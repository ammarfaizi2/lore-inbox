Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbTJXLOQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 07:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbTJXLOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 07:14:16 -0400
Received: from mail.donpac.ru ([80.254.111.2]:49551 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S261925AbTJXLOH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 07:14:07 -0400
Date: Fri, 24 Oct 2003 15:14:02 +0400
From: Andrey Panin <pazke@donpac.ru>
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix visws framebuffer 16bpp mode support
Message-ID: <20031024111402.GC31191@pazke>
Mail-Followup-To: James Simmons <jsimmons@infradead.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SxgehGEc6vB0cZwN"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SxgehGEc6vB0cZwN
Content-Type: multipart/mixed; boundary="u5E4XgoOPWr4PD9E"
Content-Disposition: inline


--u5E4XgoOPWr4PD9E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

attached patch (2.6.0-test8) fixes visws framebuffer driver.=20
With this patch applied XFree86 can use 16bpp video mode.

Please apply.

Best regards.

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--u5E4XgoOPWr4PD9E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-sgivwfb

diff -urN -X /usr/share/dontdiff linux-2.6.0-test6.vanilla/drivers/video/sgivwfb.c linux-2.6.0-test6/drivers/video/sgivwfb.c
--- linux-2.6.0-test6.vanilla/drivers/video/sgivwfb.c	2003-08-09 08:36:42.000000000 +0400
+++ linux-2.6.0-test6/drivers/video/sgivwfb.c	2003-10-09 01:48:28.000000000 +0400
@@ -318,15 +318,15 @@
 		var->transp.offset = 0;
 		var->transp.length = 0;
 		break;
-	case 16:		/* RGBA 5551 */
-		var->red.offset = 11;
+	case 16:		/* ARGB 1555 */
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

--u5E4XgoOPWr4PD9E--

--SxgehGEc6vB0cZwN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/mQl6by9O0+A2ZecRAtG0AJ0cH9aWygJzeVgV51Z8KiLy6bNjAwCgicBy
qrNEjqU2LADjxPmy6z8J9JE=
=N+Q5
-----END PGP SIGNATURE-----

--SxgehGEc6vB0cZwN--
