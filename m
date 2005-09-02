Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbVIBXiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbVIBXiQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 19:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbVIBXiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 19:38:16 -0400
Received: from postman1.arcor-online.net ([151.189.20.156]:4258 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S1750948AbVIBXiP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 19:38:15 -0400
From: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: 2.6.13: Crash in Yenta initialization
Date: Sat, 3 Sep 2005 01:38:11 +0200
User-Agent: KMail/1.8.1
Organization: Embedded Systems and Applications Group, Tech. Univ. Darmstadt, Germany
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509030138.11905.koch@esa.informatik.tu-darmstadt.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This does not happen in my current kernel (2.6.12-rc6 with Ivan's PCI bridge 
patches applied). It is definitely localized in the Yenta code, since the 
boot proceeds when I disable the Yenta config option. My hardware is an Acer 
Travelmate 8104 with the external ezDock attached.

I can provide more info if you let me know what to look for.

Andreas Koch

Linux version 2.6.13 (root@meneldor) (gcc version 3.3.5-20050130 (Gentoo Linux 
3.3.5.20050130-r1, ssp-3.3.5.20050130-1, pie-8.7.7.1)) #2 Fri Sep 2 23:34:19 
CEST 2005
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
Detected 1995.744 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2069152k/2095616k available (3513k kernel code, 25172k reserved, 1575k 
data, 212k init, 1178112k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3995.10 BogoMIPS 
(lpj=1997552)
Mount-cache hash table entries: 512
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
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
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd6ce, last bus=8
PCI: Using MMCONFIG
ACPI: Subsystem revision 20050408
    ACPI-0362: *** Error: Looking up [Z00G] in namespace, AE_NOT_FOUND
search_node c20d9140 start_node c20d9140 return_node 00000000
    ACPI-0362: *** Error: Looking up [Z00G] in namespace, AE_NOT_FOUND
search_node c20d9d80 start_node c20d9d80 return_node 00000000
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
PCI: PXH quirk detected, disabling MSI for SHPC device
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
  IO window: 00003000-000030ff
  IO window: 00003400-000034ff
  PREFETCH window: 80000000-81ffffff
  MEM window: 84000000-85ffffff
PCI: Bridge: 0000:02:00.0
  IO window: 3000-3fff
  MEM window: 84000000-86ffffff
  PREFETCH window: 80000000-81ffffff
PCI: Bridge: 0000:00:1c.2
  IO window: 3000-3fff
  MEM window: 84000000-86ffffff
  PREFETCH window: 80000000-81ffffff
PCI: Bus 7, cardbus bridge: 0000:06:09.0
  IO window: 00004000-000040ff
  IO window: 00004400-000044ff
  PREFETCH window: 82000000-83ffffff
  MEM window: 88000000-89ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 4000-4fff
  MEM window: c8400000-c84fffff
  PREFETCH window: 82000000-83ffffff
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Device 0000:00:1c.0 not available because of resource collisions
PCI: Device 0000:00:1c.1 not available because of resource collisions
PCI: Enabling device 0000:00:1c.2 (0000 -> 0003)
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 17
ACPI: PCI Interrupt 0000:03:05.0[A] -> GSI 31 (level, low) -> IRQ 18
ACPI: PCI Interrupt 0000:06:09.0[A] -> GSI 18 (level, low) -> IRQ 17
Simple Boot Flag at 0x36 set to 0x1
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1125704367.262:1): initialized
highmem bounce pool size: 64 pages
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.23 [Flags: R/O].
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
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
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 17
assign_interrupt_mode Found MSI capability
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Battery Slot [BAT2] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Power Button (CM) [PWRB]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Thermal Zone [THRM] (64 C)
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
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ACPI: PCI Interrupt 0000:03:06.0[A] -> GSI 32 (level, low) -> IRQ 19
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
tg3.c:v3.37 (August 25, 2005)
ACPI: PCI Interrupt 0000:06:06.0[A] -> GSI 16 (level, low) -> IRQ 16
eth0: Tigon3 [partno(BCM95788A50) rev 3003 PHY(5705)] (PCI:33MHz:32-bit) 
10/100/1000BaseT Ethernet 00:c0:9f:75:57:33
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[0] TSOcap[1] 
eth0: dma_rwctrl[763f0000]
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 20
ACPI: PCI interrupt for device 0000:00:1f.2 disabled
ahci: probe of 0000:00:1f.2 failed with error -12
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 20
ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x18A0 irq 14
ata1: dev 0 ATA, max UDMA/100, 195371568 sectors: lba48
ata1(0): applying bridge limits
ata1: dev 0 configured for UDMA/100
scsi0 : ata_piix
  Vendor: ATA       Model: TOSHIBA MK1032GA  Rev: AB21
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x18A8 irq 15
ata2: dev 0 ATAPI, max UDMA/33
ata2(0): applying bridge limits
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
ohci1394: $Rev: 1299 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt 0000:03:04.0[A] -> GSI 30 (level, low) -> IRQ 21
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[21]  MMIO=[86005000-860057ff]  
Max Packet=[2048]
ACPI: PCI Interrupt 0000:06:07.0[A] -> GSI 19 (level, low) -> IRQ 20
ohci1394: fw-host1: OHCI-1394 1.1 (PCI): IRQ=[20]  MMIO=[c8415000-c84157ff]  
Max Packet=[2048]
ieee1394: raw1394: /dev/raw1394 device initialized
sbp2: $Rev: 1306 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt 0000:03:05.0[A] -> GSI 31 (level, low) -> IRQ 18
Yenta: CardBus bridge found at 0000:03:05.0 [104c:ac50]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:03:05.0, mfunc 0x00521d22, devctl 0x66
Yenta: ISA IRQ mask 0x0000, PCI irq 18
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x3000 - 0x3fff
pcmcia: parent PCI bridge Memory window: 0x84000000 - 0x86ffffff
pcmcia: parent PCI bridge Memory window: 0x80000000 - 0x81ffffff
ACPI: PCI Interrupt 0000:06:09.0[A] -> GSI 18 (level, low) -> IRQ 17
Yenta: CardBus bridge found at 0000:06:09.0 [1025:0070]
Yenta O2: res at 0x94/0xD4: ff/ea
Yenta O2: enabling read prefetch/write burst
Yenta: ISA IRQ mask 0x0438, PCI irq 17
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x4000 - 0x4fff
pcmcia: parent PCI bridge Memory window: 0xc8400000 - 0xc84fffff
pcmcia: parent PCI bridge Memory window: 0x82000000 - 0x83ffffff
ACPI: PCI Interrupt 0000:06:09.1[A] -> GSI 18 (level, low) -> IRQ 17
Yenta: CardBus bridge found at 0000:06:09.1 [1025:0070]
Unable to handle kernel NULL pointer dereference at virtual address 0000004f
 printing eip:
c03af658
*pde = 00000000
Oops: 0000 [#1]
Modules linked in:
CPU:    0
EIP:    0060:[<c03af658>]    Not tainted VLI
EFLAGS: 00010292   (2.6.13) 
EIP is at yenta_config_init+0xd8/0x170
eax: 00000000   ebx: dfcb7000   ecx: 00000000   edx: e0649000
esi: dff75000   edi: 00001000   ebp: dff75000   esp: dfd9fea8
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=dfd9e000 task=dfdc7a00)
Stack: dff7d880 00000049 0000000d 000000a8 c011f9d7 fffffff4 dfcb7000 c03af810 
       dfcb7000 dff750d8 00001025 00000070 c05abf20 ffffffed dff75000 c05ac340 
       c05ac36c c028927f dff75000 c05ac2d8 c05ac340 dff75000 dff75044 c02892bf 
Call Trace:
 [<c011f9d7>] printk+0x17/0x20
 [<c03af810>] yenta_probe+0x120/0x280
 [<c028927f>] __pci_device_probe+0x5f/0x70
 [<c02892bf>] pci_device_probe+0x2f/0x50
 [<c03211c8>] driver_probe_device+0x38/0xb0
 [<c03212c0>] __driver_attach+0x0/0x50
 [<c0321307>] __driver_attach+0x47/0x50
 [<c03207a9>] bus_for_each_dev+0x69/0x80
 [<c0321335>] driver_attach+0x25/0x30
 [<c03212c0>] __driver_attach+0x0/0x50
 [<c0320cfd>] bus_add_driver+0x8d/0xe0
 [<c0289580>] pci_register_driver+0x70/0x90
 [<c061906f>] yenta_socket_init+0xf/0x20
 [<c05fc8cb>] do_initcalls+0x2b/0xc0
 [<c0100290>] init+0x0/0x110
 [<c0100290>] init+0x0/0x110
 [<c01002ba>] init+0x2a/0x110
 [<c0101378>] kernel_thread_helper+0x0/0x18
 [<c010137d>] kernel_thread_helper+0x5/0x18
Code: ed ff 8b 13 b9 a8 00 00 00 b8 0d 00 00 00 89 4c 24 0c 89 44 24 08 8b 42 
20 89 44 24 04 8b 42 10 89 04 24 e8 bb 56 ed ff 8b 4e 14 <0f> b6 51 4f 0f b6 
41 4e c1 e2 10 c1 e0 08 09 c2 0f b6 41 4d 8b 
 <0>Kernel panic - not syncing: Attempted to kill init!
 
