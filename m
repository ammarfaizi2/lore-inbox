Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265343AbUFRQC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265343AbUFRQC5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 12:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265255AbUFRQB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 12:01:59 -0400
Received: from imap.gmx.net ([213.165.64.20]:61588 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265353AbUFRPxN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 11:53:13 -0400
X-Authenticated: #6991847
Message-ID: <40D30FE4.1070900@gmx.at>
Date: Fri, 18 Jun 2004 17:53:08 +0200
From: Thomas Latzelsberger <tlatzelsberger@gmx.at>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040610
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: webvenza@libero.it, linux-kernel@vger.kernel.org
Subject: limited bandwidth with SiS900 onboard NIC
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear readers,

As mentioned on http://teg.homeunix.org/sis900.html and 
http://www.latzinator.com/acer_aspire_1705SMi.html there is a problem 
with bandwidth for the SiS900 onboard NIC. I allways use vanilla kernels 
and I'm having had this problem from 2.4.22 to 2.4.24 and from 2.6.2 to 
2.6.6.
The symptom is easy to explain. I connect the PC to a 100MBit switch and 
no matter which method of transfer (ftp, scp, samba, nfs) I use, I get a 
maximum transfer rate of less than 400kB/s. By accident I found a dirty 
workaround that might be a hint for some tech savvy hackers: if I force 
the NIC to use halfduplex (allthough it's connected to a switch) it 
works like expected (7-8 MB/s).

The only help I can be is that I can test new kernel drivers and send 
you feedback.

Any help highly appreciated,

Thomas Latzelsberger

FYI:

about the Linux I use:
gentoo with vanilla kernel. no additional kernel patches.

hardware:
Acer Aspire 1705SMi, I run the P4 without HT (thus, no SMP related issue)
lspci:
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 650 Host (rev 80)
00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SiS 530 Virtual 
PCI-to-PCI bridge (AGP)
00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS962 [MuTIOL 
Media IO] (rev 14)
00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
00:02.3 FireWire (IEEE 1394): Silicon Integrated Systems [SiS] FireWire 
Controller
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE]
00:02.6 Modem: Silicon Integrated Systems [SiS] Intel 537 [56k Winmodem] 
(rev a0)
00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] 
Sound Controller (rev a0)
00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 
Controller (rev 0f)
00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 
Controller (rev 0f)
00:03.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 
Controller (rev 0f)
00:03.3 USB Controller: Silicon Integrated Systems [SiS] USB 2.0 Controller
00:04.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 
10/100 Ethernet (rev 91)
00:0a.0 CardBus bridge: O2 Micro, Inc. OZ6912 Cardbus Controller
00:0b.0 Network controller: Harris Semiconductor: Unknown device 3872 
(rev 01)
01:00.0 VGA compatible controller: nVidia Corporation: Unknown device 
031a (rev a1)

uname -a:
Linux latzinator 2.6.6 #1 Mon May 10 14:45:51 CEST 2004 i686 Intel(R) 
Pentium(R) 4 CPU 3.06GHz GenuineIntel GNU/Linux

dmesg:
:
d6a141a7ec3c38dfbd615a1162e1c7ba36b67858
pass
test 5 (64 bit key):
66a0949f8af7d6891f7f832ba833c00c892ebe30143ce28740011ecf
pass
test 6 (32 bit key):
d6a141a7ec3c38dfbd61
pass
test 7 (128 bit key):
697236591b5242b1
pass

testing arc4 ECB encryption across pages (chunking)

testing arc4 ECB decryption
test 1 (64 bit key):
0123456789abcdef
pass
test 2 (64 bit key):
0000000000000000
pass
test 3 (64 bit key):
0000000000000000
pass
test 4 (32 bit key):
0000000000000000000000000000000000000000
pass
test 5 (64 bit key):
123456789abcdef0123456789abcdef0123456789abcdef012345678
pass
test 6 (32 bit key):
00000000000000000000
pass
test 7 (128 bit key):
0123456789abcdef
pass

testing arc4 ECB decryption across pages (chunking)

testing sha384
test 1:
cb00753f45a35e8bb5a03d699ac65007272c32ab0eded1631a8b605a43ff5bed8086072ba1e7cc2358baeca134c825a7
pass
test 2:
3391fdddfc8dc7393707a65b1b4709397cf8b1d162af05abfe8f450de5f36bc6b0455a8520bc4e6f5fe95b1fe3c8452b
pass
test 3:
09330c33f71147e83d192fc782cd1b4753111b173b3b05d22fa08086e3b0f712fcc7c71a557e2db966c3e9fa91746039
pass
test 4:
3d208973ab3508dbbd7e2c2862ba290ad3010e4978c198dc4d8fd014e582823a89e16f9b2a7bbc1ac938e2d199e8bea4
pass
testing sha384 across pages
test 1:
3d208973ab3508dbbd7e2c2862ba290ad3010e4978c198dc4d8fd014e582823a89e16f9b2a7bbc1ac938e2d199e8bea4
pass

