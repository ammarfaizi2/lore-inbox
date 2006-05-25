Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030498AbWEYWiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030498AbWEYWiM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 18:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030499AbWEYWiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 18:38:12 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30160 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030494AbWEYWiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 18:38:09 -0400
Date: Fri, 26 May 2006 00:12:22 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, Andreas Saur <saur@acmelabs.de>,
       linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc4-mm3 - kernel panic
Message-ID: <20060525221222.GA1608@elf.ucw.cz>
References: <CFF307C98FEABE47A452B27C06B85BB68AD7E1@hdsmsx411.amr.corp.intel.com> <1148583675.3070.41.camel@whizzy>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <1148583675.3070.41.camel@whizzy>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > Does the panic go away with CONFIG_ACPI_DOCK=n?

> Can either Pavel or Andreas please try this little debugging patch and
> send me the dmesg output?  Please enable the CONFIG_DEBUG_KERNEL option
> in your .config as well so that I can get additional info.

Yep, you were right... this debugging patch helps.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=delme

Linux version 2.6.17-rc4-mm3 (pavel@amd) (gcc version 4.0.3 20051201 (prerelease) (Debian 4.0.2-5)) #3 SMP PREEMPT Fri May 26 00:04:47 CEST 2006
BIOS-provided physical RAM map:
sanitize start
sanitize end
copy_e820_map() start: 0000000000000000 size: 000000000009f000 end: 000000000009f000 type: 1
copy_e820_map() type is E820_RAM
add_memory_region(0000000000000000, 000000000009f000, 1)
copy_e820_map() start: 000000000009f000 size: 0000000000001000 end: 00000000000a0000 type: 2
add_memory_region(000000000009f000, 0000000000001000, 2)
copy_e820_map() start: 00000000000dc000 size: 0000000000024000 end: 0000000000100000 type: 2
add_memory_region(00000000000dc000, 0000000000024000, 2)
copy_e820_map() start: 0000000000100000 size: 000000005fe60000 end: 000000005ff60000 type: 1
copy_e820_map() type is E820_RAM
add_memory_region(0000000000100000, 000000005fe60000, 1)
copy_e820_map() start: 000000005ff60000 size: 0000000000017000 end: 000000005ff77000 type: 3
add_memory_region(000000005ff60000, 0000000000017000, 3)
copy_e820_map() start: 000000005ff77000 size: 0000000000002000 end: 000000005ff79000 type: 4
add_memory_region(000000005ff77000, 0000000000002000, 4)
copy_e820_map() start: 000000005ff80000 size: 0000000000080000 end: 0000000060000000 type: 2
add_memory_region(000000005ff80000, 0000000000080000, 2)
copy_e820_map() start: 00000000ff800000 size: 0000000000800000 end: 0000000100000000 type: 2
add_memory_region(00000000ff800000, 0000000000800000, 2)
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000005ff60000 (usable)
 BIOS-e820: 000000005ff60000 - 000000005ff77000 (ACPI data)
 BIOS-e820: 000000005ff77000 - 000000005ff79000 (ACPI NVS)
 BIOS-e820: 000000005ff80000 - 0000000060000000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
639MB HIGHMEM available.
895MB LOWMEM available.
On node 0 totalpages: 393056
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 225279 pages, LIFO batch:31
node 0 zone HighMem misaligned start pfn, enable UNALIGNED_ZONE_BOUNDARIES
  HighMem zone: 163681 pages, LIFO batch:31
