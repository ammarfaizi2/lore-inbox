Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265783AbUA1BHQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 20:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265796AbUA1BHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 20:07:16 -0500
Received: from dividezero.net ([216.66.75.129]:49860 "HELO
	webserv2.divide0.net") by vger.kernel.org with SMTP id S265783AbUA1BDZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 20:03:25 -0500
Message-ID: <40170A4C.1060308@alienz.net>
Date: Tue, 27 Jan 2004 20:03:08 -0500
From: Mike Garrison <mgarrison@alienz.net>
User-Agent: Mozilla Thunderbird 0.5a (Windows/20040120)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PDC20269 primary channel Busy
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having a really odd problem with a PDC20269. The primary channel, no 
matter what, will also report the drives on it as busy. I've tried 
kernel versions 2.6.1, 2.6.2-rc2, and 2.4.24 and the same problem 
occurs. The Promise card detects the drives with no problem. The card 
has been swapped out, the cables have been switched, the drives have 
been changed, and none of this has any effect at all.

If there are drives on the primary channel, I run into errors such as 
the following:
hdj: set_drive_speed_status: status=0xff { Busy }
hdi: max request size: 128KiB
hdi: status timeout: status=0xff { Busy }

I'm really quite lost as to what the problem may be. I've tried so many 
different things I don't know what else to do besides not use the 
primary chain.

I've attached my lspci -v ; my dmesg ; and my kernel .config (2.6.2-rc2)

Thanks,
Mike Garrison
mgarrison@alienz.net

dmesg:

Jan 27 09:27:46 crypto syslogd 1.4.1#13: restart.
Jan 27 09:27:46 crypto kernel: klogd 1.4.1#13, log source = /proc/kmsg started.
Jan 27 09:27:46 crypto kernel: Inspecting /boot/System.map-2.6.2-rc2
Jan 27 09:27:46 crypto kernel: Loaded 17788 symbols from /boot/System.map-2.6.2-rc2.
Jan 27 09:27:46 crypto kernel: Symbols match kernel version 2.6.2.
Jan 27 09:27:46 crypto kernel: No module symbols loaded - kernel modules not enabled. 
Jan 27 09:27:46 crypto kernel: Linux version 2.6.2-rc2 (root@crypto) (gcc version 3.3.3 20040110 (prerelease) (Debian)) #5 Tue 
Jan 2
7 09:20:55 EST 2004
Jan 27 09:27:46 crypto kernel: BIOS-provided physical RAM map:
Jan 27 09:27:46 crypto kernel:  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
Jan 27 09:27:46 crypto kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Jan 27 09:27:46 crypto kernel:  BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
Jan 27 09:27:46 crypto kernel:  BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
Jan 27 09:27:46 crypto kernel:  BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
Jan 27 09:27:46 crypto kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Jan 27 09:27:46 crypto kernel: 255MB LOWMEM available.
Jan 27 09:27:46 crypto kernel: On node 0 totalpages: 65520
Jan 27 09:27:46 crypto kernel:   DMA zone: 4096 pages, LIFO batch:1
Jan 27 09:27:46 crypto kernel:   Normal zone: 61424 pages, LIFO batch:14
Jan 27 09:27:46 crypto kernel:   HighMem zone: 0 pages, LIFO batch:1
Jan 27 09:27:46 crypto kernel: DMI 2.3 present.
Jan 27 09:27:46 crypto kernel: ACPI: RSDP (v000 VT8363                                    ) @ 0x000f7ec0
Jan 27 09:27:46 crypto kernel: ACPI: RSDT (v001 VT8363 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fff3000
Jan 27 09:27:46 crypto kernel: ACPI: FADT (v001 VT8363 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fff3040
Jan 27 09:27:46 crypto kernel: ACPI: DSDT (v001 VT8363 AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
Jan 27 09:27:46 crypto kernel: Building zonelist for node : 0
Jan 27 09:27:46 crypto kernel: Kernel command line: auto BOOT_IMAGE=LinuxNEW ro root=301
Jan 27 09:27:46 crypto kernel: Initializing CPU#0
Jan 27 09:27:46 crypto kernel: PID hash table entries: 1024 (order 10: 8192 bytes)
Jan 27 09:27:46 crypto kernel: Detected 902.342 MHz processor.
Jan 27 09:27:46 crypto kernel: Using tsc for high-res timesource
Jan 27 09:27:46 crypto kernel: Console: colour VGA+ 80x25
Jan 27 09:27:46 crypto kernel: Memory: 256464k/262080k available (1545k kernel code, 4892k reserved, 467k data, 136k init, 0k 
highme
m)
Jan 27 09:27:46 crypto kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Jan 27 09:27:46 crypto kernel: Calibrating delay loop... 1777.66 BogoMIPS
Jan 27 09:27:46 crypto kernel: Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Jan 27 09:27:46 crypto kernel: Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Jan 27 09:27:46 crypto kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Jan 27 09:27:46 crypto kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Jan 27 09:27:46 crypto kernel: CPU: L2 Cache: 256K (64 bytes/line)
Jan 27 09:27:46 crypto kernel: Intel machine check architecture supported.
Jan 27 09:27:46 crypto kernel: Intel machine check reporting enabled on CPU#0.
Jan 27 09:27:46 crypto kernel: CPU: AMD Athlon(tm) processor stepping 02
Jan 27 09:27:46 crypto kernel: Enabling fast FPU save and restore... done.
Jan 27 09:27:46 crypto kernel: Checking 'hlt' instruction... OK.
Jan 27 09:27:46 crypto kernel: POSIX conformance testing by UNIFIX
Jan 27 09:27:46 crypto kernel: NET: Registered protocol family 16
Jan 27 09:27:46 crypto kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb420, last bus=1
Jan 27 09:27:46 crypto kernel: PCI: Using configuration type 1
Jan 27 09:27:46 crypto kernel: mtrr: v2.0 (20020519)
Jan 27 09:27:46 crypto kernel: ACPI: Subsystem revision 20031002
Jan 27 09:27:46 crypto kernel: ACPI: Interpreter enabled
Jan 27 09:27:46 crypto kernel: ACPI: Using PIC for interrupt routing
Jan 27 09:27:46 crypto kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Jan 27 09:27:46 crypto kernel: PCI: Probing PCI hardware (bus 00)
Jan 27 09:27:46 crypto kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
Jan 27 09:27:46 crypto kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 12 14 15)
Jan 27 09:27:46 crypto kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
Jan 27 09:27:46 crypto kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 11 *12 14 15)
Jan 27 09:27:46 crypto kernel: ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 12
Jan 27 09:27:46 crypto kernel: ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
Jan 27 09:27:46 crypto kernel: ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
Jan 27 09:27:46 crypto kernel: PCI: Using ACPI for IRQ routing
Jan 27 09:27:46 crypto kernel: PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Jan 27 09:27:46 crypto kernel: Machine check exception polling timer started.
Jan 27 09:27:46 crypto kernel: Applying VIA southbridge workaround.
Jan 27 09:27:46 crypto kernel: pty: 256 Unix98 ptys configured
Jan 27 09:27:46 crypto kernel: Real Time Clock Driver v1.12
Jan 27 09:27:46 crypto kernel: Using anticipatory io scheduler
Jan 27 09:27:46 crypto kernel: FDC 0 is a post-1991 82077
Jan 27 09:27:46 crypto kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Jan 27 09:27:46 crypto kernel: loop: loaded (max 8 devices)
Jan 27 09:27:46 crypto kernel: 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
Jan 27 09:27:46 crypto kernel: 0000:00:0c.0: 3Com PCI 3c905C Tornado at 0xc800. Vers LK1.1.19
Jan 27 09:27:46 crypto kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Jan 27 09:27:46 crypto kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Jan 27 09:27:46 crypto kernel: VP_IDE: IDE controller at PCI slot 0000:00:07.1
Jan 27 09:27:46 crypto kernel: VP_IDE: chipset revision 6
Jan 27 09:27:46 crypto kernel: VP_IDE: not 100%% native mode: will probe irqs later
Jan 27 09:27:46 crypto kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Jan 27 09:27:46 crypto kernel: VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
Jan 27 09:27:46 crypto kernel:     ide0: BM-DMA at 0x9000-0x9007, BIOS settings: hda:DMA, hdb:DMA
Jan 27 09:27:46 crypto kernel:     ide1: BM-DMA at 0x9008-0x900f, BIOS settings: hdc:DMA, hdd:DMA
Jan 27 09:27:46 crypto kernel: hda: IBM-DJNA-371350, ATA DISK drive
Jan 27 09:27:46 crypto kernel: hdb: WDC WD1200BB-22CAA0, ATA DISK drive
Jan 27 09:27:46 crypto kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jan 27 09:27:46 crypto kernel: hdc: WDC WD800BB-32CCB0, ATA DISK drive
Jan 27 09:27:46 crypto kernel: hdd: WDC WD307AA, ATA DISK drive
Jan 27 09:27:46 crypto kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jan 27 09:27:46 crypto kernel: PDC20267: IDE controller at PCI slot 0000:00:09.0
Jan 27 09:27:46 crypto kernel: PDC20267: chipset revision 2
Jan 27 09:27:46 crypto kernel: PDC20267: 100%% native mode on irq 11
Jan 27 09:27:46 crypto kernel: PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
Jan 27 09:27:46 crypto kernel:     ide2: BM-DMA at 0xb000-0xb007, BIOS settings: hde:pio, hdf:pio
Jan 27 09:27:46 crypto kernel:     ide3: BM-DMA at 0xb008-0xb00f, BIOS settings: hdg:pio, hdh:pio
Jan 27 09:27:46 crypto kernel: hde: WDC WD800BB-00BSA0, ATA DISK drive
Jan 27 09:27:46 crypto kernel: hdf: WDC WD800BB-00BSA0, ATA DISK drive
Jan 27 09:27:46 crypto kernel: ide2 at 0xa000-0xa007,0xa402 on irq 11
Jan 27 09:27:46 crypto kernel: hdg: WDC WD800BB-00CAA0, ATA DISK drive
Jan 27 09:27:46 crypto kernel: hdh: Maxtor 4G160J8, ATA DISK drive
Jan 27 09:27:46 crypto kernel: ide3 at 0xa800-0xa807,0xac02 on irq 11
Jan 27 09:27:46 crypto kernel: PDC20269: IDE controller at PCI slot 0000:00:0b.0
Jan 27 09:27:46 crypto kernel: PDC20269: chipset revision 2
Jan 27 09:27:46 crypto kernel: PDC20269: 100%% native mode on irq 10
Jan 27 09:27:46 crypto kernel:     ide4: BM-DMA at 0xc400-0xc407, BIOS settings: hdi:pio, hdj:pio
Jan 27 09:27:46 crypto kernel:     ide5: BM-DMA at 0xc408-0xc40f, BIOS settings: hdk:pio, hdl:pio
Jan 27 09:27:46 crypto kernel: hdi: WDC WD1000BB-00CCB0, ATA DISK drive
Jan 27 09:27:46 crypto kernel: hdj: WDC WD800BB-75CAA0, ATA DISK drive
Jan 27 09:27:46 crypto kernel: hdj: set_drive_speed_status: status=0xff { Busy }
Jan 27 09:27:46 crypto kernel: ide4 at 0xb400-0xb407,0xb802 on irq 10
Jan 27 09:27:46 crypto kernel: hda: max request size: 128KiB
Jan 27 09:27:46 crypto kernel: hda: 26712000 sectors (13676 MB) w/1966KiB Cache, CHS=26500/16/63
Jan 27 09:27:46 crypto kernel:  hda: hda1 hda2 < hda5 >
Jan 27 09:27:46 crypto kernel: hdb: max request size: 128KiB
Jan 27 09:27:46 crypto kernel: hdb: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=65535/16/63
Jan 27 09:27:46 crypto kernel:  hdb: hdb1
Jan 27 09:27:46 crypto kernel: hdc: max request size: 128KiB
Jan 27 09:27:46 crypto kernel: hdc: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63
Jan 27 09:27:46 crypto kernel:  hdc: hdc1
Jan 27 09:27:46 crypto kernel: hdd: max request size: 128KiB
Jan 27 09:27:46 crypto kernel: hdd: 60074784 sectors (30758 MB) w/2048KiB Cache, CHS=59598/16/63
Jan 27 09:27:46 crypto kernel:  hdd: hdd1
Jan 27 09:27:46 crypto kernel: hde: max request size: 128KiB
Jan 27 09:27:46 crypto kernel: hde: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63
Jan 27 09:27:46 crypto kernel:  hde: hde1
Jan 27 09:27:46 crypto kernel: hdf: max request size: 128KiB
Jan 27 09:27:46 crypto kernel: hdf: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63
Jan 27 09:27:46 crypto kernel:  hdf: hdf1
Jan 27 09:27:46 crypto kernel: hdg: max request size: 128KiB
Jan 27 09:27:46 crypto kernel: hdg: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63
Jan 27 09:27:46 crypto kernel:  hdg: hdg1
Jan 27 09:27:46 crypto kernel: hdh: max request size: 1024KiB
Jan 27 09:27:46 crypto kernel: hdh: 320173056 sectors (163928 MB) w/2048KiB Cache, CHS=19929/255/63
Jan 27 09:27:46 crypto kernel:  hdh: hdh1
Jan 27 09:27:46 crypto kernel: hdi: max request size: 128KiB
Jan 27 09:27:46 crypto kernel: hdi: status timeout: status=0xff { Busy }
Jan 27 09:27:46 crypto kernel: 
Jan 27 09:27:46 crypto kernel: hdi: 195371568 sectors (100030 MB) w/2048KiB Cache, CHS=65535/16/63
Jan 27 09:27:46 crypto kernel:  hdi:hdi: status timeout: status=0xff { Busy }
Jan 27 09:27:46 crypto kernel: 
Jan 27 09:27:46 crypto kernel: PDC202XX: Primary channel reset.
Jan 27 09:27:46 crypto kernel: ide4: reset timed-out, status=0xff
Jan 27 09:27:46 crypto kernel: hdi: status timeout: status=0xff { Busy }
Jan 27 09:27:46 crypto kernel: 
Jan 27 09:27:46 crypto kernel: PDC202XX: Primary channel reset.
Jan 27 09:27:46 crypto kernel: ide4: reset timed-out, status=0xff
Jan 27 09:27:46 crypto kernel: end_request: I/O error, dev hdi, sector 0
Jan 27 09:27:46 crypto kernel: end_request: I/O error, dev hdi, sector 0
Jan 27 09:27:46 crypto kernel:  unable to read partition table
Jan 27 09:27:46 crypto kernel: hdj: max request size: 128KiB
Jan 27 09:27:46 crypto kernel: hdj: status timeout: status=0xff { Busy }
Jan 27 09:27:46 crypto kernel: 
Jan 27 09:27:46 crypto kernel: hdj: 156250000 sectors (80000 MB) w/2048KiB Cache, CHS=65535/16/63
Jan 27 09:27:46 crypto kernel:  hdj:hdj: status timeout: status=0xff { Busy }
Jan 27 09:27:46 crypto kernel: 
Jan 27 09:27:46 crypto kernel: PDC202XX: Primary channel reset.
Jan 27 09:27:46 crypto kernel: ide4: reset timed-out, status=0xff
Jan 27 09:27:46 crypto kernel: hdj: status timeout: status=0xff { Busy }
Jan 27 09:27:46 crypto kernel: 
Jan 27 09:27:46 crypto kernel: PDC202XX: Primary channel reset.
Jan 27 09:27:46 crypto kernel: ide4: reset timed-out, status=0xff
Jan 27 09:27:46 crypto kernel: end_request: I/O error, dev hdj, sector 0
Jan 27 09:27:46 crypto kernel: end_request: I/O error, dev hdj, sector 0
Jan 27 09:27:46 crypto kernel:  unable to read partition table
Jan 27 09:27:46 crypto kernel: mice: PS/2 mouse device common for all mice
Jan 27 09:27:46 crypto kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Jan 27 09:27:46 crypto kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Jan 27 09:27:46 crypto kernel: device-mapper: 4.0.0-ioctl (2003-06-04) initialised: dm@uk.sistina.com
Jan 27 09:27:46 crypto kernel: NET: Registered protocol family 2
Jan 27 09:27:46 crypto kernel: IP: routing cache hash table of 2048 buckets, 16Kbytes
Jan 27 09:27:46 crypto kernel: TCP: Hash tables configured (established 16384 bind 32768)
Jan 27 09:27:46 crypto kernel: NET: Registered protocol family 1
Jan 27 09:27:46 crypto kernel: VFS: Mounted root (ext2 filesystem) readonly.
Jan 27 09:27:46 crypto kernel: Freeing unused kernel memory: 136k freed
Jan 27 09:27:46 crypto kernel: Adding 2097136k swap on /dev/hda5.  Priority:-1 extents:1
Jan 27 09:27:46 crypto kernel: NET: Registered protocol family 17

lspci -v:
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
	Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown device e212
	Flags: bus master, medium devsel, latency 8
	Memory at da000000 (32-bit, prefetchable) [size=16M]
	Capabilities: [a0] AGP version 2.0
	Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: d8000000-d9ffffff
	Prefetchable memory behind bridge: d0000000-d7ffffff
	Capabilities: [80] Power Management version 2

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: [c0] Power Management version 2

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
	Flags: bus master, medium devsel, latency 32
	I/O ports at 9000 [size=16]
	Capabilities: [c0] Power Management version 2

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 1a) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Flags: bus master, medium devsel, latency 32, IRQ 12
	I/O ports at 9400 [size=32]
	Capabilities: [80] Power Management version 2

00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 1a) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Flags: bus master, medium devsel, latency 32, IRQ 12
	I/O ports at 9800 [size=32]
	Capabilities: [80] Power Management version 2

