Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269143AbUIRHPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269143AbUIRHPq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 03:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269142AbUIRHPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 03:15:46 -0400
Received: from smtp807.mail.sc5.yahoo.com ([66.163.168.186]:28346 "HELO
	smtp807.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269143AbUIRHO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 03:14:56 -0400
Date: Sat, 18 Sep 2004 00:14:55 -0700
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: marcelo.tosatti@cyclades.com
Subject: [PATCH 2.4] radeonfb: Fix module unload and red/blue typo 
Message-ID: <20040918071455.GA4807@darjeeling.triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	marcelo.tosatti@cyclades.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
User-Agent: Mutt/1.5.6+20040818i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

This patch fixes a blue -> red typo in radeonfb. For free, there's also
a one line hunk that sets the correct owner for the framebuffer. Herbert
Xu originally wrote this patch.

Marcelo, please apply.

Signed-off-by: Joshua Kwan <joshk@triplehelix.org>

--=20
Joshua Kwan

# origin: Debian (herbert)
# cset: n/a
# inclusion: not submitted
# description: set owner for radeonfb module, fix red/blue typo
# revision date: 2004-09-04

diff -urN kernel-source-2.4.26/drivers/video/radeonfb.c kernel-source-2.4.2=
6-1/drivers/video/radeonfb.c
--- kernel-source-2.4.26/drivers/video/radeonfb.c	2004-04-14 23:05:39.00000=
0000 +1000
+++ kernel-source-2.4.26-1/drivers/video/radeonfb.c	2004-04-17 14:24:02.000=
000000 +1000
@@ -935,6 +935,7 @@
 #endif /* CONFIG_PMAC_BACKLIGHT */
=20
 static struct fb_ops radeon_fb_ops =3D {
+	owner:			THIS_MODULE,
 	fb_get_fix:		radeonfb_get_fix,
 	fb_get_var:		radeonfb_get_var,
 	fb_set_var:		radeonfb_set_var,
@@ -2368,7 +2369,7 @@
 			disp->visual =3D FB_VISUAL_DIRECTCOLOR;
 			v.red.offset =3D 10;
 			v.green.offset =3D 5;
-			v.red.offset =3D 0;
+			v.blue.offset =3D 0;
 			v.red.length =3D v.green.length =3D v.blue.length =3D 5;
 			v.transp.offset =3D v.transp.length =3D 0;
 			break;



--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQUvgbqOILr94RG8mAQLmoBAA5rjG+6PDN+PYmYKzXV1t5k9UQgJqJUHE
t0IUKz0sTRXUnvVkBVkYqVo+IIiZ3lP3GOaniQfBgpwcQyL9JT4CcJcQiu3Hcyoj
LehUkNSKSrDMFoUj0hHwY06CCE+H5HzSBrRSIITRCF5hL0cTtPZMpW+67e+UBOVk
liR8CrtKHo6yT30DER3oPji4ljklndSyvpKYWQx+FqvrtJWRX/r7rTkg7I/PPwnD
dEY7nlo8aFCOShu8GDEDK+yW2vuUfb6s1lPOAm+a0ItWrS/Oojpuqa8JGCmtgr77
tSUm42Zm6hO3xejSfCAiJ3uCyVkz1EU7VCiz6rNBB/3o6Qxu4t3AScjIkduACZs+
xquONrGDFiepBzG/mWejxe1+Ojc+m9/JxGqLJVZ70cU48Ju98RW4vmJWZaE6x4Dl
RDJIdLQKuRvh+oQxC18m5OeNZDYkangIzmb5lKfu8tjhBegwKcnfVAAIoERxUpqE
ZCZtv6k7uwNpsqSJYITtIhhTrfQigk7D0Vqzm/Aqi1lfOw5zCestRjOkNgdzE4Ev
dlj+whqZ9e7ovvCOF51gdwwVZcDy++O0XBY4gAyqLeojLOziCoPSH5zS3zhef0m3
6UHcIdjyji96U56MLAQZ4bguOEoqgJavosun2ga7wkvW3BCUrHt/XBILX2q0fmB4
ppGXAx0jF80=
=JxUB
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
