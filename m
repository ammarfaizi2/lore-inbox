Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbVCQIuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbVCQIuq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 03:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261814AbVCQIuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 03:50:46 -0500
Received: from ZIVLNX17.UNI-MUENSTER.DE ([128.176.188.79]:14473 "EHLO
	ZIVLNX17.uni-muenster.de") by vger.kernel.org with ESMTP
	id S263021AbVCQIn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 03:43:57 -0500
From: Borislav Petkov <petkov@uni-muenster.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.11-mm4
Date: Thu, 17 Mar 2005 09:42:25 +0100
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <20050316040654.62881834.akpm@osdl.org>
In-Reply-To: <20050316040654.62881834.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_xLUOCGytPut5csj"
Message-Id: <200503170942.25833.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_xLUOCGytPut5csj
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<snip>
Hi there,

my mm4 wouldn't boot while mm3 works just fine. Here's the whole boot log:

Mar 17 09:19:28 zmei kernel: [4294667.296000] Linux version 2.6.11-mm4 (boris@zmei) (gcc version 3.3.5 (Debian 1:3.3.5-12)) #1 SMP Wed Mar 16 21:42:25 CET 2005
Mar 17 09:19:28 zmei kernel: [4294667.296000] BIOS-provided physical RAM map:
Mar 17 09:19:28 zmei kernel: [4294667.296000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Mar 17 09:19:28 zmei kernel: [4294667.296000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Mar 17 09:19:28 zmei kernel: [4294667.296000]  BIOS-e820: 00000000000ce000 - 00000000000d60ac (reserved)
Mar 17 09:19:28 zmei kernel: [4294667.296000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Mar 17 09:19:28 zmei kernel: [4294667.296000]  BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
Mar 17 09:19:28 zmei kernel: [4294667.296000]  BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
Mar 17 09:19:28 zmei kernel: [4294667.296000]  BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
Mar 17 09:19:28 zmei kernel: [4294667.296000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
Mar 17 09:19:28 zmei kernel: [4294667.296000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Mar 17 09:19:28 zmei kernel: [4294667.296000]  BIOS-e820: 00000000ffb00000 - 00000000ffc00000 (reserved)
Mar 17 09:19:28 zmei kernel: [4294667.296000]  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
Mar 17 09:19:28 zmei kernel: [4294667.296000] 511MB LOWMEM available.
Mar 17 09:19:28 zmei kernel: [4294667.296000] found SMP MP-table at 000fbad0
Mar 17 09:19:28 zmei kernel: [4294667.296000] On node 0 totalpages: 131056
Mar 17 09:19:28 zmei kernel: [4294667.296000]   DMA zone: 4096 pages, LIFO batch:1
Mar 17 09:19:28 zmei kernel: [4294667.296000]   Normal zone: 126960 pages, LIFO batch:16
Mar 17 09:19:28 zmei kernel: [4294667.296000]   HighMem zone: 0 pages, LIFO batch:1
Mar 17 09:19:28 zmei kernel: [4294667.296000] DMI 2.3 present.
Mar 17 09:19:28 zmei kernel: [4294667.296000] ACPI: RSDP (v000 AMI                                   ) @ 0x000fa270
Mar 17 09:19:28 zmei kernel: [4294667.296000] ACPI: RSDT (v001 AMIINT INTEL845 0x00000010 MSFT 0x00000097) @ 0x1fff0000
Mar 17 09:19:28 zmei kernel: [4294667.296000] ACPI: FADT (v001 AMIINT INTEL845 0x00000011 MSFT 0x00000097) @ 0x1fff0030
Mar 17 09:19:28 zmei kernel: [4294667.296000] ACPI: MADT (v001 AMIINT INTEL845 0x00000009 MSFT 0x00000097) @ 0x1fff00c0
Mar 17 09:19:28 zmei kernel: [4294667.296000] ACPI: DSDT (v001  INTEL  P4I45GL 0x00001000 MSFT 0x0100000d) @ 0x00000000
Mar 17 09:19:28 zmei kernel: [4294667.296000] ACPI: Local APIC address 0xfee00000
Mar 17 09:19:28 zmei kernel: [4294667.296000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Mar 17 09:19:28 zmei kernel: [4294667.296000] Processor #0 15:2 APIC version 20
Mar 17 09:19:28 zmei kernel: [4294667.296000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Mar 17 09:19:28 zmei kernel: [4294667.296000] Processor #1 15:2 APIC version 20
Mar 17 09:19:28 zmei kernel: [4294667.296000] Using ACPI for processor (LAPIC) configuration information
Mar 17 09:19:28 zmei kernel: [4294667.296000] Intel MultiProcessor Specification v1.4
Mar 17 09:19:28 zmei kernel: [4294667.296000]     Virtual Wire compatibility mode.
Mar 17 09:19:28 zmei kernel: [4294667.296000] OEM ID: INTEL    Product ID: I845GL       APIC at: 0xFEE00000
Mar 17 09:19:28 zmei kernel: [4294667.296000] I/O APIC #2 Version 32 at 0xFEC00000.
Mar 17 09:19:28 zmei kernel: [4294667.296000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
Mar 17 09:19:28 zmei kernel: [4294667.296000] Processors: 2
Mar 17 09:19:28 zmei kernel: [4294667.296000] Allocating PCI resources starting at 20000000 (gap: 20000000:dec00000)
Mar 17 09:19:28 zmei kernel: [4294667.296000] Built 1 zonelists
Mar 17 09:19:28 zmei kernel: [4294667.296000] mapped APIC to ffffd000 (fee00000)
Mar 17 09:19:28 zmei kernel: [4294667.296000] mapped IOAPIC to ffffc000 (fec00000)
Mar 17 09:19:28 zmei kernel: [4294667.296000] Initializing CPU#0
Mar 17 09:19:28 zmei kernel: [4294667.296000] Kernel command line: root=/dev/hda1 vga=0
Mar 17 09:19:28 zmei kernel: [4294667.296000] CPU 0 irqstacks, hard=c04c1000 soft=c04bf000
Mar 17 09:19:28 zmei kernel: [4294667.296000] PID hash table entries: 2048 (order: 11, 32768 bytes)
Mar 17 09:19:28 zmei kernel: [    0.000000] Detected 2606.843 MHz processor.
Mar 17 09:19:28 zmei kernel: [   22.419992] Using tsc for high-res timesource
Mar 17 09:19:28 zmei kernel: [   22.420923] Console: colour VGA+ 80x25
Mar 17 09:19:28 zmei kernel: [   22.422053] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Mar 17 09:19:28 zmei kernel: [   22.422892] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mar 17 09:19:28 zmei kernel: [   22.437591] Memory: 510040k/524224k available (2543k kernel code, 13696k reserved, 1078k data, 188k init, 0k highmem)
Mar 17 09:19:28 zmei kernel: [   22.437623] Checking if this processor honours the WP bit even in supervisor mode... Ok.
Mar 17 09:19:28 zmei kernel: [   22.437889] Calibrating delay loop... 5144.57 BogoMIPS (lpj=2572288)
Mar 17 09:19:28 zmei kernel: [   22.459998] Security Framework v1.0.0 initialized
Mar 17 09:19:28 zmei kernel: [   22.460017] Capability LSM initialized
Mar 17 09:19:28 zmei kernel: [   22.460063] Mount-cache hash table entries: 512
Mar 17 09:19:28 zmei kernel: [   22.460278] CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
Mar 17 09:19:28 zmei kernel: [   22.460289] CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
Mar 17 09:19:28 zmei kernel: [   22.460299] CPU: Trace cache: 12K uops, L1 D cache: 8K
Mar 17 09:19:28 zmei kernel: [   22.460319] CPU: L2 cache: 512K
Mar 17 09:19:28 zmei kernel: [   22.460333] CPU: Physical Processor ID: 0
Mar 17 09:19:28 zmei kernel: [   22.460349] CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
Mar 17 09:19:28 zmei kernel: [   22.460357] Intel machine check architecture supported.
Mar 17 09:19:28 zmei kernel: [   22.460376] Intel machine check reporting enabled on CPU#0.
Mar 17 09:19:28 zmei kernel: [   22.460394] CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
Mar 17 09:19:28 zmei kernel: [   22.460412] CPU0: Thermal monitoring enabled
Mar 17 09:19:28 zmei kernel: [   22.460428] Enabling fast FPU save and restore... done.
Mar 17 09:19:28 zmei kernel: [   22.460448] Enabling unmasked SIMD FPU exception support... done.
Mar 17 09:19:28 zmei kernel: [   22.460471] Checking 'hlt' instruction... OK.
Mar 17 09:19:28 zmei kernel: [   22.464063] CPU0: Intel(R) Pentium(R) 4 CPU 2.60GHz stepping 09
Mar 17 09:19:28 zmei kernel: [   22.464134] Booting processor 1/1 eip 2000
Mar 17 09:19:28 zmei kernel: [   22.464151] CPU 1 irqstacks, hard=c04c2000 soft=c04c0000
Mar 17 09:19:28 zmei kernel: [   22.474419] Initializing CPU#1
Mar 17 09:19:28 zmei kernel: [   22.475403] Calibrating delay loop... 5193.72 BogoMIPS (lpj=2596864)
Mar 17 09:19:28 zmei kernel: [   22.497826] CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
Mar 17 09:19:28 zmei kernel: [   22.497834] CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
Mar 17 09:19:28 zmei kernel: [   22.497844] CPU: Trace cache: 12K uops, L1 D cache: 8K
Mar 17 09:19:28 zmei kernel: [   22.497846] CPU: L2 cache: 512K
Mar 17 09:19:28 zmei kernel: [   22.497848] CPU: Physical Processor ID: 0
Mar 17 09:19:28 zmei kernel: [   22.497850] CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
Mar 17 09:19:28 zmei kernel: [   22.497857] Intel machine check architecture supported.
Mar 17 09:19:28 zmei kernel: [   22.497862] Intel machine check reporting enabled on CPU#1.
Mar 17 09:19:28 zmei kernel: [   22.497865] CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
Mar 17 09:19:28 zmei kernel: [   22.497869] CPU1: Thermal monitoring enabled
Mar 17 09:19:28 zmei kernel: [   22.497924] CPU1: Intel(R) Pentium(R) 4 CPU 2.60GHz stepping 09
Mar 17 09:19:28 zmei kernel: [   22.498071] Total of 2 processors activated (10338.30 BogoMIPS).
Mar 17 09:19:28 zmei kernel: [   22.498166] ENABLING IO-APIC IRQs
Mar 17 09:19:28 zmei kernel: [   22.498354] ..TIMER: vector=0x31 pin1=2 pin2=0
Mar 17 09:19:28 zmei kernel: [   22.508222] testing NMI watchdog ... CPU#1: NMI appears to be stuck!
Mar 17 09:19:28 zmei kernel: [   22.619520] checking TSC synchronization across 2 CPUs: passed.
Mar 17 09:19:28 zmei kernel: [    0.000191] softlockup thread 0 started up.
Mar 17 09:19:28 zmei kernel: [    0.000995] Brought up 2 CPUs
Mar 17 09:19:28 zmei kernel: [    0.000999] softlockup thread 1 started up.
Mar 17 09:19:28 zmei kernel: [    0.001042] CPU0 attaching sched-domain:
Mar 17 09:19:28 zmei kernel: [    0.001045]  domain 0: span 3
Mar 17 09:19:28 zmei kernel: [    0.001048]   groups: 1 2
Mar 17 09:19:28 zmei kernel: [    0.001054]   domain 1: span 3
Mar 17 09:19:28 zmei kernel: [    0.001057]    groups: 3
Mar 17 09:19:28 zmei kernel: [    0.001062] CPU1 attaching sched-domain:
Mar 17 09:19:28 zmei kernel: [    0.001064]  domain 0: span 3
Mar 17 09:19:28 zmei kernel: [    0.001067]   groups: 2 1
Mar 17 09:19:28 zmei kernel: [    0.001072]   domain 1: span 3
Mar 17 09:19:28 zmei kernel: [    0.001075]    groups: 3
Mar 17 09:19:28 zmei kernel: [    0.002793] NET: Registered protocol family 16
Mar 17 09:19:28 zmei kernel: [    0.009421] PCI: PCI BIOS revision 2.10 entry at 0xfdb51, last bus=3
Mar 17 09:19:28 zmei kernel: [    0.009445] PCI: Using configuration type 1
Mar 17 09:19:28 zmei kernel: [    0.009461] mtrr: v2.0 (20020519)
Mar 17 09:19:28 zmei kernel: [    0.015235] Linux Plug and Play Support v0.97 (c) Adam Belay
Mar 17 09:19:28 zmei kernel: [    0.016297] usbcore: registered new driver usbfs
Mar 17 09:19:28 zmei kernel: [    0.016394] usbcore: registered new driver hub
Mar 17 09:19:28 zmei kernel: [    0.016607] PCI: Probing PCI hardware
Mar 17 09:19:28 zmei kernel: [    0.016624] PCI: Probing PCI hardware (bus 00)
Mar 17 09:19:28 zmei kernel: [    0.017244] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Mar 17 09:19:28 zmei kernel: [    0.017800] PCI: Transparent bridge - 0000:00:1e.0
Mar 17 09:19:28 zmei kernel: [    0.019398] PCI: Using IRQ router PIIX/ICH [8086/24c0] at 0000:00:1f.0
Mar 17 09:19:28 zmei kernel: [    0.019427] PCI->APIC IRQ transform: 0000:00:1d.0[A] -> IRQ 16
Mar 17 09:19:28 zmei kernel: [    0.019446] PCI->APIC IRQ transform: 0000:00:1d.1[B] -> IRQ 19
Mar 17 09:19:28 zmei kernel: [    0.019464] PCI->APIC IRQ transform: 0000:00:1d.2[C] -> IRQ 18
Mar 17 09:19:28 zmei kernel: [    0.019483] PCI->APIC IRQ transform: 0000:00:1d.7[D] -> IRQ 23
Mar 17 09:19:28 zmei kernel: [    0.019504] PCI->APIC IRQ transform: 0000:00:1f.1[A] -> IRQ 18
Mar 17 09:19:28 zmei kernel: [    0.019522] PCI->APIC IRQ transform: 0000:01:00.0[A] -> IRQ 16
Mar 17 09:19:28 zmei kernel: [    0.019541] PCI->APIC IRQ transform: 0000:03:04.0[A] -> IRQ 17
Mar 17 09:19:28 zmei kernel: [    0.019559] PCI->APIC IRQ transform: 0000:03:06.0[A] -> IRQ 19
Mar 17 09:19:28 zmei kernel: [    0.019577] PCI->APIC IRQ transform: 0000:03:07.0[A] -> IRQ 16
Mar 17 09:19:28 zmei kernel: [    0.019595] PCI->APIC IRQ transform: 0000:03:07.1[A] -> IRQ 16
Mar 17 09:19:28 zmei kernel: [    0.019614] PCI->APIC IRQ transform: 0000:03:0a.0[A] -> IRQ 17
Mar 17 09:19:28 zmei kernel: [    0.025198] Machine check exception polling timer started.
Mar 17 09:19:28 zmei kernel: [    0.028790] inotify device minor=63
Mar 17 09:19:28 zmei kernel: [    0.029146] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Mar 17 09:19:28 zmei kernel: [    0.029920] Initializing Cryptographic API
Mar 17 09:19:28 zmei kernel: [    0.029941] kgdb <20030915.1651.33> : port =3f8, IRQ=4, divisor =1
Mar 17 09:19:28 zmei kernel: [    0.035811] Linux agpgart interface v0.101 (c) Dave Jones
Mar 17 09:19:28 zmei kernel: [    0.035936] agpgart: Detected an Intel 845G Chipset.
Mar 17 09:19:28 zmei kernel: [    0.038437] agpgart: AGP aperture is 64M @ 0xe0000000
Mar 17 09:19:28 zmei kernel: [    0.038560] [drm] Initialized drm 1.0.0 20040925
Mar 17 09:19:28 zmei kernel: [    0.038734] [drm] Initialized radeon 1.15.0 20050125 on minor 0: ATI Technologies Inc RV280 [Radeon 9200 SE]
Mar 17 09:19:28 zmei kernel: [    0.039326] PNP: No PS/2 controller found. Probing ports directly.
Mar 17 09:19:28 zmei kernel: [    0.041086] serio: i8042 AUX port at 0x60,0x64 irq 12
Mar 17 09:19:28 zmei kernel: [    0.041166] serio: i8042 KBD port at 0x60,0x64 irq 1
Mar 17 09:19:28 zmei kernel: [    0.041185] Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
Mar 17 09:19:28 zmei kernel: [    0.042635] parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
Mar 17 09:19:28 zmei kernel: [    0.042689] parport0: irq 7 detected
Mar 17 09:19:28 zmei kernel: [    0.042937] io scheduler noop registered
Mar 17 09:19:28 zmei kernel: [    0.042978] io scheduler anticipatory registered
Mar 17 09:19:28 zmei kernel: [    0.043007] io scheduler deadline registered
Mar 17 09:19:28 zmei kernel: [    0.043060] io scheduler cfq registered
Mar 17 09:19:28 zmei kernel: [    0.043283] 8139too Fast Ethernet driver 0.9.27
Mar 17 09:19:28 zmei kernel: [    0.043676] eth0: RealTek RTL8139 at 0xe0816f00, 00:0c:6e:aa:a2:81, IRQ 17
Mar 17 09:19:28 zmei kernel: [    0.043695] eth0:  Identified 8139 chip type 'RTL-8101'
Mar 17 09:19:28 zmei kernel: [    0.043705] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Mar 17 09:19:28 zmei kernel: [    0.043724] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Mar 17 09:19:28 zmei kernel: [    0.044005] ICH4: IDE controller at PCI slot 0000:00:1f.1
Mar 17 09:19:28 zmei kernel: [    0.044033] ICH4: chipset revision 2
Mar 17 09:19:28 zmei kernel: [    0.044049] ICH4: not 100%% native mode: will probe irqs later
Mar 17 09:19:28 zmei kernel: [    0.044073]     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
Mar 17 09:19:28 zmei kernel: [    0.044116]     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
Mar 17 09:19:28 zmei kernel: [    0.044156] Probing IDE interface ide0...
Mar 17 09:19:28 zmei kernel: [    0.308295] hda: QUANTUM FIREBALLlct10 20, ATA DISK drive
Mar 17 09:19:28 zmei kernel: [    0.563604] hdb: IC35L120AVV207-0, ATA DISK drive
Mar 17 09:19:28 zmei kernel: [    0.615873] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Mar 17 09:19:28 zmei kernel: [    0.616099] Probing IDE interface ide1...
Mar 17 09:19:28 zmei kernel: [    1.286642] hdc: _NEC DVD+RW ND-1100A, ATAPI CD/DVD-ROM drive
Mar 17 09:19:28 zmei kernel: [    1.541950] hdd: Maxtor 6Y160P0, ATA DISK drive
Mar 17 09:19:28 zmei kernel: [    1.593046] ide1 at 0x170-0x177,0x376 on irq 15
Mar 17 09:19:28 zmei kernel: [    1.593516] Probing IDE interface ide2...
Mar 17 09:19:28 zmei kernel: [    2.105290] Probing IDE interface ide3...
Mar 17 09:19:28 zmei kernel: [    2.616908] Probing IDE interface ide4...
Mar 17 09:19:28 zmei kernel: [    3.128523] Probing IDE interface ide5...
Mar 17 09:19:28 zmei kernel: [    3.640163] hda: max request size: 128KiB
Mar 17 09:19:28 zmei kernel: [    3.645049] hda: 39876480 sectors (20416 MB) w/418KiB Cache, CHS=39560/16/63, UDMA(33)
Mar 17 09:19:28 zmei kernel: [    3.645091] hda: cache flushes not supported
Mar 17 09:19:28 zmei kernel: [    3.645248]  hda: hda1 hda2 hda3
Mar 17 09:19:28 zmei kernel: [    3.646875] hdb: max request size: 1024KiB
Mar 17 09:19:28 zmei kernel: [    3.655474] hdb: 241254720 sectors (123522 MB) w/1821KiB Cache, CHS=16383/255/63, UDMA(100)
Mar 17 09:19:28 zmei kernel: [    3.656018] hdb: cache flushes supported
Mar 17 09:19:28 zmei kernel: [    3.656143]  hdb: hdb1
Mar 17 09:19:28 zmei kernel: [    3.665812] hdd: max request size: 1024KiB
Mar 17 09:19:28 zmei kernel: [    3.666700] hdd: 320173056 sectors (163928 MB) w/7936KiB Cache, CHS=19929/255/63, UDMA(33)
Mar 17 09:19:28 zmei kernel: [    3.666881] hdd: cache flushes supported
Mar 17 09:19:28 zmei kernel: [    3.667002]  hdd: hdd1
Mar 17 09:19:28 zmei kernel: [    3.671882] hdc: ATAPI 40X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Mar 17 09:19:28 zmei kernel: [    3.671925] Uniform CD-ROM driver Revision: 3.20
Mar 17 09:19:28 zmei kernel: [    3.680704] ehci_hcd: block sizes: qh 128 qtd 96 itd 192 sitd 96
Mar 17 09:19:28 zmei kernel: [    3.680818] PCI: Setting latency timer of device 0000:00:1d.7 to 64
Mar 17 09:19:28 zmei kernel: [    3.680822] ehci_hcd 0000:00:1d.7: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Controller
Mar 17 09:19:28 zmei kernel: [    3.680854] ehci_hcd 0000:00:1d.7: reset hcs_params 0x103206 dbg=1 cc=3 pcc=2 ordered !ppc ports=6
Mar 17 09:19:28 zmei kernel: [    3.680858] ehci_hcd 0000:00:1d.7: reset hcc_params 6871 thresh 7 uframes 1024 64 bit addr
Mar 17 09:19:28 zmei kernel: [    3.680864] ehci_hcd 0000:00:1d.7: capability 10001 at 68
Mar 17 09:19:28 zmei kernel: [    3.695989] ehci_hcd 0000:00:1d.7: BIOS handoff succeeded
Mar 17 09:19:28 zmei kernel: [    3.696112] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
Mar 17 09:19:28 zmei kernel: [    3.696146] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xdffffc00
Mar 17 09:19:28 zmei kernel: [    3.696201] ehci_hcd 0000:00:1d.7: reset command 080002 (park)=0 ithresh=8 period=1024 Reset HALT
Mar 17 09:19:28 zmei kernel: [    3.700085] PCI: cache line size of 128 is not supported by device 0000:00:1d.7
Mar 17 09:19:28 zmei kernel: [    3.700090] ehci_hcd 0000:00:1d.7: init command 010001 (park)=0 ithresh=1 period=1024 RUN
Mar 17 09:19:28 zmei kernel: [    3.700100] ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
Mar 17 09:19:28 zmei kernel: [    3.700126] ehci_hcd 0000:00:1d.7: supports USB remote wakeup
Mar 17 09:19:28 zmei kernel: [    3.700158] usb usb1: default language 0x0409
Mar 17 09:19:28 zmei kernel: [    3.700179] usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
Mar 17 09:19:28 zmei kernel: [    3.700182] usb usb1: Product: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Controller
Mar 17 09:19:28 zmei kernel: [    3.700210] usb usb1: Manufacturer: Linux 2.6.11-mm3 ehci_hcd
Mar 17 09:19:28 zmei kernel: [    3.700226] usb usb1: SerialNumber: 0000:00:1d.7
Mar 17 09:19:28 zmei kernel: [    3.700256] usb usb1: hotplug
Mar 17 09:19:28 zmei kernel: [    3.700380] usb usb1: adding 1-0:1.0 (config #1, interface 0)
Mar 17 09:19:28 zmei kernel: [    3.700393] usb 1-0:1.0: hotplug
Mar 17 09:19:28 zmei kernel: [    3.700482] hub 1-0:1.0: usb_probe_interface
Mar 17 09:19:28 zmei kernel: [    3.700485] hub 1-0:1.0: usb_probe_interface - got id
Mar 17 09:19:28 zmei kernel: [    3.700487] hub 1-0:1.0: USB hub found
Mar 17 09:19:28 zmei kernel: [    3.700516] hub 1-0:1.0: 6 ports detected
Mar 17 09:19:28 zmei kernel: [    3.700531] hub 1-0:1.0: standalone hub
Mar 17 09:19:28 zmei kernel: [    3.700533] hub 1-0:1.0: ganged power switching
Mar 17 09:19:28 zmei kernel: [    3.700535] hub 1-0:1.0: individual port over-current protection
Mar 17 09:19:28 zmei kernel: [    3.700537] hub 1-0:1.0: Single TT
Mar 17 09:19:28 zmei kernel: [    3.700539] hub 1-0:1.0: TT requires at most 8 FS bit times
Mar 17 09:19:28 zmei kernel: [    3.700541] hub 1-0:1.0: power on to power good time: 20ms
Mar 17 09:19:28 zmei kernel: [    3.700551] hub 1-0:1.0: local power source is good
Mar 17 09:19:28 zmei kernel: [    3.700555] hub 1-0:1.0: enabling power on all ports
Mar 17 09:19:28 zmei kernel: [    3.721926] hub 1-0:1.0: state 5 ports 6 chg 0000 evt 0000
Mar 17 09:19:28 zmei kernel: [    3.721955] USB Universal Host Controller Interface driver v2.2
Mar 17 09:19:28 zmei kernel: [    3.722160] PCI: Setting latency timer of device 0000:00:1d.0 to 64
Mar 17 09:19:28 zmei kernel: [    3.722165] uhci_hcd 0000:00:1d.0: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1
Mar 17 09:19:28 zmei kernel: [    3.783866] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
Mar 17 09:19:28 zmei kernel: [    3.783899] uhci_hcd 0000:00:1d.0: irq 16, io base 0x0000e400
Mar 17 09:19:28 zmei kernel: [    3.783939] uhci_hcd 0000:00:1d.0: detected 2 ports
Mar 17 09:19:28 zmei kernel: [    3.784010] usb usb2: default language 0x0409
Mar 17 09:19:28 zmei kernel: [    3.784030] usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
Mar 17 09:19:28 zmei kernel: [    3.784033] usb usb2: Product: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1
Mar 17 09:19:28 zmei kernel: [    3.784061] usb usb2: Manufacturer: Linux 2.6.11-mm3 uhci_hcd
Mar 17 09:19:28 zmei kernel: [    3.784078] usb usb2: SerialNumber: 0000:00:1d.0
Mar 17 09:19:28 zmei kernel: [    3.784106] usb usb2: hotplug
Mar 17 09:19:28 zmei kernel: [    3.784238] usb usb2: adding 2-0:1.0 (config #1, interface 0)
Mar 17 09:19:28 zmei kernel: [    3.784251] usb 2-0:1.0: hotplug
Mar 17 09:19:28 zmei kernel: [    3.784333] hub 2-0:1.0: usb_probe_interface
Mar 17 09:19:28 zmei kernel: [    3.784335] hub 2-0:1.0: usb_probe_interface - got id
Mar 17 09:19:28 zmei kernel: [    3.784337] hub 2-0:1.0: USB hub found
Mar 17 09:19:28 zmei kernel: [    3.784364] hub 2-0:1.0: 2 ports detected
Mar 17 09:19:28 zmei kernel: [    3.784379] hub 2-0:1.0: standalone hub
Mar 17 09:19:28 zmei kernel: [    3.784381] hub 2-0:1.0: no power switching (usb 1.0)
Mar 17 09:19:28 zmei kernel: [    3.784383] hub 2-0:1.0: individual port over-current protection
Mar 17 09:19:28 zmei kernel: [    3.784386] hub 2-0:1.0: power on to power good time: 2ms
Mar 17 09:19:28 zmei kernel: [    3.784396] hub 2-0:1.0: local power source is good
Mar 17 09:19:28 zmei kernel: [    3.787747] hub 2-0:1.0: state 5 ports 2 chg 0000 evt 0000
Mar 17 09:19:28 zmei kernel: [    3.787785] PCI: Setting latency timer of device 0000:00:1d.1 to 64
Mar 17 09:19:28 zmei kernel: [    3.787789] uhci_hcd 0000:00:1d.1: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2
Mar 17 09:19:28 zmei kernel: [    3.849673] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
Mar 17 09:19:28 zmei kernel: [    3.849705] uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000e800
Mar 17 09:19:28 zmei kernel: [    3.849746] uhci_hcd 0000:00:1d.1: detected 2 ports
Mar 17 09:19:28 zmei kernel: [    3.849809] usb usb3: default language 0x0409
Mar 17 09:19:28 zmei kernel: [    3.849828] usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
Mar 17 09:19:28 zmei kernel: [    3.849831] usb usb3: Product: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2
Mar 17 09:19:28 zmei kernel: [    3.849860] usb usb3: Manufacturer: Linux 2.6.11-mm3 uhci_hcd
Mar 17 09:19:28 zmei kernel: [    3.849877] usb usb3: SerialNumber: 0000:00:1d.1
Mar 17 09:19:28 zmei kernel: [    3.849904] usb usb3: hotplug
Mar 17 09:19:28 zmei kernel: [    3.850011] usb usb3: adding 3-0:1.0 (config #1, interface 0)
Mar 17 09:19:28 zmei kernel: [    3.850036] usb 3-0:1.0: hotplug
Mar 17 09:19:28 zmei kernel: [    3.850111] hub 3-0:1.0: usb_probe_interface
Mar 17 09:19:28 zmei kernel: [    3.850113] hub 3-0:1.0: usb_probe_interface - got id
Mar 17 09:19:28 zmei kernel: [    3.850115] hub 3-0:1.0: USB hub found
Mar 17 09:19:28 zmei kernel: [    3.850143] hub 3-0:1.0: 2 ports detected
Mar 17 09:19:28 zmei kernel: [    3.850779] hub 3-0:1.0: standalone hub
Mar 17 09:19:28 zmei kernel: [    3.850781] hub 3-0:1.0: no power switching (usb 1.0)
Mar 17 09:19:28 zmei kernel: [    3.850783] hub 3-0:1.0: individual port over-current protection
Mar 17 09:19:28 zmei kernel: [    3.850785] hub 3-0:1.0: power on to power good time: 2ms
Mar 17 09:19:28 zmei kernel: [    3.850795] hub 3-0:1.0: local power source is good
Mar 17 09:19:28 zmei kernel: [    3.853568] hub 3-0:1.0: state 5 ports 2 chg 0000 evt 0000
Mar 17 09:19:28 zmei kernel: [    3.853605] PCI: Setting latency timer of device 0000:00:1d.2 to 64
Mar 17 09:19:28 zmei kernel: [    3.853610] uhci_hcd 0000:00:1d.2: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3
Mar 17 09:19:28 zmei kernel: [    3.915495] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
Mar 17 09:19:28 zmei kernel: [    3.915527] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000ec00
Mar 17 09:19:28 zmei kernel: [    3.915564] uhci_hcd 0000:00:1d.2: detected 2 ports
Mar 17 09:19:28 zmei kernel: [    3.915642] usb usb4: default language 0x0409
Mar 17 09:19:28 zmei kernel: [    3.915661] usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
Mar 17 09:19:28 zmei kernel: [    3.915664] usb usb4: Product: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3
Mar 17 09:19:28 zmei kernel: [    3.915693] usb usb4: Manufacturer: Linux 2.6.11-mm3 uhci_hcd
Mar 17 09:19:28 zmei kernel: [    3.915710] usb usb4: SerialNumber: 0000:00:1d.2
Mar 17 09:19:28 zmei kernel: [    3.915738] usb usb4: hotplug
Mar 17 09:19:28 zmei kernel: [    3.915867] usb usb4: adding 4-0:1.0 (config #1, interface 0)
Mar 17 09:19:28 zmei kernel: [    3.915886] usb 4-0:1.0: hotplug
Mar 17 09:19:28 zmei kernel: [    3.915961] hub 4-0:1.0: usb_probe_interface
Mar 17 09:19:28 zmei kernel: [    3.915964] hub 4-0:1.0: usb_probe_interface - got id
Mar 17 09:19:28 zmei kernel: [    3.915966] hub 4-0:1.0: USB hub found
Mar 17 09:19:28 zmei kernel: [    3.915993] hub 4-0:1.0: 2 ports detected
Mar 17 09:19:28 zmei kernel: [    3.916009] hub 4-0:1.0: standalone hub
Mar 17 09:19:28 zmei kernel: [    3.916011] hub 4-0:1.0: no power switching (usb 1.0)
Mar 17 09:19:28 zmei kernel: [    3.916012] hub 4-0:1.0: individual port over-current protection
Mar 17 09:19:28 zmei kernel: [    3.916015] hub 4-0:1.0: power on to power good time: 2ms
Mar 17 09:19:28 zmei kernel: [    3.916024] hub 4-0:1.0: local power source is good
Mar 17 09:19:28 zmei kernel: [    3.919390] hub 4-0:1.0: state 5 ports 2 chg 0000 evt 0000
Mar 17 09:19:28 zmei kernel: [    3.919584] mice: PS/2 mouse device common for all mice
Mar 17 09:19:28 zmei kernel: [    3.919611] perfctr/x86.c: hyper-threaded P4s detected: restricting access for CPUs 1
Mar 17 09:19:28 zmei kernel: [    3.919752] Please email the following PERFCTR INIT lines to mikpe@csd.uu.se
Mar 17 09:19:28 zmei kernel: [    3.919753] To remove this message, rebuild the driver with CONFIG_PERFCTR_INIT_TESTS=n
Mar 17 09:19:28 zmei kernel: [    3.919796] PERFCTR INIT: vendor 0, family 15, model 2, stepping 9, clock 2606843 kHz
Mar 17 09:19:28 zmei kernel: [    3.919823] PERFCTR INIT: NITER == 64
Mar 17 09:19:28 zmei kernel: [    3.919849] PERFCTR INIT: loop overhead is 552 cycles
Mar 17 09:19:28 zmei kernel: [    3.919865] PERFCTR INIT: rdtsc cost is 81.5 cycles (5768 total)
Mar 17 09:19:28 zmei kernel: [    3.919883] PERFCTR INIT: rdpmc cost is 145.9 cycles (9892 total)
Mar 17 09:19:28 zmei kernel: [    3.919900] PERFCTR INIT: rdmsr (counter) cost is 255.0 cycles (16872 total)
Mar 17 09:19:28 zmei kernel: [    3.919919] PERFCTR INIT: rdmsr (escr) cost is 166.1 cycles (11188 total)
Mar 17 09:19:28 zmei kernel: [    3.919937] PERFCTR INIT: wrmsr (counter) cost is 801.3 cycles (51836 total)
Mar 17 09:19:28 zmei kernel: [    3.919955] PERFCTR INIT: wrmsr (escr) cost is 888.8 cycles (57436 total)
Mar 17 09:19:28 zmei kernel: [    3.919973] PERFCTR INIT: read cr4 cost is 5.1 cycles (880 total)
Mar 17 09:19:28 zmei kernel: [    3.919990] PERFCTR INIT: write cr4 cost is 254.0 cycles (16808 total)
Mar 17 09:19:28 zmei kernel: [    3.920008] PERFCTR INIT: rdpmc (fast) cost is 61.1 cycles (4468 total)
Mar 17 09:19:28 zmei kernel: [    3.920026] PERFCTR INIT: rdmsr (cccr) cost is 166.9 cycles (11236 total)
Mar 17 09:19:28 zmei kernel: [    3.920044] PERFCTR INIT: wrmsr (cccr) cost is 836.8 cycles (54112 total)
Mar 17 09:19:28 zmei kernel: [    3.920062] PERFCTR INIT: write LVTPC cost is 40.1 cycles (3124 total)
Mar 17 09:19:28 zmei kernel: [    3.920080] PERFCTR INIT: sync_core cost is 263.3 cycles (17408 total)
Mar 17 09:19:28 zmei kernel: [    3.920222] perfctr: driver 2.7.10, cpu type Intel P4 at 2606843 kHz
Mar 17 09:19:28 zmei kernel: [    3.920753] Advanced Linux Sound Architecture Driver Version 1.0.8 (Thu Jan 13 09:39:32 2005 UTC).
Mar 17 09:19:28 zmei kernel: [    3.944752] input: AT Translated Set 2 keyboard on isa0060/serio0
Mar 17 09:19:28 zmei kernel: [    4.095357] ALSA device list:
Mar 17 09:19:28 zmei kernel: [    4.095375]   #0: Yamaha DS-XG (YMF724) at 0xdfef8000, irq 17
Mar 17 09:19:28 zmei kernel: [    4.095474] NET: Registered protocol family 2
Mar 17 09:19:28 zmei kernel: [    4.106967] IP: routing cache hash table of 2048 buckets, 32Kbytes
Mar 17 09:19:28 zmei kernel: [    4.107291] TCP established hash table entries: 32768 (order: 7, 524288 bytes)
Mar 17 09:19:28 zmei kernel: [    4.108040] TCP bind hash table entries: 32768 (order: 7, 524288 bytes)
Mar 17 09:19:28 zmei kernel: [    4.108762] TCP: Hash tables configured (established 32768 bind 32768)
Mar 17 09:19:28 zmei kernel: [    4.108981] NET: Registered protocol family 1
Mar 17 09:19:28 zmei kernel: [    4.109006] NET: Registered protocol family 17
Mar 17 09:19:28 zmei kernel: [    4.109192] Starting balanced_irq
Mar 17 09:19:28 zmei kernel: [    4.109241] PM: Checking swsusp image.
Mar 17 09:19:28 zmei kernel: [    4.109244] PM: Resume from disk failed.
Mar 17 09:19:28 zmei kernel: [    4.112220] VFS: Mounted root (ext2 filesystem) readonly.
Mar 17 09:19:28 zmei kernel: [    4.112465] Freeing unused kernel memory: 188k freed
Mar 17 09:19:28 zmei kernel: [    4.142002] logips2pp: Detected unknown logitech mouse model 1
Mar 17 09:19:28 zmei kernel: [    4.274620] input: PS/2 Logitech Mouse on isa0060/serio1
[EOF]
<-- and here it stops waiting forever. What actually has to come next is the init 
process, i.e. something of the likes of:
INIT version x.xx loading
but it doesn't. And by the way, how do you debug this? serial console?

.config attached.

Regards,
Boris.

--Boundary-00=_xLUOCGytPut5csj
Content-Type: text/plain;
  charset="iso-8859-1";
  name="config-2.6.11-mm4"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="config-2.6.11-mm4"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.11-mm4
# Thu Mar 17 08:33:48 2005
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_CLEAR_PAGES=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_LOCK_KERNEL=y

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_HOTPLUG=y
CONFIG_KOBJECT_UEVENT=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_CPUSETS is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_MODULE_SRCVERSION_ALL=y
CONFIG_KMOD=y
CONFIG_STOP_MACHINE=y

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
CONFIG_MPENTIUM4=y
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODE is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_HPET_TIMER=y
CONFIG_SMP=y
CONFIG_NR_CPUS=2
CONFIG_SCHED_SMT=y
CONFIG_PREEMPT=y
CONFIG_PREEMPT_BKL=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_IRQBALANCE=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_REGPARM=y
CONFIG_SECCOMP=y

#
# Performance-monitoring counters support
#
# CONFIG_PERFCTR is not set
CONFIG_PHYSICAL_START=0x100000
CONFIG_KEXEC=y

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_PM_STD_PARTITION=""

#
# ACPI (Advanced Configuration and Power Interface) Support
#
# CONFIG_ACPI is not set
CONFIG_ACPI_BOOT=y

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
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCI_MSI is not set
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
# CONFIG_HOTPLUG_CPU is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m
CONFIG_TRAP_BAD_SYSCALL_EXITS=y

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=m
# CONFIG_DEBUG_DRIVER is not set

#
# Connector - unified userspace <-> kernelspace linker
#
CONFIG_CONNECTOR=m

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_SERIAL=y
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_1284 is not set

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
# CONFIG_ISAPNP is not set
# CONFIG_PNPBIOS is not set

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_LBD is not set
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
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
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=m
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set
# CONFIG_ISCSI_IF is not set

#
# SCSI Transport Attributes
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=m
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
# CONFIG_NETLINK_DEV is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=m
CONFIG_IP_TCPDIAG=y
# CONFIG_IP_TCPDIAG_IPV6 is not set

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_CT_ACCT=y
# CONFIG_IP_NF_CONNTRACK_MARK is not set
CONFIG_IP_NF_CT_PROTO_SCTP=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_ADDRTYPE=m
CONFIG_IP_NF_MATCH_REALM=m
CONFIG_IP_NF_MATCH_SCTP=m
CONFIG_IP_NF_MATCH_COMMENT=m
CONFIG_IP_NF_MATCH_HASHLIMIT=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_SAME=m
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_CLASSIFY=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_TARGET_NOTRACK=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
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

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set
CONFIG_NET_CLS_ROUTE=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_KGDBOE=y
CONFIG_NETPOLL=y
CONFIG_NETPOLL_RX=y
CONFIG_NETPOLL_TRAP=y
CONFIG_NET_POLL_CONTROLLER=y
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
CONFIG_IEEE80211=m
# CONFIG_IEEE80211_DEBUG is not set
CONFIG_IEEE80211_CRYPT_WEP=m
CONFIG_IEEE80211_CRYPT_CCMP=m
CONFIG_IEEE80211_CRYPT_TKIP=m
CONFIG_NETDEVICES=y
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_NET_SB1000 is not set

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
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
CONFIG_8139TOO=y
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_NET_POCKET is not set

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
# CONFIG_SKGE is not set
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_CHELSIO_T1 is not set
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=y

#
# Obsolete Wireless cards support (pre-802.11)
#
# CONFIG_STRIP is not set
# CONFIG_ARLAN is not set
# CONFIG_WAVELAN is not set

#
# Wireless 802.11b ISA/PCI cards support
#
# CONFIG_AIRO is not set
# CONFIG_HERMES is not set
# CONFIG_ATMEL is not set

#
# Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support
#
# CONFIG_PRISM54 is not set
# CONFIG_HOSTAP is not set
CONFIG_NET_WIRELESS=y

#
# Wan interfaces
#
# CONFIG_WAN is not set
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
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
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
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

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
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=m
# CONFIG_INPUT_UINPUT is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

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
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
CONFIG_HW_RANDOM=m
# CONFIG_NVRAM is not set
CONFIG_RTC=m
# CONFIG_GEN_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
CONFIG_AGP_INTEL=y
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
CONFIG_DRM_RADEON=y
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I830 is not set
# CONFIG_DRM_I915 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_DRM_VIA is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# TPM devices
#
# CONFIG_TCG_TPM is not set

#
# I2C support
#
CONFIG_I2C=m
# CONFIG_I2C_CHARDEV is not set

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
# CONFIG_I2C_ISA is not set
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
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set
# CONFIG_I2C_PCA_ISA is not set

#
# Hardware Sensors Chip support
#
# CONFIG_I2C_SENSOR is not set
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_FSCHER is not set
# CONFIG_SENSORS_FSCPOS is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_VIA686A is not set
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
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# SuperIO subsystem support
#
# CONFIG_SC_SUPERIO is not set

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
# CONFIG_VIDEO_PMS is not set
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
# CONFIG_VIDEO_OVCAMCHIP is not set

#
# Radio Adapters
#
# CONFIG_RADIO_CADET is not set
# CONFIG_RADIO_RTRACK is not set
# CONFIG_RADIO_RTRACK2 is not set
# CONFIG_RADIO_AZTECH is not set
# CONFIG_RADIO_GEMTEK is not set
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set
# CONFIG_RADIO_SF16FMI is not set
# CONFIG_RADIO_SF16FMR2 is not set
# CONFIG_RADIO_TERRATEC is not set
# CONFIG_RADIO_TRUST is not set
# CONFIG_RADIO_TYPHOON is not set
# CONFIG_RADIO_ZOLTRIX is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEO_BUF=m
CONFIG_VIDEO_BTCX=m
CONFIG_VIDEO_IR=m
CONFIG_VIDEO_TVEEPROM=m

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
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_SEQUENCER=y
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_MPU401_UART=y
CONFIG_SND_OPL3_LIB=y
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# ISA devices
#
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_SGALAXY is not set
# CONFIG_SND_SSCAPE is not set

#
# PCI devices
#
CONFIG_SND_AC97_CODEC=y
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
CONFIG_SND_YMFPCI=y
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
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_HDA_INTEL is not set

#
# USB devices
#
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_USX2Y is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB=y
CONFIG_USB_DEBUG=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_SUSPEND is not set
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=y
# CONFIG_USB_EHCI_SPLIT_ISO is not set
CONFIG_USB_EHCI_ROOT_HUB_TT=y
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set

#
# USB Device Class drivers
#
CONFIG_USB_AUDIO=m
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_DEBUG=y
# CONFIG_USB_STORAGE_RW_DETECT is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set

#
# USB Input Devices
#
CONFIG_USB_HID=m
# CONFIG_USB_HIDINPUT is not set
# CONFIG_USB_HIDDEV is not set

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
# CONFIG_USB_ITMTOUCH is not set
# CONFIG_USB_EGALAX is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set
# CONFIG_USB_VICAM is not set
# CONFIG_USB_DSBR is not set
# CONFIG_USB_IBMCAM is not set
# CONFIG_USB_KONICAWC is not set
# CONFIG_USB_OV511 is not set
# CONFIG_USB_SE401 is not set
# CONFIG_USB_SN9C102 is not set
# CONFIG_USB_STV680 is not set
# CONFIG_USB_PWC is not set

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_ZD1201 is not set
CONFIG_USB_MON=y

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
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGETKIT is not set
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_TEST is not set

#
# USB ATM/DSL drivers
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

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
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y

#
# XFS support
#
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=y
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_CACHEFS=m
# CONFIG_FUSE_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=m
CONFIG_NTFS_DEBUG=y
CONFIG_NTFS_RW=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y
CONFIG_RELAYFS_FS=m

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
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFS_V4=y
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
# CONFIG_RPCSEC_GSS_SPKM3 is not set
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS is not set
# CONFIG_CIFS_XATTR is not set
# CONFIG_CIFS_EXPERIMENTAL is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-15"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_PRINTK_TIME=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_LOG_BUF_SHIFT=15
CONFIG_DETECT_SOFTLOCKUP=y
CONFIG_SCHEDSTATS=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_PREEMPT=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_INFO is not set
CONFIG_PAGE_OWNER=y
CONFIG_DEBUG_FS=y
CONFIG_FRAME_POINTER=y
CONFIG_EARLY_PRINTK=y
CONFIG_DEBUG_STACKOVERFLOW=y
# CONFIG_KPROBES is not set
CONFIG_DEBUG_STACK_USAGE=y

#
# Page alloc debug is incompatible with Software Suspend on i386
#
CONFIG_4KSTACKS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_KGDB=y
# CONFIG_KGDB_9600BAUD is not set
# CONFIG_KGDB_19200BAUD is not set
# CONFIG_KGDB_38400BAUD is not set
# CONFIG_KGDB_57600BAUD is not set
CONFIG_KGDB_115200BAUD=y
CONFIG_KGDB_PORT=0x3f8
CONFIG_KGDB_IRQ=4
# CONFIG_KGDB_MORE is not set
CONFIG_NO_KGDB_CPUS=2
# CONFIG_KGDB_TS is not set
CONFIG_STACK_OVERFLOW_TEST=y
CONFIG_KGDB_CONSOLE=y
CONFIG_KGDB_SYSRQ=y

#
# Security options
#
# CONFIG_KEYS is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_CAPABILITIES=y
# CONFIG_SECURITY_ROOTPLUG is not set
CONFIG_SECURITY_SECLVL=m
# CONFIG_SECURITY_SELINUX is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
# CONFIG_CRYPTO_HMAC is not set
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_AES_586=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_CRC32C=m
CONFIG_CRYPTO_TEST=m

#
# Hardware crypto devices
#
# CONFIG_CRYPTO_DEV_PADLOCK is not set

#
# Library routines
#
CONFIG_CRC_CCITT=m
CONFIG_CRC32=y
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y
CONFIG_PC=y

--Boundary-00=_xLUOCGytPut5csj--
