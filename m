Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933117AbWFZXfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933117AbWFZXfn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933153AbWFZWet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:34:49 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:27039 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933110AbWFZWeM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:34:12 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 16/16] [Suspend2] Suspend,c header file.
Date: Tue, 27 Jun 2006 08:34:10 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223408.3832.85100.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223314.3832.23435.stgit@nigel.suspend2.net>
References: <20060626223314.3832.23435.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Header file for kernel/power/suspend.c.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend.h  |   19 +++++++++++++++++++
 kernel/power/suspend2.h |   31 +++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend.h b/kernel/power/suspend.h
new file mode 100644
index 0000000..0f54b5e
--- /dev/null
+++ b/kernel/power/suspend.h
@@ -0,0 +1,19 @@
+/*
+ * kernel/power/suspend.h
+ *
+ * Copyright (C) 2004-2006 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * It contains declarations used throughout swsusp.
+ *
+ */
+
+#ifndef KERNEL_POWER_SUSPEND_H
+#define KERNEL_POWER_SUSPEND_H
+
+extern suspend_pagedir_t *pagedir_nosave __nosavedata;
+extern int save_image_part1(void);
+extern int suspend_atomic_restore(void);
+
+#endif
diff --git a/kernel/power/suspend2.h b/kernel/power/suspend2.h
new file mode 100644
index 0000000..c271c6b
--- /dev/null
+++ b/kernel/power/suspend2.h
@@ -0,0 +1,31 @@
+/*
+ * kernel/power/suspend2.h
+ *
+ * Copyright (C) 2004-2006 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * It contains declarations used throughout swsusp and suspend2.
+ *
+ */
+#ifndef KERNEL_POWER_SUSPEND_CORE_H
+#define KERNEL_POWER_SUSPEND_CORE_H
+
+#include <linux/delay.h>
+#include <linux/bootmem.h>
+
+extern unsigned long suspend_orig_mem_free;
+
+#define KB(x) ((x) << (PAGE_SHIFT - 10))
+#define MB(x) ((x) >> (20 - PAGE_SHIFT))
+
+extern int suspend_start_anything(int starting_cycle);
+extern void suspend_finish_anything(int finishing_cycle);
+
+#if 1
+#define PRINTK(a...) do { } while(0)
+#else
+#define PRINTK(fmt, arg...) printk(KERN_DEBUG fmt, ##arg)
+#endif
+
+#endif

--
Nigel Cunningham		nigel at suspend2 dot net
