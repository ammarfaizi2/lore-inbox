Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267176AbSLEBms>; Wed, 4 Dec 2002 20:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267179AbSLEBms>; Wed, 4 Dec 2002 20:42:48 -0500
Received: from mail.tpgi.com.au ([203.12.160.58]:28058 "EHLO mail2.tpgi.com.au")
	by vger.kernel.org with ESMTP id <S267176AbSLEBmh>;
	Wed, 4 Dec 2002 20:42:37 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Brendon Higgins <bh_doc@users.sourceforge.net>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: dvd-drive no longer works (2.4.20)
Date: Thu, 5 Dec 2002 11:51:32 +1000
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200212051151.59330.bh_doc@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello. I have a problem since upgrading linux from 2.4.19 to 2.4.20. During 
boot, the kernel spits out several "status error" and other messages about my 
dvd and cdrw drives (both on ide1).

I upgraded from 2.4.19 to 2.4.20 in the hope that DMA would finally work with 
my vt8235 (MSI KT3 Ultra2 with VIA KT333). It seems fine with the two HDs on 
ide0 (big performance difference says hdparm -t when DMA is on), however it 
fails to work with my dvd drive. My cdrw drive, also on ide1, has some error 
messages too, though fewer, and it seems to work regardless. The dvd drive 
cannot be accessed; when trying to mount it it complains of an "unknown 
device". During boot something loads ide-scsi (Despite my best efforts I've 
not been able to stop it...), though when those modules are unloaded 
afterwards, and ide-cd is loaded in its place modprobe freezes while dmesg 
gradually fills up with "lost interrupt" messages from the dvd drive (hdc). 
DMA does not seem to be the cause as it makes no difference with DMA turned 
on or off.

Can anyone help?
Thank you.
Brendon Higgins

Data follows:

"mount -t iso9660 /dev/hdc /mnt" says:
mount: /dev/hdc: unknown device

