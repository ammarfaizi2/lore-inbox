Return-Path: <linux-kernel-owner+w=401wt.eu-S1755324AbXABPmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755324AbXABPmH (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 10:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755321AbXABPmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 10:42:06 -0500
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:58969 "EHLO
	smtp-out3.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755319AbXABPmC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 10:42:02 -0500
Message-ID: <459A7D46.5000509@blueyonder.co.uk>
Date: Tue, 02 Jan 2007 15:41:58 +0000
From: Sid Boyce <g3vbv@blueyonder.co.uk>
Reply-To: g3vbv@blueyonder.co.uk
Organization: blueyonder.co.uk
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.19 and up to 2.6.20-rc2 Ethernet problems x86_64
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Same problem with 2.6.19-rc3.
Apologies for the long spiel, if memory serves me correct, gzip'd 
attachments are verboten.
openSUSE 10.2
Network does not get configured with "acpi=noirq" or "acpi=off".
There may be something in dmesg that allows further analysis of the 
problem.
00:0a:e4:4e:a1:42 is the laptop MAC address.
00:48:54:d0:22:f0 is the firewall box
00:50:22:40:0F:D2 is a local box
Some things in dmesg which look decidedly strange when compared to what 
is seen with 2.6.18.2-34, two mac addresses strung together with an 
additional :08:00. I'm guessing here, this may be normal but I haven't 
seen such before.
Linux version 2.6.20-rc1-git7-default (root@Boycie) (gcc version 4.1.2 
20061115 (prerelease) (SUSE Linux)) #4 SMP Wed Dec 20 01:17:23 GMT 2006
Command line: root=/dev/hda1 vga=0x317    resume=/dev/hda2 splash=silent 3
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fef0000 (usable)
 BIOS-e820: 000000001fef0000 - 000000001fefb000 (ACPI data)
 BIOS-e820: 000000001fefb000 - 000000001ff00000 (ACPI NVS)
 BIOS-e820: 000000001ff00000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
Entering add_active_range(0, 0, 159) 0 entries of 3200 used
Entering add_active_range(0, 256, 130800) 1 entries of 3200 used
end_pfn_map = 1048576
DMI 2.3 present.
ACPI: RSDP (v000 PTLTD                                 ) @ 
0x00000000000f68c0
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 
0x000000001fef5d48
ACPI: FADT (v002 AMDK8  PTLTW    0x06040000 PTL_ 0x000f4240) @ 
0x000000001fefae56
ACPI: SSDT (v001 PTLTD  POWERNOW 0x06040000  LTP 0x00000001) @ 
0x000000001fefaeda
ACPI: MADT (v001 PTLTD           APIC   0x06040000  LTP 0x00000000) @ 
0x000000001fefafb0
ACPI: DSDT (v001  VIA   PTL_ACPI 0x06040000 MSFT 0x0100000e) @ 
0x0000000000000000
Scanning NUMA topology in Northbridge 24
Number of nodes 1
Node 0 MemBase 0000000000000000 Limit 000000001fef0000
Entering add_active_range(0, 0, 159) 0 entries of 3200 used
Entering add_active_range(0, 256, 130800) 1 entries of 3200 used
NUMA: Using 63 for the hash shift.
Using node hash shift of 63
Bootmem setup node 0 0000000000000000-000000001fef0000
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1048576
early_node_map[2] active PFN ranges
    0:        0 ->      159
    0:      256 ->   130800
On node 0 totalpages: 130703
  DMA zone: 56 pages used for memmap
  DMA zone: 1183 pages reserved
  DMA zone: 2760 pages, LIFO batch:0
  DMA32 zone: 1732 pages used for memmap
  DMA32 zone: 124972 pages, LIFO batch:31
  Normal zone: 0 pages used for memmap
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to physical flat
Using ACPI (MADT) for SMP configuration information
Nosave address range: 000000000009f000 - 00000000000a0000
Nosave address range: 00000000000a0000 - 00000000000d8000
Nosave address range: 00000000000d8000 - 0000000000100000
Allocating PCI resources starting at 30000000 (gap: 20000000:dffe0000)
SMP: Allowing 1 CPUs, 0 hotplug CPUs
PERCPU: Allocating 49664 bytes of per cpu data
Built 1 zonelists.  Total pages: 127732
Kernel command line: root=/dev/hda1 vga=0x317    resume=/dev/hda2 
splash=silent 3
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 16384 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Checking aperture...
CPU 0: aperture @ e0000000 size 256 MB
Memory: 507156k/523200k available (1948k kernel code, 15656k reserved, 
950k data, 324k init)
Calibrating delay using timer specific routine.. 3591.92 BogoMIPS 
(lpj=1795961)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0/0 -> Node 0
SMP alternatives: switching to UP code
Freeing SMP alternatives: 28k freed
ACPI: Core revision 20060707
Using local APIC timer interrupts.
result 12464666
Detected 12.464 MHz APIC timer.
Brought up 1 CPUs
testing NMI watchdog ... OK.
time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
time.c: Detected 1794.911 MHz processor.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 4000-407f claimed by vt8235 PM
PCI quirk: region 8100-810f claimed by vt8235 SMB
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [ALKA] (IRQs 16 17 18 19 20 21 22 23) *9, 
disabled.
ACPI: PCI Interrupt Link [ALKB] (IRQs 16 17 18 19 20 21 22 23) *10, 
disabled.
ACPI: PCI Interrupt Link [ALKC] (IRQs 22) *11, disabled.
ACPI: PCI Interrupt Link [ALKD] (IRQs 21) *10, disabled.
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 *9 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 *10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a 
report
PCI: Cannot allocate resource region 0 of device 0000:00:00.0
agpgart: Detected AGP bridge 0
agpgart: AGP aperture is 256M @ 0xe0000000
pnp: 00:06: ioport range 0x600-0x60f has been reserved
pnp: 00:06: ioport range 0x1c0-0x1cf has been reserved
pnp: 00:06: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:06: ioport range 0xfe10-0xfe11 could not be reserved
PCI: Bridge: 0000:00:01.0
  IO window: 2000-2fff
  MEM window: d0100000-d01fffff
  PREFETCH window: d8000000-dfffffff
PCI: Bus 2, cardbus bridge: 0000:00:0b.0
  IO window: 00001c00-00001cff
  IO window: 00003000-000030ff
  PREFETCH window: 30000000-31ffffff
  MEM window: 32000000-33ffffff
PCI: Bus 6, cardbus bridge: 0000:00:0b.1
  IO window: 00003400-000034ff
  IO window: 00003800-000038ff
  PREFETCH window: 34000000-35ffffff
  MEM window: 36000000-37ffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:0b.0[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:0b.0 to 64
PCI: Enabling device 0000:00:0b.1 (0000 -> 0003)
ACPI: PCI Interrupt 0000:00:0b.1[B] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:0b.1 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 3, 32768 bytes)
TCP established hash table entries: 16384 (order: 6, 262144 bytes)
TCP bind hash table entries: 8192 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 2885k freed
audit: initializing netlink socket (disabled)
audit(1166585213.510:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
vesafb: framebuffer at 0xd8000000, mapped to 0xffffc20000180000, using 
3072k, total 65536k
vesafb: mode is 1024x768x16, linelength=2048, pages=41
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 128000K size 1024 blocksize
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input0
input: PC Speaker as /class/input/input1
Synaptics Touchpad, model: 1, fw: 5.8, id: 0x9248b1, caps: 0x904713/0x4000
input: SynPS/2 Synaptics TouchPad as /class/input/input2
NET: Registered protocol family 1
ACPI: (supports S0 S3 S4 S5)
Freeing unused kernel memory: 324k freed
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ACPI: Thermal Zone [THRS] (53 C)
ACPI: Thermal Zone [THRC] (78 C)
VP_IDE: IDE controller at PCI slot 0000:00:11.1
ACPI: Unable to derive IRQ for device 0000:00:11.1
Losing some ticks... checking if CPU frequency changed.
ACPI: PCI Interrupt 0000:00:11.1[A]: no GSI
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1008-0x100f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: WDC WD800VE-07HDT0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=65535/16/63, 
UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2
Probing IDE interface ide1...
hdc: _NEC DVD_RW ND-6750A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
Attempting manual resume
ReiserFS: hda1: found reiserfs format "3.6" with standard journal
ReiserFS: hda1: using ordered data mode
ReiserFS: hda1: journal params: device hda1, size 8192, journal first 
block 18, max trans len 1024, max batch 900, max commit age 30, max 
trans age 30
ReiserFS: hda1: checking transaction log (hda1)
ReiserFS: hda1: Using r5 hash to sort names
NET: Registered protocol family 23
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Yenta: CardBus bridge found at 0000:00:0b.0 [1025:0046]
USB Universal Host Controller Interface driver v3.0
ieee1394: Initialized config rom entry `ip1394'
Yenta: ISA IRQ mask 0x00b8, PCI irq 17
Socket status: 30000410
Yenta: CardBus bridge found at 0000:00:0b.1 [1025:0046]
Yenta: ISA IRQ mask 0x00b8, PCI irq 18
Socket status: 30000820
ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:10.0: irq 21, io base 0x00001020
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.1[B] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.1: irq 21, io base 0x00001040
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.2[C] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.2: irq 21, io base 0x00001060
usb usb3: configuration #1 chosen from 1 choice
pccard: PCMCIA card inserted into slot 0
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb 1-2: new full speed USB device using uhci_hcd and address 2
nsc-ircc, chip->init
nsc-ircc, Found chip at base=0x02e
nsc-ircc, driver loaded (Dag Brattli)
ACPI: PCI Interrupt 0000:00:10.3[D] -> GSI 21 (level, low) -> IRQ 21
ehci_hcd 0000:00:10.3: EHCI Host Controller
ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
ehci_hcd 0000:00:10.3: irq 21, io mem 0xd0000800
ehci_hcd 0000:00:10.3: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
nsc_ircc_open(), can't get iobase of 0x2f8
nsc-ircc, Found chip at base=0x02e
nsc-ircc, driver loaded (Dag Brattli)
nsc_ircc_open(), can't get iobase of 0x2f8
pnp: Device 00:0a disabled.
pccard: CardBus card inserted into slot 1
ACPI: PCI Interrupt 0000:00:0b.2[C] -> GSI 19 (level, low) -> IRQ 19
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[19] 
MMIO=[d0000000-d00007ff]  Max Packet=[2048]  IR/IT contexts=[4/4]
---------------------------------------------------------------------
tg3.c:v3.71 (December 15, 2006)
ACPI: PCI Interrupt 0000:00:0c.0[A] -> GSI 20 (level, low) -> IRQ 20
eth0: Tigon3 [partno(BCM95705A50) rev 3003 PHY(5705)] (PCI:33MHz:32-bit) 
10/100/1000Base-T Ethernet 00:0a:e4:4e:a1:42
------------------------------------------------------------------------
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[0] 
TSOcap[1]
eth0: dma_rwctrl[763f0000] dma_mask[32-bit]
ACPI: PCI Interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:11.5 to 64
hdc: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
usb 1-2: device not accepting address 2, error -71
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 
[PCSPP,TRISTATE,COMPAT,ECP,DMA]
wbsd: Winbond W83L51xD SD/MMC card interface driver, 1.6
wbsd: Copyright(c) Pierre Ossman
mmc0: W83L51xD id 7112 at 0x820 irq 10 FIFO PnP
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000ae404061046b5]
cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xd3fff 
0xd8000-0xdffff 0xe4000-0xfffff
cs: memory probe 0x60000000-0x60ffffff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
pcmcia: registering new device pcmcia0.0
usb 1-2: new full speed USB device using uhci_hcd and address 4
pcmcia: request for exclusive IRQ could not be fulfilled.
pcmcia: the driver needs updating to supported shared IRQ lines.
0.0: ttyS0 at I/O 0x3f8 (irq = 17) is a 16550A
usb 1-2: configuration #1 chosen from 1 choice
Bluetooth: Core ver 2.11
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
usb 3-1: new full speed USB device using uhci_hcd and address 2
Bluetooth: HCI USB driver ver 2.9
usb 3-1: configuration #1 chosen from 1 choice
hub 3-1:1.0: USB hub found
hub 3-1:1.0: 4 ports detected
usb 3-2: new low speed USB device using uhci_hcd and address 3
usb 3-2: configuration #1 chosen from 1 choice
usbcore: registered new interface driver hci_usb
usb 2-1: new full speed USB device using uhci_hcd and address 2
usb 2-1: configuration #1 chosen from 1 choice
usb 3-1.3: new full speed USB device using uhci_hcd and address 4
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
usb 3-1.3: not running at top speed; connect to a high speed hub
Bluetooth: HIDP (Human Interface Emulation) ver 1.1
usb 3-1.3: configuration #1 chosen from 1 choice
usbcore: registered new interface driver hiddev
input: Acrox USB & PS/2 Mouse as /class/input/input3
input: USB HID v1.10 Mouse [Acrox USB & PS/2 Mouse] on usb-0000:00:10.2-2
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
usbcore: registered new interface driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial support registered for generic
usbcore: registered new interface driver usbserial_generic
drivers/usb/serial/usb-serial.c: USB Serial Driver core
drivers/usb/serial/usb-serial.c: USB Serial support registered for pl2303
pl2303 2-1:1.0: pl2303 converter detected
usb 2-1: pl2303 converter now attached to ttyUSB0
usbcore: registered new interface driver pl2303
drivers/usb/serial/pl2303.c: Prolific PL2303 USB to serial adaptor driver
SCSI subsystem initialized
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 4
usb-storage: waiting for device to settle before scanning
usbcore: registered new interface driver usb-storage
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.8
USB Mass Storage support registered.
Bluetooth: BNEP (Ethernet Emulation) ver 1.2
Bluetooth: BNEP filters: protocol multicast
Adding 3931696k swap on /dev/hda2.  Priority:-1 extents:1 across:3931696k
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: 
dm-devel@redhat.com
loop: loaded (max 8 devices)
scsi 0:0:0:0: Direct-Access     Maxtor 6 Y120L0           YAR4 PQ: 0 
ANSI: 0
usb-storage: device scan complete
SCSI device sda: 240121728 512-byte hdwr sectors (122942 MB)
sda: Write Protect is off
sda: Mode Sense: 03 00 00 00
sda: assuming drive cache: write through
SCSI device sda: 240121728 512-byte hdwr sectors (122942 MB)
sda: Write Protect is off
sda: Mode Sense: 03 00 00 00
sda: assuming drive cache: write through
 sda: sda1 sda2
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
Adding 1550264k swap on /dev/sda2.  Priority:-2 extents:1 across:1550264k
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
ip6_tables: (C) 2000-2006 Netfilter Core Team
ip_tables: (C) 2000-2006 Netfilter Core Team
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
powernow-k8: Found 1 AMD Athlon(tm) 64 Processor 3000+ processors 
(version 2.00.00)
powernow-k8:    0 : fid 0xa (1800 MHz), vid 0x2
powernow-k8:    1 : fid 0x8 (1600 MHz), vid 0x6
powernow-k8:    2 : fid 0x0 (800 MHz), vid 0x12
ttyS1: LSR safety check engaged!
audit(1166585256.326:2): audit_pid=2996 old=0 by auid=4294967295
PM: Writing back config space on device 0000:00:0c.0 at offset b (was 
3ed173b, writing 461025)
PM: Writing back config space on device 0000:00:0c.0 at offset 3 (was 0, 
writing 4010)
PM: Writing back config space on device 0000:00:0c.0 at offset 2 (was 
2000000, writing 2000003)
PM: Writing back config space on device 0000:00:0c.0 at offset 1 (was 
2b00000, writing 2b00006)
PM: Writing back config space on device 0000:00:0c.0 at offset 0 (was 
3ed173b, writing 169c14e4)
ADDRCONF(NETDEV_UP): eth0: link is not ready
NET: Registered protocol family 17
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
SFW2-OUT-ERROR IN= OUT=eth0 SRC=192.168.10.5 DST=224.0.0.251 LEN=107 
TOS=0x00 PREC=0x00 TTL=255 ID=0 DF PROTO=UDP SPT=5353 DPT=5353 LEN=87
SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC= SRC=192.168.10.5 DST=224.0.0.251 
LEN=107 TOS=0x00 PREC=0x00 TTL=255 ID=0 DF PROTO=UDP SPT=5353 DPT=5353 
LEN=87
SFW2-OUT-ERROR IN= OUT=eth0 SRC=192.168.10.5 DST=224.0.0.251 LEN=107 
TOS=0x00 PREC=0x00 TTL=255 ID=0 DF PROTO=UDP SPT=5353 DPT=5353 LEN=87
SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC= SRC=192.168.10.5 DST=224.0.0.251 
LEN=107 TOS=0x00 PREC=0x00 TTL=255 ID=0 DF PROTO=UDP SPT=5353 DPT=5353 
LEN=87
SFW2-OUT-ERROR IN= OUT=eth0 SRC=192.168.10.5 DST=192.168.10.1 LEN=60 
TOS=0x00 PREC=0x00 TTL=64 ID=64687 DF PROTO=TCP SPT=14566 DPT=111 
WINDOW=5840 RES=0x00 S
YN URGP=0 OPT (020405B40402080AFFFC4A360000000001030302)
SFW2-OUT-ERROR IN= OUT=eth0 SRC=192.168.10.5 DST=224.0.0.22 LEN=40 
TOS=0x00 PREC=0xC0 TTL=1 ID=0 DF OPT (94040000) PROTO=2
SFW2-OUT-ERROR IN= OUT=eth0 SRC=192.168.10.5 DST=224.0.0.251 LEN=107 
TOS=0x00 PREC=0x00 TTL=255 ID=0 DF PROTO=UDP SPT=5353 DPT=5353 LEN=87
SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC= SRC=192.168.10.5 DST=224.0.0.251 
LEN=107 TOS=0x00 PREC=0x00 TTL=255 ID=0 DF PROTO=UDP SPT=5353 DPT=5353 
LEN=87
eth0: no IPv6 routers present
SFW2-OUT-ERROR IN= OUT=eth0 SRC=192.168.10.5 DST=192.168.10.1 LEN=60 
TOS=0x00 PREC=0x00 TTL=64 ID=64689 DF PROTO=TCP SPT=14566 DPT=111 
WINDOW=5840 RES=0x00 S
YN URGP=0 OPT (020405B40402080AFFFC90860000000001030302)
SFW2-INext-DROP-DEFLT IN=eth0 OUT= 
MAC=00:0a:e4:4e:a1:42:00:48:54:d0:22:f0:08:00 SRC=195.188.53.175 
DST=192.168.10.5 LEN=119 TOS=0x00 PREC=0x00 TTL=247 ID=45
161 DF PROTO=UDP SPT=53 DPT=1025 LEN=99
SFW2-INext-DROP-DEFLT IN=eth0 OUT= 
MAC=00:0a:e4:4e:a1:42:00:48:54:d0:22:f0:08:00 SRC=195.188.53.175 
DST=192.168.10.5 LEN=119 TOS=0x00 PREC=0x00 TTL=247 ID=45
162 DF PROTO=UDP SPT=53 DPT=1027 LEN=99
SFW2-INext-DROP-DEFLT IN=eth0 OUT= 
MAC=00:0a:e4:4e:a1:42:00:48:54:d0:22:f0:08:00 SRC=62.31.176.39 
DST=192.168.10.5 LEN=119 TOS=0x00 PREC=0x00 TTL=251 ID=1270
7 DF PROTO=UDP SPT=53 DPT=1026 LEN=99
SFW2-INext-DROP-DEFLT IN=eth0 OUT= 
MAC=00:0a:e4:4e:a1:42:00:50:22:40:0f:d2:08:00 SRC=192.168.10.1 
DST=192.168.10.5 LEN=84 TOS=0x00 PREC=0x00 TTL=64 ID=47744
PROTO=ICMP TYPE=0 CODE=0 ID=34575 SEQ=1
SFW2-INext-DROP-DEFLT IN=eth0 OUT= 
MAC=00:0a:e4:4e:a1:42:00:50:22:40:0f:d2:08:00 SRC=192.168.10.1 
DST=192.168.10.5 LEN=84 TOS=0x00 PREC=0x00 TTL=64 ID=47745
PROTO=ICMP TYPE=0 CODE=0 ID=34575 SEQ=2
SFW2-INext-DROP-DEFLT IN=eth0 OUT= 
MAC=00:0a:e4:4e:a1:42:00:48:54:d0:22:f0:08:00 SRC=194.117.134.19 
DST=192.168.10.5 LEN=119 TOS=0x00 PREC=0x00 TTL=248 ID=56
11 DF PROTO=UDP SPT=53 DPT=1028 LEN=99
SFW2-INext-DROP-DEFLT IN=eth0 OUT= 
MAC=00:0a:e4:4e:a1:42:00:50:22:40:0f:d2:08:00 SRC=192.168.10.1 
DST=192.168.10.5 LEN=84 TOS=0x00 PREC=0x00 TTL=64 ID=47746
PROTO=ICMP TYPE=0 CODE=0 ID=34575 SEQ=3
SFW2-INext-DROP-DEFLT IN=eth0 OUT= 
MAC=00:0a:e4:4e:a1:42:00:50:22:40:0f:d2:08:00 SRC=192.168.10.1 
DST=192.168.10.5 LEN=84 TOS=0x00 PREC=0x00 TTL=64 ID=47747
PROTO=ICMP TYPE=0 CODE=0 ID=34575 SEQ=4
SFW2-INext-DROP-DEFLT IN=eth0 OUT= 
MAC=00:0a:e4:4e:a1:42:00:48:54:d0:22:f0:08:00 SRC=62.31.176.39 
DST=192.168.10.5 LEN=119 TOS=0x00 PREC=0x00 TTL=251 ID=1270
8 DF PROTO=UDP SPT=53 DPT=1029 LEN=99
SFW2-INext-DROP-DEFLT IN=eth0 OUT= 
MAC=00:0a:e4:4e:a1:42:00:50:22:40:0f:d2:08:00 SRC=192.168.10.1 
DST=192.168.10.5 LEN=84 TOS=0x00 PREC=0x00 TTL=64 ID=47748
PROTO=ICMP TYPE=0 CODE=0 ID=34575 SEQ=5
SFW2-OUT-ERROR IN= OUT=eth0 SRC=192.168.10.5 DST=195.188.53.175 LEN=58 
TOS=0x00 PREC=0x00 TTL=64 ID=43443 DF PROTO=UDP SPT=1025 DPT=53 LEN=38
SFW2-INext-DROP-DEFLT IN=eth0 OUT= 
MAC=00:0a:e4:4e:a1:42:00:48:54:d0:22:f0:08:00 SRC=194.117.134.19 
DST=192.168.10.5 LEN=119 TOS=0x00 PREC=0x00 TTL=248 ID=56
13 DF PROTO=UDP SPT=53 DPT=1028 LEN=99
SFW2-OUT-ERROR IN= OUT=eth0 SRC=192.168.10.5 DST=194.117.134.19 LEN=63 
TOS=0x00 PREC=0x00 TTL=64 ID=13907 DF PROTO=UDP SPT=1034 DPT=53 LEN=43
SFW2-INext-DROP-DEFLT IN=eth0 OUT= 
MAC=00:0a:e4:4e:a1:42:00:48:54:d0:22:f0:08:00 SRC=194.117.134.19 
DST=192.168.10.5 LEN=138 TOS=0x00 PREC=0x00 TTL=248 ID=56
16 DF PROTO=UDP SPT=53 DPT=1036 LEN=118
SFW2-OUT-ERROR IN= OUT=eth0 SRC=192.168.10.5 DST=194.117.134.19 LEN=63 
TOS=0x00 PREC=0x00 TTL=64 ID=18909 DF PROTO=UDP SPT=1036 DPT=53 LEN=43
SFW2-INext-DROP-DEFLT IN=eth0 OUT= 
MAC=00:0a:e4:4e:a1:42:00:48:54:d0:22:f0:08:00 SRC=195.188.53.175 
DST=192.168.10.5 LEN=74 TOS=0x00 PREC=0x00 TTL=247 ID=356
16 DF PROTO=UDP SPT=53 DPT=1039 LEN=54
etc.,etc.

Regards
Sid.

-- 
Sid Boyce ... Hamradio License G3VBV, Licensed Private Pilot
Emeritus IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support Specialist, Cricket Coach
Microsoft Windows Free Zone - Linux used for all Computing Tasks


