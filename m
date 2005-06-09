Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262503AbVFIWju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262503AbVFIWju (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 18:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbVFIWjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 18:39:41 -0400
Received: from umbar.esa.informatik.tu-darmstadt.de ([130.83.163.30]:19328
	"EHLO umbar.esa.informatik.tu-darmstadt.de") by vger.kernel.org
	with ESMTP id S262502AbVFIWig (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 18:38:36 -0400
Date: Fri, 10 Jun 2005 00:38:35 +0200
From: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>
To: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: PROBLEM: Devices behind PCI Express-to-PCI bridge not mapped
Message-ID: <20050609223835.GB26023@erebor.esa.informatik.tu-darmstadt.de>
References: <Pine.LNX.4.58.0506032149130.1876@ppc970.osdl.org> <20050604155742.GA14384@erebor.esa.informatik.tu-darmstadt.de> <20050605204645.A28422@jurassic.park.msu.ru> <20050606002739.GA943@erebor.esa.informatik.tu-darmstadt.de> <20050606184335.A30338@jurassic.park.msu.ru> <20050608173409.GA32004@erebor.esa.informatik.tu-darmstadt.de> <20050609023639.A7067@jurassic.park.msu.ru> <1118289850.6850.164.camel@gaston> <20050609175441.C9187@jurassic.park.msu.ru> <20050609175429.GA26023@erebor.esa.informatik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050609175429.GA26023@erebor.esa.informatik.tu-darmstadt.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did some more experimentation, and to my great the surprise, the
serial port on the dock _is_ functioning, even when the rest of the
dock is dead. So, I managed to capture a full log using the serial
console. I sure hope that we can get to the bottom of this now :-)

Andreas


Linux version 2.6.12-rc5 (root@grima) (gcc version 3.3.5-20050130 (Gentoo Linux 3.3.5.20050130-r1, ssp-3.3.5.20050130-1, pie-8.7.7.1)) #24 Fri Jun 10 00:25:07 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ce000 - 00000000000d0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fe80000 (usable)
 BIOS-e820: 000000007fe80000 - 000000007fe89000 (ACPI data)
 BIOS-e820: 000000007fe89000 - 000000007ff00000 (ACPI NVS)
 BIOS-e820: 000000007ff00000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0006000 (reserved)
 BIOS-e820: 00000000f0008000 - 00000000f000c000 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000fed90000 (reserved)
 BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
1150MB HIGHMEM available.
896MB LOWMEM available.
DMI present.
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:13 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x02] address[0xfec20000] gsi_base[24])
IOAPIC[1]: apic_id 2, version 32, address 0xfec20000, GSI 24-47
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Enabling APIC mode:  Flat.  Using 2 I/O APICs
ACPI: HPET id: 0x8086a201 base: 0x0
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 80000000 (gap: 80000000:60000000)
Built 1 zonelists
Kernel command line: root=/dev/ram0 lvm2root=/dev/vg0/root console=ttyS00
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 1995.600 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2069340k/2095616k available (3366k kernel code, 24980k reserved, 1541k data, 220k init, 1178112k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Mount-cache hash table entries: 512
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 2.00GHz stepping 08
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 2061k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd6ce, last bus=8
PCI: Using MMCONFIG
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
    ACPI-0352: *** Error: Looking up [Z00G] in namespace, AE_NOT_FOUND
search_node c20da160 start_node c20da160 return_node 00000000
    ACPI-0352: *** Error: Looking up [Z00G] in namespace, AE_NOT_FOUND
search_node c20dada0 start_node c20dada0 return_node 00000000
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12 14 15<7>Losing some ticks... checking if CPU frequency changed.
) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs<7>Losing some ticks... checking if CPU frequency changed.
 1 3 4 5 6 7 *11 12 14 15)
