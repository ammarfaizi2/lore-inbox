Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318367AbSHEK6d>; Mon, 5 Aug 2002 06:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318373AbSHEK6d>; Mon, 5 Aug 2002 06:58:33 -0400
Received: from [62.40.73.125] ([62.40.73.125]:4556 "HELO Router")
	by vger.kernel.org with SMTP id <S318367AbSHEK6b>;
	Mon, 5 Aug 2002 06:58:31 -0400
Date: Mon, 5 Aug 2002 13:01:59 +0200
From: Jan Hudec <bulb@ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: linux-2.4.19-ac[13] IDE chrash
Message-ID: <20020805110159.GA522@vagabond>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried linux-2.4.19-ac1 and -ac3 and they hang just after listing IDE
drives. No error is reported, it seems not to react on keyboard nor ATX
power switch. Vanilla 2.4.19 boots OK.

It's the damned VIA chipset with two IDE controlers (HPT370 as secondary
ide). I disabled ide1 long ago when it caused lots of errors back on
2.4.1 and 2.4.4 kernels. I used to get lots of "hdg: drive appears
confused (ireason=0x1)" errors on 2.4.13-ac8 kernel, I don't see them
now on 2.4.19.

Here is dmesg from 2.4.19 with exact place where 24.19-ac1 and -ac3
stopped marked:

Linux version 2.4.19 (root@vagabond) (gcc version 2.95.4 20011002 (Debian prerelease)) #11 Po srp 5 12:31:27 CEST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
 BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
