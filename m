Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261833AbVAUAbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbVAUAbM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 19:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262230AbVAUAbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 19:31:12 -0500
Received: from mo00.iij4u.or.jp ([210.130.0.19]:1783 "EHLO mo00.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S261833AbVAUAbB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 19:31:01 -0500
Date: Fri, 21 Jan 2005 09:30:46 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] mips: fixed LTT build errors
Message-Id: <20050121093046.11ff2811.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch had fixed LTT build errors on MIPS.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/kernel/irq.c a/arch/mips/kernel/irq.c
--- a-orig/arch/mips/kernel/irq.c	Fri Jan 21 00:15:19 2005
+++ a/arch/mips/kernel/irq.c	Fri Jan 21 08:17:31 2005
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
+#include <linux/ltt-events.h>
 #include <linux/module.h>
 #include <linux/proc_fs.h>
 #include <linux/slab.h>
diff -urN -X dontdiff a-orig/arch/mips/kernel/traps.c a/arch/mips/kernel/traps.c
--- a-orig/arch/mips/kernel/traps.c	Fri Jan 21 00:15:19 2005
+++ a/arch/mips/kernel/traps.c	Fri Jan 21 08:17:31 2005
@@ -13,6 +13,7 @@
  */
 #include <linux/config.h>
 #include <linux/init.h>
+#include <linux/ltt-events.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/sched.h>
diff -urN -X dontdiff a-orig/arch/mips/mm/fault.c a/arch/mips/mm/fault.c
--- a-orig/arch/mips/mm/fault.c	Fri Jan 21 00:15:19 2005
+++ a/arch/mips/mm/fault.c	Fri Jan 21 08:17:31 2005
@@ -13,6 +13,7 @@
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/ptrace.h>
+#include <linux/ltt-events.h>
 #include <linux/mman.h>
 #include <linux/mm.h>
 #include <linux/smp.h>
