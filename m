Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264920AbSLVKLi>; Sun, 22 Dec 2002 05:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264925AbSLVKLi>; Sun, 22 Dec 2002 05:11:38 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:11400 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S264920AbSLVKLh>; Sun, 22 Dec 2002 05:11:37 -0500
Date: Sun, 22 Dec 2002 11:21:05 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: [PATCH 2.5] cpufreq: deprecated usage of CPUFREQ_ALL_CPUS (x86 drivers)
Message-ID: <20021222102105.GA3222@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/elanfreq.c linux/arch/i386/kernel/cpu/cpufreq/elanfreq.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/elanfreq.c	2002-12-22 11:13:15.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/elanfreq.c	2002-12-22 11:02:26.000000000 +0100
@@ -124,7 +124,7 @@
 
 	freqs.old = elanfreq_get_cpu_frequency();
 	freqs.new = elan_multiplier[state].clock;
-	freqs.cpu = CPUFREQ_ALL_CPUS; /* elanfreq.c is UP only driver */
+	freqs.cpu = 0; /* elanfreq.c is UP only driver */
 	
 	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
 
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/longhaul.c linux/arch/i386/kernel/cpu/cpufreq/longhaul.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/longhaul.c	2002-12-21 14:53:44.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/longhaul.c	2002-12-22 11:02:40.000000000 +0100
@@ -315,7 +315,7 @@
 
 	freqs.old = longhaul_get_cpu_mult() * longhaul_get_cpu_fsb() * 100;
 	freqs.new = clock_ratio[clock_ratio_index] * newfsb * 100;
-	freqs.cpu = CPUFREQ_ALL_CPUS; /* longhaul.c is UP only driver */
+	freqs.cpu = 0; /* longhaul.c is UP only driver */
 	
 	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
 
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/powernow-k6.c linux/arch/i386/kernel/cpu/cpufreq/powernow-k6.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/powernow-k6.c	2002-12-21 14:53:44.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/powernow-k6.c	2002-12-22 11:03:24.000000000 +0100
@@ -83,7 +83,7 @@
 
 	freqs.old = busfreq * powernow_k6_get_cpu_multiplier();
 	freqs.new = busfreq * clock_ratio[best_i];
-	freqs.cpu = CPUFREQ_ALL_CPUS; /* powernow-k6.c is UP only driver */
+	freqs.cpu = 0; /* powernow-k6.c is UP only driver */
 	
 	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
 
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/speedstep.c linux/arch/i386/kernel/cpu/cpufreq/speedstep.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/speedstep.c	2002-12-21 14:53:44.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/speedstep.c	2002-12-22 11:03:39.000000000 +0100
@@ -154,7 +154,7 @@
 
 	freqs.old = (oldstate == SPEEDSTEP_HIGH) ? speedstep_high_freq : speedstep_low_freq;
 	freqs.new = (state == SPEEDSTEP_HIGH) ? speedstep_high_freq : speedstep_low_freq;
-	freqs.cpu = CPUFREQ_ALL_CPUS; /* speedstep.c is UP only driver */
+	freqs.cpu = 0; /* speedstep.c is UP only driver */
 	
 	if (notify)
 		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
