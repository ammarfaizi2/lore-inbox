Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbVFJUuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVFJUuS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 16:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVFJUuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 16:50:18 -0400
Received: from postman1.arcor-online.net ([151.189.20.156]:36738 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S261228AbVFJUsI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 16:48:08 -0400
From: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: PROBLEM: Devices behind PCI Express-to-PCI bridge not mapped
Date: Fri, 10 Jun 2005 22:47:29 +0200
User-Agent: KMail/1.7.2
Cc: Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       gregkh@suse.de
References: <20050605204645.A28422@jurassic.park.msu.ru> <Pine.LNX.4.58.0506091617130.2286@ppc970.osdl.org> <20050610184815.A13999@jurassic.park.msu.ru>
In-Reply-To: <20050610184815.A13999@jurassic.park.msu.ru>
Organization: Embedded Systems and Applications Group, Tech. Univ. Darmstadt, Germany
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506102247.30842.koch@esa.informatik.tu-darmstadt.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 June 2005 16:48, Ivan Kokshaysky wrote:
> I'm still not sure if it boots though...

It does :-))

And the devices on the dock appear to be working, too! I could only test the 
USB ports (my wife has currently taken posession of our FireWire MP3 player), 
but according to the attached log, the mappings look sensible.
If you'd like me to perform other tests, let me know.

As an aside, hotplugging the dock doesn't work, even though I have compiled in 
pciehp and shpchp: /sys/bus/pci/slots/ stays empty. The same with the ACPI 
hotplug driver. I do get some messages during boot.

...
Evaluate _OSC Set fails. Status = 0x0005
pciehp: add_host_bridge: status 5
pciehp: Fails to gain control of native hot-plug
...

When I attach the device, nothing happens in dmesg.

In my daily usage, that's fine (I didn't plan on hotplugging the dock anyway). 
But if you want me to run more tests and try other patches on that aspect, 
I'm game.

Many thanks for the quick help to all of you!

  Andreas


Linux version 2.6.12-rc6 (root@grima) (gcc version 3.3.5-20050130 (Gentoo 
Linux 3.3.5.20050130-r1, ssp-3.3.5.20050130-1, pie-8.7.7.1)) #1 Fri Jun 10 
21:52:03 CEST 2005
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
Kernel command line: root=/dev/ram0 lvm2root=/dev/vg0/root console=ttyS0
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 1995.039 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2069332k/2095616k available (3372k kernel code, 24988k reserved, 1544k 
data, 220k init, 1178112k highmem)
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
checking if image is initramfs...it isn't (no cpio magic); looks like an 
initrd
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
ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 *11 12 14 15)
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
PCI: Cannot allocate resource region 7 of bridge 0000:00:1c.0
PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.0
PCI: Cannot allocate resource region 9 of bridge 0000:00:1c.0
PCI: Cannot allocate resource region 7 of bridge 0000:00:1c.1
PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.1
PCI: Cannot allocate resource region 9 of bridge 0000:00:1c.1
PCI: Cannot allocate resource region 7 of bridge 0000:00:1c.2
PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.2
PCI: Cannot allocate resource region 9 of bridge 0000:00:1c.2
PCI: Cannot allocate resource region 7 of bridge 0000:02:00.0
PCI: Cannot allocate resource region 8 of bridge 0000:02:00.0
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
  MEM window: 88000000-89ffffff
PCI: Bridge: 0000:02:00.0
  IO window: 3000-5fff
  MEM window: 88000000-8affffff
  PREFETCH window: 80000000-81ffffff
PCI: Bridge: 0000:00:1c.2
  IO window: 3000-5fff
  MEM window: 88000000-8affffff
  PREFETCH window: 80000000-81ffffff
PCI: Bus 7, cardbus bridge: 0000:06:09.0
  IO window: 00006000-00006fff
  IO window: 00007000-00007fff
  PREFETCH window: 82000000-83ffffff
  MEM window: 8c000000-8dffffff
PCI: Bus 11, cardbus bridge: 0000:06:09.1
  IO window: 00008000-00008fff
  IO window: 00009000-00009fff
  PREFETCH window: 84000000-85ffffff
  MEM window: 8e000000-8fffffff
