Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261975AbVASXZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261975AbVASXZm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 18:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbVASXZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 18:25:42 -0500
Received: from relay-am.club-internet.fr ([194.158.104.67]:63449 "EHLO
	relay-am.club-internet.fr") by vger.kernel.org with ESMTP
	id S261975AbVASXY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 18:24:28 -0500
From: Daniel Caujolle-Bert <segfault@club-internet.fr>
Reply-To: segfault@club-internet.fr
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Alps touchpad probing failure
Date: Thu, 20 Jan 2005 00:23:58 +0100
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1164041.SHlAoyZF5S";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200501200024.01963.segfault@club-internet.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1164041.SHlAoyZF5S
Content-Type: multipart/mixed;
  boundary="Boundary-01=_Owu7B7vc5caaFVE"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_Owu7B7vc5caaFVE
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

 With 2.6.11-rc1 bk6 and bk7 (didn't tried with < bk6), my alps touchpad is=
 no=20
more correctly probed, it's recognised as a standard PS/2 mouse.
 So, with this trivial two line patch, everything is working again.

Cheers.
=2D-=20
73's de Daniel "Der Schreckliche", F1RMB.

             -=3D- Daniel Caujolle-Bert -=3D- segfault@club-internet.fr -=
=3D-
                        -=3D- http://naboo.homelinux.org -=3D-

--Boundary-01=_Owu7B7vc5caaFVE
Content-Type: text/x-diff;
  charset="us-ascii";
  name="alps.c.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="alps.c.diff"

=2D-- linux-2.6.11-rc1/drivers/input/mouse/alps.c	2005-01-19 19:43:36.00000=
0000 +0100
+++ linux/drivers/input/mouse/alps.c	2005-01-19 19:34:32.000000000 +0100
@@ -194,6 +194,12 @@
 	int i;
=20
 	/*
+	 * Let's clean the stuff.
+	 */
+	if(psmouse_reset(psmouse) < 0)
+	  printk(KERN_ERR "alps reset failed\n");
+
+	/*
 	 * First try "E6 report".
 	 * ALPS should return 0x00,0x00,0x0a or 0x00,0x00,0x64
 	 */

--Boundary-01=_Owu7B7vc5caaFVE--

--nextPart1164041.SHlAoyZF5S
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBB7uwRLToa6iW5KUsRApntAJ9DJH7xuLVlfow8MFGF+pg/ze9xsQCfd/g5
r9CnIxrgxnQrZMMDPHwybUQ=
=gctr
-----END PGP SIGNATURE-----

--nextPart1164041.SHlAoyZF5S--
