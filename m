Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261919AbVAYMRn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbVAYMRn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 07:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbVAYMRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 07:17:42 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:7096 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S261917AbVAYMRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 07:17:06 -0500
Date: Tue, 25 Jan 2005 13:17:04 +0100
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: 2.6.11-rc2-mm1 strange messages
Message-ID: <20050125121704.GA22610@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Andrew!

After fixing the agpgart (fix by dj) 2.6.11-rc2-mm1 boots and runs wiht
X on my Acer TM654LCi, radeon M7.

But I found the following strange stuff in my dmesg:

. __iounmap:
------------
ACPI: DSDT (v001 ACER   IBIS     0x20020930 MSFT 0x0100000e) @ 0x00000000
Built 1 zonelists
__iounmap: bad address c00fffd9
Local APIC disabled by BIOS -- you can enable it with "lapic"

and:
__journal_remove_journal_head: freeing b_committed_data

Any comments on this? Full dmesg attached.

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
sip:preining@at43.tuwien.ac.at                             +43 (0) 59966-690018
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
DRAFFAN (n.)
An infuriating person who always manages to look much more dashing
that anyone else by turning up unshaven and hangover at a formal
party.
			--- Douglas Adams, The Meaning of Liff

--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.txt"

Linux version 2.6.11-rc2-mm1 (root@gandalf) (gcc-Version 3.3.5 (Debian 1:3.3.5-6)) #1 Mon Jan 24 14:52:30 CET 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff70000 (usable)
 BIOS-e820: 000000001ff70000 - 000000001ff7c000 (ACPI data)
 BIOS-e820: 000000001ff7c000 - 000000001ff80000 (ACPI NVS)
 BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 130928
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126832 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
ACPI: RSDP (v000 ACER                                  ) @ 0x000f5e80
ACPI: RSDT (v001 ACER     RSDT   0x20020930  LTP 0x00000000) @ 0x1ff75a7b
ACPI: FADT (v001 ACER   IBIS     0x20020930 PTL  0x0000001e) @ 0x1ff7bf64
ACPI: BOOT (v001 ACER   IBIS     0x20020930  LTP 0x00000001) @ 0x1ff7bfd8
ACPI: DSDT (v001 ACER   IBIS     0x20020930 MSFT 0x0100000e) @ 0x00000000
Built 1 zonelists
__iounmap: bad address c00fffd9
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01401000)
Initializing CPU#0
Kernel command line: BOOT_IMAGE=2.6.11-rc2-mm1 ro root=304
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 2193.174 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 514760k/523712k available (2089k kernel code, 8396k reserved, 961k data, 180k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 4325.37 BogoMIPS (lpj=2162688)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebf9ff 00000000 00000000 00000000 00000400 00000000 00000000
CPU: After vendor identify, caps: bfebf9ff 00000000 00000000 00000000 00000400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After all inits, caps: bfebf9ff 00000000 00000000 00000080 00000400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
CPU: Intel Mobile Intel(R) Pentium(R) 4 - M CPU 2.20GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
    ACPI-0294: *** Info: Table [DSDT] replaced by host OS
ACPI: setting ELCR to 0200 (from 0420)
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xfd731, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050114
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
ACPI: PCI Interrupt Link [LNKC] (IRQs *10)
ACPI: PCI Interrupt Link [LNKD] (IRQs *5)
ACPI: PCI Interrupt Link [LNKE] (IRQs *10)
ACPI: PCI Interrupt Link [LNKF] (IRQs 10) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 10) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 10) *0, disabled.
ACPI: Embedded Controller [EC0] (gpe 29)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB_._PRT]
ACPI: Power Resource [PFN0] (off)
ACPI: Power Resource [PFN1] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
PnPBIOS: Disabled by ACPI
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
Simple Boot Flag at 0x36 set to 0x1
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
Initializing Cryptographic API
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Battery Slot [BAT2] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN0] (off)
ACPI: Fan [FAN1] (off)
ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Thermal Zone [THRM] (60 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
inotify device minor=63
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
hw_random: cannot enable RNG, aborting
ACPI: PS/2 Keyboard Controller [KBC] at I/O 0x60, 0x64, irq 1
ACPI: PS/2 Mouse Controller [MOU2] at irq 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 10 (level, low) -> IRQ 10
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
lp0: using parport0 (interrupt-driven).
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 10 (level, low) -> IRQ 10
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: TOSHIBA MK4021GAS, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: QSI CD-RW/DVD-ROM SBW-242, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB), CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
Synaptics Touchpad, model: 1
 Firmware: 5.8
 180 degree mounted touchpad
 Sensor: 29
 new absolute packet format
 Touchpad has extended capability bits
 -> 4 multi-buttons, i.e. besides standard buttons
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
perfctr: driver 2.7.9, cpu type Intel P4 at 2193174 kHz
Advanced Linux Sound Architecture Driver Version 1.0.8 (Thu Jan 13 09:39:32 2005 UTC).
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49449 usecs
intel8x0: clocking to 48000
ALSA device list:
  #0: Intel 82801CA-ICH3 with ALC202 at 0x1c00, irq 10
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP established hash table entries: 32768 (order: 6, 262144 bytes)
TCP bind hash table entries: 32768 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
PM: Reading swsusp image.
swsusp: Resume From Partition: /dev/hda3
<3>swsusp: Suspend partition has wrong signature?
swsusp: Error -22 resuming
PM: Resume from disk failed.
ACPI wakeup devices: 
MDM0  HUB GLAN USB1 USB2 USB1 
ACPI: (supports S0 S3 S4 S5)
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 180k freed
kjournald starting.  Commit interval 5 seconds
Adding 682752k swap on /dev/hda3.  Priority:-1 extents:1
EXT3 FS on hda4, internal journal
b44.c:v0.95 (Aug 3, 2004)
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 5 (level, low) -> IRQ 5
eth0: Broadcom 4400 10/100BaseT Ethernet 00:c0:9f:1f:59:38
orinoco 0.15rc2HEAD (David Gibson <hermes@gibson.dropbear.id.au>, Pavel Roskin <proski@gnu.org>, et al)
orinoco_pci 0.15rc2HEAD (Pavel Roskin <proski@gnu.org>, David Gibson <hermes@gibson.dropbear.id.au> & Jean Tourrilhes <jt@hpl.hp.com>)
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 10 (level, low) -> IRQ 10
orinoco_pci: Detected PCI device 0000:02:04.0, memory 0xf8000000-0xf8000fff, irq 10
eth1: Hardware identity 8022:0000:0001:0000
eth1: Station identity  001f:0000:0001:0008
eth1: Firmware determined as Intersil 1.8.0
eth1: Ad-hoc demo mode supported
eth1: IEEE standard IBSS ad-hoc mode supported
eth1: WEP supported, 104-bit key
eth1: MAC address 00:02:8A:95:EE:C0
eth1: Station name "Prism  I"
eth1: ready
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel i845 Chipset.
agpgart: AGP aperture is 64M @ 0xec000000
Acer Travelmate hotkey driver v0.5.18
atkbd.c: Unknown key pressed (translated set 2, code 0x0 on isa0060/serio0).
atkbd.c: Use 'setkeycodes 00 <keycode>' to make it known.
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
PCI: Enabling device 0000:00:1d.0 (0004 -> 0005)
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 10 (level, low) -> IRQ 10
uhci_hcd 0000:00:1d.0: Intel Corp. 82801CA/CAM USB (Hub #1)
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 10, io base 0x1800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PCI: Enabling device 0000:00:1d.1 (0000 -> 0001)
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 5 (level, low) -> IRQ 5
uhci_hcd 0000:00:1d.1: Intel Corp. 82801CA/CAM USB (Hub #2)
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 5, io base 0x1820
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:02:09.0[A] -> GSI 10 (level, low) -> IRQ 10
uhci_hcd 0000:02:09.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
uhci_hcd 0000:02:09.0: irq 10, io base 0x5000
uhci_hcd 0000:02:09.0: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:02:09.1[B] -> GSI 10 (level, low) -> IRQ 10
uhci_hcd 0000:02:09.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
uhci_hcd 0000:02:09.1: irq 10, io base 0x5020
uhci_hcd 0000:02:09.1: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 2-2: new full speed USB device using uhci_hcd and address 2
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usb-storage: device found at 2
usb-storage: waiting for device to settle before scanning
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1f.6 to 64
hostap_crypt: registered algorithm 'NULL'
hostap_pci: CVS (Jouni Malinen <jkmaline@cc.hut.fi>)
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
ACPI: PCI interrupt 0000:02:06.0[A] -> GSI 10 (level, low) -> IRQ 10
Yenta: CardBus bridge found at 0000:02:06.0 [1025:0020]
Yenta O2: res at 0x94/0xD4: 00/ea
Yenta O2: enabling read prefetch/write burst
Yenta: ISA IRQ mask 0x0818, PCI irq 10
Socket status: 30000006
PCI: Enabling device 0000:02:06.1 (0104 -> 0106)
ACPI: PCI interrupt 0000:02:06.1[A] -> GSI 10 (level, low) -> IRQ 10
Yenta: CardBus bridge found at 0000:02:06.1 [1025:0020]
Yenta: ISA IRQ mask 0x0818, PCI irq 10
Socket status: 30000410
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
ACPI: PCI interrupt 0000:02:07.0[A] -> GSI 10 (level, low) -> IRQ 10
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[10]  MMIO=[e8208000-e82087ff]  Max Packet=[2048]
ACPI: PCI interrupt 0000:02:09.2[C] -> GSI 10 (level, low) -> IRQ 10
ehci_hcd 0000:02:09.2: VIA Technologies, Inc. USB 2.0
ehci_hcd 0000:02:09.2: irq 10, pci mem 0xe8208800
ehci_hcd 0000:02:09.2: new USB bus registered, assigned bus number 5
ehci_hcd 0000:02:09.2: USB 2.0 initialized, EHCI 0.95, driver 10 Dec 2004
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 4 ports detected
ieee1394: impossible ack_complete from node 65535 (tcode 4)
ieee1394: Current remote IRM is not 1394a-2000 compliant, resetting...
ieee1394: impossible ack_complete from node 65535 (tcode 4)
ieee1394: Current remote IRM is not 1394a-2000 compliant, resetting...
ieee1394: impossible ack_complete from node 65535 (tcode 4)
ieee1394: Current remote IRM is not 1394a-2000 compliant, resetting...
ieee1394: impossible ack_complete from node 65535 (tcode 4)
ieee1394: Current remote IRM is not 1394a-2000 compliant, resetting...
ieee1394: impossible ack_complete from node 65535 (tcode 4)
ieee1394: Current remote IRM is not 1394a-2000 compliant, resetting...
ieee1394: impossible ack_complete from node 65535 (tcode 4)
ieee1394: Current remote IRM is not 1394a-2000 compliant, resetting...
ieee1394: Stopping reset loop for IRM sanity
tlabel: 0, (data[1] >> 16): ffc0
packet->tlabel: 0, packet->node_id: ffc0
tlabel: 1, (data[1] >> 16): ffc0
packet->tlabel: 1, packet->node_id: ffc0
tlabel: 2, (data[1] >> 16): ffc0
packet->tlabel: 2, packet->node_id: ffc0
tlabel: 3, (data[1] >> 16): ffc0
packet->tlabel: 3, packet->node_id: ffc0
tlabel: 4, (data[1] >> 16): ffc0
packet->tlabel: 4, packet->node_id: ffc0
tlabel: 5, (data[1] >> 16): ffc0
packet->tlabel: 5, packet->node_id: ffc0
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00c09f00000b36ba]
eth1394: $Rev: 1224 $ Ben Collins <bcollins@debian.org>
eth1394: eth2: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
  Vendor: Generic   Model: Flash R/W         Rev: 2002
  Type:   Direct-Access                      ANSI SCSI revision: 02
usb-storage: device scan complete
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
NET: Registered protocol family 23
b44: eth0: Link is down.
b44: eth0: Link is up at 100 Mbps, full duplex.
b44: eth0: Flow control is off for TX and off for RX.
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
cdrom: This disc doesn't have any tracks I recognize!
pktcdvd: writer pktcdvd0 mapped to hdc
eth1: New link status: Disconnected (0002)
[drm] Initialized drm 1.0.0 20040925
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 10 (level, low) -> IRQ 10
[drm] Initialized radeon 1.12.0 20020828 on minor 0: ATI Technologies Inc Radeon Mobility M7 LW [Radeon Mobility 7500]
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
usb 3-2: new low speed USB device using uhci_hcd and address 2
usbcore: registered new driver hiddev
drivers/usb/input/hid-core.c: usb_submit_urb(ctrl) failed
drivers/usb/input/hid-core.c: timeout initializing reports

input: USB HID v1.10 Mouse [0d62:1000] on usb-0000:02:09.0-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
__journal_remove_journal_head: freeing b_committed_data

--17pEHd4RhPHOinZp--
