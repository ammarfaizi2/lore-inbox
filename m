Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbUBDAwq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 19:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263777AbUBDAwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 19:52:46 -0500
Received: from fmr06.intel.com ([134.134.136.7]:15592 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261605AbUBDAw0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 19:52:26 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Bug in mm series
Date: Wed, 4 Feb 2004 08:51:27 +0800
Message-ID: <571ACEFD467F7749BC50E0A98C17CDD8D5FECE@PDSMSX403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Bug in mm series
Thread-Index: AcPqRIgj8dxLnB0pQq2W9n28gjL50QAc5k2A
From: "Li, Shaohua" <shaohua.li@intel.com>
To: =?gb2312?B?THVpcyBNaWd1ZWwgR2FyY6iqYQ==?= <ktech@wanadoo.es>
Cc: "LINUX KERNEL MAILING LIST" <linux-kernel@vger.kernel.org>,
       <akpm@digeo.com>
X-OriginalArrivalTime: 04 Feb 2004 00:51:28.0534 (UTC) FILETIME=[05E66360:01C3EAB9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Is this really an ACPI error? I noticed below message:
>IOAPIC[0]: Invalid reference to IRQ 0
> number of IO-APIC #2 registers: 0
It sounds like IOAPIC can't be initialized correctly. 

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Luis Miguel Garc¨ªa
> Sent: 2004Äê2ÔÂ3ÈÕ 18:53
> To: LINUX KERNEL MAILING LIST; akpm@digeo.com
> Subject: Bug in mm series
> 
> When I try to boot with latest mm series (such as actual rc3-mm1 or
> rc2-mm2), my nforce ethernet device doesn't works. It worked in the past
> with the forcedeth reverse engineered driver but now it keeps for 30 or
> more seconds halted (at boot) and then the network device dosn't run.
> 
> Here is the dmesg of rc3-mm1. Do you want for me to test something? Thanks!
> 
> P.S.:   The ACPI related messages are larger that in rc3.
> 
> P.S.2: If you can, CC me because i'm not subscribed to lkml.
> 
> 
> cted 1830.250 MHz processor.
> Using tsc for high-res timesource
> Console: colour VGA+ 80x25
> Memory: 904752k/917504k available (1793k kernel code, 12008k reserved,
> 775k data, 132k init, 0k highmem)
> Calibrating delay loop... 3612.67 BogoMIPS
> Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> CPU:     After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
> CPU:     After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 512K (64 bytes/line)
> CPU:     After all inits, caps: 0383fbff c1c3fbff 00000000 00000020
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> CPU: AMD Athlon(tm) XP 2500+ stepping 00
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
> POSIX conformance testing by UNIFIX
> enabled ExtINT on CPU#0
> ESR value before enabling vector: 00000000
> ESR value after enabling vector: 00000000
> Using local APIC timer interrupts.
> calibrating APIC timer ...
> ..... CPU clock speed is 1829.0785 MHz.
> ..... host bus clock speed is 332.0688 MHz.
> NET: Registered protocol family 16
> PCI: PCI BIOS revision 2.10 entry at 0xfb420, last bus=2
> PCI: Using configuration type 1
> mtrr: v2.0 (20020519)
> ACPI: Subsystem revision 20040116
> IOAPIC[0]: Invalid reference to IRQ 0
> spurious 8259A interrupt: IRQ7.
> ACPI: Interpreter enabled
> ACPI: Using IOAPIC for interrupt routing
> ACPI: PCI Root Bridge [PCI0] (00:00)
> PCI: Probing PCI hardware (bus 00)
> PCI: disabling nForce2 Halt Disconnect and Stop Grant Disconnect
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
> ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 *5 6 7 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 *10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 *5 6 7 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
> ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 10 *11 12 14 15)
> ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 10 *11 12 14 15)
> ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 7 *10 11 12 14 15)
> ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
> ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 10 *11 12 14 15)
> ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 *5 6 7 10 11 12 14 15)
> ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15)
> ACPI: PCI Interrupt Link [APC1] (IRQs *16)
> ACPI: PCI Interrupt Link [APC2] (IRQs 17)
> ACPI: PCI Interrupt Link [APC3] (IRQs 18)
> ACPI: PCI Interrupt Link [APC4] (IRQs *19)
> ACPI: PCI Interrupt Link [APCE] (IRQs 16)
> ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22)
> ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22)
> ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22)
> ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22)
> ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22)
> ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22)
> ACPI: PCI Interrupt Link [APCS] (IRQs *23)
> ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22)
> ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22)
> ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22)
> ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22)
> ACPI: PCI Interrupt Link [APCS] enabled at IRQ 23
> IOAPIC[0]: Set PCI routing entry (2-23 -> 0x39 -> IRQ 23 Mode:1 Active:0)
> 00:00:01[A] -> 2-23 -> IRQ 23
> Pin 2-23 already programmed
> ACPI: PCI Interrupt Link [APCF] enabled at IRQ 20
> IOAPIC[0]: Set PCI routing entry (2-20 -> 0x41 -> IRQ 20 Mode:1 Active:0)
> 00:00:02[A] -> 2-20 -> IRQ 20
> ACPI: PCI Interrupt Link [APCG] enabled at IRQ 22
> IOAPIC[0]: Set PCI routing entry (2-22 -> 0x49 -> IRQ 22 Mode:1 Active:0)
> 00:00:02[B] -> 2-22 -> IRQ 22
> ACPI: PCI Interrupt Link [APCL] enabled at IRQ 21
> IOAPIC[0]: Set PCI routing entry (2-21 -> 0x51 -> IRQ 21 Mode:1 Active:0)
> 00:00:02[C] -> 2-21 -> IRQ 21
> ACPI: PCI Interrupt Link [APCH] enabled at IRQ 20
> Pin 2-20 already programmed
> ACPI: PCI Interrupt Link [APCI] enabled at IRQ 22
> Pin 2-22 already programmed
> ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 21
> Pin 2-21 already programmed
> ACPI: PCI Interrupt Link [APCK] enabled at IRQ 20
> Pin 2-20 already programmed
> ACPI: PCI Interrupt Link [APCM] enabled at IRQ 22
> Pin 2-22 already programmed
> ACPI: PCI Interrupt Link [AP3C] enabled at IRQ 21
> Pin 2-21 already programmed
> ACPI: PCI Interrupt Link [APCZ] enabled at IRQ 20
> Pin 2-20 already programmed
> ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
> IOAPIC[0]: Set PCI routing entry (2-18 -> 0x59 -> IRQ 18 Mode:1 Active:0)
> 00:01:06[A] -> 2-18 -> IRQ 18
> ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
> IOAPIC[0]: Set PCI routing entry (2-19 -> 0x61 -> IRQ 19 Mode:1 Active:0)
> 00:01:06[B] -> 2-19 -> IRQ 19
> ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
> IOAPIC[0]: Set PCI routing entry (2-16 -> 0x69 -> IRQ 16 Mode:1 Active:0)
> 00:01:06[C] -> 2-16 -> IRQ 16
> ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
> IOAPIC[0]: Set PCI routing entry (2-17 -> 0x71 -> IRQ 17 Mode:1 Active:0)
> 00:01:06[D] -> 2-17 -> IRQ 17
> Pin 2-19 already programmed
> Pin 2-16 already programmed
> Pin 2-17 already programmed
> Pin 2-18 already programmed
> Pin 2-16 already programmed
> Pin 2-17 already programmed
> Pin 2-18 already programmed
> Pin 2-19 already programmed
> Pin 2-17 already programmed
> Pin 2-18 already programmed
> Pin 2-19 already programmed
> Pin 2-16 already programmed
> Pin 2-18 already programmed
> Pin 2-19 already programmed
> Pin 2-16 already programmed
> Pin 2-17 already programmed
> Pin 2-18 already programmed
> Pin 2-18 already programmed
> Pin 2-18 already programmed
> Pin 2-18 already programmed
> Pin 2-19 already programmed
> number of MP IRQ sources: 16.
> number of IO-APIC #2 registers: 0.
> testing the IO APIC.......................
> IO APIC #2......
> .... register #00: 00018971
> .......    : physical APIC id: 00
> .......    : Delivery Type: 1
> .......    : LTS          : 0
> .... register #01: 00018971
> .......     : max redirection entries: 0001
> .......     : PRQ implemented: 1
> .......     : IO APIC version: 0071
> .... IRQ redirection table:
>  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
>  00 000 00  1    1    0   0   0    1    1    71
>  01 000 00  1    1    0   0   0    1    1    71
> IRQ to pin mappings:
> IRQ0 -> 0:0
> IRQ1 -> 0:0
> IRQ2 -> 0:0
> IRQ3 -> 0:0
> IRQ4 -> 0:0
> IRQ5 -> 0:0
> IRQ6 -> 0:0
> IRQ7 -> 0:0
> IRQ8 -> 0:0
> IRQ9 -> 0:0
> IRQ10 -> 0:0
> IRQ11 -> 0:0
> IRQ12 -> 0:0
> IRQ13 -> 0:0
> IRQ14 -> 0:0
> IRQ15 -> 0:0
> IRQ16 -> 0:0-> 0:16
> IRQ17 -> 0:0-> 0:17
> IRQ18 -> 0:0-> 0:18
> IRQ19 -> 0:0-> 0:19
> IRQ20 -> 0:0-> 0:20
> IRQ21 -> 0:0-> 0:21
> IRQ22 -> 0:0-> 0:22
> IRQ23 -> 0:0-> 0:23
> IRQ24 -> 0:0
> IRQ25 -> 0:0
> IRQ26 -> 0:0
> IRQ27 -> 0:0
> IRQ28 -> 0:0
> IRQ29 -> 0:0
> IRQ30 -> 0:0
> IRQ31 -> 0:0
> IRQ32 -> 0:0
> IRQ33 -> 0:0
> IRQ34 -> 0:0
> IRQ35 -> 0:0
> IRQ36 -> 0:0
> IRQ37 -> 0:0
> IRQ38 -> 0:0
> IRQ39 -> 0:0
> IRQ40 -> 0:0
> IRQ41 -> 0:0
> IRQ42 -> 0:0
> IRQ43 -> 0:0
> IRQ44 -> 0:0
> IRQ45 -> 0:0
> IRQ46 -> 0:0
> IRQ47 -> 0:0
> IRQ48 -> 0:0
> IRQ49 -> 0:0
> IRQ50 -> 0:0
> IRQ51 -> 0:0
> IRQ52 -> 0:0
> IRQ53 -> 0:0
> IRQ54 -> 0:0
> IRQ55 -> 0:0
> IRQ56 -> 0:0
> IRQ57 -> 0:0
> IRQ58 -> 0:0
> IRQ59 -> 0:0
> IRQ60 -> 0:0
> IRQ61 -> 0:0
> IRQ62 -> 0:0
> IRQ63 -> 0:0
> IRQ64 -> 0:0
> IRQ65 -> 0:0
> IRQ66 -> 0:0
> IRQ67 -> 0:0
> IRQ68 -> 0:0
> IRQ69 -> 0:0
> IRQ70 -> 0:0
> IRQ71 -> 0:0
> IRQ72 -> 0:0
> IRQ73 -> 0:0
> IRQ74 -> 0:0
> IRQ75 -> 0:0
> IRQ76 -> 0:0
> IRQ77 -> 0:0
> IRQ78 -> 0:0
> IRQ79 -> 0:0
> IRQ80 -> 0:0
> IRQ81 -> 0:0
> IRQ82 -> 0:0
> IRQ83 -> 0:0
> IRQ84 -> 0:0
> IRQ85 -> 0:0
> IRQ86 -> 0:0
> IRQ87 -> 0:0
> IRQ88 -> 0:0
> IRQ89 -> 0:0
> IRQ90 -> 0:0
> IRQ91 -> 0:0
> IRQ92 -> 0:0
> IRQ93 -> 0:0
> IRQ94 -> 0:0
> IRQ95 -> 0:0
> IRQ96 -> 0:0
> IRQ97 -> 0:0
> IRQ98 -> 0:0
> IRQ99 -> 0:0
> IRQ100 -> 0:0
> IRQ101 -> 0:0
> IRQ102 -> 0:0
> IRQ103 -> 0:0
> IRQ104 -> 0:0
> IRQ105 -> 0:0
> IRQ106 -> 0:0
> IRQ107 -> 0:0
> IRQ108 -> 0:0
> IRQ109 -> 0:0
> IRQ110 -> 0:0
> IRQ111 -> 0:0
> IRQ112 -> 0:0
> IRQ113 -> 0:0
> IRQ114 -> 0:0
> IRQ115 -> 0:0
> IRQ116 -> 0:0
> IRQ117 -> 0:0
> IRQ118 -> 0:0
> IRQ119 -> 0:0
> IRQ120 -> 0:0
> IRQ121 -> 0:0
> IRQ122 -> 0:0
> IRQ123 -> 0:0
> IRQ124 -> 0:0
> IRQ125 -> 0:0
> IRQ126 -> 0:0
> IRQ127 -> 0:0
> IRQ128 -> 0:0
> IRQ129 -> 0:0
> IRQ130 -> 0:0
> IRQ131 -> 0:0
> IRQ132 -> 0:0
> IRQ133 -> 0:0
> IRQ134 -> 0:0
> IRQ135 -> 0:0
> IRQ136 -> 0:0
> IRQ137 -> 0:0
> IRQ138 -> 0:0
> IRQ139 -> 0:0
> IRQ140 -> 0:0
> IRQ141 -> 0:0
> IRQ142 -> 0:0
> IRQ143 -> 0:0
> IRQ144 -> 0:0
> IRQ145 -> 0:0
> IRQ146 -> 0:0
> IRQ147 -> 0:0
> IRQ148 -> 0:0
> IRQ149 -> 0:0
> IRQ150 -> 0:0
> IRQ151 -> 0:0
> IRQ152 -> 0:0
> IRQ153 -> 0:0
> IRQ154 -> 0:0
> IRQ155 -> 0:0
> IRQ156 -> 0:0
> IRQ157 -> 0:0
> IRQ158 -> 0:0
> IRQ159 -> 0:0
> IRQ160 -> 0:0
> IRQ161 -> 0:0
> IRQ162 -> 0:0
> IRQ163 -> 0:0
> IRQ164 -> 0:0
> IRQ165 -> 0:0
> IRQ166 -> 0:0
> IRQ167 -> 0:0
> IRQ168 -> 0:0
> IRQ169 -> 0:0
> IRQ170 -> 0:0
> IRQ171 -> 0:0
> IRQ172 -> 0:0
> IRQ173 -> 0:0
> IRQ174 -> 0:0
> IRQ175 -> 0:0
> IRQ176 -> 0:0
> IRQ177 -> 0:0
> IRQ178 -> 0:0
> IRQ179 -> 0:0
> IRQ180 -> 0:0
> IRQ181 -> 0:0
> IRQ182 -> 0:0
> IRQ183 -> 0:0
> IRQ184 -> 0:0
> IRQ185 -> 0:0
> IRQ186 -> 0:0
> IRQ187 -> 0:0
> IRQ188 -> 0:0
> IRQ189 -> 0:0
> IRQ190 -> 0:0
> IRQ191 -> 0:0
> IRQ192 -> 0:0
> IRQ193 -> 0:0
> IRQ194 -> 0:0
> IRQ195 -> 0:0
> IRQ196 -> 0:0
> IRQ197 -> 0:0
> IRQ198 -> 0:0
> IRQ199 -> 0:0
> IRQ200 -> 0:0
> IRQ201 -> 0:0
> IRQ202 -> 0:0
> IRQ203 -> 0:0
> IRQ204 -> 0:0
> IRQ205 -> 0:0
> IRQ206 -> 0:0
> IRQ207 -> 0:0
> IRQ208 -> 0:0
> IRQ209 -> 0:0
> IRQ210 -> 0:0
> IRQ211 -> 0:0
> IRQ212 -> 0:0
> IRQ213 -> 0:0
> IRQ214 -> 0:0
> IRQ215 -> 0:0
> IRQ216 -> 0:0
> IRQ217 -> 0:0
> IRQ218 -> 0:0
> IRQ219 -> 0:0
> IRQ220 -> 0:0
> IRQ221 -> 0:0
> IRQ222 -> 0:0
> IRQ223 -> 0:0
> .................................... done.
> PCI: Using ACPI for IRQ routing
> PCI: if you experience problems, try using option 'pci=noacpi' or even
> 'acpi=off'
> devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
> devfs: boot_options: 0x0
> Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> ACPI: Power Button (FF) [PWRF]
> ACPI: Fan [FAN] (on)
> ACPI: Processor [CPU0] (supports C1)
> ACPI: Thermal Zone [THRM] (54 C)
> pty: 256 Unix98 ptys configured
> Real Time Clock Driver v1.12
> Using anticipatory io scheduler
> Floppy drive(s): fd0 is 1.44M
> FDC 0 is a post-1991 82077
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> NFORCE2: IDE controller at PCI slot 0000:00:09.0
> NFORCE2: chipset revision 162
> NFORCE2: not 100% native mode: will probe irqs later
> NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
>     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
> hda: ST380023A, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hdc: HL-DT-ST GCE-8520B, ATAPI CD/DVD-ROM drive
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: max request size: 128KiB
> hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63,
> UDMA(100)
>  /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 > p3 p4
> hdc: ATAPI 40X CD-ROM CD-R/RW CD-MRW drive, 2048kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.20
> mice: PS/2 mouse device common for all mice
> serio: i8042 AUX port at 0x60,0x64 irq 12
> input: ImExPS/2 Logitech Explorer Mouse on isa0060/serio1
> serio: i8042 KBD port at 0x60,0x64 irq 1
> input: AT Translated Set 2 keyboard on isa0060/serio0
> NET: Registered protocol family 2
> IP: routing cache hash table of 8192 buckets, 64Kbytes
> TCP: Hash tables configured (established 262144 bind 65536)
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> found reiserfs format "3.6" with standard journal
> Reiserfs journal params: device hda4, size 8192, journal first block 18,
> max trans len 1024, max batch 900, max commit age 30, max trans age 30
> reiserfs: checking transaction log (hda4) for (hda4)
> Using r5 hash to sort names
> VFS: Mounted root (reiserfs filesystem) readonly.
> Freeing unused kernel memory: 132k freed
> Adding 498004k swap on /dev/hda3.  Priority:-1 extents:1
> SCSI subsystem initialized
> forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.19.
> PCI: Setting latency timer of device 0000:00:04.0 to 64
> eth0: forcedeth.c: subsystem: 0147b:1c00 bound to 0000:00:04.0
> Linux agpgart interface v0.100 (c) Dave Jones
> agpgart: Detected NVIDIA nForce2 chipset
> agpgart: Maximum main memory to use for agp memory: 816M
> agpgart: AGP aperture is 128M @ 0xd0000000
> Linux video capture interface: v1.00
> bttv: driver version 0.9.12 loaded
> bttv: using 8 buffers with 2080k (520 pages) each for capture
> bttv: Bt8xx card found (0).
> bttv0: Bt878 (rev 2) at 0000:01:08.0, irq: 16, latency: 32, mmio:
> 0xd8000000
> bttv0: using: Prolink PixelView PlayTV pro [card=37,insmod option]
> bttv0: gpio: en=00000000, out=00000000 in=00ffffff [init]
> bttv0: using tuner=2
> bttv0: i2c: checking for TDA9875 @ 0xb0... not found
> bttv0: i2c: checking for TDA7432 @ 0x8a... not found
> tuner: chip found @ 0xc2
> tuner: type set to 2 (Philips NTSC (FI1236,FM1236 and compatibles))
> tuner: type forced to 2 (Philips NTSC (FI1236,FM1236 and compatibles))
> [insmod]
> tuner: type already set (2)
> bttv0: registered device video0
> bttv0: registered device vbi0
> bttv0: PLL: 28636363 => 35468950 .. ok
> drivers/usb/core/usb.c: registered new driver usbfs
> drivers/usb/core/usb.c: registered new driver hub
> PCI: Setting latency timer of device 0000:00:06.0 to 64
> intel8x0_measure_ac97_clock: measured 49329 usecs
> intel8x0: clocking to 48000
> ohci_hcd: 2003 Oct 13 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
> ohci_hcd: block sizes: ed 64 td 64
> ohci_hcd 0000:00:02.0: OHCI Host Controller
> PCI: Setting latency timer of device 0000:00:02.0 to 64
> ohci_hcd 0000:00:02.0: irq 20, pci mem f8a28000
> ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 3 ports detected
> ohci_hcd 0000:00:02.1: OHCI Host Controller
> PCI: Setting latency timer of device 0000:00:02.1 to 64
> ohci_hcd 0000:00:02.1: irq 22, pci mem f8a2a000
> ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 2
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 3 ports detected
> ehci_hcd 0000:00:02.2: EHCI Host Controller
> PCI: Setting latency timer of device 0000:00:02.2 to 64
> ehci_hcd 0000:00:02.2: irq 21, pci mem f8a2c000
> ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 3
> PCI: cache line size of 64 is not supported by device 0000:00:02.2
> ehci_hcd 0000:00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29
> hub 3-0:1.0: USB hub found
> hub 3-0:1.0: 6 ports detected
> hub 1-0:1.0: connect-debounce failed, port 1 disabled
> hub 1-0:1.0: new USB device on port 1, assigned address 2
> usb 1-1: control timeout on ep0out
> ohci_hcd 0000:00:02.0: Unlink after no-IRQ?  Different ACPI or APIC
> settings may help.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
