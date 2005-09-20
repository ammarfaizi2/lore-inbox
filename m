Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964927AbVITIcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964927AbVITIcK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 04:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964928AbVITIcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 04:32:09 -0400
Received: from news.cistron.nl ([62.216.30.38]:20892 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S964927AbVITIcH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 04:32:07 -0400
From: dth@cistron.nl (Danny ter Haar)
Subject: 2.6.14-rc1-git5: problem with "nosmp" boot argument
Date: Tue, 20 Sep 2005 08:32:02 +0000 (UTC)
Organization: Cistron
Message-ID: <dgohe2$2iv$1@news.cistron.nl>
X-Trace: ncc1701.cistron.net 1127205122 2655 62.216.30.70 (20 Sep 2005 08:32:02 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@cistron.nl (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Still having problems with SMP (non-) performance

Just tried to reboot SMP kernel with "nosmp" argument.

Built 2 zonelists
Kernel command line: root=/dev/md0 ro console=tty0 console=ttyS0,9600 nosmp panic=30
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 14.318180 MHz HPET timer.
time.c: Detected 2391.537 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Memory: 4061536k/4128704k available (2513k kernel code, 66780k reserved, 809k data, 192k init)
Calibrating delay using timer specific routine.. 4789.70 BogoMIPS (lpj=9579417)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(1) -> Node 0 -> Core 0
mtrr: v2.0 (20020519)
SMP mode deactivated, forcing use of dummy APIC emulation.
SMP disabled
Brought up 1 CPUs
time.c: Using HPET/TSC based timekeeping.
testing NMI watchdog ... CPU#0: NMI appears to be stuck (0->0)!
softlockup thread 0 started up.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
Generic PHY: Registered new driver
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
hpet0: at MMIO 0xfec01000, IRQs 2, 8, 0
hpet0: 69ns tick, 3 32-bit timers
PCI-DMA: Disabling IOMMU.
PCI: Bridge: 0000:00:06.0
  IO window: a000-bfff
  MEM window: fc900000-feafffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0a.0
No IOAPIC for GSI 4
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ERROR: Unable to locate IOAPIC for GSI 3
No IOAPIC for GSI 3
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
loop: loaded (max 8 devices)
ERROR: Unable to locate IOAPIC for GSI 24
No IOAPIC for GSI 24
ACPI: PCI Interrupt 0000:02:06.0[A] -> GSI 24 (level, low) -> IRQ 24
aic79xx: probe of 0000:02:06.0 failed with error -38
ERROR: Unable to locate IOAPIC for GSI 25
No IOAPIC for GSI 25
ACPI: PCI Interrupt 0000:02:06.1[B] -> <7>spurious 8259A interrupt: IRQ7.
GSI 25 (level, low) -> IRQ 25
aic79xx: probe of 0000:02:06.1 failed with error -38
md: raid1 personality registered as nr 3
md: multipath personality registered as nr 7
md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=2

[HANG HERE]

