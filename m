Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbWAQQrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWAQQrM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 11:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWAQQrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 11:47:12 -0500
Received: from 213-140-2-71.ip.fastwebnet.it ([213.140.2.71]:3463 "EHLO
	aa004msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932173AbWAQQrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 11:47:10 -0500
Date: Tue, 17 Jan 2006 17:45:00 +0100
From: Mattia Dongili <malattia@linux.it>
To: john stultz <johnstul@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: first bisection results in -mm3 [was: Re: 2.6.15-mm2: reiser3 oops on suspend and more (bonus oops shot!)]
Message-ID: <20060117164500.GB3591@inferi.kami.home>
Mail-Followup-To: john stultz <johnstul@us.ibm.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060111100016.GC2574@elf.ucw.cz> <20060110235554.GA3527@inferi.kami.home> <20060110170037.4a614245.akpm@osdl.org> <20060111184027.GB4735@inferi.kami.home> <20060112220825.GA3490@inferi.kami.home> <1137108362.2890.141.camel@cog.beaverton.ibm.com> <20060114120816.GA3554@inferi.kami.home> <1137442582.27699.12.camel@cog.beaverton.ibm.com> <20060116204057.GC3639@inferi.kami.home> <1137447763.27699.27.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137447763.27699.27.camel@cog.beaverton.ibm.com>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.15-mm4-2 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2006 at 01:42:43PM -0800, john stultz wrote:
[...]
> and send me your dmesg.

ops, forgot it, here it is as plain text

[    0.000000] Linux version 2.6.15-mm4-3 (mattia@inferi) (gcc version 4.0.3 20051201 (prerelease) (Debian 4.0.2-5)) #4 PREEMPT Tue Jan 17 16:00:41 CET 2006
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
[    0.000000]  BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000c0000 - 00000000000d0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000d8000 - 00000000000e0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000000fef0000 (usable)
[    0.000000]  BIOS-e820: 000000000fef0000 - 000000000feff000 (ACPI data)
[    0.000000]  BIOS-e820: 000000000feff000 - 000000000ff00000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000000ff00000 - 000000000ff80000 (usable)
[    0.000000]  BIOS-e820: 000000000ff80000 - 0000000010000000 (reserved)
[    0.000000]  BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
[    0.000000]  BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
[    0.000000] 255MB LOWMEM available.
[    0.000000] On node 0 totalpages: 65408
[    0.000000]   DMA zone: 4096 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 0 pages, LIFO batch:0
[    0.000000]   Normal zone: 61312 pages, LIFO batch:15
[    0.000000]   HighMem zone: 0 pages, LIFO batch:0
[    0.000000] DMI present.
[    0.000000] ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f6cd0
[    0.000000] ACPI: RSDT (v001 SONY   C0       0x20010809 PTL  0x00000000) @ 0x0fefa88f
[    0.000000] ACPI: FADT (v001   SONY       C0 0x20010809 PTL  0x01000000) @ 0x0fefef64
[    0.000000] ACPI: BOOT (v001   SONY       C0 0x20010809 PTL  0x00000001) @ 0x0fefefd8
[    0.000000] ACPI: DSDT (v001   SONY       C0 0x20010809 PTL  0x0100000d) @ 0x00000000
[    0.000000] ACPI: PM-Timer IO Port: 0x1008
[    0.000000] Allocating PCI resources starting at 20000000 (gap: 10000000:ef800000)
[    0.000000] Detected 994.334 MHz processor.
[   16.592942] Built 1 zonelists
[   16.592947] Local APIC disabled by BIOS -- reenabling.
[   16.592952] Found and enabled local APIC!
[   16.592958] mapped APIC to ffffd000 (fee00000)
[   16.592965] Enabling fast FPU save and restore... done.
[   16.592970] Enabling unmasked SIMD FPU exception support... done.
[   16.592976] Initializing CPU#0
[   16.592988] Kernel command line: root=/dev/hda1 ro vga=extended video=radeonfb:800x600-32@60 fbcon=font:Acorn8x8 lapic resume=/dev/hda2
[   16.593550] CPU 0 irqstacks, hard=c0416000 soft=c0417000
[   16.593557] PID hash table entries: 1024 (order: 10, 16384 bytes)
[   17.544379] Console: colour VGA+ 80x50
[   17.545836] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[   17.546478] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[   17.561178] Memory: 255112k/261632k available (2067k kernel code, 5900k reserved, 913k data, 152k init, 0k highmem)
[   17.561225] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[   17.640678] Calibrating delay using timer specific routine.. 1989.94 BogoMIPS (lpj=3979887)
[   17.640821] Mount-cache hash table entries: 512
[   17.641031] CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
[   17.641045] CPU: After vendor identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
[   17.641061] CPU: L1 I cache: 16K, L1 D cache: 16K
[   17.641134] CPU: L2 cache: 512K
[   17.641176] CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000 00000000 00000000
[   17.641188] Intel machine check architecture supported.
[   17.641233] Intel machine check reporting enabled on CPU#0.
[   17.641286] mtrr: v2.0 (20020519)
[   17.641331] CPU: Intel(R) Pentium(R) III Mobile CPU      1000MHz stepping 01
[   17.641437] Checking 'hlt' instruction... OK.
[   17.658974]  tbxface-0109 [02] load_tables           : ACPI Tables successfully acquired
[   17.670609] Parsing all Control Methods:
[   17.671138] Table [DSDT](id 0005) - 555 Objects with 54 Devices 191 Methods 21 Regions
[   17.671230] ACPI Namespace successfully loaded at root c04491f8
[   17.705135] evxfevnt-0091 [03] enable                : Transition to ACPI mode successful
[   17.813101] NET: Registered protocol family 16
[   17.813176] ACPI: bus type pci registered
[   17.816737] PCI: PCI BIOS revision 2.10 entry at 0xfd9aa, last bus=2
[   17.816789] PCI: Using configuration type 1
[   17.817061] ACPI: Subsystem revision 20051216
[   17.818967] evgpeblk-0941 [06] ev_create_gpe_block   : GPE 00 to 0F [_GPE] 2 regs on int 0x9
[   17.819111] evgpeblk-0941 [06] ev_create_gpe_block   : GPE 10 to 1F [_GPE] 2 regs on int 0x9
[   17.820643] evgpeblk-1037 [05] ev_initialize_gpe_bloc: Found 6 Wake, Enabled 0 Runtime GPEs in this block
[   17.821507] evgpeblk-1037 [05] ev_initialize_gpe_bloc: Found 1 Wake, Enabled 0 Runtime GPEs in this block
[   17.826779] Completing Region/Field/Buffer/Package initialization:..............................................................
[   17.833828] Initialized 20/21 Regions 0/0 Fields 25/25 Buffers 17/27 Packages (564 nodes)
[   17.833917] Executing all Device _STA and_INI methods:..........................................................
[   17.843774] 58 Devices found containing: 3 _STA, 3 _INI methods
[   17.843883] ACPI: Interpreter enabled
[   17.843925] ACPI: Using PIC for interrupt routing
[   17.845783] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   17.845829] PCI: Probing PCI hardware (bus 00)
[   17.883395] PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
[   17.883443] PCI quirk: region 1180-11bf claimed by ICH4 GPIO
[   17.883527] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
[   17.883771] Boot video device is 0000:01:00.0
[   17.884009] PCI: Transparent bridge - 0000:00:1e.0
[   17.884128] PCI: Bus #03 (-#06) may be hidden behind transparent bridge #02 (-#02) (try 'pci=assign-busses')
[   17.884237] PCI: Bus #07 (-#0a) may be hidden behind transparent bridge #02 (-#02) (try 'pci=assign-busses')
[   17.884324] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   17.902237] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
[   17.905223] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB_._PRT]
[   17.912405] ACPI: Embedded Controller [EC0] (gpe 28) interrupt mode.
[   17.956448] ACPI: PCI Interrupt Link [LNKA] (IRQs *9)
[   17.957856] ACPI: PCI Interrupt Link [LNKB] (IRQs 9) *0, disabled.
[   17.959316] ACPI: PCI Interrupt Link [LNKC] (IRQs 9) *0, disabled.
[   17.960988] ACPI: PCI Interrupt Link [LNKD] (IRQs *9)
[   17.962597] ACPI: PCI Interrupt Link [LNKE] (IRQs *9)
[   17.964195] ACPI: PCI Interrupt Link [LNKF] (IRQs 9) *0
[   17.965645] ACPI: PCI Interrupt Link [LNKG] (IRQs 9) *0, disabled.
[   17.967108] ACPI: PCI Interrupt Link [LNKH] (IRQs 9) *0, disabled.
[   17.967877] Linux Plug and Play Support v0.97 (c) Adam Belay
[   17.968022] PCI: Using ACPI for IRQ routing
[   17.968067] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   17.973247] PCI: Bridge: 0000:00:01.0
[   17.973292]   IO window: 3000-3fff
[   17.973336]   MEM window: d0100000-d01fffff
[   17.973379]   PREFETCH window: d8000000-dfffffff
[   17.973440] PCI: Bus 3, cardbus bridge: 0000:02:05.0
[   17.973484]   IO window: 00004400-000044ff
[   17.973528]   IO window: 00004800-000048ff
[   17.973571]   PREFETCH window: 20000000-21ffffff
[   17.973616]   MEM window: 24000000-25ffffff
[   17.973659] PCI: Bus 7, cardbus bridge: 0000:02:05.1
[   17.973703]   IO window: 00004c00-00004cff
[   17.973746]   IO window: 00001400-000014ff
[   17.973790]   PREFETCH window: 22000000-23ffffff
[   17.973835]   MEM window: 26000000-27ffffff
[   17.973878] PCI: Bridge: 0000:00:1e.0
[   17.973920]   IO window: 4000-4fff
[   17.973964]   MEM window: d0200000-d02fffff
[   17.974009]   PREFETCH window: 20000000-23ffffff
[   17.974067] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[   17.974130] **** SET: Misaligned resource pointer: cff4a7e2 Type 07 Len 0
[   17.975437] ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 9
[   17.975484] PCI: setting IRQ 9 as level-triggered
[   17.975489] ACPI: PCI Interrupt 0000:02:05.0[A] -> Link [LNKF] -> GSI 9 (level, low) -> IRQ 9
[   17.975605] PCI: Setting latency timer of device 0000:02:05.0 to 64
[   17.975653] **** SET: Misaligned resource pointer: cff4a7e2 Type 07 Len 0
[   17.976947] ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 9
[   17.976992] ACPI: PCI Interrupt 0000:02:05.1[B] -> Link [LNKG] -> GSI 9 (level, low) -> IRQ 9
[   17.977107] PCI: Setting latency timer of device 0000:02:05.1 to 64
[   17.977203] Simple Boot Flag at 0x36 set to 0x1
[   17.978505] Initializing Cryptographic API
[   17.978554] io scheduler noop registered
[   17.978631] io scheduler anticipatory registered
[   17.978708] io scheduler deadline registered
[   17.978795] io scheduler cfq registered
[   17.979079] acpi_bus-0201 [01] bus_set_power         : Device is not power manageable
[   17.979240] **** SET: Misaligned resource pointer: cff4a2e2 Type 07 Len 0
[   17.980662] ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
[   17.980708] ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 9 (level, low) -> IRQ 9
[   17.992388] radeonfb: Retrieved PLL infos from BIOS
[   17.992434] radeonfb: Reference=27.00 MHz (RefDiv=60) Memory=166.00 Mhz, System=166.00 MHz
[   17.992488] radeonfb: PLL min 12000 max 35000
[   18.020366] Time: tsc clocksource has been installed.
[   18.020412] TSC clocksource: 994334 khz, rating=300 mult=4218204 shift=22
[   18.927606] Non-DDC laptop panel detected
[   19.922774] radeonfb: Monitor 1 type LCD found
[   19.922818] radeonfb: Monitor 2 type no found
[   19.922864] radeonfb: panel ID string: Samsung LTN150P1-L02    
[   19.922909] radeonfb: detected LVDS panel size from BIOS: 1400x1050
[   19.922954] radeondb: BIOS provided dividers will be used
[   20.158575] radeonfb: Dynamic Clock Power Management enabled
[   20.430358] Console: switching to colour frame buffer device 100x75
[   20.431228] radeonfb (0000:01:00.0): ATI Radeon LY 
[   20.433773] ACPI: AC Adapter [ACAD] (on-line)
[   20.442738] ACPI: Battery Slot [BAT1] (battery present)
[   20.445059] ACPI: Battery Slot [BAT2] (battery absent)
[   20.445181] ACPI: Lid Switch [LID]
[   20.445268] ACPI: Power Button (CM) [PWRB]
[   20.445603] ACPI: CPU0 (power states: C1[C1] C2[C2])
[   20.452669] ACPI: Thermal Zone [ATF0] (49 C)
[   20.452793] isapnp: Scanning for PnP cards...
[   20.806346] isapnp: No Plug & Play device found
[   20.842860] PNP: No PS/2 controller found. Probing ports directly.
[   20.844641] serio: i8042 AUX port at 0x60,0x64 irq 12
[   20.844831] serio: i8042 KBD port at 0x60,0x64 irq 1
[   20.845099] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   20.845226] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   20.845420] ICH3M: IDE controller at PCI slot 0000:00:1f.1
[   20.845536] PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
[   20.845656]  pci_irq-0384 [02] pci_irq_derive        : Unable to derive IRQ for device 0000:00:1f.1
[   20.845880] ACPI: PCI Interrupt 0000:00:1f.1[A]: no GSI
[   20.846005] ICH3M: chipset revision 1
[   20.846080] ICH3M: not 100% native mode: will probe irqs later
[   20.846202]     ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
[   20.846377]     ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:pio, hdd:pio
[   20.846547] Probing IDE interface ide0...
[   20.855671] check_periodic_interval: short interval! 37827221 ns.
[   20.861705] 		bad calibration or timers may be broken.
[   20.867883] check_periodic_interval: short interval! 12223630 ns.
[   20.873956] 		bad calibration or timers may be broken.
[   20.880240] check_periodic_interval: short interval! 12367068 ns.
[   20.886412] 		bad calibration or timers may be broken.
[   20.892744] check_periodic_interval: short interval! 12514412 ns.
[   20.898987] 		bad calibration or timers may be broken.
[   20.905372] check_periodic_interval: short interval! 12638672 ns.
[   20.911666] 		bad calibration or timers may be broken.
[   20.918195] hda: FUJITSU MHV2080AH, ATA DISK drive
[   20.924698] check_periodic_interval: short interval! 19340529 ns.
[   20.931112] 		bad calibration or timers may be broken.
[   20.937686] check_periodic_interval: short interval! 12999194 ns.
[   20.944178] 		bad calibration or timers may be broken.
[   20.950834] check_periodic_interval: short interval! 13158854 ns.
[   20.957396] 		bad calibration or timers may be broken.
[   20.964062] check_periodic_interval: short interval! 13238120 ns.
[   20.970600] 		bad calibration or timers may be broken.
[   20.977278] check_periodic_interval: short interval! 13227073 ns.
[   20.983785] 		bad calibration or timers may be broken.
[   20.994991] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   21.001511] Probing IDE interface ide1...
[   21.011841] Probing IDE interface ide1...
[   21.022153] hda: max request size: 128KiB
[   21.028919] hda: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
[   21.035484] hda: cache flushes supported
[   21.041980]  hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
[   21.049415] mice: PS/2 mouse device common for all mice
[   21.055969] NET: Registered protocol family 2
[   21.063402] input: AT Translated Set 2 keyboard as /class/input/input0
[   21.070101] IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
[   21.076947] TCP established hash table entries: 16384 (order: 4, 65536 bytes)
[   21.083747] TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
[   21.090516] TCP: Hash tables configured (established 16384 bind 16384)
[   21.097112] TCP reno registered
[   21.103773] TCP bic registered
[   21.110268] NET: Registered protocol family 1
[   21.116704] NET: Registered protocol family 17
[   21.123072] Using IPI Shortcut mode
[   21.154137] ACPI wakeup devices: 
[   21.160382] PWRB USB1 USB2 USB3 CRD0 CRD1  LAN  EC0 COMA MODE 
[   21.166805] ACPI: (supports S0 S3 S4 S5)
[   21.173777] ReiserFS: hda1: found reiserfs format "3.6" with standard journal
[   21.182730] ReiserFS: hda1: using ordered data mode
[   21.189268] ReiserFS: hda1: journal params: device hda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   21.204655] ReiserFS: hda1: checking transaction log (hda1)
[   21.212097] ReiserFS: hda1: Using r5 hash to sort names
[   21.218665] VFS: Mounted root (reiserfs filesystem) readonly.
[   21.225419] Freeing unused kernel memory: 152k freed
[   22.826555] hw_random hardware driver 1.0.0 loaded
[   22.863045] usbcore: registered new driver usbfs
[   22.870147] usbcore: registered new driver hub
[   22.880784] Linux agpgart interface v0.101 (c) Dave Jones
[   22.894656] agpgart: Detected an Intel 830M Chipset.
[   22.916452] agpgart: AGP aperture is 256M @ 0xe0000000
[   22.939765] USB Universal Host Controller Interface driver v3.0
[   22.946632] ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 9 (level, low) -> IRQ 9
[   22.953532] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[   22.953540] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[   22.960618] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
[   22.967503] uhci_hcd 0000:00:1d.0: irq 9, io base 0x00001800
[   22.974540] usb usb1: configuration #1 chosen from 1 choice
[   22.981477] hub 1-0:1.0: USB hub found
[   22.988320] hub 1-0:1.0: 2 ports detected
[   23.095630] **** SET: Misaligned resource pointer: cf4f3c02 Type 07 Len 0
[   23.103937] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
[   23.110791] ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
[   23.117689] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[   23.117697] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[   23.124540] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
[   23.131384] uhci_hcd 0000:00:1d.1: irq 9, io base 0x00001820
[   23.138329] usb usb2: configuration #1 chosen from 1 choice
[   23.145151] hub 2-0:1.0: USB hub found
[   23.151959] hub 2-0:1.0: 2 ports detected
[   23.259401] **** SET: Misaligned resource pointer: cf4f3d02 Type 07 Len 0
[   23.267849] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
[   23.274658] ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 9 (level, low) -> IRQ 9
[   23.281570] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[   23.281578] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[   23.288508] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
[   23.295415] uhci_hcd 0000:00:1d.2: irq 9, io base 0x00001840
[   23.302388] usb usb3: configuration #1 chosen from 1 choice
[   23.309274] hub 3-0:1.0: USB hub found
[   23.316089] hub 3-0:1.0: 2 ports detected
[   23.423175] PCI: Enabling device 0000:00:1f.5 (0000 -> 0001)
[   23.430113] **** SET: Misaligned resource pointer: cff382e2 Type 07 Len 0
[   23.438391] ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 9
[   23.445206] ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 9 (level, low) -> IRQ 9
[   23.452147] PCI: Setting latency timer of device 0000:00:1f.5 to 64
[   23.530922] usb 2-1: new low speed USB device using uhci_hcd and address 2
[   23.716804] usb 2-1: configuration #1 chosen from 1 choice
[   23.966556] usb 3-1: new full speed USB device using uhci_hcd and address 2
[   24.026538] intel8x0_measure_ac97_clock: measured 52457 usecs
[   24.033536] intel8x0: clocking to 48000
[   24.150626] usb 3-1: configuration #1 chosen from 1 choice
[   24.257221] ACPI: PCI Interrupt 0000:02:05.0[A] -> Link [LNKF] -> GSI 9 (level, low) -> IRQ 9
[   24.264352] Yenta: CardBus bridge found at 0000:02:05.0 [104d:80e7]
[   24.296380] e100: Intel(R) PRO/100 Network Driver, 3.4.14-k4-NAPI
[   24.303496] e100: Copyright(c) 1999-2005 Intel Corporation
[   24.406897] Yenta: ISA IRQ mask 0x0cb8, PCI irq 9
[   24.413893] Socket status: 30000006
[   24.420837] pcmcia: parent PCI bridge I/O window: 0x4000 - 0x4fff
[   24.427833] cs: IO port probe 0x4000-0x4fff: clean.
[   24.435270] pcmcia: parent PCI bridge Memory window: 0xd0200000 - 0xd02fffff
[   24.442308] pcmcia: parent PCI bridge Memory window: 0x20000000 - 0x23ffffff
[   24.450316] acpi_bus-0201 [01] bus_set_power         : Device is not power manageable
[   24.457455] **** SET: Misaligned resource pointer: cf515ca2 Type 07 Len 0
[   24.465863] ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 9
[   24.473011] ACPI: PCI Interrupt 0000:02:08.0[A] -> Link [LNKE] -> GSI 9 (level, low) -> IRQ 9
[   24.502383] e100: eth0: e100_probe: addr 0xd0204000, irq 9, MAC addr 08:00:46:26:50:59
[   24.509668] ACPI: PCI Interrupt 0000:02:05.1[B] -> Link [LNKG] -> GSI 9 (level, low) -> IRQ 9
[   24.517039] Yenta: CardBus bridge found at 0000:02:05.1 [104d:80e7]
[   24.650695] Yenta: ISA IRQ mask 0x0cb8, PCI irq 9
[   24.658069] Socket status: 30000006
[   24.665379] pcmcia: parent PCI bridge I/O window: 0x4000 - 0x4fff
[   24.672771] cs: IO port probe 0x4000-0x4fff: clean.
[   24.680545] pcmcia: parent PCI bridge Memory window: 0xd0200000 - 0xd02fffff
[   24.688072] pcmcia: parent PCI bridge Memory window: 0x20000000 - 0x23ffffff
[   25.099689] input: Logitech USB Mouse as /class/input/input1
[   25.114390] input: USB HID v1.10 Mouse [Logitech USB Mouse] on usb-0000:00:1d.1-1
[   25.121976] usbcore: registered new driver usbhid
[   25.129424] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
[   25.217824] SCSI subsystem initialized
[   25.275368] Initializing USB Mass Storage driver...
[   25.286225] scsi0 : SCSI emulation for USB Mass Storage devices
[   25.294165] usb-storage: device found at 2
[   25.294169] usb-storage: waiting for device to settle before scanning
[   25.294185] usbcore: registered new driver usb-storage
[   25.302507] USB Mass Storage support registered.
[   25.435207]   Vendor: Sony      Model: MSC-U02           Rev: 1.00
[   25.443398]   Type:   Direct-Access                      ANSI SCSI revision: 00
[   25.460353] usb-storage: device scan complete
[   25.492546] SCSI device sda: 7904 512-byte hdwr sectors (4 MB)
[   25.501255] sda: Write Protect is off
[   25.508991] sda: Mode Sense: 00 6a 10 00
[   25.508995] sda: assuming drive cache: write through
[   25.521716] SCSI device sda: 7904 512-byte hdwr sectors (4 MB)
[   25.530498] sda: Write Protect is off
[   25.538129] sda: Mode Sense: 00 6a 10 00
[   25.538134] sda: assuming drive cache: write through
[   25.545770]  sda: sda1
[   25.586782] sd 0:0:0:0: Attached scsi removable disk sda
[   25.808408] Adding 248996k swap on /dev/hda2.  Priority:-1 extents:1 across:248996k
[   26.050205] input: PC Speaker as /class/input/input2
[   26.104604] speedstep: frequency transition measured seems out of range (4800 nSec), falling back to a safe one of 500000 nSec.
[   26.137841] sonypi: Sony Programmable I/O Controller Driver v1.26.
[   26.149857] sonypi: detected type2 model, verbose = 0, fnkeyinit = off, camera = off, compat = off, mask = 0xffffffff, useinput = on, acpi = on
[   26.163316] sonypi: enabled at irq=11, port1=0x1080, port2=0x1084
[   26.170087] sonypi: device allocated minor is 63
[   26.191119] input: Sony Vaio Jogdial as /class/input/input3
[   26.226397] input: Sony Vaio Keys as /class/input/input4
[   26.281565] tun: Universal TUN/TAP device driver, 1.6
[   26.292148] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[   26.320519] ACPI Sony Notebook Control Driver v0.2 successfully installed
[   26.347144] Real Time Clock Driver v1.12ac
[   26.392679] Synaptics Touchpad, model: 1, fw: 5.9, id: 0x2548b1, caps: 0x804753/0x0
[   26.408654] input: SynPS/2 Synaptics TouchPad as /class/input/input5
[   26.434670] do_settimeofday() was called!
[   26.452811] do_settimeofday() was called!
[   26.623365] ReiserFS: hda3: found reiserfs format "3.6" with standard journal
[   26.643990] ReiserFS: hda3: using ordered data mode
[   26.650660] ReiserFS: hda3: journal params: device hda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   26.665746] ReiserFS: hda3: checking transaction log (hda3)
[   26.672893] ReiserFS: hda3: Using r5 hash to sort names
[   26.701880] SGI XFS with ACLs, security attributes, no debug enabled
[   26.710619] XFS mounting filesystem hda6
[   26.721647] Ending clean XFS mount for filesystem: hda6
[   27.245644] TSC clocksource: 994334 khz, rating=300 mult=4218204 shift=22
[   27.465933] TSC clocksource: 994334 khz, rating=300 mult=4218204 shift=22
[   27.681885] TSC clocksource: 994334 khz, rating=300 mult=4218204 shift=22
[   27.897878] TSC clocksource: 994334 khz, rating=300 mult=4218204 shift=22
[   28.190949] do_settimeofday() was called!
[   39.544076] TSC: Marked unstable
[   39.550209]  [<c0103bb3>] show_trace+0x13/0x20
[   39.556348]  [<c0103bde>] dump_stack+0x1e/0x20
[   39.562434]  [<c0108b77>] mark_tsc_unstable+0x27/0x40
[   39.568578]  [<c01090fb>] time_cpufreq_notifier+0x19b/0x1b0
[   39.574709]  [<c0127e3d>] notifier_call_chain+0x2d/0x50
[   39.580821]  [<c029b5dc>] cpufreq_notify_transition+0x13c/0x170
[   39.586921]  [<d120f3c0>] speedstep_target+0xd0/0xe0 [speedstep_ich]
[   39.593001]  [<c029b1d7>] __cpufreq_driver_target+0x77/0x80
[   39.599034]  [<d11de5ee>] do_dbs_timer+0x13e/0x200 [cpufreq_ondemand]
[   39.605099]  [<c012b1da>] run_workqueue+0x9a/0x140
[   39.611147]  [<c012b477>] worker_thread+0x107/0x140
[   39.617097]  [<c012eaa9>] kthread+0xd9/0xe0
[   39.622948]  [<c0101005>] kernel_thread_helper+0x5/0x10
[  243.600000] Time: acpi_pm clocksource has been installed.
[  246.108000] ip_tables: (C) 2000-2006 Netfilter Core Team
[  246.236000] ip_conntrack version 2.4 (2044 buckets, 16352 max) - 232 bytes per conntrack
[  246.636000] e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
[  252.524000] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[  556.512000] TSC: Marked unstable
[  556.512000]  [<c0103bb3>] show_trace+0x13/0x20
[  556.512000]  [<c0103bde>] dump_stack+0x1e/0x20
[  556.512000]  [<c0108b77>] mark_tsc_unstable+0x27/0x40
[  556.512000]  [<c01090fb>] time_cpufreq_notifier+0x19b/0x1b0
[  556.512000]  [<c0127e3d>] notifier_call_chain+0x2d/0x50
[  556.512000]  [<c029b551>] cpufreq_notify_transition+0xb1/0x170
[  556.512000]  [<d120f39d>] speedstep_target+0xad/0xe0 [speedstep_ich]
[  556.512000]  [<c029b1d7>] __cpufreq_driver_target+0x77/0x80
[  556.512000]  [<d11de66e>] do_dbs_timer+0x1be/0x200 [cpufreq_ondemand]
[  556.512000]  [<c012b1da>] run_workqueue+0x9a/0x140
[  556.512000]  [<c012b477>] worker_thread+0x107/0x140
[  556.512000]  [<c012eaa9>] kthread+0xd9/0xe0
[  556.512000]  [<c0101005>] kernel_thread_helper+0x5/0x10
[  556.532000] check_periodic_interval: Long interval! 135987395 ns.
[  556.532000] 		Something may be blocking interrupts.
[  563.016000] TSC: Marked unstable
[  563.016000]  [<c0103bb3>] show_trace+0x13/0x20
[  563.016000]  [<c0103bde>] dump_stack+0x1e/0x20
[  563.016000]  [<c0108b77>] mark_tsc_unstable+0x27/0x40
[  563.016000]  [<c01090fb>] time_cpufreq_notifier+0x19b/0x1b0
[  563.016000]  [<c0127e3d>] notifier_call_chain+0x2d/0x50
[  563.016000]  [<c029b5dc>] cpufreq_notify_transition+0x13c/0x170
[  563.016000]  [<d120f3c0>] speedstep_target+0xd0/0xe0 [speedstep_ich]
[  563.016000]  [<c029b1d7>] __cpufreq_driver_target+0x77/0x80
[  563.016000]  [<d11de5ee>] do_dbs_timer+0x13e/0x200 [cpufreq_ondemand]
[  563.016000]  [<c012b1da>] run_workqueue+0x9a/0x140
[  563.016000]  [<c012b477>] worker_thread+0x107/0x140
[  563.016000]  [<c012eaa9>] kthread+0xd9/0xe0
[  563.016000]  [<c0101005>] kernel_thread_helper+0x5/0x10
[  563.032000] check_periodic_interval: Long interval! 140156640 ns.
[  563.032000] 		Something may be blocking interrupts.
[  576.756000] Time: jiffies clocksource has been installed.
[  878.020000] TSC: Marked unstable
[  878.020000]  [<c0103bb3>] show_trace+0x13/0x20
[  878.020000]  [<c0103bde>] dump_stack+0x1e/0x20
[  878.020000]  [<c0108b77>] mark_tsc_unstable+0x27/0x40
[  878.020000]  [<c01090fb>] time_cpufreq_notifier+0x19b/0x1b0
[  878.020000]  [<c0127e3d>] notifier_call_chain+0x2d/0x50
[  878.020000]  [<c029b551>] cpufreq_notify_transition+0xb1/0x170
[  878.020000]  [<d120f39d>] speedstep_target+0xad/0xe0 [speedstep_ich]
[  878.020000]  [<c029b1d7>] __cpufreq_driver_target+0x77/0x80
[  878.020000]  [<d11de66e>] do_dbs_timer+0x1be/0x200 [cpufreq_ondemand]
[  878.020000]  [<c012b1da>] run_workqueue+0x9a/0x140
[  878.020000]  [<c012b477>] worker_thread+0x107/0x140
[  878.020000]  [<c012eaa9>] kthread+0xd9/0xe0
[  878.020000]  [<c0101005>] kernel_thread_helper+0x5/0x10
[  880.020000] TSC: Marked unstable
[  880.020000]  [<c0103bb3>] show_trace+0x13/0x20
[  880.020000]  [<c0103bde>] dump_stack+0x1e/0x20
[  880.020000]  [<c0108b77>] mark_tsc_unstable+0x27/0x40
[  880.020000]  [<c01090fb>] time_cpufreq_notifier+0x19b/0x1b0
[  880.020000]  [<c0127e3d>] notifier_call_chain+0x2d/0x50
[  880.020000]  [<c029b5dc>] cpufreq_notify_transition+0x13c/0x170
[  880.020000]  [<d120f3c0>] speedstep_target+0xd0/0xe0 [speedstep_ich]
[  880.020000]  [<c029b1d7>] __cpufreq_driver_target+0x77/0x80
[  880.020000]  [<d11de5ee>] do_dbs_timer+0x13e/0x200 [cpufreq_ondemand]
[  880.020000]  [<c012b1da>] run_workqueue+0x9a/0x140
[  880.020000]  [<c012b477>] worker_thread+0x107/0x140
[  880.020000]  [<c012eaa9>] kthread+0xd9/0xe0
[  880.020000]  [<c0101005>] kernel_thread_helper+0x5/0x10

-- 
mattia
:wq!