ACPI: Embedded Controller [EC0] (gpe 29)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
SCSI subsystem initialized
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Cannot allocate resource region 10 of bridge 0000:00:01.0
PCI: Cannot allocate resource region 7 of bridge 0000:00:1c.0
PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.0
PCI: Cannot allocate resource region 9 of bridge 0000:00:1c.0
PCI: Cannot allocate resource region 10 of bridge 0000:00:1c.0
PCI: Cannot allocate resource region 7 of bridge 0000:00:1c.1
PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.1
PCI: Cannot allocate resource region 9 of bridge 0000:00:1c.1
PCI: Cannot allocate resource region 10 of bridge 0000:00:1c.1
PCI: Cannot allocate resource region 7 of bridge 0000:00:1c.2
PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.2
PCI: Cannot allocate resource region 9 of bridge 0000:00:1c.2
PCI: Cannot allocate resource region 10 of bridge 0000:00:1c.2
PCI: Cannot allocate resource region 7 of bridge 0000:02:00.0
PCI: Cannot allocate resource region 8 of bridge 0000:02:00.0
PCI: Cannot allocate resource region 9 of bridge 0000:02:00.0
PCI: Cannot allocate resource region 10 of bridge 0000:02:00.0
PCI: Cannot allocate resource region 7 of bridge 0000:03:05.0
PCI: Cannot allocate resource region 8 of bridge 0000:03:05.0
PCI: Cannot allocate resource region 9 of bridge 0000:03:05.0
PCI: Cannot allocate resource region 10 of bridge 0000:03:05.0
PCI: Cannot allocate resource region 7 of bridge 0000:00:1e.0
PCI: Cannot allocate resource region 8 of bridge 0000:00:1e.0
PCI: Cannot allocate resource region 9 of bridge 0000:00:1e.0
PCI: Cannot allocate resource region 10 of bridge 0000:00:1e.0
PCI: Cannot allocate resource region 7 of bridge 0000:06:09.0
PCI: Cannot allocate resource region 8 of bridge 0000:06:09.0
PCI: Cannot allocate resource region 9 of bridge 0000:06:09.0
PCI: Cannot allocate resource region 10 of bridge 0000:06:09.0
PCI: Cannot allocate resource region 7 of bridge 0000:06:09.1
PCI: Cannot allocate resource region 8 of bridge 0000:06:09.1
PCI: Cannot allocate resource region 9 of bridge 0000:06:09.1
PCI: Cannot allocate resource region 10 of bridge 0000:06:09.1
PCI: Cannot allocate resource region 7 of bridge 0000:06:09.3
PCI: Cannot allocate resource region 8 of bridge 0000:06:09.3
PCI: Cannot allocate resource region 9 of bridge 0000:06:09.3
PCI: Cannot allocate resource region 10 of bridge 0000:06:09.3
PCI: Cannot allocate resource region 4 of device 0000:03:02.0
PCI: Cannot allocate resource region 4 of device 0000:03:02.1
PCI: Cannot allocate resource region 0 of device 0000:03:02.2
PCI: Cannot allocate resource region 4 of device 0000:03:03.0
PCI: Cannot allocate resource region 4 of device 0000:03:03.1
PCI: Cannot allocate resource region 0 of device 0000:03:03.2
PCI: Cannot allocate resource region 0 of device 0000:03:04.0
PCI: Cannot allocate resource region 1 of device 0000:03:04.0
PCI: Cannot allocate resource region 0 of device 0000:03:05.0
PCI: Cannot allocate resource region 0 of device 0000:03:06.0
PCI: Ignore bogus resource 7 [0:0] of 0000:00:1e.0
PCI: Ignore bogus resource 8 [0:0] of 0000:00:1e.0
PCI: Ignore bogus resource 9 [0:0] of 0000:00:1e.0
PCI: Bridge: 0000:00:01.0
  IO window: 2000-2fff
  MEM window: c8100000-c81fffff
  PREFETCH window: d0000000-d7ffffff
PCI: Bridge: 0000:00:1c.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.1
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bus 4, cardbus bridge: 0000:03:05.0
  IO window: 00003000-00003fff
  IO window: 00004000-00004fff
  PREFETCH window: 80000000-81ffffff
  MEM window: 82000000-83ffffff
PCI: Bridge: 0000:02:00.0
  IO window: 3000-5fff
  MEM window: 82000000-84ffffff
  PREFETCH window: 80000000-81ffffff
PCI: Bridge: 0000:00:1c.2
  IO window: 3000-5fff
  MEM window: 82000000-84ffffff
  PREFETCH window: 80000000-81ffffff