dmesg boot stuff from /var/log/dmesg (cd error stuff is near the end):
    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 001 01  0    0    0   0   0    1    1    71
 0e 001 01  0    0    0   0   0    1    1    79
 0f 001 01  0    0    0   0   0    1    1    81
 10 001 01  1    1    0   1   0    1    1    89
 11 001 01  1    1    0   1   0    1    1    91
 12 001 01  1    1    0   1   0    1    1    99
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 001 01  1    1    0   1   0    1    1    A1
 16 001 01  1    1    0   1   0    1    1    A9
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ21 -> 0:21
IRQ22 -> 0:22
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1600.0852 MHz.
..... host bus clock speed is 266.6808 MHz.
cpu: 0, clocks: 2666808, slice: 1333404
CPU0<T0:2666800,T1:1333392,D:4,S:1333404,C:2666808>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfdaf1, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router default [1106/3177] at 00:11.0
PCI->APIC IRQ transform: (B0,I7,P0) -> 18
PCI->APIC IRQ transform: (B0,I10,P0) -> 17
PCI->APIC IRQ transform: (B0,I16,P0) -> 21
PCI->APIC IRQ transform: (B0,I16,P1) -> 21
PCI->APIC IRQ transform: (B0,I16,P2) -> 21
PCI->APIC IRQ transform: (B0,I16,P3) -> 21
PCI->APIC IRQ transform: (B0,I17,P0) -> 16
PCI->APIC IRQ transform: (B0,I17,P2) -> 22
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
PCI: Via IRQ fixup for 00:10.2, from 10 to 5
PCI: Via IRQ fixup for 00:10.1, from 12 to 5
PCI: Via IRQ fixup for 00:10.0, from 11 to 5
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 89
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
hda: ST340016A, ATA DISK drive
hdb: ST310232A, ATA DISK drive
hdc: HITACHI DVD-ROM GD-2500, ATAPI CD/DVD-ROM drive
hdd: CREATIVE CD-RW RW8433E, ATAPI CD/DVD-ROM drive
hdd: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hdd: set_drive_speed_status: error=0x04
ide1: Drive 1 didn't accept speed setting. Oh, well.
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=4865/255/63
hdb: 20005650 sectors (10243 MB) w/512KiB Cache, CHS=1245/255/63
Partition check:
 hda: hda1 hda3
 hdb: hdb1
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 1052 blocks [1 disk] into ram disk... done.
Freeing initrd memory: 1052k freed
VFS: Mounted root (cramfs filesystem).
Freeing unused kernel memory: 80k freed
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Adding Swap: 1052216k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,3), internal journal
Real Time Clock Driver v1.10e
ide-floppy driver 0.99.newide
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
eth0: RealTek RTL-8029 found at 0xec00, IRQ 17, 00:00:21:CC:94:D6.
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 10:17:10 Dec  5 2002
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0xe800, IRQ 21
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
usb.c: kmalloc IF cf47c180, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB UHCI Root Hub
SerialNumber: e800
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface cf47c180
usb.c: kusbd: /sbin/hotplug add 1
usb-uhci.c: USB UHCI at I/O 0xe400, IRQ 21
usb-uhci.c: Detected 2 ports
hub.c: port 1, portstatus 100, change 3, 12 Mb/s
hub.c: port 1 connection change
hub.c: port 1, portstatus 100, change 3, 12 Mb/s
hub.c: port 2, portstatus 300, change 3, 1.5 Mb/s
hub.c: port 2 connection change
hub.c: port 2, portstatus 300, change 3, 1.5 Mb/s
hub.c: port 1, portstatus 100, change 2, 12 Mb/s
hub.c: port 1 enable change, status 100
hub.c: port 2, portstatus 300, change 2, 1.5 Mb/s
hub.c: port 2 enable change, status 300
usb.c: new USB bus registered, assigned bus number 2
usb.c: kmalloc IF cf47c380, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB UHCI Root Hub
SerialNumber: e400
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface cf47c380
usb.c: kusbd: /sbin/hotplug add 1
usb-uhci.c: USB UHCI at I/O 0xe000, IRQ 21
usb-uhci.c: Detected 2 ports
hub.c: port 1, portstatus 100, change 3, 12 Mb/s
hub.c: port 1 connection change
hub.c: port 1, portstatus 100, change 3, 12 Mb/s
hub.c: port 2, portstatus 301, change 3, 1.5 Mb/s
hub.c: port 2 connection change
hub.c: port 2, portstatus 301, change 3, 1.5 Mb/s
usb.c: new USB bus registered, assigned bus number 3
usb.c: kmalloc IF cf47c580, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB UHCI Root Hub
SerialNumber: e000
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface cf47c580
usb.c: kusbd: /sbin/hotplug add 1
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
hub.c: port 2, portstatus 301, change 2, 1.5 Mb/s
usb.c: registered new driver usblp
printer.c: v0.11: USB Printer Device Class driver
Linux video capture interface: v1.00
i2c-core.o: i2c core module
hub.c: port 2, portstatus 301, change 2, 1.5 Mb/s
i2c-isa.o version 2.6.5 (20020915)
i2c-core.o: adapter ISA main adapter registered as adapter 0.
i2c-isa.o: ISA bus access for i2c modules initialized.
i2c-proc.o version 2.6.1 (20010825)
w83781d.o version 2.6.5 (20020915)
i2c-core.o: driver W83781D sensor driver registered.
i2c-core.o: client [W83697HF chip] registered to adapter [ISA main 
adapter](pos. 0).
hub.c: port 2, portstatus 301, change 2, 1.5 Mb/s
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
hub.c: port 2, portstatus 301, change 2, 1.5 Mb/s
hub.c: port 2, portstatus 303, change 0, 1.5 Mb/s
hub.c: new USB device 00:10.1-2, assigned address 2
usb.c: kmalloc IF cf47cb00, numif 1
usb.c: skipped 1 class/vendor specific interface descriptors
usb.c: new device strings: Mfr=1, Product=2, SerialNumber=0
usb.c: USB device number 2 default language ID 0x409
Manufacturer: Microsoft
Product: Microsoft SideWinder Precision Pro (USB)
usb-uhci.c: interrupt, status 3, frame# 673
input0: USB HID v1.00 Joystick [Microsoft Microsoft SideWinder Precision Pro 
(USB)] on usb2:2.0
usb.c: hid driver claimed interface cf47cb00
usb.c: kusbd: /sbin/hotplug add 2
hub.c: port 1, portstatus 301, change 3, 1.5 Mb/s
hub.c: port 1 connection change
hub.c: port 1, portstatus 301, change 3, 1.5 Mb/s
hub.c: port 1, portstatus 301, change 2, 1.5 Mb/s
hub.c: port 1, portstatus 301, change 2, 1.5 Mb/s
hub.c: port 1, portstatus 301, change 2, 1.5 Mb/s
hub.c: port 1, portstatus 301, change 2, 1.5 Mb/s
hub.c: port 1, portstatus 303, change 0, 1.5 Mb/s
hub.c: new USB device 00:10.0-1, assigned address 2
usb.c: kmalloc IF cf47cd80, numif 1
usb.c: skipped 1 class/vendor specific interface descriptors
usb.c: new device strings: Mfr=1, Product=2, SerialNumber=0
usb.c: USB device number 2 default language ID 0x409
Manufacturer: Logitech
Product: USB Mouse
usb-uhci.c: ENXIO 84000280, flags 0, urb cfe7b4c0, burb cfe7b3c0
usb-uhci.c: ENXIO 84000280, flags 0, urb cfe7b4c0, burb cfe7b3c0
usb-uhci.c: ENXIO 84000280, flags 0, urb cfe7b4c0, burb cfe7b3c0
usb-uhci.c: ENXIO 84000280, flags 0, urb cfe7b4c0, burb cfe7b3c0
input1: USB HID v1.10 Mouse [Logitech USB Mouse] on usb3:2.0
usb.c: hid driver claimed interface cf47cd80
usb.c: kusbd: /sbin/hotplug add 2
hub.c: port 2, portstatus 101, change 3, 12 Mb/s
hub.c: port 2 connection change
hub.c: port 2, portstatus 101, change 3, 12 Mb/s
hub.c: port 2, portstatus 101, change 2, 12 Mb/s
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI 
enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
hub.c: port 2, portstatus 101, change 2, 12 Mb/s
hub.c: port 2, portstatus 101, change 2, 12 Mb/s
hub.c: port 2, portstatus 101, change 2, 12 Mb/s
hub.c: port 2, portstatus 103, change 0, 12 Mb/s
hub.c: new USB device 00:10.0-2, assigned address 3
usb.c: kmalloc IF cef721c0, numif 1
usb.c: new device strings: Mfr=1, Product=2, SerialNumber=0
usb.c: USB device number 3 default language ID 0x409
Manufacturer: Lexmark
Product: Inkjet color printer
usb.c: ignoring set_interface for dev 3, iface 0, alt 0
printer.c: usblp0: USB Bidirectional printer dev 3 if 0 alt 0 proto 2 vid 
0x043D pid 0x0021
usb.c: usblp driver claimed interface cef721c0
usb.c: kusbd: /sbin/hotplug add 3
hub.c: port 1, portstatus 303, change 0, 1.5 Mb/s
hub.c: port 2, portstatus 103, change 0, 12 Mb/s
hub.c: port 1, portstatus 100, change 2, 12 Mb/s
hub.c: port 1 enable change, status 100
hub.c: port 2, portstatus 303, change 0, 1.5 Mb/s
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
hdc: status error: status=0x7f { DriveReady DeviceFault SeekComplete 
DataRequest CorrectedError Index Error }
hdc: status error: error=0x7f
hdc: drive not ready for command
hdc: ATAPI reset complete
hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdc: drive not ready for command
hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdc: drive not ready for command
hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdc: drive not ready for command
ide-scsi: (IO,CoD) != (0,1) while issuing a packet command
hdc: ATAPI reset complete
hdc: status error: status=0x08 { DataRequest }
hdc: drive not ready for command
hdc: ATAPI reset complete
hdc: status error: status=0x08 { DataRequest }
scsi0 channel 0 : resetting for second half of retries.
SCSI bus is being reset for host 0 channel 0.
hdc: drive not ready for command
hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdc: drive not ready for command
ide-scsi: (IO,CoD) != (0,1) while issuing a packet command
hdc: ATAPI reset complete
hdc: status error: status=0x08 { DataRequest }
hdc: drive not ready for command
hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdc: drive not ready for command
ide-scsi: (IO,CoD) != (0,1) while issuing a packet command
hdc: ATAPI reset complete
hdc: status error: status=0x08 { DataRequest }
hdc: drive not ready for command
hdc: ATAPI reset complete
hdc: status error: status=0x08 { DataRequest }
hdc: drive not ready for command
ide-scsi: (IO,CoD) != (0,1) while issuing a packet command
hdc: ATAPI reset complete
hdc: status error: status=0x08 { DataRequest }
hdc: drive not ready for command
hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdc: drive not ready for command
ide-scsi: (IO,CoD) != (0,1) while issuing a packet command
hdc: ATAPI reset complete
hdc: status error: status=0x08 { DataRequest }
hdc: drive not ready for command
hdc: ATAPI reset complete
hdc: status error: status=0x08 { DataRequest }
hdc: drive not ready for command
ide-scsi: (IO,CoD) != (0,1) while issuing a packet command
hdc: ATAPI reset complete
hdc: status error: status=0x08 { DataRequest }
hdc: drive not ready for command
ide-scsi: (IO,CoD) != (0,1) while issuing a packet command
hdc: ATAPI reset complete
hdc: status error: status=0x08 { DataRequest }
hdc: drive not ready for command
hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdc: drive not ready for command
ide-scsi: (IO,CoD) != (0,1) while issuing a packet command
hdc: ATAPI reset complete
hdc: status error: status=0x08 { DataRequest }
hdc: drive not ready for command
hdc: ATAPI reset complete
hdc: status error: status=0x08 { DataRequest }
hdc: drive not ready for command
ide-scsi: (IO,CoD) != (0,1) while issuing a packet command
hdc: ATAPI reset complete
hdc: status error: status=0x08 { DataRequest }
hdc: drive not ready for command
hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdc: drive not ready for command
ide-scsi: (IO,CoD) != (0,1) while issuing a packet command
hdc: ATAPI reset complete
hdc: status error: status=0x08 { DataRequest }
hdc: drive not ready for command
hdc: ATAPI reset complete
hdc: status error: status=0x08 { DataRequest }
hdc: drive not ready for command
  Vendor: CREATIVE  Model: CD-RW  RW8433E    Rev: 1R04
  Type:   CD-ROM                             ANSI SCSI revision: 02