PCI: Bus 15, cardbus bridge: 0000:06:09.3
  IO window: 0000a000-0000afff
  IO window: 0000b000-0000bfff
  PREFETCH window: 86000000-87ffffff
  MEM window: 90000000-91ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 6000-bfff
  MEM window: c8400000-c84fffff
  PREFETCH window: 82000000-87ffffff
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Device 0000:00:1c.0 not available because of resource collisions
PCI: Device 0000:00:1c.1 not available because of resource collisions
PCI: Enabling device 0000:00:1c.2 (0000 -> 0003)
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI Interrupt 0000:03:05.0[A] -> GSI 31 (level, low) -> IRQ 31
ACPI: PCI Interrupt 0000:06:09.0[A] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI Interrupt 0000:06:09.1[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Enabling device 0000:06:09.3 (0080 -> 0083)
ACPI: PCI Interrupt 0000:06:09.3[A] -> GSI 18 (level, low) -> IRQ 18
Simple Boot Flag at 0x36 set to 0x1
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1118433907.573:0): initialized
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
PCI: Device 0000:00:1c.0 not available because of resource collisions
PCI: Device 0000:00:1c.1 not available because of resource collisions
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
ACPI: Thermal Zone [THRM] (59 C)
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
parpor t: PnPBIOS parpt0: PC-style at 0x378 (0x778), irq 7 [PCSPP(,...)]
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
eth0: Tigon3 [partno(BCM95788A50) rev 3003 PHY(5705)] (PCI:33MHz:32-bit) 
10/100/1000BaseT Ethernet 00:c0:9f:75:57:33
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
ohci1394: fw-host0: Iso contexts reg: 000000a8 implemented: 0000000f
ohci1394: fw-host0: 4 iso receive contexts available
ohci1394: fw-host0: Iso contexts reg: 00000098 implemented: 000000ff
ohci1394: fw-host0: 8 iso transmit contexts available
ohci1394: fw-host0: Receive DMA ctx=0 initialized
ohci1394: fw-host0: Receive DMA ctx=0 initialized
ohci1394: fw-host0: Transmit DMA ctx=0 initialized
ohci1394: fw-host0: Transmit DMA ctx=1 initialized
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[30]  MMIO=[8a005000-8a0057ff]  
Max Packet=[2048]
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
ohci1394: fw-host1: OHCI-1394 1.1 (PCI): IRQ=[19]  MMIO=[c8415000-c84157ff]  
Max Packet=[2048]
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
Yenta: ISA IRQ mask 0x0000, PCI irq 31
Socket status: 30000006
ohci1394: fw-host0: IntEvent: 00020010
ohci1394: fw-host0: irq_handler: Bus reset requested
ohci1394: fw-host0: Cancel request received
ohci1394: fw-host0: Got RQPkt interrupt status=0x00008409
ohci1394: fw-host0: IntEvent: 00010000
ohci1394: fw-host0: SelfID interrupt received (phyid 0, root)
ohci1394: fw-host0: SelfID packet 0x807f8a52 received
ohci1394: fw-host0: SelfID for this node is 0x807f8a52
ohci1394: fw-host0: SelfID complete
ohci1394: fw-host0: PhyReqFilter=ffffffffffffffff
ohci1394: fw-host0: Single packet rcv'd
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
ACPI: PCI Interrupt 0000:06:09.0[A] -> GSI 18 (level, low) -> IRQ 18
Yenta: CardBus bridge found at 0000:06:09.0 [1025:0070]
yenta 0000:06:09.0: Preassigned resource 0 busy, reconfiguring...
yenta 0000:06:09.0: no resource of type 1200 available, trying to continue...
yenta 0000:06:09.0: Preassigned resource 1 busy, reconfiguring...
Yenta O2: res at 0x94/0xD4: ea/00
Yenta O2: enabling read prefetch/write burst
Yenta: ISA IRQ mask 0x0438, PCI irq 18
Socket status: 30000006
ohci1394: fw-host0: Inserting packet for node 0-63:1023, tlabel=0, tcode=0x0, 
speed=0
ohci1394: fw-host0: Starting transmit DMA ctx=0
ohci1394: fw-host0: IntEvent: 00000001
ohci1394: fw-host0: Got reqTxComplete interrupt status=0x00008011
ohci1394: fw-host0: Packet sent to node 63 tcode=0x0 tLabel=0 ack=0x11 spd=0 
data=0x1F0000C0 ctx=0
ACPI: PCI Interrupt 0000:06:09.1[A] -> GSI 18 (level, low) -> IRQ 18
Yenta: CardBus bridge found at 0000:06:09.1 [1025:0070]
yenta 0000:06:09.1: Preassigned resource 1 busy, reconfiguring...
Yenta: ISA IRQ mask 0x0438, PCI irq 18
Socket status: 30000006
ACPI: PCI Interrupt 0000:06:09.3[A] -> GSI 18 (level, low) -> IRQ 18
Yenta: CardBus bridge found at 0000:06:09.3 [1025:0070]
yenta 0000:06:09.3: Preassigned resource 1 busy, reconfiguring...
Yenta: ISA IRQ mask 0x0438, PCI irq 18
Socket status: 30000410
ohci1394: fw-host1: Inserting packet for node 1-63:1023, tlabel=0, tcode=0x0, 
speed=0
ohci1394: fw-host1: Starting transmit DMA ctx=0
ohci1394: fw-host1: IntEvent: 00000001
ohci1394: fw-host1: Got reqTxComplete interrupt status=0x00008011
ohci1394: fw-host1: Packet sent to node 63 tcode=0x0 tLabel=0 ack=0x11 spd=0 
data=0x1F0000C0 ctx=0
usbmon: debugs is not available
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:1d.7: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB2 EHCI Controller
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 23, io mem 0xc8004000
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
usb usb1: Product: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 
EHCI Controller
usb usb1: Manufacturer: Linux 2.6.12-rc6 ehci_hcd
usb usb1: SerialNumber: 0000:00:1d.7
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ACPI: PCI Interrupt 0000:03:02.2[C] -> GSI 26 (level, low) -> IRQ 26
ehci_hcd 0000:03:02.2: VIA Technologies, Inc. USB 2.0
ehci_hcd 0000:03:02.2: new USB bus registered, assigned bus number 2
ehci_hcd 0000:03:02.2: irq 26, io mem 0x8a005800
ehci_hcd 0000:03:02.2: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
usb usb2: Product: VIA Technologies, Inc. USB 2.0
usb usb2: Manufacturer: Linux 2.6.12-rc6 ehci_hcd
usb usb2: SerialNumber: 0000:03:02.2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 4 ports detected
ACPI: PCI Interrupt 0000:03:03.2[C] -> GSI 29 (level, low) -> IRQ 29
ehci_hcd 0000:03:03.2: VIA Technologies, Inc. USB 2.0 (#2)
ehci_hcd 0000:03:03.2: new USB bus registered, assigned bus number 3
ehci_hcd 0000:03:03.2: irq 29, io mem 0x8a005900
ehci_hcd 0000:03:03.2: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
usb usb3: Product: VIA Technologies, Inc. USB 2.0 (#2)
usb usb3: Manufacturer: Linux 2.6.12-rc6 ehci_hcd
usb usb3: SerialNumber: 0000:03:03.2
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 4 ports detected
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 23
uhci_hcd 0000:00:1d.0: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB UHCI #1
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.0: irq 23, io base 0x00001800
uhci_hcd 0000:00:1d.0: detected 2 ports
usb usb4: Product: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB 
UHCI #1
usb usb4: Manufacturer: Linux 2.6.12-rc6 uhci_hcd
usb usb4: SerialNumber: 0000:00:1d.0
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
uhci_hcd 0000:00:1d.1: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB UHCI #2
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.1: irq 19, io base 0x00001820
uhci_hcd 0000:00:1d.1: detected 2 ports
usb usb5: Product: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB 
UHCI #2
usb usb5: Manufacturer: Linux 2.6.12-rc6 uhci_hcd
usb usb5: SerialNumber: 0000:00:1d.1
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
uhci_hcd 0000:00:1d.2: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB UHCI #3
usb 4-2: new full speed USB device using uhci_hcd and address 2
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 6
uhci_hcd 0000:00:1d.2: irq 18, io base 0x00001840
uhci_hcd 0000:00:1d.2: detected 2 ports
usb usb6: Product: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB 
UHCI #3
usb usb6: Manufacturer: Linux 2.6.12-rc6 uhci_hcd
usb usb6: SerialNumber: 0000:00:1d.2
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1d.3: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB UHCI #4
usb 4-2: Product: USB Audio
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 7
uhci_hcd 0000:00:1d.3: irq 16, io base 0x00001860
uhci_hcd 0000:00:1d.3: detected 2 ports
usb usb7: Product: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB 
UHCI #4
usb usb7: Manufacturer: Linux 2.6.12-rc6 uhci_hcd
usb usb7: SerialNumber: 0000:00:1d.3
hub 7-0:1.0: USB hub found
hub 7-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:03:02.0[A] -> GSI 24 (level, low) -> IRQ 24
uhci_hcd 0000:03:02.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller
uhci_hcd 0000:03:02.0: new USB bus registered, assigned bus number 8
uhci_hcd 0000:03:02.0: irq 24, io base 0x00005040
uhci_hcd 0000:03:02.0: detected 2 ports
usb usb8: Product: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
usb usb8: Manufacturer: Linux 2.6.12-rc6 uhci_hcd
usb usb8: SerialNumber: 0000:03:02.0
hub 8-0:1.0: USB hub found
hub 8-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:03:02.1[B] -> GSI 25 (level, low) -> IRQ 25
uhci_hcd 0000:03:02.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (#2)
uhci_hcd 0000:03:02.1: new USB bus registered, assigned bus number 9
uhci_hcd 0000:03:02.1: irq 25, io base 0x00005060
uhci_hcd 0000:03:02.1: detected 2 ports
usb usb9: Product: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller 
(#2)
usb usb9: Manufacturer: Linux 2.6.12-rc6 uhci_hcd
usb usb9: SerialNumber: 0000:03:02.1
hub 9-0:1.0: USB hub found
hub 9-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:03:03.0[A] -> GSI 27 (level, low) -> IRQ 27
uhci_hcd 0000:03:03.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (#3)
uhci_hcd 0000:03:03.0: new USB bus registered, assigned bus number 10
uhci_hcd 0000:03:03.0: irq 27, io base 0x00005080
uhci_hcd 0000:03:03.0: detected 2 ports
usb usb10: Product: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller 
(#3)
usb usb10: Manufacturer: Linux 2.6.12-rc6 uhci_hcd
usb usb10: SerialNumber: 0000:03:03.0
hub 10-0:1.0: USB hub found
hub 10-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:03:03.1[B] -> GSI 28 (level, low) -> IRQ 28
uhci_hcd 0000:03:03.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (#4)
uhci_hcd 0000:03:03.1: new USB bus registered, assigned bus number 11
uhci_hcd 0000:03:03.1: irq 28, io base 0x000050a0
uhci_hcd 0000:03:03.1: detected 2 ports
usb usb11: Product: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller 
(#4)
usb usb11: Manufacturer: Linux 2.6.12-rc6 uhci_hcd
usb usb11: SerialNumber: 0000:03:03.1
hub 11-0:1.0: USB hub found
hub 11-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usb 9-1: new low speed USB device using uhci_hcd and address 2
usb 9-1: Product: Trackball
usb 9-1: Manufacturer: Logitech
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
input: USB HID v1.00 Device [USB Audio] on usb-0000:00:1d.0-2
input: USB HID v1.10 Mouse [Logitech Trackball] on usb-0000:03:02.1-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
usbcore: registered new driver auerswald
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
NET: Registered protocol family 2
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
ip_conntrack version 2.1 (8192 buckets, 65536 max) - 212 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  
http://snsowman.net/projebles: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI wakeup devices: 
AZAL RP01 RP02 RP04 USB1 USB2 USB3 USB4 USB7 LANC 
ACPI: (supports S0 S3 S4 S5)
RAMDISK: Compressed image found at block 0
input: AT Translated Set 2 keyboard on isa0060/serio0
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 220k freed
initrd: Remounting / read/write
mount: /etc/mtab: No such file or directory
initrd: Mounting /proc
initrd: Finding device mapper major and minor numbers (10,62)
initrd: Activating LVM2 volumes
  4 logical volume(s) in volume group "vg0" now active
initrd: Checking root filesystem /dev/vg0/root
WARNING: couldn't open /etc/fstab: No such file or directory
Reiserfs super block in block 16 on 0xfd00 of format 3.6 with standard journal
Blocks (total/free): 2621440/235168 by 409Synaptics Touchpad, model: 1, fw: 
5.9, id: 0x126eb1, caps: 0xa04713/0x4000
6 bytes
Filesysinput: SynPS/2 Synaptics TouchPad on isa0060/serio4
tem is clean
Replaying journal..
Reiserfs journal '/dev/vg0/root' in blocks [18..8211]: 0 transactions replayed
Checking internal tree..finished
ReiserFS: dm-0: found reiserfs format "3.6" with standard journal
initrd: MountingReiserFS: dm-0: using ordered data mode
 root filesystemReiserFS: dm-0: journal params: device dm-0, size 8192, 
journal first block 18, max trans len 1024, max batch 900, max commit age 30, 
max trans age 30
 /dev/vg0/root rReiserFS: dm-0: checking transaction log (dm-0)
w
ReiserFS: dm-0: Using r5 hash to sort names
initrd: Copying node for device mapper (/dev/mapper/control)
initrd: Moving /proc to /rootvol/proc
initrd: Changing roots
initrd: Making device nodes in lvm root fs
initrd: Unmounting /proc
initrd: Remounting lvm root fs readonly
initrd: Proceeding with boot...
INIT: version 2.86 booting