Advanced speculative caching feature not present
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=l ro root=2101 video=matrox:vesa:282
Initializing CPU#0
Detected 850.065 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1697.38 BogoMIPS
Memory: 256816k/262080k available (1197k kernel code, 4876k reserved, 356k data, 252k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:             Common caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb430, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Disabling VIA memory write queue (PCI ID 0305, rev 03): [55] 89 & 1f -> 09
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
Applying VIA southbridge workaround.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
Starting kswapd
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: Printer, HEWLETT-PACKARD DESKJET 970C
parport_pc: Via 686A parallel port: io=0x378
i2c-core.o: i2c core module
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-proc.o version 2.6.1 (20010825)
PCI: No IRQ known for interrupt pin A of device 01:00.0. Please try using pci=biosirq.
matroxfb: Matrox G450 detected
matroxfb: MTRR's turned on
matroxfb: 1280x1024x16bpp (virtual: 1280x6552)
matroxfb: framebuffer at 0xD2000000, mapped to 0xd0805000, size 33554432
Console: switching to colour frame buffer device 160x64
fb0: MATROX VGA frame buffer device
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
lp0: using parport0 (polling).
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:pio, hdb:pio
HPT370A: IDE controller on PCI bus 00 dev 98
PCI: Assigned IRQ 5 for device 00:13.0
HPT370A: chipset revision 4
HPT370A: not 100% native mode: will probe irqs later
HPT370: using 33MHz PCI clock
    ide2: BM-DMA at 0xe000-0xe007, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xe008-0xe00f, BIOS settings: hdg:pio, hdh:pio
hda: IOMEGA ZIP 250 ATAPI, ATAPI FLOPPY drive
hde: ST340824A, ATA DISK drive
hdg: TOSHIBA DVD-ROM SD-M1502, ATAPI CD/DVD-ROM drive

**** -ac1 and -ac3 stop right here! ******************************************

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0xd000-0xd007,0xd402 on irq 5
ide3 at 0xd800-0xd807,0xdc02 on irq 5
hde: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=77545/16/63, UDMA(100)
hdg: ATAPI 48X DVD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
ide-floppy driver 0.99.newide
hda: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hda: set_drive_speed_status: error=0x04
ide0: Drive 0 didn't accept speed setting. Oh, well.
hda: No disk in drive
hda: 244736kB, 239/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
Partition check:
 hde: [PTBL] [4865/255/63] hde1 hde2 hde3
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
8139too Fast Ethernet driver 0.9.25
PCI: Assigned IRQ 9 for device 00:0f.0
eth0: RealTek RTL8139 Fast Ethernet at 0xd2806000, 00:4f:4e:10:69:d4, IRQ 9
eth0:  Identified 8139 chip type 'RTL-8139C'
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected Via Apollo Pro KT133 chipset
agpgart: AGP aperture is 32M @ 0xd0000000
[drm] AGP 0.99 on VIA Apollo KT133 @ 0xd0000000 32MB
[drm] Initialized mga 3.0.2 20010321 on minor 0
ide-floppy driver 0.99.newide
matroxfb_crtc2: secondary head of fb0 was registered as fb1
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 252k freed
Adding Swap: 514072k swap-space (priority -1)
isapnp: Scanning for PnP cards...
isapnp: Card 'Advanced Gravis InterWave Audio'
isapnp: 1 Plug & Play card detected total
ide-floppy: hda: I/O error, pc =  0, key =  2, asc = 3a, ascq =  0
ide-floppy: hda: I/O error, pc = 1b, key =  2, asc = 3a, ascq =  0
hda: No disk in drive
ide-floppy: hda: I/O error, pc = 1e, key =  2, asc = 3a, ascq =  0
hdg: DMA disabled
i2c-viapro.o version 2.6.3 (20020322)
i2c-viapro.o: Found Via VT82C686A/B device
i2c-dev.o: Registered 'SMBus Via Pro adapter at 5000' as minor 0
i2c-core.o: adapter SMBus Via Pro adapter at 5000 registered as adapter 0.
i2c-viapro.o: Via Pro SMBus detected and initialized
adm1021.o version 2.6.3 (20020322)
i2c-core.o: driver ADM1021, MAX1617 sensor driver registered.
i2c-core.o: client [LM84 chip] registered to adapter [SMBus Via Pro adapter at 5000](pos. 0).
lm80.o version 2.6.3 (20020322)
i2c-core.o: driver LM80 sensor driver registered.
i2c-core.o: client [LM80 chip] registered to adapter [SMBus Via Pro adapter at 5000](pos. 1).
eeprom.o version 2.6.3 (20020322)
i2c-core.o: driver EEPROM READER registered.
i2c-core.o: client [EEPROM chip] registered to adapter [SMBus Via Pro adapter at 5000](pos. 2).
reiserfs: checking transaction log (device 21:03) ...
Using tea hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.25
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 41e1.

<end of dmesg>

Follows PCI listing:

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
        Subsystem: ABIT Computer Corp.: Unknown device a401
        Flags: bus master, medium devsel, latency 8
        Memory at d0000000 (32-bit, prefetchable) [size=32M]
        Capabilities: <available only to root>

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: d4000000-d6ffffff
        Prefetchable memory behind bridge: d2000000-d3ffffff
        Capabilities: <available only to root>

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: <available only to root>

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Flags: bus master, medium devsel, latency 32
        I/O ports at c000 [size=16]
        Capabilities: <available only to root>

00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
        Flags: medium devsel, IRQ 15
        Capabilities: <available only to root>

00:0f.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Flags: bus master, medium devsel, latency 32, IRQ 9
        I/O ports at cc00 [size=256]
        Memory at d8000000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: <available only to root>

00:13.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366 / HPT370 (rev 04)
        Subsystem: Triones Technologies, Inc.: Unknown device 0001
        Flags: bus master, 66Mhz, medium devsel, latency 120, IRQ 5
        I/O ports at d000 [size=8]
        I/O ports at d400 [size=4]
        I/O ports at d800 [size=8]
        I/O ports at dc00 [size=4]
        I/O ports at e000 [size=256]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: <available only to root>

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 82) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Millennium G450 32Mb SDRAM
        Flags: bus master, medium devsel, latency 64
        Memory at d2000000 (32-bit, prefetchable) [size=32M]
        Memory at d4000000 (32-bit, non-prefetchable) [size=16K]
        Memory at d5000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: <available only to root>

-------------------------------------------------------------------------------
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
