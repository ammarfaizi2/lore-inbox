Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264938AbTBOTLI>; Sat, 15 Feb 2003 14:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264915AbTBOTLI>; Sat, 15 Feb 2003 14:11:08 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:51728 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264962AbTBOTKm>; Sat, 15 Feb 2003 14:10:42 -0500
Subject: PATCH: make the io-apic printk generate less junk mail
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Date: Sat, 15 Feb 2003 19:20:55 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18k7rr-0007Hz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also suggest bugzilal.kernel.org now not the mailing list

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/arch/i386/kernel/io_apic.c linux-2.5.61-ac1/arch/i386/kernel/io_apic.c
--- linux-2.5.61/arch/i386/kernel/io_apic.c	2003-02-15 03:39:28.000000000 +0000
+++ linux-2.5.61-ac1/arch/i386/kernel/io_apic.c	2003-02-14 22:43:45.000000000 +0000
@@ -1133,8 +1154,9 @@
 
 void __init UNEXPECTED_IO_APIC(void)
 {
-	printk(KERN_WARNING " WARNING: unexpected IO-APIC, please mail\n");
-	printk(KERN_WARNING "          to linux-smp@vger.kernel.org\n");
+	printk(KERN_WARNING "INFO: unexpected IO-APIC, please file a report at\n");
+	printk(KERN_WARNING "      http://bugzilla.kernel.org\n");
+	printk(KERN_WARNING "      if your kernel is less than 3 months old.\n");
 }
 
 void __init print_IO_APIC(void)
