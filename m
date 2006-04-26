Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbWDZNjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbWDZNjR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 09:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbWDZNjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 09:39:17 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:46642
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932437AbWDZNjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 09:39:16 -0400
Message-Id: <444F9452.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Wed, 26 Apr 2006 15:40:02 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: <cpufreq@lists.linux.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] dprintk adjustments to cpufreq-nforce2
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove KERN_* suffixes from some NForce2 cpufreq driver's dprintk-s.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru /home/jbeulich/tmp/linux-2.6.17-rc2/arch/i386/kernel/cpu/cpufreq/cpufreq-nforce2.c
2.6.17-rc2-i386-cpufreq-nforce2-dprintk/arch/i386/kernel/cpu/cpufreq/cpufreq-nforce2.c
--- /home/jbeulich/tmp/linux-2.6.17-rc2/arch/i386/kernel/cpu/cpufreq/cpufreq-nforce2.c	2006-04-26 10:55:10.000000000
+0200
+++ 2.6.17-rc2-i386-cpufreq-nforce2-dprintk/arch/i386/kernel/cpu/cpufreq/cpufreq-nforce2.c	2006-04-24
12:28:36.000000000 +0200
@@ -266,7 +266,7 @@ static int nforce2_target(struct cpufreq
 	if (freqs.old == freqs.new)
 		return 0;
 
-	dprintk(KERN_INFO "cpufreq: Old CPU frequency %d kHz, new %d kHz\n",
+	dprintk("Old CPU frequency %d kHz, new %d kHz\n",
 	       freqs.old, freqs.new);
 
 	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
@@ -278,7 +278,7 @@ static int nforce2_target(struct cpufreq
 		printk(KERN_ERR "cpufreq: Changing FSB to %d failed\n",
                        target_fsb);
 	else
-		dprintk(KERN_INFO "cpufreq: Changed FSB successfully to %d\n",
+		dprintk("Changed FSB successfully to %d\n",
                        target_fsb);
 
 	/* Enable IRQs */


