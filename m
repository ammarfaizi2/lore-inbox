Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312942AbSDEPEo>; Fri, 5 Apr 2002 10:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312940AbSDEPEY>; Fri, 5 Apr 2002 10:04:24 -0500
Received: from pD9001BAF.dip.t-dialin.net ([217.0.27.175]:23788 "EHLO
	zeus.prom.vpn") by vger.kernel.org with ESMTP id <S312939AbSDEPEF>;
	Fri, 5 Apr 2002 10:04:05 -0500
Subject: Re: [PATCH] [CLEANUP] radeonfb accelerator id in 2.4.19
From: Ingo Albrecht <prom@berlin.ccc.de>
To: Ani Joshi <ajoshi@shell.unixbox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux Framebuffer Development List 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <1018018270.30211.259.camel@zeus>
Content-Type: multipart/mixed; boundary="=-Sn7RRxjHhAr0CuS263Z8"
X-Mailer: Evolution/1.0.2 
Date: 05 Apr 2002 17:03:50 +0200
Message-Id: <1018019030.30214.264.camel@zeus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Sn7RRxjHhAr0CuS263Z8
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Stupid me. Forgot the patch.


On Fri, 2002-04-05 at 16:51, Ingo Albrecht wrote:
> 
> This small patch assigns an accelerator id to radeonfb.
> The reason for this should be obvious.
> 
> This is against 2.4.19-pre6, but making it apply against
> something else shouldnt be a lot of work ;)
> 
> I read LKML, but not fbdev-devel.
> 
> Ingo
> 
> -- 
> Let the people think they govern and they will be governed.
>                 -- William Penn, founder of Pennsylvania
-- 
Let the people think they govern and they will be governed.
                -- William Penn, founder of Pennsylvania

--=-Sn7RRxjHhAr0CuS263Z8
Content-Disposition: attachment; filename=diff-radeonfb-accel-id
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; charset=ISO-8859-1

diff -Nurb linux-2.4.19-pre6-orig/drivers/video/radeonfb.c linux/drivers/vi=
deo/radeonfb.c
--- linux-2.4.19-pre6-orig/drivers/video/radeonfb.c	Mon Feb 25 20:38:07 200=
2
+++ linux/drivers/video/radeonfb.c	Fri Apr  5 15:49:31 2002
@@ -1855,7 +1855,7 @@
 	if (noaccel)
 	        fix->accel =3D FB_ACCEL_NONE;
 	else
-		fix->accel =3D 40;	/* XXX */
+		fix->accel =3D FB_ACCEL_ATI_RADEON;
        =20
         return 0;
 }
diff -Nurb linux-2.4.19-pre6-orig/include/linux/fb.h linux/include/linux/fb=
.h
--- linux-2.4.19-pre6-orig/include/linux/fb.h	Mon Dec 11 22:16:53 2000
+++ linux/include/linux/fb.h	Fri Apr  5 15:48:42 2002
@@ -93,6 +93,7 @@
 #define FB_ACCEL_IGS_CYBER2010	34	/* CyberPro 2010		*/
 #define FB_ACCEL_IGS_CYBER5000	35	/* CyberPro 5000		*/
 #define FB_ACCEL_SIS_GLAMOUR    36	/* SiS 300/630/540              */
+#define FB_ACCEL_ATI_RADEON	37	/* ATI Radeon family		*/
=20
 struct fb_fix_screeninfo {
 	char id[16];			/* identification string eg "TT Builtin" */

--=-Sn7RRxjHhAr0CuS263Z8--
