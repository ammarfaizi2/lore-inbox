Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751346AbWCGRZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbWCGRZS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 12:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWCGRZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 12:25:17 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:11933 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751346AbWCGRZP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 12:25:15 -0500
Subject: Re: 2.6.16-rc5-mm2
From: john stultz <johnstul@us.ibm.com>
To: Dominik Karall <dominik.karall@gmx.net>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200603071533.41430.dominik.karall@gmx.net>
References: <20060303045651.1f3b55ec.akpm@osdl.org>
	 <200603052354.02828.dominik.karall@gmx.net>
	 <20060306214357.0b299686.akpm@osdl.org>
	 <200603071533.41430.dominik.karall@gmx.net>
Content-Type: text/plain
Date: Tue, 07 Mar 2006 09:25:12 -0800
Message-Id: <1141752322.19827.3.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-07 at 15:33 +0100, Dominik Karall wrote:
> On Tuesday, 7. March 2006 06:43, Andrew Morton wrote:
> > Dominik Karall <dominik.karall@gmx.net> wrote:
> > > On Friday, 3. March 2006 13:56, Andrew Morton wrote:
> > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc
> > > >5/2. 6.16-rc5-mm2/
> > >
> > > hi,
> > > I don't know why, but it seems that the kernel doesn't use the correct
> > > BIOS time. I set it to the 23:30 and after booting I got ~01:00 (next
> > > day).
> >
> > Is that new behaviour?  What's the most recent -mm kernel which that
> > machine ran?
> >
> > The full dmesg output might tell us something.
> 
> I bootet 2.6.16-rc5 now, but the bug is still present. I set BIOS time to 
> 15:07 and after booting linux showed 17:35.

Interesting. Right off, I'm not sure where this would be coming from.
>From your dmesg it looks like this is running an x86-64 kernel, correct?
Andi, do you have any ideas?

thanks
-john


