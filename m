Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267369AbUGNMVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267369AbUGNMVG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 08:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267368AbUGNMUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 08:20:17 -0400
Received: from web90005.mail.scd.yahoo.com ([66.218.94.63]:11701 "HELO
	web90005.mail.scd.yahoo.com") by vger.kernel.org with SMTP
	id S267369AbUGNMRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 08:17:32 -0400
Message-ID: <20040714121731.52870.qmail@web90005.mail.scd.yahoo.com>
Date: Wed, 14 Jul 2004 05:17:31 -0700 (PDT)
From: Hlaing Oo <hlaing_1999@yahoo.com>
Subject: missing cdrom in new kernel 2.4.26
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dear all 
I am newbie of kernel rebuilder.
I could rebuild 2.4.26 from 2.4.20-8.
Almost everything okay, but cdrom.
When I mount cdrom I got this message.

# mount -t iso9660 /dev/hdc /mnt/cdrom
mount: /dev/hdc is not a valid block device

New and old dmesg are below.
At the end of the new dmesg is differ from old dmesg.
Help me to fix.
Regards

#cat /etc/fstab
LABEL=/                 /                       ext3  
 defaults        1 1
LABEL=/boot             /boot                   ext3  
 defaults        1 2
none                    /dev/pts                devpts
 gid=5,mode=620  0 0
none                    /proc                   proc  
 defaults        0 0
none                    /dev/shm                tmpfs 
 defaults        0 0
/dev/hda3               swap                    swap  
 defaults        0 0
/dev/cdrom              /mnt/cdrom             
udf,iso9660 noauto,owner,kudzu,ro 0 0

>>>>> my new kernel dmesg is below

#cat /var/log/dmesg
Linux version 2.4.26 (root@localhost.localdomain) (gcc
version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #3 SMP
Wed Jul 14 06:55:41 EDT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800
(usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000
(reserved)
 BIOS-e820: 00000000000eac00 - 0000000000100000
(reserved)
 BIOS-e820: 0000000000100000 - 0000000003ff0000
(usable)
 BIOS-e820: 0000000003ff0000 - 0000000003fff800 (ACPI
data)
 BIOS-e820: 0000000003fff800 - 0000000004000000 (ACPI
NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000
(reserved)
63MB LOWMEM available.
On node 0 totalpages: 16368
zone(0): 4096 pages.
zone(1): 12272 pages.
zone(2): 0 pages.
ACPI disabled because your bios is from 00 and too old
You can enable it with acpi=force
Sony Vaio laptop detected.
BIOS strings suggest APM reports battery life in
minutes and wrong byte order.
Kernel command line: ro root=/dev/hda2 hdc=ide-scsi
ide_setup: hdc=ide-scsi
Local APIC disabled by BIOS -- reenabling.
Could not enable APIC!
Initializing CPU#0
Detected 496.319 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 989.59 BogoMIPS
Memory: 61420k/65472k available (1782k kernel code,
3664k reserved, 604k data, 124k init, 0k highmem)
Dentry cache hash table entries: 8192 (order: 4, 65536
bytes)
Inode cache hash table entries: 4096 (order: 3, 32768
bytes)
Mount cache hash table entries: 512 (order: 0, 4096
bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096
bytes)
Page-cache hash table entries: 16384 (order: 4, 65536
bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff 00000000
00000000 00000000
CPU:             Common caps: 0383f9ff 00000000
00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff 00000000
00000000 00000000
CPU:             Common caps: 0383f9ff 00000000
00000000 00000000
CPU0: Intel Celeron (Coppermine) stepping 01
per-CPU timeslice cutoff: 365.42 usecs.
SMP motherboard not detected.
Local APIC not detected. Using dummy APIC emulation.
Waiting on wait_init_idle (map = 0x0)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xfd99e, last
bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router PIIX/ICH [8086/7110] at 00:07.0
PCI: Found IRQ 9 for device 00:0c.0
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society
NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996
okir@monad.swb.de).
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with
MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels,
max=256).
loop: loaded (max 8 devices)
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory:
27M
agpgart: Detected Intel 440BX chipset
agpgart: AGP aperture is 16M @ 0x40000000
[drm] Initialized tdfx 1.0.0 20010216 on minor 0
[drm] AGP 0.99 Aperture @ 0x40000000 16MB
[drm] Initialized radeon 1.7.0 20020828 on minor 1
[drm] AGP 0.99 Aperture @ 0x40000000 16MB
[drm] Initialized i810 1.2.1 20020211 on minor 2
Uniform Multi-Platform E-IDE driver Revision:
7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes;
override with idebus=xx
hda: IBM-DARA-212000, ATA DISK drive
hdc: UJDA310, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 23579136 sectors (12073 MB) w/418KiB Cache,
CHS=1467/255/63
Partition check:
 hda: hda1 hda2 hda3
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k
scsi_hostadapter, errno = 2
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 9 for device 00:0c.0
PCI: Assigned IRQ 9 for device 00:0c.1
PCI: Sharing IRQ 9 with 00:0a.0
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind
4096)
IPv4 over IPv4 tunneling driver
Yenta ISA IRQ mask 0x0c98, PCI irq 9
Socket status: 30000410
Yenta ISA IRQ mask 0x0c98, PCI irq 9
Socket status: 30000006
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 124k freed
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2),
internal journal
Adding Swap: 192772k swap-space (priority -1)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1),
internal journal
EXT3-fs: mounted filesystem with ordered data mode.

