Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262535AbVCCXC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262535AbVCCXC3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 18:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262654AbVCCXBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 18:01:04 -0500
Received: from mailfe10.swipnet.se ([212.247.155.33]:28323 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262535AbVCCV6r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 16:58:47 -0500
X-T2-Posting-ID: icQHdNe7aEavrnKIz+aKnQ==
Subject: Keyboard doesn't work with CONFIG_PNP in 2.6.11-rc5-mm1
From: Alexander Nyberg <alexn@dsv.su.se>
To: dtor_core@ameritech.net
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 03 Mar 2005 22:58:19 +0100
Message-Id: <1109887099.2286.15.camel@boxen>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I had accidently chosen CONFIG_PNP and noticed that my keyboard didn't
work with bk-dtor-input.patch in the tree (backing out makes keyboard
work).


diff -up working_dmesg nokeyboard_dmesg

--- working_dmesg	2005-03-03 22:15:52.000000000 +0100
+++ nokeyboard_dmesg	2005-03-03 22:08:48.000000000 +0100
@@ -1,4 +1,4 @@
-Linux version 2.6.11-rc5 (alex@boxen) (gcc version 3.3.5 (Debian 1:3.3.5-1)) #10 Thu Mar 3 21:10:21 UTC 2005
+Linux version 2.6.11-rc5 (alex@boxen) (gcc version 3.3.5 (Debian 1:3.3.5-1)) #9 Thu Mar 3 21:05:37 UTC 2005
 BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
@@ -30,14 +30,14 @@ Local APIC disabled by BIOS -- reenablin
 Found and enabled local APIC!
 mapped APIC to ffffd000 (fee00000)
 Initializing CPU#0
-CPU 0 irqstacks, hard=c04bf000 soft=c04be000
+CPU 0 irqstacks, hard=c04be000 soft=c04bd000
 PID hash table entries: 512 (order: 9, 8192 bytes)
-Detected 1000.472 MHz processor.
+Detected 1000.568 MHz processor.
 Using tsc for high-res timesource
 Console: colour VGA+ 80x25
 Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
 Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
-Memory: 116968k/122816k available (2616k kernel code, 5296k reserved, 772k data, 416k init, 0k highmem)
+Memory: 116972k/122816k available (2614k kernel code, 5292k reserved, 770k data, 416k init, 0k highmem)
 Checking if this processor honours the WP bit even in supervisor mode... Ok.
 Calibrating delay loop... 1966.08 BogoMIPS (lpj=983040)
 Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
@@ -55,7 +55,7 @@ Checking 'hlt' instruction... OK.
  tbxface-0118 [02] acpi_load_tables      : ACPI Tables successfully acquired
 Parsing all Control Methods:........................................................................
 Table [DSDT](id F004) - 348 Objects with 29 Devices 72 Methods 24 Regions
-ACPI Namespace successfully loaded at root c04e9340
+ACPI Namespace successfully loaded at root c04e8340
 ACPI: setting ELCR to 0800 (from 0e00)
 evxfevnt-0094 [03] acpi_enable           : Transition to ACPI mode successful
 testing NMI watchdog ... OK.
@@ -100,9 +100,6 @@ SGI XFS Quota Management subsystem
 Initializing Cryptographic API
 Applying VIA southbridge workaround.
 PCI: Disabling Via external APIC routing
-PNP: No PS/2 controller found. Probing ports directly.
-serio: i8042 AUX port at 0x60,0x64 irq 12
-serio: i8042 KBD port at 0x60,0x64 irq 1
 Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
 ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
 ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
@@ -180,7 +177,6 @@ md: autorun ...
 md: ... autorun DONE.
 EXT3-fs: INFO: recovery required on readonly filesystem.
 EXT3-fs: write access will be enabled during recovery.
-input: AT Translated Set 2 keyboard on isa0060/serio0
 kjournald starting.  Commit interval 5 seconds
 EXT3-fs: recovery complete.
 EXT3-fs: mounted filesystem with ordered data mode.


