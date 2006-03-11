Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750867AbWCKPUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbWCKPUu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 10:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWCKPUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 10:20:50 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:45266 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1750867AbWCKPUt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 10:20:49 -0500
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morotn <akpm@osdl.org>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>, htejun@gmail.com,
       jgarzik@pobox.com
Subject: ata2: dev 0 failed to IDENTIFY (I/O error) [Was: 2.6.16-rc5-mm3]
In-reply-to: <20060307021929.754329c9.akpm@osdl.org>
Message-Id: <E1FI5tQ-0002kx-00@decibel.fi.muni.cz>
Date: Sat, 11 Mar 2006 16:20:32 +0100
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@informatics.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this is in diff between -mm2 and -mm3:
ata2: SATA port has no device.
ata2: PIO error
ata2: dev 0 failed to IDENTIFY (I/O error)

These lines are new in dmesg.

Whole diff:
--- mm2	2006-03-11 15:50:21.000000000 +0100
+++ mm3	2006-03-11 15:49:11.000000000 +0100
@@ -1,4 +1,4 @@
-Linux version 2.6.16-rc5-mm2 (ku@bellona) (gcc version 4.1.0 20060214 (Red Hat 4.1.0-0.27)) #101 SMP PREEMPT Fri Mar 3 16:20:18 CET 2006
+Linux version 2.6.16-rc5-mm3 (ku@bellona) (gcc version 4.1.0 20060214 (Red Hat 4.1.0-0.27)) #102 SMP PREEMPT Thu Mar 9 23:49:35 CET 2006
 BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
@@ -38,7 +38,7 @@
 Enabling APIC mode:  Flat.  Using 1 I/O APICs
 Using ACPI (MADT) for SMP configuration information
 Allocating PCI resources starting at 30000000 (gap: 20000000:dec00000)
-Detected 2736.287 MHz processor.
+Detected 2736.432 MHz processor.
 Built 1 zonelists
 Kernel command line: ro root=/dev/hda2 reboot=w
 mapped APIC to ffffd000 (fee00000)
@@ -51,9 +51,9 @@
 Console: colour VGA+ 80x25
 Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
 Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
-Memory: 514404k/524224k available (2532k kernel code, 9360k reserved, 1380k data, 200k init, 0k highmem)
+Memory: 514404k/524224k available (2534k kernel code, 9360k reserved, 1378k data, 200k init, 0k highmem)
 Checking if this processor honours the WP bit even in supervisor mode... Ok.
-Calibrating delay using timer specific routine.. 5476.83 BogoMIPS (lpj=10953674)
+Calibrating delay using timer specific routine.. 5476.78 BogoMIPS (lpj=10953574)
 Mount-cache hash table entries: 512
 CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
 CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
@@ -71,7 +71,7 @@
 Booting processor 1/1 eip 2000
 CPU 1 irqstacks, hard=c0513000 soft=c0510000
 Initializing CPU#1
-Calibrating delay using timer specific routine.. 5472.84 BogoMIPS (lpj=10945697)
+Calibrating delay using timer specific routine.. 5472.77 BogoMIPS (lpj=10945557)
 CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
 CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
 CPU: Trace cache: 12K uops, L1 D cache: 8K
@@ -83,12 +83,12 @@
 CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
 CPU1: Thermal monitoring enabled
 CPU1: Intel(R) Pentium(R) 4 CPU 2.60GHz stepping 09
-Total of 2 processors activated (10949.68 BogoMIPS).
+Total of 2 processors activated (10949.56 BogoMIPS).
 ENABLING IO-APIC IRQs
 ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
 checking TSC synchronization across 2 CPUs: passed.
 Brought up 2 CPUs
-migration_cost=5
+migration_cost=145
 NET: Registered protocol family 16
 ACPI: bus type pci registered
 PCI: Using configuration type 1
@@ -170,6 +170,7 @@
  hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
 libata version 1.20 loaded.
 ata_piix 0000:00:1f.2: version 1.05
+ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
 ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 18
 PCI: Setting latency timer of device 0000:00:1f.2 to 64
 ata1: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 18
@@ -177,8 +178,12 @@
 ata1: dev 0 cfg 49:2f00 82:346b 83:7f21 84:4003 85:3469 86:3c01 87:4003 88:203f
 ata1: dev 0 ATA-6, max UDMA/100, 234441648 sectors: LBA48
 ata1(0): applying bridge limits
+ata1: dev 0 cfg 49:2f00 82:346b 83:7f21 84:4003 85:3469 86:3c01 87:4003 88:203f
 ata1: dev 0 configured for UDMA/100
 scsi0 : ata_piix
