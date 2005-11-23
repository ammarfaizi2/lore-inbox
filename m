Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030326AbVKWGIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030326AbVKWGIf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 01:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030327AbVKWGIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 01:08:35 -0500
Received: from av7-1-sn3.vrr.skanova.net ([81.228.9.181]:709 "EHLO
	av7-1-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S1030326AbVKWGIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 01:08:34 -0500
X-Spam-Score: -4.4
Message-ID: <4384074F.5060008@fulhack.info>
Date: Wed, 23 Nov 2005 07:08:15 +0100
From: Henrik Persson <root@fulhack.info>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jt@hpl.hp.com
Cc: Rajesh Shah <rajesh.shah@intel.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: BUG 2.6.14.2 : ACPI boot lockup
References: <20051122211947.GA29622@bougret.hpl.hp.com> <20051122165429.A30362@unix-os.sc.intel.com> <20051123020609.GA30491@bougret.hpl.hp.com> <20051122181242.A5214@unix-os.sc.intel.com> <20051123022533.GA30537@bougret.hpl.hp.com>
In-Reply-To: <20051123022533.GA30537@bougret.hpl.hp.com>
X-Enigmail-Version: 0.92.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD0001F4D8E860320ECA00C93"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD0001F4D8E860320ECA00C93
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jean Tourrilhes wrote:
> On Tue, Nov 22, 2005 at 06:12:43PM -0800, Rajesh Shah wrote:
>=20
>>On Tue, Nov 22, 2005 at 06:06:09PM -0800, Jean Tourrilhes wrote:
>>
>>>	This patch does not look right to me, but I must admit I have
>>>no clue about what the code is doing. Can you confirm you want me to
>>>try this ?
>>>
>>
>>Yes, please try this since this is known to fix at least a couple
>>of other machines (see=20
>>https://bugzilla.novell.com/show_bug.cgi?id=3D116763)
>=20
>=20
> 	Ok, I tried it. It works. Kernel boot fine, Pcmcia card works,
> X works.
> 	I double checked with /proc/cmdline that I did not have the
> noacpi stuff.
> 	Works for me.

Works for me too, with an MSI Megabook S260 that refused to boot without
pci=3Dnoacpi.

Now, the only thing that's still irritating about this laptop is that it
will freeze on boot if my USB hub is attached. If I boot and then insert
the hub it works just fine.

The lspci:
0000:00:00.0 Host bridge: Intel Corp. Mobile Memory Controller Hub (rev 0=
3)
0000:00:02.0 VGA compatible controller: Intel Corp. Mobile Graphics
Controller (rev 03)
0000:00:02.1 Display controller: Intel Corp. Mobile Graphics Controller
(rev 03)
0000:00:1d.0 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #1 (rev 04)
0000:00:1d.1 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #2 (rev 04)
0000:00:1d.2 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #3 (rev 04)
0000:00:1d.3 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #4 (rev 04)
0000:00:1d.7 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB2 EHCI Controller (rev 04)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev d4)
0000:00:1e.2 Multimedia audio controller: Intel Corp.
82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97 Audio Controller (rev 04)
0000:00:1e.3 Modem: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family)
AC'97 Modem Controller (rev 04)
0000:00:1f.0 ISA bridge: Intel Corp. 82801FBM (ICH6M) LPC Interface
Bridge (rev 04)
0000:00:1f.1 IDE interface: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6
Family) IDE Controller (rev 04)
0000:00:1f.3 SMBus: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family)
SMBus Controller (rev 04)
0000:01:03.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
0000:01:04.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev ac)
0000:01:04.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev ac)
0000:01:04.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394
Controller (rev 04)
0000:01:09.0 Network controller: Intel Corp.: Unknown device 4223 (rev 05=
)

and dmesg:
$ dmesg
9)) #8 PREEMPT Wed Nov 23 06:01:03 CET 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003dfd0000 (usable)
 BIOS-e820: 000000003dfd0000 - 000000003dfde000 (ACPI data)
 BIOS-e820: 000000003dfde000 - 000000003e000000 (ACPI NVS)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
896MB LOWMEM available.
On node 0 totalpages: 229376
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 MSI                                   ) @ 0x000f7970
ACPI: RSDT (v001 MSI    1012     0x06222005 MSFT 0x00000097) @ 0x3dfd0000=

ACPI: FADT (v002 MSI    1012     0x06222005 MSFT 0x00000097) @ 0x3dfd0200=

ACPI: MADT (v001 MSI    1012     0x06222005 MSFT 0x00000097) @ 0x3dfd0390=

ACPI: MCFG (v001 MSI    1012     0x06222005 MSFT 0x00000097) @ 0x3dfd03f0=

ACPI: OEMB (v001 MSI    1012     0x06222005 MSFT 0x00000097) @ 0x3dfde040=

ACPI: MCFG (v001 MSI    1012     0x06222005 MSFT 0x00000097) @ 0x3dfd4000=

