Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265775AbUAKGEl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 01:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265779AbUAKGEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 01:04:41 -0500
Received: from [216.127.68.117] ([216.127.68.117]:65179 "HELO 216.127.68.117")
	by vger.kernel.org with SMTP id S265775AbUAKGEd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 01:04:33 -0500
Message-ID: <4000E764.6030702@meerkatsoft.com>
Date: Sun, 11 Jan 2004 15:04:20 +0900
From: Alex <alex@meerkatsoft.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en, ja
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.20 RH Cannot set DMA
References: <3FFFB60C.9010309@meerkatsoft.com> <20040111053446.GA1242@rivenstone.net>
In-Reply-To: <20040111053446.GA1242@rivenstone.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am desperatly trying to enamle DMA on my HD  (hdparm -d1 /dev/hda) but always get an error message saying 

HDIO_SET_DMA failed: Operation not permitted
using_dma = 0 (off)

Can anybody help me to get this working?

Thanks 
Alex

Some information about my system

[root@morcote root]# uname -a
Linux morcote 2.4.20-28.9custom #2 Tue Jan 6 19:25:28 JST 2004 i686 i686 i386 GNU/Linux

[root@morcote root]# hdparm -tT /dev/hda
 
/dev/hda:
 Timing buffer-cache reads:   128 MB in  0.19 seconds =673.68 MB/sec
 Timing buffered disk reads:  64 MB in 22.30 seconds =  2.87 MB/sec

[root@morcote root]# hdparm -i /dev/hda
 
/dev/hda:
 
 Model=ST3120026A, FwRev=3.06, SerialNo=3JT28LX6
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=8192kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=234441648
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: ATA/ATAPI-6 T13 1410D revision 2:  1 2 3 4 5 6

[root@morcote root]# hdparm -v /dev/hda
 
/dev/hda:
 multcount    = 16 (on)
 IO_support   =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 14593/255/63, sectors = 234441648, start = 0

[root@morcote root]# dmesg
Linux version 2.4.20-28.9custom (root@localhost) (gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #2 Tue Jan 6 19:25:28 JST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003bef0000 (usable)
 BIOS-e820: 000000003bef0000 - 000000003bef3000 (ACPI NVS)
 BIOS-e820: 000000003bef3000 - 000000003bf00000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
62MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 245488
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 16112 pages.
Kernel command line: ro root=LABEL=/ hdc=ide-scsi
ide_setup: hdc=ide-scsi
Initializing CPU#0
Detected 3192.624 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 6370.09 BogoMIPS
Memory: 962280k/981952k available (1354k kernel code, 16608k reserved, 1001k data, 132k init, 64448k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) 4 CPU 3.20GHz stepping 09
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb470, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Ignoring BAR0-3 of IDE controller 00:14.1
Transparent bridge - PCI device 1002:4342 (ATI Technologies Inc)
PCI: Using IRQ router default [1002/5833] at 00:00.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Disk quotas vdquot_6.5.1
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS0 at 0x03f8 (irq = 4) is a 16550A
Real Time Clock Driver v1.10e
floppy0: no floppy controllers found
NET4: Frame Diverter 0.46
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta3-.2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: ST3120026A, ATA DISK drive
hdc: DVD-RW IDE1004, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=14593/255/63
ide-floppy driver 0.99.newide
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
ide-floppy driver 0.99.newide
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 146k freed
VFS: Mounted root (ext2 filesystem).
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 132k freed
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-ohci.c: USB OHCI at membase 0xf884a000, IRQ 3
usb-ohci.c: usb-00:13.0, PCI device 1002:4347 (ATI Technologies Inc)
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 3 ports detected
usb-ohci.c: USB OHCI at membase 0xf884c000, IRQ 3
usb-ohci.c: usb-00:13.1, PCI device 1002:4348 (ATI Technologies Inc)
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 3 ports detected
ehci-hcd 00:13.2: PCI device 1002:4345 (ATI Technologies Inc)
ehci-hcd 00:13.2: irq 3, pci mem f8854000
usb.c: new USB bus registered, assigned bus number 3
PCI: 00:13.2 PCI cache line size set incorrectly (32 bytes) by BIOS/FW.
PCI: 00:13.2 PCI cache line size corrected to 128.
ehci-hcd 00:13.2: USB 2.0 enabled, EHCI 1.00, driver 2003-Jan-22
hub.c: USB hub found
hub.c: 6 ports detected
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,3), internal journal
Adding Swap: 2024148k swap-space (priority -1)
hub.c: new USB device 00:13.2-5, assigned address 2
usb.c: USB device not accepting new address=2 (error=-71)
hub.c: new USB device 00:13.2-5, assigned address 3
usb.c: USB device not accepting new address=3 (error=-71)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,8), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,6), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ohci1394: $Rev: 693 $ Ben Collins <bcollins@debian.org>
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[3]  MMIO=[df003000-df0037ff]  Max Packet=[2048]
ieee1394: SelfID completion called outside of bus reset!
ieee1394: Host added: Node[00:1023]  GUID[00301bb100006be5]  [Linux OHCI-1394]
SCSI subsystem driver Revision: 1.00
hdc: attached ide-scsi driver.
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: DVDRW     Model: IDE1004           Rev: 0040
  Type:   CD-ROM                             ANSI SCSI revision: 02
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 1x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
ip_tables: (C) 2000-2002 Netfilter core team
Broadcom 4401 Ethernet Driver bcm4400 ver. 1.0.2 (09/06/02)
divert: allocating divert_blk for eth0
eth0: Broadcom BCM4401 100Base-T found at mem df000000, IRQ 10, node addr 00301bb16b81
ip_tables: (C) 2000-2002 Netfilter core team
bcm4400: eth0 NIC Link is Up, 100 Mbps full duplex
NETDEV WATCHDOG: eth0: transmit timed out
ip_tables: (C) 2000-2002 Netfilter core team
[root@morcote root]#

