Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262638AbVGHMzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262638AbVGHMzT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 08:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262626AbVGHMzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 08:55:19 -0400
Received: from ms002msg.fastwebnet.it ([213.140.2.52]:36319 "EHLO
	ms002msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S262638AbVGHMzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 08:55:15 -0400
Date: Fri, 8 Jul 2005 14:55:37 +0200
From: Mattia Dongili <malattia@gmail.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dmitry Torokhov <dtor@mail.ru>
Subject: Re: Synaptics Touchpad not detected in 2.6.13-rc2
Message-ID: <20050708125537.GA4191@inferi.kami.home>
Mail-Followup-To: Vojtech Pavlik <vojtech@suse.cz>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Dmitry Torokhov <dtor@mail.ru>
References: <20050707193027.GA4162@inferi.kami.home> <20050707200238.52898.qmail@web81308.mail.yahoo.com> <20050707212442.GA4054@inferi.kami.home> <20050707212855.GA2871@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050707212855.GA2871@ucw.cz>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.13-rc2-mm1-2 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2005 at 11:28:55PM +0200, Vojtech Pavlik wrote:
> On Thu, Jul 07, 2005 at 11:24:43PM +0200, Mattia Dongili wrote:
> > On Thu, Jul 07, 2005 at 01:02:38PM -0700, Dmitry Torokhov wrote:
> > > Mattia Dongili <malattia@gmail.com> wrote:
[...]
> > oh, it seems I'm not able to reproduce the error anymore!
> > I need some rest now, I'll try again tomorrow morning (I must be missing
> > something stupid right now) and report to you again.
>  
> Could be the enabled debug is adding extra delay, making the problem
> impossible to reproduce. IIRC, we've seen this with an ALPS pad, too,
> Dmitry, right?

Sorry, it took me a while but I got the error finally (see below for the
debug log). Anyway I suspect it's most likely a bios or hw problem, a
cold boot shows the issue, simply reboot-ing cures it (keeping the
ps2_adjust_timeout in place).
Also, not every cold boot shows the issue, I reproduced it at the 3rd
try today.
So I believe all my previous suspecions are mostly void.

Here's the log:

Linux version 2.6.13-rc2-mm1-2 (mattia@inferi) (gcc version 3.3.5 (Debian 1:3.3.5-13)) #2 Thu Jul 7 23:04:34 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000c0000 - 00000000000d0000 (reserved)
 BIOS-e820: 00000000000d8000 - 00000000000e0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fef0000 (usable)
 BIOS-e820: 000000000fef0000 - 000000000feff000 (ACPI data)
 BIOS-e820: 000000000feff000 - 000000000ff00000 (ACPI NVS)
 BIOS-e820: 000000000ff00000 - 000000000ff80000 (usable)
 BIOS-e820: 000000000ff80000 - 0000000010000000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65408
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61312 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f6cd0
ACPI: RSDT (v001 SONY   C0       0x20010809 PTL  0x00000000) @ 0x0fefa88f
ACPI: FADT (v001   SONY       C0 0x20010809 PTL  0x01000000) @ 0x0fefef64
ACPI: BOOT (v001   SONY       C0 0x20010809 PTL  0x00000001) @ 0x0fefefd8
ACPI: DSDT (v001   SONY       C0 0x20010809 PTL  0x0100000d) @ 0x00000000
Allocating PCI resources starting at 10000000 (gap: 10000000:ef800000)
Built 1 zonelists
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01200000)
Initializing CPU#0
Kernel command line: BOOT_IMAGE=2613rc2mm1-2 ro root=302
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 994.522 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x50
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 255436k/261632k available (1880k kernel code, 5560k reserved, 804k data, 144k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1990.20 BogoMIPS (lpj=995101)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383f9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383f9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After all inits, caps: 0383f9ff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
CPU: Intel(R) Pentium(R) III Mobile CPU      1000MHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
 tbxface-0120 [02] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:...............................................................................................................................................................................................
Table [DSDT](id F004) - 555 Objects with 54 Devices 191 Methods 21 Regions
ACPI Namespace successfully loaded at root c03f3520
evxfevnt-0096 [03] acpi_enable           : Transition to ACPI mode successful
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd9aa, last bus=2
PCI: Using configuration type 1
ACPI: Subsystem revision 20050408
evgpeblk-1016 [06] ev_create_gpe_block   : GPE 00 to 0F [_GPE] 2 regs on int 0x9
evgpeblk-1024 [06] ev_create_gpe_block   : Found 6 Wake, Enabled 0 Runtime GPEs in this block
evgpeblk-1016 [06] ev_create_gpe_block   : GPE 10 to 1F [_GPE] 2 regs on int 0x9
evgpeblk-1024 [06] ev_create_gpe_block   : Found 1 Wake, Enabled 0 Runtime GPEs in this block
Completing Region/Field/Buffer/Package initialization:..............................................................
Initialized 20/21 Regions 0/0 Fields 25/25 Buffers 17/27 Packages (564 nodes)
Executing all Device _STA and_INI methods:..........................................................
58 Devices found containing: 58 _STA, 3 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB_._PRT]
ACPI: Embedded Controller [EC0] (gpe 28)
ACPI: PCI Interrupt Link [LNKA] (IRQs *9)
ACPI: PCI Interrupt Link [LNKB] (IRQs 9) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 9) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs *9)
ACPI: PCI Interrupt Link [LNKE] (IRQs *9)
ACPI: PCI Interrupt Link [LNKF] (IRQs 9) *0
ACPI: PCI Interrupt Link [LNKG] (IRQs 9) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 9) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Simple Boot Flag at 0x36 set to 0x1
inotify device minor=63
Initializing Cryptographic API
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Battery Slot [BAT2] (battery absent)
ACPI: Lid Switch [LID]
ACPI: Power Button (CM) [PWRB]
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Thermal Zone [ATF0] (41 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
cn_exit is registered
PNP: No PS/2 controller found. Probing ports directly.
i8042.c: Detected active multiplexing controller, rev 5.3.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
 pci_irq-0370 [02] acpi_pci_irq_derive   : Unable to derive IRQ for device 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A]: no GSI