+ata2: SATA port has no device.
+ata2: PIO error
+ata2: dev 0 failed to IDENTIFY (I/O error)
 scsi1 : ata_piix
   Vendor: ATA       Model: WDC WD1200JD-00F  Rev: 02.0
   Type:   Direct-Access                      ANSI SCSI revision: 05
@@ -203,7 +208,7 @@
 usb usb1: new device found, idVendor=0000, idProduct=0000
 usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
 usb usb1: Product: EHCI Host Controller
-usb usb1: Manufacturer: Linux 2.6.16-rc5-mm2 ehci_hcd
+usb usb1: Manufacturer: Linux 2.6.16-rc5-mm3 ehci_hcd
 usb usb1: SerialNumber: 0000:00:1d.7
 usb usb1: configuration #1 chosen from 1 choice
 hub 1-0:1.0: USB hub found
@@ -217,7 +222,7 @@
 usb usb2: new device found, idVendor=0000, idProduct=0000
 usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
 usb usb2: Product: UHCI Host Controller
-usb usb2: Manufacturer: Linux 2.6.16-rc5-mm2 uhci_hcd
+usb usb2: Manufacturer: Linux 2.6.16-rc5-mm3 uhci_hcd
 usb usb2: SerialNumber: 0000:00:1d.0
 usb usb2: configuration #1 chosen from 1 choice
 hub 2-0:1.0: USB hub found
@@ -230,7 +235,7 @@
 usb usb3: new device found, idVendor=0000, idProduct=0000
 usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
 usb usb3: Product: UHCI Host Controller
-usb usb3: Manufacturer: Linux 2.6.16-rc5-mm2 uhci_hcd
+usb usb3: Manufacturer: Linux 2.6.16-rc5-mm3 uhci_hcd
 usb usb3: SerialNumber: 0000:00:1d.1
 usb usb3: configuration #1 chosen from 1 choice
 hub 3-0:1.0: USB hub found
@@ -243,7 +248,7 @@
 usb usb4: new device found, idVendor=0000, idProduct=0000
 usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
 usb usb4: Product: UHCI Host Controller
-usb usb4: Manufacturer: Linux 2.6.16-rc5-mm2 uhci_hcd
+usb usb4: Manufacturer: Linux 2.6.16-rc5-mm3 uhci_hcd
 usb usb4: SerialNumber: 0000:00:1d.2
 usb usb4: configuration #1 chosen from 1 choice
 hub 4-0:1.0: USB hub found
@@ -256,7 +261,7 @@
 usb usb5: new device found, idVendor=0000, idProduct=0000
 usb usb5: new device strings: Mfr=3, Product=2, SerialNumber=1
 usb usb5: Product: UHCI Host Controller
-usb usb5: Manufacturer: Linux 2.6.16-rc5-mm2 uhci_hcd
+usb usb5: Manufacturer: Linux 2.6.16-rc5-mm3 uhci_hcd
 usb usb5: SerialNumber: 0000:00:1d.3
 usb usb5: configuration #1 chosen from 1 choice
 hub 5-0:1.0: USB hub found
@@ -294,25 +299,25 @@
 NET: Registered protocol family 17
 Starting balanced_irq
 Using IPI Shortcut mode
+Time: tsc clocksource has been installed.
 kjournald starting.  Commit interval 5 seconds
 EXT3-fs: mounted filesystem with ordered data mode.
 VFS: Mounted root (ext3 filesystem) readonly.
 Freeing unused kernel memory: 200k freed
-Time: tsc clocksource has been installed.
 input: AT Translated Set 2 keyboard as /class/input/input1
-gameport: EMU10K1 is pci0000:02:02.1/gameport0, io 0xa400, speed 1065kHz
 hdc: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
 Uniform CD-ROM driver Revision: 3.20
 hdd: ATAPI 40X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
+gameport: EMU10K1 is pci0000:02:02.1/gameport0, io 0xa400, speed 1084kHz
 ieee1394: Initialized config rom entry `ip1394'
 ACPI: PCI Interrupt 0000:02:05.0[A] -> GSI 21 (level, low) -> IRQ 22
 ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[22]  MMIO=[fa004000-fa0047ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
 Floppy drive(s): fd0 is 1.44M
 FDC 0 is a post-1991 82077
 parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
+ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000d6100001a97a1]
 EXT3 FS on hda2, internal journal
 kjournald starting.  Commit interval 5 seconds
-ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000d6100001a97a1]
 EXT3 FS on hda5, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 kjournald starting.  Commit interval 5 seconds
