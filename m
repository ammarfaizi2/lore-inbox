Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132514AbRDAPRh>; Sun, 1 Apr 2001 11:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132508AbRDAPR2>; Sun, 1 Apr 2001 11:17:28 -0400
Received: from f242.dkm.cz ([62.24.70.242]:9997 "EHLO www.srnet.cz")
	by vger.kernel.org with ESMTP id <S132514AbRDAPRI>;
	Sun, 1 Apr 2001 11:17:08 -0400
Date: Sun, 1 Apr 2001 17:16:12 +0200 (CEST)
From: Stepan Roh <stepan@srnet.cz>
To: <linux-kernel@vger.kernel.org>
Subject: VIA 82c686b and IOMega ATAPI ZIP 100 problem
Message-ID: <Pine.LNX.4.30.0104011612470.182-100000@penguin.src>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm experiencing serious problems with Linux, VIA vt82c686b IDE interface
(as included on VIA KT133 (latest revisions), KT133A and newer chipsets)
and IOMega ATAPI ZIP 100 drive. Error description and system information
are included below. That is a known problem with this chip. Something bad
happens with ATAPI there (but only for IOMega ATAPI ZIP 100 and some old
CD-ROMs - I have both). Under Windows (which I don't have) you can install
beta version of VIA IDE Busmaster drivers to solve this problem. I wrote
to MSI (manufacturer of motherboard) and to VIA. Guys from VIA did not
replied to me and from MSI they sent me Windows drivers with suggestion to
try it under Linux. Is there any real solution for this problem under
Linux?

I'm not subscribed to this list, so please CC to me.

Thanks,

Stepan Roh
src@srnet.cz

Error description:

When writing data to IOMega ATAPI ZIP 100 drive, whole IDE interface is
frozen including all programs accessing it. Unmount is impossible (even
when I try to force unmount with SysRq). Following messages are written to
syslog (these messages slightly differ from kernel version to kernel
version (I tried 2.2.18, 2.4.2, 2.4.3) - following is from 2.4.3 when
overwriting large file):

Mar 31 20:26:24 penguin kernel: Filesystem panic (dev 16:44).
Mar 31 20:26:24 penguin kernel:   fat_free: deleting beyond EOF
Mar 31 20:26:24 penguin kernel:   File system has been set read-only
Mar 31 20:27:47 penguin kernel: hdd: lost interrupt
Mar 31 20:27:47 penguin kernel: ide-floppy: CoD != 0 in idefloppy_pc_intr
Mar 31 20:27:47 penguin kernel: ide-floppy: CoD != 0 in idefloppy_pc_intr
Mar 31 20:27:47 penguin kernel: hdd: ATAPI reset complete

Last 4 lines are repeated as long as file is not written (this depends on
file size). On 2.2.18 kernel additional set of messages similar to the one
below is written:

Mar  4 19:50:55 penguin kernel: file_cluster badly computed!!! 0 <> 3315

Writing speed is aprox. 1000 times slower than it was on my old computer.

System information:

dmesg:

Linux version 2.4.3 (root@penguin) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #3 Sat Mar 31 20:12:33 CEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
 BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=linux-2.4.3 ro root=301
Initializing CPU#0
Detected 849.609 MHz processor.
Console: colour VGA+ 80x50
Calibrating delay loop... 1690.82 BogoMIPS
Memory: 255572k/262080k available (984k kernel code, 6120k reserved, 359k data, 180k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: Common caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfb260, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Bus master Pipeline request disabled
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 169826kB/56608kB, 512 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:pio, hdd:pio
hda: IBM-DTLA-307030, ATA DISK drive
hdc: BCD-8X 1996-09-04, ATAPI CD/DVD-ROM drive
hdd: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
hdc: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hdc: set_drive_speed_status: error=0xd1
ide1: Drive 0 didn't accept speed setting. Oh, well.
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=3737/255/63, UDMA(100)
hdc: ATAPI 2X CD-ROM drive, 240kB Cache
Uniform CD-ROM driver Revision: 3.12
hdd: 98304kB, 96/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
Partition check:
 hda: hda1 hda2 hda3
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
Serial driver version 5.05 (2000-12-13) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 180k freed
Adding Swap: 248996k swap-space (priority -1)
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
PCI: Found IRQ 10 for device 00:09.0
IRQ routing conflict in pirq table for device 00:07.5
eth0: RealTek RTL-8029 found at 0xe000, IRQ 10, 00:00:B4:A4:67:80.

/proc/pci:

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 2).
      Prefetchable 32 bit memory at 0xd0000000 [0xd3ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (rev 0).
      Master Capable.  No bursts.  Min Gnt=4.
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 64).
  Bus  0, device   7, function  1:
    IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 6).
      Master Capable.  Latency=32.
      I/O at 0xc000 [0xc00f].
  Bus  0, device   7, function  2:
    USB Controller: VIA Technologies, Inc. UHCI USB (rev 22).
      IRQ 5.
      Master Capable.  Latency=32.
      I/O at 0xc400 [0xc41f].
  Bus  0, device   7, function  3:
    USB Controller: VIA Technologies, Inc. UHCI USB (#2) (rev 22).
      IRQ 5.
      Master Capable.  Latency=32.
      I/O at 0xc800 [0xc81f].
  Bus  0, device   7, function  4:
    Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 64).
      IRQ 9.
  Bus  0, device   7, function  5:
    Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 80).
      IRQ 11.
      I/O at 0xcc00 [0xccff].
      I/O at 0xd000 [0xd003].
      I/O at 0xd400 [0xd403].
  Bus  0, device   8, function  0:
    VGA compatible controller: ATI Technologies Inc 264VT [Mach64 VT] (rev 72).
      Non-prefetchable 32 bit memory at 0xd4000000 [0xd4ffffff].
      I/O at 0xdc00 [0xdcff].
  Bus  0, device   9, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS) (rev 0).
      IRQ 10.
      I/O at 0xe000 [0xe01f].

/proc/ide/via:

----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.20
South Bridge:                       VIA vt82c686b
Revision:                           ISA 0x40 IDE 0x6
BM-DMA base:                        0xc000
PCI clock:                          33MHz
Master Read  Cycle IRDY:            0ws
Master Write Cycle IRDY:            0ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:               no                  no
Post Write Buffer:             no                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   80w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA       PIO       PIO       PIO
Address Setup:       30ns     120ns      30ns      30ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      90ns      90ns
Data Active:         90ns     330ns      90ns      90ns
Data Recovery:       30ns     270ns      90ns      90ns
Cycle Time:          20ns      50ns      90ns      90ns
Transfer Rate:  100.0MB/s  40.0MB/s  22.2MB/s  22.2MB/s





