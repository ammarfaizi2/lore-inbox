Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030263AbWGFRZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030263AbWGFRZN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 13:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030312AbWGFRZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 13:25:13 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:28575 "EHLO
	pilet.ens-lyon.fr") by vger.kernel.org with ESMTP id S1030263AbWGFRZK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 13:25:10 -0400
Message-ID: <20060706192506.14j732mosf400wk0@mouette.ens-lyon.fr>
Date: Thu, 06 Jul 2006 19:25:06 +0200
From: Cedric Augonnet <cedric.augonnet@ens-lyon.fr>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Kernel crash with ehci when plugging my USB hard drive
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=_2mthbm4mdshs"
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.0.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format.

--=_2mthbm4mdshs
Content-Type: text/plain;
	charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

I get following panic when hot plugging my USB hard drive to my Thinkpad T4=
3 (or
booting with the HD plugged). I works fine on 2.6.17 but crashes on 2.6.18-=
rc1.
My .config is attached, and lscpi and dmesg before the panic in case it mat=
ters.

regards,
C=E9dric

___________________________________________________________________________=
___
Call Trace:
 [<c011222e>] complete+0x1f/0x28
 [<e0861b42>] usb_hcd_giveback_urb+0x2d/0x5d [usbcore]
 [<e08a0a5c>] ehci_urb_done+0x5b/Ox62 [ehci_hcd]
 [<e08a1bfb>] qh_completions+0x27c/0x2f7 [ehci_hcd]
 [<e08a1cbe>] end_unlink_async+0x48/0xd2 [ehci_hcd]
 [<e08a03ec>] qh_destroy+0x0/0x4a [ehci_hcd]
 [<e08a1f52>] ehci_work+0x24/0x595 [ehci_hcd]
 [<c011c9b7>] do_timer+0x6d5/0x81b
 [<c0112eaf>] scheduler_tick+0xe/0x28a
 [<e08a2877>] ehci_irq+0x116/0x122 [ehci_hcd]
 [<e086192e>] usb_hcd_irq+0x26/0x54 [usbcore]
 [<c012f1e4>] handle_IRQ_event+0x21/0x49
 [<c012f264>] __do_IRQ+0x58/0x9e
 [<c0104b95>] do_IRQ+0x43/0x52
 [<c0103452>] common_interrupt+0x1a/0x20
 [<c01019c8>] default_idle+0x31/0x59
 [<c0101a2e>] cpu_idle+0x3e/0x56
 [<c03b8606>] start_kernel+0x267/0x269

Code: 3e c0 11 0d 4c f0 3e c0 eb 0c 01 1d 58 f0 3e c0 11 0d 5c f0 3e c0 5b =
5d c3
 55 89 e5 57 56 89 ce 53 57 57 89 45 f0 89 55 ec 8b 10 <8b> 1a eb 26 8b 7a =
f4 8d
 42 f4 ff 75 0c ff 75 08 ff 75 ec 50 ffEIP: [<c0112017>]
__wake_up_common+0x12/0x49 SS:ESP 0068:c03b7e38
 <0>Kernel panic - not syncing: Fatal exception in interrupt
___________________________________________________________________________=
___


--=_2mthbm4mdshs
Content-Type: text/plain;
	charset=ISO-8859-1;
	name="BRdmesg"
Content-Disposition: attachment;
	filename="BRdmesg"
Content-Transfer-Encoding: 7bit

ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 30000000 (gap: 20000000:c0000000)
Detected 1862.293 MHz processor.
Built 1 zonelists.  Total pages: 130784
Kernel command line: root=/dev/sda7 ro
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 8192 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 514984k/523136k available (1485k kernel code, 7728k reserved, 1286k data, 160k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3728.09 BogoMIPS (lpj=7456187)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: afe9fbff 00100000 00000000 00000000 00000180 00000000 00000000
CPU: After vendor identify, caps: afe9fbff 00100000 00000000 00000000 00000180 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: After all inits, caps: afe9fbff 00100000 00000000 00000040 00000180 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
CPU: Intel(R) Pentium(R) M processor 1.86GHz stepping 08
Checking 'hlt' instruction... OK.
ACPI: Core revision 20060623
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
NET: Registered protocol family 16
ACPI: ACPI Dock Station Driver 
ACPI: bus type pci registered
PCI: Using MMCONFIG
Setting up standard PCI resources
ACPI: Found ECDT
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH6 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC] (gpe 28) interrupt mode.
ACPI: Power Resource [PUBS] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 14 devices
PnPBIOS: Disabled by ACPI PNP
Intel 82802 RNG detected
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
  IO window: 3000-3fff
  MEM window: a8100000-a81fffff
  PREFETCH window: c0000000-c7ffffff
