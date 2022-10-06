# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module

DESCRIPTION="A dead simple, no frills Go cross compile tool"
HOMEPAGE="https://github.com/mitchellh/gox"
SRC_URI="https://github.com/mitchellh/gox/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MPL-2.0"
SLOT="0/${PVR}"
KEYWORDS="amd64 ~arm64 ~ppc64"

RESTRICT+=" test"

src_prepare() {
	use riscv && eapply "${FILESDIR}/${PN}-1.0.1-add-riscv-support.patch"
	eapply_user
}

src_compile() {
	go mod vendor && go build -mod=vendor . || die
}

src_install() {
	dobin ${PN}
	einstalldocs
}
