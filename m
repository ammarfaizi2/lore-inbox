Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289550AbSAOTHh>; Tue, 15 Jan 2002 14:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289599AbSAOTHU>; Tue, 15 Jan 2002 14:07:20 -0500
Received: from smtp-out1.kaptech.com ([62.106.132.133]:8461 "HELO
	smtp-out.kaptech.net") by vger.kernel.org with SMTP
	id <S289604AbSAOTHE> convert rfc822-to-8bit; Tue, 15 Jan 2002 14:07:04 -0500
User-Agent: Microsoft-Entourage/9.0.2.4011
Date: Tue, 15 Jan 2002 20:06:55 +0100
Subject: aty128fb weirdness
From: Chris Boot <bootc@worldnet.fr>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Message-ID: <B86A3C36.3B3%bootc@worldnet.fr>
Mime-version: 1.0
Content-type: text/plain; charset="ISO-8859-1"
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I only just decided to reinstall Linux on my Apple iMac DV SE/500 with an
ATI Rage Pro 128.  Last time I used Linux on this machine was when kernel
2.4.2 was the latest.  Now, when I try to use the native kernel driver for
my graphics card, all I get is a black screen.  I can type blindly into the
console or login through the network.  I double-checked all my kernel
arguments and didn't find any mistake whatsoever, and enabled the debug code
in the aty128fb driver, all to no avail.  I also tried several kernels,
ranging from the one included with my distro (a patched 2.4.10), 2.4.16,
2.4.17, and 2.4.18-pre3.

Quoted below is a dmesg of a boot using the driver with debug code compiled
in.  This is an iMac whose video modes are 640x480@116, 800x600@95, and
1024x768@75.  Currently, the only way I can get console video is if I force
the kernel to use the OpenFirmware frame buffer, which is locked to
1024x768@75 in 8-bit color mode, and is way slower than what the native
driver could do.

If anyone can figure out what's wrong, I would be forever grateful.

Thanks in advance,
Chris Boot

>>> BEGIN DMESG
Total memory = 256MB; using 1024kB for hash table (at c0300000)
Linux version 2.4.18-pre3 (root@gargantua.bootc.net) (gcc version 2.95.3
20010111 (prerelease/franzo/20010111)) #9 Tue Jan 15 19:04:17 CET 2002
Found Uninorth memory controller & host bridge, revision: 8
Found a Keylargo mac-io controller, rev: 3, mapped at 0xfdebf000
Processor NAP mode on idle enabled.
PowerMac motherboard: iMac FireWire
Found UniNorth PCI host bridge at 0xf0000000. Firmware bus number: 0->0
Found UniNorth PCI host bridge at 0xf2000000. Firmware bus number: 0->0
Found UniNorth PCI host bridge at 0xf4000000. Firmware bus number: 0->0
PMU driver 2 initialized for Core99, firmware: 0c
On node 0 totalpages: 65536
zone(0): 65536 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/hda10 video=aty128fb:1024x768@75,cmode:32
debug
PowerMac using OpenPIC irq controller
OpenPIC Version 1.2 (4 CPUs and 64 IRQ sources) at fc670000
OpenPIC timer frequency is 4.166666 MHz
GMT Delta read from XPRAM: 60 minutes, DST: off
time_init: decrementer frequency = 24.967326 MHz
Console: colour dummy device 80x25
Calibrating delay loop... 996.14 BogoMIPS
Memory: 253876k available (1724k kernel code, 856k data, 252k init, 0k
highmem)
AGP special page: 0xcffff000
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Fixup res 1 (101) of dev 00:10.0: 400 -> 802400
PCI->OF bus map:
0 -> 0
1 -> 0
2 -> 0
PCI:00:10.0: Resource 0: 94000000-97ffffff (f=1208)
PCI:00:10.0: Resource 2: 90000000-90003fff (f=200)
PCI:01:17.0: Resource 0: 80000000-8007ffff (f=200)
PCI:02:0f.0: Resource 0: f5200000-f53fffff (f=200)
PCI:00:10.0: Resource 1: 00802400-008024ff (f=101)
PCI:01:18.0: Resource 0: 80081000-80081fff (f=200)
PCI:01:19.0: Resource 0: 80080000-80080fff (f=200)
PCI:02:0e.0: Resource 0: f5000000-f5000fff (f=200)
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Thermal assist unit using timers, shrink_timer: 200 jiffies
Starting kswapd
Journalled Block Device driver loaded
devfs: v1.7 (20011216) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
PCI: Enabling device 00:10.0 (0086 -> 0087)
aty128fb: Rage128 Pro PR (PCI) [chip rev 0x1] 8M 64-bit SDR SGRAM (2:1)
aty128fb: aty128_var_to_pll post 2 feedback 247 vlck 6500 output 13000
ref_divider 56 vclk_per: 15384
aty128fb: aty128_ddafifo x 12
aty128fb: aty128_ddafifo p: 6 rloop: 10 x: 233 ron: 540 roff: 3d94
aty128fb: aty128_var_to_pll post 2 feedback 247 vlck 6500 output 13000
ref_divider 56 vclk_per: 15384
aty128fb: aty128_ddafifo x 12
aty128fb: aty128_ddafifo p: 6 rloop: 10 x: 233 ron: 540 roff: 3d94
aty128fb: aty128_var_to_pll post 2 feedback 247 vlck 6500 output 13000
ref_divider 56 vclk_per: 15384
aty128fb: aty128_ddafifo x 12
aty128fb: aty128_ddafifo p: 6 rloop: 10 x: 233 ron: 540 roff: 3d94
aty128fb: aty128_reset_engine engine reset<7>aty128fb: aty128_reset_engine
engine reset<7>aty128fb: aty128_var_to_pll post 2 feedback 247 vlck 6500
output 13000 ref_divider 56 vclk_per: 15384
aty128fb: aty128_ddafifo x 12
aty128fb: aty128_ddafifo p: 6 rloop: 10 x: 233 ron: 540 roff: 3d94
aty128fb: aty128_reset_engine engine reset<7>aty128fb: aty128_var_to_pll
post 2 feedback 247 vlck 6500 output 13000 ref_divider 56 vclk_per: 15384
aty128fb: aty128_ddafifo x 12
aty128fb: aty128_ddafifo p: 6 rloop: 10 x: 233 ron: 540 roff: 3d94
aty128fb: aty128_reset_engine engine resetConsole: switching to colour frame
buffer device 128x48
fb0: ATY Rage128 frame buffer device on PCI
pty: 256 Unix98 ptys configured
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
pmac_ide: enabling IDE bus ID 2
pmac_ide: enabling IDE bus ID 0
pmac_ide: enabling IDE bus ID 1
hda: QUANTUM FIREBALLlct15 30, ATA DISK drive
hdb: MATSHITADVD-ROM SR-8184, ATAPI CD/DVD-ROM drive
ide0 at 0xd4a0c000-0xd4a0c007,0xd4a0c160 on irq 19
hda: Enabling Ultra DMA 2
ide_pmac: Set UDMA timing for mode 2, reg: 0x1090038c
hda: 58680720 sectors (30045 MB) w/418KiB Cache, CHS=58215/16/63, (U)DMA
hdb: Enabling MultiWord DMA 2
ide_pmac: MDMA, cycleTime: 120, accessTime: 75, recTime: 45
ide_pmac: Set MDMA timing for mode 2, reg: 0x0001978c
hdb: ATAPI 24X DVD-ROM drive, 512kB Cache, (U)DMA
Uniform CD-ROM driver Revision: 3.12
ide-floppy driver 0.97.sv
Partition check:
 /dev/ide/host0/bus0/target0/lun0: [mac] p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11
p12 p13 p14
loop: loaded (max 8 devices)
eth0: GMAC at 00:30:65:79:f1:88, driver v1.5k4
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
ide-floppy driver 0.97.sv
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
ohci1394: $Revision: 1.80 $ Ben Collins <bcollins@debian.org>
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[40]  MMIO=[f5000000-f5001000]  Max
Packet=[2048]
video1394: Installed video1394 module
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io = 1)
scsi1 : IEEE-1394 SBP-2 protocol driver
Macintosh non-volatile memory driver v1.0
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Enabling device 01:18.0 (0000 -> 0002)
usb-ohci.c: USB OHCI at membase 0xd18eb000, IRQ 27
usb-ohci.c: usb-01:18.0, Apple Computer Inc. KeyLargo USB
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Enabling device 01:19.0 (0000 -> 0002)
usb-ohci.c: USB OHCI at membase 0xd18ed000, IRQ 28
usb-ohci.c: usb-01:19.0, Apple Computer Inc. KeyLargo USB (#2)
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver hid
hid-core.c: v1.8 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
hub.c: USB new device connect on bus1/1, assigned device number 2
hub.c: USB hub found
hub.c: 4 ports detected
hub.c: USB new device connect on bus2/1, assigned device number 2
scsi2 : SCSI emulation for USB Mass Storage devices
  Vendor: IOMEGA    Model: ZIP 100           Rev: 48.X
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi2, channel 0, id 0, lun 0
sda : READ CAPACITY failed.
sda : status = 1, message = 00, host = 0, driver = 08
Current sd00:00: sense key Not Ready
Additional sense indicates Medium not present
sda : block size assumed to be 512 bytes, disk size 1GB.
 /dev/scsi/host2/bus0/target0/lun0: I/O error: dev 08:00, sector 0
 I/O error: dev 08:00, sector 0
 unable to read partition table
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2
hub.c: USB new device connect on bus1/1/2, assigned device number 3
usb.c: USB device 3 (vend/prod 0x43d/0x16) is not claimed by any active
driver.
hub.c: USB new device connect on bus1/1/3, assigned device number 4
hub.c: USB hub found
hub.c: 3 ports detected
hub.c: USB new device connect on bus1/1/4, assigned device number 5
usb.c: USB device 5 (vend/prod 0x79b/0x1) is not claimed by any active
driver.
hub.c: USB new device connect on bus1/1/3/1, assigned device number 6
input0: USB HID v10.01 Keyboard [Mitsumi Electric Apple Extended USB
Keyboard] on usb1:6.0
input1: USB HID v10.01 Pointer [Mitsumi Electric Apple Extended USB
Keyboard] on usb1:6.1
hub.c: Cannot enable port 2 of hub 4, disabling port.
hub.c: Maybe the USB cable is bad?
hub.c: USB new device connect on bus1/1/3/2, assigned device number 7
input2: USB HID v0.01 Mouse [Microsoft Microsoft IntelliMouseÆ Explorer] on
usb1:7.0
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 252k init 8k chrp 8k prep
Device not ready.  Make sure there is a disc in the drive.
VFS: Disk change detected on device 08:00
sda : READ CAPACITY failed.
sda : status = 1, message = 00, host = 0, driver = 08
Current sd00:00: sense key Not Ready
Additional sense indicates Medium not present
sda : block size assumed to be 512 bytes, disk size 1GB.
 /dev/scsi/host2/bus0/target0/lun0: I/O error: dev 08:00, sector 0
 I/O error: dev 08:00, sector 0
Adding Swap: 262136k swap-space (priority -1)
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,10), internal journal
i2c-core.o: i2c core module
dmasound_pmac: Awacs/Screamer Codec Mfct: 1 Rev 3
dmasound_pmac: found Keylargo rev 2 or later - H/W byte-swap disabled
PowerMac Screamer  DMA sound driver rev 016 installed
Core driver edition 01.06 : PowerMac Built-in Sound driver edition 00.06
Write will use    4 fragments of   32768 bytes as default
Read  will use    4 fragments of   32768 bytes as default
eth0: PHY ID: 0x00406212
eth0: Found Broadcom BCM5201 PHY
eth0: Link state change, phy_status: 0x782d
eth0:    Link up ! BCM5201/5221 aux_stat: 0x003e
eth0:    Full Duplex: 0, Speed: 100
>>> END DMESG

-- 
Chris Boot
bootc@mac.com

"Use the source, Luke." - Obi-Wan Gnuobi

