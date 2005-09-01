Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030226AbVIAQZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030226AbVIAQZT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 12:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030228AbVIAQZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 12:25:18 -0400
Received: from r3az252.chello.upc.cz ([213.220.243.252]:12006 "EHLO
	vrapenec.doma") by vger.kernel.org with ESMTP id S1030226AbVIAQZR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 12:25:17 -0400
Message-ID: <43172B40.10900@ribosome.natur.cuni.cz>
Date: Thu, 01 Sep 2005 18:24:32 +0200
From: =?ISO-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050531
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: PCI: IRQ 0 for device 0000:00:1f.3 doesn't match PIRQ mask - try
 pci=usepirqmask
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  what does this message really mean? I did what it suggests and the "IRQ 0"
is gone then. Is that a problem in kernel or should I just use for my hardware
pci=usepirqmask when acpi=off? Should I report somewhere else? Should I care at all?
I use 2.6.13 kernel with the patch for pcmcia from here:
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=81d4af1340badcd2100c84fbd1bfd13156de41aa

--- acpioff.txt 2005-09-01 17:52:45.787890500 +0200
+++ useirqmask.txt      2005-09-01 17:58:21.294486250 +0200
@@ -16,22 +16,23 @@
 DMI 2.3 present.
 Allocating PCI resources starting at 40000000 (gap: 40000000:bfff0000)
 Built 1 zonelists
-Kernel command line: udev root=/dev/hda2 idebus=66 console=ttyS0,57600n8 console=tty0 pcmcia_core.pc_debug=9 pcmcia.pc_debug=9 sa11xx_core.pc_debug=9 acpi=off
+Kernel command line: udev root=/dev/hda2 idebus=66 console=ttyS0,57600n8 console=tty0 pcmcia_core.pc_debug=9 pcmcia.pc_debug=9 sa11xx_core.pc_debug=9 acpi=off pci=usepirqmask
 ide_setup: idebus=66
 Unknown boot option `sa11xx_core.pc_debug=9': ignoring
 Local APIC disabled by BIOS -- you can enable it with "lapic"
 mapped APIC to ffffd000 (01803000)
 Initializing CPU#0
 CPU 0 irqstacks, hard=c05c1000 soft=c05c0000
 PID hash table entries: 4096 (order: 12, 65536 bytes)
-Detected 1800.362 MHz processor.
+Detected 1800.261 MHz processor.
 Using tsc for high-res timesource
 Console: colour VGA+ 80x25
 Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
 Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
 Memory: 1033480k/1048548k available (3061k kernel code, 14316k reserved, 1585k data, 192k init, 131044k highmem)
 Checking if this processor honours the WP bit even in supervisor mode... Ok.
-Calibrating delay using timer specific routine.. 3606.04 BogoMIPS (lpj=7212086)
+Calibrating delay using timer specific routine.. 3606.00 BogoMIPS (lpj=7212016)
 Mount-cache hash table entries: 512
 CPU: After generic identify, caps: bfebf9ff 00000000 00000000 00000000 00000000 00000000 00000000
 CPU: After vendor identify, caps: bfebf9ff 00000000 00000000 00000000 00000000 00000000 00000000
@@ -175,7 +176,6 @@
 PCI: Scanning behind PCI bridge 0000:00:1e.0, config 0a0200, pass 1
 PCI: Bus scan for 0000:00 returning with max=0a
 PCI: Using IRQ router PIIX/ICH [8086/248c] at 0000:00:1f.0
-PCI: IRQ 0 for device 0000:00:1f.3 doesn't match PIRQ mask - try pci=usepirqmask
 PCI: Found IRQ 11 for device 0000:00:1f.3
 PCI: Sharing IRQ 11 with 0000:00:1f.5
 PCI: Sharing IRQ 11 with 0000:00:1f.6


The HW is ASUS L3C/S laptop. More details on the HW in http://bugzilla.kernel.org/show_bug.cgi?id=4889
Please cc: me in replies.
Martin
