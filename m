Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262873AbUFJUAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262873AbUFJUAH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 16:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262850AbUFJUAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 16:00:07 -0400
Received: from [80.72.36.106] ([80.72.36.106]:64146 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S262873AbUFJT6R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 15:58:17 -0400
Date: Thu, 10 Jun 2004 21:57:58 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.7-rc3-mm1 problems (ACPI and others)
In-Reply-To: <200406102045.i5AKjDJo017156@snoqualmie.dp.intel.com>
Message-ID: <Pine.LNX.4.58.0406102131360.18039@alpha.polcom.net>
References: <200406102045.i5AKjDJo017156@snoqualmie.dp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have the following problems with 2.6.7-rc3-mm1:

1. ACPI is still broken for me. It was broken on 2.6.7-rc2-mm2 (as I 
reported previously) but was working fine with 2.6.6-mm4 (see log).

2. Why is RTC complaining (see log)?

3. PERFCTR gives me compile time errors (see compiler messages). Do I need 
any special patches?


Here is my log:

Jun 10 20:22:28 polb01 Linux version 2.6.7-rc3-mm1 (root@polb01) (gcc 
version 3.3.3 20040412 (Gentoo Linux 3.3.3-r6, ssp-3.3.2-2, pie-8.7.6)) #1 
Thu Jun 10 20:12:55 CEST 2004
Jun 10 20:22:28 polb01 BIOS-provided physical RAM map:
Jun 10 20:22:28 polb01 BIOS-e820: 0000000000000000 - 000000000009fc00 
(usable)
Jun 10 20:22:28 polb01 BIOS-e820: 000000000009fc00 - 00000000000a0000 
(reserved)
Jun 10 20:22:28 polb01 BIOS-e820: 00000000000f0000 - 0000000000100000 
(reserved)
Jun 10 20:22:28 polb01 BIOS-e820: 0000000000100000 - 000000001fff0000 
(usable)
Jun 10 20:22:28 polb01 BIOS-e820: 000000001fff0000 - 000000001fff3000 
(ACPI NVS)
Jun 10 20:22:28 polb01 BIOS-e820: 000000001fff3000 - 0000000020000000 
(ACPI data)
Jun 10 20:22:28 polb01 BIOS-e820: 00000000ffff0000 - 0000000100000000 
(reserved)
Jun 10 20:22:28 polb01 511MB LOWMEM available.
Jun 10 20:22:28 polb01 On node 0 totalpages: 131056
Jun 10 20:22:28 polb01 DMA zone: 4096 pages, LIFO batch:1
Jun 10 20:22:28 polb01 Normal zone: 126960 pages, LIFO batch:16
Jun 10 20:22:28 polb01 HighMem zone: 0 pages, LIFO batch:1
Jun 10 20:22:28 polb01 DMI 2.2 present.
Jun 10 20:22:28 polb01 ACPI: RSDP (v000 761686                                    
) @ 0x000f6810
Jun 10 20:22:28 polb01 ACPI: RSDT (v001 761686 AWRDACPI 0x42302e31 AWRD 
0x00000000) @ 0x1fff3000
Jun 10 20:22:28 polb01 ACPI: FADT (v001 761686 AWRDACPI 0x42302e31 AWRD 
0x00000000) @ 0x1fff3040
Jun 10 20:22:28 polb01 ACPI: DSDT (v001 761686 AWRDACPI 0x00001000 MSFT 
0x0100000c) @ 0x00000000
Jun 10 20:22:28 polb01 ACPI: PM-Timer IO Port: 0x4008
Jun 10 20:22:28 polb01 Built 1 zonelists
Jun 10 20:22:28 polb01 Local APIC disabled by BIOS -- reenabling.
Jun 10 20:22:28 polb01 Found and enabled local APIC!
Jun 10 20:22:28 polb01 Initializing CPU#0
Jun 10 20:22:28 polb01 Kernel command line: ro root=/dev/hdd4
Jun 10 20:22:28 polb01 PID hash table entries: 2048 (order 11: 16384 
bytes)
Jun 10 20:22:28 polb01 Detected 1001.762 MHz processor.
Jun 10 20:22:28 polb01 Using pmtmr for high-res timesource
Jun 10 20:22:28 polb01 Console: colour VGA+ 80x25
Jun 10 20:22:28 polb01 Memory: 514656k/524224k available (2878k kernel 
code, 8816k reserved, 789k data, 140k init, 0k highmem)
Jun 10 20:22:28 polb01 Checking if this processor honours the WP bit even 
in supervisor mode... Ok.
Jun 10 20:22:28 polb01 Calibrating delay loop... 1982.46 BogoMIPS
Jun 10 20:22:28 polb01 Security Scaffold v1.0.0 initialized
Jun 10 20:22:28 polb01 Dentry cache hash table entries: 65536 (order: 6, 
262144 bytes)
Jun 10 20:22:28 polb01 Inode-cache hash table entries: 32768 (order: 5, 
131072 bytes)
Jun 10 20:22:28 polb01 Mount-cache hash table entries: 512 (order: 0, 4096 
bytes)
Jun 10 20:22:28 polb01 CPU:     After generic identify, caps: 0183fbff 
c1c7fbff 00000000 00000000
Jun 10 20:22:28 polb01 CPU:     After vendor identify, caps: 0183fbff 
c1c7fbff 00000000 00000000
Jun 10 20:22:28 polb01 CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K 
(64 bytes/line)
Jun 10 20:22:28 polb01 CPU: L2 Cache: 256K (64 bytes/line)
Jun 10 20:22:28 polb01 CPU:     After all inits, caps: 0183fbf7 c1c7fbff 
00000000 00000020
Jun 10 20:22:28 polb01 Intel machine check architecture supported.
Jun 10 20:22:28 polb01 Intel machine check reporting enabled on CPU#0.
Jun 10 20:22:28 polb01 CPU: AMD Athlon(tm) processor stepping 02
Jun 10 20:22:28 polb01 Enabling fast FPU save and restore... done.
Jun 10 20:22:28 polb01 Checking 'hlt' instruction... OK.
Jun 10 20:22:28 polb01 enabled ExtINT on CPU#0
Jun 10 20:22:28 polb01 ESR value before enabling vector: 00000000
Jun 10 20:22:28 polb01 ESR value after enabling vector: 00000000
Jun 10 20:22:28 polb01 Using local APIC timer interrupts.
Jun 10 20:22:28 polb01 calibrating APIC timer ...
Jun 10 20:22:28 polb01 ..... CPU clock speed is 1001.0108 MHz.
Jun 10 20:22:28 polb01 ..... host bus clock speed is 266.0962 MHz.
Jun 10 20:22:28 polb01 NET: Registered protocol family 16
Jun 10 20:22:28 polb01 PCI: PCI BIOS revision 2.10 entry at 0xfb5e0, last 
bus=1
Jun 10 20:22:28 polb01 PCI: Using configuration type 1
Jun 10 20:22:28 polb01 mtrr: v2.0 (20020519)
Jun 10 20:22:28 polb01 ACPI: Subsystem revision 20040326
Jun 10 20:22:28 polb01 spurious 8259A interrupt: IRQ7.
Jun 10 20:22:28 polb01 ACPI: IRQ11 SCI: Level Trigger.
Jun 10 20:22:28 polb01 ACPI: Interpreter enabled
Jun 10 20:22:28 polb01 ACPI: Using PIC for interrupt routing
Jun 10 20:22:28 polb01 ACPI: PCI Root Bridge [PCI0] (00:00)
Jun 10 20:22:28 polb01 PCI: Probing PCI hardware (bus 00)
Jun 10 20:22:28 polb01 ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Jun 10 20:22:28 polb01 ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 
*10 11 12 14 15)
Jun 10 20:22:28 polb01 ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 *5 6 7 
10 11 12 14 15)
Jun 10 20:22:28 polb01 ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 
10 11 12 14 15) *9
Jun 10 20:22:28 polb01 ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 
10 *11 12 14 15)
Jun 10 20:22:28 polb01 PCI: Using ACPI for IRQ routing
Jun 10 20:22:28 polb01 ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
Jun 10 20:22:28 polb01 ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 11 
(level, low) -> IRQ 11
Jun 10 20:22:28 polb01 ACPI: PCI interrupt 0000:00:07.3[D] -> GSI 11 
(level, low) -> IRQ 11
Jun 10 20:22:28 polb01 ACPI: PCI interrupt 0000:00:08.0[A] -> GSI 11 
(level, low) -> IRQ 11
Jun 10 20:22:28 polb01 ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
Jun 10 20:22:28 polb01 ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 10 
(level, low) -> IRQ 10
Jun 10 20:22:28 polb01 ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 11 
(level, low) -> IRQ 11
Jun 10 20:22:28 polb01 ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
Jun 10 20:22:28 polb01 ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 5 
(level, low) -> IRQ 5
Jun 10 20:22:28 polb01 ACPI: PCI interrupt 0000:00:0d.1[A] -> GSI 5 
(level, low) -> IRQ 5
Jun 10 20:22:28 polb01 ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
Jun 10 20:22:28 polb01 ACPI: PCI interrupt 0000:01:05.0[A] -> GSI 10 
(level, low) -> IRQ 10
Jun 10 20:22:28 polb01 audit: initializing netlink socket (disabled)
Jun 10 20:22:28 polb01 audit(1086898862.790:0): initialized
Jun 10 20:22:28 polb01 Total HugeTLB memory allocated, 0
Jun 10 20:22:28 polb01 VFS: Disk quotas dquot_6.5.1
Jun 10 20:22:28 polb01 Dquot-cache hash table entries: 1024 (order 0, 4096 
bytes)
Jun 10 20:22:28 polb01 SGI XFS with ACLs, security attributes, realtime, 
no debug enabled
Jun 10 20:22:28 polb01 SGI XFS Quota Management subsystem
Jun 10 20:22:28 polb01 Initializing Cryptographic API
Jun 10 20:22:28 polb01 8139too Fast Ethernet driver 0.9.27
Jun 10 20:22:28 polb01 ACPI: PCI interrupt 0000:00:08.0[A] -> GSI 11 
(level, low) -> IRQ 11
Jun 10 20:22:28 polb01 eth0: RealTek RTL8139 at 0xe000, 00:06:4f:00:73:8b, 
IRQ 11
Jun 10 20:22:28 polb01 eth0:  Identified 8139 chip type 'RTL-8139C'
Jun 10 20:22:28 polb01 Uniform Multi-Platform E-IDE driver Revision: 
7.00alpha2
Jun 10 20:22:28 polb01 ide: Assuming 33MHz system bus speed for PIO modes; 
override with idebus=xx
Jun 10 20:22:28 polb01 VP_IDE: IDE controller at PCI slot 0000:00:07.1
Jun 10 20:22:28 polb01 VP_IDE: chipset revision 6
Jun 10 20:22:28 polb01 VP_IDE: not 100% native mode: will probe irqs later
Jun 10 20:22:28 polb01 VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 
controller on pci0000:00:07.1
Jun 10 20:22:28 polb01 ide0: BM-DMA at 0xd400-0xd407, BIOS settings: 
hda:DMA, hdb:DMA
Jun 10 20:22:28 polb01 ide1: BM-DMA at 0xd408-0xd40f, BIOS settings: 
hdc:DMA, hdd:DMA
Jun 10 20:22:28 polb01 hda: SAMSUNG SV6004H, ATA DISK drive
Jun 10 20:22:28 polb01 hdb: HL-DT-ST DVDRAM GSA-4082B, ATAPI CD/DVD-ROM 
drive
Jun 10 20:22:28 polb01 Using anticipatory io scheduler
Jun 10 20:22:28 polb01 ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jun 10 20:22:28 polb01 hdc: Pioneer DVD-ROM ATAPIModel DVD-115 0133, ATAPI 
CD/DVD-ROM drive
Jun 10 20:22:28 polb01 hdd: SAMSUNG SV3063H, ATA DISK drive
Jun 10 20:22:28 polb01 ide1 at 0x170-0x177,0x376 on irq 15
Jun 10 20:22:28 polb01 hda: max request size: 128KiB
Jun 10 20:22:28 polb01 hda: 117306000 sectors (60060 MB) w/468KiB Cache, 
CHS=65535/16/63, UDMA(100)
Jun 10 20:22:28 polb01 hda: cache flushes supported
Jun 10 20:22:28 polb01 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
Jun 10 20:22:28 polb01 hdd: max request size: 128KiB
Jun 10 20:22:28 polb01 hdd: 59797584 sectors (30616 MB) w/426KiB Cache, 
CHS=59323/16/63, UDMA(100)
Jun 10 20:22:28 polb01 hdd: cache flushes supported
Jun 10 20:22:28 polb01 hdd: hdd1 hdd2 hdd3 hdd4
Jun 10 20:22:28 polb01 mice: PS/2 mouse device common for all mice
Jun 10 20:22:28 polb01 serio: i8042 AUX port at 0x60,0x64 irq 12
Jun 10 20:22:28 polb01 serio: i8042 KBD port at 0x60,0x64 irq 1
Jun 10 20:22:28 polb01 input: AT Translated Set 2 keyboard on 
isa0060/serio0
Jun 10 20:22:28 polb01 NET: Registered protocol family 2
Jun 10 20:22:28 polb01 IP: routing cache hash table of 1024 buckets, 
32Kbytes
Jun 10 20:22:28 polb01 TCP: Hash tables configured (established 32768 bind 
9362)
Jun 10 20:22:28 polb01 ip_conntrack version 2.1 (4095 buckets, 32760 max) 
- 320 bytes per conntrack
Jun 10 20:22:28 polb01 ip_tables: (C) 2000-2002 Netfilter core team
Jun 10 20:22:28 polb01 ipt_recent v0.3.1: Stephen Frost 
<sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
Jun 10 20:22:28 polb01 arp_tables: (C) 2002 David S. Miller
Jun 10 20:22:28 polb01 NET: Registered protocol family 17
Jun 10 20:22:28 polb01 ACPI: (supports S0 S1 S4 S5)
Jun 10 20:22:28 polb01 kjournald starting.  Commit interval 5 seconds
Jun 10 20:22:28 polb01 EXT3-fs: hdd4: orphan cleanup on readonly fs
Jun 10 20:22:28 polb01 ext3_orphan_cleanup: deleting unreferenced inode 
1206476
Jun 10 20:22:28 polb01 EXT3-fs: hdd4: 1 orphan inode deleted
Jun 10 20:22:28 polb01 EXT3-fs: recovery complete.
Jun 10 20:22:28 polb01 EXT3-fs: mounted filesystem with ordered data mode.
Jun 10 20:22:28 polb01 VFS: Mounted root (ext3 filesystem) readonly.
Jun 10 20:22:28 polb01 Freeing unused kernel memory: 140k freed
Jun 10 20:22:28 polb01 NET: Registered protocol family 1
Jun 10 20:22:28 polb01 EXT3 FS on hdd4, internal journal
Jun 10 20:22:28 polb01 Capability LSM initialized
Jun 10 20:22:28 polb01 CSLIP: code copyright 1989 Regents of the 
University of California
Jun 10 20:22:28 polb01 PPP generic driver version 2.4.2
Jun 10 20:22:28 polb01 PPP Deflate Compression module registered
Jun 10 20:22:28 polb01 NET: Registered protocol family 8
Jun 10 20:22:28 polb01 NET: Registered protocol family 20
Jun 10 20:22:28 polb01 input: PS/2 Generic Mouse on isa0060/serio1
Jun 10 20:22:28 polb01 Unable to handle kernel paging request at virtual 
address c04b4b00
Jun 10 20:22:28 polb01 printing eip:
Jun 10 20:22:28 polb01 c03005eb
Jun 10 20:22:28 polb01 *pde = 004fd027
Jun 10 20:22:28 polb01 *pte = 004b4000
Jun 10 20:22:28 polb01 Oops: 0002 [#1]
Jun 10 20:22:28 polb01 PREEMPT DEBUG_PAGEALLOC
Jun 10 20:22:28 polb01 Modules linked in: ac psmouse pppoatm atm 
ppp_deflate zlib_deflate zlib_inflate ppp_generic slhc capability 
commoncap unix
Jun 10 20:22:28 polb01 CPU:    0
Jun 10 20:22:28 polb01 EIP:    0060:[<c03005eb>]    Not tainted VLI
Jun 10 20:22:28 polb01 EFLAGS: 00010246   (2.6.7-rc3-mm1)
Jun 10 20:22:28 polb01 EIP is at acpi_bus_register_driver+0xd3/0x173
Jun 10 20:22:28 polb01 eax: c04b4b00   ebx: e08e6180   ecx: 000001e1   
edx: ffffffed
Jun 10 20:22:28 polb01 esi: 00000000   edi: e08e62c0   ebp: de493f84   
esp: de493f7c
Jun 10 20:22:28 polb01 ds: 007b   es: 007b   ss: 0068
Jun 10 20:22:28 polb01 Process modprobe (pid: 4994, threadinfo=de492000 
task=df1b29f0)
Jun 10 20:22:28 polb01 Stack: c04229a0 de492000 de493f8c e08ec032 de493fbc 
c0140820 dde9bf4c def83790
Jun 10 20:22:28 polb01 ded2c070 de6e9d4c de6e9d6c 00000000 de493fbc 
4014c008 0805b168 40097cbb
Jun 10 20:22:28 polb01 de492000 c01057bd 4014c008 0002eca7 0805b168 
0805b168 40097cbb 0805b168
Jun 10 20:22:28 polb01 Call Trace:
Jun 10 20:22:28 polb01 [<c0105d8a>] show_stack+0x7a/0x90
Jun 10 20:22:28 polb01 [<c0105f0d>] show_registers+0x14d/0x1b0
Jun 10 20:22:28 polb01 [<c0106109>] die+0xf9/0x250
Jun 10 20:22:28 polb01 [<c0118563>] do_page_fault+0x1d3/0x55b
Jun 10 20:22:28 polb01 [<c0105a19>] error_code+0x2d/0x38
Jun 10 20:22:28 polb01 [<e08ec032>] init_module+0x32/0x51 [ac]
Jun 10 20:22:28 polb01 [<c0140820>] sys_init_module+0x1c0/0x390
Jun 10 20:22:28 polb01 [<c01057bd>] sysenter_past_esp+0x52/0x71
Jun 10 20:22:28 polb01
Jun 10 20:22:28 polb01 Code: 4c f9 42 c0 01 00 00 00 c7 05 58 f9 42 c0 57 
4c 40 c0 c7 05 5c f9 42 c0 59 01 00 00 89 1d cc f9 42 c0 c7 03 c8 f9 42 c0 
89 43 04 <89> 18 81 3d 48 f9 42 c0 3c 4b 24 1d 74 1c 68 48 f9 42 c0 68 5b
Jun 10 20:22:28 polb01 <6>note: modprobe[4994] exited with preempt_count 1
Jun 10 20:22:28 polb01 Debug: sleeping function called from invalid 
context at /usr/src/linux-2.6.7-rc3-mm1/include/linux/rwsem.h:43
Jun 10 20:22:28 polb01 in_atomic():1, irqs_disabled():0
Jun 10 20:22:28 polb01 [<c0105db7>] dump_stack+0x17/0x20
Jun 10 20:22:28 polb01 [<c011c994>] __might_sleep+0xb4/0xe0
Jun 10 20:22:28 polb01 [<c012421f>] do_exit+0xaf/0x980
Jun 10 20:22:28 polb01 [<c010625b>] die+0x24b/0x250
Jun 10 20:22:28 polb01 [<c0118563>] do_page_fault+0x1d3/0x55b
Jun 10 20:22:28 polb01 [<c0105a19>] error_code+0x2d/0x38
Jun 10 20:22:28 polb01 [<e08ec032>] init_module+0x32/0x51 [ac]
Jun 10 20:22:28 polb01 [<c0140820>] sys_init_module+0x1c0/0x390
Jun 10 20:22:28 polb01 [<c01057bd>] sysenter_past_esp+0x52/0x71
Jun 10 20:22:28 polb01
Jun 10 20:22:28 polb01 
/usr/src/linux-2.6.7-rc3-mm1/drivers/acpi/scan.c:345: 
spin_lock(/usr/src/linux-2.6.7-rc3-mm1/drivers/acpi/scan.c:c042f948) 
already locked by /usr/src/linux-2.6.7-rc3-mm1/drivers/acpi/scan.c/345
Jun 10 20:22:28 polb01 ACPI: Power Button (FF) [PWRF]
Jun 10 20:22:28 polb01 ACPI: Sleep Button (CM) [SLPB]
Jun 10 20:22:28 polb01 ACPI: Processor [CPU0] (supports C1, 2 throttling 
states)
Jun 10 20:22:28 polb01 input: PC Speaker
Jun 10 20:22:28 polb01 inserting floppy driver for 2.6.7-rc3-mm1
Jun 10 20:22:28 polb01 Floppy drive(s): fd0 is 1.44M
Jun 10 20:22:28 polb01 FDC 0 is a post-1991 82077
Jun 10 20:22:28 polb01 loop: loaded (max 8 devices)
Jun 10 20:22:28 polb01 Non-volatile memory driver v1.2
Jun 10 20:22:28 polb01 BIOS EDD facility v0.15 2004-May-17, 2 devices 
found
Jun 10 20:22:28 polb01 device-mapper: 4.1.0-ioctl (2003-12-10) 
initialised: dm@uk.sistina.com
Jun 10 20:22:28 polb01 kjournald starting.  Commit interval 5 seconds
Jun 10 20:22:28 polb01 EXT3 FS on hda5, internal journal
Jun 10 20:22:28 polb01 EXT3-fs: mounted filesystem with ordered data mode.
Jun 10 20:22:28 polb01 kjournald starting.  Commit interval 5 seconds
Jun 10 20:22:28 polb01 EXT3 FS on hda6, internal journal
Jun 10 20:22:28 polb01 EXT3-fs: mounted filesystem with ordered data mode.
Jun 10 20:22:28 polb01 NTFS driver 2.1.13 [Flags: R/O MODULE].
Jun 10 20:22:28 polb01 NTFS volume version 3.1.
Jun 10 20:22:28 polb01 usbcore: registered new driver usbfs
Jun 10 20:22:28 polb01 usbcore: registered new driver hub
Jun 10 20:22:28 polb01 Adding 786424k swap on /mnt/old/home/swap.img.  
Priority:-1 extents:2227
Jun 10 20:22:28 polb01 rtc: IRQ 0 is not free.
Jun 10 20:22:28 polb01 rtc: IRQ 0 is not free.
Jun 10 20:22:28 polb01 ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 10 
(level, low) -> IRQ 10
Jun 10 20:22:28 polb01 parport_pc: Strange, can't probe Via 686A parallel 
port: io=0x378, irq=-1, dma=-1
Jun 10 20:22:28 polb01 USB Universal Host Controller Interface driver v2.2
Jun 10 20:22:28 polb01 ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 11 
(level, low) -> IRQ 11
Jun 10 20:22:28 polb01 uhci_hcd 0000:00:07.2: UHCI Host Controller
Jun 10 20:22:28 polb01 uhci_hcd 0000:00:07.2: irq 11, io base 0000d800
Jun 10 20:22:28 polb01 uhci_hcd 0000:00:07.2: new USB bus registered, 
assigned bus number 1
Jun 10 20:22:28 polb01 hub 1-0:1.0: USB hub found
Jun 10 20:22:28 polb01 hub 1-0:1.0: 2 ports detected
Jun 10 20:22:28 polb01 ACPI: PCI interrupt 0000:00:07.3[D] -> GSI 11 
(level, low) -> IRQ 11
Jun 10 20:22:28 polb01 uhci_hcd 0000:00:07.3: UHCI Host Controller
Jun 10 20:22:28 polb01 uhci_hcd 0000:00:07.3: irq 11, io base 0000dc00
Jun 10 20:22:28 polb01 uhci_hcd 0000:00:07.3: new USB bus registered, 
assigned bus number 2
Jun 10 20:22:28 polb01 hub 2-0:1.0: USB hub found
Jun 10 20:22:28 polb01 hub 2-0:1.0: 2 ports detected
Jun 10 20:22:28 polb01 usb 1-1: new full speed USB device using address 2
Jun 10 20:22:28 polb01 usbcore: registered new driver speedtch
Jun 10 20:22:28 polb01 usb 1-2: new full speed USB device using address 3
Jun 10 20:22:28 polb01 gameport: pci0000:00:09.1 speed 1242 kHz
Jun 10 20:22:28 polb01 Linux video capture interface: v1.00
Jun 10 20:22:28 polb01 bttv: driver version 0.9.14 loaded
Jun 10 20:22:28 polb01 bttv: using 32 buffers with 2080k (520 pages) each 
for capture
Jun 10 20:22:28 polb01 bttv: Bt8xx card found (0).
Jun 10 20:22:28 polb01 ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 5 
(level, low) -> IRQ 5
Jun 10 20:22:28 polb01 bttv0: Bt878 (rev 17) at 0000:00:0d.0, irq: 5, 
latency: 32, mmio: 0xde01b000
Jun 10 20:22:28 polb01 bttv0: using: Prolink Pixelview PV-BT878P+ 
(Rev.4C,8E) [card=70,insmod option]
Jun 10 20:22:28 polb01 bttv0: gpio: en=00000000, out=00000000 in=00ffc0ff 
[init]
Jun 10 20:22:28 polb01 bttv0: using tuner=25
Jun 10 20:22:28 polb01 bttv0: i2c: checking for MSP34xx @ 0x80... not 
found
Jun 10 20:22:28 polb01 bttv0: i2c: checking for TDA9875 @ 0xb0... not 
found
Jun 10 20:22:28 polb01 bttv0: i2c: checking for TDA7432 @ 0x8a... not 
found
Jun 10 20:22:28 polb01 tvaudio: TV audio decoder + audio/video mux driver
Jun 10 20:22:28 polb01 tvaudio: known chips: 
tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54 
(PV951),ta8874z
Jun 10 20:22:28 polb01 tuner: chip found at addr 0xc2 i2c-bus bt878 #0 
[sw]
Jun 10 20:22:28 polb01 tuner: type set to 25 (LG PAL_I+FM (TAPC-I001D)) by 
bt878 #0 [sw]
Jun 10 20:22:28 polb01 bttv0: registered device video0
Jun 10 20:22:28 polb01 bttv0: registered device vbi0
Jun 10 20:22:28 polb01 bttv0: registered device radio0
Jun 10 20:22:28 polb01 bttv0: PLL: 28636363 => 35468950 .. ok
Jun 10 20:22:28 polb01 bttv0: add subdevice "remote0"
Jun 10 20:22:28 polb01 ACPI: PCI interrupt 0000:00:0d.1[A] -> GSI 5 
(level, low) -> IRQ 5
Jun 10 20:22:28 polb01 usb 1-1: usbfs: interface 1 claimed while 
'modem_run' sets config #1
Jun 10 20:22:28 polb01 usb 1-1: usbfs: interface 2 claimed while 
'modem_run' sets config #1
Jun 10 20:22:28 polb01 eth0: link down
Jun 10 20:22:28 polb01 usb 1-1: usbfs: interface 0 claimed while 
'modem_run' sets config #1
Jun 10 20:22:28 polb01 usb 1-1: usbfs: interface 1 claimed while 
'modem_run' sets config #1
Jun 10 20:22:28 polb01 usb 1-1: usbfs: interface 2 claimed while 
'modem_run' sets config #1
Jun 10 20:22:28 polb01 NET: Registered protocol family 10
Jun 10 20:22:28 polb01 Disabled Privacy Extensions on device c0434480(lo)
Jun 10 20:22:28 polb01 IPv6 over IPv4 tunneling driver


And my config:

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_KERNEL_IMAGE_BZIMAGE=y
# CONFIG_KERNEL_IMAGE_ZIMAGE is not set
# CONFIG_KERNEL_IMAGE_VMLINUX is not set
CONFIG_KERNEL_IMAGE="arch/i386/boot/bzImage"
 
#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_STANDALONE=y
# CONFIG_M68K_TOOLCHAIN is not set
CONFIG_BROKEN_ON_SMP=y
 
#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_SYSCTL=y
CONFIG_AUDIT=y
CONFIG_AUDITSYSCALL=y
CONFIG_LOG_BUF_SHIFT=17
CONFIG_HOTPLUG=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 
#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
 
#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
CONFIG_HPET_TIMER=y
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
# CONFIG_X86_UP_IOAPIC is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=m
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
 
#
# Firmware Drivers
#
CONFIG_EDD=m
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_HAVE_DEC_LOCK=y
CONFIG_REGPARM=y
 
#
# Performance-monitoring counters support
#
CONFIG_PERFCTR=y
# CONFIG_PERFCTR_INIT_TESTS is not set
CONFIG_PERFCTR_VIRTUAL=y
 
#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_SOFTWARE_SUSPEND is not set
# CONFIG_PM_DISK is not set
 
#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y
 
#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set
 
#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set
 
#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCI_LEGACY_PROC is not set
# CONFIG_PCI_NAMES is not set
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
 
#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set
 
#
# PCI Hotplug Support
#
CONFIG_HOTPLUG_PCI=m
CONFIG_HOTPLUG_PCI_FAKE=m
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
# CONFIG_HOTPLUG_PCI_ACPI is not set
# CONFIG_HOTPLUG_PCI_CPCI is not set
# CONFIG_HOTPLUG_PCI_PCIE is not set
# CONFIG_HOTPLUG_PCI_SHPC is not set
 
#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_MISC=m
 
#
# Device Drivers
#
 
#
# Generic Driver Options
#
CONFIG_FW_LOADER=m
# CONFIG_DEBUG_DRIVER is not set
 
#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set
 
#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_OTHER is not set
# CONFIG_PARPORT_1284 is not set
 
#
# Plug and Play support
#
 
#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_CARMEL is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_LBD is not set
 
#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
 
#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_IDE_TASKFILE_IO=y
 
#
# IDE chipset support/bugfixes
#
# CONFIG_IDE_GENERIC is not set
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set
 
#
# SCSI device support
#
# CONFIG_SCSI is not set
 
#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
# CONFIG_MD_RAID5 is not set
# CONFIG_MD_RAID6 is not set
# CONFIG_MD_MULTIPATH is not set
CONFIG_BLK_DEV_DM=m
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_MIRROR=m
CONFIG_DM_ZERO=m
 
#
# Fusion MPT device support
#
 
#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set
 
#
# I2O device support
#
CONFIG_I2O=m
CONFIG_I2O_CONFIG=m
CONFIG_I2O_BLOCK=m
CONFIG_I2O_PROC=m
 
#
# Networking support
#
CONFIG_NET=y
 
#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
CONFIG_NETLINK_DEV=m
CONFIG_UNIX=m
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_NAT=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_TOS=y
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
# CONFIG_IP_MROUTE is not set
CONFIG_ARPD=y
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m
 
#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
CONFIG_IPV6=m
CONFIG_IPV6_PRIVACY=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_TUNNEL=m
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
 
#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=y
# CONFIG_IP_NF_FTP is not set
# CONFIG_IP_NF_IRC is not set
# CONFIG_IP_NF_TFTP is not set
# CONFIG_IP_NF_AMANDA is not set
CONFIG_IP_NF_QUEUE=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=y
CONFIG_IP_NF_MATCH_IPRANGE=y
CONFIG_IP_NF_MATCH_MAC=y
CONFIG_IP_NF_MATCH_PKTTYPE=y
CONFIG_IP_NF_MATCH_MARK=y
CONFIG_IP_NF_MATCH_MULTIPORT=y
CONFIG_IP_NF_MATCH_TOS=y
CONFIG_IP_NF_MATCH_RECENT=y
CONFIG_IP_NF_MATCH_ECN=y
CONFIG_IP_NF_MATCH_DSCP=y
CONFIG_IP_NF_MATCH_AH_ESP=y
CONFIG_IP_NF_MATCH_LENGTH=y
CONFIG_IP_NF_MATCH_TTL=y
CONFIG_IP_NF_MATCH_TCPMSS=y
CONFIG_IP_NF_MATCH_HELPER=y
CONFIG_IP_NF_MATCH_STATE=y
CONFIG_IP_NF_MATCH_CONNTRACK=y
CONFIG_IP_NF_MATCH_OWNER=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_TARGET_REDIRECT=y
CONFIG_IP_NF_TARGET_NETMAP=y
CONFIG_IP_NF_TARGET_SAME=y
# CONFIG_IP_NF_NAT_LOCAL is not set
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_MANGLE=y
CONFIG_IP_NF_TARGET_TOS=y
CONFIG_IP_NF_TARGET_ECN=y
CONFIG_IP_NF_TARGET_DSCP=y
CONFIG_IP_NF_TARGET_MARK=y
CONFIG_IP_NF_TARGET_CLASSIFY=y
CONFIG_IP_NF_TARGET_LOG=y
CONFIG_IP_NF_TARGET_ULOG=y
CONFIG_IP_NF_TARGET_TCPMSS=y
CONFIG_IP_NF_ARPTABLES=y
CONFIG_IP_NF_ARPFILTER=y
CONFIG_IP_NF_ARP_MANGLE=y
# CONFIG_IP_NF_RAW is not set
 
#
# IPv6: Netfilter Configuration
#
# CONFIG_IP6_NF_QUEUE is not set
# CONFIG_IP6_NF_IPTABLES is not set
CONFIG_XFRM=y
CONFIG_XFRM_USER=m
 
#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_MSG is not set
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_HMAC_NONE is not set
CONFIG_SCTP_HMAC_SHA1=y
# CONFIG_SCTP_HMAC_MD5 is not set
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
# CONFIG_ATM_LANE is not set
# CONFIG_ATM_BR2684 is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set
 
#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_CSZ=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_DELAY=m
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_POLICE=y
 
#
# Network testing
#
CONFIG_NET_PKTGEN=m
# CONFIG_KGDBOE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NETPOLL_RX is not set
# CONFIG_NETPOLL_TRAP is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=m
CONFIG_ETHERTAP=m
 
#
# ARCnet devices
#
# CONFIG_ARCNET is not set
 
#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
 
#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
CONFIG_NET_PCI=y
CONFIG_PCNET32=m
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
CONFIG_NE2K_PCI=m
# CONFIG_8139CP is not set
CONFIG_8139TOO=y
CONFIG_8139TOO_PIO=y
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
 
#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
 
#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set
 
#
# Token Ring devices
#
# CONFIG_TR is not set
 
#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set
 
#
# Wan interfaces
#
# CONFIG_WAN is not set
 
#
# ATM drivers
#
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_FIRESTREAM is not set
# CONFIG_ATM_ZATM is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_AMBASSADOR is not set
# CONFIG_ATM_HORIZON is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E_MAYBE is not set
# CONFIG_ATM_HE is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
CONFIG_PPPOATM=m
# CONFIG_SLIP is not set
CONFIG_SHAPER=m
# CONFIG_NETCONSOLE is not set
 
#
# ISDN subsystem
#
# CONFIG_ISDN is not set
 
#
# Telephony Support
#
# CONFIG_PHONE is not set
 
#
# Input device support
#
CONFIG_INPUT=y
 
#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=m
# CONFIG_INPUT_EVBUG is not set
 
#
# Input I/O drivers
#
CONFIG_GAMEPORT=m
CONFIG_SOUND_GAMEPORT=m
# CONFIG_GAMEPORT_NS558 is not set
# CONFIG_GAMEPORT_L4 is not set
CONFIG_GAMEPORT_EMU10K1=m
# CONFIG_GAMEPORT_VORTEX is not set
# CONFIG_GAMEPORT_FM801 is not set
# CONFIG_GAMEPORT_CS461x is not set
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_RAW=m
 
#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_VSXXXAA is not set
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=m
# CONFIG_JOYSTICK_A3D is not set
# CONFIG_JOYSTICK_ADI is not set
# CONFIG_JOYSTICK_COBRA is not set
# CONFIG_JOYSTICK_GF2K is not set
# CONFIG_JOYSTICK_GRIP is not set
# CONFIG_JOYSTICK_GRIP_MP is not set
# CONFIG_JOYSTICK_GUILLEMOT is not set
# CONFIG_JOYSTICK_INTERACT is not set
# CONFIG_JOYSTICK_SIDEWINDER is not set
# CONFIG_JOYSTICK_TMDC is not set
# CONFIG_JOYSTICK_IFORCE is not set
# CONFIG_JOYSTICK_WARRIOR is not set
# CONFIG_JOYSTICK_MAGELLAN is not set
# CONFIG_JOYSTICK_SPACEORB is not set
# CONFIG_JOYSTICK_SPACEBALL is not set
# CONFIG_JOYSTICK_STINGER is not set
# CONFIG_JOYSTICK_TWIDDLER is not set
# CONFIG_JOYSTICK_DB9 is not set
# CONFIG_JOYSTICK_GAMECON is not set
# CONFIG_JOYSTICK_TURBOGRAFX is not set
CONFIG_INPUT_JOYDUMP=m
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=m
CONFIG_INPUT_UINPUT=m
 
#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set
 
#
# Serial drivers
#
CONFIG_SERIAL_8250=m
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
 
#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=m
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_PRINTER=m
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=m
# CONFIG_TIPAR is not set
# CONFIG_QIC02_TAPE is not set
 
#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set
 
#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
CONFIG_HW_RANDOM=m
CONFIG_NVRAM=m
CONFIG_RTC=m
# CONFIG_GEN_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set
 
#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HPET=y
CONFIG_HPET_RTC_IRQ=y
CONFIG_HPET_NOMMAP=y
# CONFIG_HANGCHECK_TIMER is not set
 
#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_CHARDEV=m
 
#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=m
# CONFIG_I2C_ALGOPCF is not set
 
#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
CONFIG_I2C_ISA=m
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
CONFIG_I2C_VIAPRO=m
# CONFIG_I2C_VOODOO3 is not set
 
#
# Hardware Sensors Chip support
#
CONFIG_I2C_SENSOR=m
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_FSCHER is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_MAX1619 is not set
CONFIG_SENSORS_VIA686A=m
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83627HF is not set
 
#
# Other I2C Chip support
#
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_RTC8564 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set
 
#
# Misc devices
#
# CONFIG_IBM_ASM is not set
 
#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m
 
#
# Video For Linux
#
 
#
# Video Adapters
#
CONFIG_VIDEO_BT848=m
# CONFIG_VIDEO_BWQCAM is not set
# CONFIG_VIDEO_CQCAM is not set
# CONFIG_VIDEO_CPIA is not set
# CONFIG_VIDEO_SAA5246A is not set
# CONFIG_VIDEO_SAA5249 is not set
# CONFIG_TUNER_3036 is not set
# CONFIG_VIDEO_STRADIS is not set
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_VIDEO_SAA7134 is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DPC is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_CX88 is not set
 
#
# Radio Adapters
#
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set
 
#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEO_BUF=m
CONFIG_VIDEO_BTCX=m
CONFIG_VIDEO_IR=m
 
#
# Graphics support
#
# CONFIG_FB is not set
# CONFIG_VIDEO_SELECT is not set
 
#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
 
#
# Sound
#
CONFIG_SOUND=m
 
#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
CONFIG_SND_VERBOSE_PRINTK=y
# CONFIG_SND_DEBUG is not set
 
#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set
 
#
# PCI devices
#
CONFIG_SND_AC97_CODEC=m
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
CONFIG_SND_BT87X=m
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
CONFIG_SND_EMU10K1=m
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VX222 is not set
 
#
# ALSA USB devices
#
# CONFIG_SND_USB_AUDIO is not set
 
#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set
 
#
# USB support
#
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set
 
#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
CONFIG_USB_DYNAMIC_MINORS=y
 
#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=m
 
#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_STORAGE is not set
 
#
# USB Human Interface Devices (HID)
#
# CONFIG_USB_HID is not set
 
#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_MTOUCH is not set
# CONFIG_USB_EGALAX is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set
 
#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
 
#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set
# CONFIG_USB_VICAM is not set
# CONFIG_USB_DSBR is not set
# CONFIG_USB_IBMCAM is not set
# CONFIG_USB_KONICAWC is not set
# CONFIG_USB_OV511 is not set
# CONFIG_USB_PWC is not set
# CONFIG_USB_SE401 is not set
# CONFIG_USB_STV680 is not set
# CONFIG_USB_W9968CF is not set
 
#
# USB Network adaptors
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
 
#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
 
#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set
 
#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYTHERM is not set
CONFIG_USB_SPEEDTOUCH=m
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_TEST is not set
 
#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set
 
#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
CONFIG_REISERFS_FS_SECURITY=y
CONFIG_JFS_FS=y
CONFIG_JFS_POSIX_ACL=y
# CONFIG_JFS_DEBUG is not set
CONFIG_JFS_STATISTICS=y
CONFIG_FS_POSIX_ACL=y
CONFIG_XFS_FS=y
CONFIG_XFS_RT=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_SECURITY=y
CONFIG_XFS_POSIX_ACL=y
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_QUOTA=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=m
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
 
#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_UDF_FS=m
 
#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set
 
#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_RAMFS=y
 
#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
 
#
# Network File Systems
#
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_EXPORTFS is not set
# CONFIG_SMB_FS is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS=y
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
 
#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
CONFIG_LDM_PARTITION=y
# CONFIG_LDM_DEBUG is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_EFI_PARTITION is not set
 
#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-2"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=y
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=y
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=y
 
#
# Profiling support
#
# CONFIG_PROFILING is not set
 
#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_EARLY_PRINTK=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_DEBUG_SLAB=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_PAGEALLOC=y
CONFIG_SPINLINE=y
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
# CONFIG_KGDB is not set
CONFIG_FRAME_POINTER=y
# CONFIG_4KSTACKS is not set
CONFIG_SCHEDSTATS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
 
#
# Security options
#
CONFIG_SECURITY=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_CAPABILITIES=m
# CONFIG_SECURITY_ROOTPLUG is not set
# CONFIG_SECURITY_SELINUX is not set
 
#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_CRC32C=m
# CONFIG_CRYPTO_TEST is not set
 
#
# Library routines
#
CONFIG_CRC32=y
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y


and compilation error:

  CC      drivers/perfctr/x86.o
/usr/src/linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c: In function 
`finalise_backpatching':
/usr/src/linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c:1137: error: syntax 
error before '{' token
/usr/src/linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c:1133: warning: unused 
variable `cache'
/usr/src/linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c:1134: warning: unused 
variable `state'
/usr/src/linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c: At top level:
/usr/src/linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c:1138: warning: type 
defaults to `int' in declaration of `clear_perfctr_cpus_forbidden_mask'
/usr/src/linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c:1138: warning: function 
declaration isn't a prototype
/usr/src/linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c:1138: error: 
conflicting types for `clear_perfctr_cpus_forbidden_mask'
/usr/src/linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c:1117: error: previous 
declaration of `clear_perfctr_cpus_forbidden_mask'
/usr/src/linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c:1138: warning: data 
definition has no type or storage class
/usr/src/linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c:1140: warning: type 
defaults to `int' in declaration of `cache'
/usr/src/linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c:1140: warning: 
initialization makes integer from pointer without a cast
/usr/src/linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c:1140: warning: data 
definition has no type or storage class
/usr/src/linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c:1141: error: syntax 
error before numeric constant
/usr/src/linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c:1142: error: syntax 
error before numeric constant
/usr/src/linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c:1147: error: syntax 
error before '&' token
/usr/src/linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c:1147: warning: type 
defaults to `int' in declaration of `perfctr_cpu_sample'
/usr/src/linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c:1147: warning: function 
declaration isn't a prototype
/usr/src/linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c:1147: error: 
conflicting types for `perfctr_cpu_sample'
/usr/src/linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c:1087: error: previous 
declaration of `perfctr_cpu_sample'
/usr/src/linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c:1147: warning: data 
definition has no type or storage class
/usr/src/linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c:1148: error: syntax 
error before '&' token
/usr/src/linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c:1148: warning: type 
defaults to `int' in declaration of `perfctr_cpu_resume'
/usr/src/linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c:1148: warning: function 
declaration isn't a prototype
/usr/src/linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c:1148: error: 
conflicting types for `perfctr_cpu_resume'
/usr/src/linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c:1066: error: previous 
declaration of `perfctr_cpu_resume'
/usr/src/linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c:1148: warning: data 
definition has no type or storage class
/usr/src/linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c:1149: error: syntax 
error before '&' token
/usr/src/linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c:1149: warning: type 
defaults to `int' in declaration of `perfctr_cpu_suspend'
/usr/src/linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c:1149: warning: function 
declaration isn't a prototype
/usr/src/linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c:1149: error: 
conflicting types for `perfctr_cpu_suspend'
/usr/src/linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c:1049: error: previous 
declaration of `perfctr_cpu_suspend'
/usr/src/linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c:1149: warning: data 
definition has no type or storage class
/usr/src/linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c:1151: warning: type 
defaults to `int' in declaration of `set_perfctr_cpus_forbidden_mask'
/usr/src/linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c:1151: warning: 
parameter names (without types) in function declaration
/usr/src/linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c:1151: error: 
conflicting types for `set_perfctr_cpus_forbidden_mask'
/usr/src/linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c:1124: error: previous 
declaration of `set_perfctr_cpus_forbidden_mask'
/usr/src/linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c:1151: warning: data 
definition has no type or storage class
/usr/src/linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c:1153: warning: type 
defaults to `int' in declaration of `redirect_call_disable'
/usr/src/linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c:1153: error: 
conflicting declarations of `redirect_call_disable'
/usr/src/linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c:908: error: 
`redirect_call_disable' previously declared here
/usr/src/linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c:1153: warning: data 
definition has no type or storage class
/usr/src/linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c:1154: error: syntax 
error before '}' token
{standard input}: Assembler messages:
{standard input}:2776: Error: symbol `redirect_call_disable' is already 
defined
{standard input}:2776: Warning: rest of line ignored; first ignored 
character is `,'


Could somebody help me?


Thanks,

Grzegorz Kulewski