PCI: Bridge: 0000:00:1c.0
  IO window: disabled.
  MEM window: a8200000-a82fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.2
  IO window: 4000-4fff
  MEM window: a8300000-a83fffff
  PREFETCH window: c8000000-c80fffff
PCI: Bus 5, cardbus bridge: 0000:04:00.0
  IO window: 00005000-000050ff
  IO window: 00005400-000054ff
  PREFETCH window: d0000000-d1ffffff
  MEM window: aa000000-abffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 5000-8fff
  MEM window: a8400000-b7ffffff
  PREFETCH window: d0000000-d7ffffff
Device `[AGP]' is not power manageable<6>ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:01.0 to 64
Device `[EXP0]' is not power manageable<6>ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 20 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1c.0 to 64
Device `[EXP2]' is not power manageable<6>ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 22 (level, low) -> IRQ 185
PCI: Setting latency timer of device 0000:00:1c.2 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
Device `[CDBS]' is not power manageable<6>ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 16 (level, low) -> IRQ 169
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
Simple Boot Flag at 0x35 set to 0x1
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:01.0:pcie00]
Allocate Port Service[0000:00:01.0:pcie03]
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
Allocate Port Service[0000:00:1c.0:pcie02]
Allocate Port Service[0000:00:1c.0:pcie03]
PCI: Setting latency timer of device 0000:00:1c.2 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.2:pcie00]
Allocate Port Service[0000:00:1c.2:pcie02]
Allocate Port Service[0000:00:1c.2:pcie03]
ibm_acpi: IBM ThinkPad ACPI Extras v0.12a
ibm_acpi: http://ibm-acpi.sf.net/
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
pnp: Unable to assign resources to device 00:0a.
serial: probe of 00:0a failed with error -16
Device `[AC9M]' is not power manageable<6>ACPI: PCI Interrupt 0000:00:1e.3[B] -> GSI 23 (level, low) -> IRQ 225
ACPI: PCI interrupt for device 0000:00:1e.3 disabled
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
libata version 2.00 loaded.
ata_piix 0000:00:1f.2: version 2.00
ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
Device `[IDE0]' is not power manageable<7>PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x18C0 irq 14
scsi0 : ata_piix
ata1.00: ATA-6, max UDMA/100, 156301488 sectors: LBA 
ata1.00: ata1: dev 0 multi count 16
ata1.00: applying bridge limits
ata1.00: configured for UDMA/100
  Vendor: ATA       Model: HTS541080G9AT00   Rev: MB4I
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x18C8 irq 15
scsi1 : ata_piix
ata2.00: ATAPI, max UDMA/33
ata2.00: configured for UDMA/33
  Vendor: MATSHITA  Model: DVD-RAM UJ-822S   Rev: 1.61
  Type:   CD-ROM                             ANSI SCSI revision: 05
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 < sda5 sda6 sda7 sda8 > sda4
sd 0:0:0:0: Attached scsi disk sda
sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi CD-ROM sr0
PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
TCP bic registered
Using IPI Shortcut mode
Time: tsc clocksource has been installed.
input: AT Translated Set 2 keyboard as /class/input/input0
ACPI: (supports S0 S3 S4 S5)
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
Synaptics Touchpad, model: 1, fw: 5.9, id: 0x2c6ab1, caps: 0x884793/0x0
serio: Synaptics pass-through port at isa0060/serio1/input0
input: SynPS/2 Synaptics TouchPad as /class/input/input1
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 160k freed
Write protecting the kernel read-only data: 975k
NET: Registered protocol family 1
usbcore: registered new driver usbfs
usbcore: registered new driver hub
input: PC Speaker as /class/input/input2
ACPI: PCI Interrupt 0000:00:1f.3[A] -> GSI 23 (level, low) -> IRQ 225
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 19 (level, low) -> IRQ 233
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 233, io mem 0xa8000000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v3.0
Linux agpgart interface v0.101 (c) Dave Jones
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 169, io base 0x00001800
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
Real Time Clock Driver v1.12ac
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 50
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 50, io base 0x00001820
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
NET: Registered protocol family 23
pnp: Unable to assign resources to device 00:0c.
nsc-ircc: probe of 00:0c failed with error -16
nsc-ircc, Found chip at base=0x02e
nsc-ircc, Wrong chip version ff
ieee80211_crypt: registered algorithm 'NULL'
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 58
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 58, io base 0x00001840
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ieee80211: 802.11 data/management/control stack, git-1.1.13
ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.1.2km
ipw2200: Copyright(c) 2003-2006 Intel Corporation
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 233
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 233, io base 0x00001860
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
IBM TrackPoint firmware: 0x0e, buttons: 3/3
agpgart: Detected an Intel 915GM Chipset.
agpgart: AGP aperture is 256M @ 0x0
PCI: Enabling device 0000:00:1e.3 (0000 -> 0001)
ACPI: PCI Interrupt 0000:00:1e.3[B] -> GSI 23 (level, low) -> IRQ 225
PCI: Setting latency timer of device 0000:00:1e.3 to 64
MC'97 1 converters and GPIO not ready (0xff00)
Device `[AC9A]' is not power manageable<6>ACPI: PCI Interrupt 0000:00:1e.2[A] -> GSI 22 (level, low) -> IRQ 185
PCI: Setting latency timer of device 0000:00:1e.2 to 64
usb 4-2: new full speed USB device using uhci_hcd and address 2
input: TPPS/2 IBM TrackPoint as /class/input/input3
usb 4-2: configuration #1 chosen from 1 choice
intel8x0_measure_ac97_clock: measured 55492 usecs
intel8x0: clocking to 48000
tg3.c:v3.62 (June 30, 2006)
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:02:00.0 to 64
eth0: Tigon3 [partno(BCM95751M) rev 4101 PHY(5750)] (PCI Express) 10/100/1000BaseT Ethernet 00:11:25:d5:a6:0b
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
eth0: dma_rwctrl[76180000] dma_mask[64-bit]
Yenta: CardBus bridge found at 0000:04:00.0 [1014:056c]
Yenta: ISA IRQ mask 0x04b8, PCI irq 169
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x5000 - 0x8fff
cs: IO port probe 0x5000-0x8fff: clean.
pcmcia: parent PCI bridge Memory window: 0xa8400000 - 0xb7ffffff
pcmcia: parent PCI bridge Memory window: 0xd0000000 - 0xd7ffffff
ACPI: PCI Interrupt 0000:04:02.0[A] -> GSI 21 (level, low) -> IRQ 66
ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
cs: IO port probe 0x100-0x4ff: excluding 0x370-0x377 0x3b8-0x3df 0x3f0-0x3f7 0x4d0-0x4d7
cs: IO port probe 0x800-0x8ff: clean.
cs: IO port probe 0xc00-0xcff: excluding 0xcf8-0xcff
cs: IO port probe 0xa00-0xaff: clean.
ipw2200: Detected geography ZZR (14 802.11bg channels, 0 802.11a channels)
Adding 497972k swap on /dev/sda6.  Priority:-1 extents:1 across:497972k
EXT3 FS on sda7, internal journal
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hdaps: IBM ThinkPad T43 detected.
hdaps: initial latch check good (0x01).
hdaps: device successfully initialized.
input: hdaps as /class/input/input4
hdaps: driver successfully loaded.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on sda4, internal journal
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
pcmcia: Detected deprecated PCMCIA ioctl usage from process: discover.
pcmcia: This interface will soon be removed from the kernel; please expect breakage unless you upgrade to new tools.
pcmcia: see http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html for details.
NET: Registered protocol family 17
tg3: lan: Link is up at 100 Mbps, full duplex.
tg3: lan: Flow control is on for TX and on for RX.
ACPI: Battery Slot [BAT0] (battery absent)
ACPI: AC Adapter [AC] (on-line)
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU] (supports 8 throttling states)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
Time: acpi_pm clocksource has been installed.
ACPI: Thermal Zone [THM0] (61 C)
[drm] Initialized drm 1.0.1 20051102
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 169
[drm] Initialized radeon 1.25.0 20060524 on minor 0
[drm] Setting GART location based on new memory map
[drm] Loading R300 Microcode
[drm] writeback test succeeded in 1 usecs

--=_2mthbm4mdshs
Content-Type: text/plain;
	charset=ISO-8859-1;
	name="BRlscpi"
Content-Disposition: attachment;
	filename="BRlscpi"
Content-Transfer-Encoding: 7bit

0000:00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML Express Processor to DRAM Controller (rev 03)
	Subsystem: IBM: Unknown device 0575
	Flags: bus master, fast devsel, latency 0
	Capabilities: <available only to root>

0000:00:01.0 PCI bridge: Intel Corporation Mobile 915GM/PM Express PCI Express Root Port (rev 03) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: a8100000-a81fffff
	Prefetchable memory behind bridge: c0000000-c7ffffff
	Capabilities: <available only to root>

0000:00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 1 (rev 03) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	Memory behind bridge: a8200000-a82fffff
	Capabilities: <available only to root>

0000:00:1c.2 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 3 (rev 03) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: a8300000-a83fffff
	Prefetchable memory behind bridge: 00000000c8000000-00000000c8000000
	Capabilities: <available only to root>

0000:00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1 (rev 03) (prog-if 00 [UHCI])
	Subsystem: IBM: Unknown device 0565
	Flags: bus master, medium devsel, latency 0, IRQ 169
	I/O ports at 1800 [size=32]

0000:00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2 (rev 03) (prog-if 00 [UHCI])
	Subsystem: IBM: Unknown device 0565
	Flags: bus master, medium devsel, latency 0, IRQ 50
	I/O ports at 1820 [size=32]

0000:00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3 (rev 03) (prog-if 00 [UHCI])
	Subsystem: IBM: Unknown device 0565
	Flags: bus master, medium devsel, latency 0, IRQ 58
	I/O ports at 1840 [size=32]

0000:00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #4 (rev 03) (prog-if 00 [UHCI])
	Subsystem: IBM: Unknown device 0565
	Flags: bus master, medium devsel, latency 0, IRQ 233
	I/O ports at 1860 [size=32]

0000:00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller (rev 03) (prog-if 20 [EHCI])
	Subsystem: IBM: Unknown device 0566
	Flags: bus master, medium devsel, latency 0, IRQ 233
	Memory at a8000000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: <available only to root>

0000:00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev d3) (prog-if 01 [Subtractive decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=04, subordinate=07, sec-latency=64
	I/O behind bridge: 00005000-00008fff
	Memory behind bridge: a8400000-b7ffffff
	Prefetchable memory behind bridge: 00000000d0000000-00000000d7f00000
	Capabilities: <available only to root>

0000:00:1e.2 Multimedia audio controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97 Audio Controller (rev 03)
	Subsystem: IBM: Unknown device 0567
	Flags: bus master, medium devsel, latency 0, IRQ 185
	I/O ports at 1c00 [size=256]
	I/O ports at 1880 [size=64]
	Memory at a8000800 (32-bit, non-prefetchable) [size=512]
	Memory at a8000400 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

0000:00:1e.3 Modem: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97 Modem Controller (rev 03) (prog-if 00 [Generic])
	Subsystem: IBM: Unknown device 0574
	Flags: bus master, medium devsel, latency 0, IRQ 225
	I/O ports at 2400 [size=256]
	I/O ports at 2000 [size=128]
	Capabilities: <available only to root>

0000:00:1f.0 ISA bridge: Intel Corporation 82801FBM (ICH6M) LPC Interface Bridge (rev 03)
	Subsystem: IBM: Unknown device 0568
	Flags: bus master, medium devsel, latency 0

0000:00:1f.2 IDE interface: Intel Corporation 82801FBM (ICH6M) SATA Controller (rev 03) (prog-if 80 [Master])
	Subsystem: IBM: Unknown device 056a
	Flags: bus master, 66MHz, medium devsel, latency 0
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at 18c0 [size=16]
	Capabilities: <available only to root>

0000:00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus Controller (rev 03)
	Subsystem: IBM: Unknown device 056b
	Flags: medium devsel, IRQ 225
	I/O ports at 18e0 [size=32]

0000:01:00.0 VGA compatible controller: ATI Technologies Inc M22 [Radeon Mobility M300] (prog-if 00 [VGA])
	Subsystem: IBM: Unknown device 056e
	Flags: bus master, fast devsel, latency 0, IRQ 169
	Memory at c0000000 (32-bit, prefetchable) [size=128M]
	I/O ports at 3000 [size=256]
	Memory at a8100000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at a8120000 [disabled] [size=128K]
	Capabilities: <available only to root>

0000:02:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5751M Gigabit Ethernet PCI Express (rev 11)
	Subsystem: IBM: Unknown device 0577
	Flags: bus master, fast devsel, latency 0, IRQ 169
	Memory at a8200000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: <available only to root>

0000:04:00.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 8d)
	Subsystem: IBM: Unknown device 056c
	Flags: bus master, medium devsel, latency 168, IRQ 169
	Memory at a8400000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=04, secondary=05, subordinate=06, sec-latency=176
	Memory window 0: d0000000-d1fff000 (prefetchable)
	Memory window 1: aa000000-abfff000
	I/O window 0: 00005000-000050ff
	I/O window 1: 00005400-000054ff
	16-bit legacy interface ports at 0001

0000:04:02.0 Network controller: Intel Corporation PRO/Wireless 2200BG (rev 05)
	Subsystem: Intel Corporation: Unknown device 2712
	Flags: bus master, medium devsel, latency 64, IRQ 66
	Memory at a8401000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>


--=_2mthbm4mdshs--

