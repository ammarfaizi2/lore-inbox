Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268095AbUI1X2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268095AbUI1X2x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 19:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268100AbUI1X2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 19:28:52 -0400
Received: from mailgw.aecom.yu.edu ([129.98.1.16]:22750 "EHLO
	mailgw.aecom.yu.edu") by vger.kernel.org with ESMTP id S268095AbUI1X2M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 19:28:12 -0400
Mime-Version: 1.0
Message-Id: <a06100582bd7e5117971d@[129.98.90.227]>
In-Reply-To: <20040926093254.GA2593@cph.demon.co.uk>
References: <a06100547bcd3f33b5b73@[129.98.90.227]>
 <40AE4DDC.7050508@pobox.com> <a06100577bd7bc87d92ee@[129.98.90.227]>
 <20040926093254.GA2593@cph.demon.co.uk>
Date: Tue, 28 Sep 2004 19:28:57 -0400
To: linux-kernel@vger.kernel.org
From: Maurice Volaski <mvolaski@aecom.yu.edu>
Subject: 2.6.9-rc2 affected by tg3 [Was Re: tg3 module in kernel 2.6.5
 panics ]
Cc: jgarzik@pobox.com, Colin Phipps <cph@cph.demon.co.uk>,
       davem@nuts.davemloft.net
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>fixed.  So it's worth looking for any modules that failed to load
>earlier in the boot, they could be leaving junk in pci_bus_type.drivers

I don't see any. Here is the output from 2.6.9-rc2. This output is 
from kmsg immediately upon booting and manually loading tg3:

<4>Bootdata ok (command line is root=/dev/ram0 init=/linuxrc 
ramdisk=5500 real_root=/dev/sda3 doscsi)
<4>Linux version 2.6.9-rc2 (root@thewarehouse4) (gcc version 3.3.4 
20040623 (Gentoo Linux 3.3.4-r1, ssp-3.3.2-2, pie-8.7.6)) #4 Mon Sep 
27 21:08:24 EDT 2004
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
<4> BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
<4> BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
<4> BIOS-e820: 0000000000100000 - 00000000fc000000 (usable)
<4> BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
<6>No mptable found.
<7>On node 0 totalpages: 1032192
<7>  DMA zone: 4096 pages, LIFO batch:1
<7>  Normal zone: 1028096 pages, LIFO batch:16
<7>  HighMem zone: 0 pages, LIFO batch:1
<3>ACPI: Unable to locate RSDP
<4>Intel MultiProcessor Specification v1.1
<6>    Virtual Wire compatibility mode.
<6>OEM ID: TYAN     <6>Product ID: S2882        <6>APIC at: 0xFEE00000
<6>Processor #0 15:5 APIC version 16
<6>Processor #1 15:5 APIC version 16
<4>WARNING: NR_CPUS limit of 1 reached. Processor ignored.
<4>I/O APIC #2 Version 17 at 0xFEC00000.
<4>I/O APIC #3 Version 17 at 0xFEBFF000.
<4>I/O APIC #4 Version 17 at 0xFEBFE000.
<6>Processors: 1
<4>Checking aperture...
<4>CPU 0: aperture @ 408000000 size 32 MB
<4>Aperture from northbridge cpu 0 too small (32 MB)
<4>No AGP bridge found
<4>Built 1 zonelists
<4>Kernel command line: root=/dev/ram0 init=/linuxrc ramdisk=5500 
real_root=/dev/sda3 doscsi console=tty0
<4>Initializing CPU#0
<4>PID hash table entries: 4096 (order: 12, 131072 bytes)
<6>time.c: Using 1.193182 MHz PIT timer.
<6>time.c: Detected 2190.953 MHz processor.
<4>Console: colour VGA+ 80x25
<4>Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
<4>Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
<4>Memory: 4058688k/4128768k available (2714k kernel code, 69288k 
reserved, 1555k data, 184k init)
<7>Calibrating delay loop... 4308.99 BogoMIPS (lpj=2154496)
<4>Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
<6>CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
<6>CPU: L2 Cache: 1024K (64 bytes/line)
<4>CPU: AMD Opteron(tm) Processor 248 stepping 08
<3>ACPI: System description tables not found
<4>    ACPI-0084: *** Error: acpi_load_tables: Could not get RSDP, AE_NOT_FOUND
<4>    ACPI-0134: *** Error: acpi_load_tables: Could not load tables: 
AE_NOT_FOUND
<3>ACPI: Unable to load the System Description Tables
<6>Using local APIC NMI watchdog using perfctr0
<4>ENABLING IO-APIC IRQs
<6>Using IO-APIC 2
<6>...changing IO-APIC physical APIC ID to 2 ... ok.
<6>Using IO-APIC 3
<6>...changing IO-APIC physical APIC ID to 3 ... ok.
<6>Using IO-APIC 4
<6>...changing IO-APIC physical APIC ID to 4 ... ok.
<7>init IO_APIC IRQs
<7> IO-APIC (apicid-pin) 2-0, 2-5, 2-9, 2-10, 2-11, 2-16, 2-17, 2-20, 
2-21, 2-22, 2-23, 3-2, 3-3, 4-0, 4-1 not connected.
<6>..TIMER: vector=0x31 pin1=2 pin2=0
<7>number of MP IRQ sources: 21.
<7>number of IO-APIC #2 registers: 24.
<7>number of IO-APIC #3 registers: 4.
<7>number of IO-APIC #4 registers: 4.
<6>testing the IO APIC.......................
<4>
<7>IO APIC #2......
<7>.... register #00: 02000000
<7>.......    : physical APIC id: 02
<7>.... register #01: 00170011
<7>.......     : max redirection entries: 0017
<7>.......     : PRQ implemented: 0
<7>.......     : IO APIC version: 0011
<7>.... register #02: 02000000
<7>.......     : arbitration: 02
<7>.... IRQ redirection table:
<7> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:  
<7> 00 000 00  1    0    0   0   0    0    0    00
<7> 01 001 01  0    0    0   0   0    1    1    39
<7> 02 001 01  0    0    0   0   0    1    1    31
<7> 03 001 01  0    0    0   0   0    1    1    41
<7> 04 001 01  0    0    0   0   0    1    1    49
<7> 05 000 00  1    0    0   0   0    0    0    00
<7> 06 001 01  0    0    0   0   0    1    1    51
<7> 07 001 01  0    0    0   0   0    1    1    59
<7> 08 001 01  0    0    0   0   0    1    1    61
<7> 09 000 00  1    0    0   0   0    0    0    00
<7> 0a 000 00  1    0    0   0   0    0    0    00
<7> 0b 000 00  1    0    0   0   0    0    0    00
<7> 0c 001 01  0    0    0   0   0    1    1    69
<7> 0d 001 01  0    0    0   0   0    1    1    71
<7> 0e 001 01  0    0    0   0   0    1    1    79
<7> 0f 001 01  0    0    0   0   0    1    1    81
<7> 10 000 00  1    0    0   0   0    0    0    00
<7> 11 000 00  1    0    0   0   0    0    0    00
<7> 12 001 01  1    1    0   1   0    1    1    89
<7> 13 001 01  1    1    0   1   0    1    1    91
<7> 14 000 00  1    0    0   0   0    0    0    00
<7> 15 000 00  1    0    0   0   0    0    0    00
<7> 16 000 00  1    0    0   0   0    0    0    00
<7> 17 000 00  1    0    0   0   0    0    0    00
<4>
<7>IO APIC #3......
<7>.... register #00: 03000000
<7>.......    : physical APIC id: 03
<7>.... register #01: 00030011
<7>.......     : max redirection entries: 0003
<7>.......     : PRQ implemented: 0
<7>.......     : IO APIC version: 0011
<7>.... register #02: 00000000
<7>.......     : arbitration: 00
<7>.... IRQ redirection table:
<7> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:  
<7> 00 001 01  1    1    0   1   0    1    1    99
<7> 01 001 01  1    1    0   1   0    1    1    A1
<7> 02 000 00  1    0    0   0   0    0    0    00
<7> 03 000 00  1    0    0   0   0    0    0    00
<4>
<7>IO APIC #4......
<7>.... register #00: 04000000
<7>.......    : physical APIC id: 04
<7>.... register #01: 00030011
<7>.......     : max redirection entries: 0003
<7>.......     : PRQ implemented: 0
<7>.......     : IO APIC version: 0011
<7>.... register #02: 00000000
<7>.......     : arbitration: 00
<7>.... IRQ redirection table:
<7> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:  
<7> 00 000 00  1    0    0   0   0    0    0    00
<7> 01 000 00  1    0    0   0   0    0    0    00
<7> 02 001 01  1    1    0   1   0    1    1    A9
<7> 03 001 01  1    1    0   1   0    1    1    B1
<6>Using vector-based indexing
<7>IRQ to pin mappings:
<7>IRQ0 -> 0:2
<7>IRQ1 -> 0:1
<7>IRQ3 -> 0:3
<7>IRQ4 -> 0:4
<7>IRQ6 -> 0:6
<7>IRQ7 -> 0:7
<7>IRQ8 -> 0:8
<7>IRQ12 -> 0:12
<7>IRQ13 -> 0:13
<7>IRQ14 -> 0:14
<7>IRQ15 -> 0:15
<7>IRQ137 -> 0:18
<7>IRQ145 -> 0:19
<7>IRQ153 -> 1:0
<7>IRQ161 -> 1:1
<7>IRQ169 -> 2:2
<7>IRQ177 -> 2:3
<6>.................................... done.
<6>Using local APIC timer interrupts.
<6>Detected 12.448 MHz APIC timer.
<6>checking if image is initramfs...it isn't (no cpio magic); looks 
like an initrd
<6>NET: Registered protocol family 16
<6>PCI: Using configuration type 1
<6>mtrr: v2.0 (20020519)
<6>ACPI: Subsystem revision 20040715
<6>ACPI: Interpreter disabled.
<5>SCSI subsystem initialized
<4>PCI: Probing PCI hardware
<4>PCI: Probing PCI hardware (bus 00)
<6>PCI: Using IRQ router default [1022/746b] at 0000:00:07.3
<6>PCI->APIC IRQ transform: (B0,I7,P3) -> 145
<6>PCI->APIC IRQ transform: (B3,I0,P3) -> 145
<6>PCI->APIC IRQ transform: (B3,I0,P3) -> 145
<6>PCI->APIC IRQ transform: (B3,I5,P0) -> 145
<6>PCI->APIC IRQ transform: (B3,I6,P0) -> 137
<6>PCI->APIC IRQ transform: (B3,I8,P0) -> 137
<6>PCI->APIC IRQ transform: (B2,I9,P0) -> 153
<6>PCI->APIC IRQ transform: (B2,I9,P1) -> 161
<6>PCI->APIC IRQ transform: (B1,I5,P0) -> 169
<6>PCI->APIC IRQ transform: (B1,I5,P1) -> 177
<4>TC classifier action (bugs to netdev@oss.sgi.com cc hadi@cyberus.ca)
<6>PCI-DMA: Disabling IOMMU.
<4>IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
<6>audit: initializing netlink socket (disabled)
<3>audit(1096386714.222:0): initialized
<4>Total HugeTLB memory allocated, 0
<6>devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
<6>devfs: boot_options: 0x1
<6>Initializing Cryptographic API
<4>vesafb: probe of vesafb0 failed with error -6
<6>Real Time Clock Driver v1.12
<6>Non-volatile memory driver v1.2
<6>hw_random: AMD768 system management I/O registers at 0x5000.
<6>hw_random hardware driver 1.0.0 loaded
<6>Linux agpgart interface v0.100 (c) Dave Jones
<4>RAMDISK driver initialized: 16 RAM disks of 5500K size 1024 blocksize
<6>loop: loaded (max 8 devices)
<6>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
<6>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
<6>AMD8111: IDE controller at PCI slot 0000:00:07.1
<6>AMD8111: chipset revision 3
<6>AMD8111: not 100% native mode: will probe irqs later
<6>AMD8111: 0000:00:07.1 (rev 03) UDMA133 controller
<6>    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
<6>    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:DMA
<7>Probing IDE interface ide0...
<7>Probing IDE interface ide1...
<4>hdd: LITE-ON DVDRW LDW-811S, ATAPI CD/DVD-ROM drive
<4>Using anticipatory io scheduler
<4>ide1 at 0x170-0x177,0x376 on irq 15
<7>Probing IDE interface ide0...
<7>Probing IDE interface ide2...
<7>ide2: Wait for ready failed before probe !
<7>Probing IDE interface ide3...
<7>ide3: Wait for ready failed before probe !
<7>Probing IDE interface ide4...
<7>ide4: Wait for ready failed before probe !
<7>Probing IDE interface ide5...
<7>ide5: Wait for ready failed before probe !
<4>hdd: ATAPI 40X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
<6>Uniform CD-ROM driver Revision: 3.20
<4>GDT-HA: Storage RAID Controller Driver. Version: 3.04
<4>GDT-HA: Found 0 PCI Storage RAID Controllers
<7>libata version 1.02 loaded.
<7>sata_sil version 0.54
<6>ata1: SATA max UDMA/100 cmd 0xFFFFFF000001CC80 ctl 
0xFFFFFF000001CC8A bmdma 0xFFFFFF000001CC00 irq 145
<6>ata2: SATA max UDMA/100 cmd 0xFFFFFF000001CCC0 ctl 
0xFFFFFF000001CCCA bmdma 0xFFFFFF000001CC08 irq 145
<6>ata3: SATA max UDMA/100 cmd 0xFFFFFF000001CE80 ctl 
0xFFFFFF000001CE8A bmdma 0xFFFFFF000001CE00 irq 145
<6>ata4: SATA max UDMA/100 cmd 0xFFFFFF000001CEC0 ctl 
0xFFFFFF000001CECA bmdma 0xFFFFFF000001CE08 irq 145
<7>ata1: dev 0 cfg 49:2f00 82:74eb 83:7f63 84:4003 85:74e9 86:3c43 
87:4003 88:207f
<6>ata1: dev 0 ATA, max UDMA/133, 145226112 sectors: lba48
<6>ata1: dev 0 configured for UDMA/100
<6>scsi0 : sata_sil
<6>ata2: no device found (phy stat 00000000)
<6>scsi1 : sata_sil
<6>ata3: no device found (phy stat 00000000)
<6>scsi2 : sata_sil
<6>ata4: no device found (phy stat 00000000)
<6>scsi3 : sata_sil
<5>  Vendor: ATA       Model: WDC WD740GD-00FL  Rev: 21.0
<5>  Type:   Direct-Access                      ANSI SCSI revision: 05
<5>SCSI device sda: 145226112 512-byte hdwr sectors (74356 MB)
<5>SCSI device sda: drive cache: write back
<6> /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 >
<5>Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
<5>Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
<6>mice: PS/2 mouse device common for all mice
<6>serio: i8042 AUX port at 0x60,0x64 irq 12
<6>input: ImExPS/2 Logitech Explorer Mouse on isa0060/serio1
<6>serio: i8042 KBD port at 0x60,0x64 irq 1
<6>input: AT Translated Set 2 keyboard on isa0060/serio0
<6>device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
<6>NET: Registered protocol family 2
<6>IP: routing cache hash table of 4096 buckets, 224Kbytes
<6>TCP: Hash tables configured (established 524288 bind 37449)
<6>NET: Registered protocol family 1
<6>NET: Registered protocol family 17
<6>powernow-k8: Power state transitions not supported
<5>RAMDISK: Compressed image found at block 0
<4>VFS: Mounted root (ext2 filesystem) readonly.
<6>Mounted devfs on /dev
<4>Freeing unused kernel memory: 184k freed
<6>kjournald starting.  Commit interval 5 seconds
<6>EXT3 FS on sda3, internal journal
<6>EXT3-fs: mounted filesystem with ordered data mode.
<6>Adding 8008392k swap on /dev/sda2.  Priority:-1 extents:1
<6>EXT3 FS on sda3, internal journal
<4>EXT3-fs warning: checktime reached, running e2fsck is recommended
<6>kjournald starting.  Commit interval 5 seconds
<6>EXT3 FS on sda5, internal journal
<6>EXT3-fs: mounted filesystem with ordered data mode.
<1>Unable to handle kernel paging request at ffffffffa004aac0 RIP:
<1><ffffffff8024456b>{kobject_add+139}
<4>PML4 103027 PGD 105027 PMD fa82c067 PTE 0
<0>Oops: 0002 [1] PREEMPT
<4>CPU 0
<4>Modules linked in: tg3
<4>Pid: 2514, comm: modprobe Not tainted 2.6.9-rc2
<4>RIP: 0010:[<ffffffff8024456b>] <ffffffff8024456b>{kobject_add+139}
<4>RSP: 0018:00000100ee41be78  EFLAGS: 00010282
<4>RAX: ffffffff804d0e38 RBX: ffffffff804d0de0 RCX: ffffffffa004aac0
<4>RDX: ffffffffa00191c0 RSI: 0000000000000042 RDI: ffffffff804d0e64
<4>RBP: ffffffffa00191a0 R08: 0000000000000000 R09: 0000010004df20e8
<4>R10: ffffffff8047fd20 R11: 0000000000000012 R12: ffffffff804d0e48
<4>R13: 0000000000000000 R14: 0000000000515240 R15: 0000000000000000
<4>FS:  00000000005154a0(0000) GS:ffffffff8058d7c0(0000) knlGS:0000000000000000
<4>CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
<4>CR2: ffffffffa004aac0 CR3: 0000000000101000 CR4: 00000000000006e0
<4>Process modprobe (pid: 2514, threadinfo 00000100ee41a000, task 
00000100ee419410)
<4>Stack: ffffffffa00191a0 00000000ffffffea ffffffff804d0d60 ffffffff802445f8
<4>       0000000000000000 ffffffffa00191a0 ffffffffa0019148 ffffffff802b37e3
<4>       0000002a00000012 ffffffffa0019100
<4>Call Trace:<ffffffff802445f8>{kobject_register+40} 
<ffffffff802b37e3>{bus_add_driver+99}
<4>       <ffffffff802b3d80>{driver_register+160} 
<ffffffff80250ad8>{pci_register_driver+152}
<4>       <ffffffffa001b010>{:tg3:tg3_init+16} 
<ffffffff80165c89>{sys_init_module+697}
<4>       <ffffffff801122fa>{system_call+126}
<4>
<4>Code: 48 89 11 48 89 4a 08 48 8b 45 38 48 8b 38 48 83 c7 78 e8 be
<1>RIP <ffffffff8024456b>{kobject_add+139} RSP <00000100ee41be78>
<0>CR2: ffffffffa004aac0
<4> <6>kjournald starting.  Commit interval 5 seconds
<6>EXT3 FS on sda1, internal journal
<6>EXT3-fs: mounted filesystem with ordered data mode.

-- 

Maurice Volaski, mvolaski@aecom.yu.edu
Computing Support, Rose F. Kennedy Center
Albert Einstein College of Medicine of Yeshiva University
