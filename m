Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbTGOD4i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 23:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbTGOD4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 23:56:36 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:31960 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262093AbTGOD4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 23:56:34 -0400
Date: Tue, 15 Jul 2003 00:11:32 -0400
From: Matt Reppert <repp0017@tc.umn.edu>
To: linux@brodo.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.0-test1
Message-Id: <20030715001132.3b0fd7a5.repp0017@tc.umn.edu>
In-Reply-To: <Pine.LNX.4.44.0307132055080.2096-100000@home.osdl.org>
References: <Pine.LNX.4.44.0307132055080.2096-100000@home.osdl.org>
Organization: Arashi no Kaze
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I need this to build on powerpc (plus the patch by Jasper Spaans already posted).

Matt

diff -NruX /home/arashi/kdontdiff linux-2.6.0-test1-orig/drivers/cpufreq/proc_intf.c linux-2.6.0-test1/drivers/cpufreq/proc_intf.c
--- linux-2.6.0-test1-orig/drivers/cpufreq/proc_intf.c  2003-07-13 23:30:48.000000000 -0400
+++ linux-2.6.0-test1/drivers/cpufreq/proc_intf.c       2003-07-14 23:41:49.000000000 -0400
@@ -13,7 +13,6 @@
 #include <asm/uaccess.h>


-#define CPUFREQ_ALL_CPUS               ((NR_CPUS))

 /**
  * cpufreq_parse_policy - parse a policy string
diff -NruX /home/arashi/kdontdiff linux-2.6.0-test1-orig/include/linux/notifier.h linux-2.6.0-test1/include/linux/notifier.h
--- linux-2.6.0-test1-orig/include/linux/notifier.h     2003-07-13 23:30:36.000000000 -0400
+++ linux-2.6.0-test1/include/linux/notifier.h  2003-07-14 23:41:56.000000000 -0400
@@ -65,6 +65,7 @@
 #define CPU_UP_CANCELED        0x0004 /* CPU (unsigned)v NOT coming up */
 #define CPU_OFFLINE    0x0005 /* CPU (unsigned)v offline (still scheduling) */
 #define CPU_DEAD       0x0006 /* CPU (unsigned)v dead */
+#define CPUFREQ_ALL_CPUS               ((NR_CPUS))

 #endif /* __KERNEL__ */
 #endif /* _LINUX_NOTIFIER_H */