"ver_linux" says:
Linux phi 2.4.20 #1 Thu Dec 5 10:15:04 EST 2002 i686 unknown unknown GNU/Linux

Gnu C                  2.95.4
Gnu make               3.80
util-linux             2.11x
mount                  2.11x
modutils               2.4.21
e2fsprogs              1.32
PPP                    2.4.1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.0
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.3
Modules Loaded         ide-cd cdrom bsd_comp ppp_async agpgart NVdriver 
sidewinder gameport em8300 i2c-algo-bit adv717x snd-seq-oss 
snd-seq-midi-event snd-seq snd-pcm-oss snd-mixer-oss snd-via82xx snd-pcm 
snd-timer snd-mpu401-uart snd-rawmidi snd-seq-device snd-ac97-codec snd 
soundcore joydev serial mousedev hid input w83781d i2c-proc i2c-isa i2c-core 
videodev printer usb-uhci usbcore apm ppp_deflate zlib_deflate ppp_generic 
slhc ne2k-pci 8390 vfat fat ide-floppy rtc ext3 jbd unix

(It says ide-cd and cdrom now because I removed ide-scsi and scsi_mod and 
modprobed ide-cd, so modprobe is current filling dmesg with "hdc: lost 
interrupt" lines.)

"cat /proc/cpuinfo" says:
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) XP 1900+
stepping        : 2
cpu MHz         : 1600.102
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3191.60

