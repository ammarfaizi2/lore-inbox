Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161282AbWBUCWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161282AbWBUCWc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 21:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161283AbWBUCWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 21:22:31 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:24968 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S1161282AbWBUCW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 21:22:29 -0500
From: Francesco Biscani <biscani@pd.astro.it>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata PATA drivers patch for 2.6.16-rc4
Date: Tue, 21 Feb 2006 03:22:17 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <1140445182.26526.1.camel@localhost.localdomain> <200602202226.43772.biscani@pd.astro.it> <1140476227.26526.43.camel@localhost.localdomain>
In-Reply-To: <1140476227.26526.43.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Zln+DHppujdEzmb"
Message-Id: <200602210322.17336.biscani@pd.astro.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_Zln+DHppujdEzmb
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 20 February 2006 23:57, Alan Cox wrote:
> UDMA support is there and was selected. Older chip revisions have
> special handing for LBA48 (large disks/large requests) but I thought I
> had that all sorted now so wouldn't expect such a hit.
>
> Please send me an lspci -vxx
>
> Thanks.

lspci -vxx and dmesg attached. I have disabled all under IDE menu, I'm runn=
ing=20
only on libata now. With the patch from Mark Lord I can see the cdrom drive=
,=20
but as /dev/sdb, not /dev/sr0, and I have some messages like

ATA: abnormal status 0x58 on port 0x177

(see dmesg). Haven't tested much, but apart from the speed issue it seems=20
stable. hdparm -Tt says:

/dev/sda:
 Timing cached reads:   1124 MB in  2.00 seconds =3D 561.57 MB/sec
 Timing buffered disk reads:    8 MB in  3.76 seconds =3D   2.13 MB/sec

Regards,

  Francesco

=2D-=20
Dr. Francesco Biscani
Dipartimento di Astronomia
Universit=E0 di Padova
biscani@pd.astro.it

--Boundary-00=_Zln+DHppujdEzmb
Content-Type: text/x-log;
  charset="iso-8859-15";
  name="dmesg.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg.log"

Linux version 2.6.16-rc4-morph1-exp (yardbird@kurtz) (gcc version 4.1.0-pre20060219 (prerelease)) #7 Tue Feb 21 03:05:17 CET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d8000 - 00000000000e0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001bf70000 (usable)
 BIOS-e820: 000000001bf70000 - 000000001bf7c000 (ACPI data)
 BIOS-e820: 000000001bf7c000 - 000000001bf80000 (ACPI NVS)
 BIOS-e820: 000000001bf80000 - 000000001c000000 (reserved)
 BIOS-e820: 000000002bf80000 - 000000002c000000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
447MB LOWMEM available.
On node 0 totalpages: 114544
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 110448 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:0
DMI 2.3 present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f6ab0
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x1bf75284
ACPI: FADT (v001 ATI    Salmon   0x06040000 ATI  0x000f4240) @ 0x1bf7bf64
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x1bf7bfd8
ACPI: DSDT (v001    ATI MS2_1535 0x06040000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x8008
Allocating PCI resources starting at 30000000 (gap: 2c000000:d3f80000)
Built 1 zonelists
Kernel command line: root=/dev/sda6 resume2=swap:/dev/sda5 video=radeonfb:ywrap,mtrr:2,1024x768-16 CONSOLE=/dev/tty1
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c0410000 soft=c040f000
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 2391.845 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 450344k/458176k available (2235k kernel code, 7296k reserved, 726k data, 144k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 4792.07 BogoMIPS (lpj=2396036)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebf9ff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebf9ff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After all inits, caps: bfebf9ff 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU: Intel Mobile Intel(R) Pentium(R) 4     CPU 2.40GHz stepping 09
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0420)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd89b, last bus=2
PCI: Using configuration type 1
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:10.0
PCI quirk: region 8000-803f claimed by ali7101 ACPI
PCI quirk: region 8040-805f claimed by ali7101 SMB
Boot video device is 0000:01:05.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK0] (IRQs 7 10) *0, disabled.
ACPI: PCI Interrupt Link [LNK1] (IRQs 7 *10)
ACPI: PCI Interrupt Link [LNK2] (IRQs 7 *10)
ACPI: PCI Interrupt Link [LNK3] (IRQs 7 *10)
ACPI: PCI Interrupt Link [LNK4] (IRQs 7 10) *0, disabled.
ACPI: PCI Interrupt Link [LNK5] (IRQs 7 11) *0, disabled.
ACPI: PCI Interrupt Link [LNK6] (IRQs 7 10) *0, disabled.
ACPI: PCI Interrupt Link [LNK7] (IRQs *5)
ACPI: PCI Interrupt Link [LNK8] (IRQs 7 10) *0, disabled.
ACPI: Embedded Controller [EC0] (gpe 24) interrupt mode.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 10 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:07: ioport range 0x40b-0x40b has been reserved
pnp: 00:07: ioport range 0x480-0x48f has been reserved
pnp: 00:07: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:07: ioport range 0x4d6-0x4d6 has been reserved
pnp: 00:07: ioport range 0x8000-0x807f could not be reserved
PCI: Bridge: 0000:00:01.0
  IO window: 9000-9fff
  MEM window: d0300000-d03fffff
  PREFETCH window: d8000000-dfffffff
