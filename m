Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262921AbTHUWUq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 18:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262920AbTHUWUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 18:20:46 -0400
Received: from mail.mediaways.net ([193.189.224.113]:44636 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP id S262921AbTHUWUE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 18:20:04 -0400
Subject: Freeze with HPT370 2.4.22-rc2 and dxr3
From: Soeren Sonnenburg <kernel@nn7.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1061504310.1189.21.camel@localhost>
Mime-Version: 1.0
Date: 22 Aug 2003 00:18:30 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

When I play a movie through the dxr3 (driver form dxr3.sf.net) it used
to work just fine for quite a long time. 
However now that I use a software raid (one via ide on asus a7v8x and 2
hpt370) I can reproducably get the system to freeze when I mplayer -vo
dxr3 <file_on_sw_raid> after less than 10 minutes.

Then the IDE lid is continuously on until I reset the machine.

I found out that when I copy the file to a ram disk and then play it
through dxr3 it works just fine (no freeze). This happens even when I
boot with init=/bin/sh (so no nvidia or other binary only modules).

Any ideas on what to try out ?

Thanks,
Soeren.

dmesg output (unfortunately the beginning does not fit 
hdk: host protected area => 1
hdk: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=9964/255/63,
UDMA(100)
hdc: attached ide-scsi driver.
hdd: attached ide-scsi driver.
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 >
 /dev/ide/host2/bus0/target0/lun0: [PTBL] [9964/255/63] p1
 /dev/ide/host2/bus0/target1/lun0: p1
 /dev/ide/host2/bus1/target0/lun0: p1 p2 < p5 p6 p7 >
 /dev/ide/host4/bus0/target0/lun0: p1
 /dev/ide/host4/bus1/target0/lun0: p1
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: _NEC      Model: DVD+RW ND-1100A   Rev: 1.A0
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: PIONEER   Model: DVD-ROM DVD-105F  Rev: 1.22
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 1, lun 0
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sr1: scsi3-mmc drive: 16x/40x cd/rw xa/form2 cdda tray
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  1524.800 MB/sec
   32regs    :  1082.800 MB/sec
   pIII_sse  :   815.200 MB/sec
   pII_mmx   :  2343.600 MB/sec
   p5_mmx    :  3006.400 MB/sec
raid5: using function: pIII_sse (815.200 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
 [events: 0000006a]
 [events: 0000006a]
 [events: 000001a4]
 [events: 000001a4]
 [events: 0000006a]
 [events: 0000006a]
 [events: 000001a4]
 [events: 000001a4]
 [events: 000001a4]
md: autorun ...
md: considering ide/host4/bus1/target0/lun0/part1 ...
md:  adding ide/host4/bus1/target0/lun0/part1 ...
md:  adding ide/host4/bus0/target0/lun0/part1 ...
md:  adding ide/host2/bus1/target0/lun0/part7 ...
md:  adding ide/host2/bus0/target0/lun0/part1 ...
md:  adding ide/host0/bus0/target0/lun0/part7 ...
md: created md1
md: bind<ide/host0/bus0/target0/lun0/part7,1>
md: bind<ide/host2/bus0/target0/lun0/part1,2>
md: bind<ide/host2/bus1/target0/lun0/part7,3>
md: bind<ide/host4/bus0/target0/lun0/part1,4>
md: bind<ide/host4/bus1/target0/lun0/part1,5>
md: running:
<ide/host4/bus1/target0/lun0/part1><ide/host4/bus0/target0/lun0/part1><ide/host2/bus1/target0/lun0/part7><ide/host2/bus0/target0/lun0/part1><ide/host0/bus0/target0/lun0/part7>
md: ide/host4/bus1/target0/lun0/part1's event counter: 000001a4
md: ide/host4/bus0/target0/lun0/part1's event counter: 000001a4
md: ide/host2/bus1/target0/lun0/part7's event counter: 000001a4
md: ide/host2/bus0/target0/lun0/part1's event counter: 000001a4
md: ide/host0/bus0/target0/lun0/part7's event counter: 000001a4
md: md1: raid array is not clean -- starting background reconstruction
md1: max total readahead window set to 992k
md1: 4 data-disks, max readahead per data-disk: 248k
raid5: device ide/host4/bus1/target0/lun0/part1 operational as raid disk
3
raid5: device ide/host4/bus0/target0/lun0/part1 operational as raid disk
4
raid5: device ide/host2/bus1/target0/lun0/part7 operational as raid disk
0
raid5: device ide/host2/bus0/target0/lun0/part1 operational as raid disk
2
raid5: device ide/host0/bus0/target0/lun0/part7 operational as raid disk
1
raid5: allocated 5376kB for md1
raid5: raid level 5 set md1 active with 5 out of 5 devices, algorithm 2
raid5: raid set md1 not clean; reconstructing parity
RAID5 conf printout:
 --- rd:5 wd:5 fd:0
 disk 0, s:0, o:1, n:0 rd:0 us:1 dev:ide/host2/bus1/target0/lun0/part7
 disk 1, s:0, o:1, n:1 rd:1 us:1 dev:ide/host0/bus0/target0/lun0/part7
 disk 2, s:0, o:1, n:2 rd:2 us:1 dev:ide/host2/bus0/target0/lun0/part1
 disk 3, s:0, o:1, n:3 rd:3 us:1 dev:ide/host4/bus1/target0/lun0/part1
 disk 4, s:0, o:1, n:4 rd:4 us:1 dev:ide/host4/bus0/target0/lun0/part1
RAID5 conf printout:
 --- rd:5 wd:5 fd:0
 disk 0, s:0, o:1, n:0 rd:0 us:1 dev:ide/host2/bus1/target0/lun0/part7
 disk 1, s:0, o:1, n:1 rd:1 us:1 dev:ide/host0/bus0/target0/lun0/part7
 disk 2, s:0, o:1, n:2 rd:2 us:1 dev:ide/host2/bus0/target0/lun0/part1
 disk 3, s:0, o:1, n:3 rd:3 us:1 dev:ide/host4/bus1/target0/lun0/part1
 disk 4, s:0, o:1, n:4 rd:4 us:1 dev:ide/host4/bus0/target0/lun0/part1
md: updating md1 RAID superblock on device
md: ide/host4/bus1/target0/lun0/part1 [events: 000001a5]<6>(write)
ide/host4/bus1/target0/lun0/part1's sb offset: 80035712
md: syncing RAID array md1
md: minimum _guaranteed_ reconstruction speed: 100 KB/sec/disc.
md: using maximum available idle IO bandwith (but not more than 100000
KB/sec) for reconstruction.
md: using 124k window, over a total of 80035712 blocks.
md: ide/host4/bus0/target0/lun0/part1 [events: 000001a5]<6>(write)
ide/host4/bus0/target0/lun0/part1's sb offset: 80043136
md: ide/host2/bus1/target0/lun0/part7 [events: 000001a5]<6>(write)
ide/host2/bus1/target0/lun0/part7's sb offset: 80035712
md: ide/host2/bus0/target0/lun0/part1 [events: 000001a5]<6>(write)
ide/host2/bus0/target0/lun0/part1's sb offset: 80035712
md: ide/host0/bus0/target0/lun0/part7 [events: 000001a5]<6>(write)
ide/host0/bus0/target0/lun0/part7's sb offset: 80035712
md: considering ide/host2/bus1/target0/lun0/part6 ...
md:  adding ide/host2/bus1/target0/lun0/part6 ...
md:  adding ide/host0/bus0/target0/lun0/part6 ...
md: created md2
md: bind<ide/host0/bus0/target0/lun0/part6,1>
md: bind<ide/host2/bus1/target0/lun0/part6,2>
md: running:
<ide/host2/bus1/target0/lun0/part6><ide/host0/bus0/target0/lun0/part6>
md: ide/host2/bus1/target0/lun0/part6's event counter: 0000006a
md: ide/host0/bus0/target0/lun0/part6's event counter: 0000006a
md2: max total readahead window set to 512k
md2: 2 data-disks, max readahead per data-disk: 256k
raid0: looking at ide/host0/bus0/target0/lun0/part6
raid0:   comparing ide/host0/bus0/target0/lun0/part6(94606656) with
ide/host0/bus0/target0/lun0/part6(94606656)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at ide/host2/bus1/target0/lun0/part6
raid0:   comparing ide/host2/bus1/target0/lun0/part6(94606656) with
ide/host0/bus0/target0/lun0/part6(94606656)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: zone 0
raid0: checking ide/host0/bus0/target0/lun0/part6 ... contained as
device 0
  (94606656) is smallest!.
raid0: checking ide/host2/bus1/target0/lun0/part6 ... contained as
device 1
raid0: zone->nb_dev: 2, size: 189213312
raid0: current zone offset: 94606656
raid0: done.
raid0 : md_size is 189213312 blocks.
raid0 : conf->smallest->size is 189213312 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: updating md2 RAID superblock on device
md: ide/host2/bus1/target0/lun0/part6 [events: 0000006b]<6>(write)
ide/host2/bus1/target0/lun0/part6's sb offset: 94606656
md: ide/host0/bus0/target0/lun0/part6 [events: 0000006b]<6>(write)
ide/host0/bus0/target0/lun0/part6's sb offset: 94606656
md: considering ide/host2/bus1/target0/lun0/part1 ...
md:  adding ide/host2/bus1/target0/lun0/part1 ...
md:  adding ide/host0/bus0/target0/lun0/part1 ...
md: created md0
md: bind<ide/host0/bus0/target0/lun0/part1,1>
md: bind<ide/host2/bus1/target0/lun0/part1,2>
md: running:
<ide/host2/bus1/target0/lun0/part1><ide/host0/bus0/target0/lun0/part1>
md: ide/host2/bus1/target0/lun0/part1's event counter: 0000006a
md: ide/host0/bus0/target0/lun0/part1's event counter: 0000006a
md: md0: raid array is not clean -- starting background reconstruction
md: RAID level 1 does not need chunksize! Continuing anyway.
md0: max total readahead window set to 124k
md0: 1 data-disks, max readahead per data-disk: 124k
raid1: device ide/host2/bus1/target0/lun0/part1 operational as mirror 1
raid1: device ide/host0/bus0/target0/lun0/part1 operational as mirror 0
raid1: raid set md0 not clean; reconstructing mirrors
raid1: raid set md0 active with 2 out of 2 mirrors
md: updating md0 RAID superblock on device
md: ide/host2/bus1/target0/lun0/part1 [events: 0000006b]<6>(write)
ide/host2/bus1/target0/lun0/part1's sb offset: 104320
md: delaying resync of md0 until md1 has finished resync (they share one
or more physical units)
md: ide/host0/bus0/target0/lun0/part1 [events: 0000006b]<6>(write)
ide/host0/bus0/target0/lun0/part1's sb offset: 104320
md: ... autorun DONE.
ISDN subsystem Rev: 1.1.4.1/1.1.4.1/1.1.4.1/1.1.4.1/1.1.4.1/1.1.4.1
PPP BSD Compression module registered
dss1_divert module successfully installed
CAPI-driver Rev 1.1.4.1: started
capi20: started up with major 68
kcapi: capi20 attached
capi20: Rev 1.1.4.2: started up with major 68 (middleware+capifs)
kcapi: capidrv attached
kcapi: appl 1 up
capidrv: Rev 1.1.4.1: loaded
capifs: Rev 1.1.4.1
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
ip_conntrack version 2.1 (8192 buckets, 65536 max) - 292 bytes per
conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>. 
http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
raid5: switching cache buffer size, 4096 --> 1024
raid5: switching cache buffer size, 1024 --> 512
FAT: bogus logical sector size 1536
md: swapper(pid 1) used obsolete MD ioctl, upgrade your software to use
new ictls.
raid5: switching cache buffer size, 512 --> 1024
raid5: switching cache buffer size, 1024 --> 512
ufs was compiled with read-only support, can't be mounted as read-write
md: swapper(pid 1) used obsolete MD ioctl, upgrade your software to use
new ictls.
UDF-fs DEBUG lowlevel.c:65:udf_get_last_session: CDROMMULTISESSION not
supported: rc=-22
UDF-fs DEBUG super.c:1421:udf_read_super: Multi-session=0
UDF-fs DEBUG super.c:410:udf_vrs: Starting at sector 16 (2048 byte
sectors)
raid5: switching cache buffer size, 512 --> 2048
UDF-fs DEBUG super.c:1157:udf_check_valid: Failed to read byte 32768.
Assuming open disc. Skipping validity check
md: swapper(pid 1) used obsolete MD ioctl, upgrade your software to use
new ictls.
UDF-fs DEBUG misc.c:285:udf_read_tagged: location mismatch block 256,
tag 649 != 256
UDF-fs DEBUG super.c:1211:udf_load_partition: No Anchor block found
UDF-fs: No partition found (1)
raid5: switching cache buffer size, 2048 --> 4096
reiserfs: found format "3.6" with standard journal
reiserfs: checking transaction log (device md(9,1)) ...
for (md(9,1))
md(9,1):Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem).
Mounted devfs on /dev
Freeing unused kernel memory: 144k freed
Adding Swap: 1028120k swap-space (priority 1)
Adding Swap: 1028120k swap-space (priority 1)
LCD device LCD V0.2 init:
  got 3 addresses from 0x278
  Display is 4 Lines with 20 Cols
  Timing is Short: 40, Long: 100
i2c-core.o: i2c core module
i2c-viapro.o version 2.7.0 (20021208)
i2c-viapro.o: Found Via VT8233A/8235 device
i2c-core.o: adapter SMBus Via Pro adapter at e800 registered as adapter
0.
i2c-viapro.o: Via Pro SMBus detected and initialized
i2c-proc.o version 2.6.1 (20010825)
w83781d.o version 2.7.0 (20021208)
i2c-core.o: driver W83781D sensor driver registered.
i2c-core.o: client [W83782D chip] registered to adapter [SMBus Via Pro
adapter at e800](pos. 0).
i2c-core.o: client [W83782D subclient] registered to adapter [SMBus Via
Pro adapter at e800](pos. 1).
i2c-core.o: client [W83782D subclient] registered to adapter [SMBus Via
Pro adapter at e800](pos. 2).
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
reiserfs: found format "3.6" with standard journal
reiserfs: checking transaction log (device md(9,2)) ...
for (md(9,2))
md(9,2):Using r5 hash to sort names
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
ehci_hcd 00:10.3: VIA Technologies, Inc. USB 2.0
ehci_hcd 00:10.3: irq 21, pci mem f8b2e000
usb.c: new USB bus registered, assigned bus number 1
PCI: 00:10.3 PCI cache line size set incorrectly (32 bytes) by BIOS/FW.
PCI: 00:10.3 PCI cache line size corrected to 64.
ehci_hcd 00:10.3: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-19/2.4
hub.c: USB hub found
hub.c: 6 ports detected
usb-uhci.c: $Revision: 1.275 $ time 23:03:49 Aug 21 2003
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0x7000, IRQ 21
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0x6800, IRQ 21
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0x6400, IRQ 21
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 4
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
mice: PS/2 mouse device common for all mice
hub.c: new USB device 00:10.2-2, assigned address 2
usb.c: USB device 2 (vend/prod 0x4f9/0xb) is not claimed by any active
driver.
hub.c: new USB device 00:10.1-2, assigned address 2
usb.c: USB device 2 (vend/prod 0x57c/0x1000) is not claimed by any
active driver.
hub.c: new USB device 00:10.0-2, assigned address 2
usb.c: USB device 2 (vend/prod 0xa5c/0x2000) is not claimed by any
active driver.
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
eth1: RealTek RTL-8029 found at 0xb400, IRQ 19, 00:00:1C:01:2C:63.
b44: eth0: Link is down.
b44: eth0: Link is up at 100 Mbps, full duplex.
b44: eth0: Flow control is on for TX and on for RX.
BlueZ Core ver 2.3 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
BlueZ HCI USB driver ver 2.4 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
usb.c: registered new driver hci_usb
lirc_serial: auto-detected active low receiver
fcusb2: AVM FRITZ!Card USB v2 driver, revision 0.2
fcusb2: (fcusb2 built on Aug 21 2003 at 23:29:47)
fcusb2: Loading...
kcapi: driver fcusb2 attached
usb.c: registered new driver fcusb2
fcusb2: Driver 'fcusb2' attached to stack
kcapi: Controller 1: fritz-usb attached
fcusb2: Loaded.
usb.c: registered new driver usblp
printer.c: usblp0: USB Bidirectional printer dev 2 if 0 alt 0 proto 2
vid 0x04F9 pid 0x000B
printer.c: v0.11: USB Printer Device Class driver
fcusb2: Stack version 3.10-02
kcapi: card 1 "fritz-usb" ready.
kcapi: notify up contr 1
capidrv: controller 1 up
capidrv-1: now up (2 B channels)
capidrv-1: D2 trace enabled
capi: controller 1 up
VIA 82xx soundcard not found or device busy
devfs_register(audio): could not append to parent, err: -17
ALSA seq_oss.c:223: can't register device seq
device eth0 entered promiscuous mode
BlueZ L2CAP ver 2.3 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
devfs_register(bluetooth/rfcomm/0): could not append to parent, err: -17
BlueZ RFCOMM ver 1.0
Copyright (C) 2002 Maxim Krasnyansky <maxk@qualcomm.com>
Copyright (C) 2002 Marcel Holtmann <marcel@holtmann.org>
kcapi: appl 2 up
kcapi: appl 3 up
0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4496 
Wed Jul 16 19:03:09 PDT 2003
Linux video capture interface: v1.00
i2c-algo-bit.o: i2c bit algorithm module
bttv: driver version 0.7.107 loaded
bttv: using 4 buffers with 2080k (8320k total) for capture
bttv: Host bridge is VIA Technologies, Inc. VT8377 [KT400 AGP] Host
Bridge


