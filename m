Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030240AbWF0SZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030240AbWF0SZZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 14:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030259AbWF0SZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 14:25:25 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:34366 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1030240AbWF0SZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 14:25:24 -0400
Date: Tue, 27 Jun 2006 20:26:46 +0200
From: Jens Axboe <axboe@suse.de>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-git broke suspend!
Message-ID: <20060627182646.GB32115@suse.de>
References: <20060627181045.GA32115@suse.de> <20060627182014.GB7914@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060627182014.GB7914@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27 2006, Dave Jones wrote:
> On Tue, Jun 27, 2006 at 08:10:45PM +0200, Jens Axboe wrote:
> 
>  > Incidentally, /sys/devices/system/cpu/cpu0/ is also empty on this
>  > kernel. Some new magic option that needs to be enabled? Not suspending
>  > sucks, cpufreq not working sucks as well (I'm stuck on 800MHz).
> 
> dmesg ? Is this powernow-k8 hardware ?

Nopes, it's an IBM T43 so centrino.

> If so, can you try backing out 6cad647da228486f36a9794137ad459e39b02590
> and e7bdd7a531320eb4a4a8160afbe0c7cc98ac7187 ?

I guess that's not relevant then?

I'll boot the older kernel and do a dmesg diff as well...

00000005fef5000 - 000000005ff00000 (ACPI NVS)
 BIOS-e820: 000000005ff00000 - 0000000060000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000f0008000 - 00000000f000c000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fed14000 - 00000000fed1a000 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000fed90000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
1534MB LOWMEM available.
On node 0 totalpages: 392928
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 388832 pages, LIFO batch:31
DMI present.
ACPI: RSDP (v002 IBM                                   ) @ 0x000f6c00
ACPI: XSDT (v001 IBM    TP-1Y    0x00001240  LTP 0x00000000) @ 0x5fee6ff2
ACPI: FADT (v003 IBM    TP-1Y    0x00001240 IBM  0x00000001) @ 0x5fee7100
ACPI: SSDT (v001 IBM    TP-1Y    0x00001240 MSFT 0x0100000e) @ 0x5fee72b4
ACPI: ECDT (v001 IBM    TP-1Y    0x00001240 IBM  0x00000001) @ 0x5fef4def
ACPI: TCPA (v001 IBM    TP-1Y    0x00001240 PTL  0x00000001) @ 0x5fef4e41
ACPI: MADT (v001 IBM    TP-1Y    0x00001240 IBM  0x00000001) @ 0x5fef4e73
ACPI: MCFG (v001 IBM    TP-1Y    0x00001240 IBM  0x00000001) @ 0x5fef4ecd
ACPI: BOOT (v001 IBM    TP-1Y    0x00001240  LTP 0x00000001) @ 0x5fef4fd8
ACPI: DSDT (v001 IBM    TP-1Y    0x00001240 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:13 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 68000000 (gap: 60000000:80000000)
Detected 798.110 MHz processor.
Built 1 zonelists.  Total pages: 392928
Kernel command line: root=/dev/sda1 vga=0x342 libata.atapi_enabled=1 libata.bridge_limits=0 resume=/dev/sda7 fcache.disable=1
Unknown boot option `libata.bridge_limits=0': ignoring
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=78380000 soft=7837f000
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 131072 (order: 7, 524288 bytes)
Memory: 1554624k/1571712k available (1740k kernel code, 16620k reserved, 658k data, 132k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1597.30 BogoMIPS (lpj=798654)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: afe9fbff 00100000 00000000 00000000 00000180 00000000 00000000
CPU: After vendor identify, caps: afe9fbff 00100000 00000000 00000000 00000180 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: After all inits, caps: afe9fbff 00100000 00000000 00000040 00000180 00000000 00000000
CPU: Intel(R) Pentium(R) M processor 1.86GHz stepping 08
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 0k freed
ACPI: Core revision 20060608
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG
Setting up standard PCI resources
ACPI: Found ECDT
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH6 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC] (gpe 28) interrupt mode.
ACPI: Power Resource [PUBS] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
Intel 82802 RNG detected
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
  IO window: 3000-3fff
  MEM window: a8100000-a81fffff
  PREFETCH window: c0000000-c7ffffff
PCI: Bridge: 0000:00:1c.0
  IO window: disabled.
  MEM window: a8200000-a82fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.2
  IO window: 4000-4fff
  MEM window: a8300000-a83fffff
  PREFETCH window: c8000000-c80fffff
PCI: Bus 5, cardbus bridge: 0000:04:00.0
  IO window: 00005000-000050ff
  IO window: 00005400-000054ff
  PREFETCH window: d0000000-d1ffffff
  MEM window: aa000000-abffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 5000-8fff
  MEM window: a8400000-b7ffffff
  PREFETCH window: d0000000-d7ffffff
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 20 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.0 to 64
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 22 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1c.2 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 16 (level, low) -> IRQ 16
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
TCP established hash table entries: 262144 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
Simple Boot Flag at 0x35 set to 0x1
Initializing Cryptographic API
io scheduler noop registered
io scheduler cfq registered (default)
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:01.0:pcie00]
Allocate Port Service[0000:00:01.0:pcie03]
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
Allocate Port Service[0000:00:1c.0:pcie02]
Allocate Port Service[0000:00:1c.0:pcie03]
PCI: Setting latency timer of device 0000:00:1c.2 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.2:pcie00]
Allocate Port Service[0000:00:1c.2:pcie02]
Allocate Port Service[0000:00:1c.2:pcie03]
vesafb: framebuffer at 0xc0000000, mapped to 0xd8880000, using 5742k, total 65472k
vesafb: mode is 1400x1050x16, linelength=2800, pages=21
vesafb: protected mode interface info at c000:5b55
vesafb: pmi: set display start = 780c5bc3, set palette = 780c5bfd
vesafb: pmi: ports = 3010 3016 3054 3038 303c 305c 3000 3004 30b0 30b2 30b4 
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 175x65
fb0: VESA VGA frame buffer device
Real Time Clock Driver v1.12ac
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing disabled
pnp: Unable to assign resources to device 00:09.
serial: probe of 00:09 failed with error -16
ACPI: PCI Interrupt 0000:00:1e.3[B] -> GSI 23 (level, low) -> IRQ 19
libata version 1.30 loaded.
ata_piix 0000:00:1f.2: version 1.10
ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x18C0 irq 14
scsi0 : ata_piix
ata1.00: configured for UDMA/100
  Vendor: ATA       Model: ST980825A         Rev: 3.04
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x18C8 irq 15
scsi1 : ata_piix
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 < sda5 sda6 sda7 >
sd 0:0:0:0: Attached scsi disk sda
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
ieee80211: 802.11 data/management/control stack, git-1.1.13
ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
ieee80211_crypt: registered algorithm 'NULL'
ieee80211_crypt: registered algorithm 'WEP'
Using IPI Shortcut mode
ACPI: (supports<6>Time: tsc clocksource has been installed.
 S0 S3 S4 S5)
input: AT Translated Set 2 keyboard as /class/input/input0
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: sda1: orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 883340
EXT3-fs: sda1: 1 orphan inode deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 132k freed
IBM TrackPoint firmware: 0x0e, buttons: 3/3
input: TPPS/2 IBM TrackPoint as /class/input/input1
EXT3 FS on sda1, internal journal
Yenta: CardBus bridge found at 0000:04:00.0 [1014:056c]
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 915GM Chipset.
agpgart: AGP aperture is 256M @ 0x0
ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.1.2k
ipw2200: Copyright(c) 2003-2006 Intel Corporation
Yenta: ISA IRQ mask 0x04b8, PCI irq 16
Socket status: 30000006
USB Universal Host Controller Interface driver v3.0
pcmcia: parent PCI bridge I/O window: 0x5000 - 0x8fff
pcmcia: parent PCI bridge Memory window: 0xa8400000 - 0xb7ffffff
pcmcia: parent PCI bridge Memory window: 0xd0000000 - 0xd7ffffff
ACPI: PCI Interrupt 0000:04:02.0[A] -> GSI 21 (level, low) -> IRQ 20
ipw2200: Detected Intel PRO/Wireless 2915ABG Network Connection
sd 0:0:0:0: Attached scsi generic sg0 type 0
ipw2200: Detected geography ZZE (13 802.11bg channels, 19 802.11a channels)
tg3.c:v3.60 (June 17, 2006)
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:02:00.0 to 64
eth1: Tigon3 [partno(BCM95751M) rev 4101 PHY(5750)] (PCI Express) 10/100/1000BaseT Ethernet 00:10:c6:dd:56:af
eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
eth1: dma_rwctrl[76180000] dma_mask[64-bit]
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 16, io base 0x00001800
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 21, io base 0x00001820
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 22, io base 0x00001840
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.3: irq 23, io base 0x00001860
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 19 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 23, io mem 0xa8000000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
ACPI: PCI Interrupt 0000:00:1e.2[A] -> GSI 22 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1e.2 to 64
usb 3-2: new full speed USB device using uhci_hcd and address 3
usb 3-2: configuration #1 chosen from 1 choice
intel8x0_measure_ac97_clock: measured 50410 usecs
intel8x0: clocking to 48000
loop: loaded (max 8 devices)
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 1951856k swap on /dev/sda7.  Priority:-1 extents:1 across:1951856k
ACPI: AC Adapter [AC] (off-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3] C4[C3])
ACPI: Processor [CPU] (supports 8 throttling states)
Time: acpi_pm clocksource has been installed.
ACPI: Thermal Zone [THM0] (46 C)
ibm_acpi: IBM ThinkPad ACPI Extras v0.12a
ibm_acpi: http://ibm-acpi.sf.net/
ibm_acpi: bay device not present
PM: Writing back config space on device 0000:02:00.0 at offset c (was fcff0000, writing 0)
NET: Registered protocol family 10
ADDRCONF(NETDEV_UP): eth0: link is not ready
IPv6 over IPv4 tunneling driver
eth1: no IPv6 routers present
Bluetooth: Core ver 2.8
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized

-- 
Jens Axboe

