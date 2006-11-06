Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752584AbWKFLpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752584AbWKFLpF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 06:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752635AbWKFLpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 06:45:05 -0500
Received: from mail-ausfall.charite.de ([193.175.70.131]:52887 "EHLO
	mail-ausfall.charite.de") by vger.kernel.org with ESMTP
	id S1752584AbWKFLpC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 06:45:02 -0500
Date: Mon, 6 Nov 2006 12:44:53 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: swapper: page allocation failure. order:1, mode:0x20
Message-ID: <20061106114453.GL19180@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The complete dmesg output up to the page allocation failure:

[    0.000000] Linux version 2.6.18.2 (root@postamt.charite.de) (gcc version 4.0.4 20060507 (prerelease) (Debian 4.0.3-3)) #1 SMP Sat Nov 4 09:14:37 CET 2006
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
[    0.000000]  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000bfffa000 (usable)
[    0.000000]  BIOS-e820: 00000000bfffa000 - 00000000c0000000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
[    0.000000]  BIOS-e820: 00000000ffc00000 - 0000000100000000 (reserved)
[    0.000000] 2175MB HIGHMEM available.
[    0.000000] 896MB LOWMEM available.
[    0.000000] found SMP MP-table at 000f4fd0
[    0.000000] On node 0 totalpages: 786426
[    0.000000]   DMA zone: 4096 pages, LIFO batch:0
[    0.000000]   Normal zone: 225280 pages, LIFO batch:31
[    0.000000]   HighMem zone: 557050 pages, LIFO batch:31
[    0.000000] DMI 2.3 present.
[    0.000000] ACPI: RSDP (v000 COMPAQ                                ) @ 0x000f4f70
[    0.000000] ACPI: RSDT (v001 COMPAQ P31      0x00000002 “ 0x0000162e) @ 0xbfffa000
[    0.000000] ACPI: FADT (v001 COMPAQ P31      0x00000002 “ 0x0000162e) @ 0xbfffa040
[    0.000000] ACPI: MADT (v001 COMPAQ 00000083 0x00000002  0x00000000) @ 0xbfffa100
[    0.000000] ACPI: SPCR (v001 COMPAQ SPCRRBSU 0x00000001 “ 0x0000162e) @ 0xbfffa1c0
[    0.000000] ACPI: DSDT (v001 COMPAQ     DSDT 0x00000001 MSFT 0x0100000b) @ 0x00000000
[    0.000000] ACPI: PM-Timer IO Port: 0x920
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] Processor #0 15:2 APIC version 20
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x04] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x06] enabled)
[    0.000000] Processor #6 15:2 APIC version 20
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] Processor #1 15:2 APIC version 20
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x05] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x07] enabled)
[    0.000000] Processor #7 15:2 APIC version 20
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-15
[    0.000000] ACPI: IOAPIC (id[0x03] address[0xfec01000] gsi_base[16])
[    0.000000] IOAPIC[1]: apic_id 3, version 17, address 0xfec01000, GSI 16-31
[    0.000000] ACPI: IOAPIC (id[0x04] address[0xfec02000] gsi_base[32])
[    0.000000] IOAPIC[2]: apic_id 4, version 17, address 0xfec02000, GSI 32-47
[    0.000000] ACPI: IOAPIC (id[0x05] address[0xfec03000] gsi_base[48])
[    0.000000] IOAPIC[3]: apic_id 5, version 17, address 0xfec03000, GSI 48-63
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Enabling APIC mode:  Flat.  Using 4 I/O APICs
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at c4000000 (gap: c0000000:3ec00000)
[    0.000000] Detected 2799.465 MHz processor.
[   69.071851] Built 1 zonelists.  Total pages: 786426
[   69.071854] Kernel command line: auto BOOT_IMAGE=Linux ro root=6806 panic=15
[   69.072043] mapped APIC to ffffd000 (fee00000)
[   69.072046] mapped IOAPIC to ffffc000 (fec00000)
[   69.072048] mapped IOAPIC to ffffb000 (fec01000)
[   69.072051] mapped IOAPIC to ffffa000 (fec02000)
[   69.072053] mapped IOAPIC to ffff9000 (fec03000)
[   69.072056] Enabling fast FPU save and restore... done.
[   69.072059] Enabling unmasked SIMD FPU exception support... done.
[   69.072063] Initializing CPU#0
[   69.072139] CPU 0 irqstacks, hard=c129f000 soft=c12a3000
[   69.072142] PID hash table entries: 4096 (order: 12, 16384 bytes)
[   69.074165] Console: colour VGA+ 80x25
[   69.077848] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[   69.078508] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[   69.228569] Memory: 3116088k/3145704k available (1696k kernel code, 28516k reserved, 756k data, 192k init, 2228200k highmem)
[   69.228668] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[   69.307629] Calibrating delay using timer specific routine.. 5603.01 BogoMIPS (lpj=11206032)
[   69.307800] Mount-cache hash table entries: 512
[   69.307992] CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
[   69.308001] CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
[   69.308013] CPU: Trace cache: 12K uops, L1 D cache: 8K
[   69.308118] CPU: L2 cache: 512K
[   69.308179] CPU: Physical Processor ID: 0
[   69.308242] CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
[   69.308250] Intel machine check architecture supported.
[   69.308318] Intel machine check reporting enabled on CPU#0.
[   69.308384] CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
[   69.308452] CPU0: Thermal monitoring enabled
[   69.308531] Checking 'hlt' instruction... OK.
[   69.323772] Freeing SMP alternatives: 12k freed
[   69.323857] ACPI: Core revision 20060707
[   69.330060] CPU0: Intel(R) Xeon(TM) CPU 2.80GHz stepping 09
[   69.330225] Booting processor 1/1 eip 2000
[   69.330289] CPU 1 irqstacks, hard=c12a0000 soft=c12a4000
[   69.340583] Initializing CPU#1
[   69.419384] Calibrating delay using timer specific routine.. 5598.72 BogoMIPS (lpj=11197448)
[   69.419395] CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
[   69.419404] CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
[   69.419414] CPU: Trace cache: 12K uops, L1 D cache: 8K
[   69.419417] CPU: L2 cache: 512K
[   69.419419] CPU: Physical Processor ID: 0
[   69.419422] CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
[   69.419429] Intel machine check architecture supported.
[   69.419434] Intel machine check reporting enabled on CPU#1.
[   69.419437] CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
[   69.419441] CPU1: Thermal monitoring enabled
[   69.419602] CPU1: Intel(R) Xeon(TM) CPU 2.80GHz stepping 09
[   69.420555] Booting processor 2/6 eip 2000
[   69.420639] CPU 2 irqstacks, hard=c12a1000 soft=c12a5000
[   69.430955] Initializing CPU#2
[   69.511183] Calibrating delay using timer specific routine.. 5598.82 BogoMIPS (lpj=11197652)
[   69.511192] CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
[   69.511199] CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
[   69.511207] CPU: Trace cache: 12K uops, L1 D cache: 8K
[   69.511210] CPU: L2 cache: 512K
[   69.511212] CPU: Physical Processor ID: 3
[   69.511214] CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
[   69.511219] Intel machine check architecture supported.
[   69.511225] Intel machine check reporting enabled on CPU#2.
[   69.511227] CPU2: Intel P4/Xeon Extended MCE MSRs (12) available
[   69.511230] CPU2: Thermal monitoring enabled
[   69.511370] CPU2: Intel(R) Xeon(TM) CPU 2.80GHz stepping 09
[   69.512111] Booting processor 3/7 eip 2000
[   69.512176] CPU 3 irqstacks, hard=c12a2000 soft=c12a6000
[   69.522407] Initializing CPU#3
[   69.602982] Calibrating delay using timer specific routine.. 5598.95 BogoMIPS (lpj=11197912)
[   69.602993] CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
[   69.603002] CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
[   69.603012] CPU: Trace cache: 12K uops, L1 D cache: 8K
[   69.603015] CPU: L2 cache: 512K
[   69.603017] CPU: Physical Processor ID: 3
[   69.603020] CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
[   69.603027] Intel machine check architecture supported.
[   69.603032] Intel machine check reporting enabled on CPU#3.
[   69.603035] CPU3: Intel P4/Xeon Extended MCE MSRs (12) available
[   69.603039] CPU3: Thermal monitoring enabled
[   69.603186] CPU3: Intel(R) Xeon(TM) CPU 2.80GHz stepping 09
[   69.603927] Total of 4 processors activated (22399.52 BogoMIPS).
[   69.604608] ENABLING IO-APIC IRQs
[   69.604902] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
[   69.750669] checking TSC synchronization across 4 CPUs: passed.
[    0.011925] Brought up 4 CPUs
[    0.092753] migration_cost=27,858
[    0.093504] NET: Registered protocol family 16
[    0.093668] ACPI: bus type pci registered
[    0.100375] PCI: PCI BIOS revision 2.10 entry at 0xf0094, last bus=6
[    0.100448] PCI: Using configuration type 1
[    0.100511] Setting up standard PCI resources
[    0.106624] mtrr: your CPUs had inconsistent fixed MTRR settings
[    0.106697] mtrr: probably your BIOS does not setup all CPUs.
[    0.106763] mtrr: corrected configuration.
[    0.113521] ACPI: Interpreter enabled
[    0.113603] ACPI: Using IOAPIC for interrupt routing
[    0.114301] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.114388] PCI: Probing PCI hardware (bus 00)
[    0.116493] Boot video device is 0000:00:03.0
[    0.116791] PCI: Ignoring BAR0-3 of IDE controller 0000:00:0f.1
[    0.117059] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.119472] ACPI: PCI Root Bridge [PCI1] (0000:01)
[    0.119540] PCI: Probing PCI hardware (bus 01)
[    0.121619] ACPI: PCI Interrupt Routing Table [\_SB_.PCI1._PRT]
[    0.122109] ACPI: PCI Root Bridge [PCI2] (0000:04)
[    0.122175] PCI: Probing PCI hardware (bus 04)
[    0.124125] ACPI: PCI Interrupt Routing Table [\_SB_.PCI2._PRT]
[    0.124631] ACPI: PCI Interrupt Link [IUSB] (IRQs 4 5 7 *10 11 15)
[    0.125333] ACPI: PCI Interrupt Link [IN16] (IRQs 4 5 7 10 11 15) *0, disabled.
[    0.126131] ACPI: PCI Interrupt Link [IN17] (IRQs 4 5 7 10 11 15) *0, disabled.
[    0.126925] ACPI: PCI Interrupt Link [IN18] (IRQs 4 5 7 10 11 15) *0, disabled.
[    0.127744] ACPI: PCI Interrupt Link [IN19] (IRQs 4 5 7 10 11 15) *0, disabled.
[    0.128539] ACPI: PCI Interrupt Link [IN20] (IRQs 4 5 7 10 11 15) *0, disabled.
[    0.129334] ACPI: PCI Interrupt Link [IN21] (IRQs 4 5 7 10 11 15) *0, disabled.
[    0.130128] ACPI: PCI Interrupt Link [IN22] (IRQs 4 5 *7 10 11 15)
[    0.130822] ACPI: PCI Interrupt Link [IN23] (IRQs 4 *5 7 10 11 15)
[    0.131516] ACPI: PCI Interrupt Link [IN24] (IRQs 4 5 7 10 11 15) *0, disabled.
[    0.132324] ACPI: PCI Interrupt Link [IN25] (IRQs 4 5 7 10 11 15) *0, disabled.
[    0.133116] ACPI: PCI Interrupt Link [IN26] (IRQs 4 5 7 10 11 15) *0, disabled.
[    0.133910] ACPI: PCI Interrupt Link [IN27] (IRQs 4 5 7 10 11 15) *3
[    0.134648] ACPI: PCI Interrupt Link [IN28] (IRQs 4 5 7 10 11 15) *3
[    0.135386] ACPI: PCI Interrupt Link [IN29] (IRQs 4 5 7 10 11 *15)
[    0.136093] ACPI: PCI Interrupt Link [IN30] (IRQs 4 5 7 10 *11 15)
[    0.136792] ACPI: PCI Interrupt Link [IN31] (IRQs 4 5 7 10 11 15) *3
[    0.137530] ACPI: PCI Interrupt Link [IN32] (IRQs 4 5 7 10 11 15) *0, disabled.
[    0.138328] ACPI: PCI Interrupt Link [IN33] (IRQs 4 5 7 10 11 15) *0, disabled.
[    0.139127] ACPI: PCI Interrupt Link [IN34] (IRQs 4 5 7 10 11 15) *0, disabled.
[    0.139962] SCSI subsystem initialized
[    0.140073] PCI: Using ACPI for IRQ routing
[    0.140140] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[    0.142230] PCI: Device 0000:00:00.0 not found by BIOS
[    0.144241] PCI: Device 0000:00:00.1 not found by BIOS
[    0.146246] PCI: Device 0000:00:00.2 not found by BIOS
[    0.156184] PCI: Device 0000:00:0f.0 not found by BIOS
[    0.162392] PCI: Device 0000:00:0f.3 not found by BIOS
[    0.164405] PCI: Device 0000:00:11.0 not found by BIOS
[    0.166415] PCI: Device 0000:00:11.2 not found by BIOS
[    0.172964] NET: Registered protocol family 2
[    0.227513] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.227772] TCP established hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.231685] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[    0.232167] TCP: Hash tables configured (established 524288 bind 65536)
[    0.232240] TCP reno registered
[    0.233452] highmem bounce pool size: 64 pages
[    0.233682] VFS: Disk quotas dquot_6.5.1
[    0.233768] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.233922] Initializing Cryptographic API
[    0.235398] io scheduler noop registered
[    0.235517] io scheduler anticipatory registered
[    0.235629] io scheduler deadline registered
[    0.235753] io scheduler cfq registered (default)
[    0.253847] Floppy drive(s): fd0 is 1.44M
[    0.270580] FDC 0 is a National Semiconductor PC87306
[    0.271683] Compaq SMART2 Driver (v 2.6.0)
[    0.271790] HP CISS Driver (v 3.6.10)
[    0.271925] ACPI: PCI Interrupt 0000:00:04.0[A] -> GSI 31 (level, low) -> IRQ 16
[    0.351175] cciss0: <0xb178> at PCI 0000:00:04.0 IRQ 16 using DAC
[    0.363140]       blocks= 142253280 block_size= 512
[    0.367131]       heads= 255, sectors= 32, cylinders= 17433
[    0.367132] 
[    0.367398]       blocks= 142253280 block_size= 512
[    0.367560]       heads= 255, sectors= 32, cylinders= 17433
[    0.367561] 
[    0.367684]  cciss/c0d0: p1 < p5 p6 p7 >
[    0.386716] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[    0.386785] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[    0.386907] SvrWks CSB5: IDE controller at PCI slot 0000:00:0f.1
[    0.386985] SvrWks CSB5: chipset revision 147
[    0.387049] SvrWks CSB5: not 100% native mode: will probe irqs later
[    0.387138] SvrWks CSB5: simplex device: DMA forced
[    0.387203]     ide0: BM-DMA at 0x2000-0x2007, BIOS settings: hda:pio, hdb:pio
[    0.387379] SvrWks CSB5: simplex device: DMA forced
[    0.387444]     ide1: BM-DMA at 0x2008-0x200f, BIOS settings: hdc:pio, hdd:pio
[    0.387614] Probing IDE interface ide0...
[    1.141679] hda: CRN-8245B, ATAPI CD/DVD-ROM drive
[    1.816302] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[    1.816464] Probing IDE interface ide1...
[    2.386969] Probing IDE interface ide1...
[    2.958655] hda: ATAPI 24X CD-ROM drive, 128kB Cache
[    2.958924] Uniform CD-ROM driver Revision: 3.20
[    2.962935] serio: i8042 AUX port at 0x60,0x64 irq 12
[    2.963062] serio: i8042 KBD port at 0x60,0x64 irq 1
[    2.963214] mice: PS/2 mouse device common for all mice
[    2.963287] TCP bic registered
[    2.963368] NET: Registered protocol family 1
[    2.963436] NET: Registered protocol family 17
[    2.963516] Starting balanced_irq
[    2.963583] Using IPI Shortcut mode
[    2.965455] Time: tsc clocksource has been installed.
[    2.967047] kjournald starting.  Commit interval 5 seconds
[    2.967059] EXT3-fs: mounted filesystem with ordered data mode.
[    2.967131] VFS: Mounted root (ext3 filesystem) readonly.
[    2.967317] Freeing unused kernel memory: 192k freed
[    3.064690] input: AT Translated Set 2 keyboard as /class/input/input0
[    4.749071] Adding 5993492k swap on /dev/cciss/c0d0p7.  Priority:-1 extents:1 across:5993492k
[    4.939918] EXT3 FS on cciss/c0d0p6, internal journal
[    5.194409] ACPI: PCI Interrupt 0000:01:01.0[A] -> GSI 28 (level, low) -> IRQ 17
[   10.397002] scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
[   10.397005]         <Adaptec 3960D Ultra160 SCSI adapter>
[   10.397007]         aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
[   10.397008] 
[   10.407033]   Vendor: TopRAID   Model: P12U3D            Rev: 332A
[   10.408981]   Type:   Direct-Access                      ANSI SCSI revision: 03
[   10.409254] scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
[   10.409436]  target0:0:0: Beginning Domain Validation
[   10.412106]  target0:0:0: wide asynchronous
[   10.412937]  target0:0:0: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 62)
[   10.422490]  target0:0:0: Ending Domain Validation
[   10.425172] SCSI device sda: 1562845184 512-byte hdwr sectors (800177 MB)
[   10.425477] sda: Write Protect is off
[   10.425547] sda: Mode Sense: 87 00 00 08
[   10.425755] SCSI device sda: drive cache: write through
[   10.426034] SCSI device sda: 1562845184 512-byte hdwr sectors (800177 MB)
[   10.426300] sda: Write Protect is off
[   10.426377] sda: Mode Sense: 87 00 00 08
[   10.426588] SCSI device sda: drive cache: write through
[   10.426667]  sda: sda1 < sda5 >
[   10.435227] sd 0:0:0:0: Attached scsi disk sda
[   10.452174] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   14.113479] ACPI: PCI Interrupt 0000:01:01.1[B] -> GSI 27 (level, low) -> IRQ 18
[   19.317308] scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
[   19.317311]         <Adaptec 3960D Ultra160 SCSI adapter>
[   19.317313]         aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs
[   19.317314] 
[   23.270347] device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised: dm-devel@redhat.com
[   23.508581] kjournald starting.  Commit interval 5 seconds
[   23.518465] EXT3 FS on cciss/c0d0p5, internal journal
[   23.518573] EXT3-fs: mounted filesystem with ordered data mode.
[   23.534300] kjournald starting.  Commit interval 5 seconds
[   23.535273] EXT3 FS on sda5, internal journal
[   23.535380] EXT3-fs: mounted filesystem with ordered data mode.
[   24.438538] tg3.c:v3.65 (August 07, 2006)
[   24.438646] ACPI: PCI Interrupt 0000:01:02.0[A] -> GSI 30 (level, low) -> IRQ 19
[   24.478878] eth0: Tigon3 [partno(N/A) rev 1002 PHY(5703)] (PCI:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:11:85:5c:71:57
[   24.479240] eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
[   24.479333] eth0: dma_rwctrl[763f0000] dma_mask[64-bit]
[   24.479439] ACPI: PCI Interrupt 0000:04:02.0[A] -> GSI 29 (level, low) -> IRQ 20
[   24.521885] eth1: Tigon3 [partno(N/A) rev 1002 PHY(5703)] (PCIX:100MHz:64-bit) 10/100/1000BaseT Ethernet 00:11:85:5c:71:6e
[   24.522244] eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
[   24.522335] eth1: dma_rwctrl[769f4000] dma_mask[64-bit]
[   27.856165] PM: Writing back config space on device 0000:01:02.0 at offset b (was 164714e4, writing cb0e11)
[   27.856180] PM: Writing back config space on device 0000:01:02.0 at offset 3 (was 0, writing 4010)
[   27.856186] PM: Writing back config space on device 0000:01:02.0 at offset 2 (was 2000000, writing 2000002)
[   27.856191] PM: Writing back config space on device 0000:01:02.0 at offset 1 (was 2b00000, writing 2b00146)
[   27.856197] PM: Writing back config space on device 0000:01:02.0 at offset 0 (was 164714e4, writing 16a714e4)
[   29.798210] Real Time Clock Driver v1.12ac
[   29.800418] Generic RTC Driver v1.07
[   31.215044] tg3: eth0: Link is up at 1000 Mbps, full duplex.
[   31.215133] tg3: eth0: Flow control is on for TX and on for RX.
[69774.700393] swapper: page allocation failure. order:1, mode:0x20
[69774.700434]  [<c1004f7f>] show_trace+0x12/0x14
[69774.700479]  [<c1004f9a>] dump_stack+0x19/0x1b
[69774.700514]  [<c103fd91>] __alloc_pages+0x1dd/0x2c6
[69774.700560]  [<c105461a>] cache_alloc_refill+0x2f4/0x517
[69774.700610]  [<c10548ac>] __kmalloc+0x6f/0x75
[69774.700657]  [<c11583be>] __alloc_skb+0x48/0xf4
[69774.700696]  [<c1180384>] tcp_collapse+0x134/0x348
[69774.700732]  [<c11806ab>] tcp_prune_queue+0x113/0x2e1
[69774.700778]  [<c1183534>] tcp_data_queue+0x585/0xc3a
[69774.700818]  [<c1184bfc>] tcp_rcv_established+0x277/0x92b
[69774.700862]  [<c118c2d7>] tcp_v4_do_rcv+0xae/0x2bd
[69774.700903]  [<c118d354>] tcp_v4_rcv+0x776/0x8df
[69774.700944]  [<c1171bab>] ip_local_deliver+0xf6/0x1b0
[69774.700984]  [<c1171f30>] ip_rcv+0x2cb/0x52b
[69774.701017]  [<c115fb43>] netif_receive_skb+0x168/0x1de
[69774.701052]  [<f8b7103e>] tg3_poll+0x61c/0x80f [tg3]
[69774.701093]  [<c115d7a8>] net_rx_action+0x82/0x167
[69774.701127]  [<c101f6d9>] __do_softirq+0x75/0xe3
[69774.701162]  [<c10053f9>] do_softirq+0x5e/0xb5
[69774.701195]  =======================
[69774.701221]  [<c101f3c4>] irq_exit+0x3a/0x3c
[69774.701252]  [<c100535e>] do_IRQ+0x65/0xa2
[69774.701283]  [<c1003582>] common_interrupt+0x1a/0x20
[69774.701315]  [<c1001a38>] cpu_idle+0x66/0x7c
[69774.701357]  [<c100cf75>] start_secondary+0x23a/0x4a5
[69774.701418]  [<00000000>] 0x0
[69774.701445]  [<f7c11fb4>] 0xf7c11fb4
[69774.701490] Mem-info:
[69774.701538] DMA per-cpu:
[69774.701587] cpu 0 hot: high 0, batch 1 used:0
[69774.701645] cpu 0 cold: high 0, batch 1 used:0
[69774.701701] cpu 1 hot: high 0, batch 1 used:0
[69774.701756] cpu 1 cold: high 0, batch 1 used:0
[69774.701802] cpu 2 hot: high 0, batch 1 used:0
[69774.701830] cpu 2 cold: high 0, batch 1 used:0
[69774.701878] cpu 3 hot: high 0, batch 1 used:0
[69774.701936] cpu 3 cold: high 0, batch 1 used:0
[69774.701991] DMA32 per-cpu: empty
[69774.702043] Normal per-cpu:
[69774.702070] cpu 0 hot: high 186, batch 31 used:17
[69774.702098] cpu 0 cold: high 62, batch 15 used:47
[69774.702126] cpu 1 hot: high 186, batch 31 used:116
[69774.702155] cpu 1 cold: high 62, batch 15 used:50
[69774.702184] cpu 2 hot: high 186, batch 31 used:168
[69774.702214] cpu 2 cold: high 62, batch 15 used:59
[69774.702242] cpu 3 hot: high 186, batch 31 used:158
[69774.702272] cpu 3 cold: high 62, batch 15 used:1
[69774.702299] HighMem per-cpu:
[69774.702327] cpu 0 hot: high 186, batch 31 used:21
[69774.702356] cpu 0 cold: high 62, batch 15 used:9
[69774.702384] cpu 1 hot: high 186, batch 31 used:12
[69774.702412] cpu 1 cold: high 62, batch 15 used:10
[69774.702441] cpu 2 hot: high 186, batch 31 used:157
[69774.702469] cpu 2 cold: high 62, batch 15 used:13
[69774.702500] cpu 3 hot: high 186, batch 31 used:121
[69774.702529] cpu 3 cold: high 62, batch 15 used:11
[69774.702558] Free pages:     1258784kB (1251916kB HighMem)
[69774.702591] Active:258255 inactive:107913 dirty:2421 writeback:0 unstable:0 free:314696 slab:94492 mapped:2747 pagetables:612
[69774.702652] DMA free:3552kB min:68kB low:84kB high:100kB active:0kB inactive:20kB present:16384kB pages_scanned:0 all_unreclaimable? no
[69774.702711] lowmem_reserve[]: 0 0 880 3055
[69774.702751] DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
[69774.702810] lowmem_reserve[]: 0 0 880 3055
[69774.702863] Normal free:3316kB min:3756kB low:4692kB high:5632kB active:187336kB inactive:308292kB present:901120kB pages_scanned:0 all_unreclaimable? no
[69774.703003] lowmem_reserve[]: 0 0 0 17407
[69774.703092] HighMem free:1251916kB min:512kB low:2836kB high:5160kB active:845684kB inactive:123340kB present:2228200kB pages_scanned:0 all_unreclaimable? no
[69774.703196] lowmem_reserve[]: 0 0 0 0
[69774.703290] DMA: 24*4kB 0*8kB 0*16kB 0*32kB 0*64kB 1*128kB 1*256kB 0*512kB 1*1024kB 1*2048kB 0*4096kB = 3552kB
[69774.703433] DMA32: empty
[69774.703483] Normal: 653*4kB 0*8kB 0*16kB 0*32kB 1*64kB 1*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 3316kB
[69774.703583] HighMem: 1*4kB 1*8kB 0*16kB 6902*32kB 4880*64kB 2697*128kB 1109*256kB 171*512kB 2*1024kB 0*2048kB 0*4096kB = 1251916kB
[69774.705997] Swap cache: add 13, delete 13, find 1/2, race 0+0
[69774.706038] Free swap  = 5993492kB
[69774.706072] Total swap = 5993492kB
[69774.706106] Free swap:       5993492kB
[69774.719956] 786426 pages of RAM
[69774.719993] 557050 pages of HIGHMEM
[69774.720027] 7175 reserved pages
[69774.720059] 170344 pages shared
[69774.720091] 0 pages swap cached
[69774.720123] 2421 pages dirty
[69774.720154] 0 pages writeback
[69774.720186] 2747 pages mapped
[69774.720218] 94492 pages slab
[69774.720250] 612 pages pagetables

-- 
Ralf Hildebrandt (i.A. des IT-Zentrums)         Ralf.Hildebrandt@charite.de
Charite - Universit√§tsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                    send no mail to plonk@charite.de
