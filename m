Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269804AbRHYRLV>; Sat, 25 Aug 2001 13:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269811AbRHYRLM>; Sat, 25 Aug 2001 13:11:12 -0400
Received: from studsv07.studserv.uni-stuttgart.de ([129.69.21.37]:14858 "EHLO
	studsv07.studserv.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S269804AbRHYRK6>; Sat, 25 Aug 2001 13:10:58 -0400
Date: Sat, 25 Aug 2001 19:11:13 +0200
From: "Marcelo E. Magallon" <marcelo.magallon@bigfoot.com>
To: linux-kernel@vger.kernel.org
Subject: Oops when loading floppy.o
Message-ID: <20010825191113.A373@ysabell.wh.vaih>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux ysabell 2.4.9-xfs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

 someone told me this is a known problem but not 100% reproduceable.
 Attached are the ksymoops and dmesg output.  The machine where this
 happens doesn't have floppy drive and has the floppy controller
 disabled at the BIOS level.  Please mail me if you need more
 information and keep me on the Cc: line.

-- 
Marcelo

--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=trace

ksymoops 2.4.1 on i686 2.4.9-xfs.  Options used
     -V (default)
     -k /var/log/ksymoops/20010825184024.ksyms (specified)
     -l /var/log/ksymoops/20010825184024.modules (specified)
     -o /lib/modules/2.4.9-xfs/ (default)
     -m /boot/System.map-2.4.9-xfs (default)

Warning (compare_maps): mismatch on symbol unix_socket_table  , unix says c8868740, /lib/modules/2.4.9-xfs/kernel/net/unix/unix.o says c8868380.  Ignoring /lib/modules/2.4.9-xfs/kernel/net/unix/unix.o entry
*pde = 01313067
Oops: 0002
CPU: 0
EIP: 0010:[<c0117602>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010092
eax: c0259fe4 ebx: 00000292 ecx: c7613d58 edx: c8875244
esi: 00000000 edi: c0297240 ebp: 00000000 esp: c7613d50
ds: 0018 es: 0018 ss: 0018
Process modprobe (pid: 147, stackpage=c7613000)
Stack: c029f734 00000000 00000000 00000046 c011a2f6 c0259fe4 c011756a c0117489
       00000009 00000001 c0297280 fffffffe c0297280 c011726a c0297280 00000000
       c0293900 00000000 c7613db4 00000046 c010810d 0c013135 00000000 c7613e6c
Call trace: [<c011a2f6>] [<c011756a>] [<c0117489>] [<c011726a>] [<c010810d>]
            [<c0106cc4>] [<c0216d82>] [<c015554a>] [<c02173ab>] [<c02173ab>]
            [<c0217426>] [<c0217444>] [<c0115854>] [<c0131350>] [<c0149738>]
            [<c012f5e6>] [<c0106c3b>]
Code: 89 4a 04 89 54 24 08 8b 50 04 89 08 89 51 04 89 0a 89 00 89

>>EIP; c0117602 <__run_task_queue+12/60>   <=====
Trace; c011a2f6 <immediate_bh+16/20>
Trace; c011756a <bh_action+1a/50>
Trace; c0117489 <tasklet_hi_action+59/80>
Trace; c011726a <do_softirq+5a/b0>
Trace; c010810d <do_IRQ+9d/b0>
Trace; c0106cc4 <ret_from_intr+0/7>
Trace; c0216d82 <number+1f2/440>
Trace; c015554a <pagebuf_generic_file_write+10a/3d0>
Trace; c02173ab <vsnprintf+3db/420>
Trace; c02173ab <vsnprintf+3db/420>
Trace; c0217426 <vsprintf+16/20>
Trace; c0217444 <sprintf+14/20>
Trace; c0115854 <get_ksyms_list+74/e0>
Trace; c0131350 <getblk+0/100>
Trace; c0149738 <ksyms_read_proc+28/40>
Trace; c012f5e6 <sys_read+96/d0>
Trace; c0106c3b <system_call+33/38>
Code;  c0117602 <__run_task_queue+12/60>
00000000 <_EIP>:
Code;  c0117602 <__run_task_queue+12/60>   <=====
   0:   89 4a 04                  mov    %ecx,0x4(%edx)   <=====
Code;  c0117605 <__run_task_queue+15/60>
   3:   89 54 24 08               mov    %edx,0x8(%esp,1)
Code;  c0117609 <__run_task_queue+19/60>
   7:   8b 50 04                  mov    0x4(%eax),%edx
Code;  c011760c <__run_task_queue+1c/60>
   a:   89 08                     mov    %ecx,(%eax)
Code;  c011760e <__run_task_queue+1e/60>
   c:   89 51 04                  mov    %edx,0x4(%ecx)
Code;  c0117611 <__run_task_queue+21/60>
   f:   89 0a                     mov    %ecx,(%edx)
Code;  c0117613 <__run_task_queue+23/60>
  11:   89 00                     mov    %eax,(%eax)
Code;  c0117615 <__run_task_queue+25/60>
  13:   89 00                     mov    %eax,(%eax)


1 warning issued.  Results may not be reliable.

--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

Linux version 2.4.9-xfs (marcelo@ysabell) (gcc version 2.95.4 20010810 (Debian prerelease)) #1 Sat Aug 25 16:24:23 CEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007ff0000 (usable)
 BIOS-e820: 0000000007ff0000 - 0000000007ff8000 (ACPI data)
 BIOS-e820: 0000000007ff8000 - 0000000008000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 32752
zone(0): 4096 pages.
zone(1): 28656 pages.
zone(2): 0 pages.
Kernel command line: mem=131008K  root=/dev/hda7 ro
Initializing CPU#0
Detected 499.051 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 996.14 BogoMIPS
Memory: 126628k/131008k available (1132k kernel code, 3992k reserved, 292k data, 172k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0081f9ff c0c1f9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After vendor init, caps: 0081f9ff c0c1f9ff 00000000 00000000
CPU:     After generic, caps: 0081f9ff c0c1f9ff 00000000 00000000
CPU:             Common caps: 0081f9ff c0c1f9ff 00000000 00000000
CPU: AMD-K7(tm) Processor stepping 02
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfdb01, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
Starting kswapd v1.8
SGI XFS with EAs, no debug enabled
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.10d
block: 128 slots per queue, batch=16
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686a (rev 1b) IDE UDMA66 controller on pci00:07.1
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: WDC WD136BA, ATA DISK drive
hdb: IOMEGA ZIP 250 ATAPI, ATAPI FLOPPY drive
hdc: Pioneer DVD-ROM ATAPIModel DVD-104S 012, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 26712000 sectors (13677 MB) w/1961KiB Cache, CHS=1662/255/63
ide-floppy driver 0.97
hdb: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hdb: set_drive_speed_status: error=0x04
ide0: Drive 1 didn't accept speed setting. Oh, well.
hdb: 244766kB, 489532 blocks, 512 sector size
hdb: 244736kB, 239/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
hdb: The disk reports a capacity of 250640384 bytes, but the drive only handles 250609664
ide-floppy: hdb: I/O error, pc = 5a, key =  5, asc = 24, ascq =  0
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 >
 hdb: hdb4
ide-floppy driver 0.97
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
Start mounting filesystem: ide0(3,7)
XFS: WARNING: recovery required on readonly filesystem.
XFS: write access will be enabled during mount.
Starting XFS recovery on filesystem: ide0(3,7) (dev: 3/7)
Ending XFS recovery on filesystem: ide0(3,7) (dev: 3/7)
VFS: Mounted root (xfs filesystem) readonly.
Freeing unused kernel memory: 172k freed
hda: DMA disabled
Adding Swap: 131000k swap-space (priority -1)
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 94M
agpgart: Detected AMD Irongate chipset
agpgart: AGP aperture is 128M @ 0xe0000000
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
PCI: Found IRQ 9 for device 00:06.0
eth0: RealTek RTL-8029 found at 0xd400, IRQ 9, 52:54:05:FD:DE:9D.
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
PCI: Found IRQ 10 for device 00:04.0
device eth0 entered promiscuous mode

--2oS5YaxWCcQjTEyO--
