Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423269AbWJSKSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423269AbWJSKSt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 06:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423268AbWJSKSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 06:18:48 -0400
Received: from max.feld.cvut.cz ([147.32.192.36]:58823 "EHLO max.feld.cvut.cz")
	by vger.kernel.org with ESMTP id S1423267AbWJSKSq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 06:18:46 -0400
From: CIJOML <cijoml@volny.cz>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [Bug 185] Sometimes kernel freezes sometime lists OOPS - hostap_cs
Date: Thu, 19 Oct 2006 11:51:40 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org
References: <200610171747.34177.cijoml@volny.cz> <200610191012.49544.cijoml@volny.cz> <20061019014446.36410c81.akpm@osdl.org>
In-Reply-To: <20061019014446.36410c81.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610191151.40264.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like it partially fixed problem, but hostap driver still not work:

notas:/home/cijoml# dmesg
Linux version 2.6.18 (root@notas) (gcc version 4.1.2 20060901 (prerelease) 
(Debian 4.1.1-13)) #5 PREEMPT Thu Sep 28 20:41:37 CEST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ce000 - 00000000000d0000 (reserved)
 BIOS-e820: 00000000000d8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003eee0000 (usable)
 BIOS-e820: 000000003eee0000 - 000000003eeeb000 (ACPI data)
 BIOS-e820: 000000003eeeb000 - 000000003ef00000 (ACPI NVS)
 BIOS-e820: 000000003ef00000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000fec10000 - 00000000fec20000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
110MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f63f0
On node 0 totalpages: 257760
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 28384 pages, LIFO batch:7
DMI present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f6420
ACPI: RSDT (v001 PTLTD  Montara  0x06040000  LTP 0x00000000) @ 0x3eee5e05
ACPI: FADT (v001 Acer   Yuhina   0x06040000 PTL  0x00000001) @ 0x3eeeaed2
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x3eeeafd8
ACPI: DSDT (v001   ANNI   Yuhina 0x06040000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
SMP mptable: bad signature [0x0]!
BIOS bug, MP table errors detected!...
... disabling SMP support. (tell your hw vendor)
Allocating PCI resources starting at 50000000 (gap: 40000000:bec10000)
Detected 2398.117 MHz processor.
Built 1 zonelists.  Total pages: 257760
Kernel command line: auto BOOT_IMAGE=Linux ro root=302 lapic ec_intr=0 
pci=assign-busses
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
mapped APIC to ffffd000 (fee00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1018468k/1031040k available (1840k kernel code, 11932k reserved, 700k 
data, 172k init, 113536k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 4797.78 BogoMIPS 
(lpj=2398891)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 
00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 
00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 128K
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
CPU: Intel(R) Celeron(R) CPU 2.40GHz stepping 09
Checking 'hlt' instruction... OK.
ACPI: Core revision 20060707
ACPI: setting ELCR to 0200 (from 0c90)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd6b4, last bus=2
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:02.0
PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 10 11) *4
ACPI: PCI Interrupt Link [LNKB] (IRQs *10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs *10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs *10 11)
ACPI: PCI Interrupt Link [LNKG] (IRQs *10 11)
ACPI: PCI Interrupt Link [LNKH] (IRQs 10 11) *7
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
PnPBIOS: Disabled by ACPI PNP
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:04: ioport range 0x600-0x60f has been reserved
PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Bus 2, cardbus bridge: 0000:01:04.0
  IO window: 00003400-000034ff
  IO window: 00003800-000038ff
  PREFETCH window: 50000000-51ffffff
  MEM window: 56000000-57ffffff
PCI: Bus 6, cardbus bridge: 0000:01:04.1
  IO window: 00003c00-00003cff
  IO window: 00001400-000014ff
  PREFETCH window: 52000000-53ffffff
  MEM window: 58000000-59ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 3000-3fff
  MEM window: e0200000-e02fffff
  PREFETCH window: 50000000-54ffffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:01:04.0[A] -> Link [LNKF] -> GSI 10 (level, low) -> 
IRQ 10
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 10
ACPI: PCI Interrupt 0000:01:04.1[B] -> Link [LNKG] -> GSI 10 (level, low) -> 
IRQ 10
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 7, 524288 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Simple Boot Flag at 0x3c set to 0x1
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14a <tigran@veritas.com>
audit: initializing netlink socket (disabled)
audit(1161251092.755:1): initialized
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLP2]
ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
Using specific hotkey driver
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Thermal Zone [THRS] (45 C)
ACPI: Thermal Zone [THRC] (45 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 855 Chipset.
agpgart: Detected 16252K stolen memory.
agpgart: AGP aperture is 128M @ 0xe8000000
[drm] Initialized drm 1.0.1 20051102
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> 
IRQ 11
[drm] Initialized i915 1.5.0 20060119 on minor 0
[drm] Initialized i915 1.5.0 20060119 on minor 1
intelfb: Framebuffer driver for Intel(R) 
830M/845G/852GM/855GM/865G/915G/915GM/945G/945GM chipsets
intelfb: Version 0.9.4
intelfb: 00:02.0: Intel(R) 852GME, aperture size 128MB, stolen memory 16252kB
intelfb: Non-CRT device is enabled ( LVDS port ).  Disabling mode switching.
intelfb: Initial video mode is 1024x768-32@60.
intelfb: Changing the video mode is not supported.
Console: switching to colour frame buffer device 128x48
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 10 (level, low) -> 
IRQ 10
ICH4: chipset revision 3
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1810-0x1817, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1818-0x181f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: HTS726060M9AT00, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: TOSHIBA CD/DVDW SDR6472U, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 512KiB
hda: 117210240 sectors (60011 MB) w/7877KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3
Yenta: CardBus bridge found at 0000:01:04.0 [1025:0039]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:01:04.0, mfunc 0x00921b22, devctl 0x64
Yenta: ISA IRQ mask 0x00b8, PCI irq 10
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x3000 - 0x3fff
cs: IO port probe 0x3000-0x3fff: clean.
pcmcia: parent PCI bridge Memory window: 0xe0200000 - 0xe02fffff
pcmcia: parent PCI bridge Memory window: 0x50000000 - 0x54ffffff
Yenta: CardBus bridge found at 0000:01:04.1 [1025:0039]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:01:04.1, mfunc 0x00921b22, devctl 0x64
Yenta: ISA IRQ mask 0x00b8, PCI irq 10
Socket status: 30000010
pcmcia: parent PCI bridge I/O window: 0x3000 - 0x3fff
cs: IO port probe 0x3000-0x3fff: clean.
pcmcia: parent PCI bridge Memory window: 0xe0200000 - 0xe02fffff
pcmcia: parent PCI bridge Memory window: 0x50000000 - 0x54ffffff
usbmon: debugfs is not available
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
GACT probability on
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
p4-clockmod: P4/Xeon(TM) CPU On-Demand Clock Modulation available
Using IPI Shortcut mode
Time: tsc clocksource has been installed.
Time: acpi_pm clocksource has been installed.
ACPI: (supports S0 S3 S4 S5)
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 172k freed
input: AT Translated Set 2 keyboard as /class/input/input0
pccard: PCMCIA card inserted into slot 1
cs: memory probe 0xe0200000-0xe02fffff: excluding 0xe0200000-0xe020ffff
pcmcia: registering new device pcmcia1.0
Synaptics Touchpad, model: 1, fw: 5.8, id: 0x9248b1, caps: 0x904713/0x4000
input: SynPS/2 Synaptics TouchPad as /class/input/input1
Real Time Clock Driver v1.12ac
NET: Registered protocol family 23
input: PC Speaker as /class/input/input2
hdc: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
cs: IO port probe 0x100-0x4ff: excluding 0x2f8-0x2ff 0x378-0x37f 0x3c0-0x3df 
0x4d0-0x4d7
cs: IO port probe 0x800-0x8ff:<6>8139too Fast Ethernet driver 0.9.27
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt 0000:01:0a.0[A] -> Link [LNKD] -> GSI 11 (level, low) -> 
IRQ 11
eth0: RealTek RTL8139 at 0xf8836000, 00:0a:e4:44:3c:b7, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8101'
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [LNKH] -> GSI 11 (level, low) -> 
IRQ 11
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 11, io mem 0xe0100000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v3.0
 excluding 0x800-0x80f
cs: IO port probe 0xc00-0xcff: clean.
cs: IO port probe 0xa00-0xaff: clean.
ieee80211_crypt: registered algorithm 'NULL'
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> 
IRQ 11
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 11, io base 0x00001820
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKD] -> GSI 11 (level, low) -> 
IRQ 11
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 11, io base 0x00001840
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
nsc-ircc, chip->init
nsc-ircc, Found chip at base=0x02e
nsc-ircc, driver loaded (Dag Brattli)
IrDA: Registered device irda0
nsc-ircc, Using dongle: HP HSDL-2300, HP HSDL-3600/HSDL-3610
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 10 (level, low) -> 
IRQ 10
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 10, io base 0x00001860
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
hostap_cs: 0.4.4-kernel (Jouni Malinen <jkmaline@cc.hut.fi>)
hostap_cs: Registered netdevice wifi0
hostap_cs: index 0x01: , irq 3, io 0x3100-0x313f
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 5, dma 3 
[PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
prism2_hw_init: initialized in 193 ms
usb 4-1: new full speed USB device using uhci_hcd and address 2
usb 4-1: configuration #1 chosen from 1 choice
wifi0: hfa384x_cmd: entry still in list? (entry=f7ff8b80, type=0, res=0)
wifi0: hfa384x_cmd: command was not completed (res=0, entry=f7ff8b80, type=0, 
cmd=0x0021, param0=0xfd0b, EVSTAT=8010 INTEN=0010)
wifi0: interrupt delivery does not seem to work
wifi0: hfa384x_get_rid: CMDCODE_ACCESS failed (res=-110, rid=fd0b, len=8)
Could not get RID for component NIC
hostap_cs: Initialization failed
hostap_cs: probe of 1.0 failed with error 1
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LNKB] -> GSI 10 (level, low) -> 
IRQ 10
PCI: Setting latency timer of device 0000:00:1f.6 to 64
ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 10 (level, low) -> 
IRQ 10
PCI: Setting latency timer of device 0000:00:1f.5 to 64
cs: IO port probe 0x100-0x4ff: excluding 0x3c0-0x3df 0x4d0-0x4d7
cs: IO port probe 0x800-0x8ff:<6>Serial: 8250/16550 driver $Revision: 1.90 $ 4 
ports, IRQ sharing disabled
 excluding 0x800-0x80f
cs: IO port probe 0xc00-0xcff: clean.
cs: IO port probe 0xa00-0xaff: clean.
1.0: RequestIO: Configuration locked
1.0: GetNextTuple: No more items
usbcore: registered new driver hiddev
input: HID 0a12:1000 as /class/input/input3
input: USB HID v1.11 Keyboard [HID 0a12:1000] on usb-0000:00:1d.2-1
input: HID 0a12:1000 as /class/input/input4
input: USB HID v1.11 Mouse [HID 0a12:1000] on usb-0000:00:1d.2-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
intel8x0_measure_ac97_clock: measured 50393 usecs
intel8x0: clocking to 48000
wifi0: hfa384x_cmd: entry still in list? (entry=f7ff8a00, type=0, res=0)
wifi0: hfa384x_cmd: command was not completed (res=0, entry=f7ff8a00, type=0, 
cmd=0x0002, param0=0x0000, EVSTAT=8010 INTEN=0010)
wifi0: interrupt delivery does not seem to work
hostap_cs: Shutdown failed
hostap_cs: probe of 1.0 failed with error 1
Adding 698816k swap on /dev/hda3.  Priority:-1 extents:1 across:698816k
EXT3 FS on hda2, internal journal
Bluetooth: Core ver 2.10
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: HCI USB driver ver 2.9
usbcore: registered new driver hci_usb
NTFS driver 2.1.27 [Flags: R/W MODULE].
NTFS volume version 3.1.
NTFS-fs error (device hda1): load_system_files(): Volume is dirty.  Mounting 
read-only.  Run chkdsk and mount in Windows.
pcmcia: Detected deprecated PCMCIA ioctl usage from process: discover.
pcmcia: This interface will soon be removed from the kernel; please expect 
breakage unless you upgrade to new tools.
pcmcia: see http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html 
for details.
microcode: CPU0 updated from revision 0x17 to 0x2e, date = 08112004
lp0: using parport0 (interrupt-driven).
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: HIDP (Human Interface Emulation) ver 1.1
usb 4-1: usbfs: USBDEVFS_CONTROL failed cmd hid2hci rqt 64 rq 0 len 0 ret -84
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.8
Bluetooth: BNEP (Ethernet Emulation) ver 1.2
Bluetooth: BNEP filters: protocol multicast
usb 4-1: USB disconnect, address 2
usb 4-1: new full speed USB device using uhci_hcd and address 3
usb 4-1: configuration #1 chosen from 1 choice
input: Bluetooth HID Boot Protocol Device as /class/input/input5

I think this is related to this bugzilla entry I filled before, but nobody 
took care about this:

http://bugzilla.kernel.org/show_bug.cgi?id=6916

I used hotplug before - then dongle wasn't found at all, with udev infra 
works, but hostap_cs not work then.

Michal


Dne ètvrtek 19 øíjen 2006 10:44 Andrew Morton napsal(a):
> On Thu, 19 Oct 2006 10:12:49 +0200
>
> CIJOML <cijoml@volny.cz> wrote:
> > it is nsc-ircc:
> >
> > nsc-ircc, chip->init
> > nsc-ircc, Found chip at base=0x02e
> > nsc-ircc, driver loaded (Dag Brattli)
> > nsc-ircc, Using dongle: HP HSDL-2300, HP HSDL-3600/HSDL-3610
>
> Well you could try this I suppose...
>
> --- a/drivers/net/irda/nsc-ircc.c~a
> +++ a/drivers/net/irda/nsc-ircc.c
> @@ -2160,7 +2160,8 @@ static int nsc_ircc_net_open(struct net_
>
>  	iobase = self->io.fir_base;
>
> -	if (request_irq(self->io.irq, nsc_ircc_interrupt, 0, dev->name, dev)) {
> +	if (request_irq(self->io.irq, nsc_ircc_interrupt, IRQF_SHARED,
> +			dev->name, dev)) {
>  		IRDA_WARNING("%s, unable to allocate irq=%d\n",
>  			     driver_name, self->io.irq);
>  		return -EAGAIN;
> @@ -2354,7 +2355,7 @@ static int nsc_ircc_resume(struct platfo
>  	nsc_ircc_init_dongle_interface(self->io.fir_base, self->io.dongle_id);
>
>  	if (netif_running(self->netdev)) {
> -		if (request_irq(self->io.irq, nsc_ircc_interrupt, 0,
> +		if (request_irq(self->io.irq, nsc_ircc_interrupt, IRQF_SHARED,
>  				self->netdev->name, self->netdev)) {
>   		    	IRDA_WARNING("%s, unable to allocate irq=%d\n",
>  				     driver_name, self->io.irq);
> _
>
>
> Did this all work under any previous kernel?  If so, which version?
>
> It'd be useful to see the full `dmesg -s 1000000' output for both good and
> bad kernels, and /proc/interrupts for the good kernel.
