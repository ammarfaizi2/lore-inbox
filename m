Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135641AbRA0Vbd>; Sat, 27 Jan 2001 16:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135640AbRA0VbX>; Sat, 27 Jan 2001 16:31:23 -0500
Received: from ruddock-157.caltech.edu ([131.215.90.157]:260 "EHLO
	alex.caltech.edu") by vger.kernel.org with ESMTP id <S135596AbRA0VbO>;
	Sat, 27 Jan 2001 16:31:14 -0500
Date: Sat, 27 Jan 2001 13:32:41 -0800
From: David Bustos <bustos@its.caltech.edu>
To: linux-kernel@vger.kernel.org
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: es1371 freezes 2.4.0 hard
Message-ID: <20010127133241.A504@alex.caltech.edu>
In-Reply-To: <20010124154457.A491@alex.caltech.edu> <3A70451D.C599794A@mandrakesoft.com> <20010125120729.A516@alex.caltech.edu> <3A72D9B5.941526CE@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3A72D9B5.941526CE@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sat, Jan 27, 2001 at 09:22:45AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoth Jeff Garzik on Sat, Jan 27, 2001 at 09:22:45AM -0500:
[...]
> But removing pci_enable_device is incorrect; it merely avoids what
> appears to be a bug with your Via irq routing.  Would it be possible for
> you to edit linux/arch/i386/kernel/pci-i386.h, and change the line near
> the top from
> 	#undef DEBUG
> to
> 	#define DEBUG 1
> and then send the output of 'dmesg -s 16384' to linux-kernel (and CC
> me)?  That will dump your PCI IRQ routing information, among other
> details.

Linux version 2.4.0 (david@alex.caltech.edu) (gcc version 2.95.3 20010111 (prerelease)) #9 Sat Jan 27 13:04:26 PST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (usable)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
 BIOS-e820: 0000000007ef0000 @ 0000000000100000 (usable)
 BIOS-e820: 000000000000d000 @ 0000000007ff3000 (ACPI data)
 BIOS-e820: 0000000000003000 @ 0000000007ff0000 (ACPI NVS)
On node 0 totalpages: 32752
zone(0): 4096 pages.
zone(1): 28656 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=debug ro root=301
Initializing CPU#0
Detected 350.804 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 699.59 BogoMIPS
Memory: 127048k/131008k available (822k kernel code, 3572k reserved, 293k data, 72k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
CPU: Before vendor init, caps: 008021bf 808029bf 00000000, vendor = 2
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: After vendor init, caps: 008021bf 808029bf 00000000 00000002
CPU: After generic, caps: 008021bf 808029bf 00000000 00000002
CPU: Common caps: 008021bf 808029bf 00000000 00000002
CPU: AMD-K6(tm) 3D processor stepping 0c
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: AMD K6
PCI: BIOS32 Service Directory structure at 0xc00fafb0
PCI: BIOS32 Service Directory entry at 0xfb430
PCI: BIOS probe returned s=00 hw=11 ver=02.10 l=01
PCI: PCI BIOS revision 2.10 entry at 0xfb460, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: IDE base address fixup for 00:07.1
PCI: Scanning for ghost devices on bus 0
PCI: Scanning for ghost devices on bus 1
PCI: IRQ init
PCI: Interrupt Routing Table found at 0xc00fde00
00:08 slot=01 0:01/deb8 1:02/deb8 2:03/deb8 3:05/deb8
00:09 slot=02 0:02/deb8 1:03/deb8 2:05/deb8 3:01/deb8
00:0a slot=03 0:03/deb8 1:05/deb8 2:01/deb8 3:02/deb8
00:0b slot=04 0:05/deb8 1:01/deb8 2:02/deb8 3:03/deb8
00:0c slot=05 0:01/deb8 1:02/deb8 2:03/deb8 3:05/deb8
00:07 slot=00 0:01/deb8 1:02/deb8 2:00/deb8 3:00/deb8
00:01 slot=00 0:01/deb8 1:02/deb8 2:03/deb8 3:05/deb8
PCI: Using IRQ router VIA [1106/0586] at 00:07.0
PCI: IRQ fixup
01:00.0: ignoring bogus IRQ 255
IRQ for 01:00.0:0 -> not found in routing table
PCI: Allocating resources
PCI: Resource e0000000-e3ffffff (f=1208, d=0, p=0)
PCI: Resource 0000e000-0000e00f (f=101, d=0, p=0)
PCI: Resource 0000e800-0000e83f (f=101, d=0, p=0)
PCI: Resource 0000ec00-0000ec7f (f=101, d=0, p=0)
PCI: Resource e8000000-e800007f (f=200, d=0, p=0)
PCI: Resource e4000000-e4ffffff (f=200, d=0, p=0)
PCI: Resource e6000000-e6ffffff (f=1208, d=0, p=0)
PCI: Sorting device list...
Activating ISA DMA hang workarounds.
isapnp: Scanning for Pnp cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
Starting kswapd v1.8
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c586b IDE UDMA33 controller on pci0:7.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC AC26400B, ATA DISK drive
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hdc: ATAPI CD-ROM DRIVE 40X MAX, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 12594960 sectors (6449 MB) w/512KiB Cache, CHS=784/255/63, UDMA(33)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 >
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
3c59x.c:LK1.1.11 13 Nov 2000  Donald Becker and others. http://www.scyld.com/network/vortex.html $Revision: 1.102.2.46 $
See Documentation/networking/vortex.txt
eth0: 3Com PCI 3c905B Cyclone 100baseTx at 0xec00, IRQ for 00:0b.0:0 -> PIRQ 05, mask deb8, excl 0c00 -> newirq=10 -> got IRQ 11
IRQ routing conflict in pirq table! Try 'pci=autoirq'
 00:10:5a:9d:56:11, IRQ 10
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 786d.
  MII transceiver found at address 0, status 786d.
  Enabling bus-master transmits and whole-frame receives.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 72k freed
Adding Swap: 64224k swap-space (priority -1)
inserting floppy driver for 2.4.0
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
hdc: ATAPI 24X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
reiserfs: checking transaction log (device 03:07) ...
Using tea hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.25
eth0: using NWAY autonegotiation
cdrom: open failed.
VFS: Disk change detected on device ide1(22,0)
es1371: version v0.27 time 12:21:28 Jan 25 2001
es1371: found chip, vendor id 0x1274 device id 0x1371 revision 0x02
es1371: found es1371 rev 2 at io 0xe800 irq 11
es1371: features: joystick 0x0
ac97_codec: AC97  codec, id: 0x414a:0x4d00 (Unknown)

> Step two, "modprobe es1371" with pci_enable_device -in- the code, and
> with debugging enabled as described above.  IIRC it should print out a
> few more lines of debugging information that will be helpful.  Since we
> are dealing with a hard lock, these last few lines of debugging info
> might have to be copied via a serial console, or by hand.

By hand:
IRQ for 00:0a.00:0 -> PIRQ 03, mask deb8, excl 0c00 -> newirq=11 -> assigning IRQ 11 -> edge ... OK
PCI: Assigned IRQ 11 for device 00:0a.0

> One last question... is this an SMP machine?  If so, let me know if
> booting with "noapic" option on the command line fixes things.

Nope, one processor.


Thanks,
David Bustos
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
