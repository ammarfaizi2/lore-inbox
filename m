Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265277AbTBBO0a>; Sun, 2 Feb 2003 09:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265305AbTBBO0a>; Sun, 2 Feb 2003 09:26:30 -0500
Received: from host213-121-98-76.in-addr.btopenworld.com ([213.121.98.76]:12500
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP
	id <S265277AbTBBO03>; Sun, 2 Feb 2003 09:26:29 -0500
Subject: AGP aperture is 16MB @ 0x0
From: Gianni Tedesco <gianni@ecsc.co.uk>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-usj9RIoZWyk9ChDdK/eJ"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Feb 2003 14:36:09 +0000
Message-Id: <1044196570.6032.24.camel@lemsip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-usj9RIoZWyk9ChDdK/eJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I have a problem getting agpgart/drm to work on my TiBook, I have
tracked the problem down to that suspect looking message.

agpgart: AGP aperture is 16MB @ 0x00
[drm] AGP 0.99 on Unkiwn @ 0x00000000 16MB

which results in the following messages in my XFree86 logs:

[agp] ring handle =3D 0x0000000
[agp] Could not map ring

Its an ATI Radeon 7500 Mobility M7 on an Apple UniNorth 1.5 chipset.

I think the correct aperture base is one of:

AGP special page: 0xdffff000
aper_base: b8000000 MC_FB_LOC to: bbffb800, MC_AGP_LOC to: ffffc000

--=20
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

--=-usj9RIoZWyk9ChDdK/eJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA+PSzZkbV2aYZGvn0RAhBHAJ0S7+HYoI+kFTFUnOk6dwlwCL5pUgCeJFNM
BcNluVSUPeCXYCEP/+Cfk/Y=
=NRV9
-----END PGP SIGNATURE-----

--=-usj9RIoZWyk9ChDdK/eJ--

