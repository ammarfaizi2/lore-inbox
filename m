Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbTHXUzY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 16:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbTHXUzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 16:55:24 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:13819 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261314AbTHXUyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 16:54:47 -0400
Message-ID: <3F492601.7090405@comcast.net>
Date: Sun, 24 Aug 2003 16:54:25 -0400
From: David van Hoose <david.vanhoose@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test4: ACPI breaks IDE/USB
References: <1061613751.897.12.camel@kahlua> <3F478636.3060002@cox.net>
In-Reply-To: <3F478636.3060002@cox.net>
Content-Type: multipart/mixed;
 boundary="------------040801010707040606030003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040801010707040606030003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Kevin P. Fleming wrote:
> Peter Lieverdink wrote:
> 
>> When I enable ACPI on 2.6.0-test4 (also on 2.6.0-test3-*), the kernel no
>> longer recognises my IDE controller and drops down to PIO mode for
>> harddisk access. Additionally, USB devices don't get detected.
> 
> I'm running -test4 here with ACPI and have no trouble with USB devices.

I'm running test4 here with ACPI and have no USB following a call trace
with "IRQ 20: nobody cared". ACPI seems to make odd reports. I've been
having this problem since 2.5.70'ish. Posted numerous times, but nobody
seems to care about it. I also have a PS/2 mouse detection when I have
no mice attached to my system.

>> The system is an Athlon 2400+ on a Gibabyte GA-7VAXP mainboard. (KT400)
> 
> My system is an Athlon 1000 on an MSI KT266-based board.

I have a Pentium 4 2.53 GHz on a Asus P4S8X mainboard.

-David

PS. dmesg is attached with ACPI debug and USB debug enabled.


--------------040801010707040606030003
Content-Type: text/plain;
 name="dmesg-2.6.0-test4"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-2.6.0-test4"

