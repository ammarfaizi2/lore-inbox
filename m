Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264644AbSLZWFB>; Thu, 26 Dec 2002 17:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264646AbSLZWFB>; Thu, 26 Dec 2002 17:05:01 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:63891 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S264644AbSLZWFA>; Thu, 26 Dec 2002 17:05:00 -0500
Date: Thu, 26 Dec 2002 23:12:52 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: [PATCH 2.5.53] cpufreq: elanfreq compile fix
Message-ID: <20021226221252.GB1407@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

min_freq is undeclared. Minimum frequency for AMD Elan is 1000 kHz.

diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/elanfreq.c linux/arch/i386/kernel/cpu/cpufreq/elanfreq.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/elanfreq.c	2002-12-21 14:53:44.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/elanfreq.c	2002-12-21 19:18:39.000000000 +0100
@@ -307,7 +307,7 @@
 	driver->policy[0].max    = max_freq;
 	driver->policy[0].policy = CPUFREQ_POLICY_PERFORMANCE;
 	driver->policy[0].cpuinfo.max_freq = max_freq;
-	driver->policy[0].cpuinfo.min_freq = min_freq;
+	driver->policy[0].cpuinfo.min_freq = 1000;
 	driver->policy[0].cpuinfo.transition_latency = CPUFREQ_ETERNAL;
 
 	elanfreq_driver = driver;
