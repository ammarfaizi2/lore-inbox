Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313571AbSH0Elu>; Tue, 27 Aug 2002 00:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313628AbSH0Elu>; Tue, 27 Aug 2002 00:41:50 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:23820
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S313571AbSH0Elm>; Tue, 27 Aug 2002 00:41:42 -0400
Date: Mon, 26 Aug 2002 21:44:06 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Francois Romieu <romieu@cogenit.fr>
cc: alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: IDE success with 2.4.20-pre4-ac1
In-Reply-To: <20020826225747.A14739@fafner.intra.cogenit.fr>
Message-ID: <Pine.LNX.4.10.10208262140260.24156-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Francois,

Now to make it so you do not have to pass every darn parameter under the
sun to get it to go!  That is one of the worst append line I have ever
seen, I am shocked it took such a big hammer.

Poking this on LKML just for the success points that are way overshadowed
by the embarrasment (sp) of your append line.

Cheers,

Andre Hedrick
LAD Storage Consulting Group


On Mon, 26 Aug 2002, Francois Romieu wrote:

> Greetings,
> 
>   asus p4b-e with on-board Promise pdc20265 controller.
> 
> lspci output:
> 00:00.0 Host bridge: Intel Corporation 82845 845 (Brookdale) Chipset Host Bridge (rev 03)
> 00:01.0 PCI bridge: Intel Corporation 82845 845 (Brookdale) Chipset AGP Bridge (rev 03)
> 00:1e.0 PCI bridge: Intel Corporation 82801BAM PCI (rev 12)
> 00:1f.0 ISA bridge: Intel Corporation 82801BA ISA Bridge (ICH2) (rev 12)
> 00:1f.1 IDE interface: Intel Corporation 82801BA IDE U100 (rev 12)
> 00:1f.2 USB Controller: Intel Corporation 82801BA(M) USB (Hub A) (rev 12)
> 00:1f.4 USB Controller: Intel Corporation 82801BA(M) USB (Hub B) (rev 12)
> 01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF
> 02:06.0 Ethernet controller: Standard Microsystems Corp [SMC] 83C170QF (rev 09)
> 02:07.0 Ethernet controller: Winbond Electronics Corp W89C940
> 02:0a.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 78)
> 02:0b.0 Ethernet controller: Standard Microsystems Corp [SMC] 83C170QF (rev 08)
> 02:0d.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
> 02:0e.0 Unknown mass storage controller: Promise Technology, Inc. 20265 (rev 02)
> 
> boot options:
>         append="nmi_watchdog=1 root=/dev/md1 ide0=dma ide1=dma ide2=dma ide3=dma
>  profile=2 devfs=nomount hda=7476,255,53 hdc=7476,255,53 hde=7476,255,53 hdg=747
> 6,255,53"
> 
> dmesg:
> _FILE=/boot/bzImage-2.4.20-pre4-ac1 nmi_watchdog=1 root=/dev/md1 ide0=dma ide1=dma ide2=dma ide3=dma profile=2 devfs=nomount hda=7476,255,53 hdc=7476,255,53 hde=7476,255,53 hdg=7476,255,53
> ide_setup: ide0=dma
> ide_setup: ide1=dma
> ide_setup: ide2=dma
> ide_setup: ide3=dma
> ide_setup: hda=7476,255,53
> ide_setup: hdc=7476,255,53
> ide_setup: hde=7476,255,53
> ide_setup: hdg=7476,255,53
> Found and enabled local APIC!
> Initializing CPU#0
> Detected 1513.491 MHz processor.
> Console: colour VGA+ 80x25
> Calibrating delay loop... 3021.20 BogoMIPS
> Memory: 513636k/524272k available (1294k kernel code, 10248k reserved, 532k data, 160k init, 0k highmem)
> Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
> Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
> Mount cache hash table entries: 512 (order: 0, 4096 bytes)
> ramfs: mounted with options: <defaults>
> ramfs: max_pages=64204 max_file_pages=0 max_inodes=0 max_dentries=64204
> Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
> Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
> CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
> CPU: L1 I cache: 0K, L1 D cache: 8K
> CPU: L2 cache: 256K
> CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
> CPU:             Common caps: 3febfbff 00000000 00000000 00000000
> CPU: Intel(R) Pentium(R) 4 CPU 1.50GHz stepping 02
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
> POSIX conformance testing by UNIFIX
> enabled ExtINT on CPU#0
> ESR value before enabling vector: 00000000
> ESR value after enabling vector: 00000000
> testing NMI watchdog ... OK.
> Using local APIC timer interrupts.
> calibrating APIC timer ...
> ..... CPU clock speed is 1513.5079 MHz.
> ..... host bus clock speed is 100.9003 MHz.
> cpu: 0, clocks: 1009003, slice: 504501
> CPU0<T0:1008992,T1:504480,D:11,S:504501,C:1009003>
> mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
> mtrr: detected mtrr type: Intel
> PCI: PCI BIOS revision 2.10 entry at 0xf1280, last bus=2
> PCI: Using configuration type 1
> PCI: Probing PCI hardware
> PCI: Using IRQ router PIIX [8086/2440] at 00:1f.0
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Initializing RT netlink socket
> Starting kswapd
> VFS: Disk quotas vdquot_6.5.1
> Journalled Block Device driver loaded
> vga16fb: initializing
> vga16fb: mapped to 0xc00a0000
> Console: switching to colour frame buffer device 80x30
> fb0: VGA16 VGA frame buffer device
> pty: 256 Unix98 ptys configured
> Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI enabled
> ttyS00 at 0x03f8 (irq = 4) is a 16550A
> ttyS01 at 0x02f8 (irq = 3) is a 16550A
> Real Time Clock Driver v1.10e
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha1
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> ICH2: IDE controller on PCI bus 00 dev f9
> ICH2: chipset revision 18
> ICH2: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0x7800-0x7807, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0x7808-0x780f, BIOS settings: hdc:DMA, hdd:pio
> PDC20265: IDE controller on PCI bus 02 dev 70
> PCI: Found IRQ 9 for device 02:0e.0
> PCI: Sharing IRQ 9 with 00:1f.4
> PCI: Sharing IRQ 9 with 02:0b.0
> PDC20265: chipset revision 2
> PDC20265: not 100% native mode: will probe irqs later
> PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
>     ide2: BM-DMA at 0x8800-0x8807, BIOS settings: hde:DMA, hdf:pio
>     ide3: BM-DMA at 0x8808-0x880f, BIOS settings: hdg:DMA, hdh:pio
> hda: IC35L060AVER07-0, ATA DISK drive
> hdc: IC35L060AVER07-0, ATA DISK drive
> hde: IC35L060AVER07-0, ATA DISK drive
> ULTRA 66/100/133: Primary channel of Ultra 66/100/133 requires an 80-pin cable for Ultra66 operation.
>          Switching to Ultra33 mode.
> Warning: Primary channel requires an 80-pin cable for operation.
> hde reduced to Ultra33 mode.
> hdg: IC35L060AVER07-0, ATA DISK drive
> hdh: LG CD-ROM CRD-8522B, ATAPI CD/DVD-ROM drive
> ULTRA 66/100/133: Secondary channel of Ultra 66/100/133 requires an 80-pin cable for Ultra66 operation.
>          Switching to Ultra33 mode.
> Warning: Secondary channel requires an 80-pin cable for operation.
> hdg reduced to Ultra33 mode.
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> ide2 at 0xa000-0xa007,0x9802 on irq 9
> ide3 at 0x9400-0x9407,0x9002 on irq 9
> hda: host protected area => 1
> hda: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=7476/255/53, UDMA(100)
> hdc: host protected area => 1
> hdc: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=7476/255/53, UDMA(100)
> hde: host protected area => 1
> hde: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=7476/255/53, UDMA(33)
> hdg: host protected area => 1
> hdg: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=7476/255/53, UDMA(33)
> Partition check:
>  hda: hda1 hda2 hda3 hda4
>  hdc: hdc1 hdc2 hdc3 hdc4
>  hde: hde1 hde2 hde3 hde4
>  hdg: hdg1 hdg2 hdg3 hdg4
> NET4: Frame Diverter 0.46
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> Cronyx Ltd, Synchronous PPP and CISCO HDLC (c) 1994
> Linux port (c) 1998 Building Number Three Ltd & Jan "Yenya" Kasprzak.
> SCSI subsystem driver Revision: 1.00
> kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
> md: raid1 personality registered as nr 3
> md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
> md: Autodetecting RAID arrays.
>  [events: 0000009e]
>  [events: 0000009e]
>  [events: 00000048]
>  [events: 00000051]
>  [events: 0000009e]
>  [events: 0000009e]
>  [events: 00000048]
>  [events: 00000051]
>  [events: fffffdf8]
> md: invalid raid superblock magic on hde1
> md: hde1 has invalid sb, not importing!
> md: could not import hde1!
>  [events: afcd6847]
> md: invalid raid superblock magic on hde2
> md: hde2 has invalid sb, not importing!
> md: could not import hde2!
>  [events: 00000051]
>  [events: 00000055]
>  [events: fffffdf8]
> md: invalid raid superblock magic on hdg1
> md: hdg1 has invalid sb, not importing!
> md: could not import hdg1!
>  [events: afcd6847]
> md: invalid raid superblock magic on hdg2
> md: hdg2 has invalid sb, not importing!
> md: could not import hdg2!
>  [events: 00000051]
>  [events: 00000055]
> md: autorun ...
> md: considering hdg4 ...
> md:  adding hdg4 ...
> md:  adding hde4 ...
> md: created md21
> md: bind<hde4,1>
> md: bind<hdg4,2>
> md: running: <hdg4><hde4>
> md: hdg4's event counter: 00000055
> md: hde4's event counter: 00000055
> md: RAID level 1 does not need chunksize! Continuing anyway.
> md21: max total readahead window set to 124k
> md21: 1 data-disks, max readahead per data-disk: 124k
> raid1: device hdg4 operational as mirror 0
> raid1: device hde4 operational as mirror 1
> raid1: raid set md21 active with 2 out of 2 mirrors
> md: updating md21 RAID superblock on device
> md: hdg4 [events: 00000056]<6>(write) hdg4's sb offset: 46652672
> md: hde4 [events: 00000056]<6>(write) hde4's sb offset: 46652672
> md: considering hdg3 ...
> md:  adding hdg3 ...
> md:  adding hde3 ...
> md: created md20
> md: bind<hde3,1>
> md: bind<hdg3,2>
> md: running: <hdg3><hde3>
> md: hdg3's event counter: 00000051
> md: hde3's event counter: 00000051
> md: RAID level 1 does not need chunksize! Continuing anyway.
> md20: max total readahead window set to 124k
> md20: 1 data-disks, max readahead per data-disk: 124k
> raid1: device hdg3 operational as mirror 0
> raid1: device hde3 operational as mirror 1
> raid1: raid set md20 active with 2 out of 2 mirrors
> md: updating md20 RAID superblock on device
> md: hdg3 [events: 00000052]<6>(write) hdg3's sb offset: 10241344
> md: hde3 [events: 00000052]<6>(write) hde3's sb offset: 10241344
> md: considering hdc4 ...
> md:  adding hdc4 ...
> md:  adding hda4 ...
> md: created md11
> md: bind<hda4,1>
> md: bind<hdc4,2>
> md: running: <hdc4><hda4>
> md: hdc4's event counter: 00000051
> md: hda4's event counter: 00000051
> md: RAID level 1 does not need chunksize! Continuing anyway.
> md11: max total readahead window set to 124k
> md11: 1 data-disks, max readahead per data-disk: 124k
> raid1: device hdc4 operational as mirror 1
> raid1: device hda4 operational as mirror 0
> raid1: raid set md11 active with 2 out of 2 mirrors
> md: updating md11 RAID superblock on device
> md: hdc4 [events: 00000052]<6>(write) hdc4's sb offset: 46652672
> md: hda4 [events: 00000052]<6>(write) hda4's sb offset: 46652672
> md: considering hdc3 ...
> md:  adding hdc3 ...
> md:  adding hda3 ...
> md: created md10
> md: bind<hda3,1>
> md: bind<hdc3,2>
> md: running: <hdc3><hda3>
> md: hdc3's event counter: 00000048
> md: hda3's event counter: 00000048
> md: RAID level 1 does not need chunksize! Continuing anyway.
> md10: max total readahead window set to 124k
> md10: 1 data-disks, max readahead per data-disk: 124k
> raid1: device hdc3 operational as mirror 1
> raid1: device hda3 operational as mirror 0
> raid1: raid set md10 active with 2 out of 2 mirrors
> md: updating md10 RAID superblock on device
> md: hdc3 [events: 00000049]<6>(write) hdc3's sb offset: 10241344
> md: hda3 [events: 00000049]<6>(write) hda3's sb offset: 10241344
> md: considering hdc2 ...
> md:  adding hdc2 ...
> md:  adding hda2 ...
> md: created md1
> md: bind<hda2,1>
> md: bind<hdc2,2>
> md: running: <hdc2><hda2>
> md: hdc2's event counter: 0000009e
> md: hda2's event counter: 0000009e
> md: RAID level 1 does not need chunksize! Continuing anyway.
> md1: max total readahead window set to 124k
> md1: 1 data-disks, max readahead per data-disk: 124k
> raid1: device hdc2 operational as mirror 0
> raid1: device hda2 operational as mirror 1
> raid1: raid set md1 active with 2 out of 2 mirrors
> md: updating md1 RAID superblock on device
> md: hdc2 [events: 0000009f]<6>(write) hdc2's sb offset: 2104448
> md: hda2 [events: 0000009f]<6>(write) hda2's sb offset: 2104448
> md: considering hdc1 ...
> md:  adding hdc1 ...
> md:  adding hda1 ...
> md: created md0
> md: bind<hda1,1>
> md: bind<hdc1,2>
> md: running: <hdc1><hda1>
> md: hdc1's event counter: 0000009e
> md: hda1's event counter: 0000009e
> md: RAID level 1 does not need chunksize! Continuing anyway.
> md0: max total readahead window set to 124k
> md0: 1 data-disks, max readahead per data-disk: 124k
> raid1: device hdc1 operational as mirror 0
> raid1: device hda1 operational as mirror 1
> raid1: raid set md0 active with 2 out of 2 mirrors
> md: updating md0 RAID superblock on device
> md: hdc1 [events: 0000009f]<6>(write) hdc1's sb offset: 1052160
> md: hda1 [events: 0000009f]<6>(write) hda1's sb offset: 1052160
> md: ... autorun DONE.
> IEEE 802.2 LLC for Linux 2.1 (c) 1996 Tim Alpaerts
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP, IGMP
> IP: routing cache hash table of 4096 buckets, 32Kbytes
> TCP: Hash tables configured (established 32768 bind 65536)
> Linux IP multicast router 0.06 plus PIM-SM
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> LLC 2.0 by Procom, 1997, Arnaldo C. Melo, 2001
> NET4.0 IEEE 802.2 extended support
> NET4.0 IEEE 802.2 User Interface SAPs, Jay Schulist, 2001
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: mounted filesystem with ordered data mode.
> VFS: Mounted root (ext3 filesystem) readonly.
> Freeing unused kernel memory: 160k freed
> Adding Swap: 1052152k swap-space (priority -1)
> usb.c: registered new driver usbdevfs
> usb.c: registered new driver hub
> uhci.c: USB Universal Host Controller Interface driver v1.1
> PCI: Found IRQ 10 for device 00:1f.2
> PCI: Setting latency timer of device 00:1f.2 to 64
> uhci.c: USB UHCI at I/O 0x7400, IRQ 10
> usb.c: new USB bus registered, assigned bus number 1
> uhci.c: detected 2 ports
> usb.c: kmalloc IF dfe66ec0, numif 1
> usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
> usb.c: USB device number 1 default language ID 0x0
> Product: USB UHCI-alt Root Hub
> SerialNumber: 7400
> hub.c: USB hub found
> hub.c: 2 ports detected
> hub.c: standalone hub
> hub.c: ganged power switching
> hub.c: global over-current protection
> hub.c: Port indicators are not supported
> hub.c: power on to power good time: 2ms
> hub.c: hub controller current requirement: 0mA
> hub.c: port removable status: RR
> hub.c: local power source is good
> hub.c: no over-current condition exists
> hub.c: enabling power on all ports
> usb.c: hub driver claimed interface dfe66ec0
> usb.c: kusbd: /sbin/hotplug add 1
> PCI: Found IRQ 9 for device 00:1f.4
> PCI: Sharing IRQ 9 with 02:0b.0
> PCI: Sharing IRQ 9 with 02:0e.0
> PCI: Setting latency timer of device 00:1f.4 to 64
> uhci.c: USB UHCI at I/O 0x7000, IRQ 9
> usb.c: new USB bus registered, assigned bus number 2
> uhci.c: detected 2 ports
> usb.c: kmalloc IF df784240, numif 1
> usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
> usb.c: USB device number 1 default language ID 0x0
> Product: USB UHCI-alt Root Hub
> SerialNumber: 7000
> hub.c: USB hub found
> hub.c: 2 ports detected
> hub.c: standalone hub
> hub.c: ganged power switching
> hub.c: global over-current protection
> hub.c: Port indicators are not supported
> hub.c: power on to power good time: 2ms
> hub.c: hub controller current requirement: 0mA
> hub.c: port removable status: RR
> hub.c: local power source is good
> hub.c: no over-current condition exists
> hub.c: enabling power on all ports
> usb.c: hub driver claimed interface df784240
> usb.c: kusbd: /sbin/hotplug add 1
> usb-uhci.c: $Revision: 1.275 $ time 22:03:11 Aug 26 2002
> usb-uhci.c: High bandwidth mode enabled
> usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
> uhci.c: 7400: suspend_hc
> usb-uhci.c: $Revision: 1.275 $ time 22:03:11 Aug 26 2002
> usb-uhci.c: High bandwidth mode enabled
> usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
> uhci.c: 7000: suspend_hc
> EXT3 FS 2.4-0.9.18, 14 May 2002 on md(9,1), internal journal
>  [events: 0000004e]
>  [events: 0000004e]
> md: autorun ...
> md: considering md21 ...
> md:  adding md21 ...
> md:  adding md11 ...
> md: created md4
> md: bind<md11,1>
> md: bind<md21,2>
> md: running: <md21><md11>
> md: md21's event counter: 0000004e
> md: md11's event counter: 0000004e
> md: raid0 personality registered as nr 2
> md4: max total readahead window set to 496k
> md4: 2 data-disks, max readahead per data-disk: 248k
> raid0: looking at md11
> raid0:   comparing md11(46652608) with md11(46652608)
> raid0:   END
> raid0:   ==> UNIQUE
> raid0: 1 zones
> raid0: looking at md21
> raid0:   comparing md21(46652608) with md11(46652608)
> raid0:   EQUAL
> raid0: FINAL 1 zones
> raid0: zone 0
> raid0: checking md11 ... contained as device 0
>   (46652608) is smallest!.
> raid0: checking md21 ... contained as device 1
> raid0: zone->nb_dev: 2, size: 93305216
> raid0: current zone offset: 46652608
> raid0: done.
> raid0 : md_size is 93305216 blocks.
> raid0 : conf->smallest->size is 93305216 blocks.
> raid0 : nb_zone is 1.
> raid0 : Allocating 8 bytes for hash.
> md: updating md4 RAID superblock on device
> md: md21 [events: 0000004f]<6>(write) md21's sb offset: 46652608
> md: md11 [events: 0000004f]<6>(write) md11's sb offset: 46652608
> md: ... autorun DONE.
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS 2.4-0.9.18, 14 May 2002 on md(9,4), internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS 2.4-0.9.18, 14 May 2002 on md(9,10), internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS 2.4-0.9.18, 14 May 2002 on md(9,20), internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> 
> hdparm -i output:
> (hda)
>  Model=IC35L060AVER07-0, FwRev=ER6OA44A, SerialNo=SZPTZM66557
>  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
>  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
>  BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=off
>  CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=120103200
>  IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes: pio0 pio1 pio2 pio3 pio4 
>  DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 
>  AdvancedPM=yes: disabled (255)
>  Drive Supports : ATA/ATAPI-5 T13 1321D revision 1 : ATA-2 ATA-3 ATA-4 ATA-5 
> 
> (hdc)
>  Model=IC35L060AVER07-0, FwRev=ER6OA44A, SerialNo=SZPTZM66578
>  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
>  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
>  BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=off
>  CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=120103200
>  IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes: pio0 pio1 pio2 pio3 pio4 
>  DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 
>  AdvancedPM=yes: disabled (255)
>  Drive Supports : ATA/ATAPI-5 T13 1321D revision 1 : ATA-2 ATA-3 ATA-4 ATA-5 
> 
> (hde)
>  Model=IC35L060AVER07-0, FwRev=ER6OA44A, SerialNo=SZPTZM68092
>  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
>  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
>  BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=off
>  CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=120103200
>  IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes: pio0 pio1 pio2 pio3 pio4 
>  DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5 
>  AdvancedPM=yes: disabled (255)
>  Drive Supports : ATA/ATAPI-5 T13 1321D revision 1 : ATA-2 ATA-3 ATA-4 ATA-5 
> 
> (hdg)
>  Model=IC35L060AVER07-0, FwRev=ER6OA44A, SerialNo=SZPTZM66553
>  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
>  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
>  BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=off
>  CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=120103200
>  IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes: pio0 pio1 pio2 pio3 pio4 
>  DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5 
>                                           ^      ^^^^^^^^^^^^^^^^^
> -> first time this appears (missing in 2.4.19 and before). Joy and happyness.
> 
>  AdvancedPM=yes: disabled (255)
>  Drive Supports : ATA/ATAPI-5 T13 1321D revision 1 : ATA-2 ATA-3 ATA-4 ATA-5 
> 
> hde used to be automatically set at udma5 so far but I'm well happy with 
> udma2.
> 
> Nice work. Thanks.
> 
> -- 
> Ueimor
> 

