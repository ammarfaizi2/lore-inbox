Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbVBZNdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVBZNdm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 08:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVBZNdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 08:33:42 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:40970 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261191AbVBZNdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 08:33:40 -0500
Date: Sat, 26 Feb 2005 14:33:37 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] deprecate EXPORT_SYMBOL(do_settimeofday)
Message-ID: <20050226133337.GK3311@stusta.de>
References: <20050224233742.GR8651@stusta.de> <20050224212448.367af4be.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050224212448.367af4be.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc4-mm1-full/Documentation/feature-removal-schedule.txt.old	2005-02-26 12:24:43.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/Documentation/feature-removal-schedule.txt	2005-02-26 12:27:18.000000000 +0100
@@ -32,3 +32,10 @@
 	/sys/devices/system/cpu/cpu%n/cpufreq/.
 Who:	Dominik Brodowski <linux@brodo.de>
 
+---------------------------
+
+What:	EXPORT_SYMBOL(do_settimeofday)
+When:	26 Aug 2005
+Files:	arch/*/kernel/time.c
+Why:	not used in the kernel
+Who:	Adrian Bunk <bunk@stusta.de>
--- linux-2.6.11-rc4-mm1-full/include/linux/time.h.old	2005-02-26 12:24:03.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/include/linux/time.h	2005-02-26 12:24:31.000000000 +0100
@@ -93,7 +93,7 @@
 #define CURRENT_TIME_SEC ((struct timespec) { xtime.tv_sec, 0 })
 
 extern void do_gettimeofday(struct timeval *tv);
-extern int do_settimeofday(struct timespec *tv);
+extern int __deprecated_in_modules do_settimeofday(struct timespec *tv);
 extern int do_sys_settimeofday(struct timespec *tv, struct timezone *tz);
 extern void clock_was_set(void); // call when ever the clock is set
 extern int do_posix_clock_monotonic_gettime(struct timespec *tp);