ACPI: SSDT (v001    AMI   CPU1PM 0x00000001 INTL 0x02002026) @ 0x3dfd4040=

ACPI: DSDT (v001    MSI 1012     0x06222005 INTL 0x02002026) @ 0x00000000=

Allocating PCI resources starting at 40000000 (gap: 3e000000:c1b80000)
Built 1 zonelists
Kernel command line: root=3D/dev/hda1 ro psmouse.proto=3Dexps
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 1996.034 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 904352k/917504k available (3411k kernel code, 12700k reserved,
877k data, 164k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... =
Ok.
Calibrating delay using timer specific routine.. 3994.78 BogoMIPS
(lpj=3D1997392)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: afe9fbff 00100000 00000000 00000000
00000180 00000000 00000000
CPU: After vendor identify, caps: afe9fbff 00100000 00000000 00000000
00000180 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: After all inits, caps: afe9fbff 00100000 00000000 00000040 00000180
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
CPU: Intel(R) Pentium(R) M processor 2.00GHz stepping 08
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0cf0)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=3D3
ACPI: 2 duplicate MCFG table ignored.
PCI: Using MMCONFIG
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:02.0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: Embedded Controller [EC] (gpe 29)
ACPI: PCI Interrupt Link [LNKA] (IRQs 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs *4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 4 5 6 *7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 4 5 *6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 4 5 6 7 10 *11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a=

report
PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Bus 2, cardbus bridge: 0000:01:04.0
  IO window: 0000e000-0000e0ff
  IO window: 0000e400-0000e4ff
  PREFETCH window: 40000000-41ffffff
  MEM window: 46000000-47ffffff
PCI: Bus 6, cardbus bridge: 0000:01:04.1
  IO window: 0000ec00-0000ecff
  IO window: 00001000-000010ff
  PREFETCH window: 42000000-43ffffff
  MEM window: 48000000-49ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: e000-efff
  MEM window: fbf00000-fbffffff
  PREFETCH window: 40000000-44ffffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:01:04.0[A] -> Link [LNKD] -> GSI 5 (level, low)
-> IRQ 5
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 6
PCI: setting IRQ 6 as level-triggered
ACPI: PCI Interrupt 0000:01:04.1[B] -> Link [LNKE] -> GSI 6 (level, low)
-> IRQ 6
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1132725472.397:1): initialized
SGI XFS with ACLs, security attributes, realtime, no debug enabled
SGI XFS Quota Management subsystem
Initializing Cryptographic API
ACPI: AC Adapter [ADP1] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Lid Switch [LID0]
ACPI: Sleep Button (CM) [SLPB]
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU1] (supports 8 throttling states)
ACPI: Thermal Zone [THRM] (67 C)
Real Time Clock Driver v1.12
hw_random: RNG not detected
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 915GM Chipset.
agpgart: Detected 32508K stolen memory.
agpgart: AGP aperture is 256M @ 0xd0000000
[drm] Initialized drm 1.0.0 20040925
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKA] -> GSI 10 (level,
low) -> IRQ 10
[drm] Initialized i915 1.1.0 20040405 on minor 0:
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
loop: loaded (max 8 devices)
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.=
com
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
NET: Registered protocol family 24
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
ICH6: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 7
PCI: setting IRQ 7 as level-triggered
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 7 (level, low)
-> IRQ 7
ICH6: chipset revision 4
ICH6: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio

****************** From what I can see the boot with USB-things inserted
will hang here. ************************

