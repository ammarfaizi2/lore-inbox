Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312563AbSDFQmx>; Sat, 6 Apr 2002 11:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312576AbSDFQmx>; Sat, 6 Apr 2002 11:42:53 -0500
Received: from pD9001B1C.dip.t-dialin.net ([217.0.27.28]:46740 "EHLO
	zeus.prom.vpn") by vger.kernel.org with ESMTP id <S312563AbSDFQmw>;
	Sat, 6 Apr 2002 11:42:52 -0500
Subject: Re: [PATCH] [CLEANUP] radeonfb accelerator id in 2.4.19
From: Ingo Albrecht <prom@berlin.ccc.de>
To: Ani Joshi <ajoshi@shell.unixbox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <1018019030.30214.264.camel@zeus>
Content-Type: multipart/mixed; boundary="=-jLNfx0Ghx8IoClAukW+2"
X-Mailer: Evolution/1.0.2 
Date: 06 Apr 2002 18:42:25 +0200
Message-Id: <1018111345.2130.300.camel@zeus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jLNfx0Ghx8IoClAukW+2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2002-04-05 at 17:03, Ingo Albrecht wrote:
> Stupid me. Forgot the patch.

And sent one that doesnt apply. Bad day for me.
Well, this one does.

Thanks to marcello for wasting his time on
trying to apply the old one ;)

Ingo

-- 
Let the people think they govern and they will be governed.
                -- William Penn, founder of Pennsylvania

--=-jLNfx0Ghx8IoClAukW+2
Content-Disposition: attachment; filename=diff-radeonfb-accel-id
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; charset=ISO-8859-1

diff -Nurb linux-2.4.19-pre6/drivers/video/radeonfb.c linux/drivers/video/r=
adeonfb.c
--- linux-2.4.19-pre6/drivers/video/radeonfb.c	Sat Apr  6 18:08:06 2002
+++ linux/drivers/video/radeonfb.c	Sat Apr  6 18:10:45 2002
@@ -1855,7 +1855,7 @@
 	if (noaccel)
 	        fix->accel =3D FB_ACCEL_NONE;
 	else
-		fix->accel =3D 40;	/* XXX */
+		fix->accel =3D FB_ACCEL_ATI_RADEON;
        =20
         return 0;
 }
diff -Nurb linux-2.4.19-pre6/include/linux/fb.h linux/include/linux/fb.h
--- linux-2.4.19-pre6/include/linux/fb.h	Sat Apr  6 18:07:16 2002
+++ linux/include/linux/fb.h	Sat Apr  6 18:17:20 2002
@@ -94,6 +94,7 @@
 #define FB_ACCEL_IGS_CYBER5000	35	/* CyberPro 5000		*/
 #define FB_ACCEL_SIS_GLAMOUR    36	/* SiS 300/630/540              */
 #define FB_ACCEL_3DLABS_PERMEDIA3 37	/* 3Dlabs Permedia 3		*/
+#define FB_ACCEL_ATI_RADEON	38	/* ATI Radeon family		*/
=20
=20
 #define FB_ACCEL_NEOMAGIC_NM2070 90	/* NeoMagic NM2070              */

--=-jLNfx0Ghx8IoClAukW+2--
