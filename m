Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbWGWVV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbWGWVV5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 17:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWGWVV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 17:21:57 -0400
Received: from math.ut.ee ([193.40.36.2]:20721 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S1751304AbWGWVV4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 17:21:56 -0400
Date: Mon, 24 Jul 2006 00:21:53 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: yenta irq disabled on IBM X20 with dock
Message-ID: <Pine.SOC.4.61.0607240016590.26491@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a IBM X20 laptop. Works fine without the dock (2 yenta ports with 
Ricoh chips). However, when I power it up in the dock (Type 2631), there 
is a problem with additional yenta ports in the dock (TI ones). The 
disable the IRQ and also kill a USB port (the probable reason behind the 
USB messages, but maybe it's unrelated since the USB messages start 
before the IRQ message). Other than that it works fine in the dock.

Tested with 2.6.17 and 2.6.18-rc2.

lspci and dmesg are below:

00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03)
00:04.0 PCI bridge: Texas Instruments PCI2032 PCI Docking Bridge
00:07.0 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 03)
00:08.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
00:08.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
00:0a.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100] (rev 09)
00:0a.1 Serial controller: Xircom Mini-PCI V.90 56k Modem
00:0b.0 Multimedia audio controller: Cirrus Logic Crystal CS4281 PCI Audio (rev 01)
01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility P/M AGP 2x (rev 64)
02:01.0 IDE interface: Silicon Image, Inc. PCI0648 (rev 01)
02:02.0 CardBus bridge: Texas Instruments PCI1420
02:02.1 CardBus bridge: Texas Instruments PCI1420


0000 00000000 00000000
CPU: After vendor identify, caps: 0383f9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps: 0383f9ff 00000000 00000000 00000040 00000000 00000000 00000000
Compat vDSO mapped to ffffe000.
CPU: Intel Pentium III (Coppermine) stepping 03
Checking 'hlt' instruction... OK.
ACPI: Core revision 20060707
ACPI: setting ELCR to 0200 (from 0e20)
checking if image is initramfs... it is
Freeing initrd memory: 4492k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd94f, last bus=14
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 9 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 9 11) *10
ACPI: PCI Interrupt Link [LNKC] (IRQs *9 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 9 11) *5
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI quirk: region 1000-103f claimed by PIIX4 ACPI
PCI quirk: region 1040-104f claimed by PIIX4 SMB
PIIX4 devres I PIO at 03f0-03f7
PIIX4 devres J PIO at 002e-002f
Boot video device is 0000:01:00.0
PCI: Found IBM Dock II Cardbus Bridge applying quirk
PCI: Found IBM Dock II Cardbus Bridge applying quirk
PCI: Transparent bridge - 0000:00:04.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: Power Resource [PSIO] (on)
ACPI: Power Resource [PSER] (off)
ACPI: Embedded Controller [EC] (gpe 9) interrupt mode.
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.DOCK._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
PnPBIOS: Disabled by ACPI PNP
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Cannot allocate resource region 7 of bridge 0000:00:04.0
PCI: Cannot allocate resource region 8 of bridge 0000:00:04.0
PCI: Cannot allocate resource region 9 of bridge 0000:00:04.0
pnp: 00:02: ioport range 0x1000-0x103f could not be reserved
pnp: 00:02: ioport range 0x1040-0x104f has been reserved
pnp: 00:02: ioport range 0xfe00-0xfe0f has been reserved
PCI: Bridge: 0000:00:01.0
   IO window: 2000-2fff
   MEM window: f4100000-f5ffffff
   PREFETCH window: 20000000-200fffff
PCI: Bus 3, cardbus bridge: 0000:02:02.0
   IO window: 00004000-000040ff
   IO window: 00004400-000044ff
   PREFETCH window: 14000000-15ffffff
   MEM window: 10000000-11ffffff
PCI: Bus 7, cardbus bridge: 0000:02:02.1
   IO window: 00004800-000048ff
   IO window: 00004c00-00004cff
   PREFETCH window: 16000000-17ffffff
   MEM window: 12000000-13ffffff
PCI: Bridge: 0000:00:04.0
   IO window: 4000-4fff
   MEM window: 10000000-13ffffff
   PREFETCH window: 14000000-17ffffff
PCI: Bus 9, cardbus bridge: 0000:00:08.0
   IO window: 00001400-000014ff
   IO window: 00001c00-00001cff
   PREFETCH window: 18000000-19ffffff
   MEM window: 1a000000-1bffffff
