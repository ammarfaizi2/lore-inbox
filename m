Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267195AbUGNIC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267195AbUGNIC2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 04:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267316AbUGNIC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 04:02:28 -0400
Received: from mailrelay.nefonline.de ([212.114.153.196]:24025 "EHLO
	mailrelay1.nefonline.de") by vger.kernel.org with ESMTP
	id S267195AbUGNIAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 04:00:41 -0400
Date: Wed, 14 Jul 2004 10:00:36 +0200
From: Hermann Gottschalk <hg@ostc.de>
To: bert hubert <ahu@ds9a.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange Network behaviour
Message-ID: <20040714080036.GC11178@ostc.de>
References: <20040702153028.GD15170@ostc.de> <20040704164654.GA18688@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040704164654.GA18688@outpost.ds9a.nl>
User-Agent: Mutt/1.4.1i
X-PGP-Key: 1024D/0B2D8EEA 2004-06-07 Hermann Gottschalk (OSTC) <hg@ostc.de>
X-PGP-Fingerprint: 9A36 D20E B7FB BE5D 11DB  3006 3ADA D083 0B2D 8EEA
X-Operating-System: Linux 2.4.21-231-default
X-message-flag: Please do NOT send HTML e-mail or MS Word attachments - use plain text instead
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 04, 2004 at 06:46:54PM +0200, bert hubert wrote:
> On Fri, Jul 02, 2004 at 05:30:28PM +0200, Hermann Gottschalk wrote:
> 
> > This happend for a long time until there was a kernel patch from
> > 2.4.21-215 to 2.4.21-266. Since it is installed this error doesn't
> > appear anymore.
> 
> If it ever happens again, supply the output of ifconfig after it happens,
> and dmesg, and lspci -v -v -v. Sure looks like a weird error though,
> probably not related to your network interfaces. 
> 
> 'Protocol not available' is a weird one.
> 
> Perhaps something with modules?

OK, now after an "update" to 2.4.21-231 (SuSE 9.0) some similar
Errors occur:

1) The via-rhine IF isn't accessible anymore. It's up but doesn't work.

2) We work with lvm and lvm-snapshots can't be removed anymore. I
   get a segmentation fault.

Here the ouputs:

ifconfig
---------
eth0      Link encap:Ethernet  HWaddr 00:0C:76:3F:D6:C4
          inet addr:172.16.0.12  Bcast:172.16.0.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:207507 errors:0 dropped:0 overruns:0 frame:0
          TX packets:196605 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:92145974 (87.8 Mb)  TX bytes:64863064 (61.8 Mb)
          Interrupt:5 Base address:0xbc00 Memory:fe9e0000-fea00000

eth0:0    Link encap:Ethernet  HWaddr 00:0C:76:3F:D6:C4
          inet addr:172.16.2.12  Bcast:172.16.2.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          Interrupt:5 Base address:0xbc00 Memory:fe9e0000-fea00000

eth1      Link encap:Ethernet  HWaddr 00:0D:88:4F:24:9B
          inet addr:192.168.0.12  Bcast:192.168.0.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
          Interrupt:12 Base address:0xc800

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:130 errors:0 dropped:0 overruns:0 frame:0
          TX packets:130 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:11491 (11.2 Kb)  TX bytes:11491 (11.2 Kb)

---------


