Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269623AbUICK1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269623AbUICK1h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 06:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269615AbUICK0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 06:26:24 -0400
Received: from mailgate.urz.tu-dresden.de ([141.30.66.154]:39815 "EHLO
	mailgate.urz.tu-dresden.de") by vger.kernel.org with ESMTP
	id S269595AbUICKWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 06:22:45 -0400
Message-ID: <1094206957.413845ed84b54@rmc60-231.urz.tu-dresden.de>
Date: Fri,  3 Sep 2004 12:22:37 +0200
From: Hendrik Fehr <s4248297@rcs.urz.tu-dresden.de>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Full CPU-usage on sis5513-chipset disc input/output-operations
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 217.238.206.14
X-TUD-Virus-Scanned: by amavisd-new at rks24.urz.tu-dresden.de
X-TUD-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on rks24
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Please post the boot "dmesg" log.
> 

This is, what dmesg gives me with 2.6.9-rc1-bk8:
(note: i use ide0=ata66 because my machine is a laptop which uses a short 40c
wire that is equal to an long (i thing 18 inches) 80c cable.)

Linux version 2.6.9-rc1-bk8 (hefe@anfortas) (gcc-Version 3.3.4 20040623 (Gentoo
Linux 3.3.4-r1, ssp-3.3.2-2, pie-8.7.6)) #1 Wed Sep 1 14:44:55 MEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d0000 - 00000000000d8000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fdf0000 (usable)
 BIOS-e820: 000000001fdf0000 - 000000001fdfb000 (ACPI data)
 BIOS-e820: 000000001fdfb000 - 000000001fe00000 (ACPI NVS)
 BIOS-e820: 000000001fe00000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
509MB LOWMEM available.
found SMP MP-table at 000f6990
On node 0 totalpages: 130544
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126448 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f69f0
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x1fdf7151
ACPI: FADT (v001 ECS     G732    0x06040000 PTL  0x000f4240) @ 0x1fdfaf3c
ACPI: MADT (v001 PTLTD           APIC   0x06040000  LTP 0x00000000) @
0x1fdfafb0
ACPI: DSDT (v001 PTLTD     ECS   0x06040000 MSFT 0x0100000e) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 16 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ11 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: BOOT_IMAGE=bk8dev26 root=305 psmouse.proto=imps hdc=cdrom
ide0=ata66
ide_setup: hdc=cdrom
ide_setup: ide0=ata66
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 2390.684 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 514196k/522176k available (1828k kernel code, 7456k reserved, 754k data,
148k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 4718.59 BogoMIPS (lpj=2359296)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=16 pin2=-1
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...  failed.
...trying to set up timer as Virtual Wire IRQ... works.
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xfd9b8, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040715
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Uncovering SIS962 that hid as a SIS503 (compatible=1)
Enabling SiS 96x SMBus.
PCI: Ignoring BAR0-3 of IDE controller 0000:00:02.5
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 5 10 11) *4
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 *9 10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 *9 10 11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 4 5 10 11) *9
ACPI: PCI Interrupt Link [LNKF] (IRQs 4 5 10 *11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 4 5 *10 11)
ACPI: PCI Interrupt Link [LNKH] (IRQs 4 *5 10 11)
ACPI: Embedded Controller [EC] (gpe 26)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: the driver 'system' has been registered
PCI: Using ACPI for IRQ routing
ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI interrupt 0000:00:02.3[B] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI interrupt 0000:00:02.5[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI interrupt 0000:00:02.6[C] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI interrupt 0000:00:02.7[C] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI interrupt 0000:00:03.0[A] -> GSI 20 (level, low) -> IRQ 20
ACPI: PCI interrupt 0000:00:03.1[B] -> GSI 21 (level, low) -> IRQ 21
ACPI: PCI interrupt 0000:00:03.2[C] -> GSI 22 (level, low) -> IRQ 22
ACPI: PCI interrupt 0000:00:03.3[D] -> GSI 23 (level, low) -> IRQ 23
ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 19 (level, low) -> IRQ 19
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=260.00 Mhz, System=200.00 MHz
Non-DDC laptop panel detected
radeonfb: Monitor 1 type LCD found
radeonfb: Monitor 2 type no found
radeonfb: panel ID string: Samsung LTN150P1-L02
radeonfb: detected LVDS panel size from BIOS: 1400x1050
radeondb: BIOS provided dividers will be used
radeonfb: Power Management enabled for Mobility chipsets
radeonfb: ATI Radeon Lf  DDR SGRAM 64 MB
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
ACPI: AC Adapter [ADP0] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Processor [CPU0] (supports C1)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Console: switching to colour frame buffer device 175x65
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected SiS 646 chipset
agpgart: Maximum main memory to use for agp memory: 437M
agpgart: AGP aperture is 128M @ 0xe0000000
[drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI Technologies Inc Radeon
R250 Lf [Radeon Mobility 9000 M9]
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS1 at I/O 0x2f8 (irq = 3) is a 8250
PCI: Enabling device 0000:00:02.6 (0000 -> 0001)
ACPI: PCI interrupt 0000:00:02.6[C] -> GSI 18 (level, low) -> IRQ 18
pnp: the driver 'serial' has been registered
sis900.c: v1.08.07 11/02/2003
ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 19 (level, low) -> IRQ 19
eth0: Realtek RTL8201 PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0xf800, IRQ 19, 00:50:eb:1d:af:9a.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
ACPI: PCI interrupt 0000:00:02.5[A] -> GSI 16 (level, low) -> IRQ 16
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
    ide0: BM-DMA at 0x2000-0x2007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x2008-0x200f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: TOSHIBA MK4021GAS, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: QSI CD-RW/DVD-ROM SBW-241, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB), CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 p6 p7 p8 >
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: PS/2 Synaptics TouchPad on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S3 S4 S5)
ACPI wakeup devices:
PCI0 USB0 USB1 USB2 USB3  LAN PCI1 PCI2 CRD0 AC97
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
kjournald starting.  Commit interval 5 seconds
Mounted devfs on /dev
Freeing unused kernel memory: 148k freed
Adding 489972k swap on /dev/hda2.  Priority:-1 extents:1
EXT3 FS on hda5, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eth0: Media Link On 100mbps full-duplex
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
[drm] Loading R200 Microcode
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
[drm] Loading R200 Microcode
APIC error on CPU0: 00(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
