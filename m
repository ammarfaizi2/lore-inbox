Return-Path: <linux-kernel-owner+w=401wt.eu-S964817AbWLMA23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbWLMA23 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 19:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbWLMA23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 19:28:29 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:4082 "EHLO
	pd5mo3so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964817AbWLMA21 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 19:28:27 -0500
Date: Tue, 12 Dec 2006 18:27:00 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: 2.6.19-rc6-mm2 oops and udev misbehavior
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Message-id: <457F48D4.2070505@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seeing this oops on 2.6.19-rc6-mm2 intermittently on bootup. Also, when 
this doesn't happen it seems like udev goes crazy adding and removing 
/dev/md0 over and over using up a ton of CPU. Is this a known problem? 
This also happened with -mm1.

Linux version 2.6.19-rc6-mm2admafix (rob@newcastle.ss.shawcable.net) 
(gcc version 4.1.1 20061011 (Red Hat 4.1.1-30)) #1 SMP Mon Dec 11 
22:38:59 CST 2006
Command line: ro root=/dev/VolGroup00/LogVol00
BIOS-provided physical RAM map:
BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
BIOS-e820: 000000007fff0000 - 000000007fff3000 (ACPI NVS)
BIOS-e820: 000000007fff3000 - 0000000080000000 (ACPI data)
BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
Entering add_active_range(0, 0, 159) 0 entries of 12800 used
Entering add_active_range(0, 256, 524272) 1 entries of 12800 used
end_pfn_map = 1048576
DMI 2.3 present.
ACPI: RSDP (v000 Nvidia                                ) @ 
0x00000000000f7c80
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 
0x000000007fff3040
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 
0x000000007fff30c0
ACPI: SSDT (v001 PTLTD  POWERNOW 0x00000001  LTP 0x00000001) @ 
0x000000007fff9900
ACPI: SRAT (v001 AMD    HAMMER   0x00000001 AMD  0x00000001) @ 
0x000000007fff9b40
ACPI: MCFG (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 
0x000000007fff9c40
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 
0x000000007fff9840
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 
0x0000000000000000
SRAT: PXM 0 -> APIC 0 -> Node 0
SRAT: PXM 0 -> APIC 1 -> Node 0
SRAT: Node 0 PXM 0 0-a0000
Entering add_active_range(0, 0, 159) 0 entries of 12800 used
SRAT: Node 0 PXM 0 0-80000000
Entering add_active_range(0, 0, 159) 1 entries of 12800 used
Entering add_active_range(0, 256, 524272) 1 entries of 12800 used
Bootmem setup node 0 0000000000000000-0000000080000000
Node 0 memmap at 0xffff81000096a000 size 33554432 first pfn 
0xffff81000096a000
sizeof(struct page) = 64
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1048576
early_node_map[2] active PFN ranges
    0:        0 ->      159
    0:      256 ->   524272
On node 0 totalpages: 524175
  DMA zone: 64 pages used for memmap
  DMA zone: 1907 pages reserved
  DMA zone: 2028 pages, LIFO batch:0
  DMA32 zone: 8127 pages used for memmap
  DMA32 zone: 512049 pages, LIFO batch:31
  Normal zone: 0 pages used for memmap
Nvidia board detected. Ignoring ACPI timer override.
If you got timer trouble try acpi_use_timer_override
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
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
Nosave address range: 000000000009f000 - 00000000000a0000
Nosave address range: 00000000000a0000 - 00000000000f0000
Nosave address range: 00000000000f0000 - 0000000000100000
Allocating PCI resources starting at 88000000 (gap: 80000000:60000000)
SMP: Allowing 2 CPUs, 0 hotplug CPUs
PERCPU: Allocating 67968 bytes of per cpu data
Built 1 zonelists.  Total pages: 514077
Kernel command line: ro root=/dev/VolGroup00/LogVol00
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Checking aperture...
CPU 0: aperture @ 630000000 size 32 MB
Aperture too small (32 MB)
No AGP bridge found
Memory: 2050348k/2097088k available (2275k kernel code, 46352k reserved, 
1601k data, 624k init)
Calibrating delay using timer specific routine.. 4425.40 BogoMIPS 
(lpj=8850801)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU 0/0 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
SMP alternatives: switching to UP code
ACPI: Core revision 20060707
Using local APIC timer interrupts.
result 12564667
Detected 12.564 MHz APIC timer.
SMP alternatives: switching to SMP code
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 4423.03 BogoMIPS 
(lpj=8846062)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU 1/1 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
AMD Athlon(tm) 64 X2 Dual Core Processor 4200+ stepping 01
Brought up 2 CPUs
testing NMI watchdog ... OK.
Disabling vsyscall due to use of PM timer
time.c: Using 3.579545 MHz WALL PM GTOD PM timer.
time.c: Detected 2211.377 MHz processor.
migration_cost=229
checking if image is initramfs... it is
Freeing initrd memory: 2326k freed
PM: Adding info for No Bus:platform
NET: Registered protocol family 16
PM: Adding info for No Bus:vtcon0
ACPI: bus type pci registered
PCI: Using MMCONFIG at e0000000
PCI: No mmconfig possible on device 00:18
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
PM: Adding info for acpi:acpi
ACPI: PCI Root Bridge [PCI0] (0000:00)
PM: Adding info for No Bus:pci0000:00
PCI: Transparent bridge - 0000:00:09.0
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
PM: Adding info for pci:0000:00:00.0
PM: Adding info for pci:0000:00:01.0
PM: Adding info for pci:0000:00:01.1
PM: Adding info for pci:0000:00:02.0
PM: Adding info for pci:0000:00:02.1
PM: Adding info for pci:0000:00:06.0
PM: Adding info for pci:0000:00:07.0
PM: Adding info for pci:0000:00:08.0
PM: Adding info for pci:0000:00:09.0
PM: Adding info for pci:0000:00:0a.0
PM: Adding info for pci:0000:00:0b.0
PM: Adding info for pci:0000:00:0c.0
PM: Adding info for pci:0000:00:0d.0
PM: Adding info for pci:0000:00:0e.0
PM: Adding info for pci:0000:00:18.0
PM: Adding info for pci:0000:00:18.1
PM: Adding info for pci:0000:00:18.2
PM: Adding info for pci:0000:00:18.3
PM: Adding info for pci:0000:05:07.0
PM: Adding info for pci:0000:05:08.0
PM: Adding info for pci:0000:05:0b.0
PM: Adding info for pci:0000:02:00.0
PM: Adding info for pci:0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs *3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 *7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 7 9 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LMAC] (IRQs *3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 7 9 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LSID] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LFID] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LPCA] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, 
disabled.
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
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
PM: Adding info for No Bus:pnp0
PM: Adding info for pnp:00:00
PM: Adding info for pnp:00:01
PM: Adding info for pnp:00:02
PM: Adding info for pnp:00:03
PM: Adding info for pnp:00:04
PM: Adding info for pnp:00:05
PM: Adding info for pnp:00:06
PM: Adding info for pnp:00:07
PM: Adding info for pnp:00:08
PM: Adding info for pnp:00:09
pnp: PnP ACPI: found 10 devices
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a 
report
PCI-DMA: Disabling IOMMU.
pnp: 00:01: ioport range 0x4000-0x407f could not be reserved
pnp: 00:01: ioport range 0x4080-0x40ff has been reserved
pnp: 00:01: ioport range 0x4400-0x447f has been reserved
pnp: 00:01: ioport range 0x4480-0x44ff could not be reserved
pnp: 00:01: ioport range 0x4800-0x487f has been reserved
pnp: 00:01: ioport range 0x4880-0x48ff has been reserved
PM: Adding info for No Bus:mem
PM: Adding info for No Bus:kmem
PM: Adding info for No Bus:null
PM: Adding info for No Bus:port
PM: Adding info for No Bus:zero
PM: Adding info for No Bus:full
PM: Adding info for No Bus:random
PM: Adding info for No Bus:urandom
PM: Adding info for No Bus:kmsg
PCI: Bridge: 0000:00:09.0
  IO window: a000-afff
  MEM window: d0000000-d1ffffff
  PREFETCH window: disabled.
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
  MEM window: c0000000-c7ffffff
  PREFETCH window: b8000000-bfffffff
