Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265951AbUAVIJO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 03:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265969AbUAVIJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 03:09:13 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:57067 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S265951AbUAVIJI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 03:09:08 -0500
Date: Thu, 22 Jan 2004 21:11:55 +1300
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Subject: PATCH: Revised console patch (support for > 127 chars)
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: ncunningham@users.sourceforge.net
Message-id: <1074756797.1944.31.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: multipart/signed; boundary="=-h8wzcUHFRHfpKegNpWu4";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-h8wzcUHFRHfpKegNpWu4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi.

Here's a revised version of the console patch posted last week.

Regards,

Nigel

diff -ruN linux-2.6.1/drivers/char/vt.c software-suspend-linux-2.6.1-rev3/d=
rivers/char/vt.c
--- linux-2.6.1/drivers/char/vt.c	2004-01-13 16:22:58.000000000 +1300
+++ software-suspend-linux-2.6.1-rev3/drivers/char/vt.c	2004-01-22 17:39:08=
.000000000 +1300
@@ -2996,13 +2996,13 @@
 	return screenpos(currcons, 2 * w_offset, viewed);
 }
=20
-void getconsxy(int currcons, char *p)
+void getconsxy(int currcons, unsigned char *p)
 {
 	p[0] =3D x;
 	p[1] =3D y;
 }
=20
-void putconsxy(int currcons, char *p)
+void putconsxy(int currcons, unsigned char *p)
 {
 	gotoxy(currcons, p[0], p[1]);
 	set_cursor(currcons);
diff -ruN linux-2.6.1/include/linux/selection.h software-suspend-linux-2.6.=
1-rev3/include/linux/selection.h
--- linux-2.6.1/include/linux/selection.h	2004-01-13 16:21:06.000000000 +13=
00
+++ software-suspend-linux-2.6.1-rev3/include/linux/selection.h	2004-01-22 =
17:39:09.000000000 +1300
@@ -36,8 +36,8 @@
 extern void complement_pos(int currcons, int offset);
 extern void invert_screen(int currcons, int offset, int count, int shift);
=20
-extern void getconsxy(int currcons, char *p);
-extern void putconsxy(int currcons, char *p);
+extern void getconsxy(int currcons, unsigned char *p);
+extern void putconsxy(int currcons, unsigned char *p);
=20
 extern u16 vcs_scr_readw(int currcons, const u16 *org);
 extern void vcs_scr_writew(int currcons, u16 val, u16 *org);


--=20
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

--=-h8wzcUHFRHfpKegNpWu4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAD3y9VfpQGcyBBWkRAuqsAJ4yTbpygAwIf3fgIgH11Kxugy76VgCfQvqS
sNX/p5NYeaCuKYkpZbCWiAc=
=4eBE
-----END PGP SIGNATURE-----

--=-h8wzcUHFRHfpKegNpWu4--