testing sha512
test 1:
ddaf35a193617abacc417349ae20413112e6fa4e89a97ea20a9eeee64b55d39a2192992a274fc1a836ba3c23a3feebbd454d4423643ce80e2a9ac94fa54ca49f
pass
test 2:
204a8fc6dda82f0a0ced7beb8e08a41657c16ef468b228a8279be331a703c33596fd15c13b1b07f9aa1d3bea57789ca031ad85c7a71dd70354ec631238ca3445
pass
test 3:
8e959b75dae313da8cf4f72814fc143f8f7779c6eb9f7fa17299aeadb6889018501d289e4900f7e4331b99dec4b5433ac7d329eeb6dd26545e96e55b874be909
pass
test 4:
930d0cefcb30ff1133b6898121f1cf3d27578afcafe8677c5257cf069911f75d8f5831b56ebfda67b278e66dff8b84fe2b2870f742a580d8edb41987232850c9
pass
testing sha512 across pages
test 1:
930d0cefcb30ff1133b6898121f1cf3d27578afcafe8677c5257cf069911f75d8f5831b56ebfda67b278e66dff8b84fe2b2870f742a580d8edb41987232850c9
pass

testing deflate compression
test 1:
f3cacfcc53282d56c8cb2f5748cc4b5128ce482c4a5528c9485528ce4f2b290771bc082b0100
pass (ratio 70:38)
test 2:
5d8d310ec2301004bfb22fc81f10040989c2853f70b12ff824db67d947c1ef49681251ae7667d62719881ade85ab21f2085d161e20042dadf318a215852d69c4428323b66c89719befcf8b9fcf33ca2fed62a94c80ff13af5237ed0e526b5902d94ee87a761d0298fe8a8783a34f568ab89e8e5c57d3a079fa02
pass (ratio 191:122)

testing deflate decompression
test 1:
5468697320646f63756d656e7420646573637269626573206120636f6d7072657373696f6e206d6574686f64206261736564206f6e20746865204445464c415445636f6d7072657373696f6e20616c676f726974686d2e20205468697320646f63756d656e7420646566696e657320746865206170706c69636174696f6e206f6620746865204445464c41544520616c676f726974686d20746f20746865204950205061796c6f616420436f6d7072657373696f6e2050726f746f636f6c2e
pass (ratio 122:191)
test 2:
4a6f696e207573206e6f7720616e642073686172652074686520736f667477617265204a6f696e207573206e6f7720616e642073686172652074686520736f66747761726520
pass (ratio 38:70)

testing crc32c
testing crc32c initialized to 00000000: pass
testing crc32c setkey returns 12345678 : pass
testing crc32c using update/final:
 0e2c157f:OK e980ebf6:OK de74bded:OK d579c862:OK ba979ad0:OK 2b29d913:OK
testing crc32c using incremental accumulator:
 24c5d375:OK
testing crc32c using digest:
 24c5d375:OK
pass
crc32c test complete

testing hmac_md5
test 1:
9294727a3638bb1c13f48ef8158bfc9d
pass
test 2:
750c783e6ab0b503eaa86e310a5db738
pass
test 3:
56be34521d144c88dbb8c733f0e8b3f6
pass
test 4:
697eaf0aca3a3aea3a75164746ffaa79
pass
test 5:
56461ef2342edc00f9bab995690efd4c
pass
test 6:
6b1ab7fe4bd7bf8f0b62e6ce61b9d0cd
pass
test 7:
6f630fad67cda0ee1fb1f562db3aa53e
pass

testing hmac_md5 across pages
test 1:
750c783e6ab0b503eaa86e310a5db738
pass

testing hmac_sha1
test 1:
b617318655057264e28bc0b6fb378c8ef146be00
pass
test 2:
effcdf6ae5eb2fa2d27416d5f184df9c259a7c79
pass
test 3:
125d7342b9ac11cd91a39af48aa17b4f63f175d3
pass
test 4:
4c9007f4026250c6bc8414f9bf50c86c2d7235da
pass
test 5:
4c1a03424b55e07fe7f27be1d58bb9324a9a5a04
pass
test 6:
aa4ae5e15272d00e95705637ce8a3b55ed402112
pass
test 7:
e8e99d0f45237d786d6bbaa7965c7808bbff1a91
pass