PCI: Bus 7, cardbus bridge: 0000:06:09.0
  IO window: 00006000-00006fff
  IO window: 00007000-00007fff
  PREFETCH window: 86000000-87ffffff
  MEM window: 88000000-89ffffff
PCI: Bus 11, cardbus bridge: 0000:06:09.1
  IO window: 00008000-00008fff
  IO window: 00009000-00009fff
  PREFETCH window: 8a000000-8bffffff
  MEM window: 8c000000-8dffffff
PCI: Bus 15, cardbus bridge: 0000:06:09.3
  IO window: 0000a000-0000afff
  IO window: 0000b000-0000bfff
  PREFETCH window: 8e000000-8fffffff
  MEM window: 90000000-91ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI Interrupt 0000:03:05.0[A] -> GSI 31 (level, low) -> IRQ 31
ACPI: PCI Interrupt 0000:06:09.0[A] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI Interrupt 0000:06:09.1[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Enabling device 0000:06:09.3 (0080 -> 0082)
ACPI: PCI Interrupt 0000:06:09.3[A] -> GSI 18 (level, low) -> IRQ 18
Simple Boot Flag at 0x36 set to 0x1
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1118356439.954:0): initialized
highmem bounce pool size: 64 pages
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.22 [Flags: R/O].
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
pciehp: add_host_bridge: status 5
pciehp: Fails to gain control of native hot-plug
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
assign_interrupt_mode Found MSI capability
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 17
assign_interrupt_mode Found MSI capability
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 16
assign_interrupt_mode Found MSI capability
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 18
assign_interrupt_mode Found MSI capability
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Battery Slot [BAT2] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Thermal Zone [THRM] (60 C)
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ACPI: PCI Interrupt 0000:03:06.0[A] -> GSI 32 (level, low) -> IRQ 32
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP(,...)]
lp0: using parport0 (interrupt-driven).
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
tg3.c:v3.29 (May 23, 2005)
ACPI: PCI Interrupt 0000:06:06.0[A] -> GSI 16 (level, low) -> IRQ 16
eth0: Tigon3 [partno(BCM95788A50) rev 3003 PHY(5705)] (PCI:33MHz:32-bit) 10/100/1000BaseT Ethernet 00:c0:9f:75:57:33
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[0] TSOcap[1] 
eth0: dma_rwctrl[763f0000]
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
ahci: probe of 0000:00:1f.2 failed with error -12
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x18A0 irq 14
ata1: dev 0 ATA, max UDMA/100, 195371568 sectors: lba48
ata1: dev 0 configured for UDMA/100
scsi0 : ata_piix
  Vendor: ATA       Model: ST9100823A        Rev: 3.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x18A8 irq 15
ata2: dev 0 ATAPI, max UDMA/33
ata2: dev 0 configured for UDMA/33
scsi1 : ata_piix
  Vendor: HL-DT-ST  Model: DVDRAM GMA-4080N  Rev: 0H35
  Type:   CD-ROM                             ANSI SCSI revision: 05
