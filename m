Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136167AbRAHJXO>; Mon, 8 Jan 2001 04:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135621AbRAHJXE>; Mon, 8 Jan 2001 04:23:04 -0500
Received: from node1.teliafi.net ([195.10.132.101]:46752 "EHLO
	mbox.teliafi.net") by vger.kernel.org with ESMTP id <S132903AbRAHJWp>;
	Mon, 8 Jan 2001 04:22:45 -0500
Date: Mon, 08 Jan 2001 11:22:40 +0200
From: Aschwin van der Woude <aschwin@sofis.fi>
Subject: Re: Kernel halts rock solid on assigning ip (ne2k-pci)
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        becker@scyld.com, linux-net@vger.kernel.org,
        Paul Gortmaker <p_gortmaker@yahoo.com>
Message-id: <3A5986E0.B1F4C5F8@sofis.fi>
Organization: Sofis design
MIME-version: 1.0
X-Mailer: Mozilla 4.7 [en] (X11; U; Linux 2.4.0-test10 i586)
Content-type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_/j0KrDoGqnxG6dFCZLeEJw)"
X-Accept-Language: en
In-Reply-To: <Pine.LNX.4.10.10101050946180.7111-100000@coffee.psychology.mcmaster.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_/j0KrDoGqnxG6dFCZLeEJw)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT

Mark Hahn wrote:
> 
> > But as soon as I try to assign an IP-adress the whole system halts
> > rock-solid, the magic sysrq combinations don't even work anymore.
> 
> I notice that the driver detects irq11, but it doesn't show in
> /proc/interrupts.  are there no other kernel messages?
> 
> someone else reported a similar problem with a 3c9xx, btw.
> I suspect some late pci/irq changes cause the problem.

I attached the dmesg just after boot.
When I disable the BIOS setting 'PnP OS', the network-card is assigned
to IRQ 10. But this doesn't solve the problem.

-- 
"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.

--Boundary_(ID_/j0KrDoGqnxG6dFCZLeEJw)
Content-type: text/plain; name=ne2k-pci.bugreport.dmesg; charset=us-ascii
Content-disposition: inline; filename=ne2k-pci.bugreport.dmesg
Content-transfer-encoding: 7BIT

Linux version 2.4.0 (root@lorien.sofis.fi) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #14 Fri Jan 5 13:36:52 EET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (usable)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
 BIOS-e820: 0000000005f00000 @ 0000000000100000 (usable)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c0000000 for 4096 bytes.
On node 0 totalpages: 24576
zone(0): 4096 pages.
zone(1): 20480 pages.
zone(2): 0 pages.
mapped APIC to ffffe000 (0119a000)
Kernel command line: BOOT_IMAGE=linux24 ro root=301
Initializing CPU#0
Detected 375.856 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 750.38 BogoMIPS
Memory: 94140k/98304k available (1196k kernel code, 3776k reserved, 466k data, 220k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
CPU: Before vendor init, caps: 008021bf 808029bf 00000000, vendor = 2
Enabling new style K6 write allocation for 96 Mb
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: After vendor init, caps: 008021bf 808029bf 00000000 00000002
CPU: After generic, caps: 008021bf 808029bf 00000000 00000002
CPU: Common caps: 008021bf 808029bf 00000000 00000002
CPU: AMD-K6(tm) 3D processor stepping 0c
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: AMD K6
PCI: PCI BIOS revision 2.10 entry at 0xfb000, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router VIA [1106/0586] at 00:07.0
Activating ISA DMA hang workarounds.
isapnp: Scanning for Pnp cards...
isapnp: Calling quirk for 01:03
isapnp: CMI8330 quirk - fixing interrupts and dma
isapnp: Card 'CMI8330/C3D Audio Adapter'
isapnp: 1 Plug & Play card detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
Starting kswapd v1.8
matroxfb: Matrox Productiva G100 (AGP) detected
matroxfb: MTRR's turned on
matroxfb: 640x480x8bpp (virtual: 640x13100)
matroxfb: framebuffer at 0xE4000000, mapped to 0xc6805000, size 8388608
Console: switching to colour frame buffer device 80x30
fb0: MATROX VGA frame buffer device
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c586b IDE UDMA33 controller on pci0:7.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
hda: IBM-DTTA-351010, ATA DISK drive
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hdc: 8X CD-ROM, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 19807200 sectors (10141 MB) w/466KiB Cache, CHS=1232/255/63, UDMA(33)
hdc: ATAPI CD-ROM drive, 240kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 62M
agpgart: Detected Via MVP3 chipset
agpgart: AGP aperture is 4M @ 0xe6000000
[drm] AGP 0.99 on VIA MVP3 @ 0xe6000000 4MB
[drm] Initialized mga 2.0.1 20000928 on minor 63
es1371: version v0.27 time 10:56:19 Jan  5 2001
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ACPI: System description tables not found
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 220k freed
Adding Swap: 104384k swap-space (priority -1)
Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
sb: CMI8330/C3D Audio Adapter detected
sb: ISAPnP reports 'CMI8330/C3D Audio Adapter' at i/o 0x220, irq 5, dma 1, 5
SB 4.13 detected OK (220)
sb: 1 Soundblaster PnP card(s) found.
ne2k-pci.c:vpre-1.00e 5/27/99 D. Becker/P. Gortmaker http://cesdis.gsfc.nasa.gov/linux/drivers/ne2k-pci.html
PCI: Assigned IRQ 11 for device 00:08.0
eth0: Winbond 89C940 found at 0xe800, IRQ 11, 48:54:E8:2B:CB:F7.
nfs warning: mount version older than kernel

--Boundary_(ID_/j0KrDoGqnxG6dFCZLeEJw)--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
