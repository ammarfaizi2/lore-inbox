Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318155AbSHDLlr>; Sun, 4 Aug 2002 07:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318158AbSHDLlr>; Sun, 4 Aug 2002 07:41:47 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:39685 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S318155AbSHDLlo>; Sun, 4 Aug 2002 07:41:44 -0400
Message-ID: <32838.192.168.0.100.1028462137.squirrel@mail.zwanebloem.nl>
Date: Sun, 4 Aug 2002 13:55:37 +0200 (CEST)
Subject: 2.4.18 (pre8) strange software raid0 problem
From: "Tommy Faasen" <faasen@xs4all.nl>
To: <neilb@cse.unsw.edu.au>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.7)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_20020804135537_86104"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20020804135537_86104
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,

i ran into a very strange problem.

I booted my system this morning only to discover that I could no longer
mount my /dev/md0. I shut down my system last night without any problems.

The only way I can mount it again is with mdadm --assembly /dev/md0
/dev/sda9 /dev/sdb1 /dev/sdc1
I have to do this every time the system is rebooted.

The distribution is debian unstable
mdadm - v1.0.1 - 20 May 2002
raidstart v0.3d compiled for md raidtools-0.90

Is there any way to permanently fix this error?
How did this happen, as i didn't do anything i can see related to this?

If you need any extra information please let me know.

Tommy



------=_20020804135537_86104
Content-Type: text/plain; name="dmesg.txt"
Content-Disposition: attachment; filename="dmesg.txt"

Linux version 2.4.19-pre8-jp13 (root@it0) (gcc version 2.95.4 20011002 (Debian prerelease)) #2 Fri Jul 5 19:04:05 CEST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=debian-jp root=808 bootfs=ext3 ide0=ata66 hdc=ide-scsi hdd=ide-scsi mem=nopentium
ide_setup: ide0=ata66
ide_setup: hdc=ide-scsi
ide_setup: hdd=ide-scsi
Initializing CPU#0
Detected 1470.050 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2929.45 BogoMIPS
Memory: 514252k/524224k available (1625k kernel code, 9588k reserved, 489k data, 212k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0383f9ff c1cbf9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0383f9ff c1cbf9ff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff c1cbf9ff 00000000 00000000
CPU:             Common caps: 0383f9ff c1cbf9ff 00000000 00000000
CPU: AMD Athlon(tm) XP 1700+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb4a0, last bus=1
PCI: Using configuration type 1
PCI: Probing hardware on bus (00:00)
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
Applying VIA southbridge workaround.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
Starting kswapd
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
PCI: Found IRQ 5 for device 00:0a.0
Real Time Clock Driver v1.10e
Non-volatile memory driver v1.1
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
VP_IDE: ATA-66/100 forced bit set (WARNING)!!
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
hdc: LITE-ON LTR-16101B, ATAPI CD/DVD-ROM drive
hdd: ASUS CD-S500/A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
PCI: Found IRQ 11 for device 00:0b.0
PCI: Sharing IRQ 11 with 00:07.2
PCI: Sharing IRQ 11 with 00:07.3
PCI: Sharing IRQ 11 with 00:0d.0
eth0: OEM i82557/i82558 10/100 Ethernet, 00:08:C7:5A:9F:BB, IRQ 11.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 692290-002, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x24c9f043).
  Receiver lock-up workaround activated.
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected Via Apollo Pro KT133 chipset
agpgart: AGP aperture is 128M @ 0xd0000000
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 11 for device 00:0d.0
PCI: Sharing IRQ 11 with 00:07.2
PCI: Sharing IRQ 11 with 00:07.3
PCI: Sharing IRQ 11 with 00:0b.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.6
        <Adaptec 2940 Ultra2 SCSI adapter>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=5, 32/253 SCBs

  Vendor: IBM       Model: DDYS-T18350N      Rev: S93E
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: IBM       Model: DNES-309170W      Rev: SAH0
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: IBM       Model: DNES-309170W      Rev: SAH0
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
scsi0:A:1:0: Tagged Queuing enabled.  Depth 253
scsi0:A:2:0: Tagged Queuing enabled.  Depth 253
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
Attached scsi disk sdc at scsi0, channel 0, id 2, lun 0
(scsi0:A:0): 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
Partition check:
 sda: sda1 sda2 < sda5 sda6 sda7 sda8 sda9 >
