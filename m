Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277949AbRKAEmX>; Wed, 31 Oct 2001 23:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277966AbRKAEmH>; Wed, 31 Oct 2001 23:42:07 -0500
Received: from h24-78-175-24.nv.shawcable.net ([24.78.175.24]:7040 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S277949AbRKAEmC>;
	Wed, 31 Oct 2001 23:42:02 -0500
Date: Wed, 31 Oct 2001 20:42:38 -0800
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Cc: m.schimschak@gmx.de
Subject: Re: [Danger] 2.4.14pre3-pre5: Queueing changes broken? [Re: [2.4.14-pre3] kernel: attempt to access beyond end of device]
Message-ID: <20011031204237.A980@netnation.com>
In-Reply-To: <87pu76fd2l.fsf@hobbes.masch.org> <20011030205858.A571@netnation.com> <20011031081959.A30992@netnation.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <20011031081959.A30992@netnation.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 31, 2001 at 08:19:59AM -0800, Simon Kirby wrote:

> Confirmed that reattaching the hdb drive makes the kernel boot up fine,
> and removing it again makes it blow up.  I left my null modem cable at
> work so I wasn't able to get a serial console log, but I will get one
> tonight.

Okay, attached are some captures.  The first is a serial console capture of
the machine before I took the drive out, and the second is after I
removed it.  It appears to start giving the error right when/before
ide-scsi is loaded (as a module).

I'm compiling pre6 now as well to see if it's any different.

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]

--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="with-hdb.log"

Linux version 2.4.14-pre4 (root@oof) (gcc version 2.95.4 20011006 (Debian prerelease)) #10 SMP Mon Oct 29 21:03:52 PST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fffd000 (usable)
 BIOS-e820: 000000000fffd000 - 000000000ffff000 (ACPI data)
 BIOS-e820: 000000000ffff000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
