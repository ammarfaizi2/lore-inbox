Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbRBHQx2>; Thu, 8 Feb 2001 11:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129098AbRBHQxT>; Thu, 8 Feb 2001 11:53:19 -0500
Received: from river.it.gvsu.edu ([148.61.1.16]:6631 "EHLO river.it.gvsu.edu")
	by vger.kernel.org with ESMTP id <S129066AbRBHQxG>;
	Thu, 8 Feb 2001 11:53:06 -0500
Message-ID: <3A82CEE6.9060204@lycosmail.com>
Date: Thu, 08 Feb 2001 11:52:54 -0500
From: Adam Schrotenboer <ajschrotenboer@lycosmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.1-ac6 i686; en-US; 0.7) Gecko/20010105
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Mem detection problem
Content-Type: multipart/mixed;
 boundary="------------030201070807000308060909"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030201070807000308060909
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This is actually a repost of a problem that received few serious replies 
(IMNSHO).

Basically 2.4.0 detects 192 MB(maybe 191, but big whoop) of memory. This 
is correct. However, 2.4.1-ac6 (as did Linus-blessed 2.4.1) detects 64. 
The problem is simple. 2.4.1 and later for some reason uses bios-88, 
instead of e820.

Attached are the dmesgs from 2.4.0 and 2.4.1-ac6.

--------------030201070807000308060909
Content-Type: text/plain;
 name="dmesg-2.4.0"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-2.4.0"

Linux version 2.4.0 (root@tabriel) (gcc version pgcc-2.95.2 19991024 (release)) #2 Mon Jan 8 09:02:27 EST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
 BIOS-e820: 000000000bef0000 @ 0000000000100000 (usable)
 BIOS-e820: 000000000000d000 @ 000000000bff3000 (ACPI data)
 BIOS-e820: 0000000000003000 @ 000000000bff0000 (ACPI NVS)
On node 0 totalpages: 49136
zone(0): 4096 pages.
zone(1): 45040 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=k240 ro root=341
Initializing CPU#0
Detected 598.850 MHz processor.
Console: colour VGA+ 132x43
Calibrating delay loop... 1196.03 BogoMIPS
Memory: 191308k/196544k available (863k kernel code, 4848k reserved, 278k data, 200k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0081f9ff c0c1f9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After vendor init, caps: 0081f9ff c0c1f9ff 00000000 00000000
CPU: After generic, caps: 0081f9ff c0c1f9ff 00000000 00000000
CPU: Common caps: 0081f9ff c0c1f9ff 00000000 00000000
CPU: AMD-K7(tm) Processor stepping 02
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb470, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
isapnp: Scanning for Pnp cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
DMI 2.2 present.
39 structures occupying 1001 bytes.
DMI table at 0x000F0800.
BIOS Vendor: Award Software International, Inc.
BIOS Version: 6.0 PG
BIOS Release: 11/23/99
Board Vendor: MICRO-STAR INTERNATIONAL CO., LTD.
Board Name: MS-6167 (AMD751).
Board Version: 1.X.
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD7409: IDE controller on PCI bus 00 dev 39
AMD7409: chipset revision 3
AMD7409: not 100% native mode: will probe irqs later
AMD7409: disabling single-word DMA support (revision < C4)
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
hda: WDC AC28400R, ATA DISK drive
hdb: IBM-DHEA-38451, ATA DISK drive
hdc: TOSHIBA DVD-ROM SD-M1202, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 16514064 sectors (8455 MB) w/512KiB Cache, CHS=1027/255/63, UDMA(33)
hdb: 16514064 sectors (8455 MB) w/472KiB Cache, CHS=1027/255/63, UDMA(33)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1
 /dev/ide/host0/bus0/target1/lun0: p1 p2 < p5 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Real Time Clock Driver v1.10d
8139too Fast Ethernet driver 0.9.13 loaded
eth0: RealTek RTL8139 Fast Ethernet at 0xcc800000, 00:e0:7d:50:3f:3d, IRQ 10
eth0:  Identified 8139 chip type 'RTL-8139A'
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 149M
agpgart: Detected AMD Irongate chipset
agpgart: AGP aperture is 32M @ 0xd8000000
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: devfs_debug: 0x0
devfs: boot_options: 0x0
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 200k freed
Adding Swap: 136512k swap-space (priority -1)

--------------030201070807000308060909
Content-Type: text/plain;
 name="dmesg-2.4.1-ac6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-2.4.1-ac6"

Linux version 2.4.1-ac6 (root@tabriel) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 Thu Feb 8 11:12:58 EST 2001
BIOS-provided physical RAM map:
 BIOS-88: 000000000009f000 @ 0000000000000000 (usable)
 BIOS-88: 0000000003ff0000 @ 0000000000100000 (usable)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c009fc00 for 4096 bytes.
On node 0 totalpages: 16624
zone(0): 4096 pages.
zone(1): 12528 pages.
zone(2): 0 pages.
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
mapped APIC to ffffe000 (fee00000)
Kernel command line: BOOT_IMAGE=k241ac6 ro root=341
Initializing CPU#0
Detected 598.848 MHz processor.
Console: colour VGA+ 132x43
Calibrating delay loop... 1196.03 BogoMIPS
Memory: 63276k/66496k available (962k kernel code, 2832k reserved, 303k data, 220k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
CPU: Before vendor init, caps: 0081fbff c0c1fbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After vendor init, caps: 0081fbff c0c1fbff 00000000 00000000
CPU: After generic, caps: 0081fbff c0c1fbff 00000000 00000000
CPU: Common caps: 0081fbff c0c1fbff 00000000 00000000
CPU: AMD-K7(tm) Processor stepping 02
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Getting VERSION: 40010
Getting VERSION: 40010
Getting ID: b000000
Getting ID: 4000000
Getting LVT0: 700
Getting LVT1: 400
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
setting K7_PERFCTR0 to ffa4a160
setting K7 LVTPC to DM_NMI
setting K7_EVNTSEL0 to 00530076
testing NMI watchdog ... OK.
calibrating APIC timer ...
..... CPU clock speed is 598.8579 MHz.
..... host bus clock speed is 199.6193 MHz.
cpu: 0, clocks: 1996193, slice: 998096
CPU0<T0:1996192,T1:998096,D:0,S:998096,C:1996193>
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb470, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
isapnp: Scanning for Pnp cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 41829kB/13943kB, 128 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD7409: IDE controller on PCI bus 00 dev 39
AMD7409: chipset revision 3
AMD7409: not 100% native mode: will probe irqs later
AMD7409: disabling single-word DMA support (revision < C4)
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
hda: WDC AC28400R, ATA DISK drive
hdb: IBM-DHEA-38451, ATA DISK drive
hdc: TOSHIBA DVD-ROM SD-M1202, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 16514064 sectors (8455 MB) w/512KiB Cache, CHS=1027/255/63, UDMA(33)
hdb: 16514064 sectors (8455 MB) w/472KiB Cache, CHS=1027/255/63, UDMA(33)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1
 /dev/ide/host0/bus0/target1/lun0: p1 p2 < p5 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Real Time Clock Driver v1.10d
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 28M
agpgart: Detected AMD Irongate chipset
agpgart: AGP aperture is 32M @ 0xd8000000
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: devfs_debug: 0x0
devfs: boot_options: 0x0
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 220k freed
Adding Swap: 136512k swap-space (priority -1)

--------------030201070807000308060909--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
