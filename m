Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbVJQVHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbVJQVHn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 17:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbVJQVHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 17:07:43 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:36785 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S932326AbVJQVHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 17:07:42 -0400
Date: Mon, 17 Oct 2005 23:07:23 +0200
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: 2.6.14-rc4-mm1, acpi, irq problems, hdc (cdrom) dead
Message-ID: <20051017210723.GA17760@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


Hi Andrew, hi ACPI developers!

Since some kernel revisions (hard to tell since when, I don't use cdrom
very often), the cdrom hdc is not working any more:

vmunix: hdc: lost interrupt
vmunix: cdrom_pc_intr, write: dev hdc: flags = REQ_STARTED REQ_PC REQ_FAILED REQ_QUIET
vmunix: sector 0, nr/cnr 0/0
vmunix: bio 00000000, biotail 00000000, buffer 00000000, data 00000000, len 0
vmunix: cdb: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
vmunix: hdc: cdrom_pc_intr: The drive appears confused (ireason = 0x00)

I confirmed that turning off acpi fixes this problem, i.e. booting with
acpi=off made the cdrom/hdc working again.

Attached is dmesg.acpioff.txt (acpi=off) and dmesg.withacpi.txt (normal
boot).

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining AT logic DOT at>             Università di Siena
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
SMEARISARY (n.)
The correct name for a junior apprentice greengrocer whose main duty
is to arrange the fruit so that the bad side is underneath. From the
name of a character not in Dickens.
			--- Douglas Adams, The Meaning of Liff

--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.acpioff.txt"

Linux version 2.6.14-rc4-mm1 (root@gandalf) (gcc version 4.0.2 (Debian 4.0.2-2)) #1 PREEMPT Mon Oct 17 11:03:10 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff70000 (usable)
 BIOS-e820: 000000001ff70000 - 000000001ff7c000 (ACPI data)
 BIOS-e820: 000000001ff7c000 - 000000001ff80000 (ACPI NVS)
 BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 130928
  DMA zone: 4096 pages, LIFO batch:2
  DMA32 zone: 0 pages, LIFO batch:2
  Normal zone: 126832 pages, LIFO batch:64
  HighMem zone: 0 pages, LIFO batch:2