testing hmac_sha1 across pages
test 1:
effcdf6ae5eb2fa2d27416d5f184df9c259a7c79
pass

testing hmac_sha256
test 1:
a21b1f5d4cf4f73a4dd939750f7a066a7f98cc131cb16a6692759021cfab8181
pass
test 2:
104fdc1257328f08184ba73131c53caee698e36119421149ea8c712456697d30
pass
test 3:
470305fc7e40fe34d3eeb3e773d95aab73acf0fd060447a5eb4595bf33a9d1a3
pass
test 4:
198a607eb44bfbc69903a0f1cf2bbdc5ba0aa3f3d9ae3c1c7a3b1696a0b68cf7
pass
test 5:
5bdcc146bf60754e6a042426089575c75a003f089d2739839dec58b964ec3843
pass
test 6:
cdcb1220d1ecccea91e53aba3092f962e549fe6ce9ed7fdc43191fbde45c30b0
pass
test 7:
d4633c17f6fb8d744c66dee0f8f074556ec4af55ef07998541468eb49bd2e917
pass
test 8:
7546af01841fc09b1ab9c3749a5f1c17d4f589668a587b2700a9c97c1193cf42
pass
test 9:
6953025ed96f0c09f80a96f78e6538dbe2e7b820e3dd970e7ddd39091b32352f
pass
test 10:
6355ac22e890d0a3c8481a5ca4825bc884d3e7a1ff98a2fc2ac7d8e064c3b2e6
pass

testing hmac_sha256 across pages
test 1:
5bdcc146bf60754e6a042426089575c75a003f089d2739839dec58b964ec3843
pass

testing michael_mic
test 1:
82925c1ca1d130b8
pass
test 2:
434721ca40639b3f
pass
test 3:
e8f9becae97e5d29
pass
test 4:
90038fc6cf13c1db
pass
test 5:
d55e100510128986
pass
test 6:
0a942b124ecaa546
pass
testing michael_mic across pages
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU0] (supports C1)
ACPI: Thermal Zone [THRM] (65 C)
Console: switching to colour frame buffer device 160x64
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
ppdev: user-space parallel port driver
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected SiS 650 chipset
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: unable to determine aperture size.
agpgart: agp_backend_initialize() failed.
agpgart-sis: probe of 0000:00:00.0 failed with error -22
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
PCI: Enabling device 0000:00:02.6 (0000 -> 0001)
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
sis900.c: v1.08.07 11/02/2003
eth0: Unknown PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0x2000, IRQ 19, 00:c0:9f:2f:9d:78.
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
    ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1008-0x100f, BIOS settings: hdc:DMA, hdd:pio
hda: MATSHITADVD-RAM UJ-811, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: ST3120022A, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: max request size: 1024KiB
hdc: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=16383/255/63, 
UDMA(100)
 /dev/ide/host0/bus1/target0/lun0: p1 p2 p3 p4
