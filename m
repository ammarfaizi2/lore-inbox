Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266425AbSL1XIE>; Sat, 28 Dec 2002 18:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266443AbSL1XIB>; Sat, 28 Dec 2002 18:08:01 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:33781 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S266425AbSL1XHW>; Sat, 28 Dec 2002 18:07:22 -0500
Date: Sun, 29 Dec 2002 00:15:29 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: [PATCH 2.5.53][TRIVIAL] cpufreq: remove usage of #typedef
Message-ID: <20021228231529.GD1310@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruN linux-original/include/linux/cpufreq.h linux/include/linux/cpufreq.h
--- linux-original/include/linux/cpufreq.h	2002-12-25 17:45:52.000000000 +0100
+++ linux/include/linux/cpufreq.h	2002-12-27 10:56:55.000000000 +0100
@@ -107,12 +107,10 @@
  *                      CPUFREQ DRIVER INTERFACE                     *
  *********************************************************************/
 
-typedef int (*cpufreq_policy_t)          (struct cpufreq_policy *policy);
-
 struct cpufreq_driver {
 	/* needed by all drivers */
-	cpufreq_policy_t        verify;
-	cpufreq_policy_t        setpolicy;
+	int     (*verify)       (struct cpufreq_policy *policy);
+	int     (*setpolicy)    (struct cpufreq_policy *policy);
 	struct cpufreq_policy   *policy;
 	/* 2.4. compatible API */
 #ifdef CONFIG_CPU_FREQ_24_API
