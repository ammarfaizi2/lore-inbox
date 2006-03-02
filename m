Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750923AbWCBNTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbWCBNTb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 08:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbWCBNTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 08:19:31 -0500
Received: from math.ut.ee ([193.40.36.2]:51598 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S1750923AbWCBNT3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 08:19:29 -0500
Date: Thu, 2 Mar 2006 15:19:09 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: spontaneous reboots with latest 2.6.16 RC-s
Message-ID: <Pine.SOC.4.61.0603021501560.23598@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have had 3 spontaneous reboots in last week with 2.6.16-rc[45] 
timescale kernels. Could be kernel or X or hardware, not sure yet. When 
they happened, mplayer was used to play some movie fullscreen with 
Matrox G400 and XVideo (X.org 6.9) and there was slight disk and network 
activity. This reboot is not reproducible at will, it will only happen 
sometimes.

This is a lone home computer so no serial console.

Plain Duron PC with up-to-date Debian unstable. Have kept it mostly up 
to date with the exception that I kept using X.org 6.8.2 for a long time 
before switching to X.org 6.9 - so it might be X problem instead and it 
might only have surfaced after I restarted after upgrading to X.org 6.9.

Earlier 2.6.16 RC-s (or git snapshots from that time) were OK, where OK 
means that I did not see any problems.

2.6.16-rc2 was stable for 11 days
2.6.16-rc3-g5552... was OK for 2 days
2.6.16-rc3-gab47... rebooted
2.6.16-rc4-g9e95... rebooted
2.6.16-rc5-gb1e2... rebooted (todays snapshot)

/proc/interrupts, lspci -vvvn and dmesg of a bootup are below. Any ideas 
if this could be something with a kernel?

            CPU0
   0:    1614366    IO-APIC-edge  timer
   1:       9091    IO-APIC-edge  i8042
   7:          2    IO-APIC-edge  parport0
   8:        430    IO-APIC-edge  rtc
   9:         49   IO-APIC-level  acpi, uhci_hcd:usb1, uhci_hcd:usb2
  10:          0   IO-APIC-level  VIA686A
  12:      46371    IO-APIC-edge  i8042
  14:      59711    IO-APIC-edge  ide0
  15:      57543    IO-APIC-edge  ide1
169:     767715   IO-APIC-level  Ensoniq AudioPCI, mga@pci:0000:01:00.0
177:     389854   IO-APIC-level  bttv0
185:          0   IO-APIC-level  eth0
193:     559602   IO-APIC-level  eth1
NMI:    1614344
LOC:    1614335
ERR:          0
MIS:          0


0000:00:00.0 0600: 1106:0305 (rev 03)
 	Subsystem: 1458:0000
 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
 	Latency: 8
 	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
 	Capabilities: <available only to root>

0000:00:01.0 0604: 1106:8305
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
 	Latency: 0
 	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
 	I/O behind bridge: 00008000-00008fff
 	Memory behind bridge: dee00000-dfefffff
 	Prefetchable memory behind bridge: dac00000-decfffff
 	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
 	Capabilities: <available only to root>

0000:00:07.0 0601: 1106:0686 (rev 40)
 	Subsystem: 1106:0686
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 0
 	Capabilities: <available only to root>

0000:00:07.1 0101: 1106:0571 (rev 06) (prog-if 8a [Master SecP PriP])
 	Subsystem: 1106:0571
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 32
 	Region 4: I/O ports at ffa0 [size=16]
 	Capabilities: <available only to root>

0000:00:07.2 0c03: 1106:3038 (rev 1a)
 	Subsystem: 0925:1234
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 64, Cache Line Size: 0x08 (32 bytes)
 	Interrupt: pin D routed to IRQ 9
 	Region 4: I/O ports at cc00 [size=32]
 	Capabilities: <available only to root>

0000:00:07.3 0c03: 1106:3038 (rev 1a)
 	Subsystem: 0925:1234
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 64, Cache Line Size: 0x08 (32 bytes)
 	Interrupt: pin D routed to IRQ 9
 	Region 4: I/O ports at d000 [size=32]
 	Capabilities: <available only to root>

0000:00:07.4 0c05: 1106:3057 (rev 40)
 	Subsystem: 1458:0000
 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Interrupt: pin ? routed to IRQ 9
 	Capabilities: <available only to root>

0000:00:07.5 0401: 1106:3058 (rev 50)
 	Subsystem: 1458:a002
 	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Interrupt: pin C routed to IRQ 10
 	Region 0: I/O ports at dc00 [size=256]
 	Region 1: I/O ports at d800 [size=4]
 	Region 2: I/O ports at d400 [size=4]
 	Capabilities: <available only to root>

0000:00:0a.0 0200: 10ec:8139 (rev 10)
 	Subsystem: 10ec:8139
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 64 (8000ns min, 16000ns max)
 	Interrupt: pin A routed to IRQ 185
 	Region 0: I/O ports at c800 [size=256]
 	Region 1: Memory at dfffff00 (32-bit, non-prefetchable) [size=256]
 	Capabilities: <available only to root>

0000:00:0c.0 0401: 1274:1371 (rev 08)
 	Subsystem: 1274:1371
 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
 	Latency: 64 (3000ns min, 32000ns max)
 	Interrupt: pin A routed to IRQ 169
 	Region 0: I/O ports at c400 [size=64]
 	Capabilities: <available only to root>

0000:00:0d.0 0400: 109e:036e (rev 02)
 	Subsystem: 0070:13eb
 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 64 (4000ns min, 10000ns max)
 	Interrupt: pin A routed to IRQ 177
 	Region 0: Memory at dedfe000 (32-bit, prefetchable) [size=4K]

0000:00:0d.1 0480: 109e:0878 (rev 02)
 	Subsystem: 0070:13eb
 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 64 (1000ns min, 63750ns max)
 	Interrupt: pin A routed to IRQ 5
 	Region 0: Memory at dedff000 (32-bit, prefetchable) [size=4K]

0000:00:0f.0 0200: 10ec:8139 (rev 10)
 	Subsystem: 10ec:8139
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 64 (8000ns min, 16000ns max)
 	Interrupt: pin A routed to IRQ 193
 	Region 0: I/O ports at c000 [size=256]
 	Region 1: Memory at dffffe00 (32-bit, non-prefetchable) [size=256]
 	Capabilities: <available only to root>

0000:01:00.0 0300: 102b:0525 (rev 05)
 	Subsystem: 102b:2179
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 64 (4000ns min, 8000ns max), Cache Line Size: 0x08 (32 bytes)
 	Interrupt: pin A routed to IRQ 169
 	Region 0: Memory at dc000000 (32-bit, prefetchable) [size=32M]
 	Region 1: Memory at dfefc000 (32-bit, non-prefetchable) [size=16K]
 	Region 2: Memory at df000000 (32-bit, non-prefetchable) [size=8M]
 	Expansion ROM at dfee0000 [disabled] [size=64K]
 	Capabilities: <available only to root>



Linux version 2.6.16-rc5-gb1e2d907 (mroos@vaarikas) (gcc version 4.0.3 20060212 (prerelease) (Debian 4.0.2-9)) #153 PREEMPT Thu Mar 2 09:06:48 EET 2006
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000ec000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 0000000037ff0000 (usable)
  BIOS-e820: 0000000037ff0000 - 0000000037ff8000 (ACPI data)
  BIOS-e820: 0000000037ff8000 - 0000000038000000 (ACPI NVS)
  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
895MB LOWMEM available.
found SMP MP-table at 000fb210
On node 0 totalpages: 229360
   DMA zone: 4096 pages, LIFO batch:0
   DMA32 zone: 0 pages, LIFO batch:0
   Normal zone: 225264 pages, LIFO batch:31
   HighMem zone: 0 pages, LIFO batch:0
DMI 2.3 present.
ACPI: RSDP (v000 AMI                                   ) @ 0x000fa970
ACPI: RSDT (v001 AMIINT VIA_K7   0x00000010 MSFT 0x00000097) @ 0x37ff0000
ACPI: FADT (v001 AMIINT VIA_K7   0x00000011 MSFT 0x00000097) @ 0x37ff0030
ACPI: MADT (v001 AMIINT          0x00000009 MSFT 0x00000097) @ 0x37ff00b0
ACPI: DSDT (v001    VIA   VT8371 0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:7 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 40000000 (gap: 38000000:c6c00000)
Built 1 zonelists
Kernel command line: root=/dev/hda1 ro nmi_watchdog=1 lapic
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c0377000 soft=c0378000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 1300.210 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 906092k/917440k available (1638k kernel code, 10856k reserved, 713k data, 148k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 2604.09 BogoMIPS (lpj=5208191)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000 00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
CPU: After all inits, caps: 0383fbff c1c3fbff 00000000 00000020 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Duron(tm) stepping 01
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfdb31, last bus=1
PCI: Using configuration type 1
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 0c00-0c7f claimed by vt82c686 HW-mon
PCI quirk: region 0400-040f claimed by vt82c686 SMB
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 12 14 15) *9
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
PCI: Bridge: 0000:00:01.0
   IO window: 8000-8fff
   MEM window: dee00000-dfefffff
   PREFETCH window: dac00000-decfffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
Machine check exception polling timer started.
Total HugeTLB memory allocated, 0
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Applying VIA southbridge workaround.
PCI: Enabling Via external APIC routing
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU1] (supports 16 throttling states)
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected VIA Twister-K/KT133x/KM133 chipset
agpgart: AGP aperture is 64M @ 0xe0000000
[drm] Initialized drm 1.0.1 20051102
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
serial8250: ttyS0 at I/O 0x3f8 (irq = 0) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 0) is a 16550A
00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:0a: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
PPP generic driver version 2.4.2
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
PCI: Via IRQ fixup for 0000:00:07.1, from 255 to 0
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: SAMSUNG SP1614N, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: HL-DT-ST GCE-8400B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 512KiB
hda: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=19457/255/63, UDMA(100)
hda: cache flushes supported
  hda: hda1 hda2 hda3
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input0
input: PC Speaker as /class/input/input1
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 7, 524288 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Testing NMI watchdog ... OK.
Using IPI Shortcut mode
ACPI wakeup devices: 
PCI0 UAR1  USB USB1  MC9 
ACPI: (supports S0 S1 S4 S5)
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
input: ImExPS/2 Generic Explorer Mouse as /class/input/input2
EXT3-fs: hda1: orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 98255
ext3_orphan_cleanup: deleting unreferenced inode 98302
ext3_orphan_cleanup: deleting unreferenced inode 98326
ext3_orphan_cleanup: deleting unreferenced inode 98404
ext3_orphan_cleanup: deleting unreferenced inode 98324
kjournald starting.  Commit interval 5 seconds
ext3_orphan_cleanup: deleting unreferenced inode 98167
ext3_orphan_cleanup: deleting unreferenced inode 98310
ext3_orphan_cleanup: deleting unreferenced inode 98135
ext3_orphan_cleanup: deleting unreferenced inode 98403
ext3_orphan_cleanup: deleting unreferenced inode 98315
ext3_orphan_cleanup: deleting unreferenced inode 98318
ext3_orphan_cleanup: deleting unreferenced inode 98284
EXT3-fs: hda1: 12 orphan inodes deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 148k freed
ACPI: PCI Interrupt 0000:00:0c.0[A] -> GSI 16 (level, low) -> IRQ 169
hdc: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
SCSI subsystem initialized
ACPI: PCI Interrupt 0000:00:07.5[C] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:07.5 to 64
parport_pc: VIA 686A/8231 detected
parport_pc: probing current configuration
parport_pc: Current parallel port base: 0x378
parport0: PC-style at 0x378 (0x778), irq 7, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
parport_pc: VIA parallel port: io=0x378, irq=7
lp0: using parport0 (interrupt-driven).
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
loop: loaded (max 8 devices)
usbcore: registered new driver usbfs
usbcore: registered new driver hub
Linux video capture interface: v1.00
bttv: driver version 0.9.16 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 17 (level, low) -> IRQ 177
bttv0: Bt878 (rev 2) at 0000:00:0d.0, irq: 177, latency: 64, mmio: 0xdedfe000
bttv0: detected: Hauppauge WinTV [card=10], PCI subsystem ID is 0070:13eb
bttv0: using: Hauppauge (bt878) [card=10,autodetected]
bttv0: gpio: en=00000000, out=00000000 in=00ffffdb [init]
bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]
8139too Fast Ethernet driver 0.9.27
tveeprom 1-0050: Hauppauge model 37284, rev B121, serial# 3520921
tveeprom 1-0050: tuner model is Philips FM1216 (idx 21, type 5)
tveeprom 1-0050: TV standards PAL(B/G) (eeprom 0x04)
tveeprom 1-0050: audio processor is MSP3410D (idx 5)
tveeprom 1-0050: has radio
bttv0: Hauppauge eeprom indicates model#37284
bttv0: using tuner=5
bttv0: i2c: checking for MSP34xx @ 0x80... found
USB Universal Host Controller Interface driver v2.3
msp3400 1-0040: MSP3410D-B4 found @ 0x80 (bt878 #0 [sw])
msp3400 1-0040: MSP3410D-B4 supports nicam, mode is autodetect
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
bttv0: i2c: checking for TDA9887 @ 0x86... not found
tuner 1-0061: chip found @ 0xc2 (bt878 #0 [sw])
tuner 1-0061: type set to 5 (Philips PAL_BG (FI1216 and compatibles))
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: registered device radio0
bttv0: PLL: 28636363 => 35468950 .. ok
ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 18 (level, low) -> IRQ 185
eth0: RealTek RTL8139 at 0xf89c0f00, 00:40:95:30:0b:b0, IRQ 185
eth0:  Identified 8139 chip type 'RTL-8139C'
ACPI: PCI Interrupt 0000:00:0f.0[A] -> GSI 19 (level, low) -> IRQ 193
eth1: RealTek RTL8139 at 0xf89c2e00, 00:c0:df:04:7f:9b, IRQ 193
eth1:  Identified 8139 chip type 'RTL-8139B'
ACPI: PCI Interrupt 0000:00:07.2[D] -> GSI 9 (level, low) -> IRQ 9
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:07.2: irq 9, io base 0x0000cc00
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:07.3[D] -> GSI 9 (level, low) -> IRQ 9
uhci_hcd 0000:00:07.3: UHCI Host Controller
uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:07.3: irq 9, io base 0x0000d000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usb 2-1: new full speed USB device using uhci_hcd and address 2
usb 2-1: configuration #1 chosen from 1 choice
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 2 if 0 alt 0 proto 2 vid 0x03F0 pid 0x7204
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Adding 1028152k swap on /dev/hda2.  Priority:-1 extents:1 across:1028152k
EXT3 FS on hda1, internal journal
device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eth0: link down
ADDRCONF(NETDEV_UP): eth0: link is not ready
eth1: link up, 100Mbps, full-duplex, lpa 0x45E1
tun6to4: Disabled Privacy Extensions
u32 classifier
     Actions configured 
ip_tables: (C) 2000-2006 Netfilter Core Team
Netfilter messages via NETLINK v0.30.
ip_conntrack version 2.4 (7167 buckets, 57336 max) - 232 bytes per conntrack
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 169
[drm] Initialized mga 3.2.1 20051102 on minor 0
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
[drm] Initialized card for AGP DMA.

-- 
Meelis Roos (mroos@linux.ee)
