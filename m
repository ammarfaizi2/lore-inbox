Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161561AbWJaBUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161561AbWJaBUR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 20:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161562AbWJaBUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 20:20:16 -0500
Received: from 8.ctyme.com ([69.50.231.8]:39375 "EHLO darwin.ctyme.com")
	by vger.kernel.org with ESMTP id S1161561AbWJaBUN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 20:20:13 -0500
Message-ID: <4546A4C9.7090504@perkel.com>
Date: Mon, 30 Oct 2006 17:20:09 -0800
From: Marc Perkel <marc@perkel.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: usb device descriptor read/64, error -110
References: <45468ABC.1060100@perkel.com> <20061030235429.GO27968@stusta.de> <454691E4.6000807@perkel.com> <20061031011458.GP27968@stusta.de>
In-Reply-To: <20061031011458.GP27968@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamfilter-host: darwin.ctyme.com - http://www.junkemailfilter.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Adrian Bunk wrote:
> On Mon, Oct 30, 2006 at 03:59:32PM -0800, Marc Perkel wrote:
>   
>> Adrian Bunk wrote:
>>     
>>> On Mon, Oct 30, 2006 at 03:29:00PM -0800, Marc Perkel wrote:
>>>  
>>>       
>>>> Running the latest FC6 kernel based on 2.6.18.1. What does this error 
>>>> mean?
>>>>
>>>> device descriptor read/64, error -110
>>>>
>>>> Is this a kernel bug? Thanks in advance?
>>>>    
>>>>         
>>> That's a timeout.
>>>
>>> Your bug report lacks any any information for further debugging your 
>>> problem.
>>>
>>> - When does it occur?
>>> - What is failing?
>>> - Please send the output of "dmesg -s 1000000".
>>>
>>> And please read and follow REPORTING-BUGS in the kernel sources before 
>>> sending your next bug report.
>>>
>>> cu
>>> Adrian
>>>
>>>  
>>>       
>> Thanks for your help. The device is a module that lets me plug in 
>> various kinds og camera memory sticks.
>>
>> usb 1-7: new full speed USB device using ohci_hcd and address 2
>> usb 1-7: device descriptor read/64, error -110
>> usb 1-7: device descriptor read/64, error -110
>> usb 1-7: new full speed USB device using ohci_hcd and address 3
>> usb 1-7: device descriptor read/64, error -110
>>     
>
> Please send the _complete_ output of "dmesg -s 1000000".
> If you want help, you should include as much information as possible.
>
> If you are concerned about the size of your email, please remember that 
> linux-kernel has a 100 kB size limit - and everything smaller is 
> perfectly OK.
>
> cu
> Adrian
>   

OK - I was just trying to send what I thought was relevant. Here's all 
of it.

Bootdata ok (command line is ro root=LABEL=/ vga=1 pci=nommconf)
Linux version 2.6.18-1.2798.fc6 (brewbuilder@hs20-bc1-6.build.redhat.com) (gcc version 4.1.1 20061011 (Red Hat 4.1.1-30)) #1 SMP Mon Oct 16 14:39:22 EDT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000cdef0000 (usable)
 BIOS-e820: 00000000cdef0000 - 00000000cdef3000 (ACPI NVS)
 BIOS-e820: 00000000cdef3000 - 00000000cdf00000 (ACPI data)
 BIOS-e820: 00000000ce000000 - 00000000d0000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000130000000 (usable)
