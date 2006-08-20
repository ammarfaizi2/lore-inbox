Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbWHTRu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWHTRu4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 13:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWHTRu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 13:50:56 -0400
Received: from smtp-vbr1.xs4all.nl ([194.109.24.21]:33285 "EHLO
	smtp-vbr1.xs4all.nl") by vger.kernel.org with ESMTP
	id S1751091AbWHTRuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 13:50:54 -0400
Date: Sun, 20 Aug 2006 19:51:29 +0200
From: thunder7@xs4all.nl
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, Andi Kleen <ak@suse.de>,
       john stultz <johnstul@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, thunder7@xs4all.nl
Subject: Re: 2.6.18-rc4-mm1 - time moving at 3x speed, bisect finished
Message-ID: <20060820175128.GA4217@amd64.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <20060813012454.f1d52189.akpm@osdl.org> <200608181134.02427.ak@suse.de> <44E588AB.3050900@aitel.hist.no> <200608181255.46999.ak@suse.de> <20060819105031.GA3190@aitel.hist.no> <Pine.LNX.4.64.0608201859130.6762@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0608201859130.6762@scrub.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Zippel <zippel@linux-m68k.org>
Date: Sun, Aug 20, 2006 at 07:06:21PM +0200
> Hi,
> 
> On Sat, 19 Aug 2006, Helge Hafting wrote:
> 
> > > Can you narrow it down to a specific patch in -mm? 
> > >
> > The guilty patch is:
> > ntp-add-ntp_update_frequency.patch
> 
> That's really weird, I don't really have an idea why it should go wrong 
> there, could you please try the patch below and send me the kernel output?
> Thanks.
> 
The interesting part:

3b9aca0000000000,d2ea237f00000000,d2ea237f00000000,35fe7fdef9db22
3b9aca0000000000,d2ea237f00000000,d2ea237f00000000,35fe7fdef9db22
3b9aca0000000000,d2ea237f00000000,d2ea237f00000000,35fe7fdef9db22
3b9aca0000000000,d2ea237f00000000,d2ea237f00000000,35fe7fdef9db22
3b9aca0000000000,d2ea237f00000000,d2ea237f00000000,35fe7fdef9db22
3b9aca0000000000,d2ea237f00000000,d2ea237f00000000,35fe7fdef9db22

Kind regards,
Jurriaan


Full dmesg:

Linux version 2.6.18-rc4-mm2 (jurriaan@middle) (gcc version 4.1.2 20060814 (prerelease) (Debian 4.1.1-11)) #3 Sun Aug 20 19:43:39 CEST 2006
Command line: root=/dev/md2 video=nvidiafb:1600x1200-32@85 atkbd.softrepeat=1
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009c800 (usable)
 BIOS-e820: 000000000009c800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000bfff0000 (usable)
 BIOS-e820: 00000000bfff0000 - 00000000bfff3000 (ACPI NVS)
 BIOS-e820: 00000000bfff3000 - 00000000c0000000 (ACPI data)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000140000000 (usable)
DMI 2.3 present.
ACPI: RSDP (v000 Nvidia                                ) @ 0x00000000000f7d30
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x00000000bfff3040
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x00000000bfff30c0
ACPI: SSDT (v001 PTLTD  POWERNOW 0x00000001  LTP 0x00000001) @ 0x00000000bfff9900
ACPI: SRAT (v001 AMD    HAMMER   0x00000001 AMD  0x00000001) @ 0x00000000bfff9a40
ACPI: MCFG (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x00000000bfff9b40
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x00000000bfff9840
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x0000000000000000
On node 0 totalpages: 1028777
  DMA zone: 2177 pages, LIFO batch:0
  DMA32 zone: 768040 pages, LIFO batch:31
  Normal zone: 258560 pages, LIFO batch:31
Nvidia board detected. Ignoring ACPI timer override.
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:7 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] disabled)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: BIOS IRQ0 pin2 override ignored.
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
ACPI: IRQ9 used by override.
ACPI: IRQ14 used by override.
ACPI: IRQ15 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Nosave address range: 000000000009c000 - 000000000009d000
Nosave address range: 000000000009d000 - 00000000000a0000
Nosave address range: 00000000000a0000 - 00000000000f0000
Nosave address range: 00000000000f0000 - 0000000000100000
Nosave address range: 00000000bfff0000 - 00000000bfff3000
Nosave address range: 00000000bfff3000 - 00000000c0000000
Nosave address range: 00000000c0000000 - 00000000e0000000
Nosave address range: 00000000e0000000 - 00000000f0000000
Nosave address range: 00000000f0000000 - 00000000fec00000
Nosave address range: 00000000fec00000 - 0000000100000000
Allocating PCI resources starting at c2000000 (gap: c0000000:20000000)
Built 1 zonelists.  Total pages: 1028777
Kernel command line: root=/dev/md2 video=nvidiafb:1600x1200-32@85 atkbd.softrepeat=1
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
3b9aca0000000000,d2ea237f00000000,d2ea237f00000000,35fe7fdef9db22
u: 3538559.870999, 0.0000
time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
time.c: Detected 2211.364 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Checking aperture...
CPU 0: aperture @ 8000000 size 32 MB
Aperture too small (32 MB)
No AGP bridge found
Your BIOS doesn't leave a aperture memory hole
Please enable the IOMMU option in the BIOS setup
This costs you 64 MB of RAM
Mapping aperture over 65536 KB of RAM @ 8000000
Memory: 4042988k/5242880k available (3762k kernel code, 150536k reserved, 2309k data, 232k init)
Calibrating delay using timer specific routine.. 4423.94 BogoMIPS (lpj=2211970)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU: AMD Athlon(tm) 64 Processor 3700+ stepping 01
ACPI: Core revision 20060707
Using local APIC timer interrupts.
result 12564570
Detected 12.564 MHz APIC timer.
testing NMI watchdog ... OK.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG at e0000000
PCI: No mmconfig possible on device 00:18
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:09.0
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs *3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs *3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LMAC] (IRQs *3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 *7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 *7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSID] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LFID] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LPCA] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCP] (IRQs 20 21 22 23) *0, disabled.
Generic PHY: Registered new driver
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI-DMA: Disabling AGP.
PCI-DMA: aperture base @ 8000000 size 65536 KB
PCI-DMA: using GART IOMMU.
PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
ieee1394: Initialized config rom entry `ip1394'
ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
ACPI: PCI Interrupt 0000:05:08.2[B] -> Link [APC4] -> GSI 19 (level, low) -> IRQ 19
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[19]  MMIO=[d900e000-d900e7ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
ACPI: PCI Interrupt 0000:05:0b.0[A] -> Link [APC1] -> GSI 16 (level, low) -> IRQ 16
ohci1394: fw-host1: OHCI-1394 1.1 (PCI): IRQ=[16]  MMIO=[d900d000-d900d7ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
PCI: Bridge: 0000:00:09.0
  IO window: 6000-afff
  MEM window: d8000000-d9ffffff
  PREFETCH window: da100000-da1fffff
PCI: Bridge: 0000:00:0b.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0c.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0d.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0e.0
  IO window: disabled.
  MEM window: d0000000-d7ffffff
  PREFETCH window: c0000000-cfffffff
PCI: Setting latency timer of device 0000:00:09.0 to 64
PCI: Setting latency timer of device 0000:00:0b.0 to 64
PCI: Setting latency timer of device 0000:00:0c.0 to 64
PCI: Setting latency timer of device 0000:00:0d.0 to 64
PCI: Setting latency timer of device 0000:00:0e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
TCP established hash table entries: 524288 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
TCP reno registered
Coda Kernel/Venus communications, v6.0.0, coda@cs.cmu.edu
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.27 [Flags: R/O].
io scheduler noop registered
io scheduler cfq registered (default)
PCI: Linking AER extended capability on 0000:00:0b.0
PCI: Linking AER extended capability on 0000:00:0c.0
PCI: Linking AER extended capability on 0000:00:0d.0
PCI: Linking AER extended capability on 0000:00:0e.0
PCI: Setting latency timer of device 0000:00:0b.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0b.0:pcie00]
Allocate Port Service[0000:00:0b.0:pcie03]
PCI: Setting latency timer of device 0000:00:0c.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0c.0:pcie00]
Allocate Port Service[0000:00:0c.0:pcie03]
PCI: Setting latency timer of device 0000:00:0d.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0d.0:pcie00]
Allocate Port Service[0000:00:0d.0:pcie03]
PCI: Setting latency timer of device 0000:00:0e.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0e.0:pcie00]
Allocate Port Service[0000:00:0e.0:pcie03]
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [APC3] -> GSI 18 (level, low) -> IRQ 18
nvidiafb: Device ID: 10de0141 
nvidiafb: CRTC0 analog found
nvidiafb: CRTC1 analog found
i2c_adapter i2c-0: unable to read EDID block.
ohci1394: fw-host0: Running dma failed because Node ID is not valid
i2c_adapter i2c-0: unable to read EDID block.
i2c_adapter i2c-0: unable to read EDID block.
nvidiafb: EDID found from BUS2
nvidiafb: CRTC 0 appears to have a CRT attached
nvidiafb: Using CRT on CRTC 0
nvidiafb: MTRR set to ON
Console: switching to colour frame buffer device 160x66
nvidiafb: PCI nVidia NV14 framebuffer (64MB @ 0xC0000000)
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
Using specific hotkey driver
lp: driver loaded but no devices found
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
Hangcheck: Using monotonic_clock().
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
ACPI: PCI Interrupt 0000:05:0c.0[A] -> Link [APC2] -> GSI 17 (level, low) -> IRQ 17
skge 1.6 addr 0xd9008000 irq 17 chip Yukon-Lite rev 9
skge eth0: addr 00:15:f2:20:e6:69
Marvell 88E1101: Registered new driver
Davicom DM9161E: Registered new driver
Davicom DM9131: Registered new driver
Cicada Cis8204: Registered new driver
Cicada Cis8201: Registered new driver
LXT970: Registered new driver
LXT971: Registered new driver
QS6612: Registered new driver
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.57.
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [APCH] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:0a.0 to 64
forcedeth: using HIGHDMA
ohci1394: fw-host0: AT dma reset ctx=0, aborting transmission
ieee1394: Current remote IRM is not 1394a-2000 compliant, resetting...
eth1: forcedeth.c: subsystem: 01043:8141 bound to 0000:00:0a.0
Linux Tulip driver version 1.1.14 (May 6, 2006)
ACPI: PCI Interrupt 0000:05:07.0[A] -> Link [APC2] -> GSI 17 (level, low) -> IRQ 17
tulip0:  MII transceiver #1 config 3100 status 7829 advertising 01e1.
eth2: Lite-On 82c168 PNIC rev 32 at 0000000000018800, 00:A0:CC:21:89:0C, IRQ 17.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE-CK804: IDE controller at PCI slot 0000:00:06.0
NFORCE-CK804: chipset revision 242
NFORCE-CK804: not 100% native mode: will probe irqs later
NFORCE-CK804: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE-CK804: 0000:00:06.0 (rev f2) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
ieee1394: Host added: ID:BUS[0-01:1023]  GUID[00023c014100f4bf]
hda: WDC WD2000JB-32EVA0, ATA DISK drive
ieee1394: Host added: ID:BUS[1-00:1023]  GUID[0011d80000738f5d]
hdb: _NEC DVD_RW ND-3540A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: WDC WD2000JB-00FUA0, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
HPT374: IDE controller at PCI slot 0000:05:06.0
ACPI: PCI Interrupt 0000:05:06.0[A] -> Link [APC1] -> GSI 16 (level, low) -> IRQ 16
HPT374: chipset revision 7
HPT374: DPLL base: 48 MHz, f_CNT: 149, assuming 33 MHz PCI
HPT374: using 66 MHz DPLL clock
HPT374: 100% native mode on irq 16
    ide2: BM-DMA at 0x7000-0x7007, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0x7008-0x700f, BIOS settings: hdg:pio, hdh:pio
ACPI: PCI Interrupt 0000:05:06.1[A] -> Link [APC1] -> GSI 16 (level, low) -> IRQ 16
HPT374: no clock data saved by BIOS
HPT374: DPLL base: 48 MHz, f_CNT: 121, assuming 33 MHz PCI
HPT374: using 66 MHz DPLL clock
    ide4: BM-DMA at 0x8400-0x8407, BIOS settings: hdi:DMA, hdj:pio
    ide5: BM-DMA at 0x8408-0x840f, BIOS settings: hdk:pio, hdl:pio
Probing IDE interface ide2...
hde: WDC WD2500JB-00FUA0, ATA DISK drive
ide2 at 0x6000-0x6007,0x6402 on irq 16
Probing IDE interface ide3...
Probing IDE interface ide4...
hdi: ST3300831A, ATA DISK drive
ide4 at 0x7400-0x7407,0x7802 on irq 16
Probing IDE interface ide5...
Probing IDE interface ide3...
Probing IDE interface ide5...
hda: max request size: 512KiB
hda: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 >
hdc: max request size: 512KiB
hdc: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63, UDMA(100)
hdc: cache flushes supported
 hdc: hdc1 hdc2 < hdc5 hdc6 hdc7 hdc8 hdc9 >
hde: max request size: 512KiB
hde: 488397168 sectors (250059 MB) w/8192KiB Cache, CHS=30401/255/63, UDMA(100)
hde: cache flushes supported
 hde: hde1
hdi: max request size: 512KiB
hdi: 586072368 sectors (300069 MB) w/8192KiB Cache, CHS=36481/255/63, UDMA(100)
hdi: cache flushes supported
 hdi: hdi1
hdb: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
RocketRAID 3xxx SATA Controller driver v1.0 (060426)
libata version 2.00 loaded.
sata_sil 0000:05:0a.0: version 2.0
ACPI: PCI Interrupt 0000:05:0a.0[A] -> Link [APC4] -> GSI 19 (level, low) -> IRQ 19
sata_sil 0000:05:0a.0: Applying R_ERR on DMA activate FIS errata fix
ata1: SATA max UDMA/100 cmd 0xFFFFC200100BA080 ctl 0xFFFFC200100BA08A bmdma 0xFFFFC200100BA000 irq 19
ata2: SATA max UDMA/100 cmd 0xFFFFC200100BA0C0 ctl 0xFFFFC200100BA0CA bmdma 0xFFFFC200100BA008 irq 19
ata3: SATA max UDMA/100 cmd 0xFFFFC200100BA280 ctl 0xFFFFC200100BA28A bmdma 0xFFFFC200100BA200 irq 19
ata4: SATA max UDMA/100 cmd 0xFFFFC200100BA2C0 ctl 0xFFFFC200100BA2CA bmdma 0xFFFFC200100BA208 irq 19
scsi0 : sata_sil
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 0/32)
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/100
scsi1 : sata_sil
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata2.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 0/32)
ata2.00: ata2: dev 0 multi count 16
ata2.00: configured for UDMA/100
scsi2 : sata_sil
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata3.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 0/32)
ata3.00: ata3: dev 0 multi count 16
ata3.00: configured for UDMA/100
scsi3 : sata_sil
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata4.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 0/32)
ata4.00: ata4: dev 0 multi count 16
ata4.00: configured for UDMA/100
  Vendor: ATA       Model: ST3250823AS       Rev: 3.03
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
  Vendor: ATA       Model: ST3250823AS       Rev: 3.03
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1
sd 1:0:0:0: Attached scsi disk sdb
sd 1:0:0:0: Attached scsi generic sg1 type 0
  Vendor: ATA       Model: ST3250823AS       Rev: 3.03
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdc: 488397168 512-byte hdwr sectors (250059 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
Losing some ticks... checking if CPU frequency changed.
SCSI device sdc: 488397168 512-byte hdwr sectors (250059 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
 sdc: sdc1
sd 2:0:0:0: Attached scsi disk sdc
sd 2:0:0:0: Attached scsi generic sg2 type 0
  Vendor: ATA       Model: ST3250823AS       Rev: 3.02
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdd: 488397168 512-byte hdwr sectors (250059 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back
SCSI device sdd: 488397168 512-byte hdwr sectors (250059 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back
 sdd: sdd1
sd 3:0:0:0: Attached scsi disk sdd
sd 3:0:0:0: Attached scsi generic sg3 type 0
sata_nv 0000:00:07.0: version 2.0
ACPI: PCI Interrupt Link [APSI] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [APSI] -> GSI 22 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:07.0 to 64
ata5: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xD800 irq 22
ata6: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xD808 irq 22
scsi4 : sata_nv
ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata5.00: ATA-7, max UDMA/133, 586072368 sectors: LBA48 NCQ (depth 0/32)
ata5.00: ata5: dev 0 multi count 1
ata5.00: configured for UDMA/133
scsi5 : sata_nv
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata6.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 0/32)
ata6.00: ata6: dev 0 multi count 1
ata6.00: configured for UDMA/133
  Vendor: ATA       Model: ST3300622AS       Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sde: 586072368 512-byte hdwr sectors (300069 MB)
sde: Write Protect is off
sde: Mode Sense: 00 3a 00 00
SCSI device sde: drive cache: write back
SCSI device sde: 586072368 512-byte hdwr sectors (300069 MB)
sde: Write Protect is off
sde: Mode Sense: 00 3a 00 00
SCSI device sde: drive cache: write back
 sde: sde1 sde2
sd 4:0:0:0: Attached scsi disk sde
sd 4:0:0:0: Attached scsi generic sg4 type 0
  Vendor: ATA       Model: ST3250823AS       Rev: 3.03
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdf: 488397168 512-byte hdwr sectors (250059 MB)
sdf: Write Protect is off
sdf: Mode Sense: 00 3a 00 00
SCSI device sdf: drive cache: write back
SCSI device sdf: 488397168 512-byte hdwr sectors (250059 MB)
sdf: Write Protect is off
sdf: Mode Sense: 00 3a 00 00
SCSI device sdf: drive cache: write back
 sdf: sdf1
sd 5:0:0:0: Attached scsi disk sdf
sd 5:0:0:0: Attached scsi generic sg5 type 0
ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [APSJ] -> GSI 21 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:08.0 to 64
ata7: SATA max UDMA/133 cmd 0x9E0 ctl 0xBE2 bmdma 0xC400 irq 21
ata8: SATA max UDMA/133 cmd 0x960 ctl 0xB62 bmdma 0xC408 irq 21
scsi6 : sata_nv
ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata7.00: ATA-7, max UDMA/133, 586072368 sectors: LBA48 NCQ (depth 0/32)
ata7.00: ata7: dev 0 multi count 1
ata7.00: configured for UDMA/133
scsi7 : sata_nv
ata8: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata8.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 0/32)
ata8.00: ata8: dev 0 multi count 1
ata8.00: configured for UDMA/133
  Vendor: ATA       Model: ST3300622AS       Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdg: 586072368 512-byte hdwr sectors (300069 MB)
sdg: Write Protect is off
sdg: Mode Sense: 00 3a 00 00
SCSI device sdg: drive cache: write back
SCSI device sdg: 586072368 512-byte hdwr sectors (300069 MB)
sdg: Write Protect is off
sdg: Mode Sense: 00 3a 00 00
SCSI device sdg: drive cache: write back
 sdg: sdg1 sdg2
sd 6:0:0:0: Attached scsi disk sdg
sd 6:0:0:0: Attached scsi generic sg6 type 0
  Vendor: ATA       Model: ST3250823AS       Rev: 3.03
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdh: 488397168 512-byte hdwr sectors (250059 MB)
sdh: Write Protect is off
sdh: Mode Sense: 00 3a 00 00
SCSI device sdh: drive cache: write back
SCSI device sdh: 488397168 512-byte hdwr sectors (250059 MB)
sdh: Write Protect is off
sdh: Mode Sense: 00 3a 00 00
SCSI device sdh: drive cache: write back
 sdh: sdh1
sd 7:0:0:0: Attached scsi disk sdh
sd 7:0:0:0: Attached scsi generic sg7 type 0
pata_hpt37x: BIOS has not set timing clocks.
hpt37x: HPT374: Bus clock 33MHz.
PCI: Unable to reserve I/O region #1:8@7400 for device 0000:05:06.1
pata_hpt37x: probe of 0000:05:06.1 failed with error -16
video1394: Installed video1394 module
ieee1394: raw1394: /dev/raw1394 device initialized
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
ieee1394: sbp2: Try serialize_io=0 for better performance
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 20
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCL] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:02.1 to 64
ehci_hcd 0000:00:02.1: EHCI Host Controller
ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:02.1: debug port 1
PCI: cache line size of 64 is not supported by device 0000:00:02.1
ehci_hcd 0000:00:02.1: irq 20, io mem 0xfeb00000
ehci_hcd 0000:00:02.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: new device found, idVendor=0000, idProduct=0000
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.18-rc4-mm2 ehci_hcd
usb usb1: SerialNumber: 0000:00:02.1
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 10 ports detected
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.0: irq 23, io mem 0xda004000
usb usb2: new device found, idVendor=0000, idProduct=0000
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: OHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.18-rc4-mm2 ohci_hcd
usb usb2: SerialNumber: 0000:00:02.0
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 10 ports detected
usbcore: registered new interface driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input0
input: AT Translated Set 2 keyboard as /class/input/input1
i2c /dev entries driver
md: linear personality registered for level -1
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
raid6: int64x1   2066 MB/s
raid6: int64x2   2785 MB/s
raid6: int64x4   2683 MB/s
raid6: int64x8   1800 MB/s
raid6: sse2x1    2269 MB/s
raid6: sse2x2    3285 MB/s
raid6: sse2x4    3824 MB/s
raid6: using algorithm sse2x4 (3824 MB/s)
md: raid6 personality registered for level 6
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
raid5: automatically using best checksumming function: generic_sse
   generic_sse:  7064.000 MB/sec
raid5: using function: generic_sse (7064.000 MB/sec)
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
NET: Registered protocol family 8
NET: Registered protocol family 20
powernow-k8: Found 1 AMD Athlon(tm) 64 Processor 3700+ processors (version 2.00.00)
powernow-k8:    0 : fid 0x2 (1000 MHz), vid 0x12
powernow-k8:    1 : fid 0xa (1800 MHz), vid 0xa
powernow-k8:    2 : fid 0xc (2000 MHz), vid 0x8
powernow-k8:    3 : fid 0xe (2200 MHz), vid 0x6
ACPI: (supports S0 S1 S3 S4 S5)
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
logips2pp: Detected unknown logitech mouse model 1
input: ImPS/2 Logitech Wheel Mouse as /class/input/input2
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdh1 ...
md:  adding sdh1 ...
md:  adding sdg1 ...
md:  adding sdf1 ...
md:  adding sde1 ...
md:  adding sdd1 ...
md:  adding sdc1 ...
md:  adding sdb1 ...
md:  adding sda1 ...
md: hdc9 has different UUID to sdh1
md: hdc8 has different UUID to sdh1
md: hdc7 has different UUID to sdh1
md: hdc6 has different UUID to sdh1
md: hdc5 has different UUID to sdh1
md: hda9 has different UUID to sdh1
md: hda8 has different UUID to sdh1
md: hda7 has different UUID to sdh1
md: hda6 has different UUID to sdh1
md: hda5 has different UUID to sdh1
md: created md0
md: bind<sda1>
md: bind<sdb1>
md: bind<sdc1>
md: bind<sdd1>
md: bind<sde1>
md: bind<sdf1>
md: bind<sdg1>
md: bind<sdh1>
md: running: <sdh1><sdg1><sdf1><sde1><sdd1><sdc1><sdb1><sda1>
raid5: device sdh1 operational as raid disk 1
raid5: device sdg1 operational as raid disk 0
raid5: device sdf1 operational as raid disk 5
raid5: device sde1 operational as raid disk 6
raid5: device sdd1 operational as raid disk 7
raid5: device sdc1 operational as raid disk 3
raid5: device sdb1 operational as raid disk 2
raid5: device sda1 operational as raid disk 4
raid5: allocated 8462kB for md0
raid5: raid level 6 set md0 active with 8 out of 8 devices, algorithm 2
RAID5 conf printout:
 --- rd:8 wd:8
 disk 0, o:1, dev:sdg1
 disk 1, o:1, dev:sdh1
 disk 2, o:1, dev:sdb1
 disk 3, o:1, dev:sdc1
 disk 4, o:1, dev:sda1
 disk 5, o:1, dev:sdf1
 disk 6, o:1, dev:sde1
 disk 7, o:1, dev:sdd1
md0: bitmap initialized from disk: read 15/15 pages, set 1 bits, status: 0
created bitmap (233 pages) for device md0
md: considering hdc9 ...
md:  adding hdc9 ...
md: hdc8 has different UUID to hdc9
md: hdc7 has different UUID to hdc9
md: hdc6 has different UUID to hdc9
md: hdc5 has different UUID to hdc9
md:  adding hda9 ...
md: hda8 has different UUID to hdc9
md: hda7 has different UUID to hdc9
md: hda6 has different UUID to hdc9
md: hda5 has different UUID to hdc9
md: created md4
md: bind<hda9>
md: bind<hdc9>
md: running: <hdc9><hda9>
raid1: raid set md4 active with 2 out of 2 mirrors
md4: bitmap initialized from disk: read 10/10 pages, set 3 bits, status: 0
created bitmap (156 pages) for device md4
md: considering hdc8 ...
md:  adding hdc8 ...
md: hdc7 has different UUID to hdc8
md: hdc6 has different UUID to hdc8
md: hdc5 has different UUID to hdc8
md:  adding hda8 ...
md: hda7 has different UUID to hdc8
md: hda6 has different UUID to hdc8
md: hda5 has different UUID to hdc8
md: created md3
md: bind<hda8>
md: bind<hdc8>
md: running: <hdc8><hda8>
raid1: raid set md3 active with 2 out of 2 mirrors
md3: bitmap initialized from disk: read 8/8 pages, set 5 bits, status: 0
created bitmap (123 pages) for device md3
md: considering hdc7 ...
md:  adding hdc7 ...
md: hdc6 has different UUID to hdc7
md: hdc5 has different UUID to hdc7
md:  adding hda7 ...
md: hda6 has different UUID to hdc7
md: hda5 has different UUID to hdc7
md: created md2
md: bind<hda7>
md: bind<hdc7>
md: running: <hdc7><hda7>
raid1: raid set md2 active with 2 out of 2 mirrors
md2: bitmap initialized from disk: read 8/8 pages, set 87 bits, status: 0
created bitmap (123 pages) for device md2
md: considering hdc6 ...
md:  adding hdc6 ...
md: hdc5 has different UUID to hdc6
md:  adding hda6 ...
md: hda5 has different UUID to hdc6
md: created md1
md: bind<hda6>
md: bind<hdc6>
md: running: <hdc6><hda6>
raid1: raid set md1 active with 2 out of 2 mirrors
md1: bitmap initialized from disk: read 12/12 pages, set 54 bits, status: 0
created bitmap (184 pages) for device md1
md: considering hdc5 ...
md:  adding hdc5 ...
md:  adding hda5 ...
md: created md5
md: bind<hda5>
md: bind<hdc5>
md: running: <hdc5><hda5>
raid1: raid set md5 active with 2 out of 2 mirrors
md5: bitmap initialized from disk: read 9/9 pages, set 0 bits, status: 0
created bitmap (129 pages) for device md5
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 232k freed
hdb: Speed warnings UDMA 3/4/5 is not functional.
Adding 4200888k swap on /dev/md5.  Priority:-1 extents:1 across:4200888k
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on md2, internal journal
3b9aca0000000000,d2ea237f00000000,d2ea237f00000000,35fe7fdef9db22
u: 3538559.870999, 0.0000
3b9aca0000000000,d2ea237f00000000,d2ea237f00000000,35fe7fdef9db22
u: 3538559.870999, 0.0000
i2c_adapter i2c-3: nForce2 SMBus adapter at 0x4c00
i2c_adapter i2c-4: nForce2 SMBus adapter at 0x4c40
it87: Found IT8712F chip at 0x290, revision 7
it87-isa 9191-0290: Detected broken BIOS defaults, disabling PWM interface
ACPI: PCI Interrupt 0000:05:08.0[A] -> Link [APC3] -> GSI 18 (level, low) -> IRQ 18
Installing spdif_bug patch: Audigy 2 ZS [2001]
3b9aca0000000000,d2ea237f00000000,d2ea237f00000000,35fe7fdef9db22
u: 3538559.870999, 0.0000
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on md1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ReiserFS: md4: found reiserfs format "3.6" with standard journal
ReiserFS: md4: using ordered data mode
reiserfs: using flush barriers
ReiserFS: md4: journal params: device md4, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: md4: checking transaction log (md4)
ReiserFS: md4: Using r5 hash to sort names
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ReiserFS: hde1: found reiserfs format "3.6" with standard journal
ReiserFS: hde1: using ordered data mode
reiserfs: using flush barriers
ReiserFS: hde1: journal params: device hde1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hde1: checking transaction log (hde1)
ReiserFS: hde1: Using r5 hash to sort names
ReiserFS: sde2: found reiserfs format "3.6" with standard journal
ReiserFS: sde2: using ordered data mode
reiserfs: using flush barriers
ReiserFS: sde2: journal params: device sde2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sde2: checking transaction log (sde2)
ReiserFS: sde2: Using r5 hash to sort names
ReiserFS: sdg2: found reiserfs format "3.6" with standard journal
ReiserFS: sdg2: using ordered data mode
reiserfs: using flush barriers
ReiserFS: sdg2: journal params: device sdg2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sdg2: checking transaction log (sdg2)
ReiserFS: sdg2: Using r5 hash to sort names
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdi1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ip_tables: (C) 2000-2006 Netfilter Core Team
switch: Setting full-duplex based on MII#1 link partner capability of cde1.
ip_conntrack version 2.4 (8192 buckets, 65536 max) - 304 bytes per conntrack
3b9aca0000000000,d2ea237f00000000,d2ea237f00000000,35fe7fdef9db22
u: 3538559.870999, 0.0000
3b9aca0000000000,d2ea237f00000000,d2ea237f00000000,35fe7fdef9db22
u: 3538559.870999, 0.0000
switch: no IPv6 routers present
adsl: no IPv6 routers present
-- 
"I see!" said the blind man as he picked up his hammer and saw.
Debian (Unstable) GNU/Linux 2.6.18-rc4-mm2 4423 bogomips load 0.39