ICH3M: chipset revision 1
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: HITACHI_DK23CA-30, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
input: AT Translated Set 2 keyboard on isa0060/serio0
input: AT Translated Set 2 keyboard on isa0060/serio0
hda: max request size: 128KiB
hda: 58605120 sectors (30005 MB) w/2048KiB Cache, CHS=58140/16/63, UDMA(100)
hda: cache flushes not supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
perfctr: driver 2.7.17, cpu type Intel P6 at 994522 kHz
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
ACPI wakeup devices: 
PWRB USB1 USB2 USB3 CRD0 CRD1  LAN  EC0 COMA MODE 
ACPI: (supports S0 S3 S4 S5)
ReiserFS: hda2: found reiserfs format "3.6" with standard journal
ReiserFS: hda2: using ordered data mode
ReiserFS: hda2: journal params: device hda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda2: checking transaction log (hda2)
ReiserFS: hda2: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 144k freed
Adding 248996k swap on /dev/hda3.  Priority:-1 extents:1
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
PCI: setting IRQ 9 as level-triggered
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 9 (level, low) -> IRQ 9
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: Intel Corporation 82801CA/CAM USB (Hub #1)
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 9, io base 0x00001800
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: Intel Corporation 82801CA/CAM USB (Hub #2)
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 9, io base 0x00001820
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 9 (level, low) -> IRQ 9
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: Intel Corporation 82801CA/CAM USB (Hub #3)
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 9, io base 0x00001840
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb 2-1: new low speed USB device using uhci_hcd and address 2
input: USB HID v1.10 Mouse [Logitech USB Mouse] on usb-0000:00:1d.1-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
usb 3-1: new full speed USB device using uhci_hcd and address 2
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 830M Chipset.
agpgart: AGP aperture is 256M @ 0xe0000000
input: PC Speaker
Sony Vaio Jogdial input method installed.
Sony Vaio Keys input method installed.
sonypi: Sony Programmable I/O Controller Driverv1.26.
sonypi: detected type2 model, verbose = 0, fnkeyinit = off, camera = off, compat = off, mask = 0xffffffff, useinput = on, acpi = on
sonypi: enabled at irq=11, port1=0x1080, port2=0x1084
sonypi: device allocated minor is 62
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
ACPI Sony Notebook Control Driver v0.2 successfully installed
Real Time Clock Driver v1.12
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
SCSI subsystem initialized
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usb-storage: device found at 2
usb-storage: waiting for device to settle before scanning
ReiserFS: hda6: found reiserfs format "3.6" with standard journal
ReiserFS: hda6: using ordered data mode
ReiserFS: hda6: journal params: device hda6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda6: checking transaction log (hda6)
ReiserFS: hda6: Using r5 hash to sort names
ReiserFS: hda7: found reiserfs format "3.6" with standard journal
ReiserFS: hda7: using ordered data mode
ReiserFS: hda7: journal params: device hda7, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda7: checking transaction log (hda7)
ReiserFS: hda7: Using r5 hash to sort names
  Vendor: Sony      Model: MSC-U02           Rev: 1.00
  Type:   Direct-Access                      ANSI SCSI revision: 00
usb-storage: device scan complete
SCSI device sda: 7904 512-byte hdwr sectors (4 MB)
sda: Write Protect is off
sda: Mode Sense: 00 6a 10 00
sda: assuming drive cache: write through
ioctl_internal_command: <0 0 0 0> return code = 8000002
   : Current: sense key=0x0
    ASC=0x0 ASCQ=0x0
SCSI device sda: 7904 512-byte hdwr sectors (4 MB)
sda: Write Protect is off
sda: Mode Sense: 00 6a 10 00
sda: assuming drive cache: write through
 sda: sda1
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
hw_random hardware driver 1.0.0 loaded
PCI: Enabling device 0000:00:1f.5 (0000 -> 0001)
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 9
ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 9 (level, low) -> IRQ 9
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49456 usecs
intel8x0: clocking to 48000
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 9
ACPI: PCI Interrupt 0000:02:05.0[A] -> Link [LNKF] -> GSI 9 (level, low) -> IRQ 9
Yenta: CardBus bridge found at 0000:02:05.0 [104d:80e7]
Yenta: ISA IRQ mask 0x04b8, PCI irq 9
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x4000 - 0x4fff
cs: IO port probe 0x4000-0x4fff: clean.
pcmcia: parent PCI bridge Memory window: 0xd0200000 - 0xd02fffff
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 9
ACPI: PCI Interrupt 0000:02:05.1[B] -> Link [LNKG] -> GSI 9 (level, low) -> IRQ 9
Yenta: CardBus bridge found at 0000:02:05.1 [104d:80e7]
Yenta: ISA IRQ mask 0x04b8, PCI irq 9
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x4000 - 0x4fff
cs: IO port probe 0x4000-0x4fff: clean.
pcmcia: parent PCI bridge Memory window: 0xd0200000 - 0xd02fffff
e100: Intel(R) PRO/100 Network Driver, 3.4.8-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
acpi_bus-0212 [01] acpi_bus_set_power    : Device is not power manageable
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 9
ACPI: PCI Interrupt 0000:02:08.0[A] -> Link [LNKE] -> GSI 9 (level, low) -> IRQ 9
e100: eth0: e100_probe: addr 0xd0204000, irq 9, MAC addr 08:00:46:26:50:59
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (2044 buckets, 16352 max) - 248 bytes per conntrack
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
drivers/input/serio/i8042.c: 9c <- i8042 (interrupt, KBD, 1) [207616]
drivers/input/serio/i8042.c: 20 <- i8042 (interrupt, KBD, 1) [210003]
drivers/input/serio/i8042.c: 32 <- i8042 (interrupt, KBD, 1) [210136]
drivers/input/serio/i8042.c: a0 <- i8042 (interrupt, KBD, 1) [210141]
drivers/input/serio/i8042.c: 12 <- i8042 (interrupt, KBD, 1) [210259]
drivers/input/serio/i8042.c: b2 <- i8042 (interrupt, KBD, 1) [210284]
drivers/input/serio/i8042.c: 1f <- i8042 (interrupt, KBD, 1) [210402]
drivers/input/serio/i8042.c: 92 <- i8042 (interrupt, KBD, 1) [210443]
drivers/input/serio/i8042.c: 22 <- i8042 (interrupt, KBD, 1) [210494]
drivers/input/serio/i8042.c: 9f <- i8042 (interrupt, KBD, 1) [210571]
drivers/input/serio/i8042.c: 1c <- i8042 (interrupt, KBD, 1) [210617]
drivers/input/serio/i8042.c: a2 <- i8042 (interrupt, KBD, 1) [210653]
drivers/input/serio/i8042.c: 9c <- i8042 (interrupt, KBD, 1) [210781]
drivers/input/serio/i8042.c: 32 <- i8042 (interrupt, KBD, 1) [216992]
drivers/input/serio/i8042.c: 18 <- i8042 (interrupt, KBD, 1) [217095]
drivers/input/serio/i8042.c: b2 <- i8042 (interrupt, KBD, 1) [217177]
drivers/input/serio/i8042.c: 98 <- i8042 (interrupt, KBD, 1) [217238]
drivers/input/serio/i8042.c: 20 <- i8042 (interrupt, KBD, 1) [217300]
drivers/input/serio/i8042.c: 19 <- i8042 (interrupt, KBD, 1) [217412]
drivers/input/serio/i8042.c: a0 <- i8042 (interrupt, KBD, 1) [217443]
drivers/input/serio/i8042.c: 99 <- i8042 (interrupt, KBD, 1) [217540]
drivers/input/serio/i8042.c: 13 <- i8042 (interrupt, KBD, 1) [217592]
drivers/input/serio/i8042.c: 18 <- i8042 (interrupt, KBD, 1) [217714]
drivers/input/serio/i8042.c: 93 <- i8042 (interrupt, KBD, 1) [217735]
drivers/input/serio/i8042.c: 98 <- i8042 (interrupt, KBD, 1) [217837]
drivers/input/serio/i8042.c: 30 <- i8042 (interrupt, KBD, 1) [217991]
drivers/input/serio/i8042.c: 12 <- i8042 (interrupt, KBD, 1) [218098]
drivers/input/serio/i8042.c: b0 <- i8042 (interrupt, KBD, 1) [218186]
drivers/input/serio/i8042.c: 39 <- i8042 (interrupt, KBD, 1) [218247]
drivers/input/serio/i8042.c: 92 <- i8042 (interrupt, KBD, 1) [218267]
drivers/input/serio/i8042.c: b9 <- i8042 (interrupt, KBD, 1) [218370]
drivers/input/serio/i8042.c: 19 <- i8042 (interrupt, KBD, 1) [219112]
drivers/input/serio/i8042.c: 99 <- i8042 (interrupt, KBD, 1) [219251]
drivers/input/serio/i8042.c: 1f <- i8042 (interrupt, KBD, 1) [219333]
drivers/input/serio/i8042.c: 32 <- i8042 (interrupt, KBD, 1) [219471]
drivers/input/serio/i8042.c: 9f <- i8042 (interrupt, KBD, 1) [219476]
drivers/input/serio/i8042.c: 18 <- i8042 (interrupt, KBD, 1) [219558]
drivers/input/serio/i8042.c: b2 <- i8042 (interrupt, KBD, 1) [219624]
drivers/input/serio/i8042.c: 16 <- i8042 (interrupt, KBD, 1) [219732]
drivers/input/serio/i8042.c: 98 <- i8042 (interrupt, KBD, 1) [219742]
drivers/input/serio/i8042.c: 1f <- i8042 (interrupt, KBD, 1) [219855]
drivers/input/serio/i8042.c: 96 <- i8042 (interrupt, KBD, 1) [219896]
drivers/input/serio/i8042.c: 12 <- i8042 (interrupt, KBD, 1) [219957]
drivers/input/serio/i8042.c: 9f <- i8042 (interrupt, KBD, 1) [220065]
drivers/input/serio/i8042.c: 92 <- i8042 (interrupt, KBD, 1) [220136]
drivers/input/serio/i8042.c: 1c <- i8042 (interrupt, KBD, 1) [220592]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [220602]
drivers/input/serio/i8042.c: 47 -> i8042 (parameter) [220602]
drivers/input/serio/i8042.c: 90 -> i8042 (command) [220603]
drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [220603]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, KBD, 1) [220605]
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
drivers/input/serio/i8042.c: ab <- i8042 (interrupt, KBD, 1) [220608]
drivers/input/serio/i8042.c: 41 <- i8042 (interrupt, KBD, 1) [220613]
drivers/input/serio/i8042.c: 9c <- i8042 (interrupt, KBD, 1) [220700]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [220803]
drivers/input/serio/i8042.c: 45 -> i8042 (parameter) [220803]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [220803]
drivers/input/serio/i8042.c: 47 -> i8042 (parameter) [220803]
drivers/input/serio/i8042.c: 91 -> i8042 (command) [220803]
drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [220803]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, KBD, 1) [220806]
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
drivers/input/serio/i8042.c: ab <- i8042 (interrupt, KBD, 1) [220807]
drivers/input/serio/i8042.c: 41 <- i8042 (interrupt, KBD, 1) [220812]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [221003]
drivers/input/serio/i8042.c: 45 -> i8042 (parameter) [221003]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [221003]
drivers/input/serio/i8042.c: 47 -> i8042 (parameter) [221003]
drivers/input/serio/i8042.c: 92 -> i8042 (command) [221003]
drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [221003]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, KBD, 1) [221006]
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
drivers/input/serio/i8042.c: ab <- i8042 (interrupt, KBD, 1) [221007]
drivers/input/serio/i8042.c: 41 <- i8042 (interrupt, KBD, 1) [221012]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [221203]
drivers/input/serio/i8042.c: 45 -> i8042 (parameter) [221203]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [221203]
drivers/input/serio/i8042.c: 47 -> i8042 (parameter) [221203]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [221203]
drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [221203]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, KBD, 1) [221206]
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
drivers/input/serio/i8042.c: ab <- i8042 (interrupt, KBD, 1) [221207]
drivers/input/serio/i8042.c: 41 <- i8042 (interrupt, KBD, 1) [221212]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [221403]
drivers/input/serio/i8042.c: 45 -> i8042 (parameter) [221403]
drivers/input/serio/i8042.c: 20 <- i8042 (interrupt, KBD, 1) [225001]
drivers/input/serio/i8042.c: 32 <- i8042 (interrupt, KBD, 1) [225155]
drivers/input/serio/i8042.c: 12 <- i8042 (interrupt, KBD, 1) [225227]
drivers/input/serio/i8042.c: a0 <- i8042 (interrupt, KBD, 1) [225242]
drivers/input/serio/i8042.c: b2 <- i8042 (interrupt, KBD, 1) [225273]
drivers/input/serio/i8042.c: 1f <- i8042 (interrupt, KBD, 1) [225391]
drivers/input/serio/i8042.c: 92 <- i8042 (interrupt, KBD, 1) [225426]
drivers/input/serio/i8042.c: 22 <- i8042 (interrupt, KBD, 1) [225559]
drivers/input/serio/i8042.c: 9f <- i8042 (interrupt, KBD, 1) [225667]
drivers/input/serio/i8042.c: a2 <- i8042 (interrupt, KBD, 1) [225734]
drivers/input/serio/i8042.c: 1c <- i8042 (interrupt, KBD, 1) [226614]
drivers/input/serio/i8042.c: 9c <- i8042 (interrupt, KBD, 1) [226819]
drivers/input/serio/i8042.c: 20 <- i8042 (interrupt, KBD, 1) [227802]
drivers/input/serio/i8042.c: 32 <- i8042 (interrupt, KBD, 1) [227956]
drivers/input/serio/i8042.c: a0 <- i8042 (interrupt, KBD, 1) [227982]
drivers/input/serio/i8042.c: 12 <- i8042 (interrupt, KBD, 1) [228017]
drivers/input/serio/i8042.c: b2 <- i8042 (interrupt, KBD, 1) [228079]
drivers/input/serio/i8042.c: 1f <- i8042 (interrupt, KBD, 1) [228156]
drivers/input/serio/i8042.c: 92 <- i8042 (interrupt, KBD, 1) [228222]
drivers/input/serio/i8042.c: 22 <- i8042 (interrupt, KBD, 1) [228309]
drivers/input/serio/i8042.c: 9f <- i8042 (interrupt, KBD, 1) [228381]
drivers/input/serio/i8042.c: 1c <- i8042 (interrupt, KBD, 1) [228448]
drivers/input/serio/i8042.c: a2 <- i8042 (interrupt, KBD, 1) [228478]
drivers/input/serio/i8042.c: 9c <- i8042 (interrupt, KBD, 1) [228576]
...

-- 
mattia
:wq!