"cat /proc/modules" says:
ide-cd                 27172 (initializing)
cdrom                  28960   0 [ide-cd]
bsd_comp                3992   0 (autoclean)
ppp_async               6592   1 (autoclean)
agpgart                12816   3 (autoclean)
NVdriver             1065312  10 (autoclean)
sidewinder              8388   0 (unused)
gameport                1516   0 [sidewinder]
em8300                 43524   1
i2c-algo-bit            7112   2 [em8300]
adv717x                 3000   0 (unused)
snd-seq-oss            22976   0 (unused)
snd-seq-midi-event      3096   0 [snd-seq-oss]
snd-seq                37744   2 [snd-seq-oss snd-seq-midi-event]
snd-pcm-oss            36836   0
snd-mixer-oss          10680   0 [snd-pcm-oss]
snd-via82xx             7436   0
snd-pcm                55904   0 [snd-pcm-oss snd-via82xx]
snd-timer              10728   0 [snd-seq snd-pcm]
snd-mpu401-uart         2672   0 [snd-via82xx]
snd-rawmidi            12640   0 [snd-mpu401-uart]
snd-seq-device          3872   0 [snd-seq-oss snd-seq snd-rawmidi]
snd-ac97-codec         25156   0 [snd-via82xx]
snd                    23948   0 [snd-seq-oss snd-seq-midi-event snd-seq 
snd-pcm-oss snd-mixer-oss snd-via82xx snd-pcm snd-timer snd-mpu401-uart 
snd-rawmidi snd-seq-device snd-ac97-codec]
soundcore               3524   6 [em8300 snd]
joydev                  6784   0 (unused)
serial                 44100   2 (autoclean)
mousedev                3832   1
hid                    19300   0 (unused)
input                   3328   0 [sidewinder joydev mousedev hid]
w83781d                19256   0 (unused)
i2c-proc                6288   0 [w83781d]
i2c-isa                 1164   0 (unused)
i2c-core               12868   0 [i2c-algo-bit adv717x w83781d i2c-proc 
i2c-isa]
videodev                5568   0 (unused)
printer                 7456   0
usb-uhci               21708   0 (unused)
usbcore                63008   1 [hid printer usb-uhci]
apm                     9224   0 (unused)
ppp_deflate             2968   2
zlib_deflate           17912   0 [ppp_deflate]
ppp_generic            16000   3 [bsd_comp ppp_async ppp_deflate]
slhc                    4672   1 [ppp_generic]
ne2k-pci                5088   1
8390                    6032   0 [ne2k-pci]
vfat                    9548   1
fat                    29816   0 [vfat]
ide-floppy             11936   0
rtc                     5916   0 (autoclean)
ext3                   57376   1 (autoclean)
jbd                    36776   1 (autoclean) [ext3]
unix                   13800 157 (autoclean)

