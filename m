Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263579AbTJCICv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 04:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263587AbTJCICv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 04:02:51 -0400
Received: from switch-ats62.donpac.ru ([195.161.172.146]:34055 "EHLO
	switch-ats62.donpac.ru") by vger.kernel.org with ESMTP
	id S263579AbTJCICr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 04:02:47 -0400
Date: Fri, 3 Oct 2003 12:02:45 +0400
From: pazke@donpac.ru
To: linux-kernel@vger.kernel.org
Subject: [PATCH] visws: fix 16 bit framebuffer mode
Message-ID: <20031003080245.GB12930@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5G06lTa6Jq83wMTw"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5G06lTa6Jq83wMTw
Content-Type: multipart/mixed; boundary="Bn2rw/3z4jIqBvZU"
Content-Disposition: inline


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

attached patch (from Florian Boor) allows X to work on visws=20
in 16 bit framebuffer mode.

Please apply.

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-sgivwfb

diff -urN -X /usr/share/dontdiff linux-2.6.0-test6.vanilla/drivers/video/sgivwfb.c linux-2.6.0-test6/drivers/video/sgivwfb.c
--- linux-2.6.0-test6.vanilla/drivers/video/sgivwfb.c	2003-08-09 08:36:42.000000000 +0400
+++ linux-2.6.0-test6/drivers/video/sgivwfb.c	2003-10-02 01:41:30.000000000 +0400
@@ -319,14 +319,14 @@
 		var->transp.length = 0;
 		break;
 	case 16:		/* RGBA 5551 */
-		var->red.offset = 11;
+		var->red.offset = 10;
 		var->red.length = 5;
-		var->green.offset = 6;
+		var->green.offset = 5;
 		var->green.length = 5;
-		var->blue.offset = 1;
+		var->blue.offset = 0;
 		var->blue.length = 5;
-		var->transp.offset = 0;
-		var->transp.length = 0;
+		var->transp.offset = 15;
+		var->transp.length = 1;
 		break;
 	case 32:		/* RGB 8888 */
 		var->red.offset = 0;
@@ -509,7 +509,7 @@
 		SET_DBE_FIELD(WID, TYP, outputVal, DBE_CMODE_I8);
 		break;
 	case 2:
-		SET_DBE_FIELD(WID, TYP, outputVal, DBE_CMODE_RGBA5);
+		SET_DBE_FIELD(WID, TYP, outputVal, DBE_CMODE_ARGB5);
 		break;
 	case 4:
 		SET_DBE_FIELD(WID, TYP, outputVal, DBE_CMODE_RGB8);

--Bn2rw/3z4jIqBvZU--

--5G06lTa6Jq83wMTw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/fS0lby9O0+A2ZecRAhPDAKCni04DWB3fs2RqLr+mYTDGJ1HM4gCcDOIh
fmz9MtGtI0DS9y01Q36fzFg=
=egF6
-----END PGP SIGNATURE-----

--5G06lTa6Jq83wMTw--
