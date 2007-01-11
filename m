Return-Path: <linux-kernel-owner+w=401wt.eu-S1030449AbXAKNt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030449AbXAKNt2 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 08:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030453AbXAKNtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 08:49:25 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4606 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1030449AbXAKNtS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 08:49:18 -0500
Date: Thu, 11 Jan 2007 14:49:23 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: James.Bottomley@HansenPartnership.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] Voyager: remove smp_tune_scheduling() FIXME
Message-ID: <20070111134923.GF20027@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

smp_tune_scheduling() does no longer do anything that might be required 
for Voyager.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 28 Nov 2006

--- linux-2.6.19-rc6-mm1/arch/i386/mach-voyager/voyager_smp.c.old	2006-11-27 23:51:54.000000000 +0100
+++ linux-2.6.19-rc6-mm1/arch/i386/mach-voyager/voyager_smp.c	2006-11-27 23:52:03.000000000 +0100
@@ -709,10 +709,6 @@
 	 * schedule at the moment */
 	//global_irq_holder = boot_cpu_id;
 
-	/* FIXME: Need to do something about this but currently only works
-	 * on CPUs with a tsc which none of mine have. 
-	smp_tune_scheduling();
-	 */
 	smp_store_cpu_info(boot_cpu_id);
 	printk("CPU%d: ", boot_cpu_id);
 	print_cpu_info(&cpu_data[boot_cpu_id]);

