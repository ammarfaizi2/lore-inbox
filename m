Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263321AbTANNa5>; Tue, 14 Jan 2003 08:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263326AbTANNa5>; Tue, 14 Jan 2003 08:30:57 -0500
Received: from smtp.efrei.fr ([194.2.204.37]:16392 "EHLO smtp.efrei.fr")
	by vger.kernel.org with ESMTP id <S263321AbTANNax>;
	Tue, 14 Jan 2003 08:30:53 -0500
Date: Tue, 14 Jan 2003 14:39:44 +0100
From: Guillaume Allard <allard@efrei.fr>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19 - 2.4.20 : Boot parameter MEM= doesn't work anymore
Message-ID: <20030114133944.GB8978@efrei.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
It seems that the boot parameter MEM= doesn't work anymore with the
kernel 2.4.19 and 2.4.20.
This parameter allows to force the amount of RAM for old computer that
linux kernel doesn't found.

I am using a debian woody with lilo 22.2.
The computer is an old compaq with a pentium 150MHz and 64Mb of memory.
The kernel only see 16Mb of memory.

Here you can find the kernel boot messages, we can see that the kernel
receve the parameters (Kernel command line: auto BOOT_IMAGE=Linux ro
root=802 mem=64M) but that it doesn't work (Memory: 13608k/16384k
available (1327k kernel code, 2388k reserved, 410k data, 256k init, 0k
highmem).

