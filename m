Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130548AbRACLwE>; Wed, 3 Jan 2001 06:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130996AbRACLvy>; Wed, 3 Jan 2001 06:51:54 -0500
Received: from orbita.don.sitek.net ([213.24.25.98]:15882 "EHLO
	orbita.don.sitek.net") by vger.kernel.org with ESMTP
	id <S130548AbRACLvf>; Wed, 3 Jan 2001 06:51:35 -0500
Date: Wed, 3 Jan 2001 14:30:11 +0300
From: Andrey Panin <pazke@orbita.don.sitek.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] /linux/drivers/char/serial.c: missing __devinitdata
Message-ID: <20010103143011.B32634@debian>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+xNpyl7Qekk2NvDX"
User-Agent: Mutt/1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+xNpyl7Qekk2NvDX
Content-Type: multipart/mixed; boundary="mxv5cy4qt+RJ9ypb"


--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable


Hi all,

this small and obvious patch adds some missing __devinitdata directives
to the 16x50 serial driver.

Best regards,
	    Andrey

P.S. Question: why __init and friends are nop when CONFIG_HOTPLUG is define=
d ?
IMHO only __devinit and __devinitdata should be nop, isn't it ?

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-timedia-2.4.0t13p4"
Content-Transfer-Encoding: quoted-printable

diff -u /linux/drivers/char/serial.c.orig /linux/drivers/char/serial.c
--- /linux/drivers/char/serial.c.orig	Sun Dec 31 22:49:36 2000
+++ /linux/drivers/char/serial.c	Sun Dec 31 04:05:01 2000
@@ -4133,26 +4133,26 @@
  * growing *huge*, we use this function to collapse some 70 entries
  * in the PCI table into one, for sanity's and compactness's sake.
  */
-static unsigned short timedia_single_port[] =3D {
+static unsigned short timedia_single_port[] __devinitdata =3D {
 	0x4025, 0x4027, 0x4028, 0x5025, 0x5027, 0 };
-static unsigned short timedia_dual_port[] =3D {
+static unsigned short timedia_dual_port[] __devinitdata =3D {
 	0x0002, 0x4036, 0x4037, 0x4038, 0x4078, 0x4079, 0x4085,
 	0x4088, 0x4089, 0x5037, 0x5078, 0x5079, 0x5085, 0x6079,=20
 	0x7079, 0x8079, 0x8137, 0x8138, 0x8237, 0x8238, 0x9079,=20
 	0x9137, 0x9138, 0x9237, 0x9238, 0xA079, 0xB079, 0xC079,
 	0xD079, 0 };
-static unsigned short timedia_quad_port[] =3D {
+static unsigned short timedia_quad_port[] __devinitdata =3D {
 	0x4055, 0x4056, 0x4095, 0x4096, 0x5056, 0x8156, 0x8157,=20
 	0x8256, 0x8257, 0x9056, 0x9156, 0x9157, 0x9158, 0x9159,=20
 	0x9256, 0x9257, 0xA056, 0xA157, 0xA158, 0xA159, 0xB056,
 	0xB157, 0 };
-static unsigned short timedia_eight_port[] =3D {
+static unsigned short timedia_eight_port[] __devinitdata =3D {
 	0x4065, 0x4066, 0x5065, 0x5066, 0x8166, 0x9066, 0x9166,=20
 	0x9167, 0x9168, 0xA066, 0xA167, 0xA168, 0 };
 static struct timedia_struct {
 	int num;
 	unsigned short *ids;
-} timedia_data[] =3D {
+} timedia_data[] __devinitdata =3D {
 	{ 1, timedia_single_port },
 	{ 2, timedia_dual_port },
 	{ 4, timedia_quad_port },

--mxv5cy4qt+RJ9ypb--

--+xNpyl7Qekk2NvDX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6Uw1DBm4rlNOo3YgRAgV5AJ42L62hpUUCh087wSjy32oATpSg6ACfYx20
oiKDfpNHZRxUwh7QOWlaB/o=
=vOCE
-----END PGP SIGNATURE-----

--+xNpyl7Qekk2NvDX--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
