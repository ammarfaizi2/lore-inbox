Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313948AbSDPXVS>; Tue, 16 Apr 2002 19:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313962AbSDPXVR>; Tue, 16 Apr 2002 19:21:17 -0400
Received: from rhenium.btinternet.com ([194.73.73.93]:65220 "EHLO
	rhenium.btinternet.com") by vger.kernel.org with ESMTP
	id <S313948AbSDPXVK>; Tue, 16 Apr 2002 19:21:10 -0400
Content-Type: text/plain; charset=US-ASCII
From: Peter Nikolic <p.nikolic@btinternet.com>
Organization: ds9
To: linux-kernel@vger.kernel.org
Subject: IDE Problems
Date: Wed, 17 Apr 2002 00:20:59 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16xcG3-0002D4-00@rhenium.btinternet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi .

Hope someone can cast some light on this one as it has been bugging me for a 
considerable time now , The Machine is an P III 450 with 192Mb ram , 20Gb 
Seagate Hdd for hda , 8.6Gb Seagate for hdb , Liteon DVD Drive on hdc plus 
various bits on scsi ,sda 4.3Gb IBM  , Tape backup drive.

I am running SuSe 7.3 ,XFree86-4.0.2 , KDE-2.2.2 , Kernel 2.4.19-pre6 , This 
is not something that has only happened since i have been running with the 
2.4.19-pre series kernels it has also been present running the stock kernels 
as supplied with SuSe 7.3 .

Below is the dump of dmesg showing the problems which prevent me doing any 
number of disc read/write tasks i have been trying to reverse a kernel patch 
and getting I/O write errors , Permission denied when trying to delete files  
ect the list goes on .

ssor.
Console: colour dummy device 80x25
Calibrating delay loop... 894.56 BogoMIPS
Memory: 191216k/196596k available (1708k kernel code, 4992k reserved, 643k 
data, 256k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU: Intel Pentium III (Katmai) stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 448.9648 MHz.
..... host bus clock speed is 99.7697 MHz.
cpu: 0, clocks: 997697, slice: 498848
CPU0<T0:997696,T1:498848,D:0,S:498848,C:997697>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfd9b4, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Starting kswapd
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
ACPI: APM is already active, exiting
rivafb: RIVA MTRR set to ON
Console: switching to colour frame buffer device 80x30
rivafb: PCI nVidia NV10 framebuffer ver 0.9.3 (GeForce2-MX, 32MB @ 0xF0000000)
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI 
ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x1008-0x100f, BIOS settings: hdc:DMA, hdd:pio
hda: ST320410A, ATA DISK drive
hdb: ST38641A, ATA DISK drive
hdc: LITEON DVD-ROM LTD163D, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 39102336 sectors (20020 MB) w/2048KiB Cache, CHS=2434/255/63, UDMA(33)
hdb: 16809660 sectors (8607 MB) w/128KiB Cache, CHS=1046/255/63, UDMA(33)
hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3
 hdb: hdb1
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Linux Tulip driver version 0.9.15-pre10 (Mar 8, 2002)
PCI: Enabling device 00:10.0 (0114 -> 0117)
PCI: Found IRQ 9 for device 00:10.0
PCI: Sharing IRQ 9 with 00:07.2
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip0:  MII transceiver #1 config 3000 status 7829 advertising 01e1.
eth0: Digital DS21140 Tulip rev 34 at 0x1080, 00:C0:F0:30:D5:E9, IRQ 9.
SCSI subsystem driver Revision: 1.00
PCI: Enabling device 00:0e.0 (0114 -> 0117)
PCI: Found IRQ 7 for device 00:0e.0
scsi0 : AdvanSys SCSI 3.3G: PCI Ultra: IO 0x1400-0x140F, IRQ 0x7
  Vendor: IBM       Model: DCAS-34330W       Rev: S61A
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: ARCHIVE   Model: Python 25501-XXX  Rev: 2.50
  Type:   Sequential-Access                  ANSI SCSI revision: 02
st: Version 20020205, bufsize 32768, wrt 30720, max init. bufs 4, s/g segs 16
Attached scsi tape st0 at scsi0, channel 0, id 5, lun 0
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 8467200 512-byte hdwr sectors (4335 MB)
 sda: sda1
YM3812 and OPL-3 driver Copyright (C) by Hannu Savolainen, Rob Hooft 1993-1996
PCI: Enabling device 00:0c.0 (0104 -> 0106)
PCI: Found IRQ 10 for device 00:0c.0
ymfpci: YMF740C at 0xe8000000 IRQ 10
ac97_codec: AC97 Audio codec, id: 0x4144:0x5303 (Analog Devices AD1819)
<ymfpci> at 0x330 irq 1 dma 0,0
btaudio: driver version 0.6 loaded [digital+analog]
PCI: Enabling device 00:0d.1 (0104 -> 0106)
PCI: Found IRQ 11 for device 00:0d.1
PCI: Sharing IRQ 11 with 00:0d.0
PCI: Sharing IRQ 11 with 01:00.0
btaudio: Bt878 (rev 17) at 00:0d.1, irq: 11, latency: 64, memory: 0xe800a000
btaudio: registered device dsp1 [digital]
btaudio: registered device dsp2 [analog]
btaudio: registered device mixer1
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 10:39:47 Apr  8 2002
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 9 for device 00:07.2
PCI: Sharing IRQ 9 with 00:10.0
usb-uhci.c: USB UHCI at I/O 0x1020, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usb.c: registered new driver usblp
printer.c: v0.11: USB Printer Device Class driver
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
hub.c: USB new device connect on bus1/2, assigned device number 2
printer.c: Disabling reads from problem bidirectional printer on usblp0
printer.c: usblp0: USB Unidirectional printer dev 2 if 0 alt 1 proto 2 vid 
0x03F0 pid 0x0604
reiserfs: checking transaction log (device 03:03) ...
Using r5 hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 256k freed
Adding Swap: 393584k swap-space (priority 42)
reiserfs: checking transaction log (device 03:01) ...
Using r5 hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 08:01) ...
Using tea hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 03:41) ...
Using r5 hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.25
eth0: Setting half-duplex based on MII#1 link partner capability of 0021.
Linux video capture interface: v1.00
i2c-core.o: i2c core module
i2c-algo-bit.o: i2c bit algorithm module
bttv: driver version 0.7.91 loaded
bttv: using 2 buffers with 2080k (4160k total) for capture
bttv: Host bridge is Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
bttv: Host bridge needs ETBF enabled.
bttv: Bt8xx card found (0).
PCI: Enabling device 00:0d.0 (0104 -> 0106)
PCI: Found IRQ 11 for device 00:0d.0
PCI: Sharing IRQ 11 with 00:0d.1
PCI: Sharing IRQ 11 with 01:00.0
bttv0: Bt878 (rev 17) at 00:0d.0, irq: 11, latency: 132, memory: 0xe8009000
bttv0: detected: Hauppauge WinTV [card=10], PCI subsystem ID is 0070:13eb
bttv0: using: BT878(Hauppauge (bt878)) [card=10,autodetected]
bttv0: enabling ETBF (430FX/VP3 compatibilty)
bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]
i2c-core.o: adapter bt848 #0 registered as adapter 0.
bttv0: Hauppauge eeprom: model=44915, tuner=Philips FM1246 (1), radio=yes
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips: 
tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54 
(PV9
i2c-core.o: driver generic i2c audio driver registered.
i2c-core.o: driver i2c TV tuner driver registered.
tuner: probing bt848 #0 i2c adapter [id=0x10005]
tuner: chip found @ 0xc2
bttv0: i2c attach [client=Philips PAL_I,ok]
i2c-core.o: client [Philips PAL_I] registered to adapter [bt848 #0](pos. 0).
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: registered device radio0
bttv0: PLL: 28636363 => 35468950 ... ok
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=2050682, 
sector=942192
end_request: I/O error, dev 03:03 (hda), sector 942192
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=2050682, 
sector=942192
end_request: I/O error, dev 03:03 (hda), sector 942192
vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data 
of [18 426926 0x0 SD]
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=2050682, 
sector=942192
end_request: I/O error, dev 03:03 (hda), sector 942192
vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data 
of [18 426928 0x0 SD]
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=2050682, 
sector=942192
end_request: I/O error, dev 03:03 (hda), sector 942192
vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data 
of [18 426929 0x0 SD]
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=2051106, 
sector=942616
end_request: I/O error, dev 03:03 (hda), sector 942616
vs-5665: reiserfs_truncate_file: cut_from_item failedhda: dma_intr: 
status=0x51 { DriveReady SeekComple
hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=2051106, 
sector=942616
end_request: I/O error, dev 03:03 (hda), sector 942616
vs-5360: reiserfs_delete_solid_item: could not delete [18 418741 0x0 SD] due 
to fix_nodes failure
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=2051106, 
sector=942616
end_request: I/O error, dev 03:03 (hda), sector 942616
vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data 
of [18 418659 0x0 SD]
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=2051106, 
sector=942616
end_request: I/O error, dev 03:03 (hda), sector 942616
vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data 
of [18 418667 0x0 SD]
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=2051106, 
sector=942616
end_request: I/O error, dev 03:03 (hda), sector 942616
vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data 
of [18 418686 0x0 SD]
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=2051106, 
sector=942616
end_request: I/O error, dev 03:03 (hda), sector 942616
vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data 
of [18 418681 0x0 SD]
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=2051106, 
sector=942616
end_request: I/O error, dev 03:03 (hda), sector 942616
vs-5657: reiserfs_do_truncate: i/o failure occurred trying to truncate [18 
418649 0xffffffff DIRECT]
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=2050682, 
sector=942192
end_request: I/O error, dev 03:03 (hda), sector 942192
vs-5657: reiserfs_do_truncate: i/o failure occurred trying to truncate [18 
426925 0xffffffff DIRECT]
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=2050682, 
sector=942192
end_request: I/O error, dev 03:03 (hda), sector 942192
vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data 
of [18 426932 0x0 SD]
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=2050682, 
sector=942192
end_request: I/O error, dev 03:03 (hda), sector 942192
vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data 
of [18 426929 0x0 SD]
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=2050682, 
sector=942192
end_request: I/O error, dev 03:03 (hda), sector 942192
vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data 
of [18 426926 0x0 SD]
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=2050682, 
sector=942192
end_request: I/O error, dev 03:03 (hda), sector 942192
vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data 
of [18 426928 0x0 SD]
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=2050682, 
sector=942192
end_request: I/O error, dev 03:03 (hda), sector 942192
vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data 
of [18 426930 0x0 SD]
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=2050682, 
sector=942192
end_request: I/O error, dev 03:03 (hda), sector 942192
vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data 
of [18 426931 0x0 SD]
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=2051106, 
sector=942616
end_request: I/O error, dev 03:03 (hda), sector 942616
vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data 
of [18 418678 0x0 SD]
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=2051106, 
sector=942616
end_request: I/O error, dev 03:03 (hda), sector 942616
vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data 
of [18 418675 0x0 SD]
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=2051106, 
sector=942616
end_request: I/O error, dev 03:03 (hda), sector 942616
vs-5665: reiserfs_truncate_file: cut_from_item failedhda: dma_intr: 
status=0x51 { DriveReady SeekComple
hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=2051106, 
sector=942616
end_request: I/O error, dev 03:03 (hda), sector 942616
vs-5360: reiserfs_delete_solid_item: could not delete [18 418756 0x0 SD] due 
to fix_nodes failure
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=2051106, 
sector=942616
end_request: I/O error, dev 03:03 (hda), sector 942616
vs-5665: reiserfs_truncate_file: cut_from_item failedhda: dma_intr: 
status=0x51 { DriveReady SeekComple
hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=2051106, 
sector=942616
end_request: I/O error, dev 03:03 (hda), sector 942616

I have included the complete dump cus i have in the past gotten my ear  
chewed for not including enough info  and i aint into getting unwanted flack 
when all i am after is help.


Thanks  Peter Nikolic.

p.nikolic@btinternet.com