DMI present.
ACPI: RSDP (v002 IBM                                   ) @ 0x000f6df0
ACPI: XSDT (v001 IBM    TP-1Q    0x00003004  LTP 0x00000000) @ 0x5ff69e78
ACPI: FADT (v003 IBM    TP-1Q    0x00003004 IBM  0x00000001) @ 0x5ff69f00
ACPI: SSDT (v001 IBM    TP-1Q    0x00003004 MSFT 0x0100000e) @ 0x5ff6a0b4
ACPI: ECDT (v001 IBM    TP-1Q    0x00003004 IBM  0x00000001) @ 0x5ff76e11
ACPI: TCPA (v001 IBM    TP-1Q    0x00003004 PTL  0x00000001) @ 0x5ff76e63
ACPI: BOOT (v001 IBM    TP-1Q    0x00003004  LTP 0x00000001) @ 0x5ff76fd8
ACPI: DSDT (v001 IBM    TP-1Q    0x00003004 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
Allocating PCI resources starting at 70000000 (gap: 60000000:9f800000)
Detected 1798.497 MHz processor.
Built 1 zonelists
Kernel command line: root=/dev/hda4 resume=/dev/hda1 psmouse.psmouse_proto=imps psmouse_proto=imps psmouse.proto=imps vga=1 pci=assign-busses rootfstype=ext2
Unknown boot option `psmouse.psmouse_proto=imps': ignoring
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffe000 (01c17000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour VGA+ 80x50
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1550028k/1572224k available (5054k kernel code, 21060k reserved, 1851k data, 316k init, 654724k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3599.57 BogoMIPS (lpj=7199141)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: afe9f9bf 00000000 00000000 00000000 00000180 00000000 00000000
CPU: After vendor identify, caps: afe9f9bf 00000000 00000000 00000000 00000180 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: After all inits, caps: afe9f9bf 00000000 00000000 00000040 00000180 00000000 00000000
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 24k freed
 tbxface-0107 [01] load_tables           : ACPI Tables successfully acquired
Parsing all Control Methods:
Table [DSDT](id 0006) - 1407 Objects with 65 Devices 442 Methods 19 Regions
Parsing all Control Methods:
Table [SSDT](id 0004) - 1 Objects with 0 Devices 1 Methods 0 Regions
ACPI Namespace successfully loaded at root c087ccd8
ACPI: setting ELCR to 0200 (from 0800)
evxfevnt-0089 [02] enable                : Transition to ACPI mode successful
CPU0: Intel(R) Pentium(R) M processor 1.80GHz stepping 06
SMP motherboard not detected.
Local APIC not detected. Using dummy APIC emulation.
Brought up 1 CPUs
migration_cost=0
PM: Adding info for No Bus:platform
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd8d6, last bus=8
Setting up standard PCI resources
ACPI: Subsystem revision 20060310
evgpeblk-0951 [04] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int 0x9
evgpeblk-1048 [03] ev_initialize_gpe_bloc: Found 7 Wake, Enabled 0 Runtime GPEs in this block
ACPI: Found ECDT
Completing Region/Field/Buffer/Package initialization:.................................................................................................................................................................................................................................................
Initialized 18/19 Regions 123/123 Fields 58/58 Buffers 42/49 Packages (1417 nodes)
Executing all Device _STA and_INI methods:.....................................................................
69 Devices found - executed 3 _STA, 11 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
PM: Adding info for acpi:acpi
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
PM: Adding info for No Bus:pci0000:00
PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
PM: Adding info for pci:0000:00:00.0
PM: Adding info for pci:0000:00:01.0
PM: Adding info for pci:0000:00:1d.0
PM: Adding info for pci:0000:00:1d.1
PM: Adding info for pci:0000:00:1d.2
PM: Adding info for pci:0000:00:1d.7
PM: Adding info for pci:0000:00:1e.0
PM: Adding info for pci:0000:00:1f.0
PM: Adding info for pci:0000:00:1f.1
PM: Adding info for pci:0000:00:1f.3
PM: Adding info for pci:0000:00:1f.5
PM: Adding info for pci:0000:00:1f.6
PM: Adding info for pci:0000:01:00.0
PM: Adding info for pci:0000:02:00.0
PM: Adding info for pci:0000:02:00.1
PM: Adding info for pci:0000:02:00.2
PM: Adding info for pci:0000:02:01.0
PM: Adding info for pci:0000:02:02.0
ACPI: Embedded Controller [EC] (gpe 28) interrupt mode.
ACPI: Power Resource [PUBS] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
irda_init()
NET: Registered protocol family 23
Bluetooth: Core ver 2.8
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
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
ACPI (acpi_bus-0192): Device `CBS0]is not power manageable [20060310]
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
ACPI (acpi_bus-0192): Device `CBS1]is not power manageable [20060310]
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI Interrupt 0000:02:00.1[B] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
TCP established hash table entries: 131072 (order: 9, 3145728 bytes)
TCP bind hash table entries: 65536 (order: 8, 1572864 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
PM: Adding info for platform:pcspkr
Simple Boot Flag at 0x35 set to 0x80
IBM machine detected. Enabling interrupts during APM calls.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
highmem bounce pool size: 64 pages
Coda Kernel/Venus communications, v6.0.0, coda@cs.cmu.edu
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.27 [Flags: R/O DEBUG].
fuse init (API version 7.6)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ibmphpd: IBM Hot Plug PCI Controller Driver version: 0.6
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
Dock station not done being initialized!!!
Dock station not done being initialized!!!
Dock station not done being initialized!!!
Dock station not done being initialized!!!
Dock station not done being initialized!!!
Dock station not done being initialized!!!
Dock station not done being initialized!!!
Dock station not done being initialized!!!
Dock station not done being initialized!!!
Dock station not done being initialized!!!
Dock station not done being initialized!!!
Dock station not done being initialized!!!
Dock station not done being initialized!!!
acpiphp_ibm: ibm_find_acpi_device:  Failed to get device information<3>acpiphp_ibm: ibm_find_acpi_device:  Failed to get device information<3>acpiphp_ibm: ibm_find_acpi_device:  Failed to get device information<3>acpiphp_ibm: ibm_acpiphp_init: acpi_walk_namespace failed
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
radeonfb: Retrieved PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=60) Memory=144.00 Mhz, System=144.00 MHz
radeonfb: PLL min 12000 max 35000
PM: Adding info for No Bus:i2c-0
PM: Adding info for No Bus:i2c-1
PM: Adding info for No Bus:i2c-2
PM: Adding info for No Bus:i2c-3
Non-DDC laptop panel detected
radeonfb: Monitor 1 type LCD found
radeonfb: Monitor 2 type no found
radeonfb: panel ID string: 1024x768                
radeonfb: detected LVDS panel size from BIOS: 1024x768
radeondb: BIOS provided dividers will be used
radeonfb: Dynamic Clock Power Management enabled
Console: switching to colour frame buffer device 102x42
radeonfb (0000:01:00.0): ATI Radeon LY 
PM: Adding info for platform:vesafb.0
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: ACPI Dock Station Driver 
ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
Using specific hotkey driver
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU] (supports 8 throttling states)
ACPI: Thermal Zone [THM0] (62 C)
ibm_acpi: IBM ThinkPad ACPI Extras v0.12a
ibm_acpi: http://ibm-acpi.sf.net/
ACPI Exception (acpi_bus-0070): AE_NOT_FOUND, No context for object [f7fdb50c] [20060310]
ibm_acpi: bay device not present
lp: driver loaded but no devices found
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.1 20051102
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
[drm] Initialized radeon 1.24.0 20060225 on minor 0
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
PM: Adding info for platform:serial8250
ACPI (acpi_bus-0192): Device `AC9M]is not power manageable [20060310]
ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt for device 0000:00:1f.6 disabled
parport0: PC-style at 0x3bc [PCSPP(,...)]
lp0: using parport0 (polling).
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
PM: Adding info for platform:floppy.0
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 7.0.38-k2
Copyright (c) 1999-2006 Intel Corporation.
ACPI: PCI Interrupt 0000:02:01.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
e1000: 0000:02:01.0: e1000_probe: (PCI:33MHz:32-bit) 00:11:25:b2:13:20
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
pcnet32.c:v1.32 18.Mar.2006 tsbogend@alpha.franken.de
e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256).
CSLIP: code copyright 1989 Regents of the University of California.
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
orinoco 0.15 (David Gibson <hermes@gibson.dropbear.id.au>, Pavel Roskin <proski@gnu.org>, et al)
Linux video capture interface: v1.00
bttv: driver version 0.9.16 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: HTS541040G9AT00, ATA DISK drive
PM: Adding info for No Bus:ide0
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
PM: Adding info for ide:0.0
Probing IDE interface ide1...
Probing IDE interface ide1...
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB) w/7539KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4
libata version 1.30 loaded.
ACPI: PCI Interrupt 0000:02:00.2[C] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
PM: Adding info for ieee1394:fw-host0
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[11]  MMIO=[c0211000-c02117ff]  Max Packet=[2048]  IR/IT contexts=[4/4]
ieee1394: raw1394: /dev/raw1394 device initialized
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
ieee1394: sbp2: Try serialize_io=0 for better performance
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
Yenta: CardBus bridge found at 0000:02:00.0 [1014:0532]
Yenta: ISA IRQ mask 0x04b8, PCI irq 11
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x4000 - 0x8fff
cs: IO port probe 0x4000-0x8fff: clean.
pcmcia: parent PCI bridge Memory window: 0xc0200000 - 0xcfffffff
pcmcia: parent PCI bridge Memory window: 0xe8000000 - 0xefffffff
ACPI: PCI Interrupt 0000:02:00.1[B] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
Yenta: CardBus bridge found at 0000:02:00.1 [1014:0532]
Yenta: ISA IRQ mask 0x04b8, PCI irq 11
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x4000 - 0x8fff
cs: IO port probe 0x4000-0x8fff: clean.
pcmcia: parent PCI bridge Memory window: 0xc0200000 - 0xcfffffff
pcmcia: parent PCI bridge Memory window: 0xe8000000 - 0xefffffff
PM: Adding info for platform:i82365.0
Intel ISA PCIC probe: not found.
PM: Removing info for platform:i82365.0
Databook TCIC-2 PCMCIA probe: not found.
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [LNKH] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 11, io mem 0xc0000000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: new device found, idVendor=0000, idProduct=0000
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.17-rc4-mm3 ehci_hcd
usb usb1: SerialNumber: 0000:00:1d.7
PM: Adding info for usb:usb1
usb usb1: configuration #1 chosen from 1 choice
PM: Adding info for usb:1-0:1.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 11, io base 0x00001800
usb usb2: new device found, idVendor=0000, idProduct=0000
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.17-rc4-mm3 uhci_hcd
usb usb2: SerialNumber: 0000:00:1d.0
PM: Adding info for usb:usb2
usb usb2: configuration #1 chosen from 1 choice
PM: Adding info for usb:2-0:1.0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 11, io base 0x00001820
usb usb3: new device found, idVendor=0000, idProduct=0000
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.17-rc4-mm3 uhci_hcd
usb usb3: SerialNumber: 0000:00:1d.1
PM: Adding info for usb:usb3
usb usb3: configuration #1 chosen from 1 choice
PM: Adding info for usb:3-0:1.0
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
PM: Adding info for ieee1394:00061b032904c34f
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00061b032904c34f]
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 11, io base 0x00001840
usb usb4: new device found, idVendor=0000, idProduct=0000
usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: UHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.17-rc4-mm3 uhci_hcd
usb usb4: SerialNumber: 0000:00:1d.2
PM: Adding info for usb:usb4
usb usb4: configuration #1 chosen from 1 choice
PM: Adding info for usb:4-0:1.0
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 3-1: new full speed USB device using uhci_hcd and address 2
usb 3-1: new device found, idVendor=0a48, idProduct=3260
usb 3-1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 3-1: Product: USB Digital Drive
usb 3-1: Manufacturer: Hewlett-Packard
PM: Adding info for usb:3-1
usb 3-1: configuration #1 chosen from 1 choice
PM: Adding info for usb:3-1:1.0
usbcore: registered new driver cdc_acm
drivers/usb/class/cdc-acm.c: v0.25:USB Abstract Control Model driver for USB modems and ISDN adapters
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
PM: Adding info for No Bus:host0
usb-storage: device found at 2
usb-storage: waiting for device to settle before scanning
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
usbcore: registered new driver catc
drivers/usb/net/catc.c: v2.8 CATC EL1210A NetMate USB Ethernet driver
usbcore: registered new driver asix
usbcore: registered new driver cdc_ether
usbcore: registered new driver net1080
usbcore: registered new driver cdc_subset
usbcore: registered new driver zaurus
usbcore: registered new driver zd1201
PM: Adding info for platform:i8042
serio: i8042 AUX port at 0x60,0x64 irq 12
PM: Adding info for serio:serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
PM: Adding info for serio:serio1
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input0
input: AT Translated Set 2 keyboard as /class/input/input1
PM: Adding info for No Bus:i2c-9191
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
device-mapper: 4.6.0-ioctl (2006-02-17) initialised: dm-devel@redhat.com
Bluetooth: HCI USB driver ver 2.9
usbcore: registered new driver hci_usb
Bluetooth: HCI UART driver ver 2.2
Bluetooth: HCI H4 protocol initialized
Bluetooth: HCI BCSP protocol initialized
EDAC MC: Ver: 2.0.0 May 25 2006
Advanced Linux Sound Architecture Driver Version 1.0.11rc4 (Wed Mar 22 10:27:24 2006 UTC).
ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1f.5 to 64
input: PS/2 Generic Mouse as /class/input/input2
intel8x0_measure_ac97_clock: measured 56004 usecs
intel8x0: clocking to 48000
PM: Adding info for ac97:0-0:AD1981B
usbcore: registered new driver snd-usb-audio
ALSA device list:
  #0: Intel 82801DB-ICH4 with AD1981B at 0xc0000c00, irq 11
