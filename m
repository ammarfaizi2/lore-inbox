Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263194AbSJCIGU>; Thu, 3 Oct 2002 04:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263196AbSJCIGT>; Thu, 3 Oct 2002 04:06:19 -0400
Received: from verlaine.noos.net ([212.198.2.73]:19548 "EHLO smtp.noos.fr")
	by vger.kernel.org with ESMTP id <S263194AbSJCIGC>;
	Thu, 3 Oct 2002 04:06:02 -0400
Date: Thu, 3 Oct 2002 10:13:51 +0200
From: Thierry Mallard <shaman@vawis.net>
To: Greg KH <gregkh@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Similar warning in slab.c - kernel 2.5.40
Message-ID: <20021003081351.GA1852@hobbes.local.vawis.net>
References: <200210011654.g91GsaU29508@eng2.beaverton.ibm.com> <20021001170246.GA15890@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20021001170246.GA15890@us.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

FYI, I just compiled and installed linux 2.5.40 on Debian 3.0r0 system,
and noticed a similar warning. It didn't show in 2.5.39, AFAIK.

-=-=-=-
Linux version 2.5.40 (root@hobbes.local.vawis.net) (gcc version 2.95.4 20011002 (Debian prerelease)) #2 Wed Oct 2 22:05:09 CEST 2002
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000003000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
48MB LOWMEM available.
On node 0 totalpages: 12288
  DMA zone: 4096 pages
  Normal zone: 8192 pages
  HighMem zone: 0 pages
Building zonelist for node : 0
Kernel command line: root=/dev/hdd1
Initializing CPU#0
Detected 166.122 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 326.65 BogoMIPS
Memory: 45548k/49152k available (1195k kernel code, 3220k reserved, 432k data, 244k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Before vendor init, caps: 008001bf 00000000 00000000, vendor = 0
Intel Pentium with F0 0F bug - workaround enabled.
CPU: After vendor init, caps: 008001bf 00000000 00000000 00000000
CPU:     After generic, caps: 008001bf 00000000 00000000 00000000
CPU:             Common caps: 008001bf 00000000 00000000 00000000
CPU: Intel Pentium MMX stepping 03
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xfb1a0, last bus=0
PCI: Using configuration type 1
adding '' to cpu class interfaces
isapnp: Scanning for PnP cards...
isapnp: Card 'PnP Sound Chip'
isapnp: 1 Plug & Play card detected total
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbe70
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbe98, dseg 0xf0000
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
PnPBIOS: PNP0c02: ioport range 0x208-0x20f has been reserved
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/0586] at 00:07.0
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs:  86 entries (12 bytes)
biovec pool[1]:   4 bvecs:  86 entries (48 bytes)
biovec pool[2]:  16 bvecs:  43 entries (192 bytes)
biovec pool[3]:  64 bvecs:  21 entries (768 bytes)
biovec pool[4]: 128 bvecs:  10 entries (1536 bytes)
biovec pool[5]: 256 bvecs:   5 entries (3072 bytes)
aio_setup: sizeof(struct page) = 40
Journalled Block Device driver loaded
Capability LSM initialized
Activating ISA DMA hang workarounds.
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
pty: 256 Unix98 ptys configured
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 16M
agpgart: no supported devices found.
[drm] Initialized radeon 1.6.0 20020828 on minor 0
block request queues:
 80 requests per read queue
 80 requests per write queue
 8 requests per batch
 enter congestion at 19
 exit congestion at 21
Floppy drive(s): fd0 is 1.44M
apm: driver version: Interface not connected
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c586a (rev 27) IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0x6000-0x6007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x6008-0x600f, BIOS settings: hdc:pio, hdd:pio
hda: FUJITSU MPB3021ATU, ATA DISK drive
hda: DMA disabled
Debug: sleeping function called from illegal context at slab.c:1374
c10b5eb0 c01138d1 c0232d80 c02371d6 0000055e 00000000 c012d827 c02371d6 
       0000055e c0321334 c03212fc c109d380 00000000 c01b7a60 c10fec20 000001d0 
       c03212fc c03212ec c109d380 00000000 00000000 c01b7af1 c03212fc c03212fc 
Call Trace:
 [<c01138d1>]__might_sleep+0x55/0x64
 [<c012d827>]kmem_cache_alloc+0x23/0xf0
 [<c01b7a60>]blk_init_free_list+0x4c/0xd0
 [<c01b7af1>]blk_init_queue+0xd/0xe8
 [<c01c4bf4>]ide_init_queue+0x28/0x68
 [<c01cb240>]do_ide_request+0x0/0x18
 [<c01c4ed8>]init_irq+0x2a4/0x358
 [<c01c5236>]hwif_init+0x10a/0x258
 [<c01c4b1c>]probe_hwif_init+0x1c/0x70
 [<c01d5067>]ide_setup_pci_device+0x47/0x80
 [<c010508a>]init+0x2a/0x180
 [<c0105060>]init+0x0/0x180
 [<c01054a5>]kernel_thread_helper+0x5/0xc

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: OSD OJC-W101, ATAPI CD/DVD-ROM drive
hdd: FUJITSU M1636TAU, ATA DISK drive
hdc: DMA disabled
hdd: DMA disabled
Debug: sleeping function called from illegal context at slab.c:1374
c10b5eb0 c01138d1 c0232d80 c02371d6 0000055e 00000000 c012d827 c02371d6 
       0000055e c032190c c03218d4 c109d440 00000000 c01b7a60 c10fec20 000001d0 
       c03218d4 c03218c4 c109d440 00000000 00000000 c01b7af1 c03218d4 c03218d4 
