Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265942AbTGCKco (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 06:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265953AbTGCKco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 06:32:44 -0400
Received: from M973P026.adsl.highway.telekom.at ([62.47.153.154]:42112 "EHLO
	stallburg.dyndns.org") by vger.kernel.org with ESMTP
	id S265942AbTGCKcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 06:32:36 -0400
Date: Thu, 3 Jul 2003 12:47:00 +0200
From: maximilian attems <maks@sternwelten.at>
To: linux-kernel@vger.kernel.org
Cc: Thomas Winischhofer <thomas@winischhofer.net>
Subject: [2.5 patch] move an unused variable in sis_main.c
Message-ID: <20030703104700.GA939@mail.sternwelten.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The patch below moves an used variable from drivers/video/sis/sis_main.c

i've tested the compilation with 2.5.74

please apply
maks


--- linux-2.5.74/drivers/video/sis/sis_main.c	Wed Jul  2 22:50:59 2003
+++ linux/drivers/video/sis/sis_main.c	Thu Jul  3 12:06:58 2003
@@ -619,11 +619,11 @@
 	double drate =3D 0, hrate =3D 0;
 	int found_mode =3D 0;
 	int old_mode;
-	unsigned char reg;
=20
 	TWDEBUG("Inside do_set_var");
 =09
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)=09
+	unsigned char reg;
 	inSISIDXREG(SISCR,0x34,reg);
 	if(reg & 0x80) {
 	   printk(KERN_INFO "sisfb: Cannot change display mode, X server is activ=
e\n");


---
When your medical records are indexed in Google, something's wrong!
aaron kaplan


--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/BAmk6//kSTNjoX0RAq3qAJ9bUQAcejFYmrV10U4fQKwe+tEq4gCeMcuf
DmRSp1ddcS+oPTqoK92vpQc=
=uz5Z
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
