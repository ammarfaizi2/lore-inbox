Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262191AbUKKI2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262191AbUKKI2T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 03:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbUKKI2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 03:28:19 -0500
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:46271 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262191AbUKKI15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 03:27:57 -0500
Date: Thu, 11 Nov 2004 00:27:55 -0800
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: Problem with current fb_get_color_depth function
Message-ID: <20041111082755.GE2815@triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org, adaplas@pol.net,
	linux-fbdev-devel@lists.sourceforge.net,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <20041010225903.GA2418@darjeeling.triplehelix.org> <200410110832.19978.adaplas@hotpop.com> <20041102055555.GJ6361@triplehelix.org> <200411030610.12231.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sHrvAb52M6C8blB9"
Content-Disposition: inline
In-Reply-To: <200411030610.12231.adaplas@hotpop.com>
User-Agent: Mutt/1.5.6+20040722i
From: joshk@triplehelix.org (Joshua Kwan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sHrvAb52M6C8blB9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 03, 2004 at 06:10:12AM +0800, Antonino A. Daplas wrote:
> After giving it a lot of thought, perhaps you are not booting at 16 bpp, =
but
> at 8bpp pseudocolor.  However, radeonfb's default var use only a red, gre=
en,
> and blue length of 6.  Try this patch and let me know if it helps.

The patch rejects against 2.6.10-rc1, but re-adapted, it works. Here is the
updated patch for radeon_monitor.c.

Thanks a lot for your help!

and in case this is final,
Signed-off-by: Joshua Kwan <joshk@triplehelix.org>

--=20
Joshua Kwan

--- a/drivers/video/aty/radeon_monitor.c	2004-11-10 23:38:18.000000000 -0800
+++ b/drivers/video/aty/radeon_monitor.c	2004-11-10 23:38:21.000000000 -0800
@@ -8,7 +8,7 @@
=20
 static struct fb_var_screeninfo radeonfb_default_var =3D {
         640, 480, 640, 480, 0, 0, 8, 0,
-        {0, 6, 0}, {0, 6, 0}, {0, 6, 0}, {0, 0, 0},
+        {0, 8, 0}, {0, 8, 0}, {0, 8, 0}, {0, 0, 0},
         0, 0, -1, -1, 0, 39721, 40, 24, 32, 11, 96, 2,
         0, FB_VMODE_NONINTERLACED
 };

--sHrvAb52M6C8blB9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQZMiiqOILr94RG8mAQIfgRAA5MjnqgQrUFnfBlgRdkhjoKEG/q2Dizvz
ZPxMnH5Sb6uiq8zXok5viUljWtF/JTFf6vwdTabNZq0Kc7pXSI2MSp7AcOKpGap8
qpXojfpdd97S8/92+WKqrGr0fEVGmLdPmQVr3SMp7uMmBn+kbiNA11AnYzMVb+WB
zazqkhKAL9YQsPphBirdh9RTKZBq5k6glMNSx0EWqOQHFnK+Vs92NfjhuGJw+A5W
NZV07qiDiOHUnnbXw+/bxjpJ4zWraz9HihmuYfWeeA7U/qQ9e+vYUSlDY4U6dh81
K3vPKqoCIsvRBEn84bgNjRkCSxxNyjXlRbGIc1fTy8d8WO7TIACgFVUuCBXLdrCP
zhpmdxmqmUJLLI/fDy2gr6d0d6rixNdeKXRZyREH4UVykXcDyQ56LXn2U0C9QIEy
93f//Wc/Xe2onSGyeNE15iAqhVge6wxcOzyxmYTbOzEZfP4JOKDj3nJ/JYu9ZtBB
3g6ofTzh6DZx0f+OGyXfGmu25RRK4kvDJnHXsVA6dQSLZoJUZO1cZ/uSzGmbHfLK
X2l5lsYrpUOWWTedhI4W1wSLD89rHK0WpqfDyWQ+P3sIofZ08Do6TD87JkScS6K4
SPMCbmLHMpdEHE8yTqrBlCiV5figwMfTo7yYY9uLfNHxhRv+JYkbz7P8z+iboxay
I9Y6Z7ITToM=
=zbCO
-----END PGP SIGNATURE-----

--sHrvAb52M6C8blB9--
