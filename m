Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbWDZNkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbWDZNkm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 09:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbWDZNkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 09:40:42 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:1587
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932436AbWDZNkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 09:40:41 -0400
Message-Id: <444F94A2.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Wed, 26 Apr 2006 15:41:22 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: <cpufreq@lists.linux.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] dprintk adjustments to cpufreq-speedstep-centrino
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove KERN_* suffixes from some Centrino cpufreq driver's dprintk-s.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru /home/jbeulich/tmp/linux-2.6.17-rc2/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
2.6.17-rc2-x86-cpufreq-centrino-dprintk/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
--- /home/jbeulich/tmp/linux-2.6.17-rc2/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	2006-04-26
10:55:11.000000000 +0200
+++ 2.6.17-rc2-x86-cpufreq-centrino-dprintk/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	2006-04-24
12:28:36.000000000 +0200
@@ -250,7 +250,7 @@ static int centrino_cpu_init_table(struc
 
 	if (model->cpu_id == NULL) {
 		/* No match at all */
-		dprintk(KERN_INFO PFX "no support for CPU model \"%s\": "
+		dprintk("no support for CPU model \"%s\": "
 		       "send /proc/cpuinfo to " MAINTAINER "\n",
 		       cpu->x86_model_id);
 		return -ENOENT;
@@ -258,10 +258,10 @@ static int centrino_cpu_init_table(struc
 
 	if (model->op_points == NULL) {
 		/* Matched a non-match */
-		dprintk(KERN_INFO PFX "no table support for CPU model \"%s\"\n",
+		dprintk("no table support for CPU model \"%s\"\n",
 		       cpu->x86_model_id);
 #ifndef CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI
-		dprintk(KERN_INFO PFX "try compiling with CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI enabled\n");
+		dprintk("try compiling with CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI enabled\n");
 #endif
 		return -ENOENT;
 	}
@@ -368,7 +368,7 @@ static int centrino_cpu_init_acpi(struct
 
 	/* register with ACPI core */
 	if (acpi_processor_register_performance(&p, cpu)) {
-		dprintk(KERN_INFO PFX "obtaining ACPI data failed\n");
+		dprintk("obtaining ACPI data failed\n");
 		return -EIO;
 	}
 
@@ -465,7 +465,7 @@ static int centrino_cpu_init_acpi(struct
 	kfree(centrino_model[cpu]);
  err_unreg:
 	acpi_processor_unregister_performance(&p, cpu);
-	dprintk(KERN_INFO PFX "invalid ACPI data\n");
+	dprintk("invalid ACPI data\n");
 	return (result);
 }
 #else
@@ -499,7 +499,7 @@ static int centrino_cpu_init(struct cpuf
 			centrino_cpu[policy->cpu] = &cpu_ids[i];
 
 		if (!centrino_cpu[policy->cpu]) {
-			dprintk(KERN_INFO PFX "found unsupported CPU with "
+			dprintk("found unsupported CPU with "
 			"Enhanced SpeedStep: send /proc/cpuinfo to "
 			MAINTAINER "\n");
 			return -ENODEV;


