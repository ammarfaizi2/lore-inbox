Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316530AbSFQQ4A>; Mon, 17 Jun 2002 12:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316574AbSFQQz7>; Mon, 17 Jun 2002 12:55:59 -0400
Received: from web21001.mail.yahoo.com ([216.136.227.55]:44411 "HELO
	web21001.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S316530AbSFQQzz>; Mon, 17 Jun 2002 12:55:55 -0400
Message-ID: <20020617165244.44049.qmail@web21001.mail.yahoo.com>
Date: Mon, 17 Jun 2002 09:52:44 -0700 (PDT)
From: kk maddowx <kk_maddox2000@yahoo.com>
Subject: Re: 2.4.18 kernel panics before and after boot
To: Kristian Peters <kristian.peters@korseby.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020617093545.23389d53.kristian.peters@korseby.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately I could not get memtest to work. I added
the lines:

label=memtest
image=/boot/memtest

to lilo.conf and ran lilo.
I can see the selection for memtest but it wont accept
it as a bootable image. I did swap the memory out and
still recieve kernel panics with known working memory.

However if I boot from my old 2.2.20 kernel I will
never see a panic or experience a panic after boot
making me think the memory is ok. Here is the dmesg
from a successful 2.4 boot if that helps:



LILO
Loading 2.4..................
Linux version 2.4.18a (root@birdbrain) (gcc version
2.96 20000731 (Red Hat Linux
 7.0)) #1 Thu Jun 13 01:54:35 EDT 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00
(usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000
(reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000
(reserved)
 BIOS-e820: 0000000000100000 - 0000000008000000
(usable)
 BIOS-e820: 00000000fec00000 - 00000000fec01000
(reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000
(reserved)
 BIOS-e820: 00000000fffe0000 - 0000000100000000
(reserved)
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=2.4 ro root=305
BOOT_FILE=/boot/vmlinuz-2.4
.18a console=ttyS0,9600n8 console=tty0
Initializing CPU#0
Detected 333.523 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 665.19 BogoMIPS
Memory: 126532k/131072k available (1263k kernel code,
4152k reserved, 396k data,
 220k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5,
131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536
bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384
bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768
bytes)
Page-cache hash table entries: 32768 (order: 5, 131072
bytes)
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32
bytes/line)
CPU: AMD-K6(tm) 3D processor stepping 00
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfdb11, last
bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router ALI [10b9/1533] at 00:07.0
PCI: Hardcoded IRQ 14 for device 00:0f.0
isapnp: Scanning for PnP cards...
isapnp: SB audio device quirk - increasing port range
isapnp: AWE32 quirk - adding two ports
isapnp: Card 'Creative SB AWE64 PnP'
isapnp: 1 Plug & Play card detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society
NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with
MANY_PORTS SHARE_IRQ SERIAL_PCI IS
APNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: 128 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes;
override with idebus=xx
ALI15X3: IDE controller on PCI bus 00 dev 78
PCI: Hardcoded IRQ 14 for device 00:0f.0
ALI15X3: chipset revision 32
ALI15X3: not 100% native mode: will probe irqs later
ALI15X3: simplex device:  DMA disabled
ide0: ALI15X3 Bus-Master DMA disabled (BIOS)
ALI15X3: simplex device:  DMA disabled
ide1: ALI15X3 Bus-Master DMA disabled (BIOS)
hda: WDC AC313000R, ATA DISK drive
hdb: CREATIVEDVD-ROM DVD2240E 12/24/97, ATAPI
CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 25429824 sectors (13020 MB) w/512KiB Cache,
CHS=1582/255/63
hdb: ATAPI 24X DVD-ROM drive, 256kB Cache
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 < hda5 hda6 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory:
96M
agpgart: Detected Ali M1541 chipset
agpgart: AGP aperture is 64M @ 0xe0000000
[drm] Initialized tdfx 1.0.0 20010216 on minor 0
[drm] AGP 0.99 on ALi M1541 @ 0xe0000000 64MB
[drm] Initialized radeon 1.1.1 20010405 on minor 1
SCSI subsystem driver Revision: 1.00
request_module[scsi_hostadapter]: Root fs not mounted
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
usb.c: registered new driver hub
uhci.c: USB Universal Host Controller Interface driver
v1.1
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind
8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ds: no socket drivers loaded!
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 220k freed


I have noticed that if the kernel does decide to panic
on boot it will happen after the "Freeing unused
memory" message is printed. Do you have any ideas what
might be casuing this? TIA


--- Kristian Peters <kristian.peters@korseby.net>
wrote:
> Hello.
> 
> I suspect bad ram. Could you verify with memtest86
> that your ram is ok ?
> 
> *Kristian
> 
> kk maddowx <kk_maddox2000@yahoo.com> wrote:
> > >>EIP; 00000400 Before first symbol   <=====
> > Trace; c0127b63 <shrink_cache+2b3/2f0>
> > Trace; c0127cd6 <shrink_caches+56/90>
> > Trace; c0127d40 <try_to_free_pages+30/50>
> > Trace; c0127dd4 <kswapd_balance_pgdat+44/90>
> > Trace; c0127e36 <kswapd_balance+16/30>
> > Trace; c0127f51 <kswapd+a1/c0>
> > Trace; c0127eb0 <kswapd+0/c0>
> > Trace; c010552b <kernel_thread+2b/40>
> 
>   :... [snd.science] ...:
>  ::                             _o)
>  :: http://www.korseby.net      /\\
>  :: http://gsmp.sf.net         _\_V
>   :.........................:


__________________________________________________
Do You Yahoo!?
Yahoo! - Official partner of 2002 FIFA World Cup
http://fifaworldcup.yahoo.com
