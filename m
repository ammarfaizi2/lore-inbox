Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135836AbRDTJkI>; Fri, 20 Apr 2001 05:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135838AbRDTJj6>; Fri, 20 Apr 2001 05:39:58 -0400
Received: from aeon.tvd.be ([195.162.196.20]:56502 "EHLO aeon.tvd.be")
	by vger.kernel.org with ESMTP id <S135836AbRDTJjq>;
	Fri, 20 Apr 2001 05:39:46 -0400
Date: Fri, 20 Apr 2001 11:38:37 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3-ac10
In-Reply-To: <E14qKp1-0007yX-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.05.10104201138010.2779-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Apr 2001, Alan Cox wrote:
> 2.4.3-ac10
> o	Merge Linus 2.4.4pre4
> o	Reorder frame buffer probes			(Geert Uytterhoeven)

These got somewhat mixed. Remove the duplicates:

--- linux-2.4.3-ac10/drivers/video/fbmem.c.orig	Fri Apr 20 09:58:50 2001
+++ linux-2.4.3-ac10/drivers/video/fbmem.c	Fri Apr 20 11:33:28 2001
@@ -205,9 +205,6 @@
 #if defined(CONFIG_FB_SIS) && (defined(CONFIG_FB_SIS_300) || defined(CONFIG_FB_SIS_315))
 	{ "sisfb", sisfb_init, sisfb_setup },
 #endif
-#ifdef CONFIG_FB_E1355
-	{ "e1355fb", e1355fb_init, e1355fb_setup },
-#endif
 
 	/*
 	 * Generic drivers that are used as fallbacks
@@ -275,9 +272,6 @@
 #endif
 #ifdef CONFIG_FB_E1355
 	{ "e1355fb", e1355fb_init, e1355fb_setup },
-#endif
-#ifdef CONFIG_FB_DC
-	{ "dcfb", dcfb_init, NULL },
 #endif
 #ifdef CONFIG_FB_DC
 	{ "dcfb", dcfb_init, NULL },

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