(scsi0:A:1): 40.000MB/s transfers (20.000MHz, offset 31, 16bit)
SCSI device sdb: 17916240 512-byte hdwr sectors (9173 MB)
 sdb: sdb1 sdb2
(scsi0:A:2): 40.000MB/s transfers (20.000MHz, offset 31, 16bit)
SCSI device sdc: 17916240 512-byte hdwr sectors (9173 MB)
 sdc: sdc1 sdc2
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
md: raid0 personality registered as nr 2
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Couldn't find valid RAM disk image starting at 0.
Freeing initrd memory: 820k freed
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 212k freed
Adding Swap: 514072k swap-space (priority 1)
Adding Swap: 514072k swap-space (priority 1)
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on sd(8,8), internal journal
uhci.c: USB Universal Host Controller Interface driver v1.1
PCI: Found IRQ 11 for device 00:07.2
PCI: Sharing IRQ 11 with 00:07.3
PCI: Sharing IRQ 11 with 00:0b.0
PCI: Sharing IRQ 11 with 00:0d.0
uhci.c: USB UHCI at I/O 0xd400, IRQ 11
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 11 for device 00:07.3
PCI: Sharing IRQ 11 with 00:07.2
PCI: Sharing IRQ 11 with 00:0b.0
PCI: Sharing IRQ 11 with 00:0d.0
uhci.c: USB UHCI at I/O 0xd800, IRQ 11
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
mice: PS/2 mouse device common for all mice
usb.c: registered new driver usb_mouse
usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
PCI: Found IRQ 12 for device 00:09.0
hub.c: USB new device connect on bus1/1, assigned device number 2
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: LITE-ON   Model: LTR-16101B        Rev: TS0W
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: ASUS      Model: CD-S500/A         Rev: 1.2D
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi1, channel 0, id 0, lun 0
Attached scsi CD-ROM sr1 at scsi1, channel 0, id 1, lun 0
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sr1: scsi3-mmc drive: 50x/50x cd/rw xa/form2 cdda tray
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
usb_control/bulk_msg: timeout
input0: USB HID v1.00 Joystick [Logitech Inc. WingMan Gamepad] on usb1:2.0
USB Mass Storage support registered.
i2c-core.o: i2c core module version 2.6.3 (20020322)
i2c-isa.o version 2.6.3 (20020322)
i2c-isa.o: ISA bus access for i2c modules initialized.
i2c-proc.o version 2.6.3 (20020322)
via686a.o version 2.6.3 (20020322)
hub.c: USB new device connect on bus1/2, assigned device number 3
reiserfs: checking transaction log (device 08:06) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 08:07) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
read_super_block: bread failed (dev 09:00, block 64, size 1024)
read_super_block: bread failed (dev 09:00, block 8, size 1024)
loop: loaded (max 8 devices)
usb_control/bulk_msg: timeout
input1: USB HID v1.00 Mouse [Logitech Inc. iFeel Mouse   ] on usb1:3.0
parport0: PC-style at 0x378 [PCSPP,EPP]
parport_pc: Via 686A parallel port: io=0x378
lp0: using parport0 (polling).
nvidia: loading NVIDIA NVdriver Kernel Module  1.0-2960  Tue May 14 07:41:42 PDT 2002
NVRM: AGPGART: VIA Apollo KT133 chipset
NVRM: AGPGART: aperture: 128M @ 0xd0000000
NVRM: AGPGART: aperture mapped from 0xd0000000 to 0xe1bde000
NVRM: AGPGART: mode 4x
NVRM: AGPGART: allocated 16 pages
NVRM: AGPGART: freed 16 pages
NVRM: AGPGART: backend released
NVRM: AGPGART: VIA Apollo KT133 chipset
NVRM: AGPGART: aperture: 128M @ 0xd0000000
NVRM: AGPGART: aperture mapped from 0xd0000000 to 0xe1c01000
NVRM: AGPGART: mode 4x
NVRM: AGPGART: allocated 16 pages
 [events: 00000209]
md: bind<sdb1,1>
 [events: 00000209]
md: bind<sdc1,2>
 [events: 00000209]
md: bind<sda9,3>
md: sda9's event counter: 00000209
md: sdc1's event counter: 00000209
md: sdb1's event counter: 00000209
md0: max total readahead window set to 744k
md0: 3 data-disks, max readahead per data-disk: 248k
raid0: looking at sda9
raid0:   comparing sda9(8442048) with sda9(8442048)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at sdb1
raid0:   comparing sdb1(8442048) with sda9(8442048)
raid0:   EQUAL
raid0: looking at sdc1
raid0:   comparing sdc1(8442048) with sda9(8442048)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: zone 0
raid0: checking sda9 ... contained as device 0
  (8442048) is smallest!.
