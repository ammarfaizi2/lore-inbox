Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262969AbVG3Of6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262969AbVG3Of6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 10:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262972AbVG3Of6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 10:35:58 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30920 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262969AbVG3Of4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 10:35:56 -0400
Date: Sat, 30 Jul 2005 16:35:51 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, rmk@arm.linux.org.uk
Subject: [patch] fix warning in sa1100fb.c
Message-ID: <20050730143551.GI1830@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix compile-time warning in sa1100fb.c

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit 00fe4ed421624db9aae1bdcc80458d831422d9f9
tree 042157c712919bdc4006b59093181c60c2013af1
parent 785338d9bb750962ce99e672177f604853a69f97
author <pavel@amd.(none)> Sat, 30 Jul 2005 16:35:06 +0200
committer <pavel@amd.(none)> Sat, 30 Jul 2005 16:35:06 +0200

 drivers/video/sa1100fb.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

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
@@ -606,6 +607,7 @@ static unsigned int sa1100fb_display_dma
 	 */
 	return var->pixclock * 8 * 16 / var->bits_per_pixel;
 }
+#endif
 
 /*
  *  sa1100fb_check_var():

-- 
if you have sharp zaurus hardware you don't need... you know my address
