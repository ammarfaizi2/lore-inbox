Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268366AbTCFUay>; Thu, 6 Mar 2003 15:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268372AbTCFUay>; Thu, 6 Mar 2003 15:30:54 -0500
Received: from B5485.pppool.de ([213.7.84.133]:38367 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S268366AbTCFUat>; Thu, 6 Mar 2003 15:30:49 -0500
Subject: Re: [patch] work around gcc-3.x inlining bugs
From: Daniel Egger <degger@fhm.edu>
To: Andrew Morton <akpm@digeo.com>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20030306032208.03f1b5e2.akpm@digeo.com>
References: <20030306032208.03f1b5e2.akpm@digeo.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-gHzP8NrGb6F9Z1/IurnA"
Organization: 
Message-Id: <1046982732.18897.34.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 06 Mar 2003 21:32:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gHzP8NrGb6F9Z1/IurnA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Don, 2003-03-06 um 12.22 schrieb Andrew Morton:

> shrinks my 3.2.1-compiled kernel text by about 64 kbytes:
>=20
>    text    data     bss     dec     hex filename
> 3316138  574844  726816 4617798  467646 vmlinux-before
> 3249255  555436  727204 4531895  4526b7 vmlinux-after
>=20
> mnm:/tmp> nm vmlinux-before|grep __constant_c_and_count_memset | wc
>     233     699    9553
> mnm:/tmp> nm vmlinux-after|grep __constant_c_and_count_memset | wc
>      13      39     533

> Can anyone see a problem with it?

Looks good to me...

   text    data     bss     dec     hex filename
1842635  167450  140292 2150377  20cfe9 vmlinux
1867787  167450  140292 2175529  213229 vmlinux.old

I hope this doesn't trigger any latent compiler bugs but in this
case we should beat the gcc people to it...

--=20
Servus,
       Daniel

--=-gHzP8NrGb6F9Z1/IurnA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+Z7BLchlzsq9KoIYRAlDAAJ9hCIONVTG8vXeFSwvdftxFRjD9DACfShw3
NxS8aXKAVi3XeEkZslL0sT0=
=B7Q+
-----END PGP SIGNATURE-----

--=-gHzP8NrGb6F9Z1/IurnA--