00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown device e212
	Flags: medium devsel, IRQ 5
	Capabilities: [68] Power Management version 2

00:09.0 Unknown mass storage controller: Promise Technology, Inc. 20267 (rev 02)
	Subsystem: Promise Technology, Inc. Ultra100
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at a000 [size=8]
	I/O ports at a400 [size=4]
	I/O ports at a800 [size=8]
	I/O ports at ac00 [size=4]
	I/O ports at b000 [size=64]
	Memory at dc000000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [58] Power Management version 1

00:0b.0 Unknown mass storage controller: Promise Technology, Inc. 20269 (rev 02) (prog-if 85)
	Subsystem: Promise Technology, Inc. Ultra133TX2
	Flags: bus master, 66Mhz, slow devsel, latency 32, IRQ 10
	I/O ports at b400 [size=8]
	I/O ports at b800 [size=4]
	I/O ports at bc00 [size=8]
	I/O ports at c000 [size=4]
	I/O ports at c400 [size=16]
	Memory at dc020000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at <unassigned> [disabled] [size=16K]
	Capabilities: [60] Power Management version 1

00:0c.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 6c)
	Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
	Flags: bus master, medium devsel, latency 32, IRQ 12
	I/O ports at c800 [size=128]
	Memory at dc024000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2

01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX/MX 400] (rev a1) (prog-if 00 [VGA])
	Subsystem: Hercules: Unknown device 0020
	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 11
	Memory at d8000000 (32-bit, non-prefetchable) [size=16M]
	Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [60] Power Management version 2
	Capabilities: [44] AGP version 2.0

