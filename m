Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267195AbUH3HuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267195AbUH3HuJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 03:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267285AbUH3HuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 03:50:08 -0400
Received: from vsmtp12.tin.it ([212.216.176.206]:41903 "EHLO vsmtp12.tin.it")
	by vger.kernel.org with ESMTP id S267195AbUH3Ht5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 03:49:57 -0400
Date: Mon, 30 Aug 2004 10:10:18 +0200
From: Luca Risolia <luca.risolia@studio.unibo.it>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.9-rc1-mm1] Disable colour conversion in the CPiA Video Camera driver
Message-ID: <20040830081018.GA3206@studio.unibo.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Given that colour conversion is not allowed in kernel space, this patch
disables it in the CPiA driver. The routines implementing the conversions
can be removed at all by the maintainers of the driver; however, this
patch is a good starting point and makes someone happy.

I have already submitted this patch to both the V4L mailing list
and the V4L maintainer two months ago, but it has been ignored for
some unknown reasons, so here it is again.

Please apply.

Signed-off-by: Luca Risolia <luca.risolia@studio.unibo.it>

--- devel-2.6.8/drivers/media/video/cpia.c.orig	2004-08-29 11:28:14.0000000=
00 +0200
+++ devel-2.6.8/drivers/media/video/cpia.c	2004-08-29 11:29:55.000000000 +0=
200
@@ -1428,14 +1428,8 @@ static void __exit proc_cpia_destroy(voi
 /* supported frame palettes and depths */
 static inline int valid_mode(u16 palette, u16 depth)
 {
-	return (palette =3D=3D VIDEO_PALETTE_GREY && depth =3D=3D 8) ||
-	       (palette =3D=3D VIDEO_PALETTE_RGB555 && depth =3D=3D 16) ||
-	       (palette =3D=3D VIDEO_PALETTE_RGB565 && depth =3D=3D 16) ||
-	       (palette =3D=3D VIDEO_PALETTE_RGB24 && depth =3D=3D 24) ||
-	       (palette =3D=3D VIDEO_PALETTE_RGB32 && depth =3D=3D 32) ||
-	       (palette =3D=3D VIDEO_PALETTE_YUV422 && depth =3D=3D 16) ||
-	       (palette =3D=3D VIDEO_PALETTE_YUYV && depth =3D=3D 16) ||
-	       (palette =3D=3D VIDEO_PALETTE_UYVY && depth =3D=3D 16);
+	return (palette =3D=3D VIDEO_PALETTE_YUV422 && depth =3D=3D 16) ||
+	       (palette =3D=3D VIDEO_PALETTE_YUYV && depth =3D=3D 16);
 }
=20
 static int match_videosize( int width, int height )

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBMuDqmdpdKvzmNaQRAl5GAJwP8YcbeAJi9brw22L5n8dxFeUeaACg2hj5
tr+zLXtWseVVuJ0fzOUyLHs=
=gvC/
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
