Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262610AbULPBFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbULPBFn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 20:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262616AbULPBDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 20:03:01 -0500
Received: from mail.dif.dk ([193.138.115.101]:48548 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262569AbULPA1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 19:27:48 -0500
Date: Thu, 16 Dec 2004 01:38:17 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linux Kernel Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [PATCH 24/30] return statement cleanup - kill pointless parentheses
 in arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
Message-ID: <Pine.LNX.4.61.0412160137320.3864@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes pointless parentheses from return statements in 
arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.10-rc3-bk8-orig/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	2004-12-06 22:24:16.000000000 +0100
+++ linux-2.6.10-rc3-bk8/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	2004-12-15 23:55:42.000000000 +0100
@@ -450,7 +450,7 @@ static int centrino_cpu_init_acpi(struct
  err_unreg:
 	acpi_processor_unregister_performance(&p, policy->cpu);
 	printk(KERN_INFO PFX "invalid ACPI data\n");
-	return (result);
+	return result;
 }
 #else
 static inline int centrino_cpu_init_acpi(struct cpufreq_policy *policy) { return -ENODEV; }
@@ -518,7 +518,7 @@ static int centrino_cpu_init(struct cpuf
 
 	ret = cpufreq_frequency_table_cpuinfo(policy, centrino_model->op_points);
 	if (ret)
-		return (ret);
+		return ret;
 
 	cpufreq_frequency_table_get_attr(centrino_model->op_points, policy->cpu);
 
@@ -587,7 +587,7 @@ static int centrino_target (struct cpufr
 	set_cpus_allowed(current, policy->cpus);
 	if (smp_processor_id() != policy->cpu) {
 		dprintk("couldn't limit to CPUs in this domain\n");
-		return(-EAGAIN);
+		return -EAGAIN;
 	}
 
 	if (cpufreq_frequency_table_target(policy, centrino_model->op_points, target_freq,
@@ -627,7 +627,7 @@ static int centrino_target (struct cpufr
 	retval = 0;
 migrate_end:
 	set_cpus_allowed(current, saved_mask);
-	return (retval);
+	return retval;
 }
 
 static struct freq_attr* centrino_attr[] = {



