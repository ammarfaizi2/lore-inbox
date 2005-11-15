Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932527AbVKOOBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932527AbVKOOBw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 09:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbVKOOBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 09:01:52 -0500
Received: from barclay.balt.net ([195.14.162.78]:12163 "EHLO barclay.balt.net")
	by vger.kernel.org with ESMTP id S932527AbVKOOBv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 09:01:51 -0500
Date: Tue, 15 Nov 2005 16:00:24 +0200
From: Zilvinas Valinskas <zilvinas@gemtek.lt>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Andrew Morton <akpm@osdl.org>,
       Alexandre Buisse <alexandre.buisse@ens-lyon.fr>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, yi.zhu@intel.com,
       jketreno@linux.intel.com
Subject: Re: Linuv 2.6.15-rc1
Message-ID: <20051115140023.GB9910@gemtek.lt>
Reply-To: Zilvinas Valinskas <zilvinas@gemtek.lt>
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org> <4378980C.7060901@ens-lyon.fr> <20051114162942.5b163558.akpm@osdl.org> <20051115100519.GA5567@gemtek.lt> <20051115115657.GA30489@gemtek.lt> <84144f020511150451l6ef30420g5a83a147c61f34a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <84144f020511150451l6ef30420g5a83a147c61f34a8@mail.gmail.com>
X-Attribution: Zilvinas
X-Url: http://www.gemtek.lt/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello again,

screenshots of ooops (not of the best quality though :( ) - 
http://www.gemtek.lt/~zilvinas/dumps/  - as it can be seen from
screenshots crashing in _ipw_read_indirect_0xa9/0x179 ... This time it
took a while to reproduce a problem. Somehow I get impression it is
either f/w loading related (see attached oops.1 file) and/or initiating
scan and reading back wireless scan results ??? ...

Also for a very first time I hit f/w loading problems (perhaps I haven't
noticed those messages earlier somehow...). Anyway f/w loading errors
out and there are signs of poisoning 6b6b6b6b ... Please see the
attached file.

Zilvinas Valinskas

On Tue, Nov 15, 2005 at 02:51:16PM +0200, Pekka Enberg wrote:
> Hi Zilvinas,
> 
> Would be helpful to see the oops message... If you don't have serial
> console handy, you can do the below to disable the call trace.
> 
>                          Pekka
> 
> Index: 2.6/arch/i386/kernel/traps.c
> ===================================================================
> --- 2.6.orig/arch/i386/kernel/traps.c
> +++ 2.6/arch/i386/kernel/traps.c
> @@ -185,8 +185,10 @@ void show_stack(struct task_struct *task
>  			printk("\n       ");
>  		printk("%08lx ", *stack++);
>  	}
> +#if 0
>  	printk("\nCall Trace:\n");
>  	show_trace(task, esp);
> +#endif
>  }
> 

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops.1"

 00000000 00000400 00000000 00000000
CPU: After vendor identify, caps: bfebf9ff 00000000 00000000 00000000 00000400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After all inits, caps: bfebf9f7 00000000 00000000 00000080 00000400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
mtrr: v2.0 (20020519)
CPU: Intel Mobile Intel(R) Pentium(R) 4 - M CPU 1.70GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0c20)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xf031f, last bus=3
PCI: Using configuration type 1
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [C046] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.C046] bus is 0
PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 1100-113f claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.C046._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C046.C047._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C046.C058._PRT]
ACPI: Embedded Controller [C0E4] (gpe 29)
ACPI: Power Resource [C155] (off)
ACPI: Power Resource [C169] (off)
ACPI: Power Resource [C16D] (off)
ACPI: Power Resource [C171] (off)
ACPI: Power Resource [C17A] (on)
ACPI: PCI Interrupt Link [C0C0] (IRQs 5 10 *11)
ACPI: PCI Interrupt Link [C0C1] (IRQs *5 10 11)
ACPI: PCI Interrupt Link [C0C2] (IRQs 5 10 11) *0, disabled.
ACPI: PCI Interrupt Link [C0C3] (IRQs 5 10 *11)
ACPI: PCI Interrupt Link [C0C4] (IRQs 5 *10 11)
ACPI: PCI Interrupt Link [C0C5] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [C0C6] (IRQs) *0, disabled.
ACPI: PCI Interrupt Link [C0C7] (IRQs) *0, disabled.
ACPI: Power Resource [C0E3] (on)
ACPI: Power Resource [C1EB] (off)
ACPI: Power Resource [C1EC] (off)
ACPI: Power Resource [C1ED] (off)
ACPI: Power Resource [C1EE] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 15 devices
PnPBIOS: Disabled by ACPI PNP
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:0d: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:0d: ioport range 0x1000-0x107f could not be reserved
pnp: 00:0d: ioport range 0x1100-0x113f has been reserved
pnp: 00:0d: ioport range 0x1200-0x121f has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: 2000-2fff
  MEM window: 40300000-403fffff
  PREFETCH window: 48000000-4fffffff