[root@morcote log]# lspci
00:00.0 Host bridge: ATI Technologies Inc: Unknown device 5833 (rev 02)
00:01.0 PCI bridge: ATI Technologies Inc: Unknown device 5838
00:13.0 USB Controller: ATI Technologies Inc: Unknown device 4347 (rev 01)
00:13.1 USB Controller: ATI Technologies Inc: Unknown device 4348 (rev 01)
00:13.2 USB Controller: ATI Technologies Inc: Unknown device 4345 (rev 01)
00:14.0 SMBus: ATI Technologies Inc: Unknown device 4353 (rev 17)
00:14.1 IDE interface: ATI Technologies Inc: Unknown device 4349
00:14.3 ISA bridge: ATI Technologies Inc: Unknown device 434c
00:14.4 PCI bridge: ATI Technologies Inc: Unknown device 4342
00:14.5 Multimedia audio controller: ATI Technologies Inc: Unknown device 4341
01:05.0 VGA compatible controller: ATI Technologies Inc: Unknown device 5834
02:05.0 RAID bus controller: CMD Technology Inc: Unknown device 3512 (rev 01)
02:06.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T (rev 01)
02:0b.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 80)

[root@morcote log]# cat /proc/modules
iptable_filter          2444   0 (autoclean) (unused)
ip_tables              15096   1 [iptable_filter]
autofs                 13268   0 (autoclean) (unused)
bcm4400                30912   1
sg                     36524   0 (autoclean)
sr_mod                 18168   0 (autoclean)
ide-scsi               12208   0
scsi_mod              107576   3 [sg sr_mod ide-scsi]
ide-cd                 35680   0
cdrom                  33728   0 [sr_mod ide-cd]
ohci1394               20200   0 (unused)
ieee1394               48780   0 [ohci1394]
keybdev                 2976   0 (unused)
mousedev                5556   1
hid                    22244   0 (unused)
input                   5888   0 [keybdev mousedev hid]
ehci-hcd               20104   0 (unused)
usb-ohci               21704   0 (unused)
usbcore                79072   1 [hid ehci-hcd usb-ohci]
ext3                   70784   6
jbd                    51924   6 [ext3]

boot log
Jan  7 23:49:04 morcote syslog: syslogd startup succeeded
Jan  7 23:49:04 morcote syslog: klogd startup succeeded
Jan  7 23:49:05 morcote portmap: portmap startup succeeded
Jan  7 23:49:05 morcote nfslock: rpc.statd startup succeeded
Jan  7 23:49:05 morcote keytable:
Jan  7 23:49:05 morcote keytable: Loading system font:
Jan  7 23:49:05 morcote keytable:
Jan  7 23:49:05 morcote rc: Starting keytable:  succeeded
Jan  7 23:49:05 morcote random: Initializing random number generator:  succeeded
Jan  7 23:49:05 morcote rc: Starting pcmcia:  succeeded
Jan  7 23:49:05 morcote netfs: Mounting other filesystems:  succeeded
Jan  7 23:49:06 morcote autofs: automount startup succeeded
Jan  7 23:49:02 morcote sysctl: kernel.shmall = 536870912
Jan  7 23:49:02 morcote sysctl: kernel.shmmax = 536870912
Jan  7 23:49:02 morcote network: Setting network parameters:  succeeded
Jan  7 23:49:02 morcote network: Bringing up loopback interface:  succeeded
Jan  7 23:49:07 morcote sshd:  succeeded
Jan  7 23:49:10 morcote xinetd: xinetd startup succeeded
Jan  7 23:49:12 morcote ntpd:  succeeded
Jan  7 23:49:13 morcote ntpd: ntpd startup succeeded
Jan  7 23:49:14 morcote sendmail: sendmail startup succeeded
Jan  7 23:49:14 morcote sendmail: sm-client startup succeeded
Jan  7 23:49:14 morcote gpm: gpm startup succeeded
Jan  7 23:49:15 morcote canna:  succeeded
Jan  7 23:49:16 morcote crond: crond startup succeeded
Jan  7 23:49:19 morcote xfs: xfs startup succeeded
Jan  7 23:49:19 morcote anacron: anacron startup succeeded
Jan  7 23:49:19 morcote atd: atd startup succeeded
Jan  7 23:49:19 morcote rhnsd: rhnsd startup succeeded