SCSI device sda: 195371568 512-byte hdwr sectors (100030 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 195371568 512-byte hdwr sectors (100030 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 5
ohci1394: $Rev: 1250 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt 0000:03:04.0[A] -> GSI 30 (level, low) -> IRQ 30
ohci1394: fw-host0: Remapped memory spaces reg 0xf8834000
ohci1394: fw-host0: Soft reset finished
ohci1394: fw-host0: Iso contexts reg: 000000a8 implemented: ffffffff
ohci1394: fw-host0: 32 iso receive contexts available
ohci1394: fw-host0: Iso contexts reg: 00000098 implemented: ffffffff
ohci1394: fw-host0: 32 iso transmit contexts available
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Runaway loop while stopping context: ...
ohci1394: fw-host0: Receive DMA ctx=0 initialized
ohci1394: fw-host0: Runaway loop while stopping context: ...
ohci1394: fw-host0: Receive DMA ctx=0 initialized
ohci1394: fw-host0: Runaway loop while stopping context: ...
ohci1394: fw-host0: Transmit DMA ctx=0 initialized
ohci1394: fw-host0: Runaway loop while stopping context: ...
ohci1394: fw-host0: Transmit DMA ctx=1 initialized
ohci1394: fw-host0: OHCI-1394 165.165 (PCI): IRQ=[30]  MMIO=[84005000-840057ff]  Max Packet=[65536]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ACPI: PCI Interrupt 0000:06:07.0[A] -> GSI 19 (level, low) -> IRQ 19
ohci1394: fw-host1: Remapped memory spaces reg 0xf8846000
ohci1394: fw-host1: Soft reset finished
ohci1394: fw-host1: Iso contexts reg: 000000a8 implemented: 0000000f
ohci1394: fw-host1: 4 iso receive contexts available
ohci1394: fw-host1: Iso contexts reg: 00000098 implemented: 000000ff
ohci1394: fw-host1: 8 iso transmit contexts available
ohci1394: fw-host1: Receive DMA ctx=0 initialized
ohci1394: fw-host1: Receive DMA ctx=0 initialized
ohci1394: fw-host1: Transmit DMA ctx=0 initialized
ohci1394: fw-host1: Transmit DMA ctx=1 initialized
ohci1394: fw-host1: OHCI-1394 1.1 (PCI): IRQ=[19]  MMIO=[c8415000-c84157ff]  Max Packet=[2048]
ieee1394: raw1394: /dev/raw1394 device initialized
sbp2: $Rev: 1219 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt 0000:03:05.0[A] -> GSI 31 (level, low) -> IRQ 31
Yenta: CardBus bridge found at 0000:03:05.0 [104c:ac50]
yenta 0000:03:05.0: Preassigned resource 0 busy, reconfiguring...
yenta 0000:03:05.0: no resource of type 1200 available, trying to continue...
yenta 0000:03:05.0: Preassigned resource 1 busy, reconfiguring...
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:03:05.0, mfunc 0x00521d22, devctl 0x66
Yenta TI: socket 0000:03:05.0 probing PCI interrupt failed, trying to fix
Yenta TI: socket 0000:03:05.0 falling back to parallel PCI interrupts
ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
ohci1394: fw-host1: IntEvent: 00020010
ohci1394: fw-host1: irq_handler: Bus reset requested
ohci1394: fw-host1: Cancel request received
ohci1394: fw-host1: Got RQPkt interrupt status=0x00008409
ohci1394: fw-host1: IntEvent: 00010000
ohci1394: fw-host1: SelfID interrupt received (phyid 0, root)
ohci1394: fw-host1: SelfID packet 0x807f8842 received
ohci1394: fw-host1: SelfID for this node is 0x807f8842
ohci1394: fw-host1: SelfID complete
ohci1394: fw-host1: PhyReqFilter=ffffffffffffffff
ohci1394: fw-host1: Single packet rcv'd
Yenta TI: socket 0000:03:05.0 no PCI interrupts. Fish. Please report.
Yenta: ISA IRQ mask 0x0000, PCI irq 0
Socket status: ffffffff
ACPI: PCI Interrupt 0000:06:09.0[A] -> GSI 18 (level, low) -> IRQ 18
Yenta: CardBus bridge found at 0000:06:09.0 [1025:0070]
yenta 0000:06:09.0: Preassigned resource 0 busy, reconfiguring...
yenta 0000:06:09.0: Preassigned resource 1 busy, reconfiguring...
Yenta O2: res at 0x94/0xD4: ea/00
Yenta O2: enabling read prefetch/write burst
Yenta: ISA IRQ mask 0x0438, PCI irq 18
Socket status: 30000006
ohci1394: fw-host1: Inserting packet for node 1-63:1023, tlabel=0, tcode=0x0, speed=0
ohci1394: fw-host1: Starting transmit DMA ctx=0
ohci1394: fw-host1: IntEvent: 00000001
ohci1394: fw-host1: Got reqTxComplete interrupt status=0x00008011
ohci1394: fw-host1: Packet sent to node 63 tcode=0x0 tLabel=0 ack=0x11 spd=0 data=0x1F0000C0 ctx=0
ACPI: PCI Interrupt 0000:06:09.1[A] -> GSI 18 (level, low) -> IRQ 18