PCI: Bus 3, cardbus bridge: 0000:02:06.0
  IO window: 00004000-000040ff
  IO window: 00004400-000044ff
  PREFETCH window: 30000000-31ffffff
  MEM window: 34000000-35ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 4000-4fff
  MEM window: 40000000-402fffff
  PREFETCH window: 30000000-31ffffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
ACPI: PCI Interrupt Link [C0C3] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:02:06.0[A] -> Link [C0C3] -> GSI 11 (level, low) -> IRQ 11
Machine check exception polling timer started.
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SGI XFS with ACLs, no debug enabled
SGI XFS Quota Management subsystem
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
usbmon: debugfs is not available
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
ACPI: PCI Interrupt Link [C0C0] enabled at IRQ 11
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [C0C0] -> GSI 11 (level, low) -> IRQ 11
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=260.75 Mhz, System=175.75 MHz
radeonfb: PLL min 12000 max 35000
radeonfb: Monitor 1 type LCD found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
radeonfb: panel ID string: LGP                     
radeonfb: detected LVDS panel size from BIOS: 1400x1050
radeondb: BIOS provided dividers will be used
radeonfb: Dynamic Clock Power Management enabled
Console: switching to colour frame buffer device 175x65
radeonfb (0000:01:00.0): ATI Radeon LW 
ACPI: AC Adapter [C130] (on-line)
ACPI: Battery Slot [C132] (battery present)
ACPI: Battery Slot [C131] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [C190]
ACPI: Sleep Button (CM) [C134]
ACPI: Lid Switch [C133]
ACPI: Fan [C1EF] (off)
ACPI: Fan [C1F0] (off)
ACPI: Fan [C1F1] (off)
ACPI: Fan [C1F2] (off)
ACPI: Video Device [C0CE] (multi-head: yes  rom: no  post: no)
Using specific hotkey driver
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [C000] (supports 8 throttling states)
ACPI: Thermal Zone [TZ1] (51 C)
ACPI: Thermal Zone [TZ2] (45 C)
ACPI: Thermal Zone [TZ3] (16 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
PNP: PS/2 Controller [PNP0303:C177,PNP0f13:C178] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 1 [PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
lp0: using parport0 (interrupt-driven).
e100: Intel(R) PRO/100 Network Driver, 3.4.14-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt Link [C0C2] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [C0C2] -> GSI 10 (level, low) -> IRQ 10
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x3440-0x3447, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x3448-0x344f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: SAMSUNG MP0804H, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: HL-DT-STCD-RW/DVD DRIVE GCC-4240N, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 156368016 sectors (80060 MB) w/8192KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 > hda3 hda4
 hda3: <bsd: hda11 hda12 hda13 hda14 hda15 >
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
NET: Registered protocol family 2
IP route cache hash table entries: 8192 (order: 3, 32768 bytes)
TCP established hash table entries: 32768 (order: 5, 131072 bytes)
TCP bind hash table entries: 32768 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
Using IPI Shortcut mode
ACPI wakeup devices: 
C058 C0AA C0B0 C0B3 C181 C177 C178 C190 C134 
ACPI: (supports S0 S3 S4 S5)
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 148k freed
input: AT Translated Set 2 keyboard as /class/input/input0
Synaptics Touchpad, model: 1, fw: 5.9, id: 0x336ab1, caps: 0x984713/0x4000
input: SynPS/2 Synaptics TouchPad as /class/input/input1
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS2 at I/O 0x3e8 (irq = 4) is a NS16550A
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [C0C4] enabled at IRQ 10
ACPI: PCI Interrupt 0000:02:0e.0[A] -> Link [C0C4] -> GSI 10 (level, low) -> IRQ 10
ohci_hcd 0000:02:0e.0: OHCI Host Controller
ohci_hcd 0000:02:0e.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:02:0e.0: irq 10, io mem 0x40100000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
Linux agpgart interface v0.101 (c) Dave Jones
ACPI: PCI Interrupt 0000:02:06.0[A] -> Link [C0C3] -> GSI 11 (level, low) -> IRQ 11
Yenta: CardBus bridge found at 0000:02:06.0 [0e11:004a]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:06.0, mfunc 0x012c1202, devctl 0x64
input: PC Speaker as /class/input/input2
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
NET: Registered protocol family 23
00:02: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Yenta: ISA IRQ mask 0x0038, PCI irq 11
Socket status: 30000020
pcmcia: parent PCI bridge I/O window: 0x4000 - 0x4fff
cs: IO port probe 0x4000-0x4fff: clean.
pcmcia: parent PCI bridge Memory window: 0x40000000 - 0x402fffff
pcmcia: parent PCI bridge Memory window: 0x30000000 - 0x31ffffff
ieee80211_crypt: registered algorithm 'NULL'
ieee80211: 802.11 data/management/control stack, git-1.1.7
ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
agpgart: Detected an Intel i845 Chipset.
agpgart: AGP aperture is 256M @ 0x60000000
ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, git-1.0.8
ipw2200: Copyright(c) 2003-2005 Intel Corporation
ACPI: PCI Interrupt Link [C0C1] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:02:04.0[A] -> Link [C0C1] -> GSI 5 (level, low) -> IRQ 5
ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
ACPI: PCI Interrupt 0000:02:0e.1[B] -> Link [C0C4] -> GSI 10 (level, low) -> IRQ 10
ohci_hcd 0000:02:0e.1: OHCI Host Controller
ohci_hcd 0000:02:0e.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:02:0e.1: irq 10, io mem 0x40180000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usb 1-1: new full speed USB device using ohci_hcd and address 2
ACPI: PCI Interrupt 0000:02:0e.2[C] -> Link [C0C4] -> GSI 10 (level, low) -> IRQ 10
ehci_hcd 0000:02:0e.2: EHCI Host Controller
ehci_hcd 0000:02:0e.2: new USB bus registered, assigned bus number 3
ehci_hcd 0000:02:0e.2: irq 10, io mem 0x40200000
ehci_hcd 0000:02:0e.2: USB 2.0 initialized, EHCI 0.95, driver 10 Dec 2004
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 5 ports detected
usb 1-2: new low speed USB device using ohci_hcd and address 3
usb 1-1: USB disconnect, address 2
ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [C0C1] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1f.5 to 64
usb 1-1: new full speed USB device using ohci_hcd and address 4
intel8x0_measure_ac97_clock: measured 50979 usecs
intel8x0: clocking to 48000
pccard: CardBus card inserted into slot 0
usb 1-2: new low speed USB device using ohci_hcd and address 5
input: Targus USB Mouse as /class/input/input3
input: USB HID v1.00 Mouse [Targus USB Mouse] on usb-0000:02:0e.0-2
ipw2200: ipw-2.4-bss.fw load failed: Reason -2
ipw2200: Unable to load firmware: -2
ipw2200: failed to register network device
ACPI: PCI interrupt for device 0000:02:04.0 disabled
ipw2200: probe of 0000:02:04.0 failed with error -5
Unable to handle kernel paging request at virtual address 6b6b6c6b
 printing eip:
c0181cec
*pde = 00000000
Oops: 0002 [#1]
DEBUG_PAGEALLOC
Modules linked in: snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss irtty_sir snd_pcm snd_timer snd sir_dev ipw2200 intel_agp ieee80211 ieee80211_crypt soundcore 8250_pnp irda ide_cd pcspkr yenta_socket rsrc_nonstatic agpgart firmware_class snd_page_alloc ehci_hcd ohci_hcd 8250 serial_core floppy pcmcia_core cdrom crc_ccitt
CPU:    0
EIP:    0060:[<c0181cec>]    Not tainted VLI
EFLAGS: 00010202   (2.6.15-rc1) 
EIP is at release+0x2a/0x4f
eax: 6b6b6b6b   ebx: de312f00   ecx: 1ddcc000   edx: 00000001
esi: dd572ddc   edi: def57000   ebp: dda16f74   esp: dde19f74
ds: 007b   es: 007b   ss: 0068
Process cat (pid: 1299, threadinfo=dde19000 task=dd8ffb10)
Stack: 00000008 de2affd4 dd877eb4 c0149a4d 00000000 de2aff70 c14d9e38 dd877eb4 
       dda16f74 00000000 dd816e48 dde19000 c01484ef 00000001 00000001 b7f185c0 
       ffffffff c0102bd3 00000001 00000000 b7f17ff4 b7f185c0 ffffffff bfa54298 Code: e8 57 56 53 8b 4a 08 8b 41 14 8b 40 50 8b 58 14 8b 41 50 8b 70 14 8b 7a 74 85 db 74 07 89 d8 e8 26 4b 0a 00 8b 46 04 85 c0 74 0b <ff> 88 00 01 00 00 83 38 02 74 0d 89 f8 e8 7e 4e fb ff 31 c0 5b 
 <6>usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial support registered for generic
usbcore: registered new driver usbserial_generic
drivers/usb/serial/usb-serial.c: USB Serial Driver core
drivers/usb/serial/usb-serial.c: USB Serial support registered for pl2303
pl2303 1-1:1.0: pl2303 converter detected
usb 1-1: pl2303 converter now attached to ttyUSB0
usbcore: registered new driver pl2303
drivers/usb/serial/pl2303.c: Prolific PL2303 USB to serial adaptor driver
Adding 997880k swap on /dev/hda6.  Priority:-1 extents:1 across:997880k
EXT3 FS on hda1, internal journal
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda10, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
NET: Registered protocol family 10
Disabled Privacy Extensions on device c03ab660(lo)
IPv6 over IPv4 tunneling driver
pcmcia: Detected deprecated PCMCIA ioctl usage.
pcmcia: This interface will soon be removed from the kernel; please expect breakage unless you upgrade to new tools.
pcmcia: see http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html for details.
cs: IO port probe 0x100-0x4ff: clean.
cs: IO port probe 0x800-0x8ff: clean.
cs: IO port probe 0xc00-0xcff: clean.
cs: IO port probe 0xa00-0xaff: clean.
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
microcode: CPU0 updated from revision 0x26 to 0x39, date = 06042003 
IA-32 Microcode Update Driver v1.14 unregistered

--EeQfGwPcQSOJBaQU--
