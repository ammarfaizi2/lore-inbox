Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265098AbTBTKDe>; Thu, 20 Feb 2003 05:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265099AbTBTKDd>; Thu, 20 Feb 2003 05:03:33 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:30992 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S265098AbTBTKDa>; Thu, 20 Feb 2003 05:03:30 -0500
Date: Thu, 20 Feb 2003 11:13:07 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: Make UNEXPECTED_IO_APIC static
Message-ID: <20030220101307.GA11889@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This makes it static... Because we can.

							Pavel

--- clean/arch/i386/kernel/io_apic.c	2003-02-18 12:24:27.000000000 +0100
+++ linux/arch/i386/kernel/io_apic.c	2003-02-18 12:24:59.000000000 +0100
@@ -1150,7 +1150,7 @@
 	enable_8259A_irq(0);
 }
 
-void __init UNEXPECTED_IO_APIC(void)
+static void __init UNEXPECTED_IO_APIC(void)
 {
 	printk(KERN_WARNING "INFO: unexpected IO-APIC, please file a report at\n");
 	printk(KERN_WARNING "      http://bugzilla.kernel.org\n");

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
