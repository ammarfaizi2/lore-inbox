Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934372AbWKUOsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934372AbWKUOsn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 09:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934370AbWKUOsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 09:48:43 -0500
Received: from mailhost.informatik.uni-bremen.de ([134.102.201.18]:14478 "EHLO
	informatik.uni-bremen.de") by vger.kernel.org with ESMTP
	id S934369AbWKUOsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 09:48:42 -0500
Message-ID: <4563119A.1000001@tzi.de>
Date: Tue, 21 Nov 2006 15:47:54 +0100
From: Janosch Machowinski <scotch@tzi.de>
User-Agent: Thunderbird 1.5.0.8 (X11/20061114)
MIME-Version: 1.0
To: Len Brown <lenb@kernel.org>
CC: David Brownell <david-b@pacbell.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org
Subject: Re: 2.6.19-rc5 nasty ACPI regression, AE_TIME errors
References: <200611142303.47325.david-b@pacbell.net> <200611150248.12578.len.brown@intel.com>
In-Reply-To: <200611150248.12578.len.brown@intel.com>
Content-Type: multipart/mixed;
 boundary="------------090601020204070200060302"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090601020204070200060302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

>>
>> What's an AE_TIME?
>>
>> I'm not quite sure where these problems crept in, but I never saw such stuff with
>> 2.6.18 at all.
>>
I had the same error some days ago, under realy heavy load (compiling 
mozilla-thunderbird) on an 2.6.18.1. So this seems so have crept in 
before... Dmesg is attached.

	Janosch


--------------090601020204070200060302
Content-Type: text/plain;
 name="acpi.error"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpi.error"

Table [\_SB_.PCI0.P0P2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 *4 5 6 7 11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs *10 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs *5 6 10)
ACPI: PCI Interrupt Link [LNKE] (IRQs 6 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 7) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 4 7) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 4 6 *10 12)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 15 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:09: ioport range 0x480-0x48f has been reserved
pnp: 00:09: ioport range 0x5c0-0x5cf has been reserved
pnp: 00:0d: ioport range 0x540-0x55f has been reserved
pnp: 00:0d: ioport range 0x400-0x47f could not be reserved
pnp: 00:0d: ioport range 0x480-0x48f has been reserved
pnp: 00:0d: ioport range 0x500-0x53f has been reserved
pnp: 00:0d: ioport range 0x4c0-0x4cf has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: d000-dfff
  MEM window: ff800000-ff8fffff
  PREFETCH window: ce900000-de9fffff
PCI: Bus 3, cardbus bridge: 0000:02:01.0
  IO window: 00001000-000010ff
  IO window: 00001400-000014ff
  PREFETCH window: 32000000-33ffffff
  MEM window: 34000000-35ffffff
PCI: Bus 7, cardbus bridge: 0000:02:01.1
  IO window: 00001800-000018ff
  IO window: 00001c00-00001cff
  PREFETCH window: 36000000-37ffffff
  MEM window: 38000000-39ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 1000-1fff
  MEM window: ff900000-ff9fffff
  PREFETCH window: dea00000-deafffff
