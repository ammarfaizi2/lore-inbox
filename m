Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270621AbTGZWaS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 18:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270623AbTGZWaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 18:30:17 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:61608 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S270621AbTGZWaN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 18:30:13 -0400
Date: Sun, 27 Jul 2003 00:45:16 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: [PM] Missed parts from ACPI_SLEEP / SOFTWARE_SUSPEND split
Message-ID: <20030726224516.GA492@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This was missed...
							Pavel

Index: linux/kernel/Makefile
===================================================================
--- linux.orig/kernel/Makefile	2003-07-22 13:39:43.000000000 +0200
+++ linux/kernel/Makefile	2003-07-17 22:22:58.000000000 +0200
@@ -17,7 +17,7 @@
 obj-$(CONFIG_PM) += pm.o
 obj-$(CONFIG_CPU_FREQ) += cpufreq.o
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
-obj-$(CONFIG_SOFTWARE_SUSPEND) += suspend.o
+obj-$(CONFIG_PM) += suspend.o
 obj-$(CONFIG_COMPAT) += compat.o
 
 ifneq ($(CONFIG_IA64),y)
Index: linux/kernel/suspend.c
===================================================================
--- linux.orig/kernel/suspend.c	2003-07-22 13:39:43.000000000 +0200
+++ linux/kernel/suspend.c	2003-07-22 13:46:26.000000000 +0200
@@ -1279,4 +1271,5 @@
 
 EXPORT_SYMBOL(software_suspend);
 EXPORT_SYMBOL(software_suspend_enabled);
+#endif
 EXPORT_SYMBOL(refrigerator);

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
