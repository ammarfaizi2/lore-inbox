Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266187AbUGTSsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266187AbUGTSsZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 14:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266137AbUGTSmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 14:42:32 -0400
Received: from nl-ams-slo-l4-01-pip-3.chellonetwork.com ([213.46.243.17]:58967
	"EHLO amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S266139AbUGTSiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 14:38:10 -0400
Date: Tue, 20 Jul 2004 20:38:08 +0200
Message-Id: <200407201838.i6KIc8kS015419@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 470] amifb sparse &=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amiga Frame buffer: Use `&' instead of `&=' (found by sparse, present since at
least 2.0.x)

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.8-rc2/drivers/video/amifb.c	2004-04-28 15:49:02.000000000 +0200
+++ linux-m68k-2.6.8-rc2/drivers/video/amifb.c	2004-07-10 21:07:38.000000000 +0200
@@ -1309,7 +1311,7 @@
 		info->fix.ypanstep = 0;
 	} else {
 		info->fix.ywrapstep = 0;
-		if (par->vmode &= FB_VMODE_SMOOTH_XPAN)
+		if (par->vmode & FB_VMODE_SMOOTH_XPAN)
 			info->fix.xpanstep = 1;
 		else
 			info->fix.xpanstep = 16<<maxfmode;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