kernel .config
#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_STANDALONE=y
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_IKCONFIG is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
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
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
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
# CONFIG_HPET_TIMER is not set
# CONFIG_HPET_EMULATE_RTC is not set
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_HAVE_DEC_LOCK=y

#
# Power management options (ACPI, APM)
#
# CONFIG_PM is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_ASUS=m
CONFIG_ACPI_TOSHIBA=m
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_ACPI_RELAXED_AML is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_LEGACY_PROC is not set
# CONFIG_PCI_NAMES is not set
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
# CONFIG_HOTPLUG is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=m
# CONFIG_BINFMT_MISC is not set

#
# Device Drivers
#

#
# Generic Driver Options
#

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
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
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_IDE_TASKFILE_IO is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
# CONFIG_IDEDMA_PCI_AUTO is not set
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
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
CONFIG_BLK_DEV_PDC202XX_OLD=y
# CONFIG_PDC202XX_BURST is not set
CONFIG_BLK_DEV_PDC202XX_NEW=y
# CONFIG_PDC202XX_FORCE is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_IDEDMA_AUTO is not set
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_SCSI is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
# CONFIG_BLK_DEV_MD is not set
CONFIG_BLK_DEV_DM=y
CONFIG_DM_IOCTL_V4=y

#
# Fusion MPT device support
#

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
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
CONFIG_PACKET=m
# CONFIG_PACKET_MMAP is not set
CONFIG_NETLINK_DEV=m
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_IPV6 is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_NETFILTER is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
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
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_MII is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=y
# CONFIG_TYPHOON is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
# CONFIG_NET_PCI is not set

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
# CONFIG_SIS190 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# Bluetooth support
#
# CONFIG_BT is not set

#
# ISDN subsystem
#
# CONFIG_ISDN_BOOL is not set

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
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

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
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256

#
# Mice
#
CONFIG_BUSMOUSE=m
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=y
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
# CONFIG_HANGCHECK_TIMER is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
# CONFIG_FB is not set
CONFIG_VIDEO_SELECT=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB is not set
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_GADGET is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
CONFIG_MINIX_FS=m
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=y
# CONFIG_DEVPTS_FS_XATTR is not set
# CONFIG_TMPFS is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
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
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
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
CONFIG_NLS_DEFAULT="cp437"
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
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
# CONFIG_NLS_ISO8859_13 is not set
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_FRAME_POINTER is not set

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Library routines
#
# CONFIG_CRC32 is not set
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y



Jan 27 09:27:47 crypto lpd[231]: restarted


