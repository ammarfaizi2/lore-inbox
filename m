Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262198AbVCOCSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbVCOCSo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 21:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbVCOCSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 21:18:44 -0500
Received: from [206.246.247.150] ([206.246.247.150]:36814 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S262198AbVCOCSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 21:18:32 -0500
Date: Mon, 14 Mar 2005 18:50:50 -0500
From: Ben Collins <bcollins@debian.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux1394-devel@lists.sourceforge.net,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: OHCI driver dies on Mac Mini at boot
Message-ID: <20050314235050.GD1437@internal>
References: <1110846336.5673.53.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110846336.5673.53.camel@gaston>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Send me the lspci -v output for this machine.

On Tue, Mar 15, 2005 at 11:25:36AM +1100, Benjamin Herrenschmidt wrote:
> I get this output with current Linus bk : 
> 
> [    0.000000] Total memory = 512MB; using 1024kB for hash table (at 80400000)
> [    0.000000] Linux version 2.6.11-gack (benh@gaston) (gcc version 3.3.5 (Debian 1:3.3.5-8)) #5 Tue Mar 15 11:20:41 EST 2005
> [    0.000000] Found UniNorth memory controller & host bridge, revision: 210
> [    0.000000] Mapped at 0xfdd68000
> [    0.000000] Found a Intrepid mac-io controller, rev: 0, mapped at 0xfdce8000
> [    0.000000] Processor NAP mode on idle enabled.
> [    0.000000] PowerMac motherboard: Mac mini
> [    0.000000] Found UniNorth PCI host bridge at 0xf0000000. Firmware bus number: 0->0
> [    0.000000] Found UniNorth PCI host bridge at 0xf2000000. Firmware bus number: 0->0
> [    0.000000] Found UniNorth PCI host bridge at 0xf4000000. Firmware bus number: 0->0
> [    0.000000] via-pmu: Server Mode is disabled
> [    0.000000] PMU driver 2 initialized for Core99, firmware: 55
> [    0.000000] nvram: Checking bank 0...
> [    0.000000] nvram: gen0=122, gen1=121
> [    0.000000] nvram: Active bank is: 0
> [    0.000000] nvram: OF partition at 0x410
> [    0.000000] nvram: XP partition at 0x1020
> [    0.000000] nvram: NR partition at 0x1120
> [    0.000000] On node 0 totalpages: 131072
> [    0.000000]   DMA zone: 131072 pages, LIFO batch:16
> [    0.000000]   Normal zone: 0 pages, LIFO batch:1
> [    0.000000]   HighMem zone: 0 pages, LIFO batch:1
> [    0.000000] Built 1 zonelists
> [    0.000000] Kernel command line: s
> [    0.000000] PowerMac using OpenPIC irq controller at 0x80040000
> [    0.000000] OpenPIC Version 1.2 (4 CPUs and 64 IRQ sources) at fc496000
> [    0.000000] OpenPIC timer frequency is 4.166666 MHz
> [    0.000000] PID hash table entries: 4096 (order: 12, 65536 bytes)
> [    0.000000] GMT Delta read from XPRAM: 0 minutes, DST: off
> [    0.000000] time_init: decrementer frequency = 41.620997 MHz
> [   69.359998] Console: colour dummy device 80x25
> [   69.360691] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> [   69.361601] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> [   69.380943] Memory: 512896k available (2580k kernel code, 1336k data, 176k init, 0k highmem)
> [   69.380964] System.map loaded at 0x811bd000 for debugger, size: 963019 bytes
> [   69.380972] AGP special page: 0x9ffff000
> [   69.381051] Calibrating delay loop... 1413.12 BogoMIPS (lpj=706560)
> [   69.402356] Mount-cache hash table entries: 512
> [   69.404165] NET: Registered protocol family 16
> [   69.405106] PCI: Probing PCI hardware
> [   69.406287] PCI: Cannot allocate resource region 0 of device 0001:10:18.0
> [   69.406299] PCI: Cannot allocate resource region 0 of device 0001:10:19.0
> [   69.406322] Apple USB OHCI 0001:10:18.0 disabled by firmware
> [   69.406331] Apple USB OHCI 0001:10:19.0 disabled by firmware
> [   69.406390] Registering openpic with sysfs...
> [   69.407120] SCSI subsystem initialized
> [   69.407258] usbcore: registered new driver usbfs
> [   69.407289] usbcore: registered new driver hub
> [   69.408749] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> [   69.409293] PCI: Enabling device 0000:00:10.0 (0006 -> 0007)
> [   69.925273] radeonfb (0000:00:10.0): Invalid ROM signature 0 should be0xaa55
> [   69.925294] radeonfb: Retreived PLL infos from Open Firmware
> [   69.925303] radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=190.00 Mhz, System=250.00 MHz
> [   69.925314] radeonfb: PLL min 12000 max 35000
> [   70.517246] radeonfb: Monitor 1 type DFP found
> [   70.517263] radeonfb: EDID probed
> [   70.517269] radeonfb: Monitor 2 type DFP found
> [   70.517275] radeonfb: EDID probed
> [   70.611713] Console: switching to colour frame buffer device 240x75
> [   70.611913] radeonfb (0000:00:10.0): ATI Radeon Yb 
> [   70.626083] Generic RTC Driver v1.07
> [   70.626274] Macintosh non-volatile memory driver v1.1
> [   70.626540] io scheduler noop registered
> [   70.626702] io scheduler anticipatory registered
> [   70.626861] io scheduler deadline registered
> [   70.627015] io scheduler cfq registered
> [   70.627552] RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> [   70.627979] loop: loaded (max 8 devices)
> [   70.628137] sungem.c:v0.98 8/24/03 David S. Miller (davem@redhat.com)
> [   70.690585] PHY ID: 4061e4, addr: 0
> [   70.691210] eth0: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:11:24:76:c8:ea 
> [   70.691524] eth0: Found BCM5221 PHY
> [   70.691694] pcnet32.c:v1.30i 06.28.2004 tsbogend@alpha.franken.de
> [   70.691954] PPP generic driver version 2.4.2
> [   70.692139] PPP Deflate Compression module registered
> [   70.692337] MacIO PCI driver attached to Intrepid chipset
> [   70.692956] input: Macintosh mouse button emulation
> [   70.693211] apm_emu: APM Emulation 0.5 initialized.
> [   70.693421] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> [   70.693620] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> [   70.693882] adb: starting probe task...
> [   70.694008] adb: finished probe task...
> [   70.694322] PCI: Enabling device 0002:20:0d.0 (0004 -> 0006)
> [   71.706181] ide0: Found Apple UniNorth ATA-6 controller, bus ID 3, irq 39
> [   71.706404] Probing IDE interface ide0...
> [   71.970334] hda: TOSHIBA MK8025GAS, ATA DISK drive
> [   72.378303] hdb: MATSHITACD-RW CW-8123, ATAPI CD/DVD-ROM drive
> [   72.429131] hda: Enabling Ultra DMA 5
> [   72.430274] hdb: Enabling Ultra DMA 2
> [   72.431454] ide0 at 0xa101a000-0xa101a007,0xa101a160 on irq 39
> [   73.090239] eth0: Link is up at 100 Mbps, full-duplex.
> [   73.443069] ide1: Found Apple KeyLargo ATA-3 controller, bus ID 0, irq 24
> [   73.443287] Probing IDE interface ide1...
> [   73.962026] ide1: Bus empty, interface released.
> [   73.962215] hda: max request size: 1024KiB
> [   74.216212] hda: 156301488 sectors (80026 MB), CHS=16383/255/63, UDMA(100)
> [   74.216523] hda: cache flushes supported
> [   74.216723]  hda: [mac] hda1 hda2 hda3 hda4 hda5 hda6 hda7 hda8
> [   74.282414] hdb: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
> [   74.282712] Uniform CD-ROM driver Revision: 3.20
> [   74.284641] ide-floppy driver 0.99.newide
> [   74.284893] mesh: configured for synchronous 5 MB/s
> [   74.285105] st: Version 20041025, fixed bufsize 32768, s/g segs 256
> [   74.285418] usbmon: debugs is not available
> [   74.285553] ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
> [   74.285592] Apple USB OHCI 0001:10:18.0 disabled by firmware
> [   74.285773] Apple USB OHCI 0001:10:19.0 disabled by firmware
> [   74.285954] PCI: Enabling device 0001:10:1a.0 (0000 -> 0002)
> [   74.295306] ohci_hcd 0001:10:1a.0: Apple Computer Inc. KeyLargo/Intrepid USB (#3)
> [   74.304588] ohci_hcd 0001:10:1a.0: new USB bus registered, assigned bus number 1
> [   74.313747] ohci_hcd 0001:10:1a.0: irq 29, io mem 0x80083000
> [   74.353116] hub 1-0:1.0: USB hub found
> [   74.362232] hub 1-0:1.0: 2 ports detected
> [   74.392029] PCI: Enabling device 0001:10:1b.0 (0000 -> 0002)
> [   74.401126] ohci_hcd 0001:10:1b.0: NEC Corporation USB
> [   74.410400] ohci_hcd 0001:10:1b.0: new USB bus registered, assigned bus number 2
> [   74.419646] ohci_hcd 0001:10:1b.0: irq 63, io mem 0x80082000
> [   74.459072] hub 2-0:1.0: USB hub found
> [   74.468330] hub 2-0:1.0: 3 ports detected
> [   74.498025] PCI: Enabling device 0001:10:1b.1 (0000 -> 0002)
> [   74.507405] ohci_hcd 0001:10:1b.1: NEC Corporation USB (#2)
> [   74.516803] ohci_hcd 0001:10:1b.1: new USB bus registered, assigned bus number 3
> [   74.526190] ohci_hcd 0001:10:1b.1: irq 63, io mem 0x80081000
> [   74.566061] hub 3-0:1.0: USB hub found
> [   74.575288] hub 3-0:1.0: 2 ports detected
> [   74.662013] usbcore: registered new driver usbhid
> [   74.671081] drivers/usb/input/hid-core.c: v2.01:USB HID core driver
> [   74.680311] mice: PS/2 mouse device common for all mice
> [   74.689528] oprofile: using timer interrupt.
> [   74.698770] NET: Registered protocol family 2
> [   74.718042] IP: routing cache hash table of 4096 buckets, 32Kbytes
> [   74.727650] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
> [   74.739914] TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
> [   74.749784] TCP: Hash tables configured (established 131072 bind 65536)
> [   74.759471] NET: Registered protocol family 1
> [   74.768982] NET: Registered protocol family 17
> [   74.788984] usb 2-1: new low speed USB device using ohci_hcd and address 2
> [   74.798912] EXT3-fs: INFO: recovery required on readonly filesystem.
> [   74.808580] EXT3-fs: write access will be enabled during recovery.
> [   74.935605] input: USB HID v1.10 Mouse [Microsoft Basic Optical Mouse] on usb-0001:10:1b.0-1
> [   74.977829] kjournald starting.  Commit interval 5 seconds
> [   74.987617] EXT3-fs: recovery complete.
> [   74.998266] EXT3-fs: mounted filesystem with ordered data mode.
> [   75.007984] VFS: Mounted root (ext3 filesystem) readonly.
> [   75.017680] Freeing unused kernel memory: 176k init 4k chrp 8k prep
> [   75.229947] usb 3-1: new low speed USB device using ohci_hcd and address 2
> [   75.401614] input: USB HID v1.10 Keyboard [Logitech USB Receiver] on usb-0001:10:1b.1-1
> [   75.424797] input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0001:10:1b.1-1
> [   80.639297] Adding 1953116k swap on /dev/hda6.  Priority:-1 extents:1
> [   80.787420] EXT3 FS on hda4, internal journal
> [   84.020857] ieee1394: Initialized config rom entry `ip1394'
> [   84.048240] sbp2: $Rev: 1219 $ Ben Collins <bcollins@debian.org>
> [   84.203758] Found KeyWest i2c on "uni-n", 2 channels, stepping: 4 bits
> [   84.215110] Found KeyWest i2c on "mac-io", 1 channel, stepping: 4 bits
> [   85.392553] kjournald starting.  Commit interval 5 seconds
> [   85.402199] EXT3 FS on hda5, internal journal
> [   85.411612] EXT3-fs: mounted filesystem with ordered data mode.
> [   85.444911] kjournald starting.  Commit interval 5 seconds
> [   85.454548] EXT3 FS on hda7, internal journal
> [   85.464029] EXT3-fs: mounted filesystem with ordered data mode.
> [   88.155217] ohci1394: $Rev: 1250 $ Ben Collins <bcollins@debian.org>
> [   88.164904] PCI: Enabling device 0002:20:0e.0 (0000 -> 0002)
> [   88.188723] ohci1394: fw-host0: Unexpected PCI resource length of 1000!
> [   88.250601] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[40]  MMIO=[f5000000-f50007ff]  Max Packet=[2048]
> [   89.741666] Linux agpgart interface v0.101 (c) Dave Jones
> [   89.803084] agpgart: Detected Apple UniNorth 2 chipset
> [   89.812583] agpgart: configuring for size idx: 4
> [   89.824113] agpgart: AGP aperture is 16M @ 0x0
> [   89.941059] ohci1394: fw-host0: Unrecoverable error!
> [   89.950220] ohci1394: fw-host0: Async Req Rcv Context died: ctrl[00008808] cmdptr[1ef28000]
> [   89.959378] ohci1394: fw-host0: Error in reception of SelfID packets [0x8002000c/0x00000000] (count: 0)
> [   89.970595] ohci1394: fw-host0: SelfID received outside of bus reset sequence
> [   90.235036] ieee1394: impossible ack_complete from node 65535 (tcode 4)
> [   90.244330] ieee1394: Current remote IRM is not 1394a-2000 compliant, resetting...
> [   90.246363] ohci1394: fw-host0: Error in reception of SelfID packets [0x8004000c/0x00000000] (count: 1)
> [   90.257846] ohci1394: fw-host0: SelfID received outside of bus reset sequence
> [   90.513026] ieee1394: impossible ack_complete from node 65535 (tcode 4)
> [   90.522642] ieee1394: Current remote IRM is not 1394a-2000 compliant, resetting...
> [   90.524673] ohci1394: fw-host0: Error in reception of SelfID packets [0x8006000c/0x00000000] (count: 2)
> [   90.536379] ohci1394: fw-host0: SelfID received outside of bus reset sequence
> [   90.801002] ieee1394: impossible ack_complete from node 65535 (tcode 4)
> [   90.810758] ieee1394: Current remote IRM is not 1394a-2000 compliant, resetting...
> [   90.812788] ohci1394: fw-host0: Error in reception of SelfID packets [0x8008000c/0x00000000] (count: 3)
> [   90.824645] ohci1394: fw-host0: SelfID received outside of bus reset sequence
> [   91.079999] ieee1394: impossible ack_complete from node 65535 (tcode 4)
> [   91.089869] ieee1394: Current remote IRM is not 1394a-2000 compliant, resetting...
> [   91.091900] ohci1394: fw-host0: Error in reception of SelfID packets [0x800a000c/0x00000000] (count: 4)
> [   91.104034] ohci1394: fw-host0: SelfID received outside of bus reset sequence
> [   91.375966] ieee1394: impossible ack_complete from node 65535 (tcode 4)
> [   91.386009] ieee1394: Current remote IRM is not 1394a-2000 compliant, resetting...
> [   91.388038] ohci1394: fw-host0: Error in reception of SelfID packets [0x800c000c/0x00000000] (count: 5)
> [   91.400264] ohci1394: fw-host0: SelfID received outside of bus reset sequence
> [   91.655954] ieee1394: impossible ack_complete from node 65535 (tcode 4)
> [   91.666503] ieee1394: Current remote IRM is not 1394a-2000 compliant, resetting...
> [   91.666507] ieee1394: Stopping reset loop for IRM sanity
> [   96.598155] eth0: Link is up at 100 Mbps, full-duplex.
> [   96.608017] eth0: Pause is disabled
> 
> 
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> mailing list linux1394-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux1394-devel

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
