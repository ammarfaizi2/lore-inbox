Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262579AbSJHBVA>; Mon, 7 Oct 2002 21:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262616AbSJHBVA>; Mon, 7 Oct 2002 21:21:00 -0400
Received: from dsl-206-47-80-119.kingston.net ([206.47.80.119]:31505 "EHLO
	linux.interlinx.bc.ca") by vger.kernel.org with ESMTP
	id <S262579AbSJHBU7>; Mon, 7 Oct 2002 21:20:59 -0400
Date: Mon, 7 Oct 2002 21:26:27 -0400
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@redhat.com>
Subject: [PATCH] drivers/net/appletalk/Config.in, kernel 2.4.19
Message-ID: <20021008012627.GB2997@pc.ilinx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: "Brian J. Murrell" <8821dc6cca218ed182e7363b244e013d@interlinx.bc.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Please find below a small patch that makes the two AppleTalk PC NICs
(LTPC and COPS) in the kernel configurable only if there is an [E]ISA
bus configured.

--- linux-2.4.19-16mdk/drivers/net/appletalk/Config.in	2002-08-02 20:39:44.=
000000000 -0400
+++ linux-2.4.19-16mdk-uml/drivers/net/appletalk/Config.in.new	2002-10-07 1=
3:19:14.000000000 -0400
@@ -6,8 +6,10 @@
 comment 'Appletalk devices'
 dep_mbool 'Appletalk interfaces support' CONFIG_DEV_APPLETALK $CONFIG_ATALK
 if [ "$CONFIG_DEV_APPLETALK" =3D "y" ]; then
-   tristate '  Apple/Farallon LocalTalk PC support' CONFIG_LTPC
-   tristate '  COPS LocalTalk PC support' CONFIG_COPS
+   if [ "$CONFIG_ISA" =3D "y" -o "$CONFIG_EISA" =3D "y" ]; then
+      tristate '  Apple/Farallon LocalTalk PC support' CONFIG_LTPC
+      tristate '  COPS LocalTalk PC support' CONFIG_COPS
+   fi
    if [ "$CONFIG_COPS" !=3D "n" ]; then
       bool '    Dayna firmware support' CONFIG_COPS_DAYNA
       bool '    Tangent firmware support' CONFIG_COPS_TANGENT

b.

--=20
Brian J. Murrell

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9ojRDl3EQlGLyuXARAkVcAKCSEKqrR27Y/rFtN1U0cmE3QFH3IACfWbd+
8keFLBPg7Nrj9uBX69JKLhI=
=P8Vo
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--