oprofile: using timer interrupt.
ip_conntrack version 2.4 (8192 buckets, 65536 max) - 172 bytes per conntrack
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
IrCOMM protocol (Dag Brattli)
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO (Voice Link) ver 0.5
Bluetooth: SCO socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.7
Bluetooth: BNEP (Ethernet Emulation) ver 1.2
Bluetooth: BNEP filters: protocol multicast
Bluetooth: HIDP (Human Interface Emulation) ver 1.1
ieee80211: 802.11 data/management/control stack, git-1.1.13
ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
ieee80211_crypt: registered algorithm 'NULL'
ieee80211_crypt: registered algorithm 'WEP'
acpi_processor-0731 [00] processor_preregister_: Error while parsing _PSD domain information. Assuming no coordination
acpi_processor-0731 [00] processor_preregister_: Error while parsing _PSD domain information. Assuming no coordination
Using IPI No-Shortcut mode
ACPI: (supports S0 S3 S4 S5)
Time: tsc clocksource has been installed.
Freeing unused kernel memory: 316k freed
Time: acpi_pm clocksource has been installed.
Attempting manual resume
swsusp: Resume From Partition 3:1
PM: Checking swsusp image.
PM: Resume from disk failed.
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
EXT2-fs warning (device hda4): ext2_fill_super: mounting ext3 filesystem as ext2
Adding 2136448k swap on /dev/hda1.  Priority:-1 extents:1 across:2136448k
kjournald starting.  Commit interval 6000 seconds
EXT3 FS on hda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
PM: Adding info for No Bus:target0:0:0
  Vendor:  HP       Model: Digital Drive     Rev: 1.00
  Type:   Direct-Access                      ANSI SCSI revision: 00
