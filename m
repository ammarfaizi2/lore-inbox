Return-Path: <linux-kernel-owner+w=401wt.eu-S1751079AbWLVRD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWLVRD7 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 12:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbWLVRD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 12:03:58 -0500
Received: from torres.zugschlus.de ([85.10.211.154]:2817 "EHLO
	torres.zugschlus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079AbWLVRD5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 12:03:57 -0500
Date: Fri, 22 Dec 2006 18:03:55 +0100
From: Marc Haber <mh+linux-kernel@zugschlus.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 file content corruption on ext3
Message-ID: <20061222170355.GD21794@torres.zugschlus.de>
References: <20061207155740.GC1434@torres.l21.ma.zugschlus.de> <458BDDDE.8050201@gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <458BDDDE.8050201@gentoo.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 22, 2006 at 08:30:06AM -0500, Daniel Drake wrote:
> Marc Haber wrote:
> >After updating to 2.6.19, Debian's apt control file
> >/var/cache/apt/pkgcache.bin corrupts pretty frequently - like in under
> >six hours. In that situation, "aptitude update" segfaults. When I
> >delete the file and have apt recreate it, things are fine again for a
> >few hours before the file is broken again and the segfault start over.
> >In all cases, umounting the file system and doing an fsck does not
> >show issues with the file system.
> 
> Are you using wireless networking of any kind?

Since the system in question is a colocated server box, I am pretty
sure that there is no wireless networking.

>  Might be useful if you could post 'dmesg' output so that people can
>  see the other hardware that you have.

I have attached what I could scrape from syslog.

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Mannheim, Germany  |  lose things."    Winona Ryder | Fon: *49 621 72739834
Nordisch by Nature |  How to make an American Quilt | Fax: *49 621 72739835

--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=syslog

Dec 18 15:45:01 torres syslogd 1.4.1#17: restart.
Dec 18 15:45:01 torres kernel: klogd 1.4.1#17, log source = /proc/kmsg started.
Dec 18 15:45:01 torres kernel: Inspecting /boot/System.map-2.6.19.1-zgsrv
Dec 18 15:45:01 torres kernel: Loaded 26500 symbols from /boot/System.map-2.6.19.1-zgsrv.
Dec 18 15:45:01 torres kernel: Symbols match kernel version 2.6.19.
Dec 18 15:45:01 torres kernel: No module symbols loaded - kernel modules not enabled. 
Dec 18 15:45:01 torres kernel: Linux version 2.6.19.1-zgsrv (mh@nechayev) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #1 Sun Dec 17 12:44:56 UTC 2006
Dec 18 15:45:01 torres kernel: BIOS-provided physical RAM map:
Dec 18 15:45:01 torres kernel:  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
Dec 18 15:45:01 torres kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Dec 18 15:45:01 torres kernel:  BIOS-e820: 0000000000100000 - 000000000f7f0000 (usable)
Dec 18 15:45:01 torres kernel:  BIOS-e820: 000000000f7f0000 - 000000000f7f3000 (ACPI NVS)
Dec 18 15:45:01 torres kernel:  BIOS-e820: 000000000f7f3000 - 000000000f800000 (ACPI data)
Dec 18 15:45:01 torres kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Dec 18 15:45:01 torres kernel: 0MB HIGHMEM available.
Dec 18 15:45:01 torres kernel: 247MB LOWMEM available.
Dec 18 15:45:01 torres kernel: Entering add_active_range(0, 0, 63472) 0 entries of 256 used
Dec 18 15:45:01 torres kernel: Zone PFN ranges:
Dec 18 15:45:01 torres kernel:   DMA             0 ->     4096
Dec 18 15:45:01 torres kernel:   Normal       4096 ->    63472
Dec 18 15:45:01 torres kernel:   HighMem     63472 ->    63472
Dec 18 15:45:01 torres kernel: early_node_map[1] active PFN ranges
Dec 18 15:45:01 torres kernel:     0:        0 ->    63472
Dec 18 15:45:01 torres kernel: On node 0 totalpages: 63472
Dec 18 15:45:01 torres kernel:   DMA zone: 32 pages used for memmap
Dec 18 15:45:01 torres kernel:   DMA zone: 0 pages reserved
Dec 18 15:45:01 torres kernel:   DMA zone: 4064 pages, LIFO batch:0
Dec 18 15:45:01 torres kernel:   Normal zone: 463 pages used for memmap
Dec 18 15:45:01 torres kernel:   Normal zone: 58913 pages, LIFO batch:15
Dec 18 15:45:01 torres kernel:   HighMem zone: 0 pages used for memmap
Dec 18 15:45:01 torres kernel: DMI 2.2 present.
Dec 18 15:45:01 torres kernel: ACPI: RSDP (v000 VIA694                                ) @ 0x000f8050
Dec 18 15:45:01 torres kernel: ACPI: RSDT (v001 VIA694 MSI ACPI 0x42302e31 AWRD 0x00000000) @ 0x0f7f3000
Dec 18 15:45:01 torres kernel: ACPI: FADT (v001 VIA694 MSI ACPI 0x42302e31 AWRD 0x00000000) @ 0x0f7f3040
Dec 18 15:45:01 torres kernel: ACPI: DSDT (v001 VIA694 AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
Dec 18 15:45:01 torres kernel: ACPI: PM-Timer IO Port: 0x4008
Dec 18 15:45:01 torres kernel: Allocating PCI resources starting at 10000000 (gap: 0f800000:f07f0000)
Dec 18 15:45:01 torres kernel: Detected 1466.361 MHz processor.
Dec 18 15:45:01 torres kernel: Built 1 zonelists.  Total pages: 62977
Dec 18 15:45:01 torres kernel: Kernel command line: root=/dev/hda1 ro vga=normal 
Dec 18 15:45:01 torres kernel: Enabling fast FPU save and restore... done.
Dec 18 15:45:01 torres kernel: Enabling unmasked SIMD FPU exception support... done.
Dec 18 15:45:01 torres kernel: Initializing CPU#0
Dec 18 15:45:01 torres kernel: PID hash table entries: 1024 (order: 10, 4096 bytes)
Dec 18 15:45:01 torres kernel: Console: colour VGA+ 80x25
Dec 18 15:45:01 torres kernel: Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Dec 18 15:45:01 torres kernel: Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Dec 18 15:45:01 torres kernel: Memory: 246964k/253888k available (2896k kernel code, 6368k reserved, 859k data, 204k init, 0k highmem)
Dec 18 15:45:01 torres kernel: virtual kernel memory layout:
Dec 18 15:45:01 torres kernel:     fixmap  : 0xfffea000 - 0xfffff000   (  84 kB)
Dec 18 15:45:01 torres kernel:     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
Dec 18 15:45:01 torres kernel:     vmalloc : 0xd0000000 - 0xff7fe000   ( 759 MB)
Dec 18 15:45:01 torres kernel:     lowmem  : 0xc0000000 - 0xcf7f0000   ( 247 MB)
Dec 18 15:45:01 torres kernel:       .init : 0xc04ae000 - 0xc04e1000   ( 204 kB)
Dec 18 15:45:01 torres kernel:       .data : 0xc03d40b2 - 0xc04aaff4   ( 859 kB)
Dec 18 15:45:01 torres kernel:       .text : 0xc0100000 - 0xc03d40b2   (2896 kB)
Dec 18 15:45:01 torres kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Dec 18 15:45:01 torres kernel: Calibrating delay using timer specific routine.. 2935.39 BogoMIPS (lpj=5870788)
Dec 18 15:45:01 torres kernel: Security Framework v1.0.0 initialized
Dec 18 15:45:01 torres kernel: Capability LSM initialized
Dec 18 15:45:01 torres kernel: Mount-cache hash table entries: 512
Dec 18 15:45:01 torres kernel: CPU: After generic identify, caps: 0383f9ff c1c3f9ff 00000000 00000000 00000000 00000000 00000000
Dec 18 15:45:01 torres kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Dec 18 15:45:01 torres kernel: CPU: L2 Cache: 256K (64 bytes/line)
Dec 18 15:45:01 torres kernel: CPU: After all inits, caps: 0383f9ff c1c3f9ff 00000000 00000420 00000000 00000000 00000000
Dec 18 15:45:01 torres kernel: Intel machine check architecture supported.
Dec 18 15:45:01 torres kernel: Intel machine check reporting enabled on CPU#0.
Dec 18 15:45:01 torres kernel: Compat vDSO mapped to ffffe000.
Dec 18 15:45:01 torres kernel: CPU: AMD Athlon(tm) XP 1700+ stepping 02
Dec 18 15:45:01 torres kernel: Checking 'hlt' instruction... OK.
Dec 18 15:45:01 torres kernel: ACPI: Core revision 20060707
Dec 18 15:45:01 torres kernel: ACPI: setting ELCR to 1000 (from 1c00)
Dec 18 15:45:01 torres kernel: NET: Registered protocol family 16
Dec 18 15:45:01 torres kernel: ACPI: bus type pci registered
Dec 18 15:45:01 torres kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb5c0, last bus=1
Dec 18 15:45:01 torres kernel: PCI: Using configuration type 1
Dec 18 15:45:01 torres kernel: Setting up standard PCI resources
Dec 18 15:45:01 torres kernel: ACPI: Interpreter enabled
Dec 18 15:45:01 torres kernel: ACPI: Using PIC for interrupt routing
Dec 18 15:45:01 torres kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Dec 18 15:45:01 torres kernel: PCI: Probing PCI hardware (bus 00)
Dec 18 15:45:01 torres kernel: ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
Dec 18 15:45:01 torres kernel: Disabling VIA memory write queue (PCI ID 3112, rev 00): [55] f9 & 1f -> 19
Dec 18 15:45:01 torres kernel: PCI quirk: region 6000-607f claimed by vt82c686 HW-mon
Dec 18 15:45:01 torres kernel: PCI quirk: region 5000-500f claimed by vt82c686 SMB
Dec 18 15:45:01 torres kernel: Boot video device is 0000:01:00.0
Dec 18 15:45:01 torres kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Dec 18 15:45:01 torres kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
Dec 18 15:45:01 torres kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *0, disabled.
Dec 18 15:45:01 torres kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *0, disabled.
Dec 18 15:45:01 torres kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
Dec 18 15:45:01 torres kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Dec 18 15:45:01 torres kernel: pnp: PnP ACPI init
Dec 18 15:45:01 torres kernel: pnp: PnP ACPI: found 11 devices
Dec 18 15:45:01 torres kernel: PnPBIOS: Disabled by ACPI PNP
Dec 18 15:45:01 torres kernel: SCSI subsystem initialized
Dec 18 15:45:01 torres kernel: usbcore: registered new interface driver usbfs
Dec 18 15:45:01 torres kernel: usbcore: registered new interface driver hub
Dec 18 15:45:01 torres kernel: usbcore: registered new device driver usb
Dec 18 15:45:01 torres kernel: PCI: Using ACPI for IRQ routing
Dec 18 15:45:01 torres kernel: PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Dec 18 15:45:01 torres kernel: NetLabel: Initializing
Dec 18 15:45:01 torres kernel: NetLabel:  domain hash size = 128
Dec 18 15:45:01 torres kernel: NetLabel:  protocols = UNLABELED CIPSOv4
Dec 18 15:45:01 torres kernel: NetLabel:  unlabeled traffic allowed by default
Dec 18 15:45:01 torres kernel: PCI: Bridge: 0000:00:01.0
Dec 18 15:45:01 torres kernel:   IO window: disabled.
Dec 18 15:45:01 torres kernel:   MEM window: d4000000-d6ffffff
Dec 18 15:45:01 torres kernel:   PREFETCH window: 10000000-100fffff
Dec 18 15:45:01 torres kernel: PCI: Setting latency timer of device 0000:00:01.0 to 64
Dec 18 15:45:01 torres kernel: NET: Registered protocol family 2
Dec 18 15:45:01 torres kernel: IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
Dec 18 15:45:01 torres kernel: TCP established hash table entries: 8192 (order: 3, 32768 bytes)
Dec 18 15:45:01 torres kernel: TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
Dec 18 15:45:01 torres kernel: TCP: Hash tables configured (established 8192 bind 4096)
Dec 18 15:45:01 torres kernel: TCP reno registered
Dec 18 15:45:01 torres kernel: Machine check exception polling timer started.
Dec 18 15:45:01 torres kernel: apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
Dec 18 15:45:01 torres kernel: apm: overridden by ACPI.
Dec 18 15:45:01 torres kernel: audit: initializing netlink socket (disabled)
Dec 18 15:45:01 torres kernel: audit(1166453090.432:1): initialized
Dec 18 15:45:01 torres kernel: SGI XFS with no debug enabled
Dec 18 15:45:01 torres kernel: io scheduler noop registered
Dec 18 15:45:01 torres kernel: io scheduler anticipatory registered (default)
Dec 18 15:45:01 torres kernel: io scheduler deadline registered
Dec 18 15:45:01 torres kernel: io scheduler cfq registered
Dec 18 15:45:01 torres kernel: Applying VIA southbridge workaround.
Dec 18 15:45:01 torres kernel: ACPI: Power Button (FF) [PWRF]
Dec 18 15:45:01 torres kernel: ACPI: Power Button (CM) [PWRB]
Dec 18 15:45:01 torres kernel: ACPI: Sleep Button (CM) [SLPB]
Dec 18 15:45:01 torres kernel: isapnp: Scanning for PnP cards...
Dec 18 15:45:01 torres kernel: isapnp: No Plug & Play device found
Dec 18 15:45:01 torres kernel: Linux agpgart interface v0.101 (c) Dave Jones
Dec 18 15:45:01 torres kernel: agpgart: Detected VIA KLE133 chipset
Dec 18 15:45:01 torres kernel: agpgart: AGP aperture is 64M @ 0xd0000000
Dec 18 15:45:01 torres kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
Dec 18 15:45:01 torres kernel: serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Dec 18 15:45:01 torres kernel: 00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Dec 18 15:45:01 torres kernel: FDC 0 is a post-1991 82077
Dec 18 15:45:01 torres kernel: HP CISS Driver (v 3.6.10)
Dec 18 15:45:01 torres kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Dec 18 15:45:01 torres kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Dec 18 15:45:01 torres kernel: VP_IDE: IDE controller at PCI slot 0000:00:07.1
Dec 18 15:45:01 torres kernel: VP_IDE: chipset revision 6
Dec 18 15:45:01 torres kernel: VP_IDE: not 100%% native mode: will probe irqs later
Dec 18 15:45:01 torres kernel: VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
Dec 18 15:45:01 torres kernel:     ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:pio
Dec 18 15:45:01 torres kernel:     ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:pio, hdd:pio
Dec 18 15:45:01 torres kernel: Probing IDE interface ide0...
Dec 18 15:45:01 torres kernel: hda: WDC WD400BB-75DEA0, ATA DISK drive
Dec 18 15:45:01 torres kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Dec 18 15:45:01 torres kernel: Probing IDE interface ide1...
Dec 18 15:45:01 torres kernel: Probing IDE interface ide1...
Dec 18 15:45:01 torres kernel: hda: max request size: 128KiB
Dec 18 15:45:01 torres kernel: hda: Host Protected Area detected.
Dec 18 15:45:01 torres kernel: ^Icurrent capacity is 78125000 sectors (40000 MB)
Dec 18 15:45:01 torres kernel: ^Inative  capacity is 78125040 sectors (40000 MB)
Dec 18 15:45:01 torres kernel: hda: Host Protected Area disabled.
Dec 18 15:45:01 torres kernel: hda: 78125040 sectors (40000 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
Dec 18 15:45:01 torres kernel: hda: cache flushes not supported
Dec 18 15:45:01 torres kernel:  hda: hda1 hda2 hda3
Dec 18 15:45:01 torres kernel: 3ware Storage Controller device driver for Linux v1.26.02.001.
Dec 18 15:45:01 torres kernel: usbmon: debugfs is not available
Dec 18 15:45:01 torres kernel: ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
Dec 18 15:45:01 torres kernel: USB Universal Host Controller Interface driver v3.0
Dec 18 15:45:01 torres kernel: usbcore: registered new interface driver hiddev
Dec 18 15:45:01 torres kernel: usbcore: registered new interface driver usbhid
Dec 18 15:45:01 torres kernel: drivers/usb/input/hid-core.c: v2.6:USB HID core driver
Dec 18 15:45:01 torres kernel: usbcore: registered new interface driver usbserial
Dec 18 15:45:01 torres kernel: drivers/usb/serial/usb-serial.c: USB Serial support registered for generic
Dec 18 15:45:01 torres kernel: usbcore: registered new interface driver usbserial_generic
Dec 18 15:45:01 torres kernel: drivers/usb/serial/usb-serial.c: USB Serial Driver core
Dec 18 15:45:01 torres kernel: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
Dec 18 15:45:01 torres kernel: PNP: PS/2 controller doesn't have AUX irq; using default 12
Dec 18 15:45:01 torres kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Dec 18 15:45:01 torres kernel: mice: PS/2 mouse device common for all mice
Dec 18 15:45:01 torres kernel: md: raid1 personality registered for level 1
Dec 18 15:45:01 torres kernel: raid6: int32x1    558 MB/s
Dec 18 15:45:01 torres kernel: raid6: int32x2    565 MB/s
Dec 18 15:45:01 torres kernel: raid6: int32x4    405 MB/s
Dec 18 15:45:01 torres kernel: raid6: int32x8    421 MB/s
Dec 18 15:45:01 torres kernel: raid6: mmxx1     1169 MB/s
Dec 18 15:45:01 torres kernel: raid6: mmxx2     1870 MB/s
Dec 18 15:45:01 torres kernel: raid6: sse1x1     586 MB/s
Dec 18 15:45:01 torres kernel: raid6: sse1x2    1178 MB/s
Dec 18 15:45:01 torres kernel: raid6: using algorithm sse1x2 (1178 MB/s)
Dec 18 15:45:01 torres kernel: md: raid6 personality registered for level 6
Dec 18 15:45:01 torres kernel: md: raid5 personality registered for level 5
Dec 18 15:45:01 torres kernel: md: raid4 personality registered for level 4
Dec 18 15:45:01 torres kernel: raid5: automatically using best checksumming function: pIII_sse
Dec 18 15:45:01 torres kernel:    pIII_sse  :  3401.000 MB/sec
Dec 18 15:45:01 torres kernel: raid5: using function: pIII_sse (3401.000 MB/sec)
Dec 18 15:45:01 torres kernel: device-mapper: ioctl: 4.10.0-ioctl (2006-09-14) initialised: dm-devel@redhat.com
Dec 18 15:45:01 torres kernel: TCP cubic registered
Dec 18 15:45:01 torres kernel: NET: Registered protocol family 1
Dec 18 15:45:01 torres kernel: NET: Registered protocol family 17
Dec 18 15:45:01 torres kernel: NET: Registered protocol family 15
Dec 18 15:45:01 torres kernel: Using IPI Shortcut mode
Dec 18 15:45:01 torres kernel: ACPI: (supports S0 S1 S4 S5)
Dec 18 15:45:01 torres kernel: Time: tsc clocksource has been installed.
Dec 18 15:45:01 torres kernel: input: AT Translated Set 2 keyboard as /class/input/input0
Dec 18 15:45:01 torres kernel: md: Autodetecting RAID arrays.
Dec 18 15:45:01 torres kernel: md: autorun ...
Dec 18 15:45:01 torres kernel: md: ... autorun DONE.
Dec 18 15:45:01 torres kernel: kjournald starting.  Commit interval 5 seconds
Dec 18 15:45:01 torres kernel: EXT3-fs: mounted filesystem with ordered data mode.
Dec 18 15:45:01 torres kernel: VFS: Mounted root (ext3 filesystem) readonly.
Dec 18 15:45:01 torres kernel: Freeing unused kernel memory: 204k freed
Dec 18 15:45:01 torres kernel: Adding 1952992k swap on /dev/hda2.  Priority:-1 extents:1 across:1952992k
Dec 18 15:45:01 torres kernel: EXT3 FS on hda1, internal journal
Dec 18 15:45:01 torres kernel: Linux Tulip driver version 1.1.14 (May 11, 2002)
Dec 18 15:45:01 torres kernel: ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
Dec 18 15:45:01 torres kernel: PCI: setting IRQ 11 as level-triggered
Dec 18 15:45:01 torres kernel: ACPI: PCI Interrupt 0000:00:0f.0[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
Dec 18 15:45:01 torres kernel: tulip0:  MII transceiver #1 config 1000 status 786d advertising 05e1.
Dec 18 15:45:01 torres kernel: eth0: ADMtek Comet rev 17 at Port 0xec00, 00:10:DC:6A:AA:0E, IRQ 11.
Dec 18 15:45:01 torres kernel: kjournald starting.  Commit interval 5 seconds
Dec 18 15:45:01 torres kernel: EXT3 FS on dm-0, internal journal
Dec 18 15:45:01 torres kernel: EXT3-fs: mounted filesystem with ordered data mode.
Dec 18 15:45:01 torres kernel: kjournald starting.  Commit interval 5 seconds
Dec 18 15:45:01 torres kernel: EXT3 FS on dm-1, internal journal
Dec 18 15:45:01 torres kernel: EXT3-fs: mounted filesystem with ordered data mode.
Dec 18 15:45:01 torres kernel: kjournald starting.  Commit interval 5 seconds
Dec 18 15:45:01 torres kernel: EXT3 FS on dm-2, internal journal
Dec 18 15:45:01 torres kernel: EXT3-fs: mounted filesystem with ordered data mode.
Dec 18 15:45:01 torres kernel: NET: Registered protocol family 10
Dec 18 15:45:01 torres kernel: lo: Disabled Privacy Extensions
Dec 18 15:45:03 torres kernel: 0000:00:0f.0: tulip_stop_rxtx() failed
Dec 18 15:45:03 torres kernel: eth0: Setting full-duplex based on MII#1 link partner capability of 41e1.
Dec 18 15:45:10 torres kernel: eth0: no IPv6 routers present

--Qxx1br4bt0+wmkIi--