hda: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
st: Version 20040318, fixed bufsize 32768, s/g segs 256
osst :I: Tape driver with OnStream support version 0.99.1
osst :I: $Id: osst.c,v 1.70 2003/12/23 14:22:12 wriede Exp $
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1203 $ Ben Collins <bcollins@debian.org>
PCI: Enabling device 0000:00:02.3 (0000 -> 0002)
ohci1394: fw-host0: Unexpected PCI resource length of 1000!
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[17]  
MMIO=[e4000000-e40007ff]  Max Packet=[2048]
video1394: Installed video1394 module
ieee1394: raw1394: /dev/raw1394 device initialized
sbp2: $Rev: 1205 $ Ben Collins <bcollins@debian.org>
ip1394: $Rev: 1198 $ Ben Collins <bcollins@debian.org>
ip1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
ieee1394: Loaded AMDTP driver
ieee1394: Loaded CMP driver
pd: pd version 1.05, major 45, cluster 64, nice 0
pda: Autoprobe failed
pd: no valid drive found
pcd: pcd version 1.07, major 46, nice 0
pcd0: Autoprobe failed
pcd: No CD-ROM drive found
pf: pf version 1.04, major 47, cluster 64, nice 0
pf: No ATAPI disk detected
pt: pt version 1.04, major 96
pt0: Autoprobe failed
pt: No ATAPI tape drive detected
pg: pg version 1.02, major 97
pga: Autoprobe failed
pg: No ATAPI device detected
PCI: Enabling device 0000:00:03.3 (0000 -> 0002)
ehci_hcd 0000:00:03.3: Silicon Integrated Systems [SiS] USB 2.0 Controller
ehci_hcd 0000:00:03.3: irq 23, pci mem f9831000
ehci_hcd 0000:00:03.3: new USB bus registered, assigned bus number 1
PCI: cache line size of 128 is not supported by device 0000:00:03.3
ehci_hcd 0000:00:03.3: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:00:03.0: Silicon Integrated Systems [SiS] USB 1.0 Controller
ohci_hcd 0000:00:03.0: irq 20, pci mem f9833000
ohci_hcd 0000:00:03.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ohci_hcd 0000:00:03.1: Silicon Integrated Systems [SiS] USB 1.0 
Controller (#2)
ohci_hcd 0000:00:03.1: irq 21, pci mem f9835000
ohci_hcd 0000:00:03.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ohci_hcd 0000:00:03.2: Silicon Integrated Systems [SiS] USB 1.0 
Controller (#3)
usb 1-3: new high speed USB device using address 2
ohci_hcd 0000:00:03.2: irq 22, pci mem f9837000
ohci_hcd 0000:00:03.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
USB Universal Host Controller Interface driver v2.2
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00c09f000011b431]
usb 3-2: new low speed USB device using address 2
  Vendor: Maxtor    Model: OneTouch          Rev: 0200
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 490232832 512-byte hdwr sectors (250999 MB)
sda: assuming drive cache: write through
 /dev/scsi/host0/bus0/target0/lun0: p1
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
USB Mass Storage device found at 2
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver hiddev
usbcore: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: PC Speaker
drivers/usb/input/hid-core.c: ctrl urb status -32 received
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
Synaptics Touchpad, model: 1
 Firmware: 5.8
 Sensor: 29
 new absolute packet format
 Touchpad has extended capability bits
 -> 4 multi-buttons, i.e. besides standard buttons
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: USB HID v1.10 Keyboard [0566:3002] on usb-0000:00:03.1-2
input: AT Translated Set 2 keyboard on isa0060/serio0
I2O Core - (C) Copyright 1999 Red Hat Software
I2O: Event thread created as pid 168
i2o: Checking for PCI I2O controllers...
I2O configuration manager v 0.04.
  (C) Copyright 1999 Red Hat Software
I2O Block Storage OSM v0.9
   (c) Copyright 1999-2001 Red Hat Software.
i2o_block: Checking for Boot device...
i2o_block: Checking for I2O Block devices...
i2o_scsi.c: Version 0.1.2
  chain_pool: 0 bytes @ f7ba377c
  (512 byte buffers X 4 can_queue X 0 i2o controllers)
i2c /dev entries driver
i2c-sis96x version 1.0.0
drivers/usb/input/hid-core.c: ctrl urb status -32 received
drivers/usb/input/hid-core.c: ctrl urb status -32 received
drivers/usb/input/hid-core.c: ctrl urb status -32 received
sis96x smbus 0000:00:02.1: SiS96x SMBus base address: 0x8100
input,hiddev96: USB HID v1.10 Device [0566:3002] on usb-0000:00:03.1-2
Advanced Linux Sound Architecture Driver Version 1.0.4rc2 (Tue Mar 30 
08:19:30 2004 UTC).
PCI: Enabling device 0000:00:02.7 (0000 -> 0001)
usb 4-2: new low speed USB device using address 2
input: USB HID v1.10 Mouse [B16_b_02 USB-PS/2 Optical Mouse] on 
usb-0000:00:03.2-2
intel8x0_measure_ac97_clock: measured 49545 usecs
intel8x0: clocking to 48000
ALSA device list:
  #0: SiS SI7012 at 0x1c00, irq 18
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
ip_conntrack version 2.1 (7168 buckets, 57344 max) - 296 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  
http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
ACPI: (supports S0 S3 S4 S5)
found reiserfs format "3.6" with standard journal
reiserfs: using ordered data mode
Reiserfs journal params: device hdc4, size 8192, journal first block 18, 
max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hdc4) for (hdc4)
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 212k freed
Adding 1004052k swap on /dev/hdc3.  Priority:-1 extents:1
NTFS volume version 3.1.
ISO 9660 Extensions: Microsoft Joliet Level 1
ISOFS: changing to secondary root
nvidia: module license 'NVIDIA' taints kernel.
0: nvidia: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-5336  Wed 
Jan 14 18:29:26 PST 2004
0: NVRM: AGPGART: unable to retrieve symbol table
drivers/usb/input/hid-input.c: event field not found
drivers/usb/input/hid-input.c: event field not found
drivers/usb/input/hid-input.c: event field not found
drivers/usb/input/hid-input.c: event field not found
no device found
Unable to load NLS charset cp437
ISO 9660 Extensions: Microsoft Joliet Level 3
ISOFS: changing to secondary root
no device found
no device found
no device found
usb 1-3: USB disconnect, address 2
no device found