found SMP MP-table at 000f6e90
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
On node 0 totalpages: 65533
zone(0): 4096 pages.
zone(1): 61437 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #1 Pentium(tm) Pro APIC version 17
Processor #0 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
Kernel command line: auto BOOT_IMAGE=Linux ro root=302 console=ttyS0,115200n8 console=tty0 aic7xxx=verbose,reverse_scan
Initializing CPU#0
Detected 451.034 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 897.84 BogoMIPS
Memory: 255316k/262132k available (1237k kernel code, 6432k reserved, 438k data, 228k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check reporting enabled on CPU#0.
CPU0: Intel Celeron (Mendocino) stepping 00
per-CPU timeslice cutoff: 365.35 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 901.12 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Celeron (Mendocino) stepping 00
Total of 2 processors activated (1798.96 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
..TIMER: vector=0x31 pin1=2 pin2=0
testing the IO APIC.......................

.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 451.0001 MHz.
..... host bus clock speed is 100.2220 MHz.
cpu: 0, clocks: 1002220, slice: 334073
CPU0<T0:1002208,T1:668128,D:7,S:334073,C:1002220>
cpu: 1, clocks: 1002220, slice: 334073
CPU1<T0:1002208,T1:334048,D:14,S:334073,C:1002220>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xf0730, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:04.0
PCI->APIC IRQ transform: (B0,I4,P3) -> 19
PCI->APIC IRQ transform: (B0,I6,P0) -> 19
PCI->APIC IRQ transform: (B0,I9,P0) -> 19
PCI->APIC IRQ transform: (B0,I10,P0) -> 18
PCI->APIC IRQ transform: (B0,I11,P0) -> 17
PCI->APIC IRQ transform: (B0,I12,P0) -> 16
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
i2c-core.o: i2c core module
i2c-algo-bit.o: i2c bit algorithm module
i2c-proc.o version 2.6.1 (20010825)
Detected PS/2 Mouse Port.
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 21
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:DMA
hda: ST360021A, ATA DISK drive
hdb: IBM-DTLA-307045, ATA DISK drive
hdc: Pioneer DVD-ROM ATAPIModel DVD-106S 010, ATAPI CD/DVD-ROM drive
hdd: LITE-ON LTR-24102B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=7297/255/63, UDMA(33)
hdb: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=5606/255/63, UDMA(33)
Partition check:
 hda: hda1 hda2 hda3 hda4
 hdb: hdb1
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected Intel 440BX chipset
agpgart: AGP aperture is 256M @ 0xd0000000
SCSI subsystem driver Revision: 1.00
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
 [events: 0000002c]
md: autorun ...
md: considering hdb1 ...
md:  adding hdb1 ...
md: created md0
md: bind<hdb1,1>
md: running: <hdb1>
md: hdb1's event counter: 0000002c
md: RAID level 1 does not need chunksize! Continuing anyway.
md0: max total readahead window set to 124k
md0: 1 data-disks, max readahead per data-disk: 124k
raid1: device hdb1 operational as mirror 0
raid1: raid set md0 active with 1 out of 1 mirrors
md: updating md0 RAID superblock on device
md: hdb1 [events: 0000002d]<6>(write) hdb1's sb offset: 45030080
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 228k freed
Adding Swap: 265064k swap-space (priority 0)
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: PIONEER   Model: DVD-ROM DVD-106   Rev: 1.08
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: LITE-ON   Model: LTR-24102B        Rev: 5S07
  Type:   CD-ROM                             ANSI SCSI revision: 02
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
        <Adaptec aic7890/91 Ultra2 SCSI adapter>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

  Vendor: YAMAHA    Model: CRW4416S          Rev: 1.0j
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 1, lun 0
Attached scsi CD-ROM sr2 at scsi1, channel 0, id 3, lun 0
sr0: scsi3-mmc drive: 40x/40x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sr1: scsi3-mmc drive: 167x/40x writer cd/rw xa/form2 cdda tray
(scsi1:A:3): 8.333MB/s transfers (8.333MHz, offset 31)
sr2: scsi3-mmc drive: 16x/16x writer cd/rw xa/form2 cdda tray
ip_conntrack (2047 buckets, 16376 max)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.268 $ time 21:11:54 Oct 29 2001
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0xb400, IRQ 19
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.268:USB Universal Host Controller Interface driver
usb.c: registered new driver dc2xx
dc2xx.c: v1.0.0:USB Camera Driver for Kodak DC-2xx series cameras
hub.c: USB new device connect on bus1/2, assigned device number 2
hub.c: USB hub found
hub.c: 4 ports detected
usb.c: registered new driver hid
hid-core.c: v1.8 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
hub.c: USB new device connect on bus1/2/4, assigned device number 3
input0: USB HID v1.10 Mouse [Logitech USB Mouse] on usb1:3.0
Sorry: masquerading timeouts set 5DAYS/2MINS/60SECS
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eth0: OEM i82557/i82558 10/100 Ethernet, 00:90:27:0F:49:4D, IRQ 16.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 697680-002, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  Forcing 100Mbs full-duplex operation.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x24c9f043).
  Receiver lock-up workaround activated.
ne.c:v1.10 9/23/94 Donald Becker (becker@scyld.com)
Last modified Nov 1, 2000 by Paul Gortmaker
NE*000 ethercard probe at 0x300: 00 40 05 2a 3a 7f
eth1: NE2000 found at 0x300, using IRQ 5.
hdc: CHECK for good STATUS
Trident 4DWave/SiS 7018/ALi 5451,Tvia CyberPro 5050 PCI Audio, version 0.14.9d, 21:11:23 Oct 29 2001
trident: Trident 4DWave NX found at IO 0xa800, IRQ 17
ac97_codec: AC97 Audio codec, id: 0x8384:0x7608 (SigmaTel STAC9708)
Linux video capture interface: v1.00
bttv: driver version 0.7.83 loaded
bttv: using 2 buffers with 2080k (4160k total) for capture
bttv: Host bridge is Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
bttv: Host bridge needs ETBF enabled.
bttv: Bt8xx card found (0).
bttv0: Bt848 (rev 18) at 00:0a.0, irq: 18, latency: 32, memory: 0xc5000000
bttv0: using: BT848A(MIRO PCTV pro) [card=11,insmod option]
bttv0: enabling ETBF (430FX/VP3 compatibilty)
i2c-core.o: adapter bt848 #0 registered as adapter 0.
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: miro: id=0 tuner=-795896916 radio=no stereo=no
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
i2c-core.o: driver i2c TV tuner driver registered.
tuner: chip found @ 0xc0
bttv0: i2c attach [client=Philips NTSC,ok]
i2c-core.o: client [Philips NTSC] registered to adapter [bt848 #0](pos. 0).
i2c-core.o: driver i2c msp3400 driver registered.
i2c-core.o: driver tv card mixer driver registered.
tvmixer: debug: Philips NTSC
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips: tda9840,tda9873h,tda9874a,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54 (PV951)
i2c-core.o: driver generic i2c audio driver registered.
usb-uhci.c: interrupt, status 3, frame# 1892
usb-uhci.c: interrupt, status 3, frame# 1684
usb-uhci.c: interrupt, status 3, frame# 460
usb-uhci.c: interrupt, status 3, frame# 1812
usb-uhci.c: interrupt, status 3, frame# 740
usb-uhci.c: interrupt, status 3, frame# 1180
md: recovery thread got woken up ...
md: recovery thread finished ...
hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hdc: drive_cmd: error=0x04
hdd: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hdd: drive_cmd: error=0x04
md: marking sb clean...
md: updating md0 RAID superblock on device
md: hdb1 [events: 0000002e]<6>(write) hdb1's sb offset: 45030080
md: md0 stopped.
md: unbind<hdb1,0>
md: export_rdev(hdb1)
md: stopping all md devices.
Restarting system.

--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="without-hdb.log"

Linux version 2.4.14-pre4 (root@oof) (gcc version 2.95.4 20011006 (Debian prerelease)) #10 SMP Mon Oct 29 21:03:52 PST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fffd000 (usable)
 BIOS-e820: 000000000fffd000 - 000000000ffff000 (ACPI data)
 BIOS-e820: 000000000ffff000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
found SMP MP-table at 000f6e90
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
On node 0 totalpages: 65533
zone(0): 4096 pages.
zone(1): 61437 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #1 Pentium(tm) Pro APIC version 17
Processor #0 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
Kernel command line: auto BOOT_IMAGE=Linux ro root=302 console=ttyS0,115200n8 console=tty0 aic7xxx=verbose,reverse_scan
Initializing CPU#0
Detected 451.031 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 897.84 BogoMIPS
Memory: 255316k/262132k available (1237k kernel code, 6432k reserved, 438k data, 228k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check reporting enabled on CPU#0.
CPU0: Intel Celeron (Mendocino) stepping 00
per-CPU timeslice cutoff: 365.35 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 901.12 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Celeron (Mendocino) stepping 00
Total of 2 processors activated (1798.96 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
..TIMER: vector=0x31 pin1=2 pin2=0
testing the IO APIC.......................

.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 451.0298 MHz.
..... host bus clock speed is 100.2286 MHz.
cpu: 0, clocks: 1002286, slice: 334095
CPU0<T0:1002272,T1:668176,D:1,S:334095,C:1002286>
cpu: 1, clocks: 1002286, slice: 334095
CPU1<T0:1002272,T1:334080,D:2,S:334095,C:1002286>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xf0730, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:04.0
PCI->APIC IRQ transform: (B0,I4,P3) -> 19
PCI->APIC IRQ transform: (B0,I6,P0) -> 19
PCI->APIC IRQ transform: (B0,I9,P0) -> 19
PCI->APIC IRQ transform: (B0,I10,P0) -> 18
PCI->APIC IRQ transform: (B0,I11,P0) -> 17
PCI->APIC IRQ transform: (B0,I12,P0) -> 16
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
i2c-core.o: i2c core module
i2c-algo-bit.o: i2c bit algorithm module
i2c-proc.o version 2.6.1 (20010825)
Detected PS/2 Mouse Port.
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 21
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:DMA
hda: ST360021A, ATA DISK drive
hdc: Pioneer DVD-ROM ATAPIModel DVD-106S 010, ATAPI CD/DVD-ROM drive
hdd: LITE-ON LTR-24102B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=7297/255/63, UDMA(33)
Partition check:
 hda: hda1 hda2 hda3 hda4
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected Intel 440BX chipset
agpgart: AGP aperture is 256M @ 0xd0000000
SCSI subsystem driver Revision: 1.00
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 228k freed
Adding Swap: 265064k swap-space (priority 0)
attempt to access beyond end of device
03:02: rw=0, want=10555924, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=10555926, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=10555924, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=10555926, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=10551352, limit=4096
EXT2-fs error (device ide0(3,2)): ext2_read_inode: unable to read inode block - inode=1319201, block=5275675
attempt to access beyond end of device
03:02: rw=0, want=10551352, limit=4096
EXT2-fs error (device ide0(3,2)): ext2_read_inode: unable to read inode block - inode=1319204, block=5275675
attempt to access beyond end of device
03:02: rw=0, want=4915250, limit=4096
EXT2-fs error (device ide0(3,2)): ext2_read_inode: unable to read inode block - inode=614647, block=2457624
attempt to access beyond end of device
03:02: rw=0, want=9076758, limit=4096
EXT2-fs error (device ide0(3,2)): ext2_read_inode: unable to read inode block - inode=1134622, block=4538378
attempt to access beyond end of device
03:02: rw=0, want=2949122, limit=4096
EXT2-fs error (device ide0(3,2)): read_block_bitmap: Cannot read block bitmap - block_group = 90, block_bitmap = 1474560
attempt to access beyond end of device
03:02: rw=0, want=2949124, limit=4096
EXT2-fs error (device ide0(3,2)): read_inode_bitmap: Cannot read inode bitmap - block_group = 90, inode_bitmap = 1474561
attempt to access beyond end of device
03:02: rw=0, want=2949124, limit=4096
EXT2-fs error (device ide0(3,2)): read_inode_bitmap: Cannot read inode bitmap - block_group = 90, inode_bitmap = 1474561
attempt to access beyond end of device
03:02: rw=0, want=4915258, limit=4096
EXT2-fs error (device ide0(3,2)): ext2_read_inode: unable to read inode block - inode=614715, block=2457628
attempt to access beyond end of device
03:02: rw=0, want=4915226, limit=4096
EXT2-fs error (device ide0(3,2)): ext2_read_inode: unable to read inode block - inode=614454, block=2457612
attempt to access beyond end of device
03:02: rw=0, want=4915810, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=4915810, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6717548, limit=4096
EXT2-fs error (device ide0(3,2)): ext2_read_inode: unable to read inode block - inode=840400, block=3358773
attempt to access beyond end of device
03:02: rw=0, want=6717550, limit=4096
EXT2-fs error (device ide0(3,2)): ext2_read_inode: unable to read inode block - inode=840401, block=3358774
attempt to access beyond end of device
03:02: rw=0, want=4915988, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=4915990, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=4915846, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=4915958, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=4915926, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=4915928, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=4915926, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=4915928, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=4915226, limit=4096
EXT2-fs error (device ide0(3,2)): ext2_read_inode: unable to read inode block - inode=614451, block=2457612
attempt to access beyond end of device
03:02: rw=0, want=4915848, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=4915972, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=4915972, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=4915802, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=4915802, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=4915852, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=4915226, limit=4096
EXT2-fs error (device ide0(3,2)): ext2_read_inode: unable to read inode block - inode=614464, block=2457612
attempt to access beyond end of device
03:02: rw=0, want=4915850, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=4915948, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=4915950, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=4915858, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=4915860, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=4915840, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=4915836, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=4915836, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=4917920, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=4917920, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=4915226, limit=4096
EXT2-fs error (device ide0(3,2)): ext2_read_inode: unable to read inode block - inode=614452, block=2457612
attempt to access beyond end of device
03:02: rw=0, want=10092564, limit=4096
EXT2-fs error (device ide0(3,2)): ext2_read_inode: unable to read inode block - inode=1261582, block=5046281
attempt to access beyond end of device
03:02: rw=0, want=28510, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=28510, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=28510, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=28510, limit=4096
EXT2-fs error (device ide0(3,2)): ext2_free_branches: Read failure, inode=1000154, block=14254
attempt to access beyond end of device
03:02: rw=0, want=2949160, limit=4096
EXT2-fs error (device ide0(3,2)): ext2_read_inode: unable to read inode block - inode=368808, block=1474579
attempt to access beyond end of device
03:02: rw=0, want=6066452, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066454, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066456, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066458, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066460, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066462, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066464, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066466, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066468, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066470, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066472, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066474, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066476, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066478, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066480, limit=4096
attempt to access beyond end of device
03:02: rw=0, want=6066482, limit=4096

--y0ulUmNC+osPPQO6--
