Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261483AbUKFWMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbUKFWMU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 17:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbUKFWMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 17:12:20 -0500
Received: from alpha.lic1.vsi.ru ([80.82.34.34]:52181 "EHLO alpha.lic1.vsi.ru")
	by vger.kernel.org with ESMTP id S261483AbUKFWLu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 17:11:50 -0500
Message-ID: <418D4C16.9020504@lic1.vsi.ru>
Date: Sun, 07 Nov 2004 01:11:34 +0300
From: "Igor A. Valcov" <viaprog@lic1.vsi.ru>
Reply-To: viaprog@lic1.vsi.ru
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040921
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: linux 2.6.9-ac6 kernel messages
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I saw this in my dmesg:

Badness in futex_wait at kernel/futex.c:542
  [<c0129f3e>] futex_wait+0x17d/0x187
  [<c0114dae>] default_wake_function+0x0/0xc
  [<c011afdf>] do_wait+0x1b8/0x4b9
  [<c0114dae>] default_wake_function+0x0/0xc
  [<c010a4fb>] convert_fxsr_from_user+0x15/0xd8
  [<c012a15e>] do_futex+0x35/0x7f
  [<c012a288>] sys_futex+0xe0/0xec
  [<c0103e85>] sysenter_past_esp+0x52/0x71
Badness in futex_wait at kernel/futex.c:542
  [<c0129f3e>] futex_wait+0x17d/0x187
  [<c0114dae>] default_wake_function+0x0/0xc
  [<c011afdf>] do_wait+0x1b8/0x4b9
  [<c0114dae>] default_wake_function+0x0/0xc
  [<c0114b70>] scheduler_tick+0x1fa/0x438
  [<c012a15e>] do_futex+0x35/0x7f
  [<c012a288>] sys_futex+0xe0/0xec
  [<c0103e85>] sysenter_past_esp+0x52/0x71

root@alpha-viaprog viaprog # emerge -pv glibc

These are the packages that I would merge, in order:

Calculating dependencies ...done!
[ebuild   R   ] sys-libs/glibc-2.3.4.20040808-r1  -build -debug -erandom 
-hardened -makecheck -multilib +nls +nptl -pic -userlocales 0 kB

