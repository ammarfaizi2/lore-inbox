Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753404AbWKFQme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404AbWKFQme (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 11:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753417AbWKFQme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 11:42:34 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:22674 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1753404AbWKFQmc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 11:42:32 -0500
Message-ID: <1162831350.454f65f6d4f08@imp2-g19.free.fr>
Date: Mon, 06 Nov 2006 17:42:30 +0100
From: Remi <remi.colinet@free.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc4-mm2: ahci: probe of 0000:00:1f.2 failed with error -16
References: <1162764770.454e61e2db5ff@imp3-g19.free.fr> <20061105161941.ec64ae70.akpm@osdl.org>
In-Reply-To: <20061105161941.ec64ae70.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.5
X-Originating-IP: 81.255.27.251
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Andrew Morton <akpm@osdl.org> wrote:

> On Sun, 05 Nov 2006 23:12:50 +0100
> Remi <remi.colinet@free.fr> wrote:
>
> > Hi all,
> >
> > I'm getting the following error with 2.6.19-rc4-mm2 on Dell D610.
> >
> > SCSI subsystem initialized
> > libata version 2.00 loaded.
> > ahci 0000:00:1f.2: version 2.0
> > ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 17 (level, low) -> IRQ 18
> > PCI: Unable to reserve I/O region #1:8@1f0 for device 0000:00:1f.2
> > ahci: probe of 0000:00:1f.2 failed with error -16
> > ata_piix 0000:00:1f.2: version 2.00ac7
> > ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
> > PCI: Unable to reserve I/O region #1:8@1f0 for device 0000:00:1f.2
> > ata_piix: probe of 0000:00:1f.2 failed with error -16
> > Kernel panic - not syncing: Attempted to kill init!
> >
> > A Google search doesn't help to fix this error.
> >
> > 2.6.19-rc4 boots fine with similar .config file.
> > Any idea (ahci, pci)?
> >
> > Should I start a bisecting search?
> >
> > I have caught the full 2.6.19-rc4-mm2 boot messages over a serial cable if
> it
> > can help.
> >
>
> Do you have CONFIG_USB_MULTITHREAD_PROBE=y?  If so, try =n.
>

# CONFIG_USB_MULTITHREAD_PROBE is not set

> Yes please send the full dmesg for both -rc4 and for -rc4-mm2, thanks.
>

First dmesg is for 2.6.19-rc4.


Linux version 2.6.19-rc4 (root@rco) (gcc version 4.1.1 20061011 (Red Hat
4.1.1-30)) #8 SMP PREEMPT Fri Nov 3 00:11:22 CET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003f7d1800 (usable)
 BIOS-e820: 000000003f7d1800 - 0000000040000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0007000 (reserved)
 BIOS-e820: 00000000f0008000 - 00000000f000c000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
1015MB LOWMEM available.
Entering add_active_range(0, 0, 260049) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   260049
early_node_map[1] active PFN ranges
    0:        0 ->   260049
On node 0 totalpages: 260049
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 1999 pages used for memmap
  Normal zone: 253954 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v000 DELL                                  ) @ 0x000fc9b0