PCI: Enabling device 0000:00:1e.0 (0106 -> 0107)
PCI: Setting latency timer of device 0000:00:1e.0 to 64
PCI: Enabling device 0000:02:01.0 (0000 -> 0003)
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 4
PCI: setting IRQ 4 as level-triggered
ACPI: PCI Interrupt 0000:02:01.0[A] -> Link [LNKB] -> GSI 4 (level, low) -> IRQ 4
PCI: Setting latency timer of device 0000:02:01.0 to 64
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:02:01.1[B] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:02:01.1 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
Machine check exception polling timer started.
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.27 [Flags: R/O].
fuse init (API version 7.7)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
ACPI: AC Adapter [AC] (off-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Power Button (CM) [PWRB]
ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
Using specific hotkey driver
ACPI: Invalid PBLK length [7]
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Thermal Zone [THRM] (25 C)
Asus Laptop ACPI Extras version 0.30
  M6NE model detected, supported
lp: driver loaded but no devices found
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 855PM Chipset.
agpgart: AGP aperture is 256M @ 0xe0000000
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LNKB] -> GSI 4 (level, low) -> IRQ 4
ACPI: PCI interrupt for device 0000:00:1f.6 disabled
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP(,...)]
lp0: using parport0 (interrupt-driven).
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
tg3.c:v3.65 (August 07, 2006)
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNKB] -> GSI 4 (level, low) -> IRQ 4
eth0: Tigon3 [partno(BCM95788A50) rev 3003 PHY(5705)] (PCI:33MHz:32-bit) 10/100/1000BaseT Ethernet 00:11:2f:8d:b2:b5
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[0] TSOcap[1] 
eth0: dma_rwctrl[763f0000] dma_mask[32-bit]
PPP generic driver version 2.4.2
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
ICH4: chipset revision 3
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: IC25N060ATMR04-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
hda: max request size: 512KiB
hda: 117210240 sectors (60011 MB) w/7884KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
ACPI: PCI Interrupt 0000:02:01.2[C] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[10]  MMIO=[ff9ef800-ff9effff]  Max Packet=[2048]  IR/IT contexts=[4/4]
ieee1394: raw1394: /dev/raw1394 device initialized
Yenta: CardBus bridge found at 0000:02:01.0 [1043:1864]
Yenta: ISA IRQ mask 0x0028, PCI irq 4
Socket status: 30000006
Yenta: Raising subordinate bus# of parent bus (#02) from #02 to #06
pcmcia: parent PCI bridge I/O window: 0x1000 - 0x1fff
cs: IO port probe 0x1000-0x1fff: clean.
pcmcia: parent PCI bridge Memory window: 0xff900000 - 0xff9fffff
pcmcia: parent PCI bridge Memory window: 0xdea00000 - 0xdeafffff
Yenta: CardBus bridge found at 0000:02:01.1 [1043:1864]
Yenta: ISA IRQ mask 0x0028, PCI irq 11
Socket status: 30000006
Yenta: Raising subordinate bus# of parent bus (#02) from #06 to #0a
pcmcia: parent PCI bridge I/O window: 0x1000 - 0x1fff
cs: IO port probe 0x1000-0x1fff: clean.
pcmcia: parent PCI bridge Memory window: 0xff900000 - 0xff9fffff
pcmcia: parent PCI bridge Memory window: 0xdea00000 - 0xdeafffff
usbmon: debugfs is not available
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [LNKH] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 10, io mem 0xffaffc00
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 11, io base 0x0000e800
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKD] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 5, io base 0x0000e880
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 10, io base 0x0000ec00
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f12:PS2M] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
sdhci: Secure Digital Host Controller Interface driver, 0.12
sdhci: Copyright(c) Pierre Ossman
Advanced Linux Sound Architecture Driver Version 1.0.12rc1 (Thu Jun 22 13:55:50 2006 UTC).
ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 4 (level, low) -> IRQ 4
PCI: Setting latency timer of device 0000:00:1f.5 to 64
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e01800031fe66b]
input: AT Translated Set 2 keyboard as /class/input/input0
Synaptics Touchpad, model: 1, fw: 4.6, id: 0x925ea1, caps: 0x80471b/0x0
intel8x0_measure_ac97_clock: measured 60000 usecs
intel8x0: clocking to 48000
ALSA device list:
  #0: Intel 82801DB-ICH4 with STAC9750,51 at 0xffaff800, irq 4