PCI: Bridge: 0000:00:0e.0
  IO window: disabled.
  MEM window: c8000000-cfffffff
  PREFETCH window: b0000000-b7ffffff
PCI: Setting latency timer of device 0000:00:09.0 to 64
PCI: Setting latency timer of device 0000:00:0b.0 to 64
PCI: Setting latency timer of device 0000:00:0c.0 to 64
PCI: Setting latency timer of device 0000:00:0d.0 to 64
PCI: Setting latency timer of device 0000:00:0e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
TCP established hash table entries: 131072 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
PM: Adding info for platform:pcspkr
PM: Adding info for No Bus:mcelog
PM: Adding info for No Bus:msr0
PM: Adding info for No Bus:msr1
PM: Adding info for No Bus:cpu0
PM: Adding info for No Bus:cpu1
PM: Adding info for No Bus:snapshot
audit: initializing netlink socket (disabled)
audit(1165946380.436:1): initialized
PM: Adding info for No Bus:kevent
KEVENT subsystem has been successfully registered.
KEVENT: Added callbacks for type 2.
KEVENT: Added callbacks for type 3.
Kevent poll()/select() subsystem has been initialized.
KEVENT: Added callbacks for type 0.
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: Found HT MSI mapping on 0000:00:0b.0 with capability disabled
PCI: Found HT MSI mapping on 0000:00:00.0 with capability enabled
PCI: Linking AER extended capability on 0000:00:0b.0
PCI: Found HT MSI mapping on 0000:00:0c.0 with capability disabled
PCI: Found HT MSI mapping on 0000:00:00.0 with capability enabled
PCI: Linking AER extended capability on 0000:00:0c.0
PCI: Found HT MSI mapping on 0000:00:0d.0 with capability disabled
PCI: Found HT MSI mapping on 0000:00:00.0 with capability enabled
PCI: Linking AER extended capability on 0000:00:0d.0
PCI: Found HT MSI mapping on 0000:00:0e.0 with capability disabled
PCI: Found HT MSI mapping on 0000:00:00.0 with capability enabled
PCI: Linking AER extended capability on 0000:00:0e.0
PCI: Setting latency timer of device 0000:00:0b.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0b.0:pcie00]
PM: Adding info for pci_express:0000:00:0b.0:pcie00
Allocate Port Service[0000:00:0b.0:pcie03]
PM: Adding info for pci_express:0000:00:0b.0:pcie03
PCI: Setting latency timer of device 0000:00:0c.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0c.0:pcie00]
PM: Adding info for pci_express:0000:00:0c.0:pcie00
Allocate Port Service[0000:00:0c.0:pcie03]
PM: Adding info for pci_express:0000:00:0c.0:pcie03
PCI: Setting latency timer of device 0000:00:0d.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0d.0:pcie00]
PM: Adding info for pci_express:0000:00:0d.0:pcie00
Allocate Port Service[0000:00:0d.0:pcie03]
PM: Adding info for pci_express:0000:00:0d.0:pcie03
PCI: Setting latency timer of device 0000:00:0e.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0e.0:pcie00]
PM: Adding info for pci_express:0000:00:0e.0:pcie00
Allocate Port Service[0000:00:0e.0:pcie03]
PM: Adding info for pci_express:0000:00:0e.0:pcie03
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
PM: Adding info for platform:vesafb.0
ACPI: Fan [FAN] (on)
ACPI: Thermal Zone [THRM] (40 C)
PM: Adding info for No Bus:tty
PM: Adding info for No Bus:console
PM: Adding info for No Bus:ptmx
PM: Adding info for No Bus:tty0
PM: Adding info for No Bus:vcs
PM: Adding info for No Bus:vcsa
PM: Adding info for No Bus:tty1
PM: Adding info for No Bus:tty2
PM: Adding info for No Bus:tty3
PM: Adding info for No Bus:tty4
PM: Adding info for No Bus:tty5
PM: Adding info for No Bus:tty6
PM: Adding info for No Bus:tty7
PM: Adding info for No Bus:tty8
PM: Adding info for No Bus:tty9
PM: Adding info for No Bus:tty10
PM: Adding info for No Bus:tty11
PM: Adding info for No Bus:tty12
PM: Adding info for No Bus:tty13
PM: Adding info for No Bus:tty14
PM: Adding info for No Bus:tty15
PM: Adding info for No Bus:tty16
PM: Adding info for No Bus:tty17
PM: Adding info for No Bus:tty18
PM: Adding info for No Bus:tty19
PM: Adding info for No Bus:tty20
PM: Adding info for No Bus:tty21
PM: Adding info for No Bus:tty22
PM: Adding info for No Bus:tty23
PM: Adding info for No Bus:tty24
PM: Adding info for No Bus:tty25
PM: Adding info for No Bus:tty26
PM: Adding info for No Bus:tty27
PM: Adding info for No Bus:tty28
PM: Adding info for No Bus:tty29
PM: Adding info for No Bus:tty30
PM: Adding info for No Bus:tty31
PM: Adding info for No Bus:tty32
PM: Adding info for No Bus:tty33
PM: Adding info for No Bus:tty34
PM: Adding info for No Bus:tty35
PM: Adding info for No Bus:tty36
PM: Adding info for No Bus:tty37
PM: Adding info for No Bus:tty38
PM: Adding info for No Bus:tty39
PM: Adding info for No Bus:tty40
PM: Adding info for No Bus:tty41
PM: Adding info for No Bus:tty42
PM: Adding info for No Bus:tty43
PM: Adding info for No Bus:tty44
PM: Adding info for No Bus:tty45
PM: Adding info for No Bus:tty46
PM: Adding info for No Bus:tty47
PM: Adding info for No Bus:tty48
PM: Adding info for No Bus:tty49
PM: Adding info for No Bus:tty50
PM: Adding info for No Bus:tty51
PM: Adding info for No Bus:tty52
PM: Adding info for No Bus:tty53
PM: Adding info for No Bus:tty54
PM: Adding info for No Bus:tty55
PM: Adding info for No Bus:tty56
PM: Adding info for No Bus:tty57
PM: Adding info for No Bus:tty58
PM: Adding info for No Bus:tty59
PM: Adding info for No Bus:tty60
PM: Adding info for No Bus:tty61
PM: Adding info for No Bus:tty62
PM: Adding info for No Bus:tty63
PM: Adding info for No Bus:rtc
Real Time Clock Driver v1.12ac
PM: Adding info for No Bus:hpet
PM: Adding info for No Bus:nvram
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
PM: Adding info for platform:serial8250
PM: Adding info for No Bus:ttyS0
PM: Adding info for No Bus:ttyS1
PM: Adding info for No Bus:ttyS2
PM: Adding info for No Bus:ttyS3
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
PM: Adding info for No Bus:lo
usbcore: registered new interface driver libusual
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: No PS/2 controller found. Probing ports directly.
PM: Adding info for platform:i8042
serio: i8042 KBD port at 0x60,0x64 irq 1
PM: Adding info for serio:serio0
mice: PS/2 mouse device common for all mice
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow-k8: Found 2 AMD Athlon(tm) 64 X2 Dual Core Processor 4200+ 
processors (version 2.00.00)
powernow-k8:    0 : fid 0xe (2200 MHz), vid 0x8
powernow-k8:    1 : fid 0xc (2000 MHz), vid 0xa
powernow-k8:    2 : fid 0xa (1800 MHz), vid 0xc
powernow-k8:    3 : fid 0x2 (1000 MHz), vid 0x12
ACPI: (supports S0 S1 S3 S4 S5)
Freeing unused kernel memory: 624k freed
Write protecting the kernel read-only data: 454k
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
USB Universal Host Controller Interface driver v3.0
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 23 (level, 
low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:02.0: irq 23, io mem 0xd2003000
usb usb1: new device found, idVendor=0000, idProduct=0000
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: OHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.19-rc6-mm2admafix ohci_hcd
usb usb1: SerialNumber: 0000:00:02.0
PM: Adding info for usb:usb1
PM: Adding info for No Bus:usbdev1.1_ep00
usb usb1: configuration #1 chosen from 1 choice
PM: Adding info for usb:1-0:1.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 10 ports detected
PM: Adding info for No Bus:usbdev1.1_ep81
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCL] -> GSI 22 (level, 
low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:02.1 to 64
ehci_hcd 0000:00:02.1: EHCI Host Controller
ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 2
ehci_hcd 0000:00:02.1: debug port 1
PCI: cache line size of 64 is not supported by device 0000:00:02.1
ehci_hcd 0000:00:02.1: irq 22, io mem 0xfeb00000
ehci_hcd 0000:00:02.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb2: new device found, idVendor=0000, idProduct=0000
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: EHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.19-rc6-mm2admafix ehci_hcd
usb usb2: SerialNumber: 0000:00:02.1
PM: Adding info for usb:usb2
PM: Adding info for No Bus:usbdev2.1_ep00
usb usb2: configuration #1 chosen from 1 choice
PM: Adding info for usb:2-0:1.0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 10 ports detected
PM: Adding info for No Bus:usbdev2.1_ep81
SCSI subsystem initialized
libata version 2.00 loaded.
sata_nv 0000:00:07.0: version 3.3
ACPI: PCI Interrupt Link [APSI] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [APSI] -> GSI 21 (level, 
low) -> IRQ 21
sata_nv 0000:00:07.0: Using ADMA mode
PCI: Setting latency timer of device 0000:00:07.0 to 64
ata1: SATA max UDMA/133 cmd 0xFFFFC2000001C480 ctl 0xFFFFC2000001C4A0 
bmdma 0xD800 irq 21
ata2: SATA max UDMA/133 cmd 0xFFFFC2000001C580 ctl 0xFFFFC2000001C5A0 
bmdma 0xD808 irq 21
scsi0 : sata_nv
PM: Adding info for No Bus:host0
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-6, max UDMA/133, 312581808 sectors: LBA48 NCQ (depth 31/32)
ata1.00: ata1: dev 0 multi count 1
ata1.00: configured for UDMA/133
scsi1 : sata_nv
PM: Adding info for No Bus:host1
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
usb 2-3: new high speed USB device using ehci_hcd and address 4
ata2.00: ATAPI, max UDMA/66
ata2.00: applying bridge limits
usb 2-3: new device found, idVendor=0409, idProduct=0059
usb 2-3: new device strings: Mfr=0, Product=0, SerialNumber=0
PM: Adding info for usb:2-3
PM: Adding info for No Bus:usbdev2.4_ep00
usb 2-3: configuration #1 chosen from 1 choice
PM: Adding info for usb:2-3:1.0
hub 2-3:1.0: USB hub found
hub 2-3:1.0: 4 ports detected
ata2.00: configured for UDMA/66
PM: Adding info for No Bus:target0:0:0
scsi 0:0:0:0: Direct-Access     ATA      ST3160827AS      3.42 PQ: 0 ANSI: 5
ata1: bounce limit 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFFFF, hw 
segs 61
PM: Adding info for scsi:0:0:0:0
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sda: sda1
sd 0:0:0:0: Attached scsi disk sda
PM: Adding info for No Bus:target1:0:0
scsi 1:0:0:0: CD-ROM            LITE-ON  DVDRW SHM-165H6S HS0E PQ: 0 ANSI: 5
ata2: bounce limit 0xFFFFFFFF, segment boundary 0xFFFF, hw segs 127
PM: Adding info for scsi:1:0:0:0
ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 20
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [APSJ] -> GSI 20 (level, 
low) -> IRQ 20
sata_nv 0000:00:08.0: Using ADMA mode
PCI: Setting latency timer of device 0000:00:08.0 to 64
ata3: SATA max UDMA/133 cmd 0xFFFFC2000001E480 ctl 0xFFFFC2000001E4A0 
bmdma 0xC400 irq 20
ata4: SATA max UDMA/133 cmd 0xFFFFC2000001E580 ctl 0xFFFFC2000001E5A0 
bmdma 0xC408 irq 20
scsi2 : sata_nv
PM: Adding info for No Bus:host2
PM: Adding info for No Bus:usbdev2.4_ep81
usb 2-9: new high speed USB device using ehci_hcd and address 6
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.00: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 31/32)
ata3.00: ata3: dev 0 multi count 1
ata3.00: configured for UDMA/133
scsi3 : sata_nv
PM: Adding info for No Bus:host3
usb 2-9: new device found, idVendor=07cc, idProduct=0301
usb 2-9: new device strings: Mfr=1, Product=2, SerialNumber=3
usb 2-9: Product: Winter Ver1.3   usb 2-9: Manufacturer:         Ltd
usb 2-9: SerialNumber: 972394281841
PM: Adding info for usb:2-9
PM: Adding info for No Bus:usbdev2.6_ep00
usb 2-9: configuration #1 chosen from 1 choice
PM: Adding info for usb:2-9:1.0
libusual: modprobe for usb-storage succeeded, but module is not present
PM: Adding info for No Bus:usbdev2.6_ep81
PM: Adding info for No Bus:usbdev2.6_ep02
usb 1-1: new low speed USB device using ohci_hcd and address 2
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: ATA-6, max UDMA/133, 312581808 sectors: LBA48 NCQ (depth 31/32)
ata4.00: ata4: dev 0 multi count 1
ata4.00: configured for UDMA/133
PM: Adding info for No Bus:target2:0:0
scsi 2:0:0:0: Direct-Access     ATA      ST3320620AS      3.AA PQ: 0 ANSI: 5
ata3: bounce limit 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFFFF, hw 
segs 61
PM: Adding info for scsi:2:0:0:0
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
usb 1-1: new device found, idVendor=045e, idProduct=008c
usb 1-1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 1-1: Product: Microsoft Wireless Optical Mouse® 1.0A
usb 1-1: Manufacturer: Microsoft
PM: Adding info for usb:1-1
PM: Adding info for No Bus:usbdev1.2_ep00
usb 1-1: configuration #1 chosen from 1 choice
SCSI device sdb: write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sdb:<7>PM: Adding info for usb:1-1:1.0
sdb1
sd 2:0:0:0: Attached scsi disk sdb
PM: Adding info for No Bus:target3:0:0
scsi 3:0:0:0: Direct-Access     ATA      ST3160827AS      3.42 PQ: 0 ANSI: 5
ata4: bounce limit 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFFFF, hw 
segs 61
PM: Adding info for scsi:3:0:0:0
SCSI device sdc: 312581808 512-byte hdwr sectors (160042 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
input: Microsoft Microsoft Wireless Optical Mouse® 1.0A as 
/class/input/input0
input: USB HID v1.11 Mouse [Microsoft Microsoft Wireless Optical Mouse® 
1.0A] on usb-0000:00:02.0-1
PM: Adding info for No Bus:usbdev1.2_ep81
SCSI device sdc: write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
SCSI device sdc: 312581808 512-byte hdwr sectors (160042 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sdc: sdc1 sdc2 sdc3 sdc4 < sdc5 >
sd 3:0:0:0: Attached scsi disk sdc
PM: Adding info for No Bus:device-mapper
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: 
dm-devel@redhat.com
usb 1-2: new full speed USB device using ohci_hcd and address 3
usb 1-2: new device found, idVendor=0451, idProduct=1446
usb 1-2: new device strings: Mfr=0, Product=0, SerialNumber=0
PM: Adding info for usb:1-2
PM: Adding info for No Bus:usbdev1.3_ep00
usb 1-2: configuration #1 chosen from 1 choice
PM: Adding info for usb:1-2:1.0
hub 1-2:1.0: USB hub found
hub 1-2:1.0: 4 ports detected
PM: Adding info for No Bus:usbdev1.3_ep81
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
usb 1-4: new low speed USB device using ohci_hcd and address 4
audit(1165946384.956:2): enforcing=1 old_enforcing=0 auid=4294967295
security:  3 users, 6 roles, 1577 types, 170 bools, 1 sens, 1024 cats
security:  59 classes, 49211 rules
security:  class dccp_socket not defined in policy
security:  permission dccp_recv in class node not defined in policy
security:  permission dccp_send in class node not defined in policy
security:  permission dccp_recv in class netif not defined in policy
security:  permission dccp_send in class netif not defined in policy
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
usb 1-4: new device found, idVendor=051d, idProduct=0002
usb 1-4: new device strings: Mfr=3, Product=1, SerialNumber=2
usb 1-4: Product: Back-UPS BR  800 FW:9.o2 .D USB FW:o2 usb 1-4: 
Manufacturer: American Power Conversion
usb 1-4: SerialNumber: QB0419230426  PM: Adding info for usb:1-4
PM: Adding info for No Bus:usbdev1.4_ep00
usb 1-4: configuration #1 chosen from 1 choice
SELinux: initialized (dev dm-0, type ext3), uses xattr
PM: Adding info for usb:1-4:1.0
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts
SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses genfs_contexts
SELinux: initialized (dev devpts, type devpts), uses transition SIDs
SELinux: initialized (dev eventpollfs, type eventpollfs), uses task SIDs
SELinux: initialized (dev inotifyfs, type inotifyfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
SELinux: initialized (dev cpuset, type cpuset), not configured for labeling
SELinux: initialized (dev proc, type proc), uses genfs_contexts
SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
audit(1165946385.188:3): policy loaded auid=4294967295
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
hiddev96: USB HID v1.10 Device [American Power Conversion Back-UPS BR 
800 FW:9.o2 .D USB FW:o2 ] on usb-0000:00:02.0-4
PM: Adding info for No Bus:usbdev1.4_ep81
usb 2-3.1: new full speed USB device using ehci_hcd and address 7
usb 2-3.1: new device found, idVendor=046d, idProduct=092c
usb 2-3.1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 2-3.1: Product: Camera
usb 2-3.1: Manufacturer:         PM: Adding info for usb:2-3.1
PM: Adding info for No Bus:usbdev2.7_ep00
usb 2-3.1: configuration #1 chosen from 1 choice
PM: Adding info for usb:2-3.1:1.0
PM: Adding info for No Bus:usbdev2.7_ep81
usb 1-2.1: new low speed USB device using ohci_hcd and address 5
usb 1-2.1: new device found, idVendor=045e, idProduct=002b
usb 1-2.1: new device strings: Mfr=0, Product=1, SerialNumber=0
usb 1-2.1: Product: Microsoft Internet Keyboard Pro
PM: Adding info for usb:1-2.1
PM: Adding info for No Bus:usbdev1.5_ep00
usb 1-2.1: configuration #1 chosen from 1 choice
PM: Adding info for usb:1-2.1:1.0
input: Microsoft Internet Keyboard Pro as /class/input/input1
input: USB HID v1.10 Keyboard [Microsoft Internet Keyboard Pro] on 
usb-0000:00:02.0-2.1
PM: Adding info for No Bus:usbdev1.5_ep81
PM: Adding info for usb:1-2.1:1.1
input: Microsoft Internet Keyboard Pro as /class/input/input2
input: USB HID v1.10 Device [Microsoft Internet Keyboard Pro] on 
usb-0000:00:02.0-2.1
PM: Adding info for No Bus:usbdev1.5_ep82
EDAC MC: Ver: 2.0.1 Dec 11 2006
ieee1394: Initialized config rom entry `ip1394'
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
ACPI: PCI Interrupt 0000:05:0b.0[A] -> Link [APC1] -> GSI 16 (level, 
low) -> IRQ 16
PM: Adding info for ieee1394:fw-host0
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[16] 
MMIO=[d1004000-d10047ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
EDAC MC0: Giving out device to k8_edac Athlon64/Opteron: DEV 0000:00:18.2
Linux video capture interface: v2.00
input: PC Speaker as /class/input/input3
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.59.
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [APCH] -> GSI 23 (level, 
low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:0a.0 to 64
forcedeth: using HIGHDMA
cx2388x v4l2 driver version 0.0.6 loaded
Floppy drive(s): fd0 is 1.44M
PM: Adding info for No Bus:eth0
eth0: forcedeth.c: subsystem: 01043:8141 bound to 0000:00:0a.0
pata_amd 0000:00:06.0: version 0.2.7
PCI: Setting latency timer of device 0000:00:06.0 to 64
ata5: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
ata6: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
scsi4 : pata_amd
PM: Adding info for No Bus:host4
FDC 0 is a post-1991 82077
PM: Adding info for platform:floppy.0
sd 0:0:0:0: Attached scsi generic sg0 type 0
scsi 1:0:0:0: Attached scsi generic sg1 type 5
sd 2:0:0:0: Attached scsi generic sg2 type 0
sd 3:0:0:0: Attached scsi generic sg3 type 0
ATA: abnormal status 0x7F on port 0x1F7
scsi5 : pata_amd
PM: Adding info for No Bus:host5
PM: Adding info for No Bus:timer
sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi CD-ROM sr0
PM: Adding info for ieee1394:0011d80000007098
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0011d80000007098]
PM: Adding info for ieee1394:0011d80000007098-0
ata6.00: ATAPI, max UDMA/33
ata6.00: configured for UDMA/33
PM: Adding info for No Bus:target5:0:0
scsi 5:0:0:0: CD-ROM            LITE-ON  CD-RW SOHR-5238S 4S09 PQ: 0 ANSI: 5
PM: Adding info for scsi:5:0:0:0
sr1: scsi3-mmc drive: 40x/52x writer cd/rw xa/form2 cdda tray
sr 5:0:0:0: Attached scsi CD-ROM sr1
sr 5:0:0:0: Attached scsi generic sg4 type 5
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
ACPI: PCI Interrupt 0000:05:08.0[A] -> Link [APC3] -> GSI 18 (level, 
low) -> IRQ 18
CORE cx88[0]: subsystem: 0000:0000, board: MSI TV-@nywhere 
[card=13,insmod option]
TV tuner 33 at 0x1fe, Radio tuner -1 at 0x1fe
PM: Adding info for No Bus:i2c-0
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x4c00
PM: Adding info for No Bus:i2c-1
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x4c40
PM: Adding info for No Bus:i2c-2
tveeprom 2-0050: Huh, no eeprom present (err=-121)?
cx88[0]/0: found at 0000:05:08.0, rev: 3, irq: 18, latency: 32, mmio: 
0xd0000000
PM: Adding info for No Bus:seq
tuner 2-0060: Chip ID is not zero. It is not a TEA5767
tuner 2-0060: chip found @ 0xc0 (cx88[0])
PM: Adding info for i2c:2-0060
tuner 2-0060: microtune: companycode=4d54 part=04 rev=04
tuner 2-0060: microtune MT2032 found, OK
tuner 2-0060: microtune: companycode=4d54 part=04 rev=04
tuner 2-0060: microtune MT2032 found, OK
PM: Adding info for No Bus:sequencer
PM: Adding info for No Bus:sequencer2
cx88[0]/0: registered device video0 [v4l2]
cx88[0]/0: registered device vbi0
ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
ACPI: PCI Interrupt 0000:05:07.0[A] -> Link [APC2] -> GSI 17 (level, 
low) -> IRQ 17
ice1724: No matching model found for ID 0x581404a6
ice1724: Invalid EEPROM version 1
PM: Adding info for No Bus:card0
PM: Adding info for ac97:0-0:VT1616i
PM: Adding info for No Bus:pcmC0D1p
PM: Adding info for No Bus:adsp
PM: Adding info for No Bus:pcmC0D0p
PM: Adding info for No Bus:pcmC0D0c
PM: Adding info for No Bus:dsp
PM: Adding info for No Bus:audio
PM: Adding info for No Bus:controlC0
PM: Adding info for No Bus:mixer
lp: driver loaded but no devices found
bay: Unknown symbol is_dock_device
bay: Unknown symbol register_hotplug_dock_device
bay: Unknown symbol unregister_hotplug_dock_device
input: Power Button (FF) as /class/input/input4
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input5
ACPI: Power Button (CM) [PWRB]
ibm_acpi: ec object not found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
kobject_add failed for md0 with -EEXIST, don't try to register things 
with the same name in the same directory.

Call Trace:
[<ffffffff80264d67>] show_trace+0x34/0x47
[<ffffffff80264d8c>] dump_stack+0x12/0x17
[<ffffffff80334887>] kobject_add+0x16d/0x198
[<ffffffff802f5378>] register_disk+0x47/0x218
[<ffffffff8032d93d>] add_disk+0x34/0x3d
[<ffffffff803d6d29>] md_probe+0xd8/0x13f
[<ffffffff803a16f3>] kobj_lookup+0x10b/0x151
[<ffffffff8032d8a1>] get_gendisk+0x17/0x29
[<ffffffff802e0528>] do_open+0x3b/0x2ca
[<ffffffff802e0a58>] blkdev_open+0x2e/0x5d
[<ffffffff8021cf5b>] __dentry_open+0xd9/0x1af
[<ffffffff80225441>] do_filp_open+0x2d/0x3d
[<ffffffff80217f05>] do_sys_open+0x44/0xbe
[<ffffffff8025711e>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83
Leftover inexact backtrace:

Unable to handle kernel NULL pointer dereference at 0000000000000020 
RIP: [<ffffffff802f84c6>] create_dir+0x11/0x1e0
PGD 7b6e1067 PUD 7b6e2067 PMD 0 Oops: 0000 [1] SMP last sysfs file: 
/class/input/input5/event5/dev
CPU 0 Modules linked in: video sony_acpi sbs i2c_ec button battery 
backlight ac parport_pc lp parport snd_ice1724 snd_ice17xx_ak4xxx 
snd_ac97_codec snd_ac97_bus snd_ak4114 snd_seq_dummy snd_seq_oss 
snd_seq_midi_event tuner snd_seq snd_pcm_oss snd_mixer_oss snd_pcm 
sr_mod snd_timer snd_page_alloc snd_pt2258 snd_i2c snd_ak4xxx_adda cdrom 
snd_mpu401_uart snd_rawmidi sg floppy i2c_nforce2 snd_seq_device joydev 
cx8800 cx88xx ir_common i2c_algo_bit pata_amd video_buf tveeprom 
i2c_core forcedeth pcspkr compat_ioctl32 btcx_risc videodev snd 
v4l2_common k8_edac ohci1394 v4l1_compat k8temp ieee1394 edac_mc hwmon 
soundcore dm_snapshot dm_zero dm_mirror dm_mod ata_generic sata_nv 
libata sd_mod scsi_mod ext3 jbd ehci_hcd ohci_hcd uhci_hcd
Pid: 1896, comm: vol_id Not tainted 2.6.19-rc6-mm2admafix #1
RIP: 0010:[<ffffffff802f84c6>]  [<ffffffff802f84c6>] create_dir+0x11/0x1e0
RSP: 0018:ffff81007bc59ca8  EFLAGS: 00010282
RAX: ffff81007e864470 RBX: ffff81007f3cd840 RCX: ffff81007bc59ce0
RDX: ffff81007f3cd848 RSI: 0000000000000000 RDI: ffff81007f3cd840
RBP: ffff81007f3cd840 R08: 0000000000000246 R09: 0000000000000296
R10: 0000000000000000 R11: 0000000000000000 R12: ffff81007f3cd800
R13: ffff81007bc59ce0 R14: 0000000000000000 R15: ffff81007e864470
FS:  0000000000686850(0063) GS:ffffffff805ca000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000020 CR3: 000000007dfba000 CR4: 00000000000006e0
Process vol_id (pid: 1896, threadinfo ffff81007bc58000, task 
ffff810037dc87f0)
Stack:  ffff81007f3cd840 00000000ffffffea ffff81007f3cd800 0000000000900000
0000000000000000 ffffffff802f8a55 ffff81007e864470 0000000000000000
ffff81007f3cd840 ffffffff803347f5 0000000100000009 ffff81007f3cd840
Call Trace:
[<ffffffff802f8a55>] sysfs_create_dir+0x52/0x70
[<ffffffff803347f5>] kobject_add+0xdb/0x198
[<ffffffff803349ed>] kobject_register+0x20/0x3a
[<ffffffff803d6d81>] md_probe+0x130/0x13f
[<ffffffff803a16f3>] kobj_lookup+0x10b/0x151
[<ffffffff8032d8a1>] get_gendisk+0x17/0x29
[<ffffffff802e0528>] do_open+0x3b/0x2ca
[<ffffffff802e0a58>] blkdev_open+0x2e/0x5d
[<ffffffff8021cf5b>] __dentry_open+0xd9/0x1af
[<ffffffff80225441>] do_filp_open+0x2d/0x3d
[<ffffffff80217f05>] do_sys_open+0x44/0xbe
[<ffffffff8025711e>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83
Leftover inexact backtrace:


Code: 48 8b 7e 20 48 89 d3 48 81 c7 d0 00 00 00 e8 bf 4d f6 ff fc RIP 
[<ffffffff802f84c6>] create_dir+0x11/0x1e0
RSP <ffff81007bc59ca8>
CR2: 0000000000000020
<6>EXT3 FS on dm-0, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdc3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev sdc3, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
NTFS driver 2.1.27 [Flags: R/W MODULE].
NTFS volume version 3.1.
SELinux: initialized (dev sdb1, type ntfs), uses genfs_contexts
NTFS volume version 3.1.
SELinux: initialized (dev sdc1, type ntfs), uses genfs_contexts
SELinux: initialized (dev sdc2, type vfat), uses genfs_contexts
Adding 2031608k swap on /dev/VolGroup00/LogVol01.  Priority:-1 extents:1 
across:2031608k
SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses 
genfs_contexts
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
PM: Adding info for No Bus:vcs2
PM: Adding info for No Bus:vcs3
PM: Adding info for No Bus:vcsa3
PM: Removing info for No Bus:vcs3
PM: Removing info for No Bus:vcsa3
PM: Adding info for No Bus:vcs3
PM: Adding info for No Bus:vcsa3
PM: Adding info for No Bus:vcs4
PM: Adding info for No Bus:vcsa4
PM: Removing info for No Bus:vcs4
PM: Removing info for No Bus:vcsa4
PM: Adding info for No Bus:vcs4
PM: Adding info for No Bus:vcsa4
PM: Adding info for No Bus:vcs5
PM: Adding info for No Bus:vcs6
PM: Adding info for No Bus:vcsa6
PM: Removing info for No Bus:vcs6
PM: Removing info for No Bus:vcsa6
PM: Adding info for No Bus:vcs6
PM: Adding info for No Bus:vcsa6
PM: Adding info for No Bus:vcsa5
PM: Removing info for No Bus:vcs5
PM: Removing info for No Bus:vcsa5
PM: Adding info for No Bus:vcs5
PM: Adding info for No Bus:vcsa5
PM: Adding info for No Bus:vcsa2
PM: Removing info for No Bus:vcs2
PM: Removing info for No Bus:vcsa2
PM: Adding info for No Bus:vcs2
PM: Adding info for No Bus:vcsa2
PM: Adding info for No Bus:vcs7
PM: Adding info for No Bus:vcsa7
PM: Removing info for No Bus:vcs7
PM: Removing info for No Bus:vcsa7
PM: Adding info for No Bus:vcs7
PM: Adding info for No Bus:vcsa7
eth0: no IPv6 routers present

-- 

Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