dmesg
---------
: IRQ (10) already programmed
PIC: IRQ (5) already programmed
PIC: IRQ (12) already programmed
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 9
00:03:09[A] -> IRQ 9 Mode 1 Trigger 1
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 9
PIC: IRQ (9) already programmed
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 11
PIC: IRQ (11) already programmed
PIC: IRQ (12) already programmed
PIC: IRQ (9) already programmed
PIC: IRQ (9) already programmed
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
apm: overridden by ACPI.
Starting kswapd
bigpage subsystem: allocated 0 bigpages (=0MB).
allocated 32 pages and 32 bhs reserved for the highmem bounces
kinoded started
VFS: Disk quotas vdquot_6.5.1
aio_setup: num_physpages = 131068
aio_setup: sizeof(struct page) = 48
vesafb: framebuffer at 0xf0000000, mapped to 0xf8817000, size 65536k
vesafb: mode is 1024x768x16, linelength=2048, pages=1
vesafb: protected mode interface info at c000:ec70
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
bootsplash 3.0.9-2003/09/08: looking for picture.... silenjpeg size 22326 bytes, found (1024x768, 11098 bytes, v3).
bootsplash: silent jpeg found.
bootsplash: silent jpeg found.
Console: switching to colour frame buffer device 118x38
fb0: VESA VGA frame buffer device
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
keyboard: Timeout - AT keyboard not present?(ed)
keyboard: Timeout - AT keyboard not present?(f4)
Real Time Clock Driver v1.10e
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
loop: loaded (max 16 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX-4: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
PIIX-4: chipset revision 2
PIIX-4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
hdc: JLMS XJ-HD166S, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
ide-floppy driver 0.99.newide
ide-floppy driver 0.99.newide
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 524288 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
cryptoapi: loaded
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 395k freed
VFS: Mounted root (ext2 filesystem).
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 29160 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
  Vendor: MAXTOR    Model: ATLAS10K4_73WLS   Rev: DFV0
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 143666192 512-byte hdwr sectors (73557 MB)
Partition check:
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Trying to move old root to /initrd ... failed
Unmounting old root
Trying to free ramdisk memory ... okay
Freeing unused kernel memory: 160k freed
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,3), internal journal
lvm-mp: allocating 42 lowmem entries at c39b9000
LVM version 1.0.5+(mp-v6d)(22/07/2002) module loaded
Adding Swap: 2104472k swap-space (priority 42)
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,3), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ISO 9660 Extensions: Microsoft Joliet Level 3
ISO 9660 Extensions: RRIP_1991A
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on lvm(58,0), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on lvm(58,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on lvm(58,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on lvm(58,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
bootsplash: silent jpeg found.
Intel(R) PRO/1000 Network Driver - version 5.2.16
Copyright (c) 1999-2003 Intel Corporation.
PCI: Setting latency timer of device 02:01.0 to 64
eth0: Intel(R) PRO/1000 Network Connection
via-rhine.c:v1.10-LK1.1.17  March-1-2003  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
eth1: VIA VT6105 Rhine-III at 0xc800, 00:0d:88:4f:24:9b, IRQ 12.
eth1: MII PHY found at address 1, status 0x786d advertising 05e1 Link 45e1.
eth1: Setting full-duplex based on MII #1 link partner capability of 45e1.
raw1394: /dev/raw1394 device initialized
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Setting latency timer of device 00:1d.7 to 64
ehci_hcd 00:1d.7: Intel Corp. 82801EB USB2 Enhanced Host Controller
ehci_hcd 00:1d.7: irq 12, pci mem fc995c00
usb.c: new USB bus registered, assigned bus number 1
ehci_hcd 00:1d.7: enabled 64bit PCI DMA
PCI: 00:1d.7 PCI cache line size set incorrectly (0 bytes) by BIOS/FW.
PCI: 00:1d.7 PCI cache line size corrected to 32.
ehci_hcd 00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-19/2.4
hub.c: USB hub found
hub.c: 8 ports detected
usb-uhci.c: $Revision: 1.275 $ time 16:12:56 Jun 28 2004
usb-uhci.c: High bandwidth mode enabled
PCI: Setting latency timer of device 00:1d.0 to 64
usb-uhci.c: USB UHCI at I/O 0xe000, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.1 to 64
usb-uhci.c: USB UHCI at I/O 0xe400, IRQ 12
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.2 to 64
usb-uhci.c: USB UHCI at I/O 0xe800, IRQ 5
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 4
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.3 to 64
usb-uhci.c: USB UHCI at I/O 0xec00, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 5
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
uhci.c: USB Universal Host Controller Interface driver v1.1
mice: PS/2 mouse device common for all mice
e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU1] (supports C1, 8 throttling states)
ACPI: Processor [CPU2] (supports C1, 8 throttling states)
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
bootsplash: silent jpeg found.
keyboard: Timeout - AT keyboard not present?(f4)
eth1: Reset not complete yet. Trying harder.
eth1: Setting full-duplex based on MII #1 link partner capability of 45e1.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
keyboard: Timeout - AT keyboard not present?(f4)
keyboard: Timeout - AT keyboard not present?(f4)
keyboard: Timeout - AT keyboard not present?(f4)
keyboard: Timeout - AT keyboard not present?(f4)
keyboard: Timeout - AT keyboard not present?(f4)
keyboard: Timeout - AT keyboard not present?(f4)
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Transmit timed out, status 0000, PHY status 786d, resetting...
eth1: Reset not complete yet. Trying harder.
eth1: Setting full-duplex based on MII #1 link partner capability of 45e1.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Transmit timed out, status 0000, PHY status 786d, resetting...
eth1: Reset not complete yet. Trying harder.
eth1: Setting full-duplex based on MII #1 link partner capability of 45e1.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Transmit timed out, status 0000, PHY status 786d, resetting...
eth1: Reset not complete yet. Trying harder.
eth1: Setting full-duplex based on MII #1 link partner capability of 45e1.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Transmit timed out, status 0000, PHY status 786d, resetting...
eth1: Reset not complete yet. Trying harder.
eth1: Setting full-duplex based on MII #1 link partner capability of 45e1.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Transmit timed out, status 0000, PHY status 786d, resetting...
eth1: Reset not complete yet. Trying harder.
eth1: Setting full-duplex based on MII #1 link partner capability of 45e1.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Transmit timed out, status 0000, PHY status 786d, resetting...
eth1: Reset not complete yet. Trying harder.
eth1: Setting full-duplex based on MII #1 link partner capability of 45e1.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Transmit timed out, status 0000, PHY status 786d, resetting...
eth1: Reset not complete yet. Trying harder.
eth1: Setting full-duplex based on MII #1 link partner capability of 45e1.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Transmit timed out, status 0000, PHY status 786d, resetting...
eth1: Reset not complete yet. Trying harder.
eth1: Setting full-duplex based on MII #1 link partner capability of 45e1.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Transmit timed out, status 0000, PHY status 786d, resetting...
eth1: Reset not complete yet. Trying harder.
eth1: Setting full-duplex based on MII #1 link partner capability of 45e1.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Transmit timed out, status 0000, PHY status 786d, resetting...
eth1: Reset not complete yet. Trying harder.
eth1: Setting full-duplex based on MII #1 link partner capability of 45e1.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Transmit timed out, status 0000, PHY status 786d, resetting...
eth1: Reset not complete yet. Trying harder.
eth1: Setting full-duplex based on MII #1 link partner capability of 45e1.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Transmit timed out, status 0000, PHY status 786d, resetting...
eth1: Reset not complete yet. Trying harder.
eth1: Setting full-duplex based on MII #1 link partner capability of 45e1.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Transmit timed out, status 0000, PHY status 786d, resetting...
eth1: Reset not complete yet. Trying harder.
eth1: Setting full-duplex based on MII #1 link partner capability of 45e1.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Transmit timed out, status 0000, PHY status 786d, resetting...
eth1: Reset not complete yet. Trying harder.
eth1: Setting full-duplex based on MII #1 link partner capability of 45e1.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Transmit timed out, status 0000, PHY status 786d, resetting...
eth1: Reset not complete yet. Trying harder.
eth1: Setting full-duplex based on MII #1 link partner capability of 45e1.
device eth0 entered promiscuous mode
device eth0 left promiscuous mode
eth1: Promiscuous mode enabled.
device eth1 entered promiscuous mode
device eth1 left promiscuous mode
eth1: Reset not complete yet. Trying harder.
eth1: Setting full-duplex based on MII #1 link partner capability of 45e1.
kernel BUG at memory.c:531!
invalid operand: 0000 2.4.21-231-default #1 Mon Jun 28 15:39:34 UTC 2004
CPU:    0
EIP:    0010:[<c012db64>]    Not tainted
EFLAGS: 00010246
eax: 00000000   ebx: c10db0b0   ecx: 0000000b   edx: c27ffd40
esi: c2802670   edi: 00000000   ebp: 00000006   esp: caa93d7c
ds: 0018   es: 0018   ss: 0018
Process lvremove (pid: 28873, stackpage=caa93000)
Stack: c10db0b0 c39a2220 c012dfd7 c10db0b0 c3946c00 c3946c00 c3946600 c3975447
       c39a2220 c39a2220 c39ed000 c39736c4 c3946c00 c3946770 4004fe21 00000000
       c39ed000 bffff300 c3970940 00000000 c3979ca0 ffffffff c54c6a00 c5c377e8
Call Trace:         [<c012dfd7>] (20) [<c3975447>] (16) [<c39736c4>] (28)
  [<c3970940>] (08) [<c3979ca0>] (16) [<c012f795>] (44) [<c0118718>] (28)
  [<c022615b>] (12) [<c02262b2>] (08) [<c024daf8>] (40) [<c022615b>] (12)
  [<c02262b2>] (04) [<c013437e>] (12) [<c0134488>] (36) [<c012f2d3>] (72)
  [<c014ed80>] (24) [<c0151c8a>] (16) [<c014492b>] (48) [<c0144a94>] (24)
  [<c01438f4>] (28) [<c01437b0>] (24) [<c0152e26>] (32) [<c0143b0c>] (20)
  [<c0108e13>] (60)
Modules: [(lvm-mod:<c3970060>:<c397f644>)]
Code: 0f 0b 13 02 a6 22 2a c0 eb dc 89 f6 55 57 56 53 57 57 83 7c
 <6>NETDEV WATCHDOG: eth1: transmit timed out
eth1: Transmit timed out, status 0000, PHY status 786d, resetting...
eth1: Reset not complete yet. Trying harder.
eth1: Setting full-duplex based on MII #1 link partner capability of 45e1.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Transmit timed out, status 0000, PHY status 786d, resetting...
eth1: Reset not complete yet. Trying harder.
eth1: Setting full-duplex based on MII #1 link partner capability of 45e1.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Transmit timed out, status 0000, PHY status 786d, resetting...
eth1: Reset not complete yet. Trying harder.
eth1: Setting full-duplex based on MII #1 link partner capability of 45e1.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Transmit timed out, status 0000, PHY status 786d, resetting...
eth1: Reset not complete yet. Trying harder.
eth1: Setting full-duplex based on MII #1 link partner capability of 45e1.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Transmit timed out, status 0000, PHY status 786d, resetting...
eth1: Reset not complete yet. Trying harder.
eth1: Setting full-duplex based on MII #1 link partner capability of 45e1.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Transmit timed out, status 0000, PHY status 786d, resetting...
eth1: Reset not complete yet. Trying harder.
eth1: Setting full-duplex based on MII #1 link partner capability of 45e1.
via-rhine.c:v1.10-LK1.1.17  March-1-2003  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
via-rhine: Reset not complete yet. Trying harder.
eth1: VIA VT6105 Rhine-III at 0xc800, 00:0d:88:4f:24:9b, IRQ 12.
eth1: MII PHY found at address 1, status 0x786d advertising 05e1 Link 45e1.
eth1: Reset not complete yet. Trying harder.
eth1: Setting full-duplex based on MII #1 link partner capability of 45e1.
---------

lspci -v -v -v
---------
00:00.0 Host bridge: Intel Corp. 82865G/PE/P Processor to I/O Controller (rev 02)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7280
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [e4] #09 [2106]
        Capabilities: [a0] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=2 Cal=2 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=2 SBA+ AGP- GART64- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 82865G/PE/P Processor to AGP Controller (rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fc800000-fe8fffff
        Prefetchable memory behind bridge: efe00000-f7dfffff
        BridgeCtl: Parity+ SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:03.0 PCI bridge: Intel Corp. 82865G/PE/P Processor to PCI to CSA Bridge (rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 0000b000-0000bfff
        Memory behind bridge: fe900000-fe9fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00 [UHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7280
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 4: I/O ports at e000 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00 [UHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7280
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 12
        Region 4: I/O ports at e400 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00 [UHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7280
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 5
        Region 4: I/O ports at e800 [size=32]

00:1d.3 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00 [UHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7280
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 4: I/O ports at ec00 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801EB USB2 (rev 02) (prog-if 20 [EHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7280
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 12
        Region 0: Memory at febffc00 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] #0a [20a0]

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev c2) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
        Latency: 0
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=32
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: fea00000-feafffff
        Prefetchable memory behind bridge: f7e00000-f7efffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801EB LPC Interface Controller (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801EB Ultra ATA Storage Controller (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7280
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at fc00 [size=16]
        Region 5: Memory at 80000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp. 82801EB SMBus Controller (rev 02)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7280
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 10
        Region 4: I/O ports at 0c00 [size=32]

01:00.0 VGA compatible controller: nVidia Corporation NV18 [GeForce4 MX 440 AGP 8x] (rev a4) (prog-if 00 [VGA])
        Subsystem: LeadTek Research Inc.: Unknown device 2924
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at f0000000 (32-bit, prefetchable) [size=64M]
        Expansion ROM at fe8e0000 [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=0 Cal=3 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

02:01.0 Ethernet controller: Intel Corp.: Unknown device 1019
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 728c
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (63750ns min), cache line size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at fe9e0000 (32-bit, non-prefetchable) [size=128K]
        Region 2: I/O ports at bc00 [size=32]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-

03:01.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
        Subsystem: Adaptec 29160 Ultra160 SCSI Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (10000ns min, 6250ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        BIST result: 00
        Region 0: I/O ports at cc00 [disabled] [size=256]
        Region 1: Memory at feaff000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at feac0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

03:03.0 Ethernet controller: VIA Technologies, Inc. VT6105 [Rhine-III] (rev 86)
        Subsystem: D-Link System Inc: Unknown device 1403
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (750ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 12
        Region 0: I/O ports at c800 [size=256]
        Region 1: Memory at feafef00 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at feab0000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

---------


Any ideas?

Greetings Hermann

-- 
  ___  ___ _____ ___    ___       _    _  _
 / _ \/ __|_   _/ __|  / __|_ __ | |__| || |
| (_) \__ \ | || (__  | (_ | '  \| '_ \ __ |
 \___/|___/ |_| \___|  \___|_|_|_|_.__/_||_|
----------------------------------------------
 OSTC Open Source Training and Consulting GmbH
 90425 Nürnberg      Web:   http://www.ostc.de
----------------------------------------------
            PGP-Key: 0x0B2D8EEA 
    No HTML-Mails; 72 Characters per line
