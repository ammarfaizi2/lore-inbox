Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267515AbTBDWc7>; Tue, 4 Feb 2003 17:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267524AbTBDWc7>; Tue, 4 Feb 2003 17:32:59 -0500
Received: from impact.colo.mv.net ([199.125.75.20]:27317 "EHLO
	impact.colo.mv.net") by vger.kernel.org with ESMTP
	id <S267515AbTBDWcy>; Tue, 4 Feb 2003 17:32:54 -0500
Message-ID: <3E4041B9.1090809@bogonomicon.net>
Date: Tue, 04 Feb 2003 16:42:01 -0600
From: Bryan Andersen <bryan@bogonomicon.net>
Organization: Bogonomicon
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21pre4-ac2
References: <200302041702.h14H2O112078@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running into hangs on shutdown/reboot.  I've let it set for 5
minutes without it continuing.  It hangs while flushing IDE
devices.  2.4.21-pre4 shutsdown and reboots fine.  I haven't
tried 2.4.pre4-ac1.

Messages on screen before hang:

Unmounting remote file systems... done.
Deconfiguring network interfaces... done.
Deactivating swap... done.
Unmounting local filesystems... done.
rebooting,... md: stopping all md devices.
md: marking sb clean...
[sniped normal md shutdown messages]
md: md1 switched to read-only mode.
flushing ide devices: hda hdb _

"_" is where the cursor is when it hangs.  Full dmesg output from
boot up is below.

I did a test to see if the drive was the issue and removed it.  The 
system still hung.

flushing ide devices: hda hdc hde _


Alan Cox wrote:
 > More IDE updates. Finally switch the IDE layer over to the 
ide_execute_command
 > interface. This should cure problems people have seen for a long time 
with
 > big arrays and shared IRQ. Treat this with care. The other stuff is 
mostly
 > minor fixes and obscure updates, except for the Kahlua audio enabler

Linux version 2.4.21-pre4-ac1 (root@blip) (gcc version 3.2.1 20020924
(Debian prerelease)) #14 SMP Tue Feb 4 15:01:02 CST 2003
BIOS-provided physical RAM map:
   BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
   BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
   BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
   BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
   BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
   BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
   BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
   BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
   BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=Linux ro root=302 ide0=ata66 ide1=ata66
ide_setup: ide0=ata66
ide_setup: ide1=ata66
Found and enabled local APIC!
Initializing CPU#0
Detected 1737.307 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3460.30 BogoMIPS
Memory: 515400k/524224k available (1519k kernel code, 8432k reserved,
579k data, 120k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
CPU0: AMD Athlon(tm) XP 2100+ stepping 02
per-CPU timeslice cutoff: 731.30 usecs.
task migration cache decay timeout: 10 msecs.
SMP motherboard not detected.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1737.2986 MHz.
..... host bus clock speed is 267.2766 MHz.
cpu: 0, clocks: 2672766, slice: 1336383
CPU0<T0:2672752,T1:1336368,D:1,S:1336383,C:2672766>
migration_task 0 on cpu=0
PCI: PCI BIOS revision 2.10 entry at 0xfb560, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Discovered primary peer bus ff [IRQ]
PCI: Using IRQ router default [10de/01e0] at 00:00.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
i2c-core.o: i2c core module
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-proc.o version 2.6.1 (20010825)
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: unsupported bridge
agpgart: no supported devices found.
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE2: IDE controller at PCI slot 00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
      ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
      ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
PDC20269: IDE controller at PCI slot 01:07.0
PDC20269: chipset revision 2
PDC20269: not 100% native mode: will probe irqs later
      ide2: BM-DMA at 0xa000-0xa007, BIOS settings: hde:pio, hdf:pio
      ide3: BM-DMA at 0xa008-0xa00f, BIOS settings: hdg:pio, hdh:pio
hda: C/H/S=22070/16/255 from BIOS ignored
hda: Maxtor 54610H6, ATA DISK drive
hdb: CREATIVE DVD-ROM DVD1241E, ATAPI CD/DVD-ROM drive
blk: queue c0395f60, I/O limit 4095Mb (mask 0xffffffff)
hdc: Maxtor 54610H6, ATA DISK drive
blk: queue c03963d0, I/O limit 4095Mb (mask 0xffffffff)
hde: Maxtor 4G160J8, ATA DISK drive
blk: queue c0396840, I/O limit 4095Mb (mask 0xffffffff)
hdg: Maxtor 4G160J8, ATA DISK drive
blk: queue c0396cb0, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0x9000-0x9007,0x9402 on irq 10
ide3 at 0x9800-0x9807,0x9c02 on irq 10
hda: host protected area => 1
hda: 90045648 sectors (46103 MB) w/2048KiB Cache, CHS=89331/16/63, UDMA(100)
hdc: host protected area => 1
hdc: 90045648 sectors (46103 MB) w/2048KiB Cache, CHS=89331/16/63, UDMA(100)
hde: host protected area => 1
hde: 320173056 sectors (163929 MB) w/2048KiB Cache, CHS=19929/255/63,
UDMA(133)
hdg: host protected area => 1
hdg: 320173056 sectors (163929 MB) w/2048KiB Cache, CHS=19929/255/63,
UDMA(133)
hdb: ATAPI 40X DVD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
   hda: hda1 hda2 hda3 < hda5 hda6 hda7 >
   hdc: hdc1 hdc2 hdc3 < hdc5 hdc6 hdc7 >
   hde: hde1 hde2
   hdg: hdg1 hdg2
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
Linux video capture interface: v1.00
md: raid1 personality registered as nr 3
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 120k freed
Adding Swap: 1999832k swap-space (priority -1)
Adding Swap: 1999832k swap-space (priority -2)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
nvidia: loading NVIDIA Linux x86 NVdriver Kernel Module  1.0-3123  Tue
Aug 27 15:56:48 PDT 2002
PCI: Setting latency timer of device 00:04.0 to 64
Intel 810 + AC97 Audio, version 0.24, 14:35:33 Feb  4 2003
PCI: Setting latency timer of device 00:06.0 to 64
i810: NVIDIA nForce Audio found at IO 0xc800 and 0xc400, MEM 0x0000 and
0x0000, IRQ 11
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
ac97_codec: AC97 Audio codec, id: ALG32 (ALC650)
i810_audio: AC'97 codec 0, new EID value = 0x05c7
i810_audio: AC'97 codec 0, DAC map configured, total channels = 6
PCI: Setting latency timer of device 00:02.0 to 64
usb-ohci.c: USB OHCI at membase 0xe0b11000, IRQ 10
usb-ohci.c: usb-00:02.0, PCI device 10de:0067 (nVidia Corporation)
usb.c: new USB bus registered, assigned bus number 1
usb.c: kmalloc IF defd4e40, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB OHCI Root Hub
SerialNumber: e0b11000
hub.c: USB hub found
hub.c: 3 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RRR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface defd4e40
usb.c: kusbd: /sbin/hotplug add 1
usb.c: kusbd policy returned 0xfffffffe
PCI: Setting latency timer of device 00:02.1 to 64
usb-ohci.c: USB OHCI at membase 0xe0b13000, IRQ 11
usb-ohci.c: usb-00:02.1, PCI device 10de:0067 (nVidia Corporation)
usb.c: new USB bus registered, assigned bus number 2
usb.c: kmalloc IF defd4bc0, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB OHCI Root Hub
SerialNumber: e0b13000
hub.c: USB hub found
hub.c: 3 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RRR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface defd4bc0
usb.c: kusbd: /sbin/hotplug add 1
usb.c: kusbd policy returned 0xfffffffe
   [events: 0000005b]
md: bind<hdc7,1>
   [events: 0000005b]
md: bind<hda7,2>
md: hda7's event counter: 0000005b
md: hdc7's event counter: 0000005b
md: RAID level 1 does not need chunksize! Continuing anyway.
md1: max total readahead window set to 124k
md1: 1 data-disks, max readahead per data-disk: 124k
raid1: device hda7 operational as mirror 0
raid1: device hdc7 operational as mirror 1
raid1: raid set md1 active with 2 out of 2 mirrors
md: updating md1 RAID superblock on device
md: hda7 [events: 0000005c]<6>(write) hda7's sb offset: 28772736
md: hdc7 [events: 0000005c]<6>(write) hdc7's sb offset: 28772736
   [events: 0000002e]
md: bind<hdc6,1>
   [events: 0000002e]
md: bind<hda6,2>
md: hda6's event counter: 0000002e
md: hdc6's event counter: 0000002e
md: RAID level 1 does not need chunksize! Continuing anyway.
md0: max total readahead window set to 124k
md0: 1 data-disks, max readahead per data-disk: 124k
raid1: device hda6 operational as mirror 0
raid1: device hdc6 operational as mirror 1
raid1: raid set md0 active with 2 out of 2 mirrors
md: updating md0 RAID superblock on device
md: hda6 [events: 0000002f]<6>(write) hda6's sb offset: 9999744
md: hdc6 [events: 0000002f]<6>(write) hdc6's sb offset: 9999744
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide1(22,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on md(9,0), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on md(9,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide2(33,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide3(34,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.



