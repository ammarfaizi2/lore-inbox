Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265704AbTGDCHX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 22:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265690AbTGDB6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 21:58:21 -0400
Received: from granite.he.net ([216.218.226.66]:26382 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S265661AbTGDByy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 21:54:54 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10572845542237@kroah.com>
Subject: Re: [PATCH] PCI and sysfs fixes for 2.5.74
In-Reply-To: <1057284554141@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 3 Jul 2003 19:09:14 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1373, 2003/07/03 16:39:18-07:00, johnstul@us.ibm.com

[PATCH] jiffies include fix
This patch fixes a bad declaration of jiffies in timer_tsc.c and
timer_cyclone.c, replacing it with the proper usage of jiffies.h.
Caught by gregkh.


 arch/i386/kernel/timers/timer_cyclone.c |    2 +-
 arch/i386/kernel/timers/timer_tsc.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/arch/i386/kernel/timers/timer_cyclone.c b/arch/i386/kernel/timers/timer_cyclone.c
--- a/arch/i386/kernel/timers/timer_cyclone.c	Thu Jul  3 18:15:57 2003
+++ b/arch/i386/kernel/timers/timer_cyclone.c	Thu Jul  3 18:15:57 2003
@@ -11,6 +11,7 @@
 #include <linux/timex.h>
 #include <linux/errno.h>
 #include <linux/string.h>
+#include <linux/jiffies.h>
 
 #include <asm/timer.h>
 #include <asm/io.h>
@@ -18,7 +19,6 @@
 #include <asm/fixmap.h>
 
 extern spinlock_t i8253_lock;
-extern unsigned long jiffies;
 extern unsigned long calibrate_tsc(void);
 
 /* Number of usecs that the last interrupt was delayed */
diff -Nru a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/timer_tsc.c
--- a/arch/i386/kernel/timers/timer_tsc.c	Thu Jul  3 18:15:57 2003
+++ b/arch/i386/kernel/timers/timer_tsc.c	Thu Jul  3 18:15:57 2003
@@ -9,6 +9,7 @@
 #include <linux/errno.h>
 #include <linux/cpufreq.h>
 #include <linux/string.h>
+#include <linux/jiffies.h>
 
 #include <asm/timer.h>
 #include <asm/io.h>
@@ -21,7 +22,6 @@
 int tsc_disable __initdata = 0;
 
 extern spinlock_t i8253_lock;
-extern unsigned long jiffies;
 
 static int use_tsc;
 /* Number of usecs that the last interrupt was delayed */

