Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267548AbTBKKxP>; Tue, 11 Feb 2003 05:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267560AbTBKKxC>; Tue, 11 Feb 2003 05:53:02 -0500
Received: from [195.39.17.254] ([195.39.17.254]:11524 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267548AbTBKKv5>;
	Tue, 11 Feb 2003 05:51:57 -0500
Date: Mon, 10 Feb 2003 17:37:26 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: Kill SHOUTING in kernel/io_apic.c
Message-ID: <20030210163726.GA1115@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

That source is shouting WAY TOO MUCH. Please apply,
								Pavel

--- clean/arch/i386/kernel/io_apic.c	2003-01-17 23:13:33.000000000 +0100
+++ linux-swsusp/arch/i386/kernel/io_apic.c	2003-01-19 19:46:51.000000000 +0100
@@ -824,7 +824,7 @@
 	enable_8259A_irq(0);
 }
 
-void __init UNEXPECTED_IO_APIC(void)
+void __init unexpected_IO_APIC(void)
 {
 	printk(KERN_WARNING " WARNING: unexpected IO-APIC, please mail\n");
 	printk(KERN_WARNING "          to linux-smp@vger.kernel.org\n");
@@ -865,7 +865,7 @@
 	printk(KERN_DEBUG ".......    : Delivery Type: %X\n", reg_00.delivery_type);
 	printk(KERN_DEBUG ".......    : LTS          : %X\n", reg_00.LTS);
 	if (reg_00.__reserved_0 || reg_00.__reserved_1 || reg_00.__reserved_2)
-		UNEXPECTED_IO_APIC();
+		unexpected_IO_APIC();
 
 	printk(KERN_DEBUG ".... register #01: %08X\n", *(int *)&reg_01);
 	printk(KERN_DEBUG ".......     : max redirection entries: %04X\n", reg_01.entries);
@@ -877,7 +877,7 @@
 		(reg_01.entries != 0x2E) &&
 		(reg_01.entries != 0x3F)
 	)
-		UNEXPECTED_IO_APIC();
+		unexpected_IO_APIC();
 
 	printk(KERN_DEBUG ".......     : PRQ implemented: %X\n", reg_01.PRQ);
 	printk(KERN_DEBUG ".......     : IO APIC version: %04X\n", reg_01.version);
@@ -887,15 +887,15 @@
 		(reg_01.version != 0x13) && /* Xeon IO-APICs */
 		(reg_01.version != 0x20)    /* Intel P64H (82806 AA) */
 	)
-		UNEXPECTED_IO_APIC();
+		unexpected_IO_APIC();
 	if (reg_01.__reserved_1 || reg_01.__reserved_2)
-		UNEXPECTED_IO_APIC();
+		unexpected_IO_APIC();
 
 	if (reg_01.version >= 0x10) {
 		printk(KERN_DEBUG ".... register #02: %08X\n", *(int *)&reg_02);
 		printk(KERN_DEBUG ".......     : arbitration: %02X\n", reg_02.arbitration);
 		if (reg_02.__reserved_1 || reg_02.__reserved_2)
-			UNEXPECTED_IO_APIC();
+			unexpected_IO_APIC();
 	}
 
 	printk(KERN_DEBUG ".... IRQ redirection table:\n");

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