PCI: Bus 2, cardbus bridge: 0000:00:0a.0
  IO window: 00001800-000018ff
  IO window: 00001c00-00001cff
  PREFETCH window: 30000000-31ffffff
  MEM window: 32000000-33ffffff
PCI: Enabling device 0000:00:0a.0 (0000 -> 0003)
ACPI: PCI Interrupt Link [LNK5] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNK5] -> GSI 11 (level, low) -> IRQ 11
Simple Boot Flag at 0x37 set to 0x1
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
Loading Reiser4. See www.namesys.com for a description of Reiser4.
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Activating ISA DMA hang workarounds.
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected Ati IGP345M chipset
agpgart: AGP aperture is 64M @ 0xd4000000
ACPI: PCI Interrupt Link [LNK0] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:01:05.0[A] -> Link [LNK0] -> GSI 10 (level, low) -> IRQ 10
radeonfb: Retrieved PLL infos from BIOS
radeonfb: Reference=14.32 MHz (RefDiv=31) Memory=183.00 Mhz, System=133.00 MHz
radeonfb: PLL min 12000 max 35000
Non-DDC laptop panel detected
radeonfb: Monitor 1 type LCD found
radeonfb: Monitor 2 type no found
radeonfb: panel ID string: LGP                     
radeonfb: detected LVDS panel size from BIOS: 1024x768
radeondb: BIOS provided dividers will be used
radeonfb: Dynamic Clock Power Management enabled
Console: switching to colour frame buffer device 128x48
radeonfb (0000:01:05.0): ATI Radeon C7 
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Lid Switch [LID]
ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
Using specific hotkey driver
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Thermal Zone [THRM] (51 C)
PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSE0] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
natsemi dp8381x driver, version 1.07+LK1.0.17, Sep 27, 2002
  originally by Donald Becker <becker@scyld.com>
  http://www.scyld.com/network/natsemi.html
  2.4.x kernel port by Jeff Garzik, Tjeerd Mulder
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:12.0[A] -> Link [LNK1] -> GSI 10 (level, low) -> IRQ 10
natsemi eth0: NatSemi DP8381[56] at 0xd0008000 (0000:00:12.0), 00:0f:20:22:06:e5, IRQ 10, port TP.
libata version 1.20 loaded.
ACPI: PCI Interrupt 0000:00:10.0[A]: no GSI
ata1: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x2040 irq 14
ata1: dev 0 cfg 49:0f00 82:746b 83:7fe8 84:4023 85:f469 86:3e48 87:4023 88:203f
ata1: dev 0 ATA-6, max UDMA/100, 78140160 sectors: LBA48
ata1: dev 0 configured for UDMA/100
scsi0 : ali
  Vendor: ATA       Model: IC25N040ATMR04-0  Rev: MO2O
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata2: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x2048 irq 15
ata2: dev 0 cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:0000
ata2: dev 0 ATAPI, max MWDMA2
ata2: dev 0 configured for MWDMA2
scsi1 : ali
ata2: command 0xa0 timeout, stat 0x58 host_stat 0x1
  Vendor:           Model:                   Rev:     
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 78140160 512-byte hdwr sectors (40008 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 78140160 512-byte hdwr sectors (40008 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 < sda5 sda6 > sda4
sd 0:0:0:0: Attached scsi disk sda
ATA: abnormal status 0x58 on port 0x177
ATA: abnormal status 0x58 on port 0x177
ATA: abnormal status 0x58 on port 0x177
sd 1:0:0:0: Attached scsi disk sdb
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNK5] -> GSI 11 (level, low) -> IRQ 11
Yenta: CardBus bridge found at 0000:00:0a.0 [0000:0000]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:0a.0, mfunc 0x01111112, devctl 0x64
Yenta: ISA IRQ mask 0x04f8, PCI irq 11
Socket status: 30000006
mice: PS/2 mouse device common for all mice
Advanced Linux Sound Architecture Driver Version 1.0.11rc2 (Wed Jan 04 08:57:20 2006 UTC).
PCI: Enabling device 0000:00:06.0 (0005 -> 0007)
ACPI: PCI Interrupt Link [LNK7] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [LNK7] -> GSI 5 (level, low) -> IRQ 5
input: AT Translated Set 2 keyboard as /class/input/input0
Synaptics Touchpad, model: 1, fw: 5.9, id: 0x236eb3, caps: 0x904713/0x10008
input: SynPS/2 Synaptics TouchPad as /class/input/input1
AC'97 1 does not respond - RESET
AC'97 1 access is not valid [0xffffffff], removing mixer.
ali mixer 1 creating error.
ALSA device list:
  #0: ALI 5451 at 0x1000, irq 5
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 4, 65536 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
acpi-cpufreq: CPU0 - ACPI performance management activated.
Using IPI Shortcut mode
ACPI wakeup devices: 
PCI0 MDEM  LAN  LID 
ACPI: (supports S0 S3 S4 S5)
VFS: Mounted root (reiser4 filesystem) readonly.
Freeing unused kernel memory: 144k freed
cs: IO port probe 0x100-0x3af: excluding 0x200-0x207 0x220-0x22f 0x2f8-0x2ff 0x330-0x337 0x370-0x37f 0x388-0x38f
cs: IO port probe 0x3e0-0x4ff: excluding 0x3f0-0x3f7
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt Link [LNK2] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNK2] -> GSI 10 (level, low) -> IRQ 10
uhci_hcd 0000:00:0b.0: UHCI Host Controller
uhci_hcd 0000:00:0b.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:0b.0: irq 10, io base 0x00002000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNK3] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:0b.1[B] -> Link [LNK3] -> GSI 10 (level, low) -> IRQ 10
uhci_hcd 0000:00:0b.1: UHCI Host Controller
uhci_hcd 0000:00:0b.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:0b.1: irq 10, io base 0x00002020
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
PCI: Enabling device 0000:00:0b.2 (0010 -> 0012)
ACPI: PCI Interrupt 0000:00:0b.2[C] -> Link [LNK5] -> GSI 11 (level, low) -> IRQ 11
PCI: Via IRQ fixup for 0000:00:0b.2, from 255 to 11
ehci_hcd 0000:00:0b.2: EHCI Host Controller
ehci_hcd 0000:00:0b.2: new USB bus registered, assigned bus number 3
ehci_hcd 0000:00:0b.2: irq 11, io mem 0xd0003000
ehci_hcd 0000:00:0b.2: USB 2.0 started, EHCI 0.95, driver 10 Dec 2004
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 4 ports detected
Realtime LSM initialized (group 10, mlock=1)
loop: loaded (max 8 devices)
usb 3-3: new high speed USB device using ehci_hcd and address 3
usb 3-3: configuration #1 chosen from 1 choice
usb 1-2: new low speed USB device using uhci_hcd and address 2
usb 1-2: configuration #1 chosen from 1 choice
input: Logitech USB-PS/2 Optical Mouse as /class/input/input2
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:0b.0-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
Initializing USB Mass Storage driver...
scsi2 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 3
usb-storage: waiting for device to settle before scanning
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
  Vendor: WDC WD80  Model: 0UE-22HCT0        Rev: 0000
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdc: 156301488 512-byte hdwr sectors (80026 MB)
sdc: Write Protect is off
sdc: Mode Sense: 27 00 00 00
sdc: assuming drive cache: write through
SCSI device sdc: 156301488 512-byte hdwr sectors (80026 MB)
sdc: Write Protect is off
sdc: Mode Sense: 27 00 00 00
sdc: assuming drive cache: write through
 sdc: sdc1 sdc2
