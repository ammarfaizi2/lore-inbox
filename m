Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318738AbSHAMOn>; Thu, 1 Aug 2002 08:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318719AbSHAMFT>; Thu, 1 Aug 2002 08:05:19 -0400
Received: from [195.39.17.254] ([195.39.17.254]:15744 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S318724AbSHAMFK>;
	Thu, 1 Aug 2002 08:05:10 -0400
Date: Thu, 1 Aug 2002 12:42:04 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Grover <andrew.grover@intel.com>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Make CONFIG_ACPI_BOOT work again
Message-ID: <20020801104204.GA146@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This patch makes CONFIG_ACPI_BOOT functional again. Please apply,

								Pavel

--- clean/arch/i386/kernel/acpi.c	Mon Jun  3 11:43:27 2002
+++ linux-swsusp/arch/i386/kernel/acpi.c	Mon Jun 10 23:03:24 2002
@@ -53,11 +53,9 @@
                               Boot-time Configuration
    -------------------------------------------------------------------------- */
 
-#ifdef CONFIG_ACPI_BOOT
-
 enum acpi_irq_model_id		acpi_irq_model;
 
-
+#ifdef CONFIG_ACPI_BOOT
 /*
  * Use reserved fixmap pages for physical-to-virtual mappings of ACPI tables.
  * Note that the same range is used for each table, so tables that need to
--- clean/include/linux/acpi.h	Mon Jun  3 11:43:38 2002
+++ linux-swsusp/include/linux/acpi.h	Mon Jun 10 23:03:25 2002
@@ -39,7 +39,7 @@
 #include <asm/acpi.h>
 
 
-#ifdef CONFIG_ACPI_BOOT
+#ifdef CONFIG_ACPI
 
 enum acpi_irq_model_id {
 	ACPI_IRQ_MODEL_PIC = 0,

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
