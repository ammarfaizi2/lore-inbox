Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266199AbTAJVdj>; Fri, 10 Jan 2003 16:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266250AbTAJVdj>; Fri, 10 Jan 2003 16:33:39 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:7131 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S266199AbTAJVdh>; Fri, 10 Jan 2003 16:33:37 -0500
Date: Fri, 10 Jan 2003 22:41:48 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk, akpm@diego.com
Subject: [PATCH 2.5.56] cpufreq: #defines update
Message-ID: <20030110214148.GA1130@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Make gcc-2.91.66 happy. Noted by Andrew Morton - thanks.

        Dominik

diff -ruN linux-original/kernel/cpufreq.c linux/kernel/cpufreq.c
--- linux-original/kernel/cpufreq.c	2003-01-10 21:56:32.000000000 +0100
+++ linux/kernel/cpufreq.c	2003-01-10 22:11:24.000000000 +0100
@@ -734,8 +734,8 @@
 }
 
 #else
-#define cpufreq_sysctl_init()
-#define cpufreq_sysctl_exit()
+#define cpufreq_sysctl_init() do {} while(0)
+#define cpufreq_sysctl_exit() do {} while(0)
 #endif /* CONFIG_SYSCTL */
 #endif /* CONFIG_CPU_FREQ_24_API */
 
@@ -946,7 +946,7 @@
 		loops_per_jiffy = cpufreq_scale(l_p_j_ref, l_p_j_ref_freq, ci->new);
 }
 #else
-#define adjust_jiffies(...)
+#define adjust_jiffies(x...) do {} while (0)
 #endif
 
 
@@ -1131,6 +1131,6 @@
 }
 EXPORT_SYMBOL_GPL(cpufreq_restore);
 #else
-#define cpufreq_restore()
+#define cpufreq_restore() do {} while (0)
 #endif /* CONFIG_PM */
 