sd 2:0:0:0: Attached scsi disk sdc
usb-storage: device scan complete
eth0: DSPCFG accepted after 0 usec.
eth0: link up.
eth0: Setting full-duplex based on negotiated link capability.
ip_tables: (C) 2000-2006 Netfilter Core Team
ip_conntrack version 2.4 (3579 buckets, 28632 max) - 232 bytes per conntrack
microcode: CPU0 updated from revision 0x1a to 0x2f, date = 08112004 
ata2: command 0xa0 timeout, stat 0x58 host_stat 0x1
ATA: abnormal status 0x58 on port 0x177
ATA: abnormal status 0x58 on port 0x177
ATA: abnormal status 0x58 on port 0x177
[drm] Initialized drm 1.0.1 20051102
ACPI: PCI Interrupt 0000:01:05.0[A] -> Link [LNK0] -> GSI 10 (level, low) -> IRQ 10
[drm] Initialized radeon 1.23.0 20051229 on minor 0
mtrr: 0xd8000000,0x8000000 overlaps existing 0xd8000000,0x4000000
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:05.0 into 4x mode
[drm] Setting GART location based on new memory map
[drm] writeback test succeeded in 1 usecs
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:05.0 into 4x mode

--Boundary-00=_Zln+DHppujdEzmb
Content-Type: text/x-log;
  charset="iso-8859-15";
  name="lspci.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lspci.log"

