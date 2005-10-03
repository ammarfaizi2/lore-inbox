Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932694AbVJCVpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932694AbVJCVpK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 17:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932696AbVJCVpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 17:45:09 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:11194 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932694AbVJCVpI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 17:45:08 -0400
Date: Mon, 3 Oct 2005 23:43:03 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: [zaurus] fix compilation with cpufreq disabled
Message-ID: <20051003214303.GA7187@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes compilation with CPU_FREQ disabled.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/drivers/video/sa1100fb.c b/drivers/video/sa1100fb.c
--- a/drivers/video/sa1100fb.c
+++ b/drivers/video/sa1100fb.c
@@ -592,6 +592,7 @@ sa1100fb_setcolreg(u_int regno, u_int re
 	return ret;
 }
 
+#ifdef CONFIG_CPU_FREQ
 /*
  *  sa1100fb_display_dma_period()
  *    Calculate the minimum period (in picoseconds) between two DMA
@@ -606,6 +607,7 @@ static inline unsigned int sa1100fb_disp
 	 */
 	return var->pixclock * 8 * 16 / var->bits_per_pixel;
 }
+#endif
 
 /*
  *  sa1100fb_check_var():

-- 
if you have sharp zaurus hardware you don't need... you know my address
