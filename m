Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312408AbSC3Hmg>; Sat, 30 Mar 2002 02:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312410AbSC3Hm0>; Sat, 30 Mar 2002 02:42:26 -0500
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50]:27899 "EHLO
	avocet.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S312408AbSC3HmQ>; Sat, 30 Mar 2002 02:42:16 -0500
Date: Sat, 30 Mar 2002 02:47:42 -0500
To: eyal@eyal.emu.id.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-pre5: neofb.c compile failure
Message-ID: <20020330024742.A9076@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> neofb.c:644: `FB_ACCEL_NEOMAGIC_NM2070' undeclared (first use in this
> function)

This is a diff based on 2.5.7 for include/linux/fb.h.
Console scrolling is 40% faster with neofb on a Toshiba
Tecra 8000 compared to vesafb. :)

My lilo.conf append for 2.4.19-pre5:
append = "video:neofb:ywrap,depth:8"
I.E. replace "vesa" with "neofb"


--- fb.h.orig	Fri Mar 29 21:34:57 2002
+++ fb.h	Fri Mar 29 21:36:40 2002
@@ -95,6 +95,18 @@
 #define FB_ACCEL_SIS_GLAMOUR    36	/* SiS 300/630/540              */
 #define FB_ACCEL_3DLABS_PERMEDIA3 37	/* 3Dlabs Permedia 3		*/
 
+
+#define FB_ACCEL_NEOMAGIC_NM2070 90	/* NeoMagic NM2070              */
+#define FB_ACCEL_NEOMAGIC_NM2090 91	/* NeoMagic NM2090              */
+#define FB_ACCEL_NEOMAGIC_NM2093 92	/* NeoMagic NM2093              */
+#define FB_ACCEL_NEOMAGIC_NM2097 93	/* NeoMagic NM2097              */
+#define FB_ACCEL_NEOMAGIC_NM2160 94	/* NeoMagic NM2160              */
+#define FB_ACCEL_NEOMAGIC_NM2200 95	/* NeoMagic NM2200              */
+#define FB_ACCEL_NEOMAGIC_NM2230 96	/* NeoMagic NM2230              */
+#define FB_ACCEL_NEOMAGIC_NM2360 97	/* NeoMagic NM2360              */
+#define FB_ACCEL_NEOMAGIC_NM2380 98	/* NeoMagic NM2380              */
+
+
 struct fb_fix_screeninfo {
 	char id[16];			/* identification string eg "TT Builtin" */
 	unsigned long smem_start;	/* Start of frame buffer mem */



