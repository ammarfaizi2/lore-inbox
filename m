Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285756AbRLHCGV>; Fri, 7 Dec 2001 21:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285752AbRLHCGK>; Fri, 7 Dec 2001 21:06:10 -0500
Received: from zeus.kernel.org ([204.152.189.113]:49335 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S285754AbRLHCFp>;
	Fri, 7 Dec 2001 21:05:45 -0500
Message-ID: <3C1172C0.E389B607@eyal.emu.id.au>
Date: Sat, 08 Dec 2001 12:54:08 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: problem: 2.4.7 vs 2.4.9 PCI differences
Content-Type: multipart/mixed;
 boundary="------------DDB6AFA4FC1D652A3F11813B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------DDB6AFA4FC1D652A3F11813B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I tried the RH7.2 2.4.7-10 and 2.4.9-13 and the newer one fails
to see some of the PCI devices (SCSI controllers and Network card)
on a Compaq Proliant 6000 (PII Xeon, UP). I am attaching the boot
messages from both. A diff shows how only one of the three SCSI
channels is picked up and the net card is missing. lspci shows
it really is not there (sorry, I need to get the lspci output
from the office).

I will try a vanilla kernel, but it seems like a core PCI issue
to me. Is there a known problem here?


Another problem is the DMA failures on hda (as seen in the
attachments). This happens with both kernels. This may be more
of a problem with the machine itself, natively is claims to
not support IDE disks (but it does have an IDE CD which gets the
same DMA errors). Anyone has a hint for this one?

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.anu.edu.au/eyal/>
--------------DDB6AFA4FC1D652A3F11813B
Content-Type: text/plain; charset=us-ascii;
 name="boot247.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="boot247.log"

Linux version 2.4.7-10 (bhcompile@stripples.devel.redhat.com) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #1 Thu Sep 6 17:27:27 EDT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007ffc000 (usable)
 BIOS-e820: 0000000007ffc000 - 0000000008000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
Scanning bios EBDA for MXT signature
On node 0 totalpages: 32764
zone(0): 4096 pages.
zone(1): 28668 pages.
zone(2): 0 pages.
Kernel command line: initrd=initrd.img root=/dev/hda3 BOOT_IMAGE=vmlinuz auto
Initializing CPU#0
Detected 400.006 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 797.90 BogoMIPS
Memory: 125132k/131056k available (1269k kernel code, 4640k reserved, 90k data, 220k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0183f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183f9ff 00000000 00000000 00000000
CPU:     After generic, caps: 0183f9ff 00000000 00000000 00000000
CPU:             Common caps: 0183f9ff 00000000 00000000 00000000
CPU: Intel Pentium II (Deschutes) stepping 03
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf0070, last bus=14
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Searching for i450NX host bridges on 00:10.0
Unknown bridge resource 2: assuming transparent
PCI: Device 00:78 not found by BIOS
PCI: Device 00:80 not found by BIOS
PCI: Device 00:90 not found by BIOS
PCI: Device 00:98 not found by BIOS
PCI: Device 00:a0 not found by BIOS
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS not found.
mxt_scan_bios: enter
Starting kswapd v1.8
VFS: Diskquotas version dquot_6.5.0 initialized
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10d
block: queued sectors max/low 83058kB/27686kB, 256 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz PCI bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 79
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x3000-0x3007, BIOS settings: hda:pio, hdb:pio
PIIX4: IDE controller on PCI bus 00 dev 80
PIIX4: device not capable of full native PCI mode
PIIX4: device disabled (BIOS)
hda: IBM-DTLA-307060, ATA DISK drive
hdb: CD-ROM CDU611-Q, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63, UDMA(33)
ide-floppy driver 0.97
Partition check:
 hda:hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hda: drive not ready for command
 [PTBL] [7476/255/63] hda1 hda2 hda3 hda4
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hda: drive not ready for command
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
ide-floppy driver 0.97
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 443k freed
VFS: Mounted root (ext2 filesystem).
SCSI subsystem driver Revision: 1.00
sym53c8xx: at PCI bus 0, device 13, function 0
sym53c8xx: 53c875 detected 
sym53c8xx: at PCI bus 4, device 9, function 0
sym53c8xx: 53c875 detected 
sym53c8xx: at PCI bus 4, device 9, function 1
sym53c8xx: 53c875 detected 
sym53c875-0: rev 0x4 on pci bus 0 device 13 function 0 irq 5
sym53c875-0: ID 7, Fast-20, Parity Checking
sym53c875-1: rev 0x14 on pci bus 4 device 9 function 0 irq 5
sym53c875-1: ID 7, Fast-20, Parity Checking
sym53c875-2: rev 0x14 on pci bus 4 device 9 function 1 irq 5
sym53c875-2: ID 7, Fast-20, Parity Checking
scsi0 : sym53c8xx-1.7.3c-20010512
scsi1 : sym53c8xx-1.7.3c-20010512
scsi2 : sym53c8xx-1.7.3c-20010512
Journalled Block Device driver loaded
ThunderLAN driver v1.14a
TLAN: eth0 irq=10, io=5000, Compaq Netelligent Dual 10/100 TX PCI UTP, Rev. 16
TLAN: eth1 irq=11, io=5010, Compaq Netelligent Dual 10/100 TX PCI UTP, Rev. 16
TLAN: 2 devices installed, PCI: 2  EISA: 0
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hda: drive not ready for command
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: status error: status=0x5a { DriveReady SeekComplete DataRequest Index }
hda: drive not ready for command
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 220k freed
hda: DMA disabled
hda: DMA disabled
Adding Swap: 2097136k swap-space (priority -1)
EXT3 FS 2.4-0.9.8, 25 Aug 2001 on ide0(3,3), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.8, 25 Aug 2001 on ide0(3,4), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
parport0: PC-style at 0x3bc [PCSPP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
TLAN: eth0: Starting autonegotiation.
TLAN: eth0: Autonegotiation complete.
TLAN: eth0: Link active with AutoNegotiation enabled, at 100Mbps Full-Duplex
TLAN: Partner capability: 10BaseT-HD 10BaseT-FD 100baseTx-HD 100baseTx-FD<NULL>
mtrr: no more MTRRs available
mtrr: no more MTRRs available
mtrr: no more MTRRs available

--------------DDB6AFA4FC1D652A3F11813B
Content-Type: text/plain; charset=us-ascii;
 name="boot249.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="boot249.log"

Linux version 2.4.9-13 (bhcompile@stripples.devel.redhat.com) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #1 Tue Oct 30 20:05:14 EST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007ffc000 (usable)
 BIOS-e820: 0000000007ffc000 - 0000000008000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
On node 0 totalpages: 32764
zone(0): 4096 pages.
zone(1): 28668 pages.
zone(2): 0 pages.
Kernel command line: initrd=initrd.img root=/dev/hda3 BOOT_IMAGE=vmlinuz auto
Initializing CPU#0
Detected 400.010 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 797.90 BogoMIPS
Memory: 124768k/131056k available (1738k kernel code, 5004k reserved, 90k data, 216k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0183f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183f9ff 00000000 00000000 00000000
CPU:     After generic, caps: 0183f9ff 00000000 00000000 00000000
CPU:             Common caps: 0183f9ff 00000000 00000000 00000000
CPU: Intel Pentium II (Deschutes) stepping 03
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
Checking for popad bug... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf0070, last bus=14
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Searching for i450NX host bridges on 00:10.0
PCI: BIOS reporting unknown device 04:48
PCI: Device 00:78 not found by BIOS
PCI: Device 00:80 not found by BIOS
PCI: Device 00:90 not found by BIOS
PCI: Device 00:98 not found by BIOS
PCI: Device 00:a0 not found by BIOS
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS not found.
Starting kswapd v1.8
VFS: Diskquotas version dquot_6.5.0 initialized
pty: 512 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
block: queued sectors max/low 82821kB/27607kB, 256 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz PCI bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 79
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x3000-0x3007, BIOS settings: hda:pio, hdb:pio
PIIX4: IDE controller on PCI bus 00 dev 80
PIIX4: device not capable of full native PCI mode
PIIX4: device disabled (BIOS)
hda: IBM-DTLA-307060, ATA DISK drive
hdb: CD-ROM CDU611-Q, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
blk: queue c033c4c0, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c033c4c0, I/O limit 4095Mb (mask 0xffffffff)
hda: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63, UDMA(33)
ide-floppy driver 0.97.sv
Partition check:
 hda:hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
blk: queue c033c4c0, I/O limit 4095Mb (mask 0xffffffff)
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hda: drive not ready for command
blk: queue c033c4c0, I/O limit 4095Mb (mask 0xffffffff)
 [PTBL] [7476/255/63] hda1 hda2 hda3 hda4
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
blk: queue c033c4c0, I/O limit 4095Mb (mask 0xffffffff)
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hda: drive not ready for command
blk: queue c033c4c0, I/O limit 4095Mb (mask 0xffffffff)
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
ide-floppy driver 0.97.sv
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 434k freed
VFS: Mounted root (ext2 filesystem).
SCSI subsystem driver Revision: 1.00
sym53c8xx: at PCI bus 0, device 13, function 0
sym53c8xx: 53c875 detected 
sym53c875-0: rev 0x4 on pci bus 0 device 13 function 0 irq 5
sym53c875-0: ID 7, Fast-20, Parity Checking
scsi0 : sym53c8xx-1.7.3c-20010512
blk: queue c148c818, I/O limit 4095Mb (mask 0xffffffff)
Journalled Block Device driver loaded
ThunderLAN driver v1.14a
TLAN: 0 devices installed, PCI: 0  EISA: 0
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
blk: queue c033c4c0, I/O limit 4095Mb (mask 0xffffffff)
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hda: drive not ready for command
blk: queue c033c4c0, I/O limit 4095Mb (mask 0xffffffff)
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
blk: queue c033c4c0, I/O limit 4095Mb (mask 0xffffffff)
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hda: drive not ready for command
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: ide0(3,3): orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 3359020
EXT3-fs: ide0(3,3): 1 orphan inode deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 216k freed
hda: DMA disabled
hda: DMA disabled
Adding Swap: 2097136k swap-space (priority -1)
EXT3 FS 2.4-0.9.11, 3 Oct 2001 on ide0(3,3), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.11, 3 Oct 2001 on ide0(3,4), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
parport0: PC-style at 0x3bc [PCSPP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
ThunderLAN driver v1.14a
TLAN: 0 devices installed, PCI: 0  EISA: 0
ThunderLAN driver v1.14a
TLAN: 0 devices installed, PCI: 0  EISA: 0
mtrr: no more MTRRs available
mtrr: no more MTRRs available
mtrr: no more MTRRs available

--------------DDB6AFA4FC1D652A3F11813B--

