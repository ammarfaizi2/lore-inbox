Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132958AbRBROSv>; Sun, 18 Feb 2001 09:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132959AbRBROSb>; Sun, 18 Feb 2001 09:18:31 -0500
Received: from pm5-54.bahnhof.se ([195.178.167.54]:54794 "EHLO pc1")
	by vger.kernel.org with ESMTP id <S132958AbRBROSU>;
	Sun, 18 Feb 2001 09:18:20 -0500
Date: Sun, 18 Feb 2001 15:26:25 +0100
To: linux-kernel@vger.kernel.org
Subject: [PROBLEM] 2.4.1 can't mount ext2 CD-ROM
Message-ID: <20010218152624.A506@pc1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: Jon Forsberg <zzed@cyberdude.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have two ext2 CD-ROMs. One of them I can mount the normal way, the other I
can't. Both are ok according to debugfs and e2fsck and if I do
'mount -t ext2 -o loop /dev/cdrom /cdrom' instead, both works.

The one that doesn't work have a blocksize of 1024 according to debugfs:
  Block size = 1024, fragment size = 1024
And the other:
  Block size = 4096, fragment size = 4096

What happens:

# mount -t ext2 /dev/cdrom /cdrom        
mount: block device /dev/cdrom is write-protected, mounting read-only
mount: wrong fs type, bad option, bad superblock on /dev/cdrom,
       or too many mounted file systems

kern.log:
Feb 18 14:54:34 pc1 kernel: VFS: Unsupported blocksize on dev sr(11,0).

I'm pretty sure both worked with 2.2.17.
Please CC me.

--zzed