DMI 2.4 present.
ACPI: RSDP (v002 Nvidia                                ) @ 0x00000000000f7560
ACPI: XSDT (v001 Nvidia ASUSACPI 0x42302e31 AWRD 0x00000000) @ 0x00000000cdef30c0
ACPI: FADT (v003 Nvidia ASUSACPI 0x42302e31 AWRD 0x00000000) @ 0x00000000cdefb3c0
ACPI: HPET (v001 Nvidia ASUSACPI 0x42302e31 AWRD 0x00000098) @ 0x00000000cdefb5c0
ACPI: MCFG (v001 Nvidia ASUSACPI 0x42302e31 AWRD 0x00000000) @ 0x00000000cdefb640
ACPI: MADT (v001 Nvidia ASUSACPI 0x42302e31 AWRD 0x00000000) @ 0x00000000cdefb500
ACPI: DSDT (v001 NVIDIA ASUSACPI 0x00001000 MSFT 0x0100000e) @ 0x0000000000000000
Scanning NUMA topology in Northbridge 24
Number of nodes 1
Node 0 MemBase 0000000000000000 Limit 0000000130000000
NUMA: Using 63 for the hash shift.
Using node hash shift of 63
Bootmem setup node 0 0000000000000000-0000000130000000
On node 0 totalpages: 1019245
  DMA zone: 2621 pages, LIFO batch:0
  DMA32 zone: 823088 pages, LIFO batch:31
  Normal zone: 193536 pages, LIFO batch:31
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:11 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:11 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
ACPI: IRQ14 used by override.
ACPI: IRQ15 used by override.
Setting APIC routing to physical flat
ACPI: HPET id: 0x10de8201 base: 0xfefff000
Using ACPI (MADT) for SMP configuration information
Nosave address range: 000000000009f000 - 00000000000a0000
Nosave address range: 00000000000a0000 - 00000000000f0000
Nosave address range: 00000000000f0000 - 0000000000100000
Nosave address range: 00000000cdef0000 - 00000000cdef3000
Nosave address range: 00000000cdef3000 - 00000000cdf00000
Nosave address range: 00000000cdf00000 - 00000000ce000000
Nosave address range: 00000000ce000000 - 00000000d0000000
Nosave address range: 00000000d0000000 - 00000000e0000000
Nosave address range: 00000000e0000000 - 00000000f0000000
Nosave address range: 00000000f0000000 - 00000000fec00000
Nosave address range: 00000000fec00000 - 0000000100000000
Allocating PCI resources starting at d1000000 (gap: d0000000:10000000)
SMP: Allowing 2 CPUs, 0 hotplug CPUs
Built 1 zonelists.  Total pages: 1019245
Kernel command line: ro root=LABEL=/ vga=1 pci=nommconf
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
time.c: Using 25.000000 MHz WALL HPET GTOD HPET timer.
time.c: Detected 2405.453 MHz processor.
Console: colour VGA+ 80x50
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Checking aperture...
CPU 0: aperture @ 9c20000000 size 32 MB
Aperture too small (32 MB)
No AGP bridge found
Your BIOS doesn't leave a aperture memory hole
Please enable the IOMMU option in the BIOS setup
This costs you 64 MB of RAM
Mapping aperture over 65536 KB of RAM @ 8000000
Memory: 4003372k/4980736k available (2409k kernel code, 156688k reserved, 1722k data, 204k init)
Calibrating delay using timer specific routine.. 4815.99 BogoMIPS (lpj=9631996)
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
result 12528415
Detected 12.528 MHz APIC timer.
SMP alternatives: switching to SMP code
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 4810.10 BogoMIPS (lpj=9620212)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU 1/1 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
AMD Athlon(tm) 64 X2 Dual Core Processor 4600+ stepping 02
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff 0 cycles, maxerr 675 cycles)
Brought up 2 CPUs
testing NMI watchdog ... OK.
sizeof(vma)=176 bytes
sizeof(page)=64 bytes
sizeof(inode)=720 bytes
sizeof(dentry)=232 bytes
sizeof(ext3inode)=968 bytes
sizeof(buffer_head)=96 bytes
sizeof(skbuff)=240 bytes
sizeof(task_struct)=1936 bytes
migration_cost=225
checking if image is initramfs... it is
Freeing initrd memory: 1514k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:05.0
PCI: Transparent bridge - 0000:00:10.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK2] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK3] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK4] (IRQs *5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK6] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK7] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LNK8] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs *5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LMAC] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LAZA] (IRQs *5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LPMU] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LMCI] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LIDE] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSID] (IRQs *5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LFID] (IRQs *5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC6] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC7] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC8] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APMU] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [AAZA] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 18 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
hpet0: at MMIO 0xfefff000 (virtual 0xffffffffff5fe000), IRQs 2, 8, 31
hpet0: 3 32-bit timers, 25000000 Hz
PCI-DMA: Disabling AGP.
PCI-DMA: aperture base @ 8000000 size 65536 KB
PCI-DMA: using GART IOMMU.
PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
pnp: 00:01: ioport range 0x4000-0x407f could not be reserved
pnp: 00:01: ioport range 0x4080-0x40ff has been reserved
pnp: 00:01: ioport range 0x4400-0x447f has been reserved
pnp: 00:01: ioport range 0x4480-0x44ff could not be reserved
pnp: 00:01: ioport range 0x4800-0x487f has been reserved
pnp: 00:01: ioport range 0x4880-0x48ff has been reserved
pnp: 00:01: ioport range 0x2000-0x207f has been reserved
pnp: 00:01: ioport range 0x2080-0x20ff has been reserved
PCI: Bridge: 0000:00:02.0
  IO window: a000-afff
  MEM window: fd800000-fd8fffff
  PREFETCH window: fd700000-fd7fffff
