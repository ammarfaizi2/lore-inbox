Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261292AbTBJDMv>; Sun, 9 Feb 2003 22:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261302AbTBJDMv>; Sun, 9 Feb 2003 22:12:51 -0500
Received: from h68-146-142-19.cg.shawcable.net ([68.146.142.19]:51074 "EHLO
	h68-146-142-19.localdomain") by vger.kernel.org with ESMTP
	id <S261292AbTBJDMo>; Sun, 9 Feb 2003 22:12:44 -0500
Subject: Re: [Fwd: SCSI-IDE crash in 2.4.21pre4]
From: Kim Lux <lux@diesel-research.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1044772315.1102.24.camel@h68-146-142-19.localdomain>
References: <1044772315.1102.24.camel@h68-146-142-19.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044847348.3767.20.camel@h68-146-142-19.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 09 Feb 2003 20:22:28 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One more thing: a bunch of us cdparanoia users got together and compared
notes.  All the computers that are having the problem are running the
SIS735 chipset.   We suspect a kernel bug in that driver.

Let me know if there is anything else we can do to help.

BTW: I think that Linux rocks !  You kernel developers/ debuggers/
supporters do an outstanding job.  

THANKS !

Kim  



On Sat, 2003-02-08 at 23:31, Kim Lux wrote:
> -----Forwarded Message-----
> 
> > From: Kim Lux <lux@diesel-research.com>
> > To: linux-kernel@verger.kernel.org
> > Subject: SCSI-IDE crash in 2.4.21pre4
> > Date: 08 Feb 2003 23:27:23 -0700
> > 
> > One Line Summary:
> > 
> > SCSI IDE emulation crashes RH8 computer running 2.4.21 pre4.
> > 
> > Full Description of Problem:
> > 
> > I've had this problem for months.  
> > 
> > If I run CDParanoia and try to rip CDs, it will work OK for a few
> > minutes and then start crashing, giving all sorts of SCSI timeout
> > errors, SCSI comm errors, etc. (Let me know if you want these; I'll get
> > them.)  I get the same or similar errors with KSCD as well.  This is
> > extremely frustrating. 
> > 
> > I get the error with all kernels, 2.4.18-18.8.0 through 2.4.21 pre-4,
> > although 2.4.21 freezes entirely and cannot be killed, whereas all
> > kernels prior to this allow the process to be killed.  For some reason
> > the process survives a login and reboot with 2.4.21 pre 4, whereas it
> > stops running with all previous kernels.  
> > 
> > I've tried 2 motherboards and 2 hd cables, with the same effect.  The
> > computer this occurs on is otherwise stable, with uptimes of several
> > months at a time.
> > 
> > I might have the links/permissions messed up in /dev from trying to fix
> > this problem. I also disabled the CD automount command in
> > .kde/autostart.  
> > 
> > I've been through the CDParanoia doc several times and have tried
> > various kernels with various SCSI-IDE config setups.  I know that ATAPI
> > CDROM must be disabled to work with CDParanoia.  I believe I've got that
> > set up right as CD Paranoia finds (or used to find) the CDROM player. It
> > does rip CDs, but will crash.  I strongly believe this is a kernel
> > problem and not a CDParanoia problem or a hardware problem. 
> > 
> > Keywords:
> > 2.4.20
> > 2.4.21-pre4
> > SCSI-IDE Emulation
> > CDParanoia
> > KSCD
> > 
> > Kernel Version:
> > Linux version 2.4.20 (root@h68-146-142-19) (gcc version 3.2 20020903
> > (Red Hat Linux 8.0 3.2-7)) #2 Mon Dec 2 11:09:28 MST 2002   
> >  
> > As I stated before, 2.4.21 becomes unstable on login; I cannot run it
> > anymore as I can't kill the process.
> > 
> > Output of Oops: don't have it.  I got dmesg errors on boot, on
> > /dev/hda.  See dmesg output below. 
> > 
> > A small shell script that triggers the problem:
> > > CDParanoia -svB or run KSCD.
> > 
> > Environment: (see below) Running KDE.  Everything stable otherwise. 
> > 
> > Software: 
> > 
> > If some fields are empty or look unusual you may have an old version.
> > Compare to the current minimal requirements in Documentation/Changes.
> > 
> > Linux h68-146-142-19 2.4.20 #2 Mon Dec 2 11:09:28 MST 2002 i686 athlon
> > i386 GNU/Linux
> > 
> > Gnu C                  3.2
> > Gnu make               3.79.1
> > util-linux             2.11r
> > mount                  2.11r
> > modutils               2.4.18
> > e2fsprogs              1.27
> > jfsutils               1.0.17
> > reiserfsprogs          3.6.2
> > pcmcia-cs              3.1.31
> > PPP                    2.4.1
> > isdn4k-utils           3.1pre4
> > Linux C Library        2.2.93
> > Dynamic linker (ldd)   2.2.93
> > Procps                 2.0.7
> > Net-tools              1.60
> > Kbd                    1.06
> > Sh-utils               2.0.12
> > Modules Loaded         emu10k1 ac97_codec sound soundcore parport_pc lp
> > parport autofs sis900 ipt_REJECT iptable_filter ip_tables ide-scsi
> > usb-storage scsi_mod mousedev keybdev input hid usb-ohci usbcore ext3
> > jbd
> > 
> > Processor:
> > 
> > If some fields are empty or look unusual you may have an old version.
> > Compare to the current minimal requirements in Documentation/Changes.
> > 
> > Linux h68-146-142-19 2.4.20 #2 Mon Dec 2 11:09:28 MST 2002 i686 athlon
> > i386 GNU/Linux
> > 
> > Gnu C                  3.2
> > Gnu make               3.79.1
> > util-linux             2.11r
> > mount                  2.11r
> > modutils               2.4.18
> > e2fsprogs              1.27
> > jfsutils               1.0.17
> > reiserfsprogs          3.6.2
> > pcmcia-cs              3.1.31
> > PPP                    2.4.1
> > isdn4k-utils           3.1pre4
> > Linux C Library        2.2.93
> > Dynamic linker (ldd)   2.2.93
> > Procps                 2.0.7
> > Net-tools              1.60
> > Kbd                    1.06
> > Sh-utils               2.0.12
> > Modules Loaded         emu10k1 ac97_codec sound soundcore parport_pc lp
> > parport autofs sis900 ipt_REJECT iptable_filter ip_tables ide-scsi
> > usb-storage scsi_mod mousedev keybdev input hid usb-ohci usbcore ext3
> > jbd
> > 
> > 
> > Module Information:
> > 
> > If some fields are empty or look unusual you may have an old version.
> > Compare to the current minimal requirements in Documentation/Changes.
> > 
> > Linux h68-146-142-19 2.4.20 #2 Mon Dec 2 11:09:28 MST 2002 i686 athlon
> > i386 GNU/Linux
> > 
> > Gnu C                  3.2
> > Gnu make               3.79.1
> > util-linux             2.11r
> > mount                  2.11r
> > modutils               2.4.18
> > e2fsprogs              1.27
> > jfsutils               1.0.17
> > reiserfsprogs          3.6.2
> > pcmcia-cs              3.1.31
> > PPP                    2.4.1
> > isdn4k-utils           3.1pre4
> > Linux C Library        2.2.93
> > Dynamic linker (ldd)   2.2.93
> > Procps                 2.0.7
> > Net-tools              1.60
> > Kbd                    1.06
> > Sh-utils               2.0.12
> > Modules Loaded         emu10k1 ac97_codec sound soundcore parport_pc lp
> > parport autofs sis900 ipt_REJECT iptable_filter ip_tables ide-scsi
> > usb-storage scsi_mod mousedev keybdev input hid usb-ohci usbcore ext3
> > jbd
> > 
> > 
> > I'd be glad to forward any other info you might like to see.  I could
> > also set up a user so that you could vnc or ssh into my computer.  I'd
> > have to have some verification of your identity before I'd allow that...
> > 
> > Thanks.
> > 
> > Kim Lux
> > (403) 282-5836 (home)
> > (403) 210-1230 ext 300 (work) 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > [krlux@h68-146-142-19 /]$ dmesg
> > Linux version 2.4.20 (root@h68-146-142-19) (gcc version 3.2 20020903
> > (Red Hat Linux 8.0 3.2-7)) #2 Mon Dec 2 11:09:28 MST 2002
> > BIOS-provided physical RAM map:
> >  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
> >  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
> >  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
> >  BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
> >  BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
> >  BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
> >  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
> >  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
> >  BIOS-e820: 00000000ffee0000 - 00000000fff00000 (reserved)
> >  BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
> > 511MB LOWMEM available.
> > On node 0 totalpages: 131056
> > zone(0): 4096 pages.
> > zone(1): 126960 pages.
> > zone(2): 0 pages.
> > Kernel command line: ro root=LABEL=/ hdd=ide-scsi
> > ide_setup: hdd=ide-scsi
> > Initializing CPU#0
> > Detected 1659.627 MHz processor.
> > Console: colour VGA+ 80x25
> > Calibrating delay loop... 3316.12 BogoMIPS
> > Memory: 516100k/524224k available (1146k kernel code, 7736k reserved,
> > 452k data, 112k init, 0k highmem)
> > Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
> > Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
> > Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
> > Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
> > Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
> > CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> > CPU: L2 Cache: 256K (64 bytes/line)
> > Intel machine check architecture supported.
> > Intel machine check reporting enabled on CPU#0.
> > CPU:     After generic, caps: 0383f9ff c1c3f9ff 00000000 00000000
> > CPU:             Common caps: 0383f9ff c1c3f9ff 00000000 00000000
> > CPU: AMD Athlon(tm) XP 2000+ stepping 02
> > Enabling fast FPU save and restore... done.
> > Enabling unmasked SIMD FPU exception support... done.
> > Checking 'hlt' instruction... OK.
> > POSIX conformance testing by UNIFIX
> > mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
> > mtrr: detected mtrr type: Intel
> > PCI: PCI BIOS revision 2.10 entry at 0xfdb01, last bus=1
> > PCI: Using configuration type 1
> > PCI: Probing PCI hardware
> > PCI: Using IRQ router SIS [1039/0008] at 00:02.0
> > isapnp: Scanning for PnP cards...
> > isapnp: No Plug & Play device found
> > Linux NET4.0 for Linux 2.4
> > Based upon Swansea University Computer Society NET3.039
> > Initializing RT netlink socket
> > apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
> > Starting kswapd
> > VFS: Diskquotas version dquot_6.4.0 initialized
> > pty: 512 Unix98 ptys configured
> > Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT
> > SHARE_IRQ SERIAL_PCI ISAPNP enabled
> > ttyS00 at 0x03f8 (irq = 4) is a 16550A
> > ttyS01 at 0x02f8 (irq = 3) is a 16550A
> > Real Time Clock Driver v1.10e
> > Uniform Multi-Platform E-IDE driver Revision: 6.31
> > ide: Assuming 33MHz system bus speed for PIO modes; override with
> > idebus=xx
> > SIS5513: IDE controller on PCI bus 00 dev 15
> > SIS5513: chipset revision 208
> > SIS5513: not 100% native mode: will probe irqs later
> > SiS735
> >     ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
> >     ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
> > hda: Maxtor 6Y060L0, ATA DISK drive
> > hdd: CREATIVE CD2423E, ATAPI CD/DVD-ROM drive
> > ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> > ide1 at 0x170-0x177,0x376 on irq 15
> > blk: queue c02d5a44, I/O limit 4095Mb (mask 0xffffffff)
> > hda: 120103200 sectors (61493 MB) w/2048KiB Cache, CHS=7476/255/63,
> > UDMA(100)
> > ide-floppy driver 0.99.newide
> > Partition check:
> >  hda:hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> > hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> > hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> > hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> > hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> > hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> > hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> > hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> > ide0: reset: success
> > hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> > hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> > hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> > hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> > hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> > hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> > hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> > hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> > ide0: reset: success
> >  hda1 hda2 hda3
> > Floppy drive(s): fd0 is 1.44M
> > FDC 0 is a post-1991 82077
> > NET4: Frame Diverter 0.46
> > RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> > ide-floppy driver 0.99.newide
> > md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
> > md: Autodetecting RAID arrays.
> > md: autorun ...
> > md: ... autorun DONE.
> > NET4: Linux TCP/IP 1.0 for NET4.0
> > IP Protocols: ICMP, UDP, TCP, IGMP
> > IP: routing cache hash table of 4096 buckets, 32Kbytes
> > TCP: Hash tables configured (established 32768 bind 65536)
> > Linux IP multicast router 0.06 plus PIM-SM
> > NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> > RAMDISK: Compressed image found at block 0
> > Freeing initrd memory: 126k freed
> > VFS: Mounted root (ext2 filesystem).
> > Journalled Block Device driver loaded
> > EXT3-fs: INFO: recovery required on readonly filesystem.
> > EXT3-fs: write access will be enabled during recovery.
> > kjournald starting.  Commit interval 5 seconds
> > EXT3-fs: recovery complete.
> > EXT3-fs: mounted filesystem with ordered data mode.
> > Freeing unused kernel memory: 112k freed
> > usb.c: registered new driver usbdevfs
> > usb.c: registered new driver hub
> > SiS router pirq escape (99)
> > SiS router pirq escape (99)
> > usb-ohci.c: USB OHCI at membase 0xe0844000, IRQ 11
> > usb-ohci.c: usb-00:02.3, Silicon Integrated Systems [SiS] 7001 (#2)
> > usb.c: new USB bus registered, assigned bus number 1
> > hub.c: USB hub found
> > hub.c: 3 ports detected
> > PCI: Found IRQ 11 for device 00:02.2
> > PCI: Sharing IRQ 11 with 00:0f.0
> > usb-ohci.c: USB OHCI at membase 0xe0846000, IRQ 11
> > usb-ohci.c: usb-00:02.2, Silicon Integrated Systems [SiS] 7001
> > usb.c: new USB bus registered, assigned bus number 2
> > hub.c: USB hub found
> > hub.c: 3 ports detected
> > usb.c: registered new driver hid
> > hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
> > hid-core.c: USB HID support drivers
> > mice: PS/2 mouse device common for all mice
> > EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,3), internal journal
> > Adding Swap: 1024120k swap-space (priority -1)
> > hub.c: new USB device 00:02.3-1, assigned address 2
> > usb.c: USB device 2 (vend/prod 0x4e6/0xa) is not claimed by any active
> > driver.
> > hub.c: new USB device 00:02.2-1, assigned address 2
> > : USB HID v1.10 Joystick [Logitech WingMan Attack 2] on usb2:2.0
> > kjournald starting.  Commit interval 5 seconds
> > EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
> > EXT3-fs: mounted filesystem with ordered data mode.
> > SCSI subsystem driver Revision: 1.00
> > Initializing USB Mass Storage driver...
> > usb.c: registered new driver usb-storage
> > scsi0 : SCSI emulation for USB Mass Storage devices
> >   Vendor: eUSB      Model: Compact Flash     Rev:
> >   Type:   Direct-Access                      ANSI SCSI revision: 02
> > WARNING: USB Mass Storage data integrity not assured
> > USB Mass Storage device found at 2
> > USB Mass Storage support registered.
> > scsi1 : SCSI host adapter emulation for IDE ATAPI devices
> >   Vendor: CREATIVE  Model: CD2423E  NC102    Rev: 1.02
> >   Type:   CD-ROM                             ANSI SCSI revision: 02
> > parport0: PC-style at 0x378 [PCSPP,TRISTATE]
> > parport0: Printer, Lexmark International Lexmark Optra S 1855
> > ip_tables: (C) 2000-2002 Netfilter core team
> > sis900.c: v1.08.06 9/24/2002
> > PCI: Assigned IRQ 5 for device 00:03.0
> > divert: allocating divert_blk for eth0
> > eth0: Realtek RTL8201 PHY transceiver found at address 1.
> > eth0: Using transceiver found at address 1 as default
> > eth0: SiS 900 PCI Fast Ethernet at 0xd800, IRQ 5, 00:07:95:31:18:04.
> > eth0: Media Link On 10mbps half-duplex
> > parport0: PC-style at 0x378 [PCSPP,TRISTATE]
> > parport0: Printer, Lexmark International Lexmark Optra S 1855
> > lp0: using parport0 (polling).
> > lp0: console ready
> > Creative EMU10K1 PCI Audio Driver, version 0.20, 11:01:17 Dec  2 2002
> > PCI: Found IRQ 11 for device 00:0f.0
> > PCI: Sharing IRQ 11 with 00:02.2
> > emu10k1: EMU10K1 rev 7 model 0x8064 found, IO at 0xd400-0xd41f, IRQ 11
> > ac97_codec: AC97 Audio codec, id: EMC40(Unknown)
> > emu10k1: SBLive! 5.1 card detected
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > -- 
> > Kim Lux <lux@diesel-research.com>
-- 
Kim Lux <lux@diesel-research.com>