Feb 17 15:01:13 pc1 syslogd 1.3-3#33.1: restart.
Feb 17 15:01:14 pc1 kernel: klogd 1.3-3#33.1, log source = /proc/kmsg started.
Feb 17 15:01:14 pc1 kernel: Inspecting /boot/System.map-2.4.1
Feb 17 15:01:14 pc1 kernel: Loaded 16115 symbols from /boot/System.map-2.4.1.
Feb 17 15:01:14 pc1 kernel: Symbols match kernel version 2.4.1.
Feb 17 15:01:14 pc1 kernel: No module symbols loaded.
Feb 17 15:01:14 pc1 kernel: Linux version 2.4.1 (zzed@pc1) (gcc version 2.95.2 20000220 (Debian GNU/Linux)) #1 ons feb 14 12:35:41 CET 2001
Feb 17 15:01:14 pc1 kernel: BIOS-provided physical RAM map:
Feb 17 15:01:14 pc1 kernel:  BIOS-e820: 00000000000a0000 @ 0000000000000000 (usable)
Feb 17 15:01:14 pc1 kernel:  BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
Feb 17 15:01:14 pc1 kernel:  BIOS-e820: 0000000007deb000 @ 0000000000100000 (usable)
Feb 17 15:01:14 pc1 kernel:  BIOS-e820: 0000000000004000 @ 0000000007eeb000 (ACPI data)
Feb 17 15:01:14 pc1 kernel:  BIOS-e820: 0000000000010000 @ 0000000007eef000 (reserved)
Feb 17 15:01:14 pc1 kernel:  BIOS-e820: 0000000000001000 @ 0000000007eff000 (ACPI NVS)
Feb 17 15:01:14 pc1 kernel:  BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
Feb 17 15:01:14 pc1 kernel: On node 0 totalpages: 32491
Feb 17 15:01:14 pc1 kernel: zone(0): 4096 pages.
Feb 17 15:01:14 pc1 kernel: zone(1): 28395 pages.
Feb 17 15:01:14 pc1 kernel: zone(2): 0 pages.
Feb 17 15:01:14 pc1 kernel: Kernel command line: auto BOOT_IMAGE=Linux ro root=302 BOOT_FILE=/boot/vmlinuz hda=13410,15,63 hdc=scsi bttv.radio=1 hisax=36,2
Feb 17 15:01:14 pc1 kernel: ide_setup: hda=13410,15,63
Feb 17 15:01:14 pc1 kernel: ide_setup: hdc=scsi
Feb 17 15:01:14 pc1 kernel: Initializing CPU#0
Feb 17 15:01:14 pc1 kernel: Detected 668.194 MHz processor.
Feb 17 15:01:14 pc1 kernel: Console: colour VGA+ 80x25
Feb 17 15:01:14 pc1 kernel: Calibrating delay loop... 1333.65 BogoMIPS
Feb 17 15:01:14 pc1 kernel: Memory: 125032k/129964k available (1364k kernel code, 4548k reserved, 604k data, 180k init, 0k highmem)
Feb 17 15:01:14 pc1 kernel: Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Feb 17 15:01:14 pc1 kernel: Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Feb 17 15:01:14 pc1 kernel: Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Feb 17 15:01:14 pc1 kernel: Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Feb 17 15:01:14 pc1 kernel: CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor = 0
Feb 17 15:01:14 pc1 kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Feb 17 15:01:14 pc1 kernel: CPU: L2 cache: 128K
Feb 17 15:01:14 pc1 kernel: Intel machine check architecture supported.
Feb 17 15:01:14 pc1 kernel: Intel machine check reporting enabled on CPU#0.
Feb 17 15:01:14 pc1 kernel: CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
Feb 17 15:01:14 pc1 kernel: CPU: After generic, caps: 0383f9ff 00000000 00000000 00000000
Feb 17 15:01:14 pc1 kernel: CPU: Common caps: 0383f9ff 00000000 00000000 00000000
Feb 17 15:01:14 pc1 kernel: CPU: Intel Celeron (Coppermine) stepping 03
Feb 17 15:01:14 pc1 kernel: Enabling fast FPU save and restore... done.
Feb 17 15:01:14 pc1 kernel: Enabling unmasked SIMD FPU exception support... done.
Feb 17 15:01:14 pc1 kernel: Checking 'hlt' instruction... OK.
Feb 17 15:01:14 pc1 kernel: POSIX conformance testing by UNIFIX
Feb 17 15:01:14 pc1 kernel: mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
Feb 17 15:01:14 pc1 kernel: mtrr: detected mtrr type: Intel
Feb 17 15:01:14 pc1 kernel: PCI: PCI BIOS revision 2.10 entry at 0xf0960, last bus=1
Feb 17 15:01:14 pc1 kernel: PCI: Using configuration type 1
Feb 17 15:01:14 pc1 kernel: PCI: Probing PCI hardware
Feb 17 15:01:14 pc1 kernel: PCI: Discovered primary peer bus fe [IRQ]
Feb 17 15:01:14 pc1 kernel: PCI: Using IRQ router PIIX [8086/2440] at 00:1f.0
Feb 17 15:01:14 pc1 kernel: Linux NET4.0 for Linux 2.4
Feb 17 15:01:14 pc1 kernel: Based upon Swansea University Computer Society NET3.039
Feb 17 15:01:14 pc1 kernel: DMI 2.3 present.
Feb 17 15:01:14 pc1 kernel: 45 structures occupying 1293 bytes.
Feb 17 15:01:14 pc1 kernel: DMI table at 0x000F24C0.
Feb 17 15:01:14 pc1 kernel: BIOS Vendor: Award Software, Inc.
Feb 17 15:01:14 pc1 kernel: BIOS Version: ASUS CUSL2 ACPI BIOS Revision 1001.A
Feb 17 15:01:14 pc1 kernel: BIOS Release: 06/21/2000
Feb 17 15:01:14 pc1 kernel: System Vendor: System Manufacturer.
Feb 17 15:01:14 pc1 kernel: Product Name: System Name.
Feb 17 15:01:14 pc1 kernel: Version System Version.
Feb 17 15:01:14 pc1 kernel: Serial Number SYS-1234567890.
Feb 17 15:01:14 pc1 kernel: Board Vendor: ASUSTeK Computer INC..
Feb 17 15:01:14 pc1 kernel: Board Name: CUSL2.
Feb 17 15:01:14 pc1 kernel: Board Version: REV 1.xx.
Feb 17 15:01:14 pc1 kernel: Asset Tag: Asset-1234567890.
Feb 17 15:01:14 pc1 kernel: Starting kswapd v1.8
Feb 17 15:01:14 pc1 kernel: i2c-core.o: i2c core module
Feb 17 15:01:14 pc1 kernel: i2c-dev.o: i2c /dev entries driver module
Feb 17 15:01:14 pc1 kernel: i2c-core.o: driver i2c-dev dummy driver registered.
Feb 17 15:01:14 pc1 kernel: i2c-algo-bit.o: i2c bit algorithm module
Feb 17 15:01:14 pc1 kernel: pty: 256 Unix98 ptys configured
Feb 17 15:01:14 pc1 kernel: ISDN subsystem Rev: 1.114/1.94/1.140.6.1/1.85/1.21/1.5
Feb 17 15:01:14 pc1 kernel: HiSax: Linux Driver for passive ISDN cards
Feb 17 15:01:14 pc1 kernel: HiSax: Version 3.5 (kernel)
Feb 17 15:01:14 pc1 kernel: HiSax: Layer1 Revision 2.41.6.1
Feb 17 15:01:14 pc1 kernel: HiSax: Layer2 Revision 2.25
Feb 17 15:01:14 pc1 kernel: HiSax: TeiMgr Revision 2.17
Feb 17 15:01:14 pc1 kernel: HiSax: Layer3 Revision 2.17
Feb 17 15:01:14 pc1 kernel: HiSax: LinkLayer Revision 2.51
Feb 17 15:01:14 pc1 kernel: HiSax: Approval certification valid
Feb 17 15:01:14 pc1 kernel: HiSax: Approved with ELSA Microlink PCI cards
Feb 17 15:01:14 pc1 kernel: HiSax: Approved with Eicon Technology Diva 2.01 PCI cards
Feb 17 15:01:14 pc1 kernel: HiSax: Approved with Sedlbauer Speedfax + cards
Feb 17 15:01:14 pc1 kernel: HiSax: Card 1 Protocol EDSS1 Id=HiSax (0)
Feb 17 15:01:14 pc1 kernel: HiSax: W6692 driver Rev. 1.12.6.2
Feb 17 15:01:14 pc1 kernel: PCI: Found IRQ 5 for device 01:09.0
Feb 17 15:01:14 pc1 kernel: Found: Dynalink/AsusCom IS64PH, I/O base: 0xd800, irq: 5
Feb 17 15:01:14 pc1 kernel: HiSax: IS64PH config irq:5 I/O:d800
Feb 17 15:01:14 pc1 kernel: W6692: Winbond W6692 version (0): W6692 V00
Feb 17 15:01:14 pc1 kernel: W6692 ISTA=0x0
Feb 17 15:01:14 pc1 kernel: W6692 IMASK=0xFF
Feb 17 15:01:14 pc1 kernel: W6692 D_EXIR=0x0
Feb 17 15:01:14 pc1 kernel: W6692 D_EXIM=0xFF
Feb 17 15:01:14 pc1 kernel: W6692 D_RSTA=0xA0
Feb 17 15:01:14 pc1 kernel: Winbond 6692: IRQ 5 count 0
Feb 17 15:01:14 pc1 kernel: Winbond 6692: IRQ 5 count 7
Feb 17 15:01:14 pc1 kernel: HiSax: DSS1 Rev. 2.30
Feb 17 15:01:14 pc1 kernel: HiSax: 2 channels added
Feb 17 15:01:14 pc1 kernel: HiSax: MAX_WAITING_CALLS added
Feb 17 15:01:14 pc1 kernel: Linux video capture interface: v1.00
Feb 17 15:01:14 pc1 kernel: block: queued sectors max/low 82704kB/27568kB, 256 slots per queue
Feb 17 15:01:14 pc1 kernel: loop: enabling 8 loop devices
Feb 17 15:01:14 pc1 kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
Feb 17 15:01:14 pc1 kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Feb 17 15:01:14 pc1 kernel: PIIX4: IDE controller on PCI bus 00 dev f9
Feb 17 15:01:14 pc1 kernel: PIIX4: chipset revision 1
Feb 17 15:01:14 pc1 kernel: PIIX4: not 100%% native mode: will probe irqs later
Feb 17 15:01:14 pc1 kernel:     ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:DMA
Feb 17 15:01:14 pc1 kernel:     ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:pio
Feb 17 15:01:14 pc1 kernel: hda: FUJITSU MPE3064AT, ATA DISK drive
Feb 17 15:01:14 pc1 kernel: hdb: IBM-DTLA-307045, ATA DISK drive
Feb 17 15:01:14 pc1 kernel: hdc: RICOH DVD/CDRW MP9060, ATAPI CD/DVD-ROM drive
Feb 17 15:01:14 pc1 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Feb 17 15:01:14 pc1 kernel: ide1 at 0x170-0x177,0x376 on irq 15
Feb 17 15:01:14 pc1 kernel: hda: 12672450 sectors (6488 MB) w/512KiB Cache, CHS=13410/15/63
Feb 17 15:01:14 pc1 kernel: hdb: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=5606/255/63
Feb 17 15:01:14 pc1 kernel: ide-cd: passing drive hdc to ide-scsi emulation.
Feb 17 15:01:14 pc1 kernel: Partition check:
Feb 17 15:01:14 pc1 kernel:  hda: hda1 hda2 hda3
Feb 17 15:01:14 pc1 kernel:  hdb: hdb1
Feb 17 15:01:14 pc1 kernel: udf: registering filesystem
Feb 17 15:01:14 pc1 kernel: Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
Feb 17 15:01:14 pc1 kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Feb 17 15:01:14 pc1 kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
Feb 17 15:01:14 pc1 kernel: i2c-core.o: driver i2c msp3400 driver registered.
Feb 17 15:01:14 pc1 kernel: tvaudio: TV audio decoder + audio/video mux driver
Feb 17 15:01:14 pc1 kernel: tvaudio: known chips: tda9840,tda9873h,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54 (PV951)
Feb 17 15:01:14 pc1 kernel: i2c-core.o: driver generic i2c audio driver registered.
Feb 17 15:01:14 pc1 kernel: i2c-core.o: driver i2c TV tuner driver registered.
Feb 17 15:01:14 pc1 kernel: i2c-core.o: driver tv card mixer driver registered.
Feb 17 15:01:14 pc1 kernel: bttv: driver version 0.7.50 loaded
Feb 17 15:01:14 pc1 kernel: bttv: using 2 buffers with 2080k (4160k total) for capture
Feb 17 15:01:14 pc1 kernel: bttv: Bt8xx card found (0).
Feb 17 15:01:14 pc1 kernel: PCI: Found IRQ 9 for device 01:0b.0
Feb 17 15:01:14 pc1 kernel: PCI: The same IRQ used for device 00:1f.4
Feb 17 15:01:14 pc1 kernel: PCI: The same IRQ used for device 01:0b.1
Feb 17 15:01:14 pc1 kernel: bttv0: Bt878 (rev 17) at 01:0b.0, irq: 9, latency: 64, memory: 0xf7800000
Feb 17 15:01:14 pc1 kernel: bttv0: subsystem: 0070:13eb  =>  Hauppauge WinTV  =>  card=10
Feb 17 15:01:14 pc1 kernel: bttv0: model: BT878(Hauppauge new (bt878)) [autodetected]
Feb 17 15:01:14 pc1 kernel: bttv0: Hauppauge msp34xx: reset line init
Feb 17 15:01:14 pc1 kernel: i2c-dev.o: Registered 'bt848 #0' as minor 0
Feb 17 15:01:14 pc1 kernel: msp34xx: init: chip=MSP3415D-B3, has NICAM support
Feb 17 15:01:14 pc1 kernel: msp3410: daemon started
Feb 17 15:01:14 pc1 kernel: bttv0: i2c attach [MSP3415D-B3]
Feb 17 15:01:14 pc1 kernel: i2c-core.o: client [MSP3415D-B3] registered to adapter [bt848 #0](pos. 0).
Feb 17 15:01:14 pc1 kernel: tuner: chip found @ 0x61
Feb 17 15:01:14 pc1 kernel: bttv0: i2c attach [(unset)]
Feb 17 15:01:14 pc1 kernel: i2c-core.o: client [(unset)] registered to adapter [bt848 #0](pos. 1).
Feb 17 15:01:14 pc1 kernel: tvmixer: debug: MSP3415D-B3
Feb 17 15:01:14 pc1 kernel: tvmixer: MSP3415D-B3 (bt848 #0) registered with minor 0
Feb 17 15:01:14 pc1 kernel: tvmixer: debug: (unset)
Feb 17 15:01:14 pc1 kernel: i2c-core.o: adapter bt848 #0 registered as adapter 0.
Feb 17 15:01:14 pc1 kernel: bttv0: Hauppauge eeprom: model=44354, tuner=Philips FM1216 (5)
Feb 17 15:01:14 pc1 kernel: bttv0: i2c: checking for MSP34xx @ 0x80... found
Feb 17 15:01:14 pc1 kernel: bttv0: i2c: checking for TDA9875 @ 0xb0... not found
Feb 17 15:01:14 pc1 kernel: bttv0: i2c: checking for TDA7432 @ 0x8a... not found
Feb 17 15:01:14 pc1 kernel: Linux agpgart interface v0.99 (c) Jeff Hartmann
Feb 17 15:01:14 pc1 kernel: agpgart: Maximum main memory to use for agp memory: 93M
Feb 17 15:01:14 pc1 kernel: agpgart: agpgart: Detected an Intel i815 Chipset.
Feb 17 15:01:14 pc1 kernel: agpgart: AGP aperture is 64M @ 0xf8000000
Feb 17 15:01:14 pc1 kernel: [drm] AGP 0.99 on Intel i810 @ 0xf8000000 64MB
Feb 17 15:01:14 pc1 kernel: [drm] Initialized i810 1.1.0 20000928 on minor 63
Feb 17 15:01:14 pc1 kernel: SCSI subsystem driver Revision: 1.00
Feb 17 15:01:14 pc1 kernel: scsi0 : SCSI host adapter emulation for IDE ATAPI devices
Feb 17 15:01:14 pc1 kernel:   Vendor: RICOH     Model: DVD/CDRW MP9060   Rev: 1.60
Feb 17 15:01:14 pc1 kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Feb 17 15:01:14 pc1 kernel: Detected scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Feb 17 15:01:14 pc1 kernel: sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Feb 17 15:01:14 pc1 kernel: Uniform CD-ROM driver Revision: 3.12
Feb 17 15:01:14 pc1 kernel: es1371: version v0.27 time 12:40:44 Feb 14 2001
Feb 17 15:01:14 pc1 kernel: es1371: found chip, vendor id 0x1274 device id 0x5880 revision 0x02
Feb 17 15:01:14 pc1 kernel: PCI: Found IRQ 9 for device 01:0a.0
Feb 17 15:01:14 pc1 kernel: es1371: found es1371 rev 2 at io 0xd400 irq 9
Feb 17 15:01:14 pc1 kernel: es1371: features: joystick 0x0
Feb 17 15:01:14 pc1 kernel: ac97_codec: AC97 Audio codec, id: 0x8384:0x7609 (SigmaTel STAC9721/23)
Feb 17 15:01:14 pc1 kernel: usb.c: registered new driver usbdevfs
Feb 17 15:01:14 pc1 kernel: usb.c: registered new driver hub
Feb 17 15:01:14 pc1 kernel: PCI: Found IRQ 12 for device 00:1f.2
Feb 17 15:01:14 pc1 kernel: PCI: Setting latency timer of device 00:1f.2 to 64
Feb 17 15:01:14 pc1 kernel: uhci.c: USB UHCI at I/O 0xb400, IRQ 12
Feb 17 15:01:14 pc1 kernel: uhci.c: detected 2 ports
Feb 17 15:01:14 pc1 kernel: usb.c: new USB bus registered, assigned bus number 1
Feb 17 15:01:14 pc1 kernel: hub.c: USB hub found
Feb 17 15:01:14 pc1 kernel: hub.c: 2 ports detected
Feb 17 15:01:14 pc1 kernel: PCI: Found IRQ 9 for device 00:1f.4
Feb 17 15:01:14 pc1 kernel: PCI: The same IRQ used for device 01:0b.0
Feb 17 15:01:14 pc1 kernel: PCI: The same IRQ used for device 01:0b.1
Feb 17 15:01:14 pc1 kernel: PCI: Setting latency timer of device 00:1f.4 to 64
Feb 17 15:01:14 pc1 kernel: uhci.c: USB UHCI at I/O 0xb000, IRQ 9
Feb 17 15:01:14 pc1 kernel: uhci.c: detected 2 ports
Feb 17 15:01:14 pc1 kernel: usb.c: new USB bus registered, assigned bus number 2
Feb 17 15:01:14 pc1 kernel: hub.c: USB hub found
Feb 17 15:01:14 pc1 kernel: hub.c: 2 ports detected
Feb 17 15:01:14 pc1 kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Feb 17 15:01:14 pc1 kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Feb 17 15:01:14 pc1 kernel: IP: routing cache hash table of 512 buckets, 4Kbytes
Feb 17 15:01:14 pc1 kernel: TCP: Hash tables configured (established 8192 bind 8192)
Feb 17 15:01:14 pc1 kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Feb 17 15:01:14 pc1 kernel: VFS: Mounted root (ext2 filesystem) readonly.
Feb 17 15:01:14 pc1 kernel: Freeing unused kernel memory: 180k freed
Feb 17 15:01:14 pc1 kernel: hub.c: USB new device connect on bus2/2, assigned device number 3
Feb 17 15:01:14 pc1 kernel: hub.c: USB hub found
Feb 17 15:01:14 pc1 kernel: hub.c: 4 ports detected
Feb 17 15:01:14 pc1 kernel: Adding Swap: 180012k swap-space (priority -1)