raid0: checking sdb1 ... contained as device 1
raid0: checking sdc1 ... contained as device 2
raid0: zone->nb_dev: 3, size: 25326144
raid0: current zone offset: 8442048
raid0: done.
raid0 : md_size is 25326144 blocks.
raid0 : conf->smallest->size is 25326144 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: updating md0 RAID superblock on device
md: sda9 [events: 0000020a]<6>(write) sda9's sb offset: 8442048
md: sdc1 [events: 0000020a]<6>(write) sdc1's sb offset: 8442048
md: sdb1 [events: 0000020a]<6>(write) sdb1's sb offset: 8442048
 mda: unknown partition table
reiserfs: checking transaction log (device 09:00) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
NVRM: AGPGART: freed 16 pages
NVRM: AGPGART: backend released
NVRM: AGPGART: VIA Apollo KT133 chipset
NVRM: AGPGART: aperture: 128M @ 0xd0000000
NVRM: AGPGART: aperture mapped from 0xd0000000 to 0xe1cbd000
NVRM: AGPGART: mode 4x
NVRM: AGPGART: allocated 16 pages
------=_20020804135537_86104
Content-Type: text/plain; name="mdadm.txt"
Content-Disposition: attachment; filename="mdadm.txt"

/dev/sda9:
          Magic : a92b4efc
        Version : 00.90.00
           UUID : ac8f5bb9:74341e73:b32249ec:42a1d4b2
  Creation Time : Sun Apr  7 14:30:30 2002
     Raid Level : raid0
    Device Size : 8442048 (8.05 GiB 8.69 GB)
   Raid Devices : 3
  Total Devices : 3
Preferred Minor : 0

    Update Time : Sun Aug  4 13:28:45 2002
          State : dirty, no-errors
 Active Devices : 3
Working Devices : 3
 Failed Devices : 0
  Spare Devices : 0
       Checksum : 3a31174e - correct
         Events : 0.522

     Chunk Size : 4K

      Number   Major   Minor   RaidDevice State
this     0       8        9        0      active sync   /dev/sda9
   0     0       8        9        0      active sync   /dev/sda9
   1     1       8       17        1      active sync   /dev/sdb1
   2     2       8       33        2      active sync   /dev/sdc1
/dev/sdb1:
          Magic : a92b4efc
        Version : 00.90.00
           UUID : ac8f5bb9:74341e73:b32249ec:42a1d4b2
  Creation Time : Sun Apr  7 14:30:30 2002
     Raid Level : raid0
    Device Size : 8442048 (8.05 GiB 8.69 GB)
   Raid Devices : 3
  Total Devices : 3
Preferred Minor : 0

    Update Time : Sun Aug  4 13:28:45 2002
          State : dirty, no-errors
 Active Devices : 3
Working Devices : 3
 Failed Devices : 0
  Spare Devices : 0
       Checksum : 3a311758 - correct
         Events : 0.522

     Chunk Size : 4K

      Number   Major   Minor   RaidDevice State
this     1       8       17        1      active sync   /dev/sdb1
   0     0       8        9        0      active sync   /dev/sda9
   1     1       8       17        1      active sync   /dev/sdb1
   2     2       8       33        2      active sync   /dev/sdc1
/dev/sdc1:
          Magic : a92b4efc
        Version : 00.90.00
           UUID : ac8f5bb9:74341e73:b32249ec:42a1d4b2
  Creation Time : Sun Apr  7 14:30:30 2002
     Raid Level : raid0
    Device Size : 8442048 (8.05 GiB 8.69 GB)
   Raid Devices : 3
  Total Devices : 3
Preferred Minor : 0

    Update Time : Sun Aug  4 13:28:45 2002
          State : dirty, no-errors
 Active Devices : 3
Working Devices : 3
 Failed Devices : 0
  Spare Devices : 0
       Checksum : 3a31176a - correct
         Events : 0.522

     Chunk Size : 4K

      Number   Major   Minor   RaidDevice State
this     2       8       33        2      active sync   /dev/sdc1
   0     0       8        9        0      active sync   /dev/sda9
   1     1       8       17        1      active sync   /dev/sdb1
   2     2       8       33        2      active sync   /dev/sdc1

------=_20020804135537_86104--