00:00.0 Host bridge: ATI Technologies Inc RS200/RS200M AGP Bridge [IGP 340M] (rev 02)
	Flags: bus master, 66MHz, medium devsel, latency 64
	Memory at d4000000 (32-bit, prefetchable) [size=64M]
	Memory at d0009000 (32-bit, prefetchable) [size=4K]
	Capabilities: [a0] AGP version 2.0
00: 02 10 b2 cb 06 00 30 02 02 00 00 06 00 40 00 00
10: 08 00 00 d4 08 90 00 d0 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: ATI Technologies Inc PCI Bridge [IGP 340M] (prog-if 00 [Normal decode])
	Flags: bus master, 66MHz, medium devsel, latency 99
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: d0300000-d03fffff
	Prefetchable memory behind bridge: d8000000-dfffffff
00: 02 10 10 70 07 00 20 02 00 00 04 06 00 63 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 44 91 91 20 02
20: 30 d0 30 d0 00 d8 f0 df 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 0c 00

00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link Controller Audio Device (rev 02)
	Subsystem: Hewlett-Packard Company Unknown device 0850
	Flags: bus master, medium devsel, latency 64, IRQ 5
	I/O ports at 1000 [size=256]
	Memory at d0000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
00: b9 10 51 54 07 00 90 c2 02 00 01 04 00 40 00 00
10: 01 10 00 00 00 00 00 d0 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 50 08
30: 00 00 00 00 dc 00 00 00 00 00 00 00 05 01 02 18

00:07.0 ISA bridge: ALi Corporation M1533/M1535 PCI to ISA Bridge [Aladdin IV/V/V+]
	Subsystem: ALi Corporation ALi M1533 Aladdin IV/V ISA Bridge
	Flags: bus master, medium devsel, latency 0
	Capabilities: [a0] Power Management version 1
00: b9 10 33 15 0f 00 10 02 00 00 01 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b9 10 33 15
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

00:08.0 Modem: ALi Corporation M5457 AC'97 Modem Controller (prog-if 00 [Generic])
	Subsystem: Hewlett-Packard Company Unknown device 0850
	Flags: medium devsel, IRQ 255
	Memory at d0001000 (32-bit, non-prefetchable) [disabled] [size=4K]
	I/O ports at 1400 [disabled] [size=256]
	Capabilities: [40] Power Management version 2
00: b9 10 57 54 00 00 90 02 00 00 03 07 00 40 00 00
10: 00 10 00 d0 01 14 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 50 08
30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 00 00

00:0a.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 02)
	Flags: bus master, medium devsel, latency 168, IRQ 11
	Memory at d0002000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 30000000-31fff000 (prefetchable)
	Memory window 1: 32000000-33fff000
	I/O window 0: 00001800-000018ff
	I/O window 1: 00001c00-00001cff
	16-bit legacy interface ports at 0001
00: 4c 10 50 ac 07 00 10 02 02 00 07 06 20 a8 02 00
10: 00 20 00 d0 a0 00 00 02 00 02 05 b0 00 00 00 30
20: 00 f0 ff 31 00 00 00 32 00 f0 ff 33 00 18 00 00
30: fc 18 00 00 00 1c 00 00 fc 1c 00 00 0b 01 c0 05
40: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0b.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 50) (prog-if 00 [UHCI])
	Subsystem: Hewlett-Packard Company Unknown device 0850
	Flags: bus master, medium devsel, latency 64, IRQ 10
	I/O ports at 2000 [size=32]
	Capabilities: [80] Power Management version 2