Nov  5 22:17:23 alpha-viaprog kernel: Linux version 2.6.9-ac6 
(root@alpha-viaprog) (gcc version 3.3.4 20040623 (Gentoo Linux 3.3.4-r1, 
ssp-3.3.2-2, pie-8.7.6)) #1 Mon Nov 1 22:35:35 MSK 2004
Nov  5 22:17:23 alpha-viaprog kernel: BIOS-provided physical RAM map:
Nov  5 22:17:23 alpha-viaprog kernel:  BIOS-e820: 0000000000000000 - 
00000000000a0000 (usable)
Nov  5 22:17:23 alpha-viaprog kernel:  BIOS-e820: 00000000000f0000 - 
0000000000100000 (reserved)
Nov  5 22:17:23 alpha-viaprog kernel:  BIOS-e820: 0000000000100000 - 
000000002fff0000 (usable)
Nov  5 22:17:23 alpha-viaprog kernel:  BIOS-e820: 000000002fff0000 - 
000000002fff3000 (ACPI NVS)
Nov  5 22:17:23 alpha-viaprog kernel:  BIOS-e820: 000000002fff3000 - 
0000000030000000 (ACPI data)
Nov  5 22:17:23 alpha-viaprog kernel:  BIOS-e820: 00000000fec00000 - 
0000000100000000 (reserved)
Nov  5 22:17:23 alpha-viaprog kernel: 767MB LOWMEM available.
Nov  5 22:17:23 alpha-viaprog kernel: found SMP MP-table at 000f4880
Nov  5 22:17:23 alpha-viaprog kernel: DMI 2.3 present.
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: PM-Timer IO Port: 0x4008
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: LAPIC (acpi_id[0x00] 
lapic_id[0x00] enabled)
Nov  5 22:17:23 alpha-viaprog kernel: Processor #0 15:2 APIC version 20
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: LAPIC_NMI (acpi_id[0xff] dfl 
dfl lint[0x1])
Nov  5 22:17:23 alpha-viaprog kernel: Using ACPI for processor (LAPIC) 
configuration information
Nov  5 22:17:23 alpha-viaprog kernel: Intel MultiProcessor Specification 
v1.4
Nov  5 22:17:23 alpha-viaprog kernel:     Virtual Wire compatibility mode.
Nov  5 22:17:23 alpha-viaprog kernel: OEM ID: OEM00000 Product ID: 
PROD00000000 APIC at: 0xFEE00000
Nov  5 22:17:23 alpha-viaprog kernel: I/O APIC #2 Version 17 at 0xFEC00000.
Nov  5 22:17:23 alpha-viaprog kernel: Enabling APIC mode:  Flat.  Using 
1 I/O APICs
Nov  5 22:17:23 alpha-viaprog kernel: Processors: 1
Nov  5 22:17:23 alpha-viaprog kernel: Built 1 zonelists
Nov  5 22:17:23 alpha-viaprog kernel: Kernel command line: root=/dev/hda2
Nov  5 22:17:23 alpha-viaprog kernel: Initializing CPU#0
Nov  5 22:17:23 alpha-viaprog kernel: PID hash table entries: 4096 
(order: 12, 65536 bytes)
Nov  5 22:17:23 alpha-viaprog kernel: Detected 2392.109 MHz processor.
Nov  5 22:17:23 alpha-viaprog kernel: Using pmtmr for high-res timesource
Nov  5 22:17:23 alpha-viaprog kernel: Console: colour VGA+ 80x25
Nov  5 22:17:23 alpha-viaprog kernel: Dentry cache hash table entries: 
131072 (order: 7, 524288 bytes)
Nov  5 22:17:23 alpha-viaprog kernel: Inode-cache hash table entries: 
65536 (order: 6, 262144 bytes)
Nov  5 22:17:23 alpha-viaprog kernel: Memory: 775488k/786368k available 
(2122k kernel code, 10388k reserved, 906k data, 140k init, 0k highmem)
Nov  5 22:17:23 alpha-viaprog kernel: Checking if this processor honours 
the WP bit even in supervisor mode... Ok.
Nov  5 22:17:23 alpha-viaprog kernel: Security Scaffold v1.0.0 initialized
Nov  5 22:17:23 alpha-viaprog kernel: Capability LSM initialized
Nov  5 22:17:23 alpha-viaprog kernel: Mount-cache hash table entries: 
512 (order: 0, 4096 bytes)
Nov  5 22:17:23 alpha-viaprog kernel: CPU: Trace cache: 12K uops, L1 D 
cache: 8K
Nov  5 22:17:23 alpha-viaprog kernel: CPU: L2 cache: 512K
Nov  5 22:17:23 alpha-viaprog kernel: Intel machine check architecture 
supported.
Nov  5 22:17:23 alpha-viaprog kernel: Intel machine check reporting 
enabled on CPU#0.
Nov  5 22:17:23 alpha-viaprog kernel: CPU0: Intel P4/Xeon Extended MCE 
MSRs (12) available
Nov  5 22:17:23 alpha-viaprog kernel: CPU0: Thermal monitoring enabled
Nov  5 22:17:23 alpha-viaprog kernel: CPU: Intel(R) Pentium(R) 4 CPU 
1.80GHz stepping 04
Nov  5 22:17:23 alpha-viaprog kernel: Enabling fast FPU save and 
restore... done.
Nov  5 22:17:23 alpha-viaprog kernel: Enabling unmasked SIMD FPU 
exception support... done.
Nov  5 22:17:23 alpha-viaprog kernel: Checking 'hlt' instruction... OK.
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: IRQ9 SCI: Level Trigger.
Nov  5 22:17:23 alpha-viaprog kernel: NET: Registered protocol family 16
Nov  5 22:17:23 alpha-viaprog kernel: PCI: PCI BIOS revision 2.10 entry 
at 0xfb1e0, last bus=2
Nov  5 22:17:23 alpha-viaprog kernel: PCI: Using configuration type 1
Nov  5 22:17:23 alpha-viaprog kernel: mtrr: v2.0 (20020519)
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: Subsystem revision 20040816
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: Interpreter enabled
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: Using PIC for interrupt routing
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Nov  5 22:17:23 alpha-viaprog kernel: PCI: Probing PCI hardware (bus 00)
Nov  5 22:17:23 alpha-viaprog kernel: PCI: Ignoring BAR0-3 of IDE 
controller 0000:00:1f.1
Nov  5 22:17:23 alpha-viaprog kernel: PCI: Transparent bridge - 0000:00:1e.0
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: PCI Interrupt Link [LNKA] 
(IRQs 3 4 5 6 7 9 10 11 *12 14 15)
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: PCI Interrupt Link [LNKB] 
(IRQs 3 4 *5 6 7 9 10 11 12 14 15)
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: PCI Interrupt Link [LNKC] 
(IRQs 3 4 5 6 7 9 *10 11 12 14 15)
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: PCI Interrupt Link [LNKD] 
(IRQs 3 4 5 6 7 9 *10 11 12 14 15)
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: PCI Interrupt Link [LNKE] 
(IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: PCI Interrupt Link [LNKF] 
(IRQs 3 4 5 6 7 *9 10 11 12 14 15)
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: PCI Interrupt Link [LNK0] 
(IRQs 3 4 5 6 7 9 10 *11 12 14 15)
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: PCI Interrupt Link [LNK1] 
(IRQs 3 4 5 6 7 9 10 *11 12 14 15)
Nov  5 22:17:23 alpha-viaprog kernel: SCSI subsystem initialized
Nov  5 22:17:23 alpha-viaprog kernel: usbcore: registered new driver usbfs
Nov  5 22:17:23 alpha-viaprog kernel: usbcore: registered new driver hub
Nov  5 22:17:23 alpha-viaprog kernel: PCI: Using ACPI for IRQ routing
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: PCI Interrupt Link [LNKA] 
enabled at IRQ 12
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: PCI interrupt 
0000:00:1d.0[A] -> GSI 12 (level, low) -> IRQ 12
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: PCI Interrupt Link [LNKD] 
enabled at IRQ 10
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: PCI interrupt 
0000:00:1d.1[B] -> GSI 10 (level, low) -> IRQ 10
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: PCI Interrupt Link [LNKC] 
enabled at IRQ 10
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: PCI interrupt 
0000:00:1d.2[C] -> GSI 10 (level, low) -> IRQ 10
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: PCI Interrupt Link [LNK1] 
enabled at IRQ 11
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: PCI interrupt 
0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: PCI interrupt 
0000:00:1f.1[A] -> GSI 10 (level, low) -> IRQ 10
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: PCI Interrupt Link [LNKB] 
enabled at IRQ 5
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: PCI interrupt 
0000:00:1f.3[B] -> GSI 5 (level, low) -> IRQ 5
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: PCI interrupt 
0000:00:1f.5[B] -> GSI 5 (level, low) -> IRQ 5
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: PCI interrupt 
0000:01:00.0[A] -> GSI 12 (level, low) -> IRQ 12
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: PCI interrupt 
0000:02:00.0[A] -> GSI 10 (level, low) -> IRQ 10
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: PCI Interrupt Link [LNKF] 
enabled at IRQ 9
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: PCI interrupt 
0000:02:01.0[A] -> GSI 9 (level, low) -> IRQ 9
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: PCI Interrupt Link [LNK0] 
enabled at IRQ 11
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: PCI interrupt 
0000:02:02.0[A] -> GSI 11 (level, low) -> IRQ 11
Nov  5 22:17:23 alpha-viaprog kernel: Machine check exception polling 
timer started.
Nov  5 22:17:23 alpha-viaprog kernel: IA-32 Microcode Update Driver: 
v1.14 <tigran@veritas.com>
Nov  5 22:17:23 alpha-viaprog kernel: VFS: Disk quotas dquot_6.5.1
Nov  5 22:17:23 alpha-viaprog kernel: Dquot-cache hash table entries: 
1024 (order 0, 4096 bytes)
Nov  5 22:17:23 alpha-viaprog kernel: devfs: 2004-01-31 Richard Gooch 
(rgooch@atnf.csiro.au)
Nov  5 22:17:23 alpha-viaprog kernel: devfs: boot_options: 0x0
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: Power Button (FF) [PWRF]
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: Sleep Button (CM) [SLPB]
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: Processor [CPU0] (supports 
C1, 2 throttling states)
Nov  5 22:17:23 alpha-viaprog kernel: lp: driver loaded but no devices found
Nov  5 22:17:23 alpha-viaprog kernel: Real Time Clock Driver v1.12
Nov  5 22:17:23 alpha-viaprog kernel: Non-volatile memory driver v1.2
Nov  5 22:17:23 alpha-viaprog kernel: serio: i8042 AUX port at 0x60,0x64 
irq 12
Nov  5 22:17:23 alpha-viaprog kernel: serio: i8042 KBD port at 0x60,0x64 
irq 1
Nov  5 22:17:23 alpha-viaprog kernel: Serial: 8250/16550 driver 
$Revision: 1.90 $ 8 ports, IRQ sharing disabled
Nov  5 22:17:23 alpha-viaprog kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 
16550A
Nov  5 22:17:23 alpha-viaprog kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 
16550A
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: PCI interrupt 
0000:02:01.0[A] -> GSI 9 (level, low) -> IRQ 9
Nov  5 22:17:23 alpha-viaprog kernel: ttyS4 at I/O 0x9400 (irq = 9) is a 
16550A
Nov  5 22:17:23 alpha-viaprog kernel: parport0: PC-style at 0x378 
[PCSPP(,...)]
Nov  5 22:17:23 alpha-viaprog kernel: lp0: using parport0 (polling).
Nov  5 22:17:23 alpha-viaprog kernel: Using anticipatory io scheduler
Nov  5 22:17:23 alpha-viaprog kernel: Floppy drive(s): fd0 is 1.44M
Nov  5 22:17:23 alpha-viaprog kernel: FDC 0 is a post-1991 82077
Nov  5 22:17:23 alpha-viaprog kernel: loop: loaded (max 8 devices)
Nov  5 22:17:23 alpha-viaprog kernel: nbd: registered device at major 43
Nov  5 22:17:23 alpha-viaprog kernel: PPP generic driver version 2.4.2
Nov  5 22:17:23 alpha-viaprog kernel: PPP Deflate Compression module 
registered
Nov  5 22:17:23 alpha-viaprog kernel: PPP BSD Compression module registered
Nov  5 22:17:23 alpha-viaprog kernel: 8139too Fast Ethernet driver 0.9.27
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: PCI interrupt 
0000:02:00.0[A] -> GSI 10 (level, low) -> IRQ 10
Nov  5 22:17:23 alpha-viaprog kernel: eth0: RealTek RTL8139 at 
0xf0802000, 00:05:1c:18:5f:50, IRQ 10
Nov  5 22:17:23 alpha-viaprog kernel: Uniform Multi-Platform E-IDE 
driver Revision: 7.00alpha2
Nov  5 22:17:23 alpha-viaprog kernel: ide: Assuming 33MHz system bus 
speed for PIO modes; override with idebus=xx
Nov  5 22:17:23 alpha-viaprog kernel: ICH4: IDE controller at PCI slot 
0000:00:1f.1
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: PCI interrupt 
0000:00:1f.1[A] -> GSI 10 (level, low) -> IRQ 10
Nov  5 22:17:23 alpha-viaprog kernel: ICH4: chipset revision 1
Nov  5 22:17:23 alpha-viaprog kernel: ICH4: not 100%% native mode: will 
probe irqs later
Nov  5 22:17:23 alpha-viaprog kernel:     ide0: BM-DMA at 0xcc00-0xcc07, 
BIOS settings: hda:DMA, hdb:pio
Nov  5 22:17:23 alpha-viaprog kernel:     ide1: BM-DMA at 0xcc08-0xcc0f, 
BIOS settings: hdc:DMA, hdd:DMA
Nov  5 22:17:23 alpha-viaprog kernel: hda: ST3120026A, ATA DISK drive
Nov  5 22:17:23 alpha-viaprog kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Nov  5 22:17:23 alpha-viaprog kernel: hdc: _NEC DVD_RW ND-3500AG, ATAPI 
CD/DVD-ROM drive
Nov  5 22:17:23 alpha-viaprog kernel: hdd: ST3120026A, ATA DISK drive
Nov  5 22:17:23 alpha-viaprog kernel: ide1 at 0x170-0x177,0x376 on irq 15
Nov  5 22:17:23 alpha-viaprog kernel: PDC20269: IDE controller at PCI 
slot 0000:02:02.0
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: PCI interrupt 
0000:02:02.0[A] -> GSI 11 (level, low) -> IRQ 11
Nov  5 22:17:23 alpha-viaprog kernel: PDC20269: chipset revision 2
Nov  5 22:17:23 alpha-viaprog kernel: PDC20269: 100%% native mode on irq 11
Nov  5 22:17:23 alpha-viaprog kernel:     ide2: BM-DMA at 0xa800-0xa807, 
BIOS settings: hde:pio, hdf:pio
Nov  5 22:17:23 alpha-viaprog kernel:     ide3: BM-DMA at 0xa808-0xa80f, 
BIOS settings: hdg:pio, hdh:pio
Nov  5 22:17:23 alpha-viaprog kernel: hde: ST3200822A, ATA DISK drive
Nov  5 22:17:23 alpha-viaprog kernel: ide2 at 0x9800-0x9807,0x9c02 on irq 11
Nov  5 22:17:23 alpha-viaprog kernel: hdg: ST340810A, ATA DISK drive
Nov  5 22:17:23 alpha-viaprog kernel: ide3 at 0xa000-0xa007,0xa402 on irq 11
Nov  5 22:17:23 alpha-viaprog kernel: hda: max request size: 1024KiB
Nov  5 22:17:23 alpha-viaprog kernel: hda: 234441648 sectors (120034 MB) 
w/8192KiB Cache, CHS=16383/255/63, UDMA(100)
Nov  5 22:17:23 alpha-viaprog kernel:  /dev/ide/host0/bus0/target0/lun0: 
p1 p2 p3
Nov  5 22:17:23 alpha-viaprog kernel: hdd: max request size: 1024KiB
Nov  5 22:17:23 alpha-viaprog kernel: hdd: 234441648 sectors (120034 MB) 
w/8192KiB Cache, CHS=16383/255/63, UDMA(100)
Nov  5 22:17:23 alpha-viaprog kernel:  /dev/ide/host0/bus1/target1/lun0: 
p1 p2 p3 p4
Nov  5 22:17:23 alpha-viaprog kernel: hde: max request size: 1024KiB
Nov  5 22:17:23 alpha-viaprog kernel: hde: 390721968 sectors (200049 MB) 
w/8192KiB Cache, CHS=24321/255/63, UDMA(100)
Nov  5 22:17:23 alpha-viaprog kernel:  /dev/ide/host2/bus0/target0/lun0: 
p1 p2
Nov  5 22:17:23 alpha-viaprog kernel: hdg: max request size: 128KiB
Nov  5 22:17:23 alpha-viaprog kernel: hdg: 78165360 sectors (40020 MB) 
w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
Nov  5 22:17:23 alpha-viaprog kernel:  /dev/ide/host2/bus1/target0/lun0: p1
Nov  5 22:17:23 alpha-viaprog kernel: hdc: ATAPI 48X DVD-ROM DVD-R 
CD-R/RW drive, 2048kB Cache, UDMA(33)
Nov  5 22:17:23 alpha-viaprog kernel: Uniform CD-ROM driver Revision: 3.20
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: PCI interrupt 
0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11
Nov  5 22:17:23 alpha-viaprog kernel: ehci_hcd 0000:00:1d.7: Intel Corp. 
82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Controller
Nov  5 22:17:23 alpha-viaprog kernel: ehci_hcd 0000:00:1d.7: irq 11, pci 
mem f080e000
Nov  5 22:17:23 alpha-viaprog kernel: ehci_hcd 0000:00:1d.7: new USB bus 
registered, assigned bus number 1
Nov  5 22:17:23 alpha-viaprog kernel: ehci_hcd 0000:00:1d.7: USB 2.0 
enabled, EHCI 1.00, driver 2004-May-10
Nov  5 22:17:23 alpha-viaprog kernel: hub 1-0:1.0: USB hub found
Nov  5 22:17:23 alpha-viaprog kernel: hub 1-0:1.0: 6 ports detected
Nov  5 22:17:23 alpha-viaprog kernel: USB Universal Host Controller 
Interface driver v2.2
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: PCI interrupt 
0000:00:1d.0[A] -> GSI 12 (level, low) -> IRQ 12
Nov  5 22:17:23 alpha-viaprog kernel: uhci_hcd 0000:00:1d.0: Intel Corp. 
82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1
Nov  5 22:17:23 alpha-viaprog kernel: uhci_hcd 0000:00:1d.0: irq 12, io 
base 0000b800
Nov  5 22:17:23 alpha-viaprog kernel: uhci_hcd 0000:00:1d.0: new USB bus 
registered, assigned bus number 2
Nov  5 22:17:23 alpha-viaprog kernel: hub 2-0:1.0: USB hub found
Nov  5 22:17:23 alpha-viaprog kernel: hub 2-0:1.0: 2 ports detected
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: PCI interrupt 
0000:00:1d.1[B] -> GSI 10 (level, low) -> IRQ 10
Nov  5 22:17:23 alpha-viaprog kernel: uhci_hcd 0000:00:1d.1: Intel Corp. 
82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2
Nov  5 22:17:23 alpha-viaprog kernel: uhci_hcd 0000:00:1d.1: irq 10, io 
base 0000b000
Nov  5 22:17:23 alpha-viaprog kernel: uhci_hcd 0000:00:1d.1: new USB bus 
registered, assigned bus number 3
Nov  5 22:17:23 alpha-viaprog kernel: hub 3-0:1.0: USB hub found
Nov  5 22:17:23 alpha-viaprog kernel: hub 3-0:1.0: 2 ports detected
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: PCI interrupt 
0000:00:1d.2[C] -> GSI 10 (level, low) -> IRQ 10
Nov  5 22:17:23 alpha-viaprog kernel: uhci_hcd 0000:00:1d.2: Intel Corp. 
82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3
Nov  5 22:17:23 alpha-viaprog kernel: uhci_hcd 0000:00:1d.2: irq 10, io 
base 0000b400
Nov  5 22:17:23 alpha-viaprog kernel: uhci_hcd 0000:00:1d.2: new USB bus 
registered, assigned bus number 4
Nov  5 22:17:23 alpha-viaprog kernel: hub 4-0:1.0: USB hub found
Nov  5 22:17:23 alpha-viaprog kernel: hub 4-0:1.0: 2 ports detected
Nov  5 22:17:23 alpha-viaprog kernel: usbcore: registered new driver usblp
Nov  5 22:17:23 alpha-viaprog kernel: drivers/usb/class/usblp.c: v0.13: 
USB Printer Device Class driver
Nov  5 22:17:23 alpha-viaprog kernel: Initializing USB Mass Storage 
driver...
Nov  5 22:17:23 alpha-viaprog kernel: usbcore: registered new driver 
usb-storage
Nov  5 22:17:23 alpha-viaprog kernel: USB Mass Storage support registered.
Nov  5 22:17:23 alpha-viaprog kernel: usbcore: registered new driver usbhid
Nov  5 22:17:23 alpha-viaprog kernel: drivers/usb/input/hid-core.c: 
v2.0:USB HID core driver
Nov  5 22:17:23 alpha-viaprog kernel: mice: PS/2 mouse device common for 
all mice
Nov  5 22:17:23 alpha-viaprog kernel: input: AT Translated Set 2 
keyboard on isa0060/serio0
Nov  5 22:17:23 alpha-viaprog kernel: usb 4-2: new low speed USB device 
using address 2
Nov  5 22:17:23 alpha-viaprog kernel: input: PC Speaker
Nov  5 22:17:23 alpha-viaprog kernel: Intel 810 + AC97 Audio, version 
1.01, 22:33:07 Nov  1 2004
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: PCI interrupt 
0000:00:1f.5[B] -> GSI 5 (level, low) -> IRQ 5
Nov  5 22:17:23 alpha-viaprog kernel: i810: Intel ICH4 found at IO 
0xd800 and 0xd400, MEM 0xec002000 and 0xec003000, IRQ 5
Nov  5 22:17:23 alpha-viaprog kernel: i810: Intel ICH4 mmio at 
0xf0810000 and 0xf0812000
Nov  5 22:17:23 alpha-viaprog kernel: input: USB HID v1.10 Mouse 
[Logitech USB-PS/2 Optical Mouse] on usb-0000:00:1d.2-2
Nov  5 22:17:23 alpha-viaprog kernel: i810_audio: Primary codec has ID 0
Nov  5 22:17:23 alpha-viaprog kernel: i810_audio: Audio Controller 
supports 6 channels.
Nov  5 22:17:23 alpha-viaprog kernel: i810_audio: Defaulting to base 2 
channel mode.
Nov  5 22:17:23 alpha-viaprog kernel: i810_audio: Resetting connection 0
Nov  5 22:17:23 alpha-viaprog kernel: i810_audio: Connection 0 with 
codec id 0
Nov  5 22:17:23 alpha-viaprog kernel: ac97_codec: AC97 Audio codec, id: 
ALG32 (ALC650)
Nov  5 22:17:23 alpha-viaprog kernel: i810_audio: AC'97 codec 0 supports 
AMAP, total channels = 6
Nov  5 22:17:23 alpha-viaprog kernel: NET: Registered protocol family 2
Nov  5 22:17:23 alpha-viaprog kernel: IP: routing cache hash table of 
8192 buckets, 64Kbytes
Nov  5 22:17:23 alpha-viaprog kernel: TCP: Hash tables configured 
(established 262144 bind 65536)
Nov  5 22:17:23 alpha-viaprog kernel: ip_conntrack version 2.1 (6143 
buckets, 49144 max) - 300 bytes per conntrack
Nov  5 22:17:23 alpha-viaprog kernel: ip_tables: (C) 2000-2002 Netfilter 
core team
Nov  5 22:17:23 alpha-viaprog kernel: ipt_recent v0.3.1: Stephen Frost 
<sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
Nov  5 22:17:23 alpha-viaprog kernel: arp_tables: (C) 2002 David S. Miller
Nov  5 22:17:23 alpha-viaprog kernel: NET: Registered protocol family 1
Nov  5 22:17:23 alpha-viaprog kernel: NET: Registered protocol family 17
Nov  5 22:17:23 alpha-viaprog kernel: NET: Registered protocol family 15
Nov  5 22:17:23 alpha-viaprog kernel: ACPI: (supports S0 S3 S4 S5)
Nov  5 22:17:23 alpha-viaprog kernel: ACPI wakeup devices:
Nov  5 22:17:23 alpha-viaprog kernel: SLPB PCI0 HUB0 USB0 USB1 USB2 USB3
Nov  5 22:17:23 alpha-viaprog kernel: EXT3-fs: mounted filesystem with 
ordered data mode.
Nov  5 22:17:23 alpha-viaprog kernel: VFS: Mounted root (ext3 
filesystem) readonly.
Nov  5 22:17:23 alpha-viaprog kernel: Freeing unused kernel memory: 140k 
freed
Nov  5 22:17:23 alpha-viaprog kernel: kjournald starting.  Commit 
interval 5 seconds
Nov  5 22:17:23 alpha-viaprog kernel: Adding 1028152k swap on /dev/hda1. 
  Priority:43 extents:1
Nov  5 22:17:23 alpha-viaprog kernel: Adding 1004020k swap on /dev/hde1. 
  Priority:43 extents:1
Nov  5 22:17:23 alpha-viaprog kernel: EXT3 FS on hda2, internal journal
Nov  5 22:17:23 alpha-viaprog kernel: kjournald starting.  Commit 
interval 5 seconds
Nov  5 22:17:23 alpha-viaprog kernel: EXT3 FS on hda3, internal journal
Nov  5 22:17:23 alpha-viaprog kernel: EXT3-fs: mounted filesystem with 
ordered data mode.
Nov  5 22:17:23 alpha-viaprog kernel: kjournald starting.  Commit 
interval 5 seconds
Nov  5 22:17:23 alpha-viaprog kernel: EXT3 FS on hdg1, internal journal
Nov  5 22:17:23 alpha-viaprog kernel: EXT3-fs: mounted filesystem with 
ordered data mode.
Nov  5 22:17:23 alpha-viaprog kernel: kjournald starting.  Commit 
interval 5 seconds
Nov  5 22:17:23 alpha-viaprog kernel: EXT3 FS on hde2, internal journal
Nov  5 22:17:23 alpha-viaprog kernel: EXT3-fs: mounted filesystem with 
ordered data mode.
-- 
Igor A. Valcov
