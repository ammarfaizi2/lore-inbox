Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268405AbTAMW5v>; Mon, 13 Jan 2003 17:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268409AbTAMW5u>; Mon, 13 Jan 2003 17:57:50 -0500
Received: from air-2.osdl.org ([65.172.181.6]:44260 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S268405AbTAMW5s>;
	Mon, 13 Jan 2003 17:57:48 -0500
Date: Mon, 13 Jan 2003 16:06:38 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: <linux@brodo.de>
cc: <linux-kernel@vger.kernel.org>, <torvalds@transmeta.com>
Subject: [patch] fix cpufreq compilation 
Message-ID: <Pine.LNX.4.33.0301131603490.1136-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is needed to compile kernel/cpufreq.c if the legacy procfs interface 
is not enabled in the latest BK tree. 

	-pat

===== kernel/cpufreq.c 1.13 vs edited =====
--- 1.13/kernel/cpufreq.c	Mon Jan 13 15:57:39 2003
+++ edited/kernel/cpufreq.c	Mon Jan 13 16:05:24 2003
@@ -21,6 +21,7 @@
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
 #include <linux/device.h>
+#include <linux/slab.h>
 
 #ifdef CONFIG_CPU_FREQ_PROC_INTF
 #include <linux/ctype.h>