"cat /proc/ioports" says:
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0290-0297 : w83697hf
02f8-02ff : serial(set)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
dc00-dcff : VIA Technologies, Inc. VT8233 AC97 Audio Controller
  dc00-dcff : VIA8233
e000-e01f : VIA Technologies, Inc. USB
  e000-e01f : usb-uhci
e400-e41f : VIA Technologies, Inc. USB (#2)
  e400-e41f : usb-uhci
e800-e81f : VIA Technologies, Inc. USB (#3)
  e800-e81f : usb-uhci
ec00-ec1f : Realtek Semiconductor Co., Ltd. RTL-8029(AS)
  ec00-ec1f : ne2k-pci
fc00-fc0f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
  fc00-fc07 : ide0
  fc08-fc0f : ide1

"cat /proc/iomem" says:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0fffffff : System RAM
  00100000-001c10ac : Kernel code
  001c10ad-00218ea3 : Kernel data
cda00000-ddafffff : PCI Bus #01
  d0000000-d7ffffff : nVidia Corporation NV15 [GeForce2 GTS]
ddc00000-dfcfffff : PCI Bus #01
  de000000-deffffff : nVidia Corporation NV15 [GeForce2 GTS]
dfefff00-dfefffff : VIA Technologies, Inc. USB 2.0
dff00000-dfffffff : Sigma Designs, Inc. REALmagic Hollywood Plus DVD Decoder
e0000000-e7ffffff : VIA Technologies, Inc. VT8367 [KT266]
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved

"lspci -vvv" says:
00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
        Subsystem: VIA Technologies, Inc.: Unknown device 0000
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2,x4
                Command: RQ=0 SBA- AGP+ 64bit- FW- Rate=x4
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP] (prog-if 00 
[Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR+
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: ddc00000-dfcfffff
        Prefetchable memory behind bridge: cda00000-ddafffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 Multimedia controller: Sigma Designs, Inc. REALmagic Hollywood Plus 
DVD Decoder (rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at dff00000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8029(AS)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 17
        Region 0: I/O ports at ec00 [size=32]

00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 
[UHCI])
        Subsystem: VIA Technologies, Inc. USB
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128, cache line size 08
        Interrupt: pin A routed to IRQ 21
        Region 4: I/O ports at e000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 
[UHCI])
        Subsystem: VIA Technologies, Inc. USB
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128, cache line size 08
        Interrupt: pin B routed to IRQ 21
        Region 4: I/O ports at e400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 
[UHCI])
        Subsystem: VIA Technologies, Inc. USB
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128, cache line size 08
        Interrupt: pin C routed to IRQ 21
        Region 4: I/O ports at e800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if 20 
[EHCI])
        Subsystem: VIA Technologies, Inc. USB 2.0
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128, cache line size 08
        Interrupt: pin D routed to IRQ 21
        Region 0: Memory at dfefff00 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
        Subsystem: VIA Technologies, Inc.: Unknown device 0000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 
