Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266591AbUG0TGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266591AbUG0TGk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 15:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266572AbUG0TDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 15:03:51 -0400
Received: from smtp.golden.net ([199.166.210.31]:35850 "EHLO smtp.golden.net")
	by vger.kernel.org with ESMTP id S266607AbUG0TCd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 15:02:33 -0400
Date: Tue, 27 Jul 2004 15:02:11 -0400
From: Paul Mundt <lethal@linux-sh.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] Kconfig.debug: combine Kconfig debug options
Message-ID: <20040727190210.GE20740@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	"Randy.Dunlap" <rddunlap@osdl.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20040723231158.068d4685.rddunlap@osdl.org> <Pine.GSO.4.58.0407271451130.19529@waterleaf.sonytel.be> <20040727104737.0de2da5b.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Content-Disposition: inline
In-Reply-To: <20040727104737.0de2da5b.rddunlap@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 27, 2004 at 10:47:37AM -0700, Randy.Dunlap wrote:
> DEBUG_SLAB is not available in cris, h8300, m68knommu, sh, sh64,
> or v850 AFAICT.  Yes/no ?
>=20
This can be set for sh/sh64 just fine, it is pretty much generic anyways.
So placing this in a common Kconfig seems reasonable.

> | (didn't check the whole list) Perhaps the first instance of DEBUG_INFO
> | can depend on !SUPERH64 && !USERMODE only?
>=20
> It could.  It depends on one's config (or code/patch) philosophy.
> I was trying to be explicit about which arches support a config option
> by including each arch in a list ("inclusion").  Or I could exclude
> certain arches from config options ("exclusion").  The inclusion
> method seems safer and more readable/maintainable to me, but that's
> just one opinion.
>=20
There's no need for the !SUPERH64 dependancy for DEBUG_INFO either, so
feel free to drop that if that's the way you end up going.


--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBBqay1K+teJFxZ9wRAvHAAJsHtDmUpNJ08OR5M1ryxvaryrPGmQCeOFin
l7Qk8SfjuGEQ04Hwmv4f6lQ=
=rE3l
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--