Linux version 2.6.0-test4 (root@aeon) (gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #1 Sat Aug 23 11:59:23 EDT 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fffc000 (usable)
 BIOS-e820: 000000001fffc000 - 000000001ffff000 (ACPI data)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
On node 0 totalpages: 131068
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126972 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f5810
ACPI: RSDT (v001 ASUS   P4S8X    0x42302e31 MSFT 0x31313031) @ 0x1fffc000
ACPI: FADT (v001 ASUS   P4S8X    0x42302e31 MSFT 0x31313031) @ 0x1fffc0c0
ACPI: BOOT (v001 ASUS   P4S8X    0x42302e31 MSFT 0x31313031) @ 0x1fffc030
ACPI: MADT (v001 ASUS   P4S8X    0x42302e31 MSFT 0x31313031) @ 0x1fffc058
ACPI: DSDT (v001   ASUS P4S8X    0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 128, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x1])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x14] polarity[0x3] trigger[0x3])
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Building zonelist for node : 0
Kernel command line: ro root=LABEL=/ parport=auto nmi_watchdog=1 3
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 2533.827 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 5013.50 BogoMIPS
Memory: 513496k/524272k available (2455k kernel code, 10008k reserved, 1052k data, 164k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU:     After generic identify, caps: 3febfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 3febfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After all inits, caps: 3febfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
CPU: Intel(R) Pentium(R) 4 CPU 2.53GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-9, 2-16, 2-17, 2-18, 2-19, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
activating NMI Watchdog ... done.
testing NMI watchdog ... OK.
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178080
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0080
.... register #02: 02000000
.......     : arbitration: 02
.... register #03: 00000001
.......     : Boot DT    : 1
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 000 00  1    0    0   0   0    0    0    00
 0a 001 01  0    0    0   0   0    1    1    71
 0b 001 01  0    0    0   0   0    1    1    79
 0c 001 01  0    0    0   0   0    1    1    81
 0d 001 01  0    0    0   0   0    1    1    89
 0e 001 01  0    0    0   0   0    1    1    91
 0f 001 01  0    0    0   0   0    1    1    99
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 001 01  1    1    0   1   0    1    1    A1
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:20
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2532.0662 MHz.
..... host bus clock speed is 133.0297 MHz.
PM: Adding info for No Bus:legacy
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xf11b0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030813
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:....................................................................................................................................
Table [DSDT](id F004) - 326 Objects with 47 Devices 132 Methods 6 Regions
ACPI Namespace successfully loaded at root c052c4dc
IOAPIC[0]: Set PCI routing entry (2-20 -> 0xa9 -> IRQ 20 Mode:1 Active:1)
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at 000000000000E420 on int 9
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 16 to 31 [_GPE] 2 regs at 000000000000E430 on int 9
Completing Region/Field/Buffer/Package initialization:........................................
Initialized 6/6 Regions 0/0 Fields 23/23 Buffers 11/11 Packages (334 nodes)
Executing all Device _STA and_INI methods:................................................
48 Devices found containing: 48 _STA, 1 _INI methods
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 12 14 15, enabled at IRQ 9)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15, enabled at IRQ 9)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15, enabled at IRQ 9)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15, enabled at IRQ 9)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 14 15, enabled at IRQ 9)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PM: Adding info for No Bus:pci0000:00
Enabling SiS 96x SMBus.
PM: Adding info for pci:0000:00:00.0
PM: Adding info for pci:0000:00:01.0
PM: Adding info for pci:0000:00:02.0
PM: Adding info for pci:0000:00:02.1
PM: Adding info for pci:0000:00:02.3
PM: Adding info for pci:0000:00:02.5
PM: Adding info for pci:0000:00:02.7
PM: Adding info for pci:0000:00:03.0
PM: Adding info for pci:0000:00:03.1
PM: Adding info for pci:0000:00:03.2
PM: Adding info for pci:0000:00:03.3
PM: Adding info for pci:0000:00:04.0
PM: Adding info for pci:0000:00:0b.0
PM: Adding info for pci:0000:00:0e.0
PM: Adding info for pci:0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f9680
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x96b0, dseg 0xf0000
PM: Adding info for No Bus:pnp0
PM: Adding info for pnp:00:01
PM: Adding info for pnp:00:02
PM: Adding info for pnp:00:03
PM: Adding info for pnp:00:05
PM: Adding info for pnp:00:06
PM: Adding info for pnp:00:07
PM: Adding info for pnp:00:09
PM: Adding info for pnp:00:0a
PM: Adding info for pnp:00:0b
PM: Adding info for pnp:00:0c
PM: Adding info for pnp:00:0d
PM: Adding info for pnp:00:0e
PM: Adding info for pnp:00:0f
PM: Adding info for pnp:00:10
PM: Adding info for pnp:00:11
PM: Adding info for pnp:00:12
PnPBIOS: 16 nodes reported by PnP BIOS; 16 recorded by driver
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xb1 -> IRQ 16 Mode:1 Active:1)
00:00:02[A] -> 2-16 -> IRQ 16
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb9 -> IRQ 17 Mode:1 Active:1)
00:00:02[B] -> 2-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xc1 -> IRQ 18 Mode:1 Active:1)
00:00:02[C] -> 2-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc9 -> IRQ 19 Mode:1 Active:1)
00:00:02[D] -> 2-19 -> IRQ 19
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xd1 -> IRQ 21 Mode:1 Active:1)
00:00:03[B] -> 2-21 -> IRQ 21
IOAPIC[0]: Set PCI routing entry (2-22 -> 0xd9 -> IRQ 22 Mode:1 Active:1)
00:00:03[C] -> 2-22 -> IRQ 22
IOAPIC[0]: Set PCI routing entry (2-23 -> 0xe1 -> IRQ 23 Mode:1 Active:1)
00:00:03[D] -> 2-23 -> IRQ 23
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
 pci_irq-0299 [19] acpi_pci_irq_derive   : Unable to derive IRQ for device 0000:00:03.0
