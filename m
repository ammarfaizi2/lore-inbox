Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269120AbTCBGro>; Sun, 2 Mar 2003 01:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269124AbTCBGro>; Sun, 2 Mar 2003 01:47:44 -0500
Received: from adsl-67-121-154-32.dsl.pltn13.pacbell.net ([67.121.154.32]:4064
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id <S269120AbTCBGrn>; Sun, 2 Mar 2003 01:47:43 -0500
Date: Sat, 1 Mar 2003 22:57:13 -0800
To: mk <mk@www0.org>
Cc: jsimmons@infradead.org,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Problematic Radeon fb on 2.5.63
Message-ID: <20030302065713.GA27809@triplehelix.org>
References: <20030301160909.GA1604@www0.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Content-Disposition: inline
In-Reply-To: <20030301160909.GA1604@www0.org>
User-Agent: Mutt/1.5.3i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pvezYHf7grwyp3Bc
Content-Type: multipart/mixed; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 01, 2003 at 04:09:09PM +0000, mk wrote:
> This is Radeon 7500 QW on a VT8363/8365 [KT133/KM133 AGP]

Cool.. I've got a:
	radeonfb: ATI Radeon M6 LY DDR SGRAM 32 MB=20

> Cursor does not appear on console, fbset changes are most likely
> to cause screen corruption or just black screen and what must effect all
> fb graphics support, choosing an fbdriver and not fb console support, is
> an accepted option (at least on menuconfig) having as a result blank
> screen on boot.

Should an fbdriver depend on CONFIG_FRAMEBUFFER_CONSOLE then? It seems=20
wrong to me.

I have attached the fix for the cursor not appearing problem. James=20
already has it in his own tree, why isn't it getting pushed to=20
mainstream?

Regards
Josh

--=20
New PGP public key: 0x27AFC3EE

--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="radeonfb.diff"
Content-Transfer-Encoding: quoted-printable

--- linux/drivers/video/radeonfb.c-2.5.62	2003-01-03 01:31:42.000000000 +01=
00
+++ linux/drivers/video/radeonfb.c	2003-02-18 12:13:07.000000000 +0100
@@ -2212,6 +2212,7 @@
 	.fb_copyarea	=3D cfb_copyarea,
 	.fb_imageblit	=3D cfb_imageblit,
 #endif
+	.fb_cursor	=3D soft_cursor,
 };
=20
=20

--UugvWAfsgieZRqgk--

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+YatJT2bz5yevw+4RAtFZAKCqqC0Jw6zI8+ww8qPpffsNToz8tACgz6Jz
VVA9QK+d5evrGVWyKpG8wY8=
=tUtQ
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--