PCI: Bridge: 0000:00:03.0
  IO window: 8000-8fff
  MEM window: fde00000-fdefffff
  PREFETCH window: fdd00000-fddfffff
PCI: Bridge: 0000:00:04.0
  IO window: b000-bfff
  MEM window: fdc00000-fdcfffff
  PREFETCH window: fd900000-fd9fffff
PCI: Bridge: 0000:00:10.0
  IO window: 9000-9fff
  MEM window: fdb00000-fdbfffff
  PREFETCH window: fda00000-fdafffff
PCI: Setting latency timer of device 0000:00:02.0 to 64
PCI: Setting latency timer of device 0000:00:03.0 to 64
PCI: Setting latency timer of device 0000:00:04.0 to 64
PCI: Setting latency timer of device 0000:00:10.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
TCP established hash table entries: 131072 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
audit: initializing netlink socket (disabled)
audit(1162219372.540:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key 4D36EEF71C3A3150
- User ID: Red Hat, Inc. (Kernel Module GPG key)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: Setting latency timer of device 0000:00:02.0 to 64
pcie_portdrv_probe->Dev[02fc:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:02.0:pcie00]
PCI: Setting latency timer of device 0000:00:03.0 to 64
pcie_portdrv_probe->Dev[02fd:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:03.0:pcie00]
PCI: Setting latency timer of device 0000:00:04.0 to 64
pcie_portdrv_probe->Dev[02fb:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:04.0:pcie00]
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: Fan [FAN] (on)
ACPI: Thermal Zone [THRM] (40 C)
Real Time Clock Driver v1.12ac
hpet_resources: 0xfefff000 is busy
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:0a: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 4096 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE-MCP51: IDE controller at PCI slot 0000:00:0d.0
NFORCE-MCP51: chipset revision 161
NFORCE-MCP51: not 100% native mode: will probe irqs later
NFORCE-MCP51: 0000:00:0d.0 (rev a1) UDMA133 controller
    ide0: BM-DMA at 0xf400-0xf407, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf408-0xf40f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hdb: LITE-ON DVD SOHD-16P9S, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
ide-floppy driver 0.99.newide
usbcore: registered new driver libusual
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow-k8: Found 2 AMD Athlon(tm) 64 X2 Dual Core Processor 4600+ processors (version 2.00.00)
powernow-k8: MP systems not supported by PSB BIOS structure
powernow-k8: MP systems not supported by PSB BIOS structure
ACPI: (supports S0 S1 S3 S4 S5)
Freeing unused kernel memory: 204k freed
Write protecting the kernel read-only data: 462k
input: AT Translated Set 2 keyboard as /class/input/input0
logips2pp: Detected unknown logitech mouse model 0
USB Universal Host Controller Interface driver v3.0
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 23
GSI 16 sharing vector 0xC9 and IRQ 16
ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [APCF] -> GSI 23 (level, low) -> IRQ 201
PCI: Setting latency timer of device 0000:00:0b.0 to 64
ohci_hcd 0000:00:0b.0: OHCI Host Controller
ohci_hcd 0000:00:0b.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:0b.0: irq 201, io mem 0xfe02f000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 22
GSI 17 sharing vector 0xD1 and IRQ 17
ACPI: PCI Interrupt 0000:00:0b.1[B] -> Link [APCL] -> GSI 22 (level, low) -> IRQ 209
PCI: Setting latency timer of device 0000:00:0b.1 to 64
ehci_hcd 0000:00:0b.1: EHCI Host Controller
ehci_hcd 0000:00:0b.1: new USB bus registered, assigned bus number 2
ehci_hcd 0000:00:0b.1: debug port 1
PCI: cache line size of 64 is not supported by device 0000:00:0b.1
ehci_hcd 0000:00:0b.1: irq 209, io mem 0xfe02e000
ehci_hcd 0000:00:0b.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 8 ports detected
SCSI subsystem initialized
libata version 2.00 loaded.
sata_nv 0000:00:0e.0: version 2.0
ACPI: PCI Interrupt Link [APSI] enabled at IRQ 21
GSI 18 sharing vector 0xD9 and IRQ 18
ACPI: PCI Interrupt 0000:00:0e.0[A] -> Link [APSI] -> GSI 21 (level, low) -> IRQ 217
PCI: Setting latency timer of device 0000:00:0e.0 to 64
ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xE000 irq 217
ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xE008 irq 217
scsi0 : sata_nv
input: PS/2 Logitech Mouse as /class/input/input1
usb 2-4: new high speed USB device using ehci_hcd and address 2
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7, max UDMA/133, 586112591 sectors: LBA48 NCQ (depth 0/32)
ata1.00: ata1: dev 0 multi count 1
ata1.00: configured for UDMA/133
scsi1 : sata_nv
usb 2-4: configuration #1 chosen from 1 choice
libusual: modprobe for usb-storage succeeded, but module is not present
ohci_hcd 0000:00:0b.0: wakeup
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATA-7, max UDMA/133, 586114704 sectors: LBA48 NCQ (depth 0/32)
ata2.00: ata2: dev 0 multi count 1
ata2.00: configured for UDMA/133
  Vendor: ATA       Model: Maxtor 7L300S0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 586112591 512-byte hdwr sectors (300090 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 586112591 512-byte hdwr sectors (300090 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
sd 0:0:0:0: Attached scsi disk sda
  Vendor: ATA       Model: Maxtor 7L300S0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 586114704 512-byte hdwr sectors (300091 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 586114704 512-byte hdwr sectors (300091 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1
sd 1:0:0:0: Attached scsi disk sdb
ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 20
GSI 19 sharing vector 0xE1 and IRQ 19
ACPI: PCI Interrupt 0000:00:0f.0[A] -> Link [APSJ] -> GSI 20 (level, low) -> IRQ 225
PCI: Setting latency timer of device 0000:00:0f.0 to 64
ata3: SATA max UDMA/133 cmd 0x9E0 ctl 0xBE2 bmdma 0xCC00 irq 225
ata4: SATA max UDMA/133 cmd 0x960 ctl 0xB62 bmdma 0xCC08 irq 225
scsi2 : sata_nv
usb 1-7: new full speed USB device using ohci_hcd and address 2
usb 1-7: device descriptor read/64, error -110
usb 1-7: device descriptor read/64, error -110
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.00: ATA-7, max UDMA/133, 586114704 sectors: LBA48 NCQ (depth 0/32)
ata3.00: ata3: dev 0 multi count 1
ata3.00: configured for UDMA/133
scsi3 : sata_nv
usb 1-7: new full speed USB device using ohci_hcd and address 3
usb 1-7: device descriptor read/64, error -110
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: ATA-7, max UDMA/133, 586114704 sectors: LBA48 NCQ (depth 0/32)
ata4.00: ata4: dev 0 multi count 1
ata4.00: configured for UDMA/133
  Vendor: ATA       Model: Maxtor 7L300S0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdc: 586114704 512-byte hdwr sectors (300091 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
SCSI device sdc: 586114704 512-byte hdwr sectors (300091 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
 sdc: sdc1 sdc2 sdc3
sd 2:0:0:0: Attached scsi disk sdc
  Vendor: ATA       Model: Maxtor 7L300S0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdd: 586114704 512-byte hdwr sectors (300091 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back
SCSI device sdd: 586114704 512-byte hdwr sectors (300091 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back
 sdd:<3>usb 1-7: device descriptor read/64, error -110
 sdd1
sd 3:0:0:0: Attached scsi disk sdd
usb 1-7: new full speed USB device using ohci_hcd and address 4
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
usb 1-7: device not accepting address 4, error -110
usb 1-7: new full speed USB device using ohci_hcd and address 5
usb 1-7: device not accepting address 5, error -110
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
audit(1162219380.552:2): selinux=0 auid=4294967295
ieee1394: Initialized config rom entry `ip1394'
input: PC Speaker as /class/input/input2
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.56.
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:14.0[A] -> Link [APCH] -> GSI 23 (level, low) -> IRQ 201
PCI: Setting latency timer of device 0000:00:14.0 to 64
forcedeth: using HIGHDMA
EDAC MC: Ver: 2.0.1 Oct 16 2006
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 1:0:0:0: Attached scsi generic sg1 type 0
sd 2:0:0:0: Attached scsi generic sg2 type 0
sd 3:0:0:0: Attached scsi generic sg3 type 0
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
hdb: ATAPI 48X DVD-ROM drive, 254kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
eth0: forcedeth.c: subsystem: 01043:816a bound to 0000:00:14.0
ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
GSI 20 sharing vector 0xE9 and IRQ 20
ACPI: PCI Interrupt 0000:04:05.0[A] -> Link [APC4] -> GSI 19 (level, low) -> IRQ 233
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[233]  MMIO=[fdbff000-fdbff7ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
ACPI: PCI Interrupt Link [AAZA] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:10.1[B] -> Link [AAZA] -> GSI 22 (level, low) -> IRQ 209
PCI: Setting latency timer of device 0000:00:10.1 to 64
EDAC MC0: Giving out device to k8_edac Athlon64/Opteron: DEV 0000:00:18.2
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x4c00
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x4c40
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE,EPP]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0011d80000b5a029]
lp0: using parport0 (interrupt-driven).
lp0: console ready
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ibm_acpi: ec object not found
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdd1 ...
md:  adding sdd1 ...
md:  adding sdb1 ...
md: created md0
md: bind<sdb1>
md: bind<sdd1>
md: running: <sdd1><sdb1>
md: raid0 personality registered for level 0
md0: setting max_sectors to 128, segment boundary to 32767
raid0: looking at sdd1
raid0:   comparing sdd1(293049600) with sdd1(293049600)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at sdb1
raid0:   comparing sdb1(293049600) with sdd1(293049600)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 586099200 blocks.
raid0 : conf->hash_spacing is 586099200 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: ... autorun DONE.
device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised: dm-devel@redhat.com
EXT3 FS on sda3, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdc1, internal journal
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdc3, internal journal
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md0, internal journal
EXT3-fs: mounted filesystem with writeback data mode.
Adding 3068404k swap on /dev/sda2.  Priority:-1 extents:1 across:3068404k
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
audit(1162248197.430:3): audit_pid=2057 old=0 by auid=4294967295
eth0: no IPv6 routers present
usb 2-8: new high speed USB device using ehci_hcd and address 4
usb 2-8: configuration #1 chosen from 1 choice
Initializing USB Mass Storage driver...
scsi4 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 2
usb-storage: waiting for device to settle before scanning
scsi5 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 4
usb-storage: waiting for device to settle before scanning
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
  Vendor:           Model: USB DISK 25X      Rev: PMAP
  Type:   Direct-Access                      ANSI SCSI revision: 00
  Vendor: Maxtor    Model: OneTouch II       Rev: 023g
  Type:   Direct-Access                      ANSI SCSI revision: 04
SCSI device sdf: 586114704 512-byte hdwr sectors (300091 MB)
sdf: Write Protect is off
sdf: Mode Sense: 24 00 00 00
sdf: assuming drive cache: write through
SCSI device sde: 251904 512-byte hdwr sectors (129 MB)
sde: Write Protect is off
sde: Mode Sense: 23 00 00 00
sde: assuming drive cache: write through
SCSI device sde: 251904 512-byte hdwr sectors (129 MB)
sde: Write Protect is off
sde: Mode Sense: 23 00 00 00
sde: assuming drive cache: write through
 sde: sde1 sde2
sd 5:0:0:0: Attached scsi removable disk sde
sd 5:0:0:0: Attached scsi generic sg4 type 0
usb-storage: device scan complete
SCSI device sdf: 586114704 512-byte hdwr sectors (300091 MB)
sdf: Write Protect is off
sdf: Mode Sense: 24 00 00 00
sdf: assuming drive cache: write through
 sdf: sdf1
sd 4:0:0:0: Attached scsi disk sdf
sd 4:0:0:0: Attached scsi generic sg5 type 0
usb-storage: device scan complete
usb 2-8: USB disconnect, address 4
usb 2-5: new high speed USB device using ehci_hcd and address 5
usb 2-5: configuration #1 chosen from 1 choice
scsi6 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 5
usb-storage: waiting for device to settle before scanning
  Vendor:           Model: USB DISK 25X      Rev: PMAP
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sde: 251904 512-byte hdwr sectors (129 MB)
sde: Write Protect is off
sde: Mode Sense: 23 00 00 00
sde: assuming drive cache: write through
SCSI device sde: 251904 512-byte hdwr sectors (129 MB)
sde: Write Protect is off
sde: Mode Sense: 23 00 00 00
sde: assuming drive cache: write through
 sde: sde1 sde2
sd 6:0:0:0: Attached scsi removable disk sde
sd 6:0:0:0: Attached scsi generic sg4 type 0
usb-storage: device scan complete
usb 2-5: USB disconnect, address 5
ohci_hcd 0000:00:0b.0: wakeup
usb 1-7: new full speed USB device using ohci_hcd and address 6
usb 1-7: device descriptor read/64, error -110
usb 1-7: device descriptor read/64, error -110
usb 1-7: new full speed USB device using ohci_hcd and address 7
usb 1-7: device descriptor read/64, error -110
usb 1-7: device descriptor read/64, error -110
usb 1-7: new full speed USB device using ohci_hcd and address 8
usb 1-7: device not accepting address 8, error -110
usb 1-7: new full speed USB device using ohci_hcd and address 9
usb 1-7: device not accepting address 9, error -110
usb 2-8: new high speed USB device using ehci_hcd and address 7
usb 2-8: configuration #1 chosen from 1 choice
scsi7 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 7
usb-storage: waiting for device to settle before scanning
  Vendor:           Model: USB DISK 25X      Rev: PMAP
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sde: 251904 512-byte hdwr sectors (129 MB)
sde: Write Protect is off
sde: Mode Sense: 23 00 00 00
sde: assuming drive cache: write through
SCSI device sde: 251904 512-byte hdwr sectors (129 MB)
sde: Write Protect is off
sde: Mode Sense: 23 00 00 00
sde: assuming drive cache: write through
 sde: sde1 sde2
sd 7:0:0:0: Attached scsi removable disk sde
sd 7:0:0:0: Attached scsi generic sg4 type 0
usb-storage: device scan complete
usb 2-8: USB disconnect, address 7
ohci_hcd 0000:00:0b.0: wakeup
usb 1-6: new full speed USB device using ohci_hcd and address 10
usb 1-6: device descriptor read/64, error -110
usb 1-6: device descriptor read/64, error -110
usb 1-6: new full speed USB device using ohci_hcd and address 11
usb 1-6: device descriptor read/64, error -110
usb 1-6: device descriptor read/64, error -110
usb 1-6: new full speed USB device using ohci_hcd and address 12
usb 1-6: device not accepting address 12, error -110
usb 1-6: new full speed USB device using ohci_hcd and address 13
usb 1-6: device not accepting address 13, error -110


