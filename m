Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271890AbTG2QRG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 12:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271892AbTG2QRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 12:17:05 -0400
Received: from kilo.clearoption.com ([205.200.121.30]:30380 "EHLO
	kilo.clearoption.com") by vger.kernel.org with ESMTP
	id S271890AbTG2QQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 12:16:28 -0400
Subject: Very slow SATA with Silicon Image (SiI3112) Kernel 2.4.21
From: John Lange <john.lange@darkcore.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1059495379.6227.39.camel@ctech-dyn118.clearoption.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2-3mdk 
Date: 29 Jul 2003 11:16:21 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have just built a server using an ASUS A7N8X deluxe Motherboard with
and AMD 2500. The motherboard includes the Silicon Image Serial ATA
system. Attached are two Maxtor 120Gig serial ATA drives.

I have compiled a new kernel (2.4.21) which includes support for the
Sil3112.

The machine boots but have very slow drive access. Can someone please
tell me if there are some settings to improve drive throughput?

Here are the details:

hdparm -Tt /dev/hdg
/dev/hdg:
 Timing buffer-cache reads:   1148 MB in  2.00 seconds = 574.00 MB/sec
 Timing buffered disk reads:    4 MB in  3.02 seconds =   1.32 MB/sec

For comparison here is the results from an ancient AMD K6-200Mhz box:

/dev/hdb:
 Timing buffer-cache reads:   128 MB in  2.73 seconds = 46.89 MB/sec
 Timing buffered disk reads:  64 MB in  7.58 seconds =  8.44 MB/sec

>From dmesg:

---- start dmesg -----
Linux version 2.4.21 (root@mercury) (gcc version 3.2.2) #1 Mon Jul 28
22:47:10 CDT 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 262128
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32752 pages.
Kernel command line: auto BOOT_IMAGE=Linux-ATARAID ro root=2101
Found and enabled local APIC!
Initializing CPU#0
Detected 1094.143 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2182.34 BogoMIPS
Memory: 1033156k/1048512k available (1661k kernel code, 14968k reserved,
367k data, 300k init, 131008k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
CPU: AMD Athlon(tm)  stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1094.1582 MHz.
..... host bus clock speed is 198.9377 MHz.
cpu: 0, clocks: 1989377, slice: 994688
CPU0<T0:1989376,T1:994688,D:0,S:994688,C:1989377>
PCI: PCI BIOS revision 2.10 entry at 0xfb490, last bus=3
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router default [10de/01e0] at 00:00.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
pty: 512 Unix98 ptys configured
Real Time Clock Driver v1.10e
ipmi: message handler initialized
ipmi: device interface at char major 254
ipmi_kcs: No KCS @ port 0x0ca2
ipmi_kcs: Unable to find any KCS interfaces
IPMI watchdog by Corey Minyard (minyard@mvista.com)
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 7777K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
NFORCE2: IDE controller at PCI slot 00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
AMD_IDE: PCI device 10de:0065 (nVidia Corporation) (rev a2) UDMA100
controller on pci00:09.0
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
SiI3112 Serial ATA: IDE controller at PCI slot 01:0b.0
SiI3112 Serial ATA: chipset revision 2
SiI3112 Serial ATA: not 100% native mode: will probe irqs later
    ide2: MMIO-DMA , BIOS settings: hde:pio, hdf:pio
    ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio
hdd: CD-ROM TW 120D, ATAPI CD/DVD-ROM drive
hdd: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error
}
hdd: set_drive_speed_status: error=0x04
ide1: Drive 1 didn't accept speed setting. Oh, well.
hde: Maxtor 6Y120M0, ATA DISK drive
hdg: Maxtor 6Y120M0, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xf880d080-0xf880d087,0xf880d08a on irq 11
ide3 at 0xf880d0c0-0xf880d0c7,0xf880d0ca on irq 11
hde: attached ide-disk driver.
hde: host protected area => 1
hde: 240121728 sectors (122942 MB) w/7936KiB Cache, CHS=238216/16/63
hdg: attached ide-disk driver.
hdg: host protected area => 1
hdg: 240121728 sectors (122942 MB) w/7936KiB Cache, CHS=238216/16/63
hdd: attached ide-cdrom driver.
hdd: ATAPI 12X CD-ROM drive, 240kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hde: hde1 hde2
 hdg: hdg1 hdg2
Promise Fasttrak(tm) Softwareraid driver 0.03beta: No raid array found
Highpoint HPT370 Softwareraid driver for linux version 0.01-ww1
No raid array found
No raid array found
No raid array found
Guestimating sector 240120703 for superblock
Guestimating sector 240120703 for superblock
driver for Silicon Image(tm) Medley(tm) hardware version 0.0.1: No raid
array found
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  1671.600 MB/sec
   32regs    :  1184.400 MB/sec
   pIII_sse  :  3104.800 MB/sec
   pII_mmx   :  2564.000 MB/sec
   p5_mmx    :  3289.200 MB/sec
raid5: using function: pIII_sse (3104.800 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
LVM version 1.0.5+(22/07/2002)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
ip_conntrack version 2.1 (8191 buckets, 65528 max) - 152 bytes per
conntrack
ip_tables: (C) 2000-2002 Netfilter core team
arp_tables: (C) 2002 David S. Miller
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
ip6_tables: (C) 2000-2002 Netfilter core team
registering ipv6 mark target
reiserfs: checking transaction log (device 21:01) ...
reiserfs: replayed 1 transactions in 0 seconds
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 300k freed
spurious 8259A interrupt: IRQ7.
Adding Swap: 999896k swap-space (priority -1)
reiserfs: checking transaction log (device 21:02) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
02:01.0: 3Com PCI 3c920 Tornado at 0xc000. Vers LK1.1.16
 00:26:54:0e:d6:2c, IRQ 5
  product code ffff rev 00.0 date 15-31-127
  Internal config register is 1600000, transceivers 0x40.
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/MII interface.
  MII transceiver found at address 2, status 786d.
  Enabling bus-master transmits and whole-frame receives.
02:01.0: scatter/gather enabled. h/w checksums enabled
eth0: no IPv6 routers present

---- end dmesg -----

from: cat /proc/ide/siimage

Controller: 0
SiI3112 Chipset.
MMIO Base 0xf880d000
MMIO-DMA Base 0xf880d000
MMIO-DMA Base 0xf880d008
--------------- Primary Channel ---------------- Secondary Channel
-------------
--------------- drive0 --------- drive1 -------- drive0 ----------
drive1 ------
PIO Mode:       ?                ?               ?                 ?


Here is: hdparm -I /dev/hdg

/dev/hdg:

ATA device, with non-removable media
        Model Number:       Maxtor 6Y120M0
        Serial Number:      Y31XCBEE
        Firmware Revision:  YAR51BW0
Standards:
        Supported: 7 6 5 4
        Likely used: 7
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:  240121728
        device size with M = 1024*1024:      117246 MBytes
        device size with M = 1000*1000:      122942 MBytes (122 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        Queue depth: 1
        Standby timer values: spec'd by Standard, no device specific
minimum
        R/W multiple sector transfer: Max = 16  Current = 16
        Advanced power management level: unknown setting (0x0000)
        Recommended acoustic management value: 192, current value: 254
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
udma6
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    NOP cmd
           *    READ BUFFER cmd
           *    WRITE BUFFER cmd
           *    Host Protected Area feature set
           *    Look-ahead
           *    Write cache
           *    Power Management feature set
                Security Mode feature set
           *    SMART feature set
           *    FLUSH CACHE EXT command
           *    Mandatory FLUSH CACHE command
           *    Device Configuration Overlay feature set
           *    Automatic Acoustic Management feature set
                SET MAX security extension
                Advanced Power Management feature set
           *    DOWNLOAD MICROCODE cmd
           *    SMART self-test
           *    SMART error logging

If I have missed any important information please let me know.

Regards,

John Lange


