Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbTILPAF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 11:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbTILPAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 11:00:05 -0400
Received: from mail.velocity.net ([208.3.88.4]:41346 "EHLO mail.velocity.net")
	by vger.kernel.org with ESMTP id S261710AbTILO75 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 10:59:57 -0400
Subject: Adaptec 1210SA (SiL3112)
From: Dale Blount <linux-kernel@dale.us>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1063378797.8512.48.camel@dale.velocity.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 12 Sep 2003 10:59:57 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've given up on the Highpoint Rocket 1540 card:

http://www.spinics.net/lists/kernel/msg209799.html (lklm thread).

I contacted HPT's tech support and they mentioned there isn't a driver
available yet (even though it says "Linux Supported!" right on the
box...).  They don't know when it will be released and noted it will be
at least partially binary.

So I've moved on to the Adaptec card (only card I could find with a SiL
chipset).  I'd rather use a 3114 card as I need 4 ports, but I couldn't
find any info on support/cards using that chipset.

The current problem is that the SiL3112 keeps throwing 'lost interrupt'
messages.  I've tried DMA off/on all with no luck.  Here is the relevant
output from dmesg:

Linux version 2.4.22-ac2 (root@localhost.localdomain) (gcc version 3.2.2
20030222 (Red Hat Linux 3.2.2-5)) #12 Fri Sep 12 21:40:21 EDT 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e6000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ef30000 (usable)
 BIOS-e820: 000000003ef30000 - 000000003ef40000 (ACPI data)
 BIOS-e820: 000000003ef40000 - 000000003eff0000 (ACPI NVS)
 BIOS-e820: 000000003eff0000 - 000000003f000000 (reserved)
 BIOS-e820: 00000000fecf0000 - 00000000fecf1000 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000feda0000 (reserved)
111MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 257840
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 28464 pages.
Kernel command line: ro root=/dev/sda3
Initializing CPU#0
Detected 2527.236 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 5046.27 BogoMIPS
Memory: 1016396k/1031360k available (1568k kernel code, 14576k reserved,
553k data, 72k init, 113856k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) 4 CPU 2.53GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Transparent bridge - Intel Corp. 82801BA/CA/DB/EB PCI Bridge
PCI: Using IRQ router PIIX/ICH [8086/24d0] at 00:1f.0
PCI: Found IRQ 10 for device 00:1f.1
PCI: Sharing IRQ 10 with 00:1d.2
PCI: Sharing IRQ 10 with 00:1f.2
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
Linux Tulip driver version 0.9.15-pre12 (Aug 9, 2002)
PCI: Found IRQ 7 for device 01:00.0
tulip0:  MII transceiver #1 config 3000 status 7829 advertising 01e1.
eth0: Lite-On 82c168 PNIC rev 32 at 0xb800, 00:A0:CC:D2:4E:95, IRQ 7.
Intel(R) PRO/100 Network Driver - version 2.3.18-k1
Copyright (c) 2003 Intel Corporation

PCI: Found IRQ 4 for device 01:08.0
e100: selftest OK.
e100: eth1: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled

Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
Adaptec AAR-1210SA: IDE controller at PCI slot 01:03.0
PCI: Found IRQ 5 for device 01:03.0
PCI: Sharing IRQ 5 with 00:1d.1
Adaptec AAR-1210SA: chipset revision 2
Adaptec AAR-1210SA: not 100% native mode: will probe irqs later
    ide0: MMIO-DMA , BIOS settings: hda:pio, hdb:pio
    ide1: MMIO-DMA , BIOS settings: hdc:pio, hdd:pio
hda: ST3160023AS, ATA DISK drive
blk: queue c034e840, I/O limit 4095Mb (mask 0xffffffff)
hdc: ST3160023AS, ATA DISK drive
blk: queue c034ec9c, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0xf8802880-0xf8802887,0xf880288a on irq 5
ide1 at 0xf88028c0-0xf88028c7,0xf88028ca on irq 5
hda: attached ide-disk driver.
SysRq : Changing Loglevel
Loglevel set to 9
SysRq : Changing Loglevel
Loglevel set to 9
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: host protected area => 1
hda: lost interrupt
hda: 312581808 sectors (160042 MB) w/8192KiB Cache, CHS=19457/255/63
hda: lost interrupt
hda: lost interrupt
hdc: attached ide-disk driver.
hdc: lost interrupt
hdc: lost interrupt
hdc: lost interrupt
hdc: host protected area => 1
hdc: lost interrupt
hdc: 312581808 sectors (160042 MB) w/8192KiB Cache, CHS=19457/255/63
hdc: lost interrupt
hdc: lost interrupt
Partition check:
 hda:<4>hda: dma_timer_expiry: dma status == 0x24
hda: DMA interrupt recovery
hda: lost interrupt
 hda1
 hdc:<4>hdc: dma_timer_expiry: dma status == 0x24
hdc: DMA interrupt recovery
hdc: lost interrupt
 unknown partition table
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
ata_piix version 0.94
PCI: Found IRQ 10 for device 00:1f.2
PCI: Sharing IRQ 10 with 00:1d.2
PCI: Sharing IRQ 10 with 00:1f.1
PCI: Setting latency timer of device 00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xE800 ctl 0xE402 bmdma 0xD800 irq 10
ata2: SATA max UDMA/133 cmd 0xE000 ctl 0xDC02 bmdma 0xD808 irq 10
ata1: bus reset via SRST
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003
88:207f
ata1: dev 0 ATA, max UDMA/133, 234441648 sectors (lba48)
ata1: dev 0 configured for UDMA/133
ata2: SATA port has no device. disabling.
ata2: thread exiting
scsi1 : ata_piix
scsi2 : ata_piix
  Vendor: ATA       Model: ST3120026AS       Rev: 0.71
  Type:   Direct-Access                      ANSI SCSI revision: 05
libata version 0.71 loaded.
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 >


Is there anything else I can do to get this card working?  Or another
sata card *verified* working under 2.4.2x?

Thanks,

Dale


