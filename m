Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030306AbWHDDZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030306AbWHDDZe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 23:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030309AbWHDDZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 23:25:33 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:8905 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP
	id S1030306AbWHDDZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 23:25:32 -0400
Message-Id: <20060804032521.121579000@mvista.com>
References: <20060804032414.304636000@mvista.com>
User-Agent: quilt/0.45-1
Date: Thu, 03 Aug 2006 20:24:17 -0700
From: dwalker@mvista.com
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] -mm  clocksource: enable plist
Content-Disposition: inline; filename=clocksource_enable_plist.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a feeling this might get a little more discussion than the
other stuff, so it's in it's own patch.

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

---
 init/Kconfig |    1 -
 lib/Kconfig  |    6 ------
 lib/Makefile |    3 +--
 3 files changed, 1 insertion(+), 9 deletions(-)

Index: linux-2.6.17/init/Kconfig
===================================================================
--- linux-2.6.17.orig/init/Kconfig
+++ linux-2.6.17/init/Kconfig
@@ -407,7 +407,6 @@ config BASE_FULL
 
 config RT_MUTEXES
 	boolean
-	select PLIST
 
 config FUTEX
 	bool "Enable futex support" if EMBEDDED
Index: linux-2.6.17/lib/Kconfig
===================================================================
--- linux-2.6.17.orig/lib/Kconfig
+++ linux-2.6.17/lib/Kconfig
@@ -86,10 +86,4 @@ config TEXTSEARCH_BM
 config TEXTSEARCH_FSM
 	tristate
 
-#
-# plist support is select#ed if needed
-#
-config PLIST
-	boolean
-
 endmenu
Index: linux-2.6.17/lib/Makefile
===================================================================
--- linux-2.6.17.orig/lib/Makefile
+++ linux-2.6.17/lib/Makefile
@@ -5,7 +5,7 @@
 lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
 	 idr.o div64.o int_sqrt.o bitmap.o extable.o prio_tree.o \
-	 sha1.o
+	 sha1.o plist.o
 
 lib-$(CONFIG_SMP) += cpumask.o
 
@@ -26,7 +26,6 @@ lib-$(CONFIG_SEMAPHORE_SLEEPERS) += sema
 lib-$(CONFIG_GENERIC_FIND_NEXT_BIT) += find_next_bit.o
 lib-$(CONFIG_GENERIC_HWEIGHT) += hweight.o
 obj-$(CONFIG_LOCK_KERNEL) += kernel_lock.o
-obj-$(CONFIG_PLIST) += plist.o
 obj-$(CONFIG_DEBUG_PREEMPT) += smp_processor_id.o
 obj-$(CONFIG_DEBUG_LIST) += list.o
 

--
