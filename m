Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265971AbUJRUaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265971AbUJRUaI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 16:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267285AbUJRSnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 14:43:08 -0400
Received: from vsmtp12.tin.it ([212.216.176.206]:23753 "EHLO vsmtp12.tin.it")
	by vger.kernel.org with ESMTP id S267424AbUJRSld (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 14:41:33 -0400
Subject: [PATCH] Replace Dprintk with pr_debug from kernel.h - boot.c
From: Daniele Pizzoni <auouo@tin.it>
To: Len Brown <len.brown@intel.com>
Cc: kernel-janitors <kernel-janitors@lists.osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1098128556.3024.58.camel@pdp11.tsho.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 18 Oct 2004 21:43:04 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced Dprintk with pr_debug from kernel.h
Compile tested

Signed-off-by: Daniele Pizzoni <auouo@tin.it>

Index: linux-2.6.9-rc4/arch/i386/kernel/acpi/boot.c
===================================================================
--- linux-2.6.9-rc4.orig/arch/i386/kernel/acpi/boot.c	2004-10-18 19:41:13.000000000 +0200
+++ linux-2.6.9-rc4/arch/i386/kernel/acpi/boot.c	2004-10-18 21:20:18.712354096 +0200
@@ -23,6 +23,8 @@
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
+//#define DEBUG // pr_debug
+#include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/config.h>
 #include <linux/acpi.h>
@@ -461,7 +463,7 @@ unsigned int acpi_register_gsi(u32 gsi, 
 
 		if (edge_level == ACPI_LEVEL_SENSITIVE) {
 			if ((gsi < 16) && !((1 << gsi) & irq_mask)) {
-				Dprintk(KERN_DEBUG PREFIX "Setting GSI %u as level-triggered\n", gsi);
+				pr_debug(PREFIX "Setting GSI %u as level-triggered\n", gsi);
 				irq_mask |= (1 << gsi);
 				eisa_set_level_irq(gsi);
 			}


