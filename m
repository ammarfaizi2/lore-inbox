Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130802AbRAHCbf>; Sun, 7 Jan 2001 21:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131143AbRAHCb0>; Sun, 7 Jan 2001 21:31:26 -0500
Received: from nilpferd.fachschaften.tu-muenchen.de ([129.187.176.79]:16332
	"HELO nilpferd.fachschaften.tu-muenchen.de") by vger.kernel.org
	with SMTP id <S130802AbRAHCbM>; Sun, 7 Jan 2001 21:31:12 -0500
Date: Mon, 8 Jan 2001 03:31:09 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: <bunk@pluto.fachschaften.tu-muenchen.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Related VIA PCI crazyness?
In-Reply-To: <93avg9$rlk$1@penguin.transmeta.com>
Message-ID: <Pine.NEB.4.31.0101080320400.10802-100000@pluto.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Jan 2001, Linus Torvalds wrote:

> In article <20010107122800.A636@kantaka.co.uk>,
> Philip Armstrong  <phil@kantaka.co.uk> wrote:
> >In supplement to Evan Thompson's emails with the subject "Additional
> >info. for PCI VIA IDE crazyness. Please read." I've noticed the
> >following message with recent 2.4.0 test + release kernels:
> >
> >IRQ routing conflict in pirq table! Try 'pci=autoirq'
>
> But the machine still works fine, ie the SCSI driver and the network
> driver still seem happy?
>...
> Christian Engstler seems to have a problem much like yours, where it
> gets a different irq line than the one that is apparently in use.  It
> looks like Christian, too, has a working machine, and that the only bad
> result of this all is an annoying printk message.  Can you confirm that
> things actually work for you too, and you'd just like to get rid of the
> unnerving message?

Philip wrote in a PM to me that he has no problems with his machine (same
as for me).

I don't know if it's related, but has anyone with a card not manufactored
by RealTek the same problem? Philip and Albert have a RTL8139 and I have a
RTL-8029.

>...
> Could anybody with a VIA chip who has the energy please do something for
> me:
>  - enable DEBUG in arch/i386/kernel/pci-i386.h

Output of dmesg:

Linux version 2.4.0 (bunk@r063144.stusta.swh.mhn.de) (gcc version 2.95.2
2000022
0 (Debian GNU/Linux)) #1 Mon Jan 8 02:49:37 CET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (usable)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
 BIOS-e820: 0000000003f00000 @ 0000000000100000 (usable)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c0000000 for 4096 bytes.