ip_conntrack version 2.4 (4090 buckets, 32720 max) - 172 bytes per conntrack
input: SynPS/2 Synaptics TouchPad as /class/input/input1
ip_conntrack_pptp version 3.1 loaded
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
Time: tsc clocksource has been installed.
ACPI: (supports S0 S3 S4 S5)
Time: acpi_pm clocksource has been installed.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 224k freed
cs: IO port probe 0x100-0x3af: excluding 0x170-0x177 0x370-0x37f
cs: IO port probe 0x3e0-0x4ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
cs: IO port probe 0x100-0x3af: excluding 0x170-0x177 0x370-0x37f
cs: IO port probe 0x3e0-0x4ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
ts: Compaq touchscreen protocol output
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on hda5, internal journal
NTFS volume version 3.1.
Adding 506008k swap on /dev/hda6.  Priority:-1 extents:1 across:506008k
ieee80211_crypt: registered algorithm 'NULL'
ieee80211: 802.11 data/management/control stack, git-1.1.13
ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.1.2km
ipw2200: Copyright(c) 2003-2006 Intel Corporation
ACPI: PCI Interrupt 0000:02:02.0[A] -> Link [LNKB] -> GSI 4 (level, low) -> IRQ 4
ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
ipw2200: Detected geography ZZM (11 802.11bg channels, 0 802.11a channels)
eth1: NETDEV_TX_BUSY returned; driver should report queue full via ieee_device->is_queue_full.
[drm] Initialized drm 1.0.1 20051102
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
[drm] Initialized radeon 1.25.0 20060524 on minor 0
mtrr: 0xd0000000,0x8000000 overlaps existing 0xd0000000,0x4000000
mtrr: 0xd0000000,0x8000000 overlaps existing 0xd0000000,0x4000000
mtrr: 0xd0000000,0x8000000 overlaps existing 0xd0000000,0x4000000
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
[drm] Setting GART location based on new memory map
[drm] Loading R300 Microcode
[drm] writeback test succeeded in 2 usecs
PPP BSD Compression module registered
PPP Deflate Compression module registered
NTFS-fs error (device hda2): ntfs_readdir(): Directory index record with vcn 0x200 is corrupt.  Corrupt inode 0x20.  Run chkdsk.
ACPI: PCI interrupt for device 0000:02:02.0 disabled
ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.1.2km
ipw2200: Copyright(c) 2003-2006 Intel Corporation
PCI: Enabling device 0000:02:02.0 (0100 -> 0102)
ACPI: PCI Interrupt 0000:02:02.0[A] -> Link [LNKB] -> GSI 4 (level, low) -> IRQ 4
ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
ipw2200: Detected geography ZZM (11 802.11bg channels, 0 802.11a channels)
eth1: NETDEV_TX_BUSY returned; driver should report queue full via ieee_device->is_queue_full.
ACPI: read EC, OB not full
ACPI Exception (evregion-0424): AE_TIME, Returned by Handler for [EmbeddedControl] [20060707]
ACPI Exception (dswexec-0458): AE_TIME, While resolving operands for [OpcodeName unavailable] [20060707]
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.SBRG.EC0_.RWRD] (Node c1470c84), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.BAT1.BST3] (Node c146da2c), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.BAT1._BST] (Node c146db30), AE_TIME
ACPI Exception (acpi_battery-0206): AE_TIME, Evaluating _BST [20060707]
ACPI: read EC, OB not full
ACPI Exception (evregion-0424): AE_TIME, Returned by Handler for [EmbeddedControl] [20060707]
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.SBRG.EC0_.ACS_] (Node c1470f2c), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.BAT0.BST0] (Node c146d310), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.BAT0._BST] (Node c146d3d8), AE_TIME
ACPI Exception (acpi_battery-0206): AE_TIME, Evaluating _BST [20060707]
ACPI: write EC, IB not empty
ACPI: read EC, OB not full
ACPI Exception (evregion-0424): AE_TIME, Returned by Handler for [EmbeddedControl] [20060707]
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.SBRG.EC0_.BATS] (Node c1470f18), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.BAT0._BST] (Node c146d3d8), AE_TIME
ACPI Exception (acpi_battery-0206): AE_TIME, Evaluating _BST [20060707]
ACPI: read EC, OB not full
ACPI Exception (evregion-0424): AE_TIME, Returned by Handler for [EmbeddedControl] [20060707]
ACPI Exception (dswexec-0458): AE_TIME, While resolving operands for [OpcodeName unavailable] [20060707]
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.SBRG.EC0_.RWRD] (Node c1470c84), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.BAT0.BST3] (Node c146d2d4), AE_TIME
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.BAT0._BST] (Node c146d3d8), AE_TIME
ACPI Exception (acpi_battery-0206): AE_TIME, Evaluating _BST [20060707]

--------------090601020204070200060302--
