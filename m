Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268282AbTB1XLe>; Fri, 28 Feb 2003 18:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268291AbTB1XLd>; Fri, 28 Feb 2003 18:11:33 -0500
Received: from lmail.actcom.co.il ([192.114.47.13]:17870 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S268282AbTB1XLR>; Fri, 28 Feb 2003 18:11:17 -0500
Date: Sat, 1 Mar 2003 01:11:50 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] trident 1/1 fix operator precedence bug
Message-ID: <20030228231150.GE32006@actcom.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RpqchZ26BWispMcB"
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RpqchZ26BWispMcB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Fix an operator precedence bug that caused a comparison to always
return false. Patch from John Levon <levon@movementarian.org>. Tested,
works fine.=20

--- a/sound/oss/trident.c	Sat Mar  1 01:14:13 2003
+++ b/sound/oss/trident.c	Sat Mar  1 01:14:13 2003
@@ -3059,7 +3059,7 @@
         ncount =3D 10;
 	while(1) {
 		wcontrol =3D inw(TRID_REG(card, ALI_AC97_WRITE));
-		if(!wcontrol & 0x8000)
+		if(!(wcontrol & 0x8000))
 			break;
 		if(ncount <=3D 0)
 			break;

--=20
Muli Ben-Yehuda
http://www.mulix.org


--RpqchZ26BWispMcB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+X+y2KRs727/VN8sRAqRQAJ4zIOhS/wYXIJIuVHthzogyqIUVUQCfQljk
wh9eP6+NveIDH3aaq/bpHMA=
=UGe8
-----END PGP SIGNATURE-----

--RpqchZ26BWispMcB--
