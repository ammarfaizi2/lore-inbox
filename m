Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130129AbRCWHxk>; Fri, 23 Mar 2001 02:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130216AbRCWHxa>; Fri, 23 Mar 2001 02:53:30 -0500
Received: from aeon.tvd.be ([195.162.196.20]:19273 "EHLO aeon.tvd.be")
	by vger.kernel.org with ESMTP id <S130129AbRCWHxU>;
	Fri, 23 Mar 2001 02:53:20 -0500
Date: Fri, 23 Mar 2001 08:52:13 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.2-ac21
In-Reply-To: <E14g9vt-000334-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.05.10103230850500.930-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Mar 2001, Alan Cox wrote:
> 2.4.2-ac21
> o	atyfb mode updates for powermac			(Olaf Hering)

60 Hz modes should be marked 60 Hz.
Add separator comment.

--- linux-2.4.2-ac21/drivers/video/macmodes.c.orig	Fri Mar 23 08:17:54 2001
+++ linux-2.4.2-ac21/drivers/video/macmodes.c	Fri Mar 23 08:37:27 2001
@@ -96,11 +96,11 @@
 	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
     }, {
 	/* 1152x768, 60 Hz, Titanium PowerBook */
-	"mac21", 75, 1152, 768, 15386, 158, 26, 29, 3, 136, 6,
+	"mac21", 60, 1152, 768, 15386, 158, 26, 29, 3, 136, 6,
 	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
     }, {
 	/* 1600x1024, 60 Hz, Non-Interlaced (112.27 MHz dotclock) */
-	"mac22", 75, 1600, 1024, 8908, 88, 104, 1, 10, 16, 1,
+	"mac22", 60, 1600, 1024, 8908, 88, 104, 1, 10, 16, 1,
 	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
     }
 
@@ -162,6 +162,7 @@
     { VMODE_1024_768_75V, &mac_modedb[9] },
     { VMODE_1024_768_70, &mac_modedb[8] },
     { VMODE_1024_768_60, &mac_modedb[7] },
+    /* 1152x768 */
     { VMODE_1152_768_60, &mac_modedb[14] },
     /* 1152x870 */
     { VMODE_1152_870_75, &mac_modedb[11] },

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

