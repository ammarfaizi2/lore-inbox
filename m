Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318189AbSHDSsr>; Sun, 4 Aug 2002 14:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318190AbSHDSsr>; Sun, 4 Aug 2002 14:48:47 -0400
Received: from [195.39.17.254] ([195.39.17.254]:15744 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S318189AbSHDSso>;
	Sun, 4 Aug 2002 14:48:44 -0400
Date: Sun, 4 Aug 2002 20:51:04 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Grover <andrew.grover@intel.com>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Fixing ACPI compilation, fixing CONFIG_ACPI_BOOT
Message-ID: <20020804185103.GA14972@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Here are patches to fix CONFIG_ACPI_BOOT. This is 3rd or so
retransmit; I've seen no response at all. Please comment on the patch,
or it is going directly to Linus.

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
+++ linux-swsusp/include/linux/acpi.h	Sun Aug  4 18:43:05 2002
@@ -39,7 +39,7 @@
 #include <asm/acpi.h>
 
 
-#ifdef CONFIG_ACPI_BOOT
+#ifdef CONFIG_ACPI
 
 enum acpi_irq_model_id {
 	ACPI_IRQ_MODEL_PIC = 0,


-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