On node 0 totalpages: 16384
zone(0): 4096 pages.
zone(1): 12288 pages.
zone(2): 0 pages.
mapped APIC to ffffe000 (01112000)
Kernel command line: BOOT_IMAGE=test ro root=306 BOOT_FILE=/boot/test
reserve=0x
340,0x20 reserve=0x800,0x20 ether=10,0x340,eth1 ether=0,0x800,eth0
Initializing CPU#0
Detected 299.753 MHz processor.
Console: colour VGA+ 132x43
Calibrating delay loop... 598.01 BogoMIPS
Memory: 62304k/65536k available (957k kernel code, 2844k reserved, 369k
data, 20
4k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
CPU: Before vendor init, caps: 008001bf 008005bf 00000000, vendor = 2
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: After vendor init, caps: 008001bf 008005bf 00000000 00000000
CPU: After generic, caps: 008001bf 008005bf 00000000 00000000
CPU: Common caps: 008001bf 008005bf 00000000 00000000
CPU: AMD-K6tm w/ multimedia extensions stepping 00
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: BIOS32 Service Directory structure at 0xc00fafb0
PCI: BIOS32 Service Directory entry at 0xfb430
PCI: BIOS probe returned s=00 hw=11 ver=02.10 l=01
PCI: PCI BIOS revision 2.10 entry at 0xfb460, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: IDE base address fixup for 00:07.1
PCI: Scanning for ghost devices on bus 0
PCI: Scanning for ghost devices on bus 1
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: IRQ init
PCI: Interrupt Routing Table found at 0xc00fde50
00:08 slot=01 0:01/deb8 1:02/deb8 2:03/deb8 3:05/deb8
00:09 slot=02 0:02/deb8 1:03/deb8 2:05/deb8 3:01/deb8
00:0a slot=03 0:03/deb8 1:05/deb8 2:01/deb8 3:02/deb8
00:0b slot=04 0:05/deb8 1:01/deb8 2:02/deb8 3:03/deb8
00:07 slot=00 0:01/deb8 1:02/deb8 2:03/deb8 3:05/deb8
00:01 slot=00 0:01/deb8 1:02/deb8 2:03/deb8 3:05/deb8
PCI: Using IRQ router VIA [1106/0586] at 00:07.0
PCI: IRQ fixup
PCI: Allocating resources
PCI: Resource e0000000-e7ffffff (f=1208, d=0, p=0)
PCI: Resource 0000e000-0000e00f (f=101, d=0, p=0)
PCI: Resource e8000000-ebffffff (f=200, d=0, p=0)
PCI: Resource 0000e800-0000e81f (f=101, d=0, p=0)
PCI: Sorting device list...
Activating ISA DMA hang workarounds.
isapnp: Scanning for Pnp cards...
isapnp: Card 'HIGHSCREEN SOUND-BOOSTAR 16 3D'
isapnp: 1 Plug & Play card detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
DMI 2.0 present.
30 structures occupying 836 bytes.
DMI table at 0x000F0800.
BIOS Vendor: Award Software International, Inc.
BIOS Version: BIOS VER:1.0 03 GS
BIOS Release: 10/18/99
System Vendor: A-Trend.
Product Name: ATC-5220.
Version BIOS VER:1.0 03 GS.
Serial Number ATC52201003GS.
Board Vendor: A-Trend.
Board Name: VP3-586B-SMC669.
Board Version: VER:1.0 03 GS.
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
Starting kswapd v1.8
parport0: PC-style at 0x378 [PCSPP(,...)]
lp0: using parport0 (polling).
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c586b IDE UDMA33 controller on pci0:7.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 92041U4, ATA DISK drive
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
hdc: TOSHIBA CD-ROM XM-6302B, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 40020624 sectors (20491 MB) w/512KiB Cache, CHS=2491/255/63, UDMA(33)
hdc: ATAPI 32X CD-ROM drive, 256kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda3 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 hda13 hda14 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
ne.c:v1.10 9/23/94 Donald Becker (becker@scyld.com)
Last modified Nov 1, 2000 by Paul Gortmaker
NE*000 ethercard probe at 0x340: 00 4f 4c 04 6f 27
eth1: NE2000 found at 0x340, using IRQ 10.
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ
SERIAL_PCI ISA
PNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
IRQ for 00:0b.0:0 -> PIRQ 05, mask deb8, excl 1800 -> newirq=12 -> got IRQ
11
IRQ routing conflict in pirq table! Try 'pci=autoirq'
eth0: RealTek RTL-8029 found at 0xe800, IRQ 12, 00:40:05:32:EB:19.


>  - do a "/sbin/lspci -xxvvv" on the interrupt routing chip (it's the
>    "ISA bridge" chip - the VIA numbers are 82c586, 82c596, the PCI
>    numbers for them are 1106:0586 and 1106:0596, I think)

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo
VP] (rev 41)
        Subsystem: VIA Technologies, Inc. MVP3 ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
00: 06 11 86 05 8f 00 00 02 41 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


>  - do a cat /proc/pci

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT82C597 [Apollo VP3] (rev 4).
      Master Capable.  Latency=16.
      Prefetchable 32 bit memory at 0xe0000000 [0xe7ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x
AGP] (rev 0).
      Master Capable.  No bursts.  Min Gnt=4.
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP]
(rev 65).
  Bus  0, device   7, function  1:
    IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 6).
      Master Capable.  Latency=64.
      I/O at 0xe000 [0xe00f].
  Bus  0, device   7, function  3:
    Host bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 16).
  Bus  0, device  10, function  0:
    VGA compatible controller: S3 Inc. ViRGE/DX or /GX (rev 1).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=4.Max Lat=255.
      Non-prefetchable 32 bit memory at 0xe8000000 [0xebffffff].
  Bus  0, device  11, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS) (rev
0).
      IRQ 12.
      I/O at 0xe800 [0xe81f].



>...
> 		Linus

cu,
Adrian

-- 
A "No" uttered from deepest conviction is better and greater than a
"Yes" merely uttered to please, or what is worse, to avoid trouble.
                -- Mahatma Ghandi





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