DMI present.
Allocating PCI resources starting at 30000000 (gap: 20000000:dfb80000)
Built 1 zonelists
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
mapped APIC to ffffd000 (fee00000)
Initializing CPU#0
Kernel command line: BOOT_IMAGE=2.6.14-rc4-mm1 ro root=303 lapic acpi=off
weird, boot CPU (#0) not listed by the BIOS.
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 2193.334 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 515024k/523712k available (2023k kernel code, 8108k reserved, 725k data, 176k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 4392.93 BogoMIPS (lpj=8785868)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00000400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00000400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00000400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
mtrr: v2.0 (20020519)
CPU: Intel Mobile Intel(R) Pentium(R) 4 - M CPU 2.20GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
softlockup thread 0 started up.
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xfd731, last bus=2
PCI: Using configuration type 1
ACPI: Subsystem revision 20050916
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI: disabled
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f5f10
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x913b, dseg 0x400
PnPBIOS: 19 nodes reported by PnP BIOS; 19 recorded by driver
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
PCI: Using IRQ router PIIX/ICH [8086/248c] at 0000:00:1f.0
PCI: IRQ 0 for device 0000:00:1f.1 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Found IRQ 10 for device 0000:00:1f.1
PCI: Sharing IRQ 10 with 0000:02:06.0
PCI: Sharing IRQ 10 with 0000:02:06.1
PCI: Sharing IRQ 10 with 0000:02:07.0
PCI: Sharing IRQ 10 with 0000:02:09.2
pnp: 00:0b: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:0b: ioport range 0x1000-0x105f has been reserved
pnp: 00:0b: ioport range 0x1060-0x107f has been reserved
pnp: 00:0b: ioport range 0x1180-0x11bf has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: 3000-3fff
  MEM window: e8100000-e81fffff
  PREFETCH window: f0000000-f7ffffff
PCI: Bus 3, cardbus bridge: 0000:02:06.0
  IO window: 00004000-00004fff
  IO window: 00006000-00006fff
  PREFETCH window: 30000000-31ffffff
  MEM window: 32000000-33ffffff
PCI: Bus 7, cardbus bridge: 0000:02:06.1
  IO window: 00007000-00007fff
  IO window: 00008000-00008fff
  PREFETCH window: 34000000-35ffffff
  MEM window: 36000000-37ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 4000-5fff
  MEM window: e8200000-e87fffff
  PREFETCH window: f8000000-f80fffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
PCI: Found IRQ 10 for device 0000:02:06.0
PCI: Sharing IRQ 10 with 0000:00:1f.1
PCI: Sharing IRQ 10 with 0000:02:06.1
PCI: Sharing IRQ 10 with 0000:02:07.0
PCI: Sharing IRQ 10 with 0000:02:09.2
PCI: Enabling device 0000:02:06.1 (0104 -> 0107)
PCI: Found IRQ 10 for device 0000:02:06.1
PCI: Sharing IRQ 10 with 0000:00:1f.1
PCI: Sharing IRQ 10 with 0000:02:06.0
PCI: Sharing IRQ 10 with 0000:02:07.0
PCI: Sharing IRQ 10 with 0000:02:09.2
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
Initializing Cryptographic API
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
hw_random: cannot enable RNG, aborting
PNP: PS/2 Controller [PNP0303,PNP0f13] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
PCI: Found IRQ 10 for device 0000:00:1f.6
PCI: Sharing IRQ 10 with 0000:00:1f.3
PCI: Sharing IRQ 10 with 0000:00:1f.5
PCI: Sharing IRQ 10 with 0000:02:09.0
mice: PS/2 mouse device common for all mice
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
input: AT Translated Set 2 keyboard//class/input_dev as input0
lp0: using parport0 (interrupt-driven).
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
PCI: Found IRQ 10 for device 0000:00:1f.1
PCI: Sharing IRQ 10 with 0000:02:06.0
PCI: Sharing IRQ 10 with 0000:02:06.1
PCI: Sharing IRQ 10 with 0000:02:07.0
PCI: Sharing IRQ 10 with 0000:02:09.2
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: TOSHIBA MK8026GAX, ATA DISK drive
Synaptics Touchpad, model: 1, fw: 5.8, id: 0x9d48b1, caps: 0x904713/0x4006
input: SynPS/2 Synaptics TouchPad//class/input_dev as input1
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: QSI CD-RW/DVD-ROM SBW-242, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 156301488 sectors (80026 MB), CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
Advanced Linux Sound Architecture Driver Version 1.0.10rc1 (Mon Sep 12 08:13:09 2005 UTC).
ALSA device list:
  No soundcards found.
NET: Registered protocol family 2
IP route cache hash table entries: 8192 (order: 3, 32768 bytes)
TCP established hash table entries: 32768 (order: 5, 131072 bytes)
TCP bind hash table entries: 32768 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
Using IPI Shortcut mode
swsusp: Resume From Partition /dev/hda3
PM: Checking swsusp image.
swsusp: Error -22 check for resume file
PM: Resume from disk failed.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.

--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.withacpi.txt"

Linux version 2.6.14-rc4-mm1 (root@gandalf) (gcc version 4.0.2 (Debian 4.0.2-2)) #1 PREEMPT Mon Oct 17 11:03:10 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff70000 (usable)
 BIOS-e820: 000000001ff70000 - 000000001ff7c000 (ACPI data)
 BIOS-e820: 000000001ff7c000 - 000000001ff80000 (ACPI NVS)
 BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 130928
  DMA zone: 4096 pages, LIFO batch:2
  DMA32 zone: 0 pages, LIFO batch:2
  Normal zone: 126832 pages, LIFO batch:64
  HighMem zone: 0 pages, LIFO batch:2
DMI present.
ACPI: RSDP (v000 ACER                                  ) @ 0x000f5e80
ACPI: RSDT (v001 ACER     RSDT   0x20020930  LTP 0x00000000) @ 0x1ff75a7b
ACPI: FADT (v001 ACER   IBIS     0x20020930 PTL  0x0000001e) @ 0x1ff7bf64
ACPI: BOOT (v001 ACER   IBIS     0x20020930  LTP 0x00000001) @ 0x1ff7bfd8
ACPI: DSDT (v001 ACER   IBIS     0x20020930 MSFT 0x0100000e) @ 0x00000000
Allocating PCI resources starting at 30000000 (gap: 20000000:dfb80000)
Built 1 zonelists
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
mapped APIC to ffffd000 (fee00000)
Initializing CPU#0
Kernel command line: BOOT_IMAGE=2.6.14-rc4-mm1 ro root=303 lapic
weird, boot CPU (#0) not listed by the BIOS.
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 2193.260 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 515024k/523712k available (2023k kernel code, 8108k reserved, 725k data, 176k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 4392.94 BogoMIPS (lpj=8785889)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00000400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00000400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00000400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
mtrr: v2.0 (20020519)
CPU: Intel Mobile Intel(R) Pentium(R) 4 - M CPU 2.20GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
    ACPI-0284: *** Info: Table [DSDT] replaced by host OS
ACPI: setting ELCR to 0200 (from 0420)
softlockup thread 0 started up.
NET: Registered protocol family 16
EISA bus registered
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd731, last bus=2
PCI: Using configuration type 1
ACPI: Subsystem revision 20050916
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
ACPI: PCI Interrupt Link [LNKC] (IRQs *10)
ACPI: PCI Interrupt Link [LNKD] (IRQs *5)
ACPI: PCI Interrupt Link [LNKE] (IRQs *10)
ACPI: PCI Interrupt Link [LNKF] (IRQs 10) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 10) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 10) *0, disabled.
ACPI: Embedded Controller [EC0] (gpe 29)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB_._PRT]
ACPI: Power Resource [PFN0] (off)
ACPI: Power Resource [PFN1] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 10 devices
PnPBIOS: Disabled by ACPI PNP
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
  IO window: 3000-3fff
  MEM window: e8100000-e81fffff
  PREFETCH window: f0000000-f7ffffff
PCI: Bus 3, cardbus bridge: 0000:02:06.0
  IO window: 00004000-00004fff
  IO window: 00006000-00006fff
  PREFETCH window: 30000000-31ffffff
  MEM window: 32000000-33ffffff
PCI: Bus 7, cardbus bridge: 0000:02:06.1
  IO window: 00007000-00007fff
  IO window: 00008000-00008fff
  PREFETCH window: 34000000-35ffffff
  MEM window: 36000000-37ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 4000-5fff
  MEM window: e8200000-e87fffff
  PREFETCH window: f8000000-f80fffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:02:06.0[A] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
PCI: Enabling device 0000:02:06.1 (0104 -> 0107)
ACPI: PCI Interrupt 0000:02:06.1[A] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
Simple Boot Flag at 0x36 set to 0x1
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
Initializing Cryptographic API
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Battery Slot [BAT2] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN0] (off)
ACPI: Fan [FAN1] (off)
ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
Using specific hotkey driver
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Thermal Zone [THRM] (56 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
hw_random: cannot enable RNG, aborting
PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:MOU2] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt for device 0000:00:1f.6 disabled
mice: PS/2 mouse device common for all mice
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
input: AT Translated Set 2 keyboard//class/input_dev as input0
lp0: using parport0 (interrupt-driven).
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: TOSHIBA MK8026GAX, ATA DISK drive
Synaptics Touchpad, model: 1, fw: 5.8, id: 0x9d48b1, caps: 0x904713/0x4006
input: SynPS/2 Synaptics TouchPad//class/input_dev as input1
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: QSI CD-RW/DVD-ROM SBW-242, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 156301488 sectors (80026 MB), CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
Advanced Linux Sound Architecture Driver Version 1.0.10rc1 (Mon Sep 12 08:13:09 2005 UTC).
ALSA device list:
  No soundcards found.
NET: Registered protocol family 2
IP route cache hash table entries: 8192 (order: 3, 32768 bytes)
TCP established hash table entries: 32768 (order: 5, 131072 bytes)
TCP bind hash table entries: 32768 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
Using IPI Shortcut mode
swsusp: Resume From Partition /dev/hda3
PM: Checking swsusp image.
swsusp: Error -22 check for resume file
PM: Resume from disk failed.
ACPI wakeup devices: 
MDM0  HUB GLAN USB1 USB2 USB1 
ACPI: (supports S0 S3 S4 S5)
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.

--yrj/dFKFPuw6o+aM--
