Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbVCYBYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVCYBYI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 20:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbVCYBN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 20:13:56 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:34321 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261380AbVCYBLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 20:11:25 -0500
Date: Fri, 25 Mar 2005 02:11:23 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] mm/swap_state.c: unexport swapper_space
Message-ID: <20050325011123.GX3966@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't find any possible modular usage in the kernel.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 6 Mar 2005

--- linux-2.6.11-mm1-full/mm/swap_state.c.old	2005-03-04 16:25:54.000000000 +0100
+++ linux-2.6.11-mm1-full/mm/swap_state.c	2005-03-04 16:26:16.000000000 +0100
@@ -40,7 +40,6 @@
 	.i_mmap_nonlinear = LIST_HEAD_INIT(swapper_space.i_mmap_nonlinear),
 	.backing_dev_info = &swap_backing_dev_info,
 };
-EXPORT_SYMBOL(swapper_space);
 
 #define INC_CACHE_INFO(x)	do { swap_cache_info.x++; } while (0)
 