-----
Dec  2 01:14:26 orion syslogd 1.4.1#10: restart.
Dec  2 01:14:26 orion kernel: klogd 1.4.1#10, log source = /proc/kmsg
started.
Dec  2 01:14:26 orion kernel: Inspecting /boot/System.map-2.4.20
Dec  2 01:14:29 orion kernel: Loaded 17467 symbols from
/boot/System.map-2.4.20.
Dec  2 01:14:29 orion kernel: Symbols match kernel version 2.4.20.
Dec  2 01:14:29 orion kernel: Loaded 23 symbols from 4 modules.
Dec  2 01:14:29 orion kernel: Linux version 2.4.20 (root@orion) (gcc
version 2.95.4 20011002 (Debian prerelease)) #1 Sat Nov 30 16:27:21 CET
200
2
Dec  2 01:14:29 orion kernel: BIOS-provided physical RAM map:
Dec  2 01:14:29 orion kernel:  BIOS-88: 0000000000000000 -
000000000009f000 (usable)
Dec  2 01:14:29 orion kernel:  BIOS-88: 0000000000100000 -
0000000001000000 (usable)
Dec  2 01:14:29 orion kernel: user-defined physical RAM map:
Dec  2 01:14:29 orion kernel:  user: 0000000000000000 - 000000000009f000
(usable)
Dec  2 01:14:29 orion kernel:  user: 0000000000100000 - 0000000001000000
(usable)
Dec  2 01:14:29 orion kernel: 16MB LOWMEM available.
Dec  2 01:14:29 orion kernel: On node 0 totalpages: 4096
Dec  2 01:14:29 orion kernel: zone(0): 4096 pages.
Dec  2 01:14:29 orion kernel: zone(1): 0 pages.
Dec  2 01:14:29 orion kernel: zone(2): 0 pages.
Dec  2 01:14:29 orion kernel: Kernel command line: auto BOOT_IMAGE=Linux
ro root=802 mem=64M
Dec  2 01:14:29 orion kernel: Initializing CPU#0
Dec  2 01:14:29 orion kernel: Detected 150.340 MHz processor.
Dec  2 01:14:29 orion kernel: Console: colour VGA+ 80x25
Dec  2 01:14:29 orion kernel: Calibrating delay loop... 299.82 BogoMIPS
Dec  2 01:14:29 orion kernel: Memory: 13608k/16384k available (1327k
kernel code, 2388k reserved, 410k data, 256k init, 0k highmem)
Dec  2 01:14:29 orion kernel: Dentry cache hash table entries: 2048
(order: 2, 16384 bytes)
Dec  2 01:14:29 orion kernel: Inode cache hash table entries: 1024
(order: 1, 8192 bytes)
Dec  2 01:14:29 orion kernel: Mount-cache hash table entries: 512
(order: 0, 4096 bytes)
Dec  2 01:14:29 orion kernel: Buffer-cache hash table entries: 1024
(order: 0, 4096 bytes)
Dec  2 01:14:29 orion kernel: Page-cache hash table entries: 4096
(order: 2, 16384 bytes)
Dec  2 01:14:29 orion kernel: Intel Pentium with F0 0F bug - workaround
enabled.
Dec  2 01:14:29 orion kernel: CPU: Intel Pentium 75 - 200 stepping 0c
Dec  2 01:14:29 orion kernel: Checking 'hlt' instruction... OK.
Dec  2 01:14:29 orion kernel: POSIX conformance testing by UNIFIX
Dec  2 01:14:29 orion kernel: mtrr: v1.40 (20010327) Richard Gooch
(rgooch@atnf.csiro.au)
Dec  2 01:14:29 orion kernel: mtrr: detected mtrr type: none
Dec  2 01:14:29 orion kernel: PCI: PCI BIOS revision 2.10 entry at
0xf005e, last bus=0
Dec  2 01:14:29 orion kernel: PCI: Using configuration type 1
Dec  2 01:14:29 orion kernel: PCI: Probing PCI hardware
Dec  2 01:14:29 orion kernel: PCI: Device 00:78 not found by BIOS
Dec  2 01:14:29 orion kernel: isapnp: Scanning for PnP cards...
Dec  2 01:14:29 orion kernel: isapnp: No Plug & Play device found
Dec  2 01:14:29 orion kernel: Linux NET4.0 for Linux 2.4
Dec  2 01:14:29 orion kernel: Based upon Swansea University Computer
Society NET3.039
Dec  2 01:14:29 orion kernel: Initializing RT netlink socket
Dec  2 01:14:29 orion kernel: IA-32 Microcode Update Driver: v1.11
<tigran@veritas.com>
Dec  2 01:14:29 orion kernel: Starting kswapd
Dec  2 01:14:29 orion kernel: VFS: Diskquotas version dquot_6.4.0
initialized
Dec  2 01:14:29 orion kernel: Journalled Block Device driver loaded
Dec  2 01:14:29 orion kernel: Installing knfsd (copyright (C) 1996
okir@monad.swb.de).
Dec  2 01:14:29 orion kernel: Detected PS/2 Mouse Port.
Dec  2 01:14:29 orion kernel: pty: 256 Unix98 ptys configured
Dec  2 01:14:29 orion kernel: Serial driver version 5.05c (2001-07-08)
with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
Dec  2 01:14:29 orion kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Dec  2 01:14:29 orion kernel: Floppy drive(s): fd0 is 1.44M
Dec  2 01:14:29 orion kernel: FDC 0 is a National Semiconductor PC87306
Dec  2 01:14:29 orion kernel: RAMDISK driver initialized: 16 RAM disks
of 4096K size 1024 blocksize
Dec  2 01:14:29 orion kernel: loop: loaded (max 8 devices)
Dec  2 01:14:29 orion kernel: ThunderLAN driver v1.15
Dec  2 01:14:29 orion kernel: TLAN: 0 devices installed, PCI: 0  EISA: 0
Dec  2 01:14:29 orion kernel: 8139too Fast Ethernet driver 0.9.26
Dec  2 01:14:29 orion kernel: eth0: RealTek RTL8139 Fast Ethernet at
0xc1800000, 00:50:fc:51:18:47, IRQ 5
Dec  2 01:14:29 orion kernel: SCSI subsystem driver Revision: 1.00
Dec  2 01:14:29 orion kernel: ncr53c8xx: at PCI bus 0, device 12,
function 0
Dec  2 01:14:29 orion kernel: ncr53c8xx: 53c810 detected
Dec  2 01:14:29 orion kernel: ncr53c810-0: rev 0x2 on pci bus 0 device
12 function 0 irq 10
Dec  2 01:14:29 orion kernel: ncr53c810-0: ID 7, Fast-10, Parity
Checking
Dec  2 01:14:29 orion kernel: scsi0 : ncr53c8xx-3.4.3b-20010512
Dec  2 01:14:29 orion kernel:   Vendor: COMPAQPC  Model: DSP3053LS
Rev: 442C
Dec  2 01:14:29 orion kernel:   Type:   Direct-Access
ANSI SCSI revision: 02
Dec  2 01:14:29 orion kernel: ncr53c810-0-<1,*>: FAST-10 SCSI 10.0 MB/s
(100 ns, offset 8)
Dec  2 01:14:29 orion kernel:   Vendor: COMPAQ    Model: ST15150N
Rev: 5216
Dec  2 01:14:29 orion kernel:   Type:   Direct-Access
ANSI SCSI revision: 02
Dec  2 01:14:29 orion kernel: ncr53c810-0-<2,*>: FAST-10 SCSI 10.0 MB/s
(100 ns, offset 8)
Dec  2 01:14:29 orion kernel:   Vendor: COMPAQ    Model: ST15150N
Rev: 5216
Dec  2 01:14:29 orion kernel:   Type:   Direct-Access
ANSI SCSI revision: 02
Dec  2 01:14:29 orion kernel:   Vendor: QUANTUM   Model: EMPIRE_2100S
Rev: 1200
Dec  2 01:14:29 orion kernel:   Type:   Direct-Access
ANSI SCSI revision: 02
Dec  2 01:14:29 orion kernel:   Vendor: IBM       Model: DORS-32160
Rev: WA6A
Dec  2 01:14:29 orion kernel:   Type:   Direct-Access
ANSI SCSI revision: 02
Dec  2 01:14:29 orion kernel:   Vendor: COMPAQ    Model: CRD-254V
Rev: 1.06
Dec  2 01:14:29 orion kernel:   Type:   CD-ROM
ANSI SCSI revision: 02
Dec  2 01:14:29 orion kernel:   Vendor: ARCHIVE   Model: Python
27871-XXX  Rev: 1214
Dec  2 01:14:29 orion kernel:   Type:   Sequential-Access
ANSI SCSI revision: 02
Dec  2 01:14:29 orion kernel: st: Version 20020805, bufsize 32768, wrt
30720, max init. bufs 4, s/g segs 16
Dec  2 01:14:29 orion kernel: Attached scsi tape st0 at scsi0, channel
0, id 6, lun 0
Dec  2 01:14:29 orion kernel: Attached scsi disk sda at scsi0, channel
0, id 0, lun 0
Dec  2 01:14:29 orion kernel: Attached scsi disk sdb at scsi0, channel
0, id 1, lun 0
Dec  2 01:14:29 orion kernel: Attached scsi disk sdc at scsi0, channel
0, id 2, lun 0
Dec  2 01:14:29 orion kernel: Attached scsi disk sdd at scsi0, channel
0, id 3, lun 0
Dec  2 01:14:29 orion kernel: Attached scsi disk sde at scsi0, channel
0, id 4, lun 0
Dec  2 01:14:29 orion kernel: ncr53c810-0-<0,*>: FAST-10 SCSI 10.0 MB/s
(100 ns, offset 8)
Dec  2 01:14:29 orion kernel: SCSI device sda: 1046532 512-byte hdwr
sectors (536 MB)
Dec  2 01:14:29 orion kernel: Partition check:
Dec  2 01:14:29 orion kernel:  sda: sda1 sda2
Dec  2 01:14:29 orion kernel: SCSI device sdb: 8386000 512-byte hdwr
sectors (4294 MB)
Dec  2 01:14:29 orion kernel:  sdb: sdb1
Dec  2 01:14:29 orion kernel: SCSI device sdc: 8386000 512-byte hdwr
sectors (4294 MB)
Dec  2 01:14:29 orion kernel:  sdc: sdc1
Dec  2 01:14:29 orion kernel: ncr53c810-0-<3,*>: FAST-10 SCSI 10.0 MB/s
(100 ns, offset 8)
Dec  2 01:14:29 orion kernel: SCSI device sdd: 4108600 512-byte hdwr
sectors (2104 MB)
Dec  2 01:14:29 orion kernel:  sdd: sdd1 sdd2
Dec  2 01:14:29 orion kernel: ncr53c810-0-<4,*>: FAST-10 SCSI 10.0 MB/s
(100 ns, offset 8)
Dec  2 01:14:29 orion kernel: SCSI device sde: 4125001 512-byte hdwr
sectors (2112 MB)
Dec  2 01:14:29 orion kernel:  sde: sde1
Dec  2 01:14:29 orion kernel: Attached scsi CD-ROM sr0 at scsi0, channel
0, id 5, lun 0
Dec  2 01:14:29 orion kernel: ncr53c810-0-<5,*>: target did not report
SYNC.
Dec  2 01:14:29 orion kernel: sr0: scsi-1 drive
Dec  2 01:14:29 orion kernel: Uniform CD-ROM driver Revision: 3.12
Dec  2 01:14:29 orion kernel: md: linear personality registered as nr 1
Dec  2 01:14:29 orion kernel: md: md driver 0.90.0 MAX_MD_DEVS=256,
MD_SB_DISKS=27
Dec  2 01:14:29 orion kernel: md: Autodetecting RAID arrays.
Dec  2 01:14:29 orion kernel: md: autorun ...
Dec  2 01:14:29 orion kernel: md: ... autorun DONE.
Dec  2 01:14:29 orion kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Dec  2 01:14:29 orion kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Dec  2 01:14:29 orion kernel: IP: routing cache hash table of 512
buckets, 4Kbytes
Dec  2 01:14:29 orion kernel: TCP: Hash tables configured (established
1024 bind 1024)
Dec  2 01:14:29 orion kernel: NET4: Unix domain sockets 1.0/SMP for
Linux NET4.0.
Dec  2 01:14:29 orion kernel: VFS: Mounted root (ext2 filesystem)
readonly.
Dec  2 01:14:29 orion kernel: Freeing unused kernel memory: 256k freed
Dec  2 01:14:29 orion kernel: Adding Swap: 125932k swap-space (priority
-1)
Dec  2 01:14:29 orion kernel: md: raid0 personality registered as nr 2
Dec  2 01:14:29 orion kernel: md: raid1 personality registered as nr 3
Dec  2 01:14:29 orion kernel: raid5: measuring checksumming speed
Dec  2 01:14:29 orion kernel:    8regs     :   103.200 MB/sec
Dec  2 01:14:29 orion kernel:    32regs    :   132.400 MB/sec
Dec  2 01:14:29 orion kernel: raid5: using function: 32regs (132.400
MB/sec)
Dec  2 01:14:29 orion kernel: md: raid5 personality registered as nr 4
Dec  2 01:14:29 orion kernel:  [events: 00000014]
Dec  2 01:14:29 orion last message repeated 2 times
Dec  2 01:14:29 orion kernel: md: autorun ...
Dec  2 01:14:29 orion kernel: md: considering sdc1 ...
Dec  2 01:14:29 orion kernel: md:  adding sdc1 ...
Dec  2 01:14:29 orion kernel: md:  adding sdb1 ...
Dec  2 01:14:29 orion kernel: md:  adding sde1 ...
Dec  2 01:14:29 orion kernel: md: created md0
Dec  2 01:14:29 orion kernel: md: bind<sde1,1>
Dec  2 01:14:29 orion kernel: md: bind<sdb1,2>
Dec  2 01:14:29 orion kernel: md: bind<sdc1,3>
Dec  2 01:14:29 orion kernel: md: running: <sdc1><sdb1><sde1>
Dec  2 01:14:29 orion kernel: md: sdc1's event counter: 00000014
Dec  2 01:14:29 orion kernel: md: sdb1's event counter: 00000014
Dec  2 01:14:29 orion kernel: md: sde1's event counter: 00000014
Dec  2 01:14:29 orion kernel: md0: max total readahead window set to
124k
Dec  2 01:14:29 orion kernel: md0: 1 data-disks, max readahead per
data-disk: 124k
Dec  2 01:14:29 orion kernel: md: updating md0 RAID superblock on device
Dec  2 01:14:29 orion kernel: md: sdc1 [events: 00000015]<6>(write)
sdc1's sb offset: 4188864
Dec  2 01:14:29 orion kernel: md: sdb1 [events: 00000015]<6>(write)
sdb1's sb offset: 4188864
Dec  2 01:14:29 orion kernel: md: sde1 [events: 00000015]<6>(write)
sde1's sb offset: 2061248
Dec  2 01:14:29 orion kernel: md: ... autorun DONE.
-----

-- 
     Guillaume Allard
     EFREI - promo 2002
     allard@efrei.fr