ACPI: No IRQ known for interrupt pin A of device 0000:00:03.0
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
pty: 256 Unix98 ptys configured
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
VFS: Disk quotas dquot_6.5.1
Journalled Block Device driver loaded
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
acpi_processor-1626 [22] acpi_processor_get_inf: Invalid PBLK length [5]
ACPI: Processor [CPU0] (supports C1)
PM: Adding info for No Bus:pnp1
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.11a
parport0: PC-style at 0x378 (0x778), irq 7, using FIFO [PCSPP,TRISTATE,COMPAT,EPP,ECP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
Using anticipatory scheduling elevator
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
PM: Adding info for platform:floppy0
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
    ide0: BM-DMA at 0xb400-0xb407, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xb408-0xb40f, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 6Y080P0, ATA DISK drive
PM: Adding info for No Bus:ide0
hdb: Maxtor 53073H6, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
PM: Adding info for ide:0.0
PM: Adding info for ide:0.1
hdc: ASUS CD-S500/A, ATAPI CD/DVD-ROM drive
PM: Adding info for No Bus:ide1
ide1 at 0x170-0x177,0x376 on irq 15
PM: Adding info for ide:1.0
hda: max request size: 128KiB
hda: 160086528 sectors (81964 MB) w/7936KiB Cache, CHS=65535/16/63, UDMA(133)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
hdb: max request size: 128KiB
hdb: 60030432 sectors (30735 MB) w/2048KiB Cache, CHS=59554/16/63, UDMA(100)
 hdb: hdb1
hdc: ATAPI 50X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
ide-floppy driver 0.99.newide
PM: Adding info for No Bus:ide-scsi
ppa: Version 2.07 (for Linux 2.4.x)
ppa: Found device at ID 6, Attempting to use EPP 32 bit
ppa: Communication established with ID 6 using EPP 32 bit
scsi0 : Iomega VPI0 (ppa) interface
PM: Adding info for No Bus:host0
  Vendor: IOMEGA    Model: ZIP 100           Rev: D.09
  Type:   Direct-Access                      ANSI SCSI revision: 02
PM: Adding info for scsi:0:0:6:0
Attached scsi removable disk sda at scsi0, channel 0, id 6, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 6, lun 0,  type 0
ehci_hcd: block sizes: qh 128 qtd 96 itd 128 sitd 64
ehci_hcd 0000:00:03.3: EHCI Host Controller
ehci_hcd 0000:00:03.3: reset hcs_params 0x103206 dbg=1 cc=3 pcc=2 ordered !ppc ports=6
ehci_hcd 0000:00:03.3: reset hcc_params 7070 thresh 7 uframes 1024
ehci_hcd 0000:00:03.3: capability 0001 at 70
ehci_hcd 0000:00:03.3: irq 23, pci mem e081c000
ehci_hcd 0000:00:03.3: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:03.3: reset command 080002 (park)=0 ithresh=8 period=1024 Reset HALT
PCI: cache line size of 128 is not supported by device 0000:00:03.3
ehci_hcd 0000:00:03.3: init command 010001 (park)=0 ithresh=1 period=1024 RUN
ehci_hcd 0000:00:03.3: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
ehci_hcd 0000:00:03.3: root hub device address 1
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/message.c: USB device number 1 default language ID 0x409
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.0-test4 ehci_hcd
usb usb1: SerialNumber: 0000:00:03.3
drivers/usb/core/usb.c: usb_hotplug
PM: Adding info for usb:usb1
usb usb1: usb_new_device - registering interface 1-0:0
drivers/usb/core/usb.c: usb_hotplug
hub 1-0:0: usb_probe_interface
hub 1-0:0: usb_probe_interface - got id
hub 1-0:0: USB hub found
hub 1-0:0: 6 ports detected
hub 1-0:0: standalone hub
hub 1-0:0: ganged power switching
hub 1-0:0: individual port over-current protection
hub 1-0:0: Single TT
hub 1-0:0: TT requires at most 8 FS bit times
hub 1-0:0: Port indicators are not supported
hub 1-0:0: power on to power good time: 0ms
hub 1-0:0: hub controller current requirement: 0mA
hub 1-0:0: local power source is good
hub 1-0:0: no over-current condition exists
hub 1-0:0: enabling power on all ports
PM: Adding info for usb:1-0:0
ohci-hcd: 2003 Feb 24 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci-hcd: block sizes: ed 64 td 64
 pci_irq-0299 [18] acpi_pci_irq_derive   : Unable to derive IRQ for device 0000:00:03.0
ACPI: No IRQ known for interrupt pin A of device 0000:00:03.0
ohci-hcd 0000:00:03.0: OHCI Host Controller
ohci-hcd 0000:00:03.0: irq 9, pci mem e081e000
ohci-hcd 0000:00:03.0: new USB bus registered, assigned bus number 2
ohci-hcd 0000:00:03.0: reset, control = 0x0
ohci-hcd 0000:00:03.0: root hub device address 1
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/message.c: USB device number 1 default language ID 0x409
usb usb2: Product: OHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.0-test4 ohci-hcd
usb usb2: SerialNumber: 0000:00:03.0
drivers/usb/core/usb.c: usb_hotplug
PM: Adding info for usb:usb2
usb usb2: usb_new_device - registering interface 2-0:0
drivers/usb/core/usb.c: usb_hotplug
hub 2-0:0: usb_probe_interface
hub 2-0:0: usb_probe_interface - got id
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
hub 2-0:0: standalone hub
hub 2-0:0: ganged power switching
hub 2-0:0: global over-current protection
hub 2-0:0: Port indicators are not supported
hub 2-0:0: power on to power good time: 2ms
hub 2-0:0: hub controller current requirement: 0mA
hub 2-0:0: local power source is good
hub 2-0:0: no over-current condition exists
hub 2-0:0: enabling power on all ports
PM: Adding info for usb:2-0:0
ohci-hcd 0000:00:03.0: created debug files
ohci-hcd 0000:00:03.0: OHCI controller state
ohci-hcd 0000:00:03.0: OHCI 1.0, with legacy support registers
ohci-hcd 0000:00:03.0: control 0x08f HCFS=operational IE PLE CBSR=3
ohci-hcd 0000:00:03.0: cmdstatus 0x00000 SOC=0
ohci-hcd 0000:00:03.0: intrstatus 0x00000004 SF
ohci-hcd 0000:00:03.0: intrenable 0x80000002 MIE WDH
ohci-hcd 0000:00:03.0: hcca frame #0011
ohci-hcd 0000:00:03.0: roothub.a 01000202 POTPGT=1 NPS NDP=2
ohci-hcd 0000:00:03.0: roothub.b 00000000 PPCM=0000 DR=0000
ohci-hcd 0000:00:03.0: roothub.status 00000000
ohci-hcd 0000:00:03.0: roothub.portstatus [0] 0x00000100 PPS
ohci-hcd 0000:00:03.0: roothub.portstatus [1] 0x00000100 PPS
ohci-hcd 0000:00:03.1: OHCI Host Controller
ohci-hcd 0000:00:03.1: irq 21, pci mem e0820000
ohci-hcd 0000:00:03.1: new USB bus registered, assigned bus number 3
ohci-hcd 0000:00:03.1: reset, control = 0x0
ohci-hcd 0000:00:03.1: root hub device address 1
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/message.c: USB device number 1 default language ID 0x409
usb usb3: Product: OHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.0-test4 ohci-hcd
usb usb3: SerialNumber: 0000:00:03.1
drivers/usb/core/usb.c: usb_hotplug
PM: Adding info for usb:usb3
usb usb3: usb_new_device - registering interface 3-0:0
drivers/usb/core/usb.c: usb_hotplug
hub 3-0:0: usb_probe_interface
hub 3-0:0: usb_probe_interface - got id
hub 3-0:0: USB hub found
hub 3-0:0: 2 ports detected
hub 3-0:0: standalone hub
hub 3-0:0: ganged power switching
hub 3-0:0: global over-current protection
hub 3-0:0: Port indicators are not supported
hub 3-0:0: power on to power good time: 2ms
hub 3-0:0: hub controller current requirement: 0mA
hub 3-0:0: local power source is good
hub 3-0:0: no over-current condition exists
hub 3-0:0: enabling power on all ports
PM: Adding info for usb:3-0:0
ohci-hcd 0000:00:03.1: created debug files
ohci-hcd 0000:00:03.1: OHCI controller state
ohci-hcd 0000:00:03.1: OHCI 1.0, with legacy support registers
ohci-hcd 0000:00:03.1: control 0x08f HCFS=operational IE PLE CBSR=3
ohci-hcd 0000:00:03.1: cmdstatus 0x00000 SOC=0
ohci-hcd 0000:00:03.1: intrstatus 0x00000004 SF
ohci-hcd 0000:00:03.1: intrenable 0x80000002 MIE WDH
ohci-hcd 0000:00:03.1: hcca frame #0011
ohci-hcd 0000:00:03.1: roothub.a 01000202 POTPGT=1 NPS NDP=2
ohci-hcd 0000:00:03.1: roothub.b 00000000 PPCM=0000 DR=0000
ohci-hcd 0000:00:03.1: roothub.status 00000000
ohci-hcd 0000:00:03.1: roothub.portstatus [0] 0x00000100 PPS
ohci-hcd 0000:00:03.1: roothub.portstatus [1] 0x00000100 PPS
ohci-hcd 0000:00:03.2: OHCI Host Controller
ohci-hcd 0000:00:03.2: irq 22, pci mem e0822000
ohci-hcd 0000:00:03.2: new USB bus registered, assigned bus number 4
ohci-hcd 0000:00:03.2: reset, control = 0x0
ohci-hcd 0000:00:03.2: root hub device address 1
usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/message.c: USB device number 1 default language ID 0x409
usb usb4: Product: OHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.0-test4 ohci-hcd
usb usb4: SerialNumber: 0000:00:03.2
drivers/usb/core/usb.c: usb_hotplug
PM: Adding info for usb:usb4
usb usb4: usb_new_device - registering interface 4-0:0
drivers/usb/core/usb.c: usb_hotplug
hub 4-0:0: usb_probe_interface
hub 4-0:0: usb_probe_interface - got id
hub 4-0:0: USB hub found
hub 4-0:0: 2 ports detected
hub 4-0:0: standalone hub
hub 4-0:0: ganged power switching
hub 4-0:0: global over-current protection
hub 4-0:0: Port indicators are not supported
hub 4-0:0: power on to power good time: 2ms
hub 4-0:0: hub controller current requirement: 0mA
hub 4-0:0: local power source is good
hub 4-0:0: no over-current condition exists
hub 4-0:0: enabling power on all ports
PM: Adding info for usb:4-0:0
ohci-hcd 0000:00:03.2: created debug files
ohci-hcd 0000:00:03.2: OHCI controller state
ohci-hcd 0000:00:03.2: OHCI 1.0, with legacy support registers
ohci-hcd 0000:00:03.2: control 0x08f HCFS=operational IE PLE CBSR=3
ohci-hcd 0000:00:03.2: cmdstatus 0x00000 SOC=0
ohci-hcd 0000:00:03.2: intrstatus 0x00000004 SF
ohci-hcd 0000:00:03.2: intrenable 0x80000002 MIE WDH
ohci-hcd 0000:00:03.2: hcca frame #0011
ohci-hcd 0000:00:03.2: roothub.a 01000202 POTPGT=1 NPS NDP=2
ohci-hcd 0000:00:03.2: roothub.b 00000000 PPCM=0000 DR=0000
ohci-hcd 0000:00:03.2: roothub.status 00000000
ohci-hcd 0000:00:03.2: roothub.portstatus [0] 0x00000100 PPS
ohci-hcd 0000:00:03.2: roothub.portstatus [1] 0x00000100 PPS
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
drivers/usb/core/usb.c: registered new driver usbscanner
drivers/usb/image/scanner.c: 0.4.14:USB Scanner Driver
mice: PS/2 mouse device common for all mice
input: PC Speaker
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
LLC 2.0 by Procom, 1997, Arnaldo C. Melo, 2001, 2002
NET 4.0 IEEE 802.2 extended support
NET4.0 IEEE 802.2 BSD sockets, Jay Schulist, 2001, Arnaldo C. Melo, 2002-2003
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 300 bytes per conntrack
ehci_hcd 0000:00:03.3: GetStatus port 1 status 001403 POWER sig=k  CSC CONNECT
hub 1-0:0: port 1, status 501, change 1, 480 Mb/s
ip_tables: (C) 2000-2002 Netfilter core team
Initializing IPsec netlink socket
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
ip6_tables: (C) 2000-2002 Netfilter core team
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 219k freed
VFS: Mounted root (ext2 filesystem).
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x501
ehci_hcd 0000:00:03.3: port 1 low speed --> companion
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
ehci_hcd 0000:00:03.3: GetStatus port 1 status 003002 POWER OWNER sig=se0  CSC
ehci_hcd 0000:00:03.3: GetStatus port 3 status 001803 POWER sig=j  CSC CONNECT
hub 1-0:0: port 3, status 501, change 1, 480 Mb/s
Freeing unused kernel memory: 164k freed
hub 1-0:0: debounce: port 3: delay 100ms stable 4 status 0x501
ehci_hcd 0000:00:03.3: port 3 full speed --> companion
ehci_hcd 0000:00:03.3: GetStatus port 3 status 003001 POWER OWNER sig=se0  CONNECT
ohci-hcd 0000:00:03.0: GetStatus roothub.portstatus [1] = 0x00010301 CSC LSDA PPS CCS
hub 2-0:0: port 1, status 301, change 1, 1.5 Mb/s
hub 2-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
ohci-hcd 0000:00:03.0: GetStatus roothub.portstatus [1] = 0x00100303 PRSC LSDA PPS PES CCS
hub 2-0:0: new USB device on port 1, assigned address 2
irq 20: nobody cared!
Call Trace:
 [<c010cf31>] __report_bad_irq+0x2b/0x8c
 [<c01ee469>] acpi_irq+0xf/0x1a
 [<c010d01a>] note_interrupt+0x69/0x99
 [<c010d2e6>] do_IRQ+0x14a/0x176
 [<c0108cb9>] default_idle+0x0/0x2c
 [<c0105000>] _stext+0x0/0x61
 [<c010b7ac>] common_interrupt+0x18/0x20
 [<c0108cb9>] default_idle+0x0/0x2c
 [<c0105000>] _stext+0x0/0x61
 [<c0108ce0>] default_idle+0x27/0x2c
 [<c0108d51>] cpu_idle+0x31/0x3a
 [<c04706e8>] start_kernel+0x17b/0x1a0
 [<c047043f>] unknown_bootoption+0x0/0xfa

handlers:
[<c01ee45a>] (acpi_irq+0x0/0x1a)
Disabling IRQ #20
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
EXT3 FS on hda2, internal journal
Adding 1004020k swap on /dev/hda5.  Priority:-1 extents:1
usb 2-1: control timeout on ep0out
intel8x0: clocking to 48000
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected SiS 648 chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 128M @ 0xe0000000
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kudzu: numerical sysctl 1 23 is obsolete.
ohci1394: $Rev: 1023 $ Ben Collins <bcollins@debian.org>
ohci1394_0: Unexpected PCI resource length of 1000!
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[17]  MMIO=[de800000-de8007ff]  Max Packet=[2048]
PM: Adding info for ieee1394:fw-host0
PM: Adding info for ieee1394:00e018000006d3df
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e018000006d3df]
Disabled Privacy Extensions on device c0423400(lo)
sis900.c: v1.08.06 9/24/2002
eth0: Realtek RTL8201 PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0x9800, IRQ 19, 00:e0:18:9d:4f:d0.
eth0: Media Link On 100mbps full-duplex 
Linux Tulip driver version 1.1.13 (May 11, 2002)
eth1: ADMtek Comet rev 17 at 0x9400, 00:20:78:04:68:6F, IRQ 19.
eth0: no IPv6 routers present
drivers/usb/serial/usb-serial.c: USB Serial support registered for Generic
drivers/usb/core/usb.c: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0


--------------040801010707040606030003--

