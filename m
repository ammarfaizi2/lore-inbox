Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267773AbTBVCWX>; Fri, 21 Feb 2003 21:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267777AbTBVCWX>; Fri, 21 Feb 2003 21:22:23 -0500
Received: from services.cam.org ([198.73.180.252]:63607 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S267773AbTBVCWM>;
	Fri, 21 Feb 2003 21:22:12 -0500
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: 2.5.62-mm2
Date: Fri, 21 Feb 2003 21:32:08 -0500
User-Agent: KMail/1.5.9
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
References: <20030220234733.3d4c5e6d.akpm@digeo.com> <200302212048.09802.tomlins@cam.org> <3E56D954.90803@cyberone.com.au>
In-Reply-To: <3E56D954.90803@cyberone.com.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200302212132.08827.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 21, 2003 08:58 pm, Nick Piggin wrote:
> Ed Tomlinson wrote:
> >On February 21, 2003 02:47 am, Andrew Morton wrote:
> >>So this tree has three elevators (apart from the no-op elevator).  You
> >> can select between them via the kernel boot commandline:
> >>
> >>        elevator=as
> >>        elevator=cfq
> >>        elevator=deadline
> >
> >Has anyone been having problems booting with 'as'?  It hangs here at the
> > point root gets mounted readonly.  cfq works ok.
>
> What sort of disk controller arrangement and drivers are you using?
>
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>

Here is the startup with cfq:

Feb 21 20:25:53 oscar syslogd 1.4.1#11: restart.
Feb 21 20:25:53 oscar kernel: klogd 1.4.1#11, log source = /proc/kmsg started.
Feb 21 20:25:53 oscar kernel: Inspecting /boot/System.map-2.5.59
Feb 21 20:25:54 oscar kernel: Loaded 19096 symbols from /boot/System.map-2.5.59.
Feb 21 20:25:54 oscar kernel: Symbols match kernel version 2.5.59.
Feb 21 20:25:54 oscar kernel: No module symbols loaded - kernel modules not enabled.
Feb 21 20:25:54 oscar kernel: Linux version 2.5.59 (ed@oscar) (gcc version 2.95.4 20011002 (Debian prerelease)) #4 Tue Jan 21 20:28:50 EST 2003
Feb 21 20:25:54 oscar kernel: Video mode to be used for restore is f00
Feb 21 20:25:54 oscar kernel: BIOS-provided physical RAM map:
Feb 21 20:25:54 oscar kernel:  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
Feb 21 20:25:54 oscar kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Feb 21 20:25:54 oscar kernel:  BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
Feb 21 20:25:54 oscar kernel:  BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
Feb 21 20:25:54 oscar kernel:  BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
Feb 21 20:25:54 oscar kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Feb 21 20:25:54 oscar kernel: 511MB LOWMEM available.
Feb 21 20:25:54 oscar kernel: On node 0 totalpages: 131056
Feb 21 20:25:54 oscar kernel:   DMA zone: 4096 pages, LIFO batch:1
Feb 21 20:25:54 oscar kernel:   Normal zone: 126960 pages, LIFO batch:16
Feb 21 20:25:54 oscar kernel:   HighMem zone: 0 pages, LIFO batch:1
Feb 21 20:25:54 oscar kernel: Building zonelist for node : 0
Feb 21 20:25:54 oscar kernel: Kernel command line: BOOT_IMAGE=59 ro root=2103 console=tty0 console=ttyS0,38400 idebus=33 profile=1
Feb 21 20:25:54 oscar kernel: ide_setup: idebus=33
Feb 21 20:25:54 oscar kernel: kernel profiling enabled
Feb 21 20:25:54 oscar kernel: Initializing CPU#0
Feb 21 20:25:54 oscar kernel: PID hash table entries: 2048 (order 11: 16384 bytes)
Feb 21 20:25:54 oscar kernel: Detected 400.850 MHz processor.
Feb 21 20:25:54 oscar kernel: Console: colour VGA+ 80x25
Feb 21 20:25:54 oscar kernel: Calibrating delay loop... 790.52 BogoMIPS
Feb 21 20:25:54 oscar kernel: Memory: 513328k/524224k available (1324k kernel code, 10140k reserved, 713k data, 80k init, 0k highmem)
Feb 21 20:25:54 oscar kernel: Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Feb 21 20:25:54 oscar kernel: Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Feb 21 20:25:54 oscar kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Feb 21 20:25:54 oscar kernel: -> /dev
Feb 21 20:25:54 oscar kernel: -> /dev/console
Feb 21 20:25:54 oscar kernel: -> /root
Feb 21 20:25:54 oscar kernel: Enabling new style K6 write allocation for 511 Mb
Feb 21 20:25:54 oscar kernel: CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
Feb 21 20:25:54 oscar kernel: CPU: L2 Cache: 256K (32 bytes/line)
Feb 21 20:25:54 oscar kernel: CPU: AMD-K6(tm) 3D+ Processor stepping 01
Feb 21 20:25:54 oscar kernel: Checking 'hlt' instruction... OK.
Feb 21 20:25:54 oscar kernel: POSIX conformance testing by UNIFIX
Feb 21 20:25:54 oscar kernel: Linux NET4.0 for Linux 2.4
Feb 21 20:25:54 oscar kernel: Based upon Swansea University Computer Society NET3.039
Feb 21 20:25:54 oscar kernel: Initializing RT netlink socket
Feb 21 20:25:54 oscar kernel: mtrr: v2.0 (20020519)
Feb 21 20:25:54 oscar kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb520, last bus=1
Feb 21 20:25:54 oscar kernel: PCI: Using configuration type 1
Feb 21 20:25:54 oscar kernel: BIO: pool of 256 setup, 15Kb (60 bytes/bio)
Feb 21 20:25:54 oscar kernel: biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
Feb 21 20:25:54 oscar kernel: biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
Feb 21 20:25:54 oscar kernel: biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
Feb 21 20:25:54 oscar kernel: biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
Feb 21 20:25:54 oscar kernel: biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
Feb 21 20:25:54 oscar kernel: biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
Feb 21 20:25:54 oscar kernel: Linux Plug and Play Support v0.94 (c) Adam Belay
Feb 21 20:25:54 oscar kernel: pnp: Enabling Plug and Play Card Services.
Feb 21 20:25:54 oscar kernel: PnPBIOS: Found PnP BIOS installation structure at 0xc00fc160
Feb 21 20:25:54 oscar kernel: PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xc188, dseg 0xf0000
Feb 21 20:25:54 oscar kernel: PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
Feb 21 20:25:54 oscar kernel: isapnp: Scanning for PnP cards...
Feb 21 20:25:54 oscar kernel: isapnp: No Plug & Play device found
Feb 21 20:25:54 oscar kernel: block request queues:
Feb 21 20:25:54 oscar kernel:  128 requests per read queue
Feb 21 20:25:54 oscar kernel:  128 requests per write queue
Feb 21 20:25:54 oscar kernel:  8 requests per batch
Feb 21 20:25:54 oscar kernel:  enter congestion at 15Feb 21 20:25:54 oscar kernel:  exit congestion at 17
Feb 21 20:25:54 oscar kernel: drivers/usb/core/usb.c: registered new driver usbfs
Feb 21 20:25:54 oscar kernel: drivers/usb/core/usb.c: registered new driver hub
Feb 21 20:25:54 oscar kernel: PCI: Probing PCI hardware
Feb 21 20:25:54 oscar kernel: PCI: Probing PCI hardware (bus 00)
Feb 21 20:25:54 oscar kernel: PCI: Using IRQ router VIA [1106/0586] at 00:07.0
Feb 21 20:25:54 oscar kernel: aio_setup: sizeof(struct page) = 40
Feb 21 20:25:54 oscar kernel: Journalled Block Device driver loaded
Feb 21 20:25:54 oscar kernel: Initializing Cryptographic API
Feb 21 20:25:54 oscar kernel: Activating ISA DMA hang workarounds.
Feb 21 20:25:54 oscar kernel: Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
Feb 21 20:25:54 oscar kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Feb 21 20:25:54 oscar kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Feb 21 20:25:54 oscar kernel: ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
Feb 21 20:25:54 oscar kernel: pty: 256 Unix98 ptys configured
Feb 21 20:25:54 oscar kernel: Linux agpgart interface v0.100 (c) Dave Jones
Feb 21 20:25:54 oscar kernel: agpgart: Detected VIA MVP3 chipset
Feb 21 20:25:54 oscar kernel: agpgart: Maximum main memory to use for agp memory: 439M
Feb 21 20:25:54 oscar kernel: agpgart: AGP aperture is 64M @ 0xe0000000
Feb 21 20:25:54 oscar kernel: [drm] Initialized mga 3.1.0 20021029 on minor 0
Feb 21 20:25:54 oscar kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Feb 21 20:25:54 oscar kernel: ide: Assuming 33MHz system bus speed for PIO modes
Feb 21 20:25:54 oscar kernel: VP_IDE: IDE controller at PCI slot 00:07.1
Feb 21 20:25:54 oscar kernel: VP_IDE: chipset revision 6
Feb 21 20:25:54 oscar kernel: VP_IDE: not 100%% native mode: will probe irqs later
Feb 21 20:25:54 oscar kernel: VP_IDE: VIA vt82c586b (rev 47) IDE UDMA33 controller on pci00:07.1
Feb 21 20:25:54 oscar kernel:     ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:DMA
Feb 21 20:25:54 oscar kernel:     ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:DMA, hdd:DMA
Feb 21 20:25:54 oscar kernel: hda: QUANTUM FIREBALLP KA13.6, ATA DISK drive
Feb 21 20:25:54 oscar kernel: hda: DMA disabled
Feb 21 20:25:54 oscar kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Feb 21 20:25:54 oscar kernel: hdc: AOPEN 16XDVD-ROM/AMH 20020328, ATAPI CD/DVD-ROM drive
Feb 21 20:25:54 oscar kernel: hdd: HP COLORADO 20GB, ATAPI TAPE drive
Feb 21 20:25:54 oscar kernel: hdc: DMA disabled
Feb 21 20:25:54 oscar kernel: hdd: DMA disabledFeb 21 20:25:54 oscar kernel: ide1 at 0x170-0x177,0x376 on irq 15
Feb 21 20:25:54 oscar kernel: PDC20267: IDE controller at PCI slot 00:09.0
Feb 21 20:25:54 oscar kernel: PCI: Found IRQ 12 for device 00:09.0
Feb 21 20:25:54 oscar kernel: PDC20267: chipset revision 2
Feb 21 20:25:54 oscar kernel: PDC20267: not 100%% native mode: will probe irqs later
Feb 21 20:25:54 oscar kernel: PDC20267: ROM enabled at 0xeb000000
Feb 21 20:25:54 oscar kernel: PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
Feb 21 20:25:54 oscar kernel:     ide2: BM-DMA at 0xbc00-0xbc07, BIOS settings: hde:DMA, hdf:pio
Feb 21 20:25:54 oscar kernel:     ide3: BM-DMA at 0xbc08-0xbc0f, BIOS settings: hdg:DMA, hdh:DMA
Feb 21 20:25:54 oscar kernel: hde: QUANTUM FIREBALLP AS40.0, ATA DISK drive
Feb 21 20:25:54 oscar kernel: ide2 at 0xac00-0xac07,0xb002 on irq 12
Feb 21 20:25:54 oscar kernel: hdg: QUANTUM FIREBALLP AS40.0, ATA DISK drive
Feb 21 20:25:54 oscar kernel: ide3 at 0xb400-0xb407,0xb802 on irq 12
Feb 21 20:25:54 oscar kernel: hda: host protected area => 1
Feb 21 20:25:54 oscar kernel: hda: 27067824 sectors (13859 MB) w/371KiB Cache, CHS=26853/16/63, UDMA(33)
Feb 21 20:25:54 oscar kernel:  hda: hda1 hda2 hda3 hda4 < hda5 >
Feb 21 20:25:54 oscar kernel: hde: host protected area => 1
Feb 21 20:25:54 oscar kernel: hde: 78177792 sectors (40027 MB) w/1902KiB Cache, CHS=77557/16/63, UDMA(100)
Feb 21 20:25:54 oscar kernel:  hde: hde1 hde2 hde3 hde4 < hde5 >
Feb 21 20:25:54 oscar kernel: hdg: host protected area => 1
Feb 21 20:25:54 oscar kernel: hdg: 78177792 sectors (40027 MB) w/1902KiB Cache, CHS=77557/16/63, UDMA(100)
Feb 21 20:25:54 oscar kernel:  hdg: hdg1 hdg2 hdg3 hdg4 < hdg5 >
Feb 21 20:25:54 oscar kernel: drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
Feb 21 20:25:54 oscar kernel: uhci-hcd 00:07.2: VIA Technologies, In USB
Feb 21 20:25:54 oscar kernel: uhci-hcd 00:07.2: irq 10, io base 0000a400
Feb 21 20:25:54 oscar kernel: Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
Feb 21 20:25:54 oscar kernel: uhci-hcd 00:07.2: new USB bus registered, assigned bus number 1
Feb 21 20:25:54 oscar kernel: hub 1-0:0: USB hub found
Feb 21 20:25:54 oscar kernel: hub 1-0:0: 2 ports detected
Feb 21 20:25:54 oscar kernel: mice: PS/2 mouse device common for all mice
Feb 21 20:25:54 oscar kernel: input: AT Set 2 keyboard on isa0060/serio0
Feb 21 20:25:54 oscar kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Feb 21 20:25:54 oscar kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Feb 21 20:25:54 oscar kernel: IP: routing cache hash table of 4096 buckets, 32Kbytes
Feb 21 20:25:54 oscar kernel: TCP: Hash tables configured (established 32768 bind 32768)
Feb 21 20:36:21 oscar kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Feb 21 20:36:21 oscar kernel: found reiserfs format "3.6" with standard journal
Feb 21 20:36:21 oscar kernel: Reiserfs journal params: device ide2(33,3), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Feb 21 20:36:21 oscar kernel: reiserfs: checking transaction log (ide2(33,3)) for (ide2(33,3))
Feb 21 20:36:21 oscar kernel: Using r5 hash to sort names
Feb 21 20:36:21 oscar kernel: VFS: Mounted root (reiserfs filesystem) readonly.
Feb 21 20:36:21 oscar kernel: Freeing unused kernel memory: 80k freed

AS stops here.

Feb 21 20:36:21 oscar kernel: hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
Feb 21 20:36:21 oscar kernel: hub 1-0:0: new USB device on port 1, assigned address 2
Feb 21 20:36:21 oscar kernel: hub 1-1:0: USB hub found
Feb 21 20:36:21 oscar kernel: hub 1-1:0: 4 ports detected
Feb 21 20:36:21 oscar kernel: hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x301
Feb 21 20:36:21 oscar kernel: hub 1-0:0: new USB device on port 2, assigned address 3
Feb 21 20:36:21 oscar kernel: hub 1-1:0: debounce: port 1: delay 100ms stable 4 status 0x101
Feb 21 20:36:21 oscar kernel: hub 1-1:0: new USB device on port 1, assigned address 4
Feb 21 20:36:21 oscar kernel: hub 1-1:0: debounce: port 4: delay 100ms stable 4 status 0x101
Feb 21 20:36:21 oscar kernel: hub 1-1:0: new USB device on port 4, assigned address 5
Feb 21 20:36:21 oscar kernel: Adding 393552k swap on /dev/hda1.  Priority:1 extents:1
Feb 21 20:36:21 oscar kernel: Adding 393584k swap on /dev/hde1.  Priority:1 extents:1
Feb 21 20:36:21 oscar kernel: Adding 393584k swap on /dev/hdg1.  Priority:1 extents:1
Feb 21 20:36:21 oscar kernel: drivers/usb/serial/usb-serial.c: USB Serial support registered for PL-2303
Feb 21 20:36:21 oscar kernel: Initializing USB Mass Storage driver...
Feb 21 20:36:21 oscar kernel: input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse<AE> Optical] on usb-00:07.2-2
Feb 21 20:36:21 oscar kernel: drivers/usb/core/usb.c: registered new driver hid
Feb 21 20:36:21 oscar kernel: drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Feb 21 20:36:21 oscar kernel: drivers/usb/core/usb.c: registered new driver usbserial
Feb 21 20:36:21 oscar kernel: drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
Feb 21 20:36:21 oscar kernel: pl2303 1-1.1:0: PL-2303 hack: descriptors matched but endpoints did not
Feb 21 20:36:21 oscar kernel: pl2303 1-1.1:1: PL-2303 converter detected
Feb 21 20:36:21 oscar kernel: usb 1-1.1: PL-2303 converter now attached to ttyUSB0 (or usb/tts/0 for devfs)
Feb 21 20:36:21 oscar kernel: drivers/usb/core/usb.c: registered new driver pl2303
Feb 21 20:36:21 oscar kernel: drivers/usb/serial/pl2303.c: Prolific PL2303 USB to serial adaptor driver v0.9
Feb 21 20:36:21 oscar kernel: scsi0 : SCSI emulation for USB Mass Storage devices
Feb 21 20:36:21 oscar kernel: CFQ elevator

Root is on hde3 - If its jiffies it would probably have to be in the AS code since 
CFQ seems to work fine.

Ed











