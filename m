Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbVKLNjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbVKLNjv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 08:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbVKLNjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 08:39:51 -0500
Received: from main.gmane.org ([80.91.229.2]:52142 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932340AbVKLNju (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 08:39:50 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?Q?Bj=F8rn_Mork?= <bmork@dod.no>
Subject: Resume from swsusp stopped working with 2.6.14 and 2.6.15-rc1
Date: Sat, 12 Nov 2005 14:39:10 +0100
Organization: Department overbearing Doncaster
Message-ID: <87zmoa0yv5.fsf@obelix.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: obelix.mork.no
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:GL/D7kvhdSxBbHRutryfEgYteRU=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have had swsusp working for ages on a IBM Thinkpad T42, but since
2.6.14 it hasn't been willing to resume anymore.  Both suspending to
disk and ACPI S3 still works. 

Output of dmesg below (running 2.6.15-rc1). Notice the line:

  Restarting tasks...<6> Strange, kseriod not stopped

I guess that's the explanation.  Could it be the new TrackPoint
driver, maybe?  (This PC has both a TrackPoint and a Touchpad).



BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ff50000 (usable)
 BIOS-e820: 000000003ff50000 - 000000003ff67000 (ACPI data)
 BIOS-e820: 000000003ff67000 - 000000003ff79000 (ACPI NVS)
 BIOS-e820: 000000003ff80000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 261968
  DMA zone: 4096 pages, LIFO batch:2
  Normal zone: 225280 pages, LIFO batch:64
  HighMem zone: 32592 pages, LIFO batch:16
DMI present.
ACPI: RSDP (v002 IBM                                   ) @ 0x000f6df0
ACPI: XSDT (v001 IBM    TP-1R    0x00003130  LTP 0x00000000) @ 0x3ff5a6cd
ACPI: FADT (v003 IBM    TP-1R    0x00003130 IBM  0x00000001) @ 0x3ff5a800
ACPI: SSDT (v001 IBM    TP-1R    0x00003130 MSFT 0x0100000e) @ 0x3ff5a9b4
ACPI: ECDT (v001 IBM    TP-1R    0x00003130 IBM  0x00000001) @ 0x3ff66ebc
ACPI: TCPA (v001 IBM    TP-1R    0x00003130 PTL  0x00000001) @ 0x3ff66f0e
ACPI: BOOT (v001 IBM    TP-1R    0x00003130  LTP 0x00000001) @ 0x3ff66fd8
ACPI: DSDT (v001 IBM    TP-1R    0x00003130 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
Allocating PCI resources starting at 50000000 (gap: 40000000:bf800000)
Built 1 zonelists
Kernel command line: BOOT_IMAGE=Linux ro root=305 resume=/dev/hda7 acpi_sleep=s3_bios
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 1694.662 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1034704k/1047872k available (2219k kernel code, 12368k reserved, 677k data, 168k init, 130368k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3392.13 BogoMIPS (lpj=6784275)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: afe9f9bf 00000000 00000000 00000000 00000180 00000000 00000000
CPU: After vendor identify, caps: afe9f9bf 00000000 00000000 00000000 00000180 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: After all inits, caps: afe9f9bf 00000000 00000000 00000040 00000180 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
CPU: Intel(R) Pentium(R) M processor 1.70GHz stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0800)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd8d6, last bus=8
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Found ECDT
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC] (gpe 28)
ACPI: Power Resource [PUBS] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
PCI: Bridge: 0000:00:01.0
  IO window: 3000-3fff
  MEM window: c0100000-c01fffff
  PREFETCH window: e0000000-e7ffffff
PCI: Bus 3, cardbus bridge: 0000:02:00.0
  IO window: 00004000-000040ff
  IO window: 00004400-000044ff
  PREFETCH window: e8000000-e9ffffff
  MEM window: c2000000-c3ffffff
PCI: Bus 7, cardbus bridge: 0000:02:00.1
  IO window: 00004800-000048ff
  IO window: 00004c00-00004cff
  PREFETCH window: ea000000-ebffffff
  MEM window: c4000000-c5ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 4000-8fff
  MEM window: c0200000-cfffffff
  PREFETCH window: e8000000-efffffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI Interrupt 0000:02:00.1[B] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
Simple Boot Flag at 0x35 set to 0x1
Machine check exception polling timer started.
highmem bounce pool size: 64 pages
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=6) Memory=320.00 Mhz, System=210.00 MHz
radeonfb: PLL min 20000 max 35000
Non-DDC laptop panel detected
radeonfb: Monitor 1 type LCD found
radeonfb: Monitor 2 type no found
radeonfb: panel ID string: Samsung LTN150P1-L02    
radeonfb: detected LVDS panel size from BIOS: 1400x1050
radeondb: BIOS provided dividers will be used
radeonfb: Dynamic Clock Power Management enabled
Console: switching to colour frame buffer device 175x65
radeonfb (0000:01:00.0): ATI Radeon NP 
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU] (supports 8 throttling states)
ACPI: Thermal Zone [THM0] (48 C)
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 855PM Chipset.
agpgart: AGP aperture is 256M @ 0xd0000000
PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Intel(R) PRO/1000 Network Driver - version 6.1.16-k2-NAPI
Copyright (c) 1999-2005 Intel Corporation.
ACPI: PCI Interrupt 0000:02:01.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: HTS548040M9AT00, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: HL-DT-STDVD-ROM GDR8083N, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB) w/7877KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 < hda5 hda6 hda7 >
mice: PS/2 mouse device common for all mice
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard as /class/input/input0
IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
TCP established hash table entries: 262144 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
Using IPI Shortcut mode
Stopping tasks: ===<6>Synaptics Touchpad, model: 1, fw: 5.9, id: 0x2c6ab1, caps: 0x884793/0x0
serio: Synaptics pass-through port at isa0060/serio1/input0
input: SynPS/2 Synaptics TouchPad as /class/input/input1

 stopping tasks failed (1 tasks remaining)