PM: Adding info for scsi:0:0:0:0
sd 0:0:0:0: Attached scsi removable disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
PM: Adding info for No Bus:target0:0:1
PM: Removing info for No Bus:target0:0:1
PM: Adding info for No Bus:target0:0:2
PM: Removing info for No Bus:target0:0:2
PM: Adding info for No Bus:target0:0:3
PM: Removing info for No Bus:target0:0:3
PM: Adding info for No Bus:target0:0:4
PM: Removing info for No Bus:target0:0:4
PM: Adding info for No Bus:target0:0:5
PM: Removing info for No Bus:target0:0:5
PM: Adding info for No Bus:target0:0:6
PM: Removing info for No Bus:target0:0:6
PM: Adding info for No Bus:target0:0:7
PM: Removing info for No Bus:target0:0:7
usb-storage: device scan complete
pcmcia: Detected deprecated PCMCIA ioctl usage from process: cardmgr.
pcmcia: This interface will soon be removed from the kernel; please expect breakage unless you upgrade to new tools.
pcmcia: see http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html for details.
cs: IO port probe 0x310-0x380: excluding 0x370-0x377
cs: IO port probe 0x310-0x380: excluding 0x370-0x377
cs: IO port probe 0xa00-0xaff: clean.
cs: IO port probe 0xa00-0xaff: clean.
coda_read_super: Bad mount data
coda_read_super: device index: 0
coda_read_super: rootfid is (01234567.ffffffff.080519c0.00000000)
coda_upcall: Venus dead on (op,un) (7.2) flags 10
Failure of coda_cnode_make for root: error -19

--sm4nu43k4a2Rpi4c--
