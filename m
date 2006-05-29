Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751076AbWE2AVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbWE2AVJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 20:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbWE2AVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 20:21:09 -0400
Received: from rune.pobox.com ([208.210.124.79]:43926 "EHLO rune.pobox.com")
	by vger.kernel.org with ESMTP id S1751076AbWE2AVH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 20:21:07 -0400
Date: Sun, 28 May 2006 17:21:01 -0700
From: Paul Dickson <dickson@permanentmail.com>
To: Mark Lord <lkml@rtr.ca>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Resume stops working between 2.6.16 and 2.6.17-rc1 on Dell
 Inspiron 6000
Message-Id: <20060528172101.a1b9725e.dickson@permanentmail.com>
In-Reply-To: <447A1AEF.3040900@rtr.ca>
References: <20060528140238.2c25a805.dickson@permanentmail.com>
	<1148850683.3074.72.camel@laptopd505.fenrus.org>
	<20060528142951.2a7417cb.dickson@permanentmail.com>
	<447A1AEF.3040900@rtr.ca>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.9.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Sun__28_May_2006_17_21_01_-0700_Dl.PMQwZw/iEr=I0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Sun__28_May_2006_17_21_01_-0700_Dl.PMQwZw/iEr=I0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 May 2006 17:49:35 -0400, Mark Lord wrote:

> We've just now put out a one-liner patch to libata that fixes
> resume on my own Inspiron, and for other machines as well.
> 
> Does it fix the problem here too?  (copy of patch is attached)
> 

Yes.  I compiled 2.6.17-rc5 without it and verified the problem occurs,
then applied the patch and tried it again.  This time it worked.

I can suspend AND hibernate with the patch.


I still get the BUG message on resuming that I reported in bugzilla
comment #9:
    https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=185108#c9
It is likely a separate bug.

Thanks for the patch!

	-Paul


--Multipart=_Sun__28_May_2006_17_21_01_-0700_Dl.PMQwZw/iEr=I0
Content-Type: text/plain;
 name="hibernate-dmesg"
Content-Disposition: attachment;
 filename="hibernate-dmesg"
Content-Transfer-Encoding: 7bit

Linux version 2.6.17-rc5 (dickson@white.pwd.internal) (gcc version 4.1.1 20060525 (Red Hat 4.1.1-1)) #1 Sun May 28 15:48:04 MST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 0000000000100000 - 000000004f7d3800 (usable)
 BIOS-e820: 000000004f7d3800 - 0000000050000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0007000 (reserved)
 BIOS-e820: 00000000f0008000 - 00000000f000c000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
375MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 325587
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 96211 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v000 DELL                                  ) @ 0x000fc9b0
ACPI: RSDT (v001 DELL    CPi R   0x27d50202 ASL  0x00000061) @ 0x4f7d3fd3
ACPI: FADT (v001 DELL    CPi R   0x27d50202 ASL  0x00000061) @ 0x4f7d4c00
ACPI: MADT (v001 DELL    CPi R   0x27d50202 ASL  0x00000047) @ 0x4f7d5400
ACPI: MCFG (v016 DELL    CPi R   0x27d50202 ASL  0x00000061) @ 0x4f7d53c0
ACPI: BOOT (v001 DELL    CPi R   0x27d50202 ASL  0x00000061) @ 0x4f7d4fc0
ACPI: SSDT (v001  PmRef  Cpu0Ist 0x00003000 INTL 0x20030522) @ 0x4f7d43e6
ACPI: SSDT (v001  PmRef  Cpu0Cst 0x00003001 INTL 0x20030522) @ 0x4f7d420e
ACPI: SSDT (v001  PmRef    CpuPm 0x00003000 INTL 0x20030522) @ 0x4f7d4013
ACPI: DSDT (v001 INT430 SYSFexxx 0x00001001 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
Allocating PCI resources starting at 60000000 (gap: 50000000:90000000)
Built 1 zonelists
Kernel command line: ro root=LABEL=/ hda=none hdc=none
ide_setup: hda=none
ide_setup: hdc=none
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Detected 1596.163 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1286020k/1302348k available (1794k kernel code, 15040k reserved, 665k data, 152k init, 384844k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3196.86 BogoMIPS (lpj=6393721)
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: afe9fbff 00100000 00000000 00000000 00000180 00000000 00000000
CPU: After vendor identify, caps: afe9fbff 00100000 00000000 00000000 00000180 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: After all inits, caps: afe9fbff 00100000 00000000 00000040 00000180 00000000 00000000
CPU: Intel(R) Pentium(R) M processor 1.60GHz stepping 08
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 0k freed
ACPI: setting ELCR to 0200 (from 0e80)
checking if image is initramfs... it is
Freeing initrd memory: 1067k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG
Setting up standard PCI resources
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
Boot video device is 0000:00:02.0
PCI quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
PCI quirk: region 1080-10bf claimed by ICH6 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
PCI: Transparent bridge - 0000:00:1e.0
PCI: Bus #04 (-#07) is hidden behind transparent bridge #03 (-#04) (try 'pci=assign-busses')
Please report the result to linux-kernel to fix this permanently
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7) *10
ACPI: PCI Interrupt Link [LNKC] (IRQs *9 10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 *7 9 10 11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
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
pnp: 00:08: ioport range 0x930-0x93f has been reserved
pnp: 00:08: ioport range 0x940-0x97f has been reserved
pnp: 00:0b: ioport range 0x7b0-0x7bb has been reserved
pnp: 00:0b: ioport range 0x7c0-0x7df has been reserved
pnp: 00:0b: ioport range 0xbb0-0xbbb has been reserved
pnp: 00:0b: ioport range 0xbc0-0xbdf has been reserved
pnp: 00:0b: ioport range 0xfb0-0xfbb has been reserved
pnp: 00:0b: ioport range 0xfc0-0xfdf has been reserved
pnp: 00:0b: ioport range 0x13b0-0x13bb has been reserved
pnp: 00:0b: ioport range 0x13c0-0x13df has been reserved
PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Failed to allocate I/O resource #7:1000@10000 for 0000:00:1e.0
PCI: Bus 4, cardbus bridge: 0000:03:01.0
  IO window: 00001400-000014ff
  IO window: 00001800-000018ff
  PREFETCH window: 60000000-61ffffff
  MEM window: 62000000-63ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: disabled.
  MEM window: dfd00000-dfdfffff
  PREFETCH window: 60000000-61ffffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
PCI: Enabling device 0000:03:01.0 (0000 -> 0003)
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 7
PCI: setting IRQ 7 as level-triggered
ACPI: PCI Interrupt 0000:03:01.0[A] -> Link [LNKD] -> GSI 7 (level, low) -> IRQ 7
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1310720 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
Simple Boot Flag at 0x79 set to 0x1
audit: initializing netlink socket (disabled)
audit(1148860881.184:1): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Lid Switch [LID]
ACPI: Power Button (CM) [PBTN]
ACPI: Sleep Button (CM) [SBTN]
ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
ACPI: Video Device [VID2] (multi-head: yes  rom: no  post: no)
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3] C4[C3])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Thermal Zone [THM] (48 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 915GM Chipset.
agpgart: Detected 7932K stolen memory.
agpgart: AGP aperture is 256M @ 0xc0000000
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ide0: I/O resource 0x1F0-0x1F7 not free.
ide0: ports already in use, skipping probe
Probing IDE interface ide1...
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
ide-floppy driver 0.99.newide
ACPI: PCI Interrupt 0000:03:01.0[A] -> Link [LNKD] -> GSI 7 (level, low) -> IRQ 7
Yenta: CardBus bridge found at 0000:03:01.0 [1028:0188]
Yenta: ISA IRQ mask 0x0c38, PCI irq 7
Socket status: 30000006
pcmcia: parent PCI bridge Memory window: 0xdfd00000 - 0xdfdfffff
pcmcia: parent PCI bridge Memory window: 0x60000000 - 0x61ffffff
usbcore: registered new driver libusual
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
ACPI wakeup devices: 
 LID PBTN PCI0 USB0 USB1 USB2 USB4 USB3 MODM PCIE 
ACPI: (supports S0 S3 S4 S5)
Freeing unused kernel memory: 152k freed
input: AT Translated Set 2 keyboard as /class/input/input0
SCSI subsystem initialized
libata version 1.20 loaded.
ata_piix 0000:00:1f.2: version 1.05
ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:1f.2[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xBFA0 irq 14
input: PS/2 Mouse as /class/input/input1
input: AlpsPS/2 ALPS GlidePoint as /class/input/input2
ata1: dev 0 cfg 49:0f00 82:746b 83:7fe8 84:4023 85:f469 86:3c48 87:4023 88:203f
ata1: dev 0 ATA-6, max UDMA/100, 117210240 sectors: LBA48
ata1(0): applying bridge limits
ata1: dev 0 configured for UDMA/100
scsi0 : ata_piix
  Vendor: ATA       Model: IC25N060ATMR04-0  Rev: MO3O
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: Attached scsi disk sda
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xBFA8 irq 15
ata2: dev 0 cfg 49:0f00 82:0210 83:4011 84:4000 85:0000 86:0001 87:4000 88:0407
ata2: dev 0 ATAPI, max UDMA/33
ata2: dev 0 configured for UDMA/33
scsi1 : ata_piix
  Vendor: TSSTcorp  Model: CDRW/DVD TSL462C  Rev: DE01
  Type:   CD-ROM                             ANSI SCSI revision: 05
device-mapper: 4.6.0-ioctl (2006-02-17) initialised: dm-devel@redhat.com
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 11, io base 0x0000bf80
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 5, io base 0x0000bf60
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
PCI: setting IRQ 9 as level-triggered
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 9 (level, low) -> IRQ 9
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 9, io base 0x0000bf40
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> Link [LNKD] -> GSI 7 (level, low) -> IRQ 7
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.3: irq 7, io base 0x0000bf20
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
b44.c:v1.00 (Apr 7, 2006)
ACPI: PCI Interrupt 0000:03:00.0[A] -> Link [LNKC] -> GSI 9 (level, low) -> IRQ 9
eth0: Broadcom 4400 10/100BaseT Ethernet 00:11:43:76:e0:2c
ACPI: PCI Interrupt 0000:00:1d.7[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 11, io mem 0xffa80800
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
sd 0:0:0:0: Attached scsi generic sg0 type 0
 1:0:0:0: Attached scsi generic sg1 type 5
ieee1394: Initialized config rom entry `ip1394'
ACPI: PCI Interrupt 0000:03:01.1[B] -> Link [LNKC] -> GSI 9 (level, low) -> IRQ 9
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[9]  MMIO=[dfdfc800-dfdfcfff]  Max Packet=[2048]  IR/IT contexts=[4/4]
cs: IO port probe 0xc00-0xcff: excluding 0xcf8-0xcff
cs: IO port probe 0x800-0x8ff: clean.
cs: IO port probe 0x100-0x4ff: excluding 0x370-0x377 0x3f0-0x3f7
cs: IO port probe 0xa00-0xaff: clean.
hw_random: cannot enable RNG, aborting
sr0: scsi3-mmc drive: 10x/24x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi CD-ROM sr0
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[394fc000054a9ce1]
ACPI: PCI Interrupt 0000:00:1e.2[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1e.2 to 64
intel8x0_measure_ac97_clock: measured 55282 usecs
intel8x0: clocking to 48000
Floppy drive(s): fd0 is 1.44M
floppy0: no floppy controllers found
lp: driver loaded but no devices found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
EXT3 FS on sda2, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 1959920k swap on /dev/sda3.  Priority:-1 extents:1 across:1959920k
b44: eth0: Link is up at 100 Mbps, full duplex.
b44: eth0: Flow control is off for TX and off for RX.
audit(1148860915.205:2): audit_pid=1667 old=0 by auid=4294967295
Bluetooth: Core ver 2.8
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: HIDP (Human Interface Emulation) ver 1.1
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present
[drm] Initialized drm 1.0.1 20051102
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
[drm] Initialized i915 1.4.0 20060119 on minor 0
NET: Unregistered protocol family 31
ieee1394: Node removed: ID:BUS[0-00:1023]  GUID[394fc000054a9ce1]
Stopping tasks: ============================================================================================================|
Back to C!
BUG: sleeping function called from invalid context at mm/slab.c:2794
in_atomic():0, irqs_disabled():1
 <c01c971b> acpi_os_acquire_object+0xf/0x3c  <c0149c48> kmem_cache_alloc+0x27/0x7f
 <c01c971b> acpi_os_acquire_object+0xf/0x3c  <c01df220> acpi_ut_allocate_object_desc_dbg+0xc/0x40
 <c01df26d> acpi_ut_create_internal_object_dbg+0x19/0x70  <c01db3ef> acpi_rs_set_srs_method_data+0x40/0xc5
 <c01e545d> acpi_pci_link_set+0x3e/0x16d  <c0149c96> kmem_cache_alloc+0x75/0x7f
 <c01e5515> acpi_pci_link_set+0xf6/0x16d  <c01e55c0> irqrouter_resume+0x34/0x52
 <c020eb77> __sysdev_resume+0x12/0x55  <c020ecd4> sysdev_resume+0x16/0x47
 <c0213117> device_power_up+0x5/0xa  <c01293db> suspend_enter+0x32/0x3a
 <c0129504> enter_state+0x121/0x13e  <c01295a2> state_store+0x81/0x94
 <c0182fa9> sysfs_write_file+0xa3/0xc9  <c014d4c8> vfs_write+0xa2/0x136
 <c014d9d2> sys_write+0x3b/0x64  <c0102ab3> syscall_call+0x7/0xb
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.0 to 64
usb usb1: root hub lost power or was reset
PCI: Enabling device 0000:00:1d.1 (0000 -> 0001)
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1d.1 to 64
usb usb2: root hub lost power or was reset
PCI: Enabling device 0000:00:1d.2 (0000 -> 0001)
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 9 (level, low) -> IRQ 9
PCI: Setting latency timer of device 0000:00:1d.2 to 64
usb usb3: root hub lost power or was reset
PCI: Enabling device 0000:00:1d.3 (0000 -> 0001)
ACPI: PCI Interrupt 0000:00:1d.3[D] -> Link [LNKD] -> GSI 7 (level, low) -> IRQ 7
PCI: Setting latency timer of device 0000:00:1d.3 to 64
usb usb4: root hub lost power or was reset
ACPI: PCI Interrupt 0000:00:1d.7[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.7 to 64
usb usb5: root hub lost power or was reset
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
PCI: Setting latency timer of device 0000:00:1e.0 to 64
ACPI: PCI Interrupt 0000:00:1e.2[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1e.2 to 64
ACPI: PCI Interrupt 0000:00:1f.2[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ACPI: PCI Interrupt 0000:03:00.0[A] -> Link [LNKC] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI Interrupt 0000:03:01.0[A] -> Link [LNKD] -> GSI 7 (level, low) -> IRQ 7
ACPI: PCI Interrupt 0000:03:01.1[B] -> Link [LNKC] -> GSI 9 (level, low) -> IRQ 9
pnp: Device 00:04 does not support activation.
pnp: Device 00:05 does not support activation.
ata1: dev 0 configured for UDMA/100
ata2: dev 0 configured for UDMA/33
Restarting tasks... done
ieee1394: Initialized config rom entry `ip1394'
ACPI: PCI Interrupt 0000:03:01.1[B] -> Link [LNKC] -> GSI 9 (level, low) -> IRQ 9
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[9]  MMIO=[dfdfc800-dfdfcfff]  Max Packet=[2048]  IR/IT contexts=[4/4]
Bluetooth: Core ver 2.8
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: HIDP (Human Interface Emulation) ver 1.1
b44: eth0: Link is up at 100 Mbps, full duplex.
b44: eth0: Flow control is off for TX and off for RX.
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[394fc000054a9ce1]
NET: Unregistered protocol family 31
ieee1394: Node removed: ID:BUS[0-00:1023]  GUID[394fc000054a9ce1]
Stopping tasks: ==============================================================================================================|
Back to C!
BUG: sleeping function called from invalid context at mm/slab.c:2794
in_atomic():0, irqs_disabled():1
 <c01c971b> acpi_os_acquire_object+0xf/0x3c  <c0149c48> kmem_cache_alloc+0x27/0x7f
 <c01c971b> acpi_os_acquire_object+0xf/0x3c  <c01df220> acpi_ut_allocate_object_desc_dbg+0xc/0x40
 <c01df26d> acpi_ut_create_internal_object_dbg+0x19/0x70  <c01db3ef> acpi_rs_set_srs_method_data+0x40/0xc5
 <c01e545d> acpi_pci_link_set+0x3e/0x16d  <c0149c96> kmem_cache_alloc+0x75/0x7f
 <c01e5515> acpi_pci_link_set+0xf6/0x16d  <c01e55c0> irqrouter_resume+0x34/0x52
 <c020eb77> __sysdev_resume+0x12/0x55  <c020ecd4> sysdev_resume+0x16/0x47
 <c0213117> device_power_up+0x5/0xa  <c01293db> suspend_enter+0x32/0x3a
 <c0129504> enter_state+0x121/0x13e  <c01295a2> state_store+0x81/0x94
 <c0182fa9> sysfs_write_file+0xa3/0xc9  <c014d4c8> vfs_write+0xa2/0x136
 <c014d9d2> sys_write+0x3b/0x64  <c0102ab3> syscall_call+0x7/0xb
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.0 to 64
usb usb1: root hub lost power or was reset
PCI: Enabling device 0000:00:1d.1 (0000 -> 0001)
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1d.1 to 64
usb usb2: root hub lost power or was reset
PCI: Enabling device 0000:00:1d.2 (0000 -> 0001)
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 9 (level, low) -> IRQ 9
PCI: Setting latency timer of device 0000:00:1d.2 to 64
usb usb3: root hub lost power or was reset
PCI: Enabling device 0000:00:1d.3 (0000 -> 0001)
ACPI: PCI Interrupt 0000:00:1d.3[D] -> Link [LNKD] -> GSI 7 (level, low) -> IRQ 7
PCI: Setting latency timer of device 0000:00:1d.3 to 64
usb usb4: root hub lost power or was reset
ACPI: PCI Interrupt 0000:00:1d.7[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.7 to 64
usb usb5: root hub lost power or was reset
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
PCI: Setting latency timer of device 0000:00:1e.0 to 64
ACPI: PCI Interrupt 0000:00:1e.2[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1e.2 to 64
ACPI: PCI Interrupt 0000:00:1f.2[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ACPI: PCI Interrupt 0000:03:00.0[A] -> Link [LNKC] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI Interrupt 0000:03:01.0[A] -> Link [LNKD] -> GSI 7 (level, low) -> IRQ 7
ACPI: PCI Interrupt 0000:03:01.1[B] -> Link [LNKC] -> GSI 9 (level, low) -> IRQ 9
pnp: Device 00:04 does not support activation.
pnp: Device 00:05 does not support activation.
ata1: dev 0 configured for UDMA/100
ata2: dev 0 configured for UDMA/33
Restarting tasks... done
ieee1394: Initialized config rom entry `ip1394'
ACPI: PCI Interrupt 0000:03:01.1[B] -> Link [LNKC] -> GSI 9 (level, low) -> IRQ 9
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[9]  MMIO=[dfdfc800-dfdfcfff]  Max Packet=[2048]  IR/IT contexts=[4/4]
b44: eth0: Link is up at 100 Mbps, full duplex.
b44: eth0: Flow control is off for TX and off for RX.
Bluetooth: Core ver 2.8
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: HIDP (Human Interface Emulation) ver 1.1
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[394fc000054a9ce1]
NET: Unregistered protocol family 31
ieee1394: Node removed: ID:BUS[0-00:1023]  GUID[394fc000054a9ce1]
Stopping tasks: ============================================================================================================|
Shrinking memory...  -\done (15972 pages freed)
..........
swsusp: Need to copy 73999 pages
swsusp: Restoring Highmem
BUG: sleeping function called from invalid context at mm/slab.c:2794
in_atomic():0, irqs_disabled():1
 <c01c971b> acpi_os_acquire_object+0xf/0x3c  <c0149c48> kmem_cache_alloc+0x27/0x7f
 <c01c971b> acpi_os_acquire_object+0xf/0x3c  <c01df220> acpi_ut_allocate_object_desc_dbg+0xc/0x40
 <c01df26d> acpi_ut_create_internal_object_dbg+0x19/0x70  <c01db3ef> acpi_rs_set_srs_method_data+0x40/0xc5
 <c01e545d> acpi_pci_link_set+0x3e/0x16d  <c0149c96> kmem_cache_alloc+0x75/0x7f
 <c01e5515> acpi_pci_link_set+0xf6/0x16d  <c01e55c0> irqrouter_resume+0x34/0x52
 <c020eb77> __sysdev_resume+0x12/0x55  <c020ecd4> sysdev_resume+0x16/0x47
 <c0213117> device_power_up+0x5/0xa  <c0129d22> swsusp_suspend+0x6b/0x83
 <c012a238> pm_suspend_disk+0x42/0xc5  <c0129432> enter_state+0x4f/0x13e
 <c01295a2> state_store+0x81/0x94  <c0182fa9> sysfs_write_file+0xa3/0xc9
 <c014d4c8> vfs_write+0xa2/0x136  <c014d9d2> sys_write+0x3b/0x64
 <c0102ab3> syscall_call+0x7/0xb 
irq 11: nobody cared (try booting with the "irqpoll" option)
 <c01315b3> __report_bad_irq+0x2b/0x69  <c0131778> note_interrupt+0x187/0x1b3
 <c01310e5> handle_IRQ_event+0x22/0x4e  <c01311a8> __do_IRQ+0x97/0xcb
 <c010439e> do_IRQ+0x19/0x24  <c0102c7e> common_interrupt+0x1a/0x20
 <c02b007b> __xfrm4_bundle_create+0x2c4/0x34b  <c0116623> __do_softirq+0x2c/0x7f
 <c0116698> do_softirq+0x22/0x26  <c01043a3> do_IRQ+0x1e/0x24
 <c0102c7e> common_interrupt+0x1a/0x20  <c014970e> cache_alloc_refill+0x2a9/0x5b2
 <c01c9825> acpi_os_allocate+0x15/0x26  <c01c971b> acpi_os_acquire_object+0xf/0x3c
 <c0149c88> kmem_cache_alloc+0x67/0x7f  <c01c971b> acpi_os_acquire_object+0xf/0x3c
 <c01df3dc> acpi_ut_create_generic_state+0xc/0x25  <c01d77ac> acpi_ns_evaluate_relative+0x47/0xcf
 <c01db44c> acpi_rs_set_srs_method_data+0x9d/0xc5  <c01e545d> acpi_pci_link_set+0x3e/0x16d
 <c0140096> sys_mprotect+0x236/0x45c  <c01e5515> acpi_pci_link_set+0xf6/0x16d
 <c01e55c0> irqrouter_resume+0x34/0x52  <c020eb77> __sysdev_resume+0x12/0x55
 <c020ecd4> sysdev_resume+0x16/0x47  <c0213117> device_power_up+0x5/0xa
 <c0129d22> swsusp_suspend+0x6b/0x83  <c012a238> pm_suspend_disk+0x42/0xc5
 <c0129432> enter_state+0x4f/0x13e  <c01295a2> state_store+0x81/0x94
 <c0182fa9> sysfs_write_file+0xa3/0xc9  <c014d4c8> vfs_write+0xa2/0x136
 <c014d9d2> sys_write+0x3b/0x64  <c0102ab3> syscall_call+0x7/0xb
handlers:
[<c023dac1>] (usb_hcd_irq+0x0/0x54)
[<c023dac1>] (usb_hcd_irq+0x0/0x54)
Disabling IRQ #11
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.0 to 64
usb usb1: root hub lost power or was reset
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1d.1 to 64
usb usb2: root hub lost power or was reset
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 9 (level, low) -> IRQ 9
PCI: Setting latency timer of device 0000:00:1d.2 to 64
usb usb3: root hub lost power or was reset
ACPI: PCI Interrupt 0000:00:1d.3[D] -> Link [LNKD] -> GSI 7 (level, low) -> IRQ 7
PCI: Setting latency timer of device 0000:00:1d.3 to 64
usb usb4: root hub lost power or was reset
ACPI: PCI Interrupt 0000:00:1d.7[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.7 to 64
usb usb5: root hub lost power or was reset
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
PCI: Setting latency timer of device 0000:00:1e.0 to 64
ACPI: PCI Interrupt 0000:00:1e.2[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1e.2 to 64
ACPI: PCI Interrupt 0000:00:1f.2[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ACPI: PCI Interrupt 0000:03:00.0[A] -> Link [LNKC] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI Interrupt 0000:03:01.0[A] -> Link [LNKD] -> GSI 7 (level, low) -> IRQ 7
ACPI: PCI Interrupt 0000:03:01.1[B] -> Link [LNKC] -> GSI 9 (level, low) -> IRQ 9
pnp: Device 00:04 does not support activation.
pnp: Device 00:05 does not support activation.
ata1: dev 0 configured for UDMA/100
ata2: dev 0 configured for UDMA/33
Restarting tasks... done
ieee1394: Initialized config rom entry `ip1394'
ACPI: PCI Interrupt 0000:03:01.1[B] -> Link [LNKC] -> GSI 9 (level, low) -> IRQ 9
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[9]  MMIO=[dfdfc800-dfdfcfff]  Max Packet=[2048]  IR/IT contexts=[4/4]
Bluetooth: Core ver 2.8
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: HIDP (Human Interface Emulation) ver 1.1
b44: eth0: Link is up at 100 Mbps, full duplex.
b44: eth0: Flow control is off for TX and off for RX.
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[394fc000054a9ce1]

--Multipart=_Sun__28_May_2006_17_21_01_-0700_Dl.PMQwZw/iEr=I0--