Call Trace:
 [<c01138d1>]__might_sleep+0x55/0x64
 [<c012d827>]kmem_cache_alloc+0x23/0xf0
 [<c01b7a60>]blk_init_free_list+0x4c/0xd0
 [<c01b7af1>]blk_init_queue+0xd/0xe8
 [<c01c4bf4>]ide_init_queue+0x28/0x68
 [<c01cb240>]do_ide_request+0x0/0x18
 [<c01c4ed8>]init_irq+0x2a4/0x358
 [<c01c5236>]hwif_init+0x10a/0x258
 [<c01c4b1c>]probe_hwif_init+0x1c/0x70
 [<c01d5098>]ide_setup_pci_device+0x78/0x80
 [<c010508a>]init+0x2a/0x180
 [<c0105060>]init+0x0/0x180
 [<c01054a5>]kernel_thread_helper+0x5/0xc

ide1 at 0x170-0x177,0x376 on irq 15
apm: get_event: Interface not connected
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
hda: 4224150 sectors (2163 MB), CHS=523/128/63, UDMA(33)
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 >
hdd: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hdd: task_no_data_intr: error=0x04 { DriveStatusError }
hdd: 2511840 sectors (1286 MB) w/128KiB Cache, CHS=2491/16/63, DMA
 hdd: hdd1
hdc: ATAPI 20X CD-ROM drive, 0kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
register interface 'mouse' with class 'input
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 244k freed
Adding 96728k swap on /dev/hda7.  Priority:-1 extents:1
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
PCI: Assigned IRQ 10 for device 00:0e.0
eth0: RealTek RTL-8029 found at 0x6200, IRQ 10, 00:50:BA:B2:AE:B4.
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: mounting unchecked fs, running e2fsck is recommended
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,8), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Debug: sleeping function called from illegal context at slab.c:1374
c21d3f6c c01138d1 c0232d80 c02371d6 0000055e 000001d0 c012d940 c02371d6 
       0000055e 00000000 00000400 bffffdc4 c21dea20 c010afe7 00000080 000001d0 
       c21d2000 00000100 bffffdc4 bffffccc 00000000 c0107007 00000000 00000400 
Call Trace:
 [<c01138d1>]__might_sleep+0x55/0x64
 [<c012d940>]kmalloc+0x4c/0x130
 [<c010afe7>]sys_ioperm+0x7f/0x124
 [<c0107007>]syscall_call+0x7/0xb

Debug: sleeping function called from illegal context at slab.c:1374
c0f13f6c c01138d1 c0232d80 c02371d6 0000055e 000001d0 c012d940 c02371d6 
       0000055e 00000000 00000400 bffffd64 c1d49680 c010afe7 00000080 000001d0 
       c0f12000 00000100 bffffd64 bffffc6c 00000000 c0107007 00000000 00000400 
Call Trace:
 [<c01138d1>]__might_sleep+0x55/0x64
 [<c012d940>]kmalloc+0x4c/0x130
 [<c010afe7>]sys_ioperm+0x7f/0x124
 [<c0107007>]syscall_call+0x7/0xb

Debug: sleeping function called from illegal context at slab.c:1374
c0d61f6c c01138d1 c0232d80 c02371d6 0000055e 000001d0 c012d940 c02371d6 
       0000055e 00000000 00000400 bffffd64 c1d48a40 c010afe7 00000080 000001d0 
       c0d60000 00000100 bffffd64 bffffc6c 00000000 c0107007 00000000 00000400 
Call Trace:
 [<c01138d1>]__might_sleep+0x55/0x64
 [<c012d940>]kmalloc+0x4c/0x130
 [<c010afe7>]sys_ioperm+0x7f/0x124
 [<c0107007>]syscall_call+0x7/0xb

Debug: sleeping function called from illegal context at slab.c:1374
c0c01f6c c01138d1 c0232d80 c02371d6 0000055e 000001d0 c012d940 c02371d6 
       0000055e 00000000 00000400 bffffd64 c1d49680 c010afe7 00000080 000001d0 
       c0c00000 00000100 bffffd64 bffffc6c 00000000 c0107007 00000000 00000400 
Call Trace:
 [<c01138d1>]__might_sleep+0x55/0x64
 [<c012d940>]kmalloc+0x4c/0x130
 [<c010afe7>]sys_ioperm+0x7f/0x124
 [<c0107007>]syscall_call+0x7/0xb

Debug: sleeping function called from illegal context at slab.c:1374
c25a3f6c c01138d1 c0232d80 c02371d6 0000055e 000001d0 c012d940 c02371d6 
       0000055e 00000000 00000400 bffffe04 c2935c60 c010afe7 00000080 000001d0 
       c25a2000 00000100 bffffe04 bffffd0c 00000000 c0107007 00000000 00000400 
Call Trace:
 [<c01138d1>]__might_sleep+0x55/0x64
 [<c012d940>]kmalloc+0x4c/0x130
 [<c010afe7>]sys_ioperm+0x7f/0x124
 [<c0107007>]syscall_call+0x7/0xb

-=-=-=

With kind regards,
 

-- 
Thierry Mallard
http://vawis.net