> Here is the dmesg output:
> 
> Linux version 2.6.16-rc5 (root@localhost) (gcc-Version 4.1.0 (Gentoo 4.1.0)) 
> #6 SMP PREEMPT Tue Mar 7 15:04:35 CET 2006
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000003ff30000 (usable)
>  BIOS-e820: 000000003ff30000 - 000000003ff40000 (ACPI data)
>  BIOS-e820: 000000003ff40000 - 000000003fff0000 (ACPI NVS)
>  BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
>  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
> ACPI: RSDP (v002 ACPIAM                                ) @ 0x00000000000fa8b0
> ACPI: XSDT (v001 A M I  OEMXSDT  0x08000403 MSFT 0x00000097) @ 
> 0x000000003ff30100
> ACPI: FADT (v003 A M I  OEMFACP  0x08000403 MSFT 0x00000097) @ 
> 0x000000003ff30290
> ACPI: MADT (v001 A M I  OEMAPIC  0x08000403 MSFT 0x00000097) @ 
> 0x000000003ff30390
> ACPI: OEMB (v001 A M I  OEMBIOS  0x08000403 MSFT 0x00000097) @ 
> 0x000000003ff40040
> ACPI: DSDT (v001  A0058 A0058002 0x00000002 MSFT 0x0100000d) @ 
> 0x0000000000000000
> Scanning NUMA topology in Northbridge 24
> Number of nodes 1
> Node 0 MemBase 0000000000000000 Limit 000000003ff30000
> NUMA: Using 63 for the hash shift.
> Using node hash shift of 63
> Bootmem setup node 0 0000000000000000-000000003ff30000
> On node 0 totalpages: 258249
>   DMA zone: 3934 pages, LIFO batch:0
>   DMA32 zone: 254315 pages, LIFO batch:31
>   Normal zone: 0 pages, LIFO batch:0
>   HighMem zone: 0 pages, LIFO batch:0
> ACPI: PM-Timer IO Port: 0x808
> ACPI: Local APIC address 0xfee00000
> ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
> Processor #0 15:12 APIC version 16
> ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
> IOAPIC[0]: apic_id 1, version 3, address 0xfec00000, GSI 0-23
> ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> ACPI: IRQ0 used by override.
> ACPI: IRQ2 used by override.
> ACPI: IRQ9 used by override.
> Setting APIC routing to flat
> Using ACPI (MADT) for SMP configuration information
> Allocating PCI resources starting at 50000000 (gap: 40000000:bff80000)
> Checking aperture...
> CPU 0: aperture @ e0000000 size 256 MB
> Built 1 zonelists
> Kernel command line:
> Initializing CPU#0
> PID hash table entries: 4096 (order: 12, 131072 bytes)
> time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
> time.c: Detected 2460.198 MHz processor.
> Console: colour VGA+ 80x25
> Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
> Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
> Memory: 1010564k/1047744k available (3289k kernel code, 36792k reserved, 1308k 
> data, 220k init)
> Calibrating delay using timer specific routine.. 4928.48 BogoMIPS 
> (lpj=2464243)
> Mount-cache hash table entries: 256
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 512K (64 bytes/line)
> CPU 0(1) -> Node 0 -> Core 0
> Using local APIC timer interrupts.
> result 12813545
> Detected 12.813 MHz APIC timer.
> Brought up 1 CPUs
> testing NMI watchdog ... OK.
> migration_cost=0
> DMI 2.3 present.
> NET: Registered protocol family 16
> ACPI: bus type pci registered
> PCI: Using configuration type 1
> ACPI: Subsystem revision 20060127
> ACPI: Interpreter enabled
> ACPI: Using IOAPIC for interrupt routing
> ACPI: PCI Root Bridge [PCI0] (0000:00)
> PCI: Probing PCI hardware (bus 00)
> Boot video device is 0000:01:00.0
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 14 15)
> ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 11 14 15)
> ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 10 11 14 15)
> ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 *7 10 11 14 15)
> ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
> ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
> ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
> ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
> SCSI subsystem initialized
> usbcore: registered new driver usbfs
> usbcore: registered new driver hub
> PCI: Using ACPI for IRQ routing
> PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
> agpgart: Detected AGP bridge 0
> agpgart: AGP aperture is 256M @ 0xe0000000
> PCI-DMA: Disabling IOMMU.
> PCI: Bridge: 0000:00:01.0
>   IO window: a000-afff
>   MEM window: fcd00000-fd2fffff
>   PREFETCH window: 9fb00000-dfafffff
> PCI: Setting latency timer of device 0000:00:01.0 to 64
> IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
> Initializing Cryptographic API
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered
> io scheduler cfq registered (default)
> pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> ACPI: Power Button (FF) [PWRF]
> ACPI: Power Button (CM) [PWRB]
> ACPI: Sleep Button (CM) [SLPB]
> Using specific hotkey driver
> Real Time Clock Driver v1.12ac
> Non-volatile memory driver v1.2
> Linux agpgart interface v0.101 (c) Dave Jones
> serio: i8042 AUX port at 0x60,0x64 irq 12
> serio: i8042 KBD port at 0x60,0x64 irq 1
> Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
> serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> loop: loaded (max 8 devices)
> GSI 16 sharing vector 0xA9 and IRQ 16
> ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 169
> sk98lin: Asus mainboard with buggy VPD? Correcting data.
> eth0: Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
>       PrefPort:A  RlmtMode:Check Link State
> PPP generic driver version 2.4.2
> Linux video capture interface: v1.00
> bttv: driver version 0.9.16 loaded
> bttv: using 8 buffers with 2080k (520 pages) each for capture
> bttv: Bt8xx card found (0).
> GSI 17 sharing vector 0xB1 and IRQ 17
> ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 18 (level, low) -> IRQ 177
> bttv0: Bt878 (rev 17) at 0000:00:0d.0, irq: 177, latency: 128, mmio: 
> 0xdfe00000
> bttv0: detected: Hauppauge WinTV [card=10], PCI subsystem ID is 0070:13eb
> bttv0: using: Hauppauge (bt878) [card=10,autodetected]
> bttv0: gpio: en=00000000, out=00000000 in=00fffffb [init]
> bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]
> tveeprom 0-0050: Hauppauge model 38074, rev B521, serial# 5099850
> tveeprom 0-0050: tuner model is Philips FM1216 (idx 21, type 5)
> tveeprom 0-0050: TV standards PAL(B/G) (eeprom 0x04)
> tveeprom 0-0050: audio processor is None (idx 0)
> tveeprom 0-0050: has radio
> bttv0: Hauppauge eeprom indicates model#38074
> bttv0: using tuner=5
> bttv0: registered device video0
> bttv0: registered device vbi0
> bttv0: registered device radio0
> bttv0: PLL: 28636363 => 35468950 .. ok
> input: i2c IR (Hauppauge) as /class/input/input0
> ir-kbd-i2c: i2c IR (Hauppauge) detected at i2c-0/0-0018/ir0 [bt878 #0 [sw]]
> tuner 0-0061: chip found @ 0xc2 (bt878 #0 [sw])
> tuner 0-0061: type set to 5 (Philips PAL_BG (FI1216 and compatibles))
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> VP_IDE: IDE controller at PCI slot 0000:00:0f.1
> GSI 18 sharing vector 0xB9 and IRQ 18
> ACPI: PCI Interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 185
> PCI: Via IRQ fixup for 0000:00:0f.1, from 255 to 9
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
>     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
> Probing IDE interface ide0...
> hda: SAMSUNG SP1604N, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Probing IDE interface ide1...
> hdc: ATAPI DVD DD 2X16X4X16, ATAPI CD/DVD-ROM drive
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: max request size: 512KiB
> hda: 312581808 sectors (160041 MB) w/2048KiB Cache, CHS=19457/255/63, 
> UDMA(133)
> hda: cache flushes supported
>  hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
> hdc: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.20
> libata version 1.20 loaded.
> sata_via 0000:00:0f.0: version 1.1
> ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 185
> PCI: Via IRQ fixup for 0000:00:0f.0, from 10 to 9
> sata_via 0000:00:0f.0: routed to hard irq line 9
> ata1: SATA max UDMA/133 cmd 0xE800 ctl 0xE402 bmdma 0xD400 irq 185
> ata2: SATA max UDMA/133 cmd 0xE000 ctl 0xD802 bmdma 0xD408 irq 185
> ata1: SATA link down (SStatus 0)
> scsi0 : sata_via
> ata2: SATA link down (SStatus 0)
> scsi1 : sata_via
> ieee1394: Initialized config rom entry `ip1394'
> GSI 19 sharing vector 0xC1 and IRQ 19
> ACPI: PCI Interrupt 0000:00:07.0[A] -> GSI 16 (level, low) -> IRQ 193
> PCI: Via IRQ fixup for 0000:00:07.0, from 11 to 1
> ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[193]  MMIO=[fd800000-fd8007ff]  
> Max Packet=[2048]  IR/IT contexts=[4/8]
> eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
> usbcore: registered new driver usblp
> drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
> Initializing USB Mass Storage driver...
> usbcore: registered new driver usb-storage
> USB Mass Storage support registered.
> mice: PS/2 mouse device common for all mice
> input: AT Translated Set 2 keyboard as /class/input/input1
> input: PC Speaker as /class/input/input2
> i2c /dev entries driver
> device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
> Advanced Linux Sound Architecture Driver Version 1.0.11rc2 (Wed Jan 04 
> 08:57:20 2006 UTC).
> GSI 20 sharing vector 0xC9 and IRQ 20
> ACPI: PCI Interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 201
> PCI: Via IRQ fixup for 0000:00:11.5, from 5 to 9
> PCI: Setting latency timer of device 0000:00:11.5 to 64
> codec_read: codec 0 is not valid [0xfe0000]
> codec_read: codec 0 is not valid [0xfe0000]
> codec_read: codec 0 is not valid [0xfe0000]
> codec_read: codec 0 is not valid [0xfe0000]
> ALSA device list:
>   #0: VIA 8237 with AD1980 at 0xc800, irq 201
> NET: Registered protocol family 2
> IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
> TCP established hash table entries: 131072 (order: 10, 4194304 bytes)
> TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
> TCP: Hash tables configured (established 131072 bind 65536)
> TCP reno registered
> IPv4 over IPv4 tunneling driver
> GRE over IPv4 tunneling driver
> TCP bic registered
> TCP westwood registered
> TCP htcp registered
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> NET: Registered protocol family 15
> powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.60.0)
> powernow-k8:    0 : fid 0x2 (1000 MHz), vid 0x12 (1100 mV)
> powernow-k8:    1 : fid 0xa (1800 MHz), vid 0xe (1200 mV)
> powernow-k8:    2 : fid 0xc (2000 MHz), vid 0xa (1300 mV)
> powernow-k8:    3 : fid 0xe (2200 MHz), vid 0x6 (1400 mV)
> powernow-k8:    4 : fid 0x10 (2400 MHz), vid 0x2 (1500 mV)
> cpu_init done, current fid 0x10, vid 0x0
> powernow-k8: ph2 null fid transition 0x10
> EXT3-fs: INFO: recovery required on readonly filesystem.
> EXT3-fs: write access will be enabled during recovery.
> input: ImPS/2 Generic Wheel Mouse as /class/input/input3
> ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e0180000ad032e]
> EXT3-fs: hda1: orphan cleanup on readonly fs
> kjournald starting.  Commit interval 5 seconds
> ext3_orphan_cleanup: deleting unreferenced inode 1971295
> ext3_orphan_cleanup: deleting unreferenced inode 1971248
> ext3_orphan_cleanup: deleting unreferenced inode 1971040
> EXT3-fs: hda1: 3 orphan inodes deleted
> EXT3-fs: recovery complete.
> EXT3-fs: mounted filesystem with ordered data mode.
> VFS: Mounted root (ext3 filesystem) readonly.
> Freeing unused kernel memory: 220k freed
> Adding 996020k swap on /dev/hda3.  Priority:-1 extents:1 across:996020k
> EXT3 FS on hda1, internal journal
> ACPI: PCI Interrupt 0000:00:0d.1[A] -> GSI 18 (level, low) -> IRQ 177
> r8169 Gigabit Ethernet driver 2.2LK-NAPI loaded
> GSI 21 sharing vector 0xD1 and IRQ 21
> ACPI: PCI Interrupt 0000:00:0e.0[A] -> GSI 19 (level, low) -> IRQ 209
> eth2: Identified chip type is 'RTL8169s/8110s'.
> eth2: RTL8169 at 0xffffc20000246000, 00:0c:f6:04:87:c0, IRQ 209
> USB Universal Host Controller Interface driver v2.3
> GSI 22 sharing vector 0xD9 and IRQ 22
> ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 217
> PCI: Via IRQ fixup for 0000:00:10.0, from 11 to 9
> uhci_hcd 0000:00:10.0: UHCI Host Controller
> uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
> uhci_hcd 0000:00:10.0: irq 217, io base 0x0000b400
> usb usb1: configuration #1 chosen from 1 choice
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 2 ports detected
> ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 217
> PCI: Via IRQ fixup for 0000:00:10.1, from 11 to 9
> uhci_hcd 0000:00:10.1: UHCI Host Controller
> uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
> uhci_hcd 0000:00:10.1: irq 217, io base 0x0000b800
> usb usb2: configuration #1 chosen from 1 choice
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 2 ports detected
> ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 217
> PCI: Via IRQ fixup for 0000:00:10.2, from 10 to 9
> uhci_hcd 0000:00:10.2: UHCI Host Controller
> uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
> uhci_hcd 0000:00:10.2: irq 217, io base 0x0000c000
> usb usb3: configuration #1 chosen from 1 choice
> hub 3-0:1.0: USB hub found
> hub 3-0:1.0: 2 ports detected
> ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 217
> PCI: Via IRQ fixup for 0000:00:10.3, from 10 to 9
> uhci_hcd 0000:00:10.3: UHCI Host Controller
> uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
> uhci_hcd 0000:00:10.3: irq 217, io base 0x0000c400
> usb usb4: configuration #1 chosen from 1 choice
> hub 4-0:1.0: USB hub found
> hub 4-0:1.0: 2 ports detected
> usb 1-2: new full speed USB device using uhci_hcd and address 2
> usb 1-2: configuration #1 chosen from 1 choice
> hub 1-2:1.0: USB hub found
> hub 1-2:1.0: 4 ports detected
> usb 2-1: new full speed USB device using uhci_hcd and address 2
> usb 2-1: configuration #1 chosen from 1 choice
> drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 2 if 0 alt 0 
> proto 2 vid 0x03F0 pid 0x7004
> ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 217
> PCI: Via IRQ fixup for 0000:00:10.4, from 5 to 9
> ehci_hcd 0000:00:10.4: EHCI Host Controller
> ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 5
> ehci_hcd 0000:00:10.4: irq 217, io mem 0xfdf00000
> ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
> usb usb5: configuration #1 chosen from 1 choice
> hub 5-0:1.0: USB hub found
> hub 5-0:1.0: 8 ports detected
> hub 1-2:1.0: hub_port_status failed (err = -71)
> hub 1-2:1.0: connect-debounce failed, port 1 disabled
> hub 1-2:1.0: cannot disable port 1 (err = -71)
> hub 1-2:1.0: hub_port_status failed (err = -71)
> hub 1-2:1.0: hub_port_status failed (err = -71)
> hub 1-2:1.0: hub_port_status failed (err = -71)
> usb 2-1: USB disconnect, address 2
> drivers/usb/class/usblp.c: usblp0: removed
> usb 5-2: new high speed USB device using ehci_hcd and address 2
> usb 5-2: configuration #1 chosen from 1 choice
> hub 5-2:1.0: USB hub found
> hub 5-2:1.0: 4 ports detected
> usb 1-2: USB disconnect, address 2
> usb 5-2.1: new high speed USB device using ehci_hcd and address 4
> ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
> usb 5-2.1: configuration #1 chosen from 1 choice
> scsi2 : SCSI emulation for USB Mass Storage devices
> usb-storage: device found at 4
> usb-storage: waiting for device to settle before scanning
> usb 2-1: new full speed USB device using uhci_hcd and address 3
> usb 2-1: configuration #1 chosen from 1 choice
> drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 3 if 0 alt 0 
> proto 2 vid 0x03F0 pid 0x7004
>   Vendor: Generic   Model: 223 U HS-CF       Rev: 1.95
>   Type:   Direct-Access                      ANSI SCSI revision: 00
> sd 2:0:0:0: Attached scsi removable disk sda
> sd 2:0:0:0: Attached scsi generic sg0 type 0
>   Vendor: Generic   Model: 223 U HS-MS       Rev: 1.95
>   Type:   Direct-Access                      ANSI SCSI revision: 00
> sd 2:0:0:1: Attached scsi removable disk sdb
> sd 2:0:0:1: Attached scsi generic sg1 type 0
> usb-storage: device scan complete
> ReiserFS: dm-0: found reiserfs format "3.6" with standard journal
> ReiserFS: dm-0: using ordered data mode
> ReiserFS: dm-0: journal params: device dm-0, size 8192, journal first block 
> 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
> ReiserFS: dm-0: checking transaction log (dm-0)
> ReiserFS: dm-0: Using r5 hash to sort names
> eth0: network connection up using port A
>     speed:           100
>     autonegotiation: yes
>     duplex mode:     full
>     flowctrl:        symmetric
>     irq moderation:  disabled
>     scatter-gather:  disabled
>     tx-checksum:     disabled
>     rx-checksum:     disabled
> PPP BSD Compression module registered
> PPP Deflate Compression module registered
> usb 5-2.2: new high speed USB device using ehci_hcd and address 5
> usb 5-2.2: configuration #1 chosen from 1 choice
> scsi3 : SCSI emulation for USB Mass Storage devices
> usb-storage: device found at 5
> usb-storage: waiting for device to settle before scanning
>   Vendor: ST325082  Model: 3A                Rev: 3.02
>   Type:   Direct-Access                      ANSI SCSI revision: 00
> SCSI device sdc: 488397168 512-byte hdwr sectors (250059 MB)
> sdc: Write Protect is off
> sdc: Mode Sense: 03 00 00 00
> sdc: assuming drive cache: write through
> SCSI device sdc: 488397168 512-byte hdwr sectors (250059 MB)
> sdc: Write Protect is off
> sdc: Mode Sense: 03 00 00 00
> sdc: assuming drive cache: write through
>  sdc:<6>Device not ready. Make sure there is a disc in the drive.
> Device not ready. Make sure there is a disc in the drive.
> Device not ready. Make sure there is a disc in the drive.
> Device not ready. Make sure there is a disc in the drive.
>  sdc1 sdc2
> sd 3:0:0:0: Attached scsi disk sdc
> sd 3:0:0:0: Attached scsi generic sg2 type 0
> usb-storage: device scan complete
> [drm] Initialized drm 1.0.1 20051102
> ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 193
> [drm] Initialized radeon 1.22.0 20051229 on minor 0
> agpgart: Found an AGP 3.5 compliant device at 0000:00:00.0.
> agpgart: X tried to set rate=x12. Setting to AGP3 x8 mode.
> agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
> agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
> [drm] Loading R300 Microcode
> agpgart: Found an AGP 3.5 compliant device at 0000:00:00.0.
> agpgart: X tried to set rate=x12. Setting to AGP3 x8 mode.
> agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
> agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
> [drm] Loading R300 Microcode