ACPI: RSDT (v001 DELL    CPi R   0x27d50302 ASL  0x00000061) @ 0x3f7d1f90
ACPI: FADT (v001 DELL    CPi R   0x27d50302 ASL  0x00000061) @ 0x3f7d2c00
ACPI: MADT (v001 DELL    CPi R   0x27d50302 ASL  0x00000047) @ 0x3f7d3400
ACPI: ASF! (v016 DELL    CPi R   0x27d50302 ASL  0x00000061) @ 0x3f7d3000
ACPI: MCFG (v016 DELL    CPi R   0x27d50302 ASL  0x00000061) @ 0x3f7d33c0
ACPI: SSDT (v001  PmRef  Cpu0Ist 0x00003000 INTL 0x20030522) @ 0x3f7d23e6
ACPI: SSDT (v001  PmRef  Cpu0Cst 0x00003001 INTL 0x20030522) @ 0x3f7d220e
ACPI: SSDT (v001  PmRef    CpuPm 0x00003000 INTL 0x20030522) @ 0x3f7d2013
ACPI: DSDT (v001 INT430 SYSFexxx 0x00001001 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:13 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] disabled)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
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
Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
Detected 1995.068 MHz processor.
Built 1 zonelists.  Total pages: 258018
Kernel command line: root=/dev/sda6 single console=tty0 selinux=0 debug
earlyprintk=serial,ttyS0,9600
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=b13ae000 soft=b13a6000
PID hash table entries: 4096 (order: 12, 16384 bytes)
disabling early console
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1024872k/1040196k available (2056k kernel code, 14716k reserved, 1362k
data, 280k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xfffb7000 - 0xfffff000   ( 288 kB)
    vmalloc : 0xf0000000 - 0xfffb5000   ( 255 MB)
    lowmem  : 0xb0000000 - 0xef7d1000   (1015 MB)
      .init : 0xb135b000 - 0xb13a1000   ( 280 kB)
      .data : 0xb1202261 - 0xb1356bd4   (1362 kB)
      .text : 0xb1000000 - 0xb1202261   (2056 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3994.13 BogoMIPS (lpj=7988264)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: afe9fbff 00100000 00000000 00000000 00000180
00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: After all inits, caps: afe9fbff 00100000 00000000 00000040 00000180
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 12k freed
ACPI: Core revision 20060707
CPU0: Intel(R) Pentium(R) M processor 2.00GHz stepping 08
Total of 1 processors activated (3994.13 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
Brought up 1 CPUs
checking if image is initramfs... it is
Freeing initrd memory: 1463k freed
PM: Adding info for No Bus:platform
Time: 10:57:28  Date: 10/06/106
NET: Registered protocol family 16
EISA bus registered
ACPI: bus type pci registered
PCI: Using MMCONFIG
Setting up standard PCI resources
ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ LMPWR] OemTableId [ DELLLOM]
[20060707]
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
PM: Adding info for acpi:acpi
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PM: Adding info for No Bus:pci0000:00
Boot video device is 0000:00:02.0
PCI quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
PCI quirk: region 1080-10bf claimed by ICH6 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
PCI: Transparent bridge - 0000:00:1e.0
PCI: Bus #04 (-#07) is hidden behind transparent bridge #03 (-#04) (try
'pci=assign-busses')
Please report the result to linux-kernel to fix this permanently
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
PM: Adding info for pci:0000:00:00.0
PM: Adding info for pci:0000:00:02.0
PM: Adding info for pci:0000:00:02.1
PM: Adding info for pci:0000:00:1c.0
PM: Adding info for pci:0000:00:1d.0
PM: Adding info for pci:0000:00:1d.1
PM: Adding info for pci:0000:00:1d.2
PM: Adding info for pci:0000:00:1d.3
PM: Adding info for pci:0000:00:1d.7
PM: Adding info for pci:0000:00:1e.0
PM: Adding info for pci:0000:00:1e.2
PM: Adding info for pci:0000:00:1e.3
PM: Adding info for pci:0000:00:1f.0
PM: Adding info for pci:0000:00:1f.2
PM: Adding info for pci:0000:00:1f.3
PM: Adding info for pci:0000:02:00.0
PM: Adding info for pci:0000:03:01.0
PM: Adding info for pci:0000:03:01.5
PM: Adding info for pci:0000:03:03.0
ACPI: PCI Interrupt Link [LNKA] (IRQs 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7) *10
ACPI: PCI Interrupt Link [LNKC] (IRQs *9 10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs *5 7 9 10 11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE._PRT]
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
PM: Adding info for pnp:00:0a
PM: Adding info for pnp:00:0b
PM: Adding info for pnp:00:0c
PM: Adding info for pnp:00:0d
PM: Adding info for pnp:00:0e
pnp: PnP ACPI: found 15 devices
PnPBIOS: Disabled by ACPI PNP
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
pnp: 00:02: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:02: ioport range 0x1000-0x1005 could not be reserved
pnp: 00:02: ioport range 0x1008-0x100f could not be reserved
pnp: 00:03: ioport range 0xf400-0xf4fe has been reserved
pnp: 00:03: ioport range 0x1006-0x1007 has been reserved
pnp: 00:03: ioport range 0x100a-0x1059 could not be reserved
pnp: 00:03: ioport range 0x1060-0x107f has been reserved
pnp: 00:03: ioport range 0x1080-0x10bf has been reserved
pnp: 00:03: ioport range 0x10c0-0x10df has been reserved
pnp: 00:08: ioport range 0x900-0x90f has been reserved
pnp: 00:08: ioport range 0x910-0x91f has been reserved
pnp: 00:08: ioport range 0x920-0x92f has been reserved
pnp: 00:08: ioport range 0x93c-0x93f has been reserved
pnp: 00:08: ioport range 0x940-0x97f has been reserved
pnp: 00:0d: ioport range 0x930-0x93b has been reserved
pnp: 00:0e: ioport range 0x7b0-0x7bb has been reserved
pnp: 00:0e: ioport range 0x7c0-0x7df has been reserved
pnp: 00:0e: ioport range 0xbb0-0xbbb has been reserved
pnp: 00:0e: ioport range 0xbc0-0xbdf has been reserved
pnp: 00:0e: ioport range 0xfb0-0xfbb has been reserved
pnp: 00:0e: ioport range 0xfc0-0xfdf has been reserved
pnp: 00:0e: ioport range 0x13b0-0x13bb has been reserved
pnp: 00:0e: ioport range 0x13c0-0x13df has been reserved
PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Failed to allocate I/O resource #7:1000@10000 for 0000:00:1e.0
PCI: Bridge: 0000:00:1c.0
  IO window: disabled.
  MEM window: dfd00000-dfdfffff
  PREFETCH window: disabled.
PCI: Bus 4, cardbus bridge: 0000:03:01.0
  IO window: 00001400-000014ff
  IO window: 00001800-000018ff
  PREFETCH window: 50000000-51ffffff
  MEM window: 52000000-53ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: disabled.
  MEM window: dfc00000-dfcfffff
  PREFETCH window: 50000000-51ffffff
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.0 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
PCI: Enabling device 0000:03:01.0 (0000 -> 0003)
ACPI: PCI Interrupt 0000:03:01.0[A] -> GSI 19 (level, low) -> IRQ 17
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1572864 bytes)
TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
PM: Adding info for platform:pcspkr
audit: initializing netlink socket (disabled)
audit(1162810648.696:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
PM: Adding info for pci_express:0000:00:1c.0:pcie00
Allocate Port Service[0000:00:1c.0:pcie02]
PM: Adding info for pci_express:0000:00:1c.0:pcie02
Allocate Port Service[0000:00:1c.0:pcie03]
PM: Adding info for pci_express:0000:00:1c.0:pcie03
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
PM: Adding info for platform:vesafb.0
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3] C4[C3])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI Exception (acpi_processor-0681): AE_NOT_FOUND, Processor Device is not
present [20060707]
ACPI: Getting cpuindex for acpiid 0x1
ACPI: Thermal Zone [THM] (49 C)
PM: Adding info for No Bus:pnp1
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 915GM Chipset.
agpgart: Detected 7932K stolen memory.
agpgart: AGP aperture is 256M @ 0xc0000000
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing enabled
PM: Adding info for platform:serial8250
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:0b: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ACPI: PCI Interrupt 0000:00:1e.3[B] -> GSI 17 (level, low) -> IRQ 18
ACPI: PCI interrupt for device 0000:00:1e.3 disabled
PM: Adding info for No Bus:isa
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ide0: I/O resource 0x1F0-0x1F7 not free.
ide0: ports already in use, skipping probe
Probing IDE interface ide1...
hdc: _NEC DVD+/-RW ND-6500A, ATAPI CD/DVD-ROM drive
PM: Adding info for No Bus:ide1
ide1 at 0x170-0x177,0x376 on irq 15
PM: Adding info for ide:1.0
hdc: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
Yenta: CardBus bridge found at 0000:03:01.0 [1028:0182]
Yenta: ISA IRQ mask 0x0cf8, PCI irq 17
Socket status: 30000006
Yenta: Raising subordinate bus# of parent bus (#03) from #04 to #07
pcmcia: parent PCI bridge Memory window: 0xdfc00000 - 0xdfcfffff
pcmcia: parent PCI bridge Memory window: 0x50000000 - 0x51ffffff
usbcore: registered new interface driver libusual
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
PM: Adding info for platform:i8042
serio: i8042 KBD port at 0x60,0x64 irq 1
PM: Adding info for serio:serio0
serio: i8042 AUX port at 0x60,0x64 irq 12
PM: Adding info for serio:serio1
mice: PS/2 mouse device common for all mice
PM: Adding info for platform:eisa.0
EISA: Probing bus 0 at eisa.0
Cannot allocate resource for EISA slot 1
EISA: Detected 0 cards.
TCP bic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI No-Shortcut mode
ACPI: (supports S0 S3 S4 S5)
  Magic number: 14:980:981
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
Freeing unused kernel memory: 280k freed
Write protecting the kernel read-only data: 733k
Time: tsc clocksource has been installed.
input: AT Translated Set 2 keyboard as /class/input/input0
Time: acpi_pm clocksource has been installed.
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 16, io base 0x0000bf80
PM: Adding info for usb:usb1
PM: Adding info for No Bus:usbdev1.1_ep00
usb usb1: configuration #1 chosen from 1 choice
PM: Adding info for usb:1-0:1.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PM: Adding info for No Bus:usbdev1.1_ep81
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 18, io base 0x0000bf60
PM: Adding info for usb:usb2
PM: Adding info for No Bus:usbdev2.1_ep00
usb usb2: configuration #1 chosen from 1 choice
PM: Adding info for usb:2-0:1.0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
PM: Adding info for No Bus:usbdev2.1_ep81
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 19, io base 0x0000bf40
PM: Adding info for usb:usb3
PM: Adding info for No Bus:usbdev3.1_ep00
usb usb3: configuration #1 chosen from 1 choice
PM: Adding info for usb:3-0:1.0
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
PM: Adding info for No Bus:usbdev3.1_ep81
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.3: irq 17, io base 0x0000bf20
PM: Adding info for usb:usb4
PM: Adding info for No Bus:usbdev4.1_ep00
usb usb4: configuration #1 chosen from 1 choice
PM: Adding info for usb:4-0:1.0
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
input: PS/2 Mouse as /class/input/input1
input: AlpsPS/2 ALPS GlidePoint as /class/input/input2
PM: Adding info for No Bus:usbdev4.1_ep81
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 16, io mem 0xffa80800
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
PM: Adding info for usb:usb5
PM: Adding info for No Bus:usbdev5.1_ep00
usb usb5: configuration #1 chosen from 1 choice
PM: Adding info for usb:5-0:1.0
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
PM: Adding info for No Bus:usbdev5.1_ep81
SCSI subsystem initialized
libata version 2.00 loaded.
ahci 0000:00:1f.2: version 2.0
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 17 (level, low) -> IRQ 18
ACPI: PCI interrupt for device 0000:00:1f.2 disabled
ahci: probe of 0000:00:1f.2 failed with error -12
ata_piix 0000:00:1f.2: version 2.00ac6
ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
PCI: Enabling device 0000:00:1f.2 (0000 -> 0001)
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 17 (level, low) -> IRQ 18
ata: 0x170 IDE port busy
ata: conflict with ide1
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xBFA0 irq 14
ata2: DUMMY
scsi0 : ata_piix
PM: Adding info for No Bus:host0
ata1.00: ATA-6, max UDMA/100, 117210240 sectors: LBA48
ata1.00: ata1: dev 0 multi count 8
ata1.00: applying bridge limits
ata1.00: configured for UDMA/100
scsi1 : ata_piix
PM: Adding info for No Bus:host1
PM: Adding info for No Bus:target0:0:0
scsi 0:0:0:0: Direct-Access     ATA      HTS726060M9AT00  MH4O PQ: 0 ANSI: 5
PM: Adding info for scsi:0:0:0:0
SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 < sda5 sda6 sda7 sda8 sda9 sda10 >
sd 0:0:0:0: Attached scsi disk sda
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
ieee80211_crypt: registered algorithm 'NULL'
iTCO_wdt: Intel TCO WatchDog Timer Driver v1.00 (08-Oct-2006)
PM: Adding info for platform:iTCO_wdt
iTCO_wdt: Found a ICH6-M TCO device (Version=2, TCOBASE=0x1060)
iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
ieee80211: 802.11 data/management/control stack, git-1.1.13
ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
input: PC Speaker as /class/input/input3
tg3.c:v3.67 (October 18, 2006)
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:02:00.0 to 64
eth0: Tigon3 [partno(BCM95751) rev 4001 PHY(5750)] (PCI Express)
10/100/1000BaseT Ethernet 00:12:3f:06:be:6e
eth0: RXcsums[1] LinkChgREG[1] MIirq[1] ASF[0] Split[0] WireSpeed[1] TSOcap[1]
eth0: dma_rwctrl[76180000] dma_mask[64-bit]
sd 0:0:0:0: Attached scsi generic sg0 type 0
cs: IO port probe 0x100-0x3af: excluding 0x378-0x37f
cs: IO port probe 0x3e0-0x4ff: excluding 0x3f0-0x3ff
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.1.4kdmprq
ipw2200: Copyright(c) 2003-2006 Intel Corporation
ACPI: PCI Interrupt 0000:03:03.0[A] -> GSI 17 (level, low) -> IRQ 18
ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
ipw2200: Radio Frequency Kill Switch is On:
Kill switch must be turned off for wireless networking to work.
ipw2200: Detected geography ZZD (13 802.11bg channels, 0 802.11a channels)
ACPI: PCI Interrupt 0000:00:1e.2[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1e.2 to 64
intel8x0_measure_ac97_clock: measured 55401 usecs
intel8x0: clocking to 48000
PM: Adding info for ac97:0-0:STAC9750,51
PCI: Enabling device 0000:00:1e.3 (0000 -> 0001)
ACPI: PCI Interrupt 0000:00:1e.3[B] -> GSI 17 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1e.3 to 64
MC'97 1 converters and GPIO not ready (0xff00)
PM: Adding info for ac97:1-1:unknown codec
Non-volatile memory driver v1.2
Floppy drive(s): fd0 is 1.44M
floppy0: no floppy controllers found
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP(,...)]
lp0: using parport0 (interrupt-driven).
lp0: console ready
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Lid Switch [LID]
ACPI: Power Button (CM) [PBTN]
ACPI: Sleep Button (CM) [SBTN]
ACPI: ACPI Dock Station Driver
Using specific hotkey driver
ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
ACPI: Video Device [VID2] (multi-head: yes  rom: no  post: no)
EXT3 FS on sda6, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.


