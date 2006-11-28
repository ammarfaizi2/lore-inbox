Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758641AbWK1B2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758641AbWK1B2q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 20:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758644AbWK1B2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 20:28:45 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:59398 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1758641AbWK1B2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 20:28:38 -0500
Date: Tue, 28 Nov 2006 02:28:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@HansenPartnership.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] Voyager: remove smp_tune_scheduling() FIXME
Message-ID: <20061128012842.GV15364@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

smp_tune_scheduling() does no longer do anything that is required 
for Voyager.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

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

