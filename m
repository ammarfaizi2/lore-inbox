Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261820AbSJNFeE>; Mon, 14 Oct 2002 01:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261824AbSJNFeE>; Mon, 14 Oct 2002 01:34:04 -0400
Received: from leary.csoft.net ([63.111.22.80]:38350 "HELO mail63.csoft.net")
	by vger.kernel.org with SMTP id <S261820AbSJNFeE>;
	Mon, 14 Oct 2002 01:34:04 -0400
Date: 14 Oct 2002 05:45:27 -0000
Message-ID: <20021014054527.24939.qmail@mail63.csoft.net>
To: linux-kernel@vger.kernel.org
Subject: Tiny patch for CPU frequency scaling.
From: krishna_lk@2bit.com
Reply-To: krishna_lk@2bit.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CPU frequency scaling on i386 doesn\'t compile out of the box with linux-2.5.42, due to non-inclusion of cpufreq.h in timer_tsc.c
Here\'s a 1 line fix for it:

--- linux-2.5.42/arch/i386/kernel/timers/timer_tsc.c       2002-10-14 14:02:42.000000000 +0900
+++ linux/arch/i386/kernel/timers/timer_tsc.c    2002-10-14 13:35:40.000000000 +0900
@@ -4,6 +4,7 @@
  */

 #include <linux/spinlock.h>
+#include <linux/cpufreq.h>
 #include <linux/init.h>
 #include <linux/timex.h>
 #include <linux/errno.h>


-Krishna