8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc. Bus Master IDE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 16
        Region 4: I/O ports at fc00 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 Audio 
Controller (rev 50)
        Subsystem: Micro-star International Co Ltd: Unknown device 4720
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 22
        Region 0: I/O ports at dc00 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV15 [GeForce2 GTS] (rev 
a4) (prog-if 00 [VGA])
        Subsystem: Asustek Computer, Inc.: Unknown device 4026
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at de000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at dfcf0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2,x4
                Command: RQ=31 SBA- AGP+ 64bit- FW- Rate=x4

"cat /proc/ide/via" says:
- ----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.35
South Bridge:                       VIA vt8235
Revision:                           ISA 0x0 IDE 0x6
Highest DMA rate:                   UDMA133
BM-DMA base:                        0xfc00
PCI clock:                          33.3MHz
Master Read  Cycle IRDY:            0ws
Master Write Cycle IRDY:            0ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
- -----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:              yes                 yes
Post Write Buffer:            yes                 yes
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   80w                 40w
- -------------------drive0----drive1----drive2----drive3-----
Transfer Mode:        PIO       PIO       PIO       PIO
Address Setup:       30ns      30ns      30ns      30ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns      90ns      90ns      90ns
Data Recovery:       30ns      30ns      30ns      30ns
Cycle Time:         120ns     120ns     120ns     120ns
Transfer Rate:   16.6MB/s  16.6MB/s  16.6MB/s  16.6MB/s

If there's anything else you need, let me know ;-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE97rEtCTfPD0Uw3q8RAiBDAJ93iRUItejbInt9pH+tNoxQ2YxUywCgj9Ov
iVTe9MHn+wj9OmyqPI/HIUw=
=Tfe9
-----END PGP SIGNATURE-----