>>>> my old kernel dmesg is below

#cat dmesg20-8
Linux version 2.4.20-8
(bhcompile@porky.devel.redhat.com) (gcc version 3.2.2
20030222 (Red Hat Linux 3.2.2-5)) #1 Thu Mar 13
17:54:28 EST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800
(usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000
(reserved)
 BIOS-e820: 00000000000eac00 - 0000000000100000
(reserved)
 BIOS-e820: 0000000000100000 - 0000000003ff0000
(usable)
 BIOS-e820: 0000000003ff0000 - 0000000003fff800 (ACPI
data)
 BIOS-e820: 0000000003fff800 - 0000000004000000 (ACPI
NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000
(reserved)
0MB HIGHMEM available.
63MB LOWMEM available.
On node 0 totalpages: 16368
zone(0): 4096 pages.
zone(1): 12272 pages.
zone(2): 0 pages.
Sony Vaio laptop detected.
BIOS strings suggest APM reports battery life in
minutes and wrong byte order.
Kernel command line: ro root=LABEL=/ hdc=ide-scsi
ide_setup: hdc=ide-scsi
Initializing CPU#0
Detected 496.314 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 989.59 BogoMIPS
Memory: 60568k/65472k available (1347k kernel code,
4008k reserved, 999k data, 132k init, 0k highmem)
Dentry cache hash table entries: 8192 (order: 4, 65536
bytes)
Inode cache hash table entries: 4096 (order: 3, 32768
bytes)
Mount cache hash table entries: 512 (order: 0, 4096
bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096
bytes)
Page-cache hash table entries: 16384 (order: 4, 65536
bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff 00000000
00000000 00000000
CPU:             Common caps: 0383f9ff 00000000
00000000 00000000
CPU: Intel Celeron (Coppermine) stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch
(rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfd99e, last
bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
PCI: Found IRQ 9 for device 00:0c.0
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society
NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with
MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP
enabled
ttyS0 at 0x03f8 (irq = 4) is a 16550A
Real Time Clock Driver v1.10e
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
NET4: Frame Diverter 0.46
RAMDISK driver initialized: 16 RAM disks of 4096K size
1024 blocksize
Uniform Multi-Platform E-IDE driver Revision:
7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes;
override with idebus=xx
PIIX4: IDE controller at PCI slot 00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfcf0-0xfcf7, BIOS settings:
hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfcf8-0xfcff, BIOS settings:
hdc:DMA, hdd:pio
hda: IBM-DARA-212000, ATA DISK drive
blk: queue c03c9f40, I/O limit 4095Mb (mask
0xffffffff)
hdc: UJDA310, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 23579136 sectors (12073 MB) w/418KiB Cache,
CHS=1467/255/63, UDMA(33)
ide-floppy driver 0.99.newide
Partition check:
 hda: hda1 hda2 hda3
ide-floppy driver 0.99.newide
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind
8192)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 145k freed
VFS: Mounted root (ext2 filesystem).
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 132k freed
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2),
internal journal
Adding Swap: 192772k swap-space (priority -1)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1),
internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI
devices
  Vendor: MATSHITA  Model: UJDA310           Rev: 1.34
  Type:   CD-ROM                             ANSI SCSI
revision: 02




		
__________________________________
Do you Yahoo!?
Yahoo! Mail is new and improved - Check it out!
http://promotions.yahoo.com/new_mail
