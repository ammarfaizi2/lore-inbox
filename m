Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268179AbUHQLJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268179AbUHQLJE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 07:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265051AbUHQLJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 07:09:04 -0400
Received: from gprs214-89.eurotel.cz ([160.218.214.89]:1920 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S268179AbUHQLHP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 07:07:15 -0400
Date: Tue, 17 Aug 2004 12:58:59 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: cpufreq deprecation
Message-ID: <20040817105859.GA1497@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Today I learned that /proc/cpufreq is going to be removed from
2.6.. I thought that 2.6 means "no interface changes" :-(. Anyway, if
we are going to warn about it, we might want to include newline...

Please apply,
								Pavel

--- clean-mm/drivers/cpufreq/cpufreq_userspace.c	2004-08-17 12:21:43.000000000 +0200
+++ linux-mm/drivers/cpufreq/cpufreq_userspace.c	2004-08-17 12:55:04.000000000 +0200
@@ -174,7 +174,7 @@
 
 	if (!warning_print) {
 		warning_print++;
-		printk(KERN_INFO "Access to /proc/sys/cpu/ is deprecated and will be removed from (new) 2.6. kernels soon after 2005-01-01");
+		printk(KERN_INFO "Access to /proc/sys/cpu/ is deprecated and will be removed from (new) 2.6. kernels soon after 2005-01-01\n");
 	}
 
 	if (write) {
@@ -214,7 +214,7 @@
 
 	if (!warning_print) {
 		warning_print++;
-		printk(KERN_INFO "Access to /proc/sys/cpu/ is deprecated and will be removed from (new) 2.6. kernels soon after 2005-01-01");
+		printk(KERN_INFO "Access to /proc/sys/cpu/ is deprecated and will be removed from (new) 2.6. kernels soon after 2005-01-01\n");
 	}
 
 	if (oldval && oldlenp) {
--- clean-mm/drivers/cpufreq/proc_intf.c	2004-08-17 12:21:43.000000000 +0200
+++ linux-mm/drivers/cpufreq/proc_intf.c	2004-08-17 12:54:53.000000000 +0200
@@ -115,7 +115,7 @@
 
 	if (!warning_print) {
 		warning_print++;
-		printk(KERN_INFO "Access to /proc/cpufreq is deprecated and will be removed from (new) 2.6. kernels soon after 2005-01-01");
+		printk(KERN_INFO "Access to /proc/cpufreq is deprecated and will be removed from (new) 2.6. kernels soon after 2005-01-01\n");
 	}
 
 	p += sprintf(p, "          minimum CPU frequency  -  maximum CPU frequency  -  policy\n");
@@ -190,7 +190,7 @@
 
 	if (!warning_print) {
 		warning_print++;
-		printk(KERN_INFO "Access to /proc/cpufreq is deprecated and will be removed from (new) 2.6. kernels soon after 2005-01-01");
+		printk(KERN_INFO "Access to /proc/cpufreq is deprecated and will be removed from (new) 2.6. kernels soon after 2005-01-01\n");
 	}
 	
 	proc_string[count] = '\0';

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
