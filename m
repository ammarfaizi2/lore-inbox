Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285392AbRLNPWq>; Fri, 14 Dec 2001 10:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285395AbRLNPWi>; Fri, 14 Dec 2001 10:22:38 -0500
Received: from mail.internet-factory.de ([195.122.142.5]:14534 "EHLO
	mail.internet-factory.de") by vger.kernel.org with ESMTP
	id <S285393AbRLNPWc>; Fri, 14 Dec 2001 10:22:32 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Holger Lubitz <h.lubitz@internet-factory.de>
Newsgroups: lists.linux.kernel
Subject: Re: Who sees "IRQ routing conflict" in dmesg?
Date: Fri, 14 Dec 2001 16:22:30 +0100
Organization: Internet Factory AG
Message-ID: <3C1A1936.49049C04@internet-factory.de>
In-Reply-To: <1005288566.32719.0.camel@stomata.megapathdsl.net> <1005442525.14433.1.camel@stomata.megapathdsl.net>
NNTP-Posting-Host: bastille.internet-factory.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: darkstar.internet-factory.de 1008343350 21709 195.122.142.158 (14 Dec 2001 15:22:30 GMT)
X-Complaints-To: usenet@internet-factory.de
NNTP-Posting-Date: 14 Dec 2001 15:22:30 GMT
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13-ac7 i686)
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane proclaimed:
> 
> I have had no replies to my previous message.
> Now, I am seeing a new problem in 2.4.15-pre2.
> pci=biosirq is failing altogether.
> 

Same here (with 2.4.16):

PCI: PCI BIOS revision 2.10 entry at 0xfdb91, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Error 89 when fetching IRQ routing table.

If I boot without pci=biosirq, the systems fails to recognize some
interrupt (I think it was 14) and tells me to use pci=biosirq. The
system _seems_ to be running fine, though (with or without biosirq
option)

dmesg output:

Linux version 2.4.16 (root@suck) (gcc version 2.96 20000731 (Red Hat
Linux 7.1 2.96-98)) #1 Fri Nov 30 16:13:08 CET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000003c00000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
On node 0 totalpages: 15360
zone(0): 4096 pages.
zone(1): 11264 pages.
zone(2): 0 pages.
Kernel command line: ro root=/dev/hda2 pci=biosirq
Initializing CPU#0
Detected 233.862 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 466.94 BogoMIPS
Memory: 58456k/61440k available (928k kernel code, 2596k reserved, 245k
data, 192k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode...
Ok.
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
CPU: Before vendor init, caps: 0080a135 00000000 00000000, vendor = 1
CPU: After vendor init, caps: 0080a135 00000000 00000000 00000004
CPU:     After generic, caps: 0080a135 00000000 00000000 00000004
CPU:             Common caps: 0080a135 00000000 00000000 00000004
CPU: Cyrix M II 3.5x Core/Bus Clock stepping 08
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Cyrix ARR
PCI: PCI BIOS revision 2.10 entry at 0xfdb91, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Error 89 when fetching IRQ routing table.
Disabling direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: Calling quirk for 01:03
isapnp: CMI8330 quirk - fixing interrupts and dma
isapnp: Card 'CMI8330/C3D Audio Adapter'
isapnp: 1 Plug & Play card detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: 128 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
SIS5513: IDE controller on PCI bus 00 dev 09
PCI: No IRQ known for interrupt pin A of device 00:01.1.
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SiS5597
    ide0: BM-DMA at 0x4000-0x4007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x4008-0x400f, BIOS settings: hdc:pio, hdd:pio
hda: ST34310A, ATA DISK drive
hdb: LEOPTICS CD-ROM 24X v4.6G, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 8420832 sectors (4311 MB) w/512KiB Cache, CHS=524/255/63, UDMA(33)
hdb: ATAPI 20X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 25M
agpgart: no supported devices found.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 192k freed
Adding Swap: 192772k swap-space (priority -1)
EXT3 FS 2.4-0.9.15, 06 Nov 2001 on ide0(3,2), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.15, 06 Nov 2001 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Linux Tulip driver version 0.9.15-pre9 (Nov 6, 2001)
PCI: Setting latency timer of device 00:0f.0 to 32
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1)
block.
tulip0:  MII transceiver #3 config 3100 status 7809 advertising 01e1.
eth0: Digital DS21140 Tulip rev 32 at 0xc4835f00, 00:E0:29:00:3C:8E, IRQ
9.
eth0: Setting full-duplex based on MII#3 link partner capability of
01e1.