Restarting tasks...<6> Strange, kseriod not stopped
 done
ACPI wakeup devices: 
 LID SLPB PCI0 UART PCI1 USB0 USB1 AC9M 
ACPI: (supports S0 S3 S4 S5)
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
IBM TrackPoint firmware: 0x0e, buttons: 3/3
input: TPPS/2 IBM TrackPoint as /class/input/input2
kjournald starting.  Commit interval 5 seconds
EXT3-fs: hda5: orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 928530
ext3_orphan_cleanup: deleting unreferenced inode 928508
EXT3-fs: hda5: 2 orphan inodes deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 168k freed
Adding 2097136k swap on /dev/hda7.  Priority:-1 extents:1 across:2097136k
EXT3 FS on hda5, internal journal
hdc: ATAPI 24X DVD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
Non-volatile memory driver v1.2
ibm_acpi: IBM ThinkPad ACPI Extras v0.12a
ibm_acpi: http://ibm-acpi.sf.net/
ibm_acpi: dock device not present
[drm] Initialized drm 1.0.0 20040925
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
[drm] Initialized radeon 1.19.0 20050911 on minor 0: 
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ath_hal: module license 'Proprietary' taints kernel.
ath_hal: 0.9.15.1 (AR5210, AR5211, AR5212, RF5111, RF5112, RF2413, RF5413)
wlan: 0.8.4.2 (Atheros/multi-bss)
ath_rate_sample: 1.2
ath_pci: 0.9.4.5 (Atheros/multi-bss)
ACPI: PCI Interrupt 0000:02:02.0[A] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
wifi%d: HAL ABI mismatch; driver expects 0x5091300, HAL reports 0x5071100
ACPI: PCI interrupt for device 0000:02:02.0 disabled
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 11, io base 0x00001800
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 11, io base 0x00001820
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 11, io base 0x00001840
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [LNKH] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 4
ehci_hcd 0000:00:1d.7: irq 11, io mem 0xc0000000
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
hw_random hardware driver 1.0.0 loaded
ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 55484 usecs
intel8x0: clocking to 48000
ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1f.6 to 64
MC'97 1 converters and GPIO not ready (0xff00)
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
Yenta: CardBus bridge found at 0000:02:00.0 [1014:0552]
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:00.0, mfunc 0x01d21b22, devctl 0x64
Yenta: ISA IRQ mask 0x04f8, PCI irq 11
Socket status: 30000086
pcmcia: parent PCI bridge I/O window: 0x4000 - 0x8fff
cs: IO port probe 0x4000-0x8fff: clean.
pcmcia: parent PCI bridge Memory window: 0xc0200000 - 0xcfffffff
pcmcia: parent PCI bridge Memory window: 0xe8000000 - 0xefffffff
ACPI: PCI Interrupt 0000:02:00.1[B] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
Yenta: CardBus bridge found at 0000:02:00.1 [1014:0552]
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:00.1, mfunc 0x01d21b22, devctl 0x64
Yenta: ISA IRQ mask 0x04f8, PCI irq 11
Socket status: 30000086
pcmcia: parent PCI bridge I/O window: 0x4000 - 0x8fff
cs: IO port probe 0x4000-0x8fff: clean.
pcmcia: parent PCI bridge Memory window: 0xc0200000 - 0xcfffffff
pcmcia: parent PCI bridge Memory window: 0xe8000000 - 0xefffffff
Real Time Clock Driver v1.12
irda_init()
NET: Registered protocol family 23
pcmcia: Detected deprecated PCMCIA ioctl usage.
pcmcia: This interface will soon be removed from the kernel; please expect breakage unless you upgrade to new tools.
pcmcia: see http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html for details.
cs: IO port probe 0x100-0x4ff: excluding 0x2f8-0x2ff 0x3b8-0x3df 0x4d0-0x4d7
cs: IO port probe 0x100-0x4ff: excluding 0x2f8-0x2ff 0x3b8-0x3df 0x4d0-0x4d7
cs: IO port probe 0x800-0x8ff: clean.
cs: IO port probe 0x800-0x8ff: clean.
cs: IO port probe 0xc00-0xcff: clean.
cs: IO port probe 0xc00-0xcff: clean.
cs: IO port probe 0xa00-0xaff: clean.
cs: IO port probe 0xa00-0xaff: clean.
Bluetooth: Core ver 2.8
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
eth0: no IPv6 routers present
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.6






Bjørn
-- 
You're probably homosexual yourself.

