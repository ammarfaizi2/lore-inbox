Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274002AbRIXQo0>; Mon, 24 Sep 2001 12:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274017AbRIXQoR>; Mon, 24 Sep 2001 12:44:17 -0400
Received: from smtp.mediascape.net ([212.105.192.20]:50438 "EHLO
	smtp.mediascape.net") by vger.kernel.org with ESMTP
	id <S274002AbRIXQoF>; Mon, 24 Sep 2001 12:44:05 -0400
Message-ID: <3BAF629A.8FB9BCA2@mediascape.de>
Date: Mon, 24 Sep 2001 18:43:06 +0200
From: Olaf Zaplinski <o.zaplinski@mediascape.de>
X-Mailer: Mozilla 4.77 [de] (X11; U; Linux 2.4.10-pre15 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: AIC7xxx errors (again) with 2.4.10pre15
In-Reply-To: <200109241639.f8OGdqY90368@aslan.scsiguy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Justin T. Gibbs" wrote:
> 
> >"Justin T. Gibbs" wrote:
> >>
> >> >Hi all,
> >> >
> >> >my software RAID1 (hda1+sda1) worked fine with the current aic7xxx driver
> >> >when using 2.4.10pre13, but with 2.4.10pre15 I get the old behaviour I know
> >> >from 2.4.9:
> >>
> >> What is your hardware configuration?  A full dmesg with aic7xxx=verbose
> >> should be sufficient.
> >
> >Here it is:
> 
> I need the *full* dmesg running with the new driver and aic7xxx=verbose
> set (in LILO or as an option in /etc/modules.conf if you are using an initrd).

OK:

Linux version 2.4.10-pre15 (root@binky) (gcc version 2.95.3 20010315 (SuSE))
#1 Mon Sep 24 17:25:37 CEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000008000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=linux ro root=901
BOOT_FILE=/boot/vmlinuz aic7xxx=verbose reboot=warm
video=vesa:ywrap,pmipal,mtrr
Initializing CPU#0
Detected 300.683 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 599.65 BogoMIPS
Memory: 126860k/131072k available (1032k kernel code, 3828k reserved, 287k
data, 204k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 008021bf 808029bf 00000000, vendor = 2
Enabling new style K6 write allocation for 128 Mb
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: After vendor init, caps: 008021bf 808029bf 00000000 00000002
CPU:     After generic, caps: 008021bf 808029bf 00000000 00000002
CPU:             Common caps: 008021bf 808029bf 00000000 00000002
CPU: AMD-K6(tm) 3D processor stepping 0c
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: AMD K6
PCI: PCI BIOS revision 2.10 entry at 0xfb2e0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router default [1039/5591] at 00:00.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
vesafb: framebuffer at 0xe6000000, mapped to 0xc8800000, size 4096k
vesafb: mode is 800x600x8, linelength=800, pages=7
vesafb: protected mode interface info at c000:4974
vesafb: pmi: set display start = c00c499b, set palette = c00c49fd
vesafb: pmi: ports = 3b4 3b5 3ba 3c0 3c1 3c4 3c5 3c6 3c7 3c8 3c9 3cc 3ce 3cf
3d0 3d1 3d2 3d3 3d4 3d5 3da 
vesafb: scrolling: ywrap using protected mode interface, yres_virtual=5242
Console: switching to colour frame buffer device 100x37
fb0: VESA VGA frame buffer device
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: 128 slots per queue, batch=16
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller on PCI bus 00 dev 01
keyboard: Timeout - AT keyboard not present?(ed)
keyboard: Timeout - AT keyboard not present?(f4)
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SiS5591
    ide0: BM-DMA at 0x4000-0x4007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x4008-0x400f, BIOS settings: hdc:pio, hdd:pio
hda: QUANTUM FIREBALL1080A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 2128896 sectors (1090 MB) w/83KiB Cache, CHS=528/64/63, DMA
Partition check:
 hda: hda1 hda2
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
eth0: RealTek RTL-8029 found at 0xe400, IRQ 12, 00:00:B4:52:4A:D6.
SCSI subsystem driver Revision: 1.00
(scsi0) <Adaptec AHA-294X Ultra SCSI host adapter> found at PCI 0/11/0
(scsi0) Narrow Channel, SCSI ID=7, 16/255 SCBs
(scsi0) Downloading sequencer code... 436 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.4/5.2.0
       <Adaptec AHA-294X Ultra SCSI host adapter>
  Vendor: IBM OEM   Model: 0662S12           Rev: 3 30
  Type:   Direct-Access                      ANSI SCSI revision: 02
(scsi0:0:0:0) Enabled tagged queuing, queue depth 32.
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
(scsi0:0:0:0) Sending SDTR 25/15 message.
(scsi0:0:0:0) Synchronous at 10.0 Mbyte/sec, offset 15.
SCSI device sda: 2055035 512-byte hdwr sectors (1052 MB)
 sda: sda1
md: raid1 personality registered as nr 3
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
(read) hda1's sb offset: 1028032 [events: 00000071]
(read) sda1's sb offset: 1026944 [events: 00000071]
md: autorun ...
md: considering sda1 ...
md:  adding sda1 ...
md:  adding hda1 ...
md: created md1
md: bind<hda1,1>
md: bind<sda1,2>
md: running: <sda1><hda1>
md: sda1's event counter: 00000071
md: hda1's event counter: 00000071
md: RAID level 1 does not need chunksize! Continuing anyway.
md1: max total readahead window set to 124k
md1: 1 data-disks, max readahead per data-disk: 124k
raid1: device sda1 operational as mirror 1
raid1: device hda1 operational as mirror 0
raid1: raid set md1 active with 2 out of 2 mirrors
md: updating md1 RAID superblock on device
md: sda1 [events: 00000072](write) sda1's sb offset: 1026944
md: hda1 [events: 00000072](write) hda1's sb offset: 1028032
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
ip_conntrack (1024 buckets, 8192 max)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
reiserfs: checking transaction log (device 09:01) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 204k freed
Adding Swap: 36280k swap-space (priority 42)
