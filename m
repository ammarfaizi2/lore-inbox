Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261385AbSJMAOS>; Sat, 12 Oct 2002 20:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261387AbSJMAOR>; Sat, 12 Oct 2002 20:14:17 -0400
Received: from modemcable061.219-201-24.mtl.mc.videotron.ca ([24.201.219.61]:43158
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261385AbSJMANy>; Sat, 12 Oct 2002 20:13:54 -0400
Date: Sat, 12 Oct 2002 19:59:37 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: felix.seeger@gmx.de
Subject: [PATCH][2.5] fix timer_tsc/cpufreq compilation
Message-ID: <Pine.LNX.4.44.0210121902370.10081-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: linux-2.5.42/arch/i386/kernel/timers/timer_tsc.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.42/arch/i386/kernel/timers/timer_tsc.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 timer_tsc.c
--- linux-2.5.42/arch/i386/kernel/timers/timer_tsc.c	12 Oct 2002 16:55:27 -0000	1.1.1.1
+++ linux-2.5.42/arch/i386/kernel/timers/timer_tsc.c	12 Oct 2002 23:00:10 -0000
@@ -166,6 +166,7 @@
 
 
 #ifdef CONFIG_CPU_FREQ
+#include <linux/cpufreq.h>
 
 static int
 time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,

-- 
function.linuxpower.ca