PCI: Bus 13, cardbus bridge: 0000:00:08.1
   IO window: 00003400-000034ff
   IO window: 00003800-000038ff
   PREFETCH window: 1c000000-1dffffff
   MEM window: 1e000000-1fffffff
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
PCI: setting IRQ 9 as level-triggered
ACPI: PCI Interrupt 0000:02:02.0[A] -> Link [LNKC] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI Interrupt 0000:02:02.1[A] -> Link [LNKC] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:08.1[B] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 4096 bind 2048)
TCP reno registered
Simple Boot Flag at 0x35 set to 0x1
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
pnp: Unable to assign resources to device 00:0b.
serial: probe of 00:0b failed with error -16
ACPI: PCI Interrupt 0000:00:0a.1[A] -> Link [LNKC] -> GSI 9 (level, low) -> IRQ 9
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
ACPI: (supports S0 S1 S3 S4 S5)
Freeing unused kernel memory: 172k freed
Write protecting the kernel read-only data: 256k
Time: tsc clocksource has been installed.
input: AT Translated Set 2 keyboard as /class/input/input0
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU] (supports 8 throttling states)
ACPI: Thermal Zone [THM0] (56 C)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
CMD648: IDE controller at PCI slot 0000:02:01.0
ACPI: PCI Interrupt 0000:02:01.0[A] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
CMD648: chipset revision 1
CMD648: 100% native mode on irq 11
     ide0: BM-DMA at 0x3000-0x3007, BIOS settings: hda:pio, hdb:pio
     ide1: BM-DMA at 0x3008-0x300f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v3.0
Time: acpi_pm clocksource has been installed.
Probing IDE interface ide1...
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKC] -> GSI 9 (level, low) -> IRQ 9
e100: eth0: e100_probe: addr 0xf4010000, irq 9, MAC addr 00:90:27:96:B1:D0
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
     ide2: BM-DMA at 0x1800-0x1807, BIOS settings: hde:DMA, hdf:pio
     ide3: BM-DMA at 0x1808-0x180f, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
hde: IBM-DJSA-220, ATA DISK drive
ide2 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide3...
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:07.2[D] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:07.2: irq 11, io base 0x00001820
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
hde: max request size: 128KiB
hde: 39070080 sectors (20003 MB) w/1874KiB Cache, CHS=41344/15/63, UDMA(33)
hde: cache flushes not supported
  hde: hde1 hde2 < hde5 >
usb 1-1: new full speed USB device using uhci_hcd and address 2
usb 1-1: configuration #1 chosen from 1 choice
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 2 ports detected
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
hub 1-1:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 1-1:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 1-1:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 1-1:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 1-1:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
input: PC Speaker as /class/input/input1
IBM TrackPoint firmware: 0x0e, buttons: 3/3
input: TPPS/2 IBM TrackPoint as /class/input/input2
Yenta: CardBus bridge found at 0000:00:08.0 [1014:0185]
Linux agpgart interface v0.101 (c) Dave Jones
Yenta: ISA IRQ mask 0x04b8, PCI irq 11
Socket status: 30000006
Yenta: CardBus bridge found at 0000:00:08.1 [1014:0185]
hub 1-1:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
Yenta: ISA IRQ mask 0x04b8, PCI irq 11
Socket status: 30000006
Yenta: CardBus bridge found at 0000:02:02.0 [1014:0148]
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:02.0, mfunc 0x00001002, devctl 0x66
irq 11: nobody cared (try booting with the "irqpoll" option)
  [<c0103ee0>] show_trace_log_lvl+0x130/0x150
  [<c0104572>] show_trace+0x12/0x20
  [<c0104649>] dump_stack+0x19/0x20
  [<c0137977>] __report_bad_irq+0x27/0x90
  [<c0137bd3>] note_interrupt+0x1f3/0x230
  [<c01371e1>] __do_IRQ+0xb1/0xd0
  [<c0105639>] do_IRQ+0xa9/0xf0
  [<c0103846>] common_interrupt+0x1a/0x20
  [<c01370d9>] handle_IRQ_event+0x19/0x70
  [<c013719c>] __do_IRQ+0x6c/0xd0
  [<c0105639>] do_IRQ+0xa9/0xf0
  [<c0103846>] common_interrupt+0x1a/0x20
  [<c88fdc53>] yenta_probe_cb_irq+0x83/0xf0 [yenta_socket]
  [<c88fe06e>] ti12xx_override+0x12e/0x5e0 [yenta_socket]
  [<c88fefc1>] yenta_probe+0x5b1/0x650 [yenta_socket]
  [<c01bde5e>] pci_device_probe+0x5e/0x80
  [<c02168b4>] driver_probe_device+0x44/0xc0
  [<c02169fe>] __driver_attach+0x5e/0x60
  [<c0216263>] bus_for_each_dev+0x43/0x70
  [<c02167f9>] driver_attach+0x19/0x20
  [<c0215eae>] bus_add_driver+0x6e/0x130
  [<c0216c0a>] driver_register+0x5a/0x90
  [<c01bdfd7>] __pci_register_driver+0x37/0x60
  [<c8823012>] yenta_socket_init+0x12/0x14 [yenta_socket]
  [<c0130973>] sys_init_module+0x123/0x1620
  [<c0102ebf>] syscall_call+0x7/0xb
  [<b7f584be>] 0xb7f584be
