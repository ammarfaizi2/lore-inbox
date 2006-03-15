Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbWCOSv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbWCOSv4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 13:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWCOSv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 13:51:56 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:61188 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751086AbWCOSvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 13:51:55 -0500
Date: Wed, 15 Mar 2006 19:51:52 +0100
From: Adrian Bunk <bunk@stusta.de>
To: mchehab@infradead.org, mdharm-usb@one-eyed-alien.net
Cc: v4l-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       usb-storage@lists.one-eyed-alien.net,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: 2.6.16-rc: saa7134 + usb-storage = freeze
Message-ID: <20060315185152.GA4454@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My computer always freezes after a few minutes with the following 
workload:
- watching TV with xawtv
- backup to an external USB disk using backup2l

As long as I'm not doing both at the same time there are no problems.

Freeze means:
- X is completely frozen
- TV sound continues to be correctly played (the TV card and the 
  internal sound chip are connected through an external cable)
- the light of the USB enclosure flashes at about twice per second

This problem is present in both 2.6.16-rc6-mm1 and 2.6.16-rc5
(the latter with a patch to support my saa7134 card).

dmesg is below.

Any hints how to find the source of this problem?

TIA
Adrian


Linux version 2.6.16-rc6-mm1 (bunk@r063144.stusta.swh.mhn.de) (gcc version 4.0.3 20060212 (prerelease) (Debian 4.0.2-9)) #4 Wed Mar 15 18:29:52 CET 2006
BIOS-provided physical RAM map:
sanitize start
sanitize end
copy_e820_map() start: 0000000000000000 size: 000000000009fc00 end: 000000000009fc00 type: 1
copy_e820_map() type is E820_RAM
add_memory_region(0000000000000000, 000000000009fc00, 1)
copy_e820_map() start: 000000000009fc00 size: 0000000000000400 end: 00000000000a0000 type: 2
add_memory_region(000000000009fc00, 0000000000000400, 2)
copy_e820_map() start: 00000000000f0000 size: 0000000000010000 end: 0000000000100000 type: 2
add_memory_region(00000000000f0000, 0000000000010000, 2)
copy_e820_map() start: 0000000000100000 size: 000000001fefb000 end: 000000001fffb000 type: 1
copy_e820_map() type is E820_RAM
add_memory_region(0000000000100000, 000000001fefb000, 1)
copy_e820_map() start: 000000001fffb000 size: 0000000000004000 end: 000000001ffff000 type: 3
add_memory_region(000000001fffb000, 0000000000004000, 3)
copy_e820_map() start: 000000001ffff000 size: 0000000000001000 end: 0000000020000000 type: 4
add_memory_region(000000001ffff000, 0000000000001000, 4)
copy_e820_map() start: 00000000fec00000 size: 0000000000001000 end: 00000000fec01000 type: 2
add_memory_region(00000000fec00000, 0000000000001000, 2)
copy_e820_map() start: 00000000fee00000 size: 0000000000001000 end: 00000000fee01000 type: 2
add_memory_region(00000000fee00000, 0000000000001000, 2)
copy_e820_map() start: 00000000ffff0000 size: 0000000000010000 end: 0000000100000000 type: 2
add_memory_region(00000000ffff0000, 0000000000010000, 2)
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fffb000 (usable)
 BIOS-e820: 000000001fffb000 - 000000001ffff000 (ACPI data)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131067
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 126971 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:0
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                  ) @ 0x000f5e30
ACPI: RSDT (v001 ASUS   A7V600-X 0x42302e31 MSFT 0x31313031) @ 0x1fffb000
ACPI: FADT (v001 ASUS   A7V600-X 0x42302e31 MSFT 0x31313031) @ 0x1fffb0b2
ACPI: BOOT (v001 ASUS   A7V600-X 0x42302e31 MSFT 0x31313031) @ 0x1fffb030
ACPI: MADT (v001 ASUS   A7V600-X 0x42302e31 MSFT 0x31313031) @ 0x1fffb058
ACPI: DSDT (v001   ASUS A7V600-X 0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: PM-Timer IO Port: 0xe408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 30000000 (gap: 20000000:dec00000)
Detected 1791.245 MHz processor.
Built 1 zonelists
Kernel command line: BOOT_IMAGE=l-2.6.16-rc6-m1 ro root=301 mode=1280x1024@760
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c0415000 soft=c0416000
PID hash table entries: 2048 (order: 11, 8192 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 510156k/524268k available (2082k kernel code, 13524k reserved, 897k data, 152k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3584.94 BogoMIPS (lpj=17924710)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000 00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps: 0383fbff c1c3fbff 00000000 00000020 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(TM) XP 2200+ stepping 01
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 0k freed
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Subsystem revision 20060210
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 *5 6 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 *6 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11 12) *15, disabled.
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI: Quirk-MSI-K8T Soundcard On
PCI: Unexpected Value in PCI-Register: no Change!
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Setting up standard PCI resources
PCI: Bridge: 0000:00:01.0
  IO window: d000-dfff
  MEM window: ef000000-efdfffff
  PREFETCH window: eff00000-f7ffffff
ACPI (acpi_bus-0216): Device 'PCI1' is not power manageable [20060210]
PCI: Setting latency timer of device 0000:00:01.0 to 64
Simple Boot Flag at 0x3a set to 0x1
Machine check exception polling timer started.
No parameters - using defaults.
  1   1   1   1   1 s   1/1    392981    438287    805326   1639961    810926
initcall at 0xc03f61a8: do_tests+0x0/0x66f(): returned with error code -55
io scheduler noop registered
io scheduler cfq registered (default)
 0000:00:10.0: uhci_check_and_reset_hc: legsup = 0x2000
 0000:00:10.0: Performing full reset
 0000:00:10.1: uhci_check_and_reset_hc: legsup = 0x2000
 0000:00:10.1: Performing full reset
 0000:00:10.2: uhci_check_and_reset_hc: legsup = 0x2000
 0000:00:10.2: Performing full reset
 0000:00:10.3: uhci_check_and_reset_hc: legsup = 0x2000
 0000:00:10.3: Performing full reset
PCI: Bypassing VIA 8237 APIC De-Assert Message
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retrieved PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=60) Memory=155.00 Mhz, System=155.00 MHz
radeonfb: PLL min 12000 max 35000
radeonfb: Monitor 1 type DFP found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
Console: switching to colour frame buffer device 160x64
radeonfb (0000:01:00.0): ATI Radeon QY 
lp: driver loaded but no devices found
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected VIA KT400/KT400A/KT600 chipset
agpgart: AGP aperture is 64M @ 0xf8000000
[drm] Initialized drm 1.0.1 20051102
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
[drm] Initialized radeon 1.23.0 20051229 on minor 0
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
lp0: using parport0 (polling).
loop: loaded (max 8 devices)
e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
ACPI: PCI Interrupt 0000:00:0b.0[A] -> GSI 19 (level, low) -> IRQ 17
e100: eth0: e100_probe: addr 0xee800000, irq 17, MAC addr 00:03:47:4D:C1:91
Linux video capture interface: v1.00
saa7130/34: v4l2 driver version 0.2.14 loaded
PCI: Enabling device 0000:00:0d.0 (0004 -> 0006)
ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 16 (level, low) -> IRQ 16
saa7133[0]: found at 0000:00:0d.0, rev: 208, irq: 16, latency: 32, mmio: 0xed800000
saa7133[0]: subsystem: 17de:7201, board: Tevion/KWorld DVB-T 220RF [card=88,autodetected]
saa7133[0]: board init: gpio is 100
saa7133[0]: i2c eeprom 00: de 17 01 72 ff ff ff ff ff ff ff ff ff ff ff ff
saa7133[0]: i2c eeprom 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7133[0]: i2c eeprom 20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7133[0]: i2c eeprom 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7133[0]: i2c eeprom 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7133[0]: i2c eeprom 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7133[0]: i2c eeprom 60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7133[0]: i2c eeprom 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7133[0]: registered device video0 [v4l2]
saa7133[0]: registered device vbi0
saa7133[0]: registered device radio0
tuner 4-004b: chip found @ 0x96 (saa7133[0])
tuner 4-004b: setting tuner address to 61
tuner 4-004b: type set to tda8290+75a
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
ACPI (acpi_bus-0216): Device 'IDE0' is not power manageable [20060210]
ACPI: PCI Interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 18
PCI: Via IRQ fixup for 0000:00:0f.1, from 14 to 2
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0x9400-0x9407, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x9408-0x940f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: SAMSUNG SV1604N, ATA DISK drive
hdb: SAMSUNG HA250JC, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: RWD XR-RW4424, ATAPI CD/DVD-ROM drive
hdd: SAMSUNG HA250JC, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 512KiB
hda: 312581808 sectors (160041 MB) w/2048KiB Cache, CHS=19457/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3
hdb: max request size: 512KiB
hdb: 488397168 sectors (250059 MB) w/2048KiB Cache, CHS=30401/255/63, UDMA(100)
hdb: cache flushes supported
 hdb: hdb1 hdb2
hdd: max request size: 512KiB
hdd: Host Protected Area detected.
	current capacity is 66055248 sectors (33820 MB)
	native  capacity is 488397168 sectors (250059 MB)
hdd: Host Protected Area disabled.
hdd: 488397168 sectors (250059 MB) w/2048KiB Cache, CHS=30401/255/63, UDMA(100)
hdd: cache flushes supported
 hdd: hdd1
hdc: ATAPI 24X CD-ROM CD-R/RW drive, 1860kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
ehci_hcd: block sizes: qh 128 qtd 96 itd 192 sitd 96
ACPI (acpi_bus-0216): Device 'SU20' is not power manageable [20060210]
ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 19
PCI: Via IRQ fixup for 0000:00:10.4, from 0 to 3
ehci_hcd 0000:00:10.4: EHCI Host Controller
drivers/usb/core/inode.c: creating file 'devices'
drivers/usb/core/inode.c: creating file '001'
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.4: reset hcs_params 0x4208 dbg=0 cc=4 pcc=2 ordered !ppc ports=8
ehci_hcd 0000:00:10.4: reset hcc_params 6872 thresh 7 uframes 256/512/1024
ehci_hcd 0000:00:10.4: MWI active
ehci_hcd 0000:00:10.4: supports USB remote wakeup
ehci_hcd 0000:00:10.4: irq 19, io mem 0xed000000
ehci_hcd 0000:00:10.4: reset command 080002 (park)=0 ithresh=8 period=1024 Reset HALT
ehci_hcd 0000:00:10.4: init command 010009 (park)=0 ithresh=1 period=256 RUN
ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: default language 0x0409
usb usb1: new device found, idVendor=0000, idProduct=0000
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.16-rc6-mm1 ehci_hcd
usb usb1: SerialNumber: 0000:00:10.4
usb usb1: uevent
usb usb1: device is self-powered
usb usb1: configuration #1 chosen from 1 choice
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: uevent
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: no power switching (usb 1.0)
hub 1-0:1.0: individual port over-current protection
hub 1-0:1.0: Single TT
hub 1-0:1.0: TT requires at most 8 FS bit times (666 ns)
hub 1-0:1.0: power on to power good time: 20ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: state 7 ports 8 chg 0000 evt 0000
drivers/usb/core/inode.c: creating file '001'
USB Universal Host Controller Interface driver v3.0
ehci_hcd 0000:00:10.4: GetStatus port 3 status 001803 POWER sig=j CSC CONNECT
hub 1-0:1.0: port 3, status 0501, change 0001, 480 Mb/s
ACPI (acpi_bus-0216): Device 'USB0' is not power manageable [20060210]
ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 19
PCI: Via IRQ fixup for 0000:00:10.0, from 0 to 3
uhci_hcd 0000:00:10.0: UHCI Host Controller
drivers/usb/core/inode.c: creating file '002'
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.0: detected 2 ports
uhci_hcd 0000:00:10.0: uhci_check_and_reset_hc: cmd = 0x0000
uhci_hcd 0000:00:10.0: Performing full reset
uhci_hcd 0000:00:10.0: irq 19, io base 0x00009000
usb usb2: default language 0x0409
usb usb2: new device found, idVendor=0000, idProduct=0000
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.16-rc6-mm1 uhci_hcd
usb usb2: SerialNumber: 0000:00:10.0
usb usb2: uevent
usb usb2: device is self-powered
usb usb2: configuration #1 chosen from 1 choice
usb usb2: adding 2-0:1.0 (config #1, interface 0)
usb 2-0:1.0: uevent
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: no power switching (usb 1.0)
hub 2-0:1.0: individual port over-current protection
hub 2-0:1.0: power on to power good time: 2ms
hub 2-0:1.0: local power source is good
hub 1-0:1.0: debounce: port 3: total 100ms stable 100ms status 0x501
drivers/usb/core/inode.c: creating file '001'
ACPI (acpi_bus-0216): Device 'USB1' is not power manageable [20060210]
ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 19
PCI: Via IRQ fixup for 0000:00:10.1, from 0 to 3
uhci_hcd 0000:00:10.1: UHCI Host Controller
drivers/usb/core/inode.c: creating file '003'
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.1: detected 2 ports
uhci_hcd 0000:00:10.1: uhci_check_and_reset_hc: cmd = 0x0000
uhci_hcd 0000:00:10.1: Performing full reset
uhci_hcd 0000:00:10.1: irq 19, io base 0x00008800
usb usb3: default language 0x0409
usb usb3: new device found, idVendor=0000, idProduct=0000
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.16-rc6-mm1 uhci_hcd
usb usb3: SerialNumber: 0000:00:10.1
usb usb3: uevent
usb usb3: device is self-powered
usb usb3: configuration #1 chosen from 1 choice
usb usb3: adding 3-0:1.0 (config #1, interface 0)
usb 3-0:1.0: uevent
hub 3-0:1.0: usb_probe_interface
hub 3-0:1.0: usb_probe_interface - got id
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
hub 3-0:1.0: standalone hub
hub 3-0:1.0: no power switching (usb 1.0)
hub 3-0:1.0: individual port over-current protection
hub 3-0:1.0: power on to power good time: 2ms
hub 3-0:1.0: local power source is good
ehci_hcd 0000:00:10.4: port 3 high speed
ehci_hcd 0000:00:10.4: GetStatus port 3 status 001005 POWER sig=se0 PE CONNECT
usb 1-3: new high speed USB device using ehci_hcd and address 2
drivers/usb/core/inode.c: creating file '001'
ACPI (acpi_bus-0216): Device 'USB2' is not power manageable [20060210]
ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 19
PCI: Via IRQ fixup for 0000:00:10.2, from 0 to 3
uhci_hcd 0000:00:10.2: UHCI Host Controller
drivers/usb/core/inode.c: creating file '004'
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:10.2: detected 2 ports
uhci_hcd 0000:00:10.2: uhci_check_and_reset_hc: cmd = 0x0000
uhci_hcd 0000:00:10.2: Performing full reset
uhci_hcd 0000:00:10.2: irq 19, io base 0x00008400
usb usb4: default language 0x0409
usb usb4: new device found, idVendor=0000, idProduct=0000
usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: UHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.16-rc6-mm1 uhci_hcd
usb usb4: SerialNumber: 0000:00:10.2
usb usb4: uevent
ehci_hcd 0000:00:10.4: port 3 high speed
ehci_hcd 0000:00:10.4: GetStatus port 3 status 001005 POWER sig=se0 PE CONNECT
usb usb4: device is self-powered
usb usb4: configuration #1 chosen from 1 choice
usb usb4: adding 4-0:1.0 (config #1, interface 0)
usb 4-0:1.0: uevent
hub 4-0:1.0: usb_probe_interface
hub 4-0:1.0: usb_probe_interface - got id
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
hub 4-0:1.0: standalone hub
hub 4-0:1.0: no power switching (usb 1.0)
hub 4-0:1.0: individual port over-current protection
hub 4-0:1.0: power on to power good time: 2ms
hub 4-0:1.0: local power source is good
usb 1-3: default language 0x0409
usb 1-3: new device found, idVendor=04b4, idProduct=6830
usb 1-3: new device strings: Mfr=56, Product=78, SerialNumber=100
usb 1-3: Product: USB2.0 Storage Device
usb 1-3: Manufacturer: Cypress Semiconductor
usb 1-3: SerialNumber: DEF10646E906
usb 1-3: uevent
usb 1-3: device is self-powered
usb 1-3: configuration #1 chosen from 1 choice
usb 1-3: adding 1-3:1.0 (config #1, interface 0)
usb 1-3:1.0: uevent
drivers/usb/core/inode.c: creating file '002'
hub 2-0:1.0: state 7 ports 2 chg 0000 evt 0006
uhci_hcd 0000:00:10.0: port 1 portsc 018a,00
hub 2-0:1.0: port 1, status 0300, change 0003, 1.5 Mb/s
drivers/usb/core/inode.c: creating file '001'
ACPI (acpi_bus-0216): Device 'USB3' is not power manageable [20060210]
ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 19
PCI: Via IRQ fixup for 0000:00:10.3, from 0 to 3
uhci_hcd 0000:00:10.3: UHCI Host Controller
drivers/usb/core/inode.c: creating file '005'
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:10.3: detected 2 ports
uhci_hcd 0000:00:10.3: uhci_check_and_reset_hc: cmd = 0x0000
uhci_hcd 0000:00:10.3: Performing full reset
uhci_hcd 0000:00:10.3: irq 19, io base 0x00008000
usb usb5: default language 0x0409
usb usb5: new device found, idVendor=0000, idProduct=0000
usb usb5: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb5: Product: UHCI Host Controller
usb usb5: Manufacturer: Linux 2.6.16-rc6-mm1 uhci_hcd
usb usb5: SerialNumber: 0000:00:10.3
usb usb5: uevent
usb usb5: device is self-powered
usb usb5: configuration #1 chosen from 1 choice
usb usb5: adding 5-0:1.0 (config #1, interface 0)
usb 5-0:1.0: uevent
hub 5-0:1.0: usb_probe_interface
hub 5-0:1.0: usb_probe_interface - got id
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
hub 5-0:1.0: standalone hub
hub 5-0:1.0: no power switching (usb 1.0)
hub 5-0:1.0: individual port over-current protection
hub 5-0:1.0: power on to power good time: 2ms
hub 5-0:1.0: local power source is good
hub 2-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x300
uhci_hcd 0000:00:10.0: port 2 portsc 018a,00
hub 2-0:1.0: port 2, status 0300, change 0003, 1.5 Mb/s
drivers/usb/core/inode.c: creating file '001'
Initializing USB Mass Storage driver...
hub 2-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x300
hub 3-0:1.0: state 7 ports 2 chg 0000 evt 0006
uhci_hcd 0000:00:10.1: port 1 portsc 008a,00
hub 3-0:1.0: port 1, status 0100, change 0003, 12 Mb/s
hub 3-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x100
uhci_hcd 0000:00:10.1: port 2 portsc 008a,00
hub 3-0:1.0: port 2, status 0100, change 0003, 12 Mb/s
hub 3-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x100
hub 4-0:1.0: state 7 ports 2 chg 0000 evt 0006
uhci_hcd 0000:00:10.2: port 1 portsc 018a,00
hub 4-0:1.0: port 1, status 0300, change 0003, 1.5 Mb/s
hub 4-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x300
uhci_hcd 0000:00:10.2: port 2 portsc 018a,00
hub 4-0:1.0: port 2, status 0300, change 0003, 1.5 Mb/s
hub 4-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x300
hub 5-0:1.0: state 7 ports 2 chg 0000 evt 0006
uhci_hcd 0000:00:10.3: port 1 portsc 018a,00
hub 5-0:1.0: port 1, status 0300, change 0003, 1.5 Mb/s
usb-storage 1-3:1.0: usb_probe_interface
usb-storage 1-3:1.0: usb_probe_interface - got id
scsi0 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 2
usb-storage: waiting for device to settle before scanning
hub 5-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x300
uhci_hcd 0000:00:10.3: port 2 portsc 018a,00
hub 5-0:1.0: port 2, status 0300, change 0003, 1.5 Mb/s
uhci_hcd 0000:00:10.0: suspend_rh (auto-stop)
hub 5-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x300
hub 3-0:1.0: state 7 ports 2 chg 0000 evt 0000
hub 4-0:1.0: state 7 ports 2 chg 0000 evt 0000
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
it87: Found IT8712F chip at 0x290, revision 5
Advanced Linux Sound Architecture Driver Version 1.0.11rc3 (Thu Feb 02 07:50:46 2006 UTC).
ACPI (acpi_bus-0216): Device 'AC97' is not power manageable [20060210]
ACPI: PCI Interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 20
PCI: Via IRQ fixup for 0000:00:11.5, from 0 to 4
input: AT Translated Set 2 keyboard as /class/input/input0
PCI: Setting latency timer of device 0000:00:11.5 to 64
uhci_hcd 0000:00:10.1: suspend_rh (auto-stop)
codec_read: codec 0 is not valid [0xfe0000]
codec_read: codec 0 is not valid [0xfe0000]
codec_read: codec 0 is not valid [0xfe0000]
codec_read: codec 0 is not valid [0xfe0000]
ALSA device list:
  #0: VIA 8237 with AD1888 at 0xe000, irq 20
NET: Registered protocol family 2
uhci_hcd 0000:00:10.2: suspend_rh (auto-stop)
IP route cache hash table entries: 8192 (order: 3, 32768 bytes)
TCP established hash table entries: 32768 (order: 7, 524288 bytes)
TCP bind hash table entries: 32768 (order: 7, 655360 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
TCP reno registered
ip_conntrack version 2.4 (4095 buckets, 32760 max) - 172 bytes per conntrack
input: ImPS/2 Generic Wheel Mouse as /class/input/input1
uhci_hcd 0000:00:10.3: suspend_rh (auto-stop)
ip_tables: (C) 2000-2006 Netfilter Core Team
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 152k freed
Time: tsc clocksource has been installed.
Adding 1004052k swap on /dev/hda2.  Priority:-1 extents:1 across:1004052k
  Vendor: SAMSUNG   Model: SV1604N           Rev: 0000
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 27 00 00 00
sda: assuming drive cache: write through
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 27 00 00 00
sda: assuming drive cache: write through
 sda: sda1
sd 0:0:0:0: Attached scsi disk sda
usb-storage: device scan complete
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
mtrr: 0xf0000000,0x8000000 overlaps existing 0xf0000000,0x4000000
mtrr: 0xf0000000,0x8000000 overlaps existing 0xf0000000,0x4000000
mtrr: 0xf0000000,0x8000000 overlaps existing 0xf0000000,0x4000000
agpgart: Found an AGP 3.5 compliant device at 0000:00:00.0.
agpgart: Device is in legacy mode, falling back to 2.x
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
[drm] Setting GART location based on old memory map
[drm] writeback test succeeded in 1 usecs