00: 06 11 38 30 15 00 10 02 50 00 03 0c 08 40 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 20 00 00 00 00 00 00 00 00 00 00 3c 10 50 08
30: 00 00 00 00 80 00 00 00 00 00 00 00 0a 01 00 00

00:0b.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 50) (prog-if 00 [UHCI])
	Subsystem: Hewlett-Packard Company Unknown device 0850
	Flags: bus master, medium devsel, latency 64, IRQ 10
	I/O ports at 2020 [size=32]
	Capabilities: [80] Power Management version 2
00: 06 11 38 30 15 00 10 02 50 00 03 0c 08 40 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 21 20 00 00 00 00 00 00 00 00 00 00 3c 10 50 08
30: 00 00 00 00 80 00 00 00 00 00 00 00 0a 02 00 00

00:0b.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51) (prog-if 20 [EHCI])
	Subsystem: Hewlett-Packard Company Unknown device 0850
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at d0003000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2
00: 06 11 04 31 16 00 10 02 51 20 03 0c 20 40 80 00
10: 00 30 00 d0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 50 08
30: 00 00 00 00 80 00 00 00 00 00 00 00 0b 03 00 00

00:0c.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
	Subsystem: Hewlett-Packard Company Unknown device 0850
	Flags: medium devsel, IRQ 255
	Memory at d0003800 (32-bit, non-prefetchable) [disabled] [size=2K]
	Memory at d0004000 (32-bit, non-prefetchable) [disabled] [size=16K]
	Capabilities: [44] Power Management version 2
00: 4c 10 26 80 10 00 10 02 00 10 00 0c 08 40 00 00
10: 00 38 00 d0 00 40 00 d0 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 50 08
30: 00 00 00 00 44 00 00 00 00 00 00 00 ff 01 02 04

00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c4) (prog-if fa)
	Subsystem: Hewlett-Packard Company Unknown device 0850
	Flags: bus master, medium devsel, latency 32
	I/O ports at 2040 [size=16]
	Capabilities: [60] Power Management version 2
00: b9 10 29 52 05 00 90 02 c4 fa 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 41 20 00 00 00 00 00 00 00 00 00 00 3c 10 50 08
30: 00 00 00 00 60 00 00 00 00 00 00 00 00 01 02 04

00:11.0 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
	Subsystem: Hewlett-Packard Company Unknown device 0850
	Flags: medium devsel
00: b9 10 01 71 00 00 00 02 00 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 50 08
30: 00 00 00 00 e4 00 00 00 00 00 00 00 00 00 00 00

00:12.0 Ethernet controller: National Semiconductor Corporation DP83815 (MacPhyter) Ethernet Controller
	Subsystem: Hewlett-Packard Company Unknown device 0850
	Flags: bus master, medium devsel, latency 90, IRQ 10
	I/O ports at 2400 [size=256]
	Memory at d0008000 (32-bit, non-prefetchable) [size=4K]
	[virtual] Expansion ROM at 34000000 [disabled] [size=64K]
	Capabilities: [40] Power Management version 2
00: 0b 10 20 00 07 00 90 02 00 00 00 02 00 5a 00 00
10: 01 24 00 00 00 80 00 d0 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 50 08
30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 01 0b 34

01:05.0 VGA compatible controller: ATI Technologies Inc Radeon IGP 330M/340M/350M (prog-if 00 [VGA])
	Subsystem: Hewlett-Packard Company Radeon IGP 345M
	Flags: bus master, stepping, fast Back2Back, 66MHz, medium devsel, latency 66, IRQ 10
	Memory at d8000000 (32-bit, prefetchable) [size=128M]
	I/O ports at 9000 [size=256]
	Memory at d0300000 (32-bit, non-prefetchable) [size=64K]
	[virtual] Expansion ROM at d0320000 [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
	Capabilities: [50] Power Management version 2
00: 02 10 37 43 87 02 b0 02 00 00 00 03 08 42 00 00
10: 08 00 00 d8 01 90 00 00 00 00 30 d0 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 50 08
30: 00 00 00 00 58 00 00 00 00 00 00 00 ff 01 08 00


--Boundary-00=_Zln+DHppujdEzmb--