handlers:
[<c8894730>] (usb_hcd_irq+0x0/0x60 [usbcore])
[<c88fe930>] (yenta_interrupt+0x0/0xe0 [yenta_socket])
[<c88fe930>] (yenta_interrupt+0x0/0xe0 [yenta_socket])
Disabling IRQ #11
agpgart: Detected an Intel 440BX Chipset.
agpgart: AGP aperture is 64M @ 0xf8000000
Yenta: ISA IRQ mask 0x04f8, PCI irq 9
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x4000 - 0x4fff
cs: IO port probe 0x4000-0x4fff: clean.
pcmcia: parent PCI bridge Memory window: 0x10000000 - 0x13ffffff
pcmcia: parent PCI bridge Memory window: 0x14000000 - 0x17ffffff
Yenta: CardBus bridge found at 0000:02:02.1 [1014:0148]
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:02.1, mfunc 0x00001002, devctl 0x66
Floppy drive(s): fd0 is 1.44M
Yenta: ISA IRQ mask 0x04b8, PCI irq 9
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x4000 - 0x4fff
cs: IO port probe 0x4000-0x4fff: clean.
pcmcia: parent PCI bridge Memory window: 0x10000000 - 0x13ffffff
pcmcia: parent PCI bridge Memory window: 0x14000000 - 0x17ffffff
piix4_smbus 0000:00:07.3: Found 0000:00:07.3 device
piix4_smbus 0000:00:07.3: IBM system detected; this module may corrupt your serial eeprom! Refusing to load module!
piix4_smbus: probe of 0000:00:07.3 failed with error -1
pnp: Unable to assign resources to device 00:0c.
parport_pc: probe of 00:0c failed with error -16
ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
hub 1-1:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
gameport: CS4281 Gameport is pci0000:00:0b.0/gameport0, speed 2209kHz
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
ts: Compaq touchscreen protocol output
floppy0: no floppy controllers found
cs: IO port probe 0x100-0x3af: excluding 0x170-0x177 0x370-0x377
cs: IO port probe 0x3e0-0x4ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
cs: IO port probe 0x100-0x3af: excluding 0x170-0x177 0x370-0x377
cs: IO port probe 0x3e0-0x4ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
cs: IO port probe 0x100-0x3af: excluding 0x170-0x177 0x370-0x377
cs: IO port probe 0x3e0-0x4ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
cs: IO port probe 0x100-0x3af: excluding 0x170-0x177 0x370-0x377
cs: IO port probe 0x3e0-0x4ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
hub 1-1:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
EXT3 FS on hde1, internal journal
Probing IDE interface ide0...
Probing IDE interface ide1...
hub 1-1:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
Probing IDE interface ide3...
device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised: dm-devel@redhat.com
hub 1-1:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
pcmcia: Detected deprecated PCMCIA ioctl usage from process: discover.
pcmcia: This interface will soon be removed from the kernel; please expect breakage unless you upgrade to new tools.
pcmcia: see http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html for details.
hub 1-1:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 1-1:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 1-1:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 1-1:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 1-1:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 1-1:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
hub 1-1:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
ACPI: Battery Slot [BAT0] (battery absent)
ACPI: AC Adapter [AC] (on-line)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
IBM machine detected. Enabling interrupts during APM calls.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
hub 1-1:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 1-1:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
Non-volatile memory driver v1.2
input: /usr/sbin/thinkpad-keys as /class/input/input3
hub 1-1:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
hub 1-1:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 1-1:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 1-1:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 1-1:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
eth0: no IPv6 routers present
hub 1-1:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 1-1:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 1-1:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 1-1:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 1-1:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 1-1:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 1-1:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 1-1:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 1-1:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 1-1:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 1-1:1.0: Cannot enable port 1.  Maybe the USB cable is bad?

-- 
Meelis Roos (mroos@linux.ee)