lspci -vx output:

00:00.0 Host bridge: Silicon Integrated Systems [SiS] 5597 [SiS5582]
(rev 10)
        Flags: bus master, medium devsel, latency 64
00: 39 10 97 55 07 00 00 22 10 00 00 06 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev
01)
        Flags: bus master, medium devsel, latency 0
00: 39 10 08 00 07 00 00 02 01 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:01.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev
d0) (prog-if 8a [Master SecP PriP])
        Subsystem: Unknown device 0422:1800
        Flags: bus master, fast devsel, latency 128
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at 4000 [size=16]
00: 39 10 13 55 07 00 00 00 d0 8a 01 01 00 80 80 00
10: 01 02 02 85 01 48 32 08 91 04 10 01 41 10 00 80
20: 01 40 00 00 00 00 00 00 00 00 00 00 22 04 00 18
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00

00:0b.0 Network controller: AVM Audiovisuelles MKTG & Computer System
GmbH A1 ISDN [Fritz] (rev 02)
        Subsystem: AVM Audiovisuelles MKTG & Computer System GmbH
FRITZ!Card ISDN Controller
        Flags: medium devsel, IRQ 11
        Memory at ffadffe0 (32-bit, non-prefetchable) [size=32]
        I/O ports at f700 [size=32]
00: 44 12 00 0a 03 01 80 02 02 00 80 02 00 00 00 00
10: e0 ff ad ff 01 f7 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 44 12 00 0a
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 00

00:0d.0 Network controller: AVM Audiovisuelles MKTG & Computer System
GmbH A1 ISDN [Fritz] (rev 02)
        Subsystem: AVM Audiovisuelles MKTG & Computer System GmbH
FRITZ!Card ISDN Controller
        Flags: medium devsel, IRQ 10
        Memory at ffadffc0 (32-bit, non-prefetchable) [size=32]
        I/O ports at f680 [size=32]
00: 44 12 00 0a 03 01 80 02 02 00 80 02 00 00 00 00
10: c0 ff ad ff 81 f6 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 44 12 00 0a
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 01 00 00

00:0f.0 Ethernet controller: Digital Equipment Corporation DECchip 21140
[FasterNet] (rev 20)
        Subsystem: Standard Microsystems Corp [SMC] SMC9332BDT
EtherPower 10/100        Flags: bus master, medium devsel, latency 32,
IRQ 9
        I/O ports at f000 [size=128]
        Memory at ffadff00 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at ffa80000 [disabled] [size=256K]
00: 11 10 09 00 07 01 80 02 20 00 00 02 00 20 00 00
10: 01 f0 00 00 00 ff ad ff 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b8 10 01 20
30: 00 00 a8 ff 00 00 00 00 00 00 00 00 09 01 14 28

00:14.0 VGA compatible controller: Silicon Integrated Systems [SiS]
5597/5598 VGA (rev 68) (prog-if 00 [VGA])
        Subsystem: Silicon Integrated Systems [SiS] 5597/5598 VGA
        Flags: medium devsel
        Memory at ff400000 (32-bit, prefetchable) [size=4M]
        Memory at ffaf0000 (32-bit, non-prefetchable) [size=64K]
        I/O ports at f400 [size=128]
        Expansion ROM at ffae0000 [disabled] [size=32K]
00: 39 10 00 02 03 00 00 02 68 00 00 03 00 00 00 00
10: 08 00 40 ff 00 00 af ff 01 f4 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 39 10 00 02
30: 00 00 ae ff 00 00 00 00 00 00 00 00 00 01 00 00