Second dmesg is for 2.6.19-rc4-mm2.

I have tried to disable some features around PCI, forcing the use of PCI_GOBIOS,
to avoid using PCI_MMCONFIG.

In any case, I'm still getting the same error at the end of the dmesg.


Linux version 2.6.19-rc4-mm2 (root@rco) (gcc version 4.1.1 20061011 (Red Hat
4.1.1-30)) #11 SMP PREEMPT Fri Nov 3 01:40:57 CET 2006
BIOS-provided physical RAM map:
sanitize start
sanitize end
copy_e820_map() start: 0000000000000000 size: 000000000009f000 end:
000000000009f000 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000000009f000 size: 0000000000001000 end:
00000000000a0000 type: 2
copy_e820_map() start: 0000000000100000 size: 000000003f6d1800 end:
000000003f7d1800 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000003f7d1800 size: 000000000082e800 end:
0000000040000000 type: 2
copy_e820_map() start: 00000000e0000000 size: 0000000010007000 end:
00000000f0007000 type: 2
copy_e820_map() start: 00000000f0008000 size: 0000000000004000 end:
00000000f000c000 type: 2
copy_e820_map() start: 00000000fec00000 size: 0000000000010000 end:
00000000fec10000 type: 2
copy_e820_map() start: 00000000fed20000 size: 00000000000f0000 end:
00000000fee10000 type: 2
copy_e820_map() start: 00000000ffb00000 size: 0000000000500000 end:
0000000100000000 type: 2
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003f7d1800 (usable)
 BIOS-e820: 000000003f7d1800 - 0000000040000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0007000 (reserved)
 BIOS-e820: 00000000f0008000 - 00000000f000c000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