Probing IDE interface ide0...
hda: SAMSUNG MP0402H, ATA DISK drive
hdb: HL-DT-ST DVD-RW GCA-4080N, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
hda: max request size: 1024KiB
hda: 78242976 sectors (40060 MB) w/8192KiB Cache, CHS=3D16383/255/63,
UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 < hda5 > hda3
hdb: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
ACPI: PCI Interrupt 0000:01:04.0[A] -> Link [LNKD] -> GSI 5 (level, low)
-> IRQ 5
Yenta: CardBus bridge found at 0000:01:04.0 [1462:0121]
Yenta: ISA IRQ mask 0x0818, PCI irq 5
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0xe000 - 0xefff
pcmcia: parent PCI bridge Memory window: 0xfbf00000 - 0xfbffffff
pcmcia: parent PCI bridge Memory window: 0x40000000 - 0x44ffffff
ACPI: PCI Interrupt 0000:01:04.1[B] -> Link [LNKE] -> GSI 6 (level, low)
-> IRQ 6
Yenta: CardBus bridge found at 0000:01:04.1 [1462:0121]
Yenta: ISA IRQ mask 0x0818, PCI irq 6
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0xe000 - 0xefff
pcmcia: parent PCI bridge Memory window: 0xfbf00000 - 0xfbffffff
pcmcia: parent PCI bridge Memory window: 0x40000000 - 0x44ffffff
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:1d.7[A] -> Link [LNKH] -> GSI 11 (level,
low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 11, io mem 0xfbe3bc00
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004=

hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKH] -> GSI 11 (level,
low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 11, io base 0x0000d880
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKD] -> GSI 5 (level, low)
-> IRQ 5
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 5, io base 0x0000d800
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 7 (level, low)
-> IRQ 7
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 7, io base 0x0000d480
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> Link [LNKA] -> GSI 10 (level,
low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 10, io base 0x0000d400
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial support registered for Generi=
c
usbcore: registered new driver usbserial_generic
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
mice: PS/2 mouse device common for all mice
Advanced Linux Sound Architecture Driver Version 1.0.10rc1 (Mon Sep 12
08:13:09 2005 UTC).
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 4
PCI: setting IRQ 4 as level-triggered
ACPI: PCI Interrupt 0000:00:1e.2[A] -> Link [LNKB] -> GSI 4 (level, low)
-> IRQ 4
PCI: Setting latency timer of device 0000:00:1e.2 to 64
input: AT Translated Set 2 keyboard on isa0060/serio0
input: PS/2 Synaptics TouchPad on isa0060/serio1
intel8x0_measure_ac97_clock: measured 50547 usecs
intel8x0: clocking to 48000
ACPI: PCI Interrupt 0000:00:1e.3[B] -> Link [LNKE] -> GSI 6 (level, low)
-> IRQ 6
PCI: Setting latency timer of device 0000:00:1e.3 to 64
ALSA device list:
  #0: Intel ICH6 with ALC655 at 0xfbe3b800, irq 4
  #1: Intel ICH6 Modem at 0xc800, irq 6
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 7, 524288 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 10
Disabled Privacy Extensions on device c04db880(lo)
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 15
Using IPI Shortcut mode
ACPI wakeup devices:
 LAN AUDI MC97
ACPI: (supports S0 S3 S4 S5)
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 164k freed
kjournald starting.  Commit interval 5 seconds
Adding 1614492k swap on /dev/hda5.  Priority:-1 extents:1 across:1614492k=

EXT3 FS on hda1, internal journal
ieee1394: Initialized config rom entry `ip1394'
sbp2: $Rev: 1306 $ Ben Collins <bcollins@debian.org>
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=3D1)
ieee1394: sbp2: Try serialize_io=3D0 for better performance
cdrom: open failed.
XFS mounting filesystem hda3
Ending clean XFS mount for filesystem: hda3
8139too Fast Ethernet driver 0.9.27
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 5
ACPI: PCI Interrupt 0000:01:03.0[A] -> Link [LNKG] -> GSI 5 (level, low)
-> IRQ 5
eth0: RealTek RTL8139 at 0xe800, 00:0c:76:f8:d1:ac, IRQ 5
eth0:  Identified 8139 chip type 'RTL-8101'
8139cp: 10/100 PCI Ethernet driver v1.2 (Mar 22, 2004)
ohci1394: $Rev: 1313 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 5
ACPI: PCI Interrupt 0000:01:04.2[C] -> Link [LNKF] -> GSI 5 (level, low)
-> IRQ 5
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=3D[5]
MMIO=3D[fbfff000-fbfff7ff]  Max Packet=3D[2048]
ieee80211_crypt: registered algorithm 'NULL'
ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.0.0
ipw2200: Copyright(c) 2003-2004 Intel Corporation
ACPI: PCI Interrupt 0000:01:09.0[A] -> Link [LNKB] -> GSI 4 (level, low)
-> IRQ 4
ipw2200: Detected Intel PRO/Wireless 2915ABG Network Connection
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0010dc00009e7c69]
input: PC Speaker
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
NET: Registered protocol family 17
eth1: duplicate address detected!
eth1: duplicate address detected!
mtrr: base(0xd0660000) is not aligned on a size(0x320000) boundary
Bluetooth: Core ver 2.7
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.7
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM ver 1.5
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
usb 1-2: new high speed USB device using ehci_hcd and address 2
hub 1-2:1.0: USB hub found
hub 1-2:1.0: 4 ports detected
usb 1-2.1: new low speed USB device using ehci_hcd and address 3
input: USB HID v1.10 Keyboard [Logitech Logitech USB Keyboard] on
usb-0000:00:1d.7-2.1
input: USB HID v1.10 Mouse [Logitech Logitech USB Keyboard] on
usb-0000:00:1d.7-2.1
usb 1-2.2: new low speed USB device using ehci_hcd and address 4
input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse=AE Explorer]=

on usb-0000:00:1d.7-2.2

Ideas, anyone? :)

--
Henrik Persson


--------------enigD0001F4D8E860320ECA00C93
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDhAdTp5uk1YPOcmcRAuXWAJ9HLnytGhkDKxkf2McsZ7xSD1wUPgCfc6Pg
QD0IYgKFL8e8wk48eNk2dkM=
=gcGr
-----END PGP SIGNATURE-----

--------------enigD0001F4D8E860320ECA00C93--
