Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbVGFDF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbVGFDF5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 23:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbVGFDFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 23:05:10 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:7321 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262062AbVGFCT1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:27 -0400
Subject: [PATCH] [27/48] Suspend2 2.1.9.8 for 2.6.12: 604-utility.patch
In-Reply-To: <11206164393426@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:42 +1000
Message-Id: <1120616442869@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruNp 605-kernel_power_suspend-header.patch-old/kernel/power/suspend.h 605-kernel_power_suspend-header.patch-new/kernel/power/suspend.h
--- 605-kernel_power_suspend-header.patch-old/kernel/power/suspend.h	1970-01-01 10:00:00.000000000 +1000
+++ 605-kernel_power_suspend-header.patch-new/kernel/power/suspend.h	2005-07-05 23:48:59.000000000 +1000
@@ -0,0 +1,28 @@
+/*
+ * kernel/power/suspend.h
+ *
+ * Copyright (C) 2004-2005 Nigel Cunningham <nigel@suspend2.net>
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
+#define SUSPEND_PD_PAGES(x)     (((x)*sizeof(struct pbe))/PAGE_SIZE+1)
+   
+/* mm/page_alloc.c */
+extern void drain_local_pages(void);
+
+void save_processor_state(void);
+void restore_processor_state(void);
+struct saved_context;
+void __save_processor_state(struct saved_context *ctxt);
+void __restore_processor_state(struct saved_context *ctxt);
+
+extern suspend_pagedir_t *pagedir_nosave __nosavedata;
+
+#endif

