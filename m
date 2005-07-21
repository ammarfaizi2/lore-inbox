Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261788AbVGUOci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbVGUOci (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 10:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbVGUOci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 10:32:38 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:33030 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261788AbVGUOch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 10:32:37 -0400
Date: Thu, 21 Jul 2005 16:32:34 +0200
From: Adrian Bunk <bunk@stusta.de>
To: spyro@f2s.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] include/asm-arm26/hardirq.h: remove #define irq_enter()
Message-ID: <20050721143234.GE3160@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes a #define for irq_enter that is superfluous due to a 
similar one in include/linux/hardirq.h .

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

Note: The compilation of this patch was not tested.

--- linux-2.6.13-rc3-mm1-full/include/asm-arm26/hardirq.h.old	2005-07-21 16:27:36.000000000 +0200
+++ linux-2.6.13-rc3-mm1-full/include/asm-arm26/hardirq.h	2005-07-21 16:29:32.000000000 +0200
@@ -22,8 +22,6 @@
 # error HARDIRQ_BITS is too low!
 #endif
 
-#define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
-
 #ifndef CONFIG_SMP
 
 extern asmlinkage void __do_softirq(void);