1015MB LOWMEM available.
Entering add_active_range(0, 0, 260049) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   260049
early_node_map[1] active PFN ranges
    0:        0 ->   260049
On node 0 totalpages: 260049
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 1999 pages used for memmap
  Normal zone: 253954 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v000 DELL                                  ) @ 0x000fc9b0
ACPI: RSDT (v001 DELL    CPi R   0x27d50302 ASL  0x00000061) @ 0x3f7d1f90
ACPI: FADT (v001 DELL    CPi R   0x27d50302 ASL  0x00000061) @ 0x3f7d2c00
ACPI: MADT (v001 DELL    CPi R   0x27d50302 ASL  0x00000047) @ 0x3f7d3400
ACPI: ASF! (v016 DELL    CPi R   0x27d50302 ASL  0x00000061) @ 0x3f7d3000
ACPI: MCFG (v016 DELL    CPi R   0x27d50302 ASL  0x00000061) @ 0x3f7d33c0
ACPI: SSDT (v001  PmRef  Cpu0Ist 0x00003000 INTL 0x20030522) @ 0x3f7d23e6
ACPI: SSDT (v001  PmRef  Cpu0Cst 0x00003001 INTL 0x20030522) @ 0x3f7d220e
ACPI: SSDT (v001  PmRef    CpuPm 0x00003000 INTL 0x20030522) @ 0x3f7d2013
ACPI: DSDT (v001 INT430 SYSFexxx 0x00001001 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:13 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] disabled)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
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
Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
Detected 1995.042 MHz processor.
Built 1 zonelists.  Total pages: 258018
Kernel command line: root=/dev/sda6 single console=ttyS0,9600 console=tty0
selinux=0 debug
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
Clock event device pit configured with caps set: 07
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1024884k/1040196k available (2058k kernel code, 14556k reserved, 1353k
data, 192k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xfffb8000 - 0xfffff000   ( 284 kB)
    vmalloc : 0xf0000000 - 0xfffb6000   ( 255 MB)
    lowmem  : 0xb0000000 - 0xef7d1000   (1015 MB)
      .init : 0xb045b000 - 0xb048b000   ( 192 kB)
      .data : 0xb03028df - 0xb0454f34   (1353 kB)
      .text : 0xb0100000 - 0xb03028df   (2058 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3994.12 BogoMIPS (lpj=7988252)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: afe9fbff 00100000 00000000 00000000 00000180
00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: After all inits, caps: afe9fbff 00100000 00000000 00000040 00000180
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 12k freed
ACPI: Core revision 20060707
CPU0: Intel(R) Pentium(R) M processor 2.00GHz stepping 08
Total of 1 processors activated (3994.12 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
Clock event device pit new caps set: 01
Clock event device lapic configured with caps set: 06
Brought up 1 CPUs
checking if image is initramfs... it is
Freeing initrd memory: 1473k freed
PM: Adding info for No Bus:platform
Time: 17:50:27  Date: 10/05/106
NET: Registered protocol family 16
PM: Adding info for No Bus:vtcon0
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfb5be, last bus=4
Setting up standard PCI resources
ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ LMPWR] OemTableId [ DELLLOM]
[20060707]
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
PM: Adding info for acpi:acpi
ACPI: PCI Root Bridge [PCI0] (0000:00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PM: Adding info for No Bus:pci0000:00
Boot video device is 0000:00:02.0
PCI quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
PCI quirk: region 1080-10bf claimed by ICH6 GPIO
PCI: Transparent bridge - 0000:00:1e.0
PCI: Bus #04 (-#07) is hidden behind transparent bridge #03 (-#04) (try
'pci=assign-busses')
Please report the result to linux-kernel to fix this permanently
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
PM: Adding info for pci:0000:00:00.0
PM: Adding info for pci:0000:00:02.0
PM: Adding info for pci:0000:00:02.1
PM: Adding info for pci:0000:00:1c.0
PM: Adding info for pci:0000:00:1d.0
PM: Adding info for pci:0000:00:1d.1
PM: Adding info for pci:0000:00:1d.2
PM: Adding info for pci:0000:00:1d.3
PM: Adding info for pci:0000:00:1d.7
PM: Adding info for pci:0000:00:1e.0
PM: Adding info for pci:0000:00:1e.2
PM: Adding info for pci:0000:00:1e.3
PM: Adding info for pci:0000:00:1f.0
PM: Adding info for pci:0000:00:1f.2
PM: Adding info for pci:0000:00:1f.3
PM: Adding info for pci:0000:02:00.0
PM: Adding info for pci:0000:03:01.0
PM: Adding info for pci:0000:03:01.5
PM: Adding info for pci:0000:03:03.0
ACPI: PCI Interrupt Link [LNKA] (IRQs 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7) *10
ACPI: PCI Interrupt Link [LNKC] (IRQs *9 10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs *5 7 9 10 11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE._PRT]
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
PM: Adding info for pnp:00:0a
PM: Adding info for pnp:00:0b
PM: Adding info for pnp:00:0c
PM: Adding info for pnp:00:0d
PM: Adding info for pnp:00:0e
pnp: PnP ACPI: found 15 devices
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
pnp: 00:02: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:02: ioport range 0x1000-0x1005 could not be reserved
pnp: 00:02: ioport range 0x1008-0x100f could not be reserved
pnp: 00:03: ioport range 0xf400-0xf4fe has been reserved
pnp: 00:03: ioport range 0x1006-0x1007 has been reserved
pnp: 00:03: ioport range 0x100a-0x1059 could not be reserved
pnp: 00:03: ioport range 0x1060-0x107f has been reserved
pnp: 00:03: ioport range 0x1080-0x10bf has been reserved
pnp: 00:03: ioport range 0x10c0-0x10df has been reserved
pnp: 00:08: ioport range 0x900-0x90f has been reserved
pnp: 00:08: ioport range 0x910-0x91f has been reserved
pnp: 00:08: ioport range 0x920-0x92f has been reserved
pnp: 00:08: ioport range 0x93c-0x93f has been reserved
pnp: 00:08: ioport range 0x940-0x97f has been reserved
pnp: 00:0d: ioport range 0x930-0x93b has been reserved
pnp: 00:0e: ioport range 0x7b0-0x7bb has been reserved
pnp: 00:0e: ioport range 0x7c0-0x7df has been reserved
pnp: 00:0e: ioport range 0xbb0-0xbbb has been reserved
pnp: 00:0e: ioport range 0xbc0-0xbdf has been reserved
pnp: 00:0e: ioport range 0xfb0-0xfbb has been reserved
pnp: 00:0e: ioport range 0xfc0-0xfdf has been reserved
pnp: 00:0e: ioport range 0x13b0-0x13bb has been reserved
pnp: 00:0e: ioport range 0x13c0-0x13df has been reserved
PM: Adding info for No Bus:mem
PM: Adding info for No Bus:kmem
PM: Adding info for No Bus:null
PM: Adding info for No Bus:port
PM: Adding info for No Bus:zero
PM: Adding info for No Bus:full
PM: Adding info for No Bus:random
PM: Adding info for No Bus:urandom
PM: Adding info for No Bus:kmsg
PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Failed to allocate I/O resource #7:1000@10000 for 0000:00:1e.0
PCI: Bridge: 0000:00:1c.0
  IO window: disabled.
  MEM window: dfd00000-dfdfffff
  PREFETCH window: disabled.
PCI: Bus 4, cardbus bridge: 0000:03:01.0
  IO window: 00001400-000014ff
  IO window: 00001800-000018ff
  PREFETCH window: 50000000-51ffffff
  MEM window: 52000000-53ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: disabled.
  MEM window: dfc00000-dfcfffff
  PREFETCH window: 50000000-51ffffff
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.0 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
PCI: Enabling device 0000:03:01.0 (0000 -> 0003)
ACPI: PCI Interrupt 0000:03:01.0[A] -> GSI 19 (level, low) -> IRQ 17
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1572864 bytes)
TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
PM: Adding info for platform:pcspkr
PM: Adding info for No Bus:snapshot
audit: initializing netlink socket (disabled)
audit(1162749021.560:1): initialized
PM: Adding info for No Bus:kevent
KEVENT subsystem has been successfully registered.
KEVENT: Added callbacks for type 2.
KEVENT: Added callbacks for type 3.
Kevent poll()/select() subsystem has been initialized.
KEVENT: Added callbacks for type 0.
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
PM: Adding info for platform:vesafb.0
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3] C4[C3])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI Exception (acpi_processor-0681): AE_NOT_FOUND, Processor Device is not
present [20060707]
ACPI: Getting cpuindex for acpiid 0x1
ACPI: Thermal Zone [THM] (70 C)
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
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 915GM Chipset.
agpgart: Detected 7932K stolen memory.
PM: Adding info for No Bus:agpgart
agpgart: AGP aperture is 256M @ 0xc0000000
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing enabled
PM: Adding info for platform:serial8250
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
PM: Adding info for No Bus:ttyS0
PM: Adding info for No Bus:ttyS1
PM: Removing info for No Bus:ttyS0
00:0b: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
PM: Adding info for No Bus:ttyS0
ACPI: PCI Interrupt 0000:00:1e.3[B] -> GSI 17 (level, low) -> IRQ 18
ACPI: PCI interrupt for device 0000:00:1e.3 disabled
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
PM: Adding info for No Bus:lo
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ide0: I/O resource 0x1F0-0x1F7 not free.
ide0: ports already in use, skipping probe
Probing IDE interface ide1...
hdc: _NEC DVD+/-RW ND-6500A, ATAPI CD/DVD-ROM drive
PM: Adding info for No Bus:ide1
ide1 at 0x170-0x177,0x376 on irq 15
PM: Adding info for ide:1.0
hdc: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
Yenta: CardBus bridge found at 0000:03:01.0 [1028:0182]
Yenta: ISA IRQ mask 0x0cf8, PCI irq 17
Socket status: 30000006
Yenta: Raising subordinate bus# of parent bus (#03) from #04 to #07
pcmcia: parent PCI bridge Memory window: 0xdfc00000 - 0xdfcfffff
pcmcia: parent PCI bridge Memory window: 0x50000000 - 0x51ffffff
usbcore: registered new interface driver libusual
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
PM: Adding info for platform:i8042
serio: i8042 KBD port at 0x60,0x64 irq 1
PM: Adding info for serio:serio0
serio: i8042 AUX port at 0x60,0x64 irq 12
PM: Adding info for serio:serio1
mice: PS/2 mouse device common for all mice
TCP bic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
speedstep-centrino with X86_SPEEDSTEP_CENTRINO_ACPIconfig is deprecated.
 Use X86_ACPI_CPUFREQ (acpi-cpufreq instead.
Using IPI No-Shortcut mode
ACPI: (supports<6>Time: tsc clocksource has been installed.
 S0 S3<6>Time: acpi_pm clocksource has been installed.
 S4 S5)
  Magic number: 14:994:844
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
Freeing unused kernel memory: 192k freed
Write protecting the kernel read-only data: 728k
PM: Adding info for No Bus:vcs1
input: AT Translated Set 2 keyboard as /class/input/input0
PM: Adding info for No Bus:vcsa1
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 16, io base 0x0000bf80
usb usb1: new device found, idVendor=0000, idProduct=0000
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: UHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.19-rc4-mm2 uhci_hcd
usb usb1: SerialNumber: 0000:00:1d.0
PM: Adding info for usb:usb1
PM: Adding info for No Bus:usbdev1.1_ep00
usb usb1: configuration #1 chosen from 1 choice
PM: Adding info for usb:1-0:1.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PM: Adding info for No Bus:usbdev1.1_ep81
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 18, io base 0x0000bf60
usb usb2: new device found, idVendor=0000, idProduct=0000
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.19-rc4-mm2 uhci_hcd
usb usb2: SerialNumber: 0000:00:1d.1
PM: Adding info for usb:usb2
PM: Adding info for No Bus:usbdev2.1_ep00
usb usb2: configuration #1 chosen from 1 choice
PM: Adding info for usb:2-0:1.0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
input: PS/2 Mouse as /class/input/input1
PM: Adding info for No Bus:usbdev2.1_ep81
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.2 to 64
input: AlpsPS/2 ALPS GlidePoint as /class/input/input2
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 19, io base 0x0000bf40
usb usb3: new device found, idVendor=0000, idProduct=0000
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.19-rc4-mm2 uhci_hcd
usb usb3: SerialNumber: 0000:00:1d.2
PM: Adding info for usb:usb3
PM: Adding info for No Bus:usbdev3.1_ep00
usb usb3: configuration #1 chosen from 1 choice
PM: Adding info for usb:3-0:1.0
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
PM: Adding info for No Bus:usbdev3.1_ep81
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.3: irq 17, io base 0x0000bf20
usb usb4: new device found, idVendor=0000, idProduct=0000
usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: UHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.19-rc4-mm2 uhci_hcd
usb usb4: SerialNumber: 0000:00:1d.3
PM: Adding info for usb:usb4
PM: Adding info for No Bus:usbdev4.1_ep00
usb usb4: configuration #1 chosen from 1 choice
PM: Adding info for usb:4-0:1.0
usb 2-1: new full speed USB device using uhci_hcd and address 2
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
PM: Adding info for No Bus:usbdev4.1_ep81
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 16, io mem 0xffa80800
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb 2-1: unable to read config index 0 descriptor/start
usb 2-1: chopping to 0 config(s)
usb 2-1: new device found, idVendor=413c, idProduct=8103
usb 2-1: new device strings: Mfr=0, Product=0, SerialNumber=0
PM: Adding info for usb:2-1
PM: Adding info for No Bus:usbdev2.2_ep00
usb 2-1: no configuration chosen from 0 choices
usb usb5: new device found, idVendor=0000, idProduct=0000
usb usb5: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb5: Product: EHCI Host Controller
usb usb5: Manufacturer: Linux 2.6.19-rc4-mm2 ehci_hcd
usb usb5: SerialNumber: 0000:00:1d.7
PM: Adding info for usb:usb5
PM: Adding info for No Bus:usbdev5.1_ep00
usb usb5: configuration #1 chosen from 1 choice
PM: Adding info for usb:5-0:1.0
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
usb 2-1: USB disconnect, address 2
PM: Removing info for No Bus:usbdev2.2_ep00
PM: Removing info for usb:2-1
PM: Adding info for No Bus:usbdev5.1_ep81
SCSI subsystem initialized
libata version 2.00 loaded.
ahci 0000:00:1f.2: version 2.0
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 17 (level, low) -> IRQ 18
PCI: Unable to reserve I/O region #1:8@1f0 for device 0000:00:1f.2
ahci: probe of 0000:00:1f.2 failed with error -16
ata_piix 0000:00:1f.2: version 2.00ac7
ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
PCI: Unable to reserve I/O region #1:8@1f0 for device 0000:00:1f.2
ata_piix: probe of 0000:00:1f.2 failed with error -16
Kernel panic - not syncing: Attempted to kill init!


Thanks,
Remi

