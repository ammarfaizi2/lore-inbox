Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbWDKUGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbWDKUGn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 16:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWDKUGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 16:06:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:1255 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751362AbWDKUGl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 16:06:41 -0400
X-Authenticated: #2277123
Message-ID: <443C0C2D.1020207@gmx.de>
Date: Tue, 11 Apr 2006 22:06:05 +0200
From: Christian Heimanns <ch.heimanns@gmx.de>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Suspend to disk
X-Enigmail-Version: 0.93.2.0
OpenPGP: id=94079F4C
Content-Type: multipart/mixed;
 boundary="------------030801090400060808070109"
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030801090400060808070109
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Hello to all,
following situation:
On my notebook Samsung X20 1730V I'm running Slackware 10.2 current with
kernel 2.6.15.6. Suspend to RAM and suspend to disk works fine.
Since kernel >= 2.6.16 suspend to disk breaks the restore of the
X-Server. That means that the current sessions is lost and the X-Server
restarts. No problems with suspend to RAM. Please find attached the
dmesg output for kernel 2.6.15.6 and 2.6.16.2. As well there is the
output frpm lspci. The only difference I can find is that I have with
kernel 2.6.16 some

>> ACPI (acpi_bus-0199): Device is not power manageable [20060310] <<

messages and a strange

>> PCI: Bus #07 (-#0a) may be hidden behind transparent bridge #06
(-#06) (try 'pci=assign-busses') <<

message. But I've no idea what to do. Can somebody please check it and
advise me what to do?

Regards,
-- 
---
Christian Heimanns
ch.heimanns<at>gmx<dot>de

### Pinguine können nicht fliegen
- Pinguine stürzen auch nicht ab! ###

--------------030801090400060808070109
Content-Type: text/plain;
 name="dmesg-2.6.15.6.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-2.6.15.6.txt"

0000005f) @ 0x3f69ee96
ACPI: MADT (v001 INTEL  ALVISO   0x06040000 LOHR 0x0000005f) @ 0x3f69ef0a
ACPI: HPET (v001 INTEL  ALVISO   0x06040000 LOHR 0x0000005f) @ 0x3f69ef64
ACPI: MCFG (v001 INTEL  ALVISO   0x06040000 LOHR 0x0000005f) @ 0x3f69ef9c
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x3f69efd8
ACPI: SSDT (v001 SataRe SataAhci 0x00001000 INTL 0x20030224) @ 0x3f699482
ACPI: SSDT (v001  PmRef  Cpu0Ist 0x00003000 INTL 0x20030224) @ 0x3f698f57
ACPI: SSDT (v001  PmRef  Cpu0Cst 0x00003001 INTL 0x20030224) @ 0x3f698d9d
ACPI: SSDT (v001  PmRef    CpuPm 0x00003000 INTL 0x20030224) @ 0x3f698cd4
ACPI: DSDT (v001 INTEL  ALVISO   0x06040000 INTL 0x20030224) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:13 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
ACPI: HPET id: 0x8086a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
Built 1 zonelists
Kernel command line: root=/dev/hda3 ro vga=795 resume=/dev/hda2 init 3
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
CPU 0 irqstacks, hard=c03dd000 soft=c03dc000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 905872k/917504k available (2022k kernel code, 11200k reserved, 720k data, 160k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
hpet0: at MMIO 0xfed00000 (virtual 0xf8800000), IRQs 2, 8, 0
hpet0: 3 64-bit timers, 14318180 Hz
Using HPET for base-timer
Using HPET for gettimeofday
Detected 1729.172 MHz processor.
Using hpet for high-res timesource
Calibrating delay using timer specific routine.. 3460.76 BogoMIPS (lpj=1730381)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: afe9fbff 00000000 00000000 00000000 00000180 00000000 00000000
CPU: After vendor identify, caps: afe9fbff 00000000 00000000 00000000 00000180 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: After all inits, caps: afe9fbff 00000000 00000000 00000040 00000180 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
CPU: Intel(R) Pentium(R) M processor 1.73GHz stepping 08
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd914, last bus=6
PCI: Using MMCONFIG
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:02.0
PCI quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH6 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
ACPI: PCI Interrupt Link [LNKC] (IRQs *5)
ACPI: PCI Interrupt Link [LNKD] (IRQs *5)
ACPI: PCI Interrupt Link [LNKE] (IRQs *11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 10) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs *5)
ACPI: PCI Interrupt Link [LNKH] (IRQs *5)
ACPI: Embedded Controller [H_EC] (gpe 23)
ACPI: Power Resource [CFAN] (on)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
PnPBIOS: Disabled by ACPI PNP
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Bridge: 0000:00:1c.0
  IO window: 3000-3fff
  MEM window: b4000000-b7ffffff
  PREFETCH window: d0000000-d3ffffff
PCI: Bus 7, cardbus bridge: 0000:06:09.0
  IO window: 00004000-000040ff
  IO window: 00004400-000044ff
  PREFETCH window: 50000000-51ffffff
  MEM window: 54000000-55ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 4000-4fff
  MEM window: b8000000-b80fffff
  PREFETCH window: 50000000-52ffffff
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.0 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
ACPI: PCI Interrupt 0000:06:09.0[A] -> GSI 16 (level, low) -> IRQ 17
Simple Boot Flag at 0x36 set to 0x1
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie02]
Allocate Port Service[pcie03]
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
vesafb: framebuffer at 0xc0000000, mapped to 0xf8880000, using 7872k, total 7872k
vesafb: mode is 1280x1024x32, linelength=5120, pages=0
vesafb: protected mode interface info at 00ff:44f0
vesafb: scrolling: redraw
vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
vesafb: Mode is VGA compatible
Console: switching to colour frame buffer device 160x64
fb0: VESA VGA frame buffer device
ACPI: AC Adapter [ADP1] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID0]
ACPI: Power Button (CM) [PWRB]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN1] (on)
ACPI: Video Device [GFX0] (multi-head: yes  rom: yes  post: no)
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU0] (supports 2 throttling states)
ACPI: Thermal Zone [THRM] (40 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
hpet_resources: 0xfed00000 is busy
Non-volatile memory driver v1.2
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
ACPI: PCI Interrupt 0000:00:1e.3[B] -> GSI 20 (level, low) -> IRQ 18
ACPI: PCI interrupt for device 0000:00:1e.3 disabled
floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH6: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 19
ICH6: chipset revision 3
ICH6: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1810-0x1817, BIOS settings: hda:DMA, hdb:DMA
Probing IDE interface ide0...
hda: FUJITSU MHV2080AH, ATA DISK drive
hdb: TSSTcorpCD/DVDW TS-L632B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: max request size: 128KiB
hda: Host Protected Area detected.
	current capacity is 155490289 sectors (79611 MB)
	native  capacity is 156301488 sectors (80026 MB)
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
ide: failed opcode was: 0xf9
hda: 155490289 sectors (79611 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4
hdb: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbmon: debugfs is not available
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input0
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
Netfilter messages via NETLINK v0.30.
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 7, 524288 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
ACPI wakeup devices: 
PWRB RP01 LANC MODM 
ACPI: (supports S0 S3 S4 S5)
input: AT Translated Set 2 keyboard as /class/input/input1
ReiserFS: hda3: found reiserfs format "3.6" with standard journal
ReiserFS: hda3: using ordered data mode
ReiserFS: hda3: journal params: device hda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda3: checking transaction log (hda3)
ReiserFS: hda3: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 160k freed
Adding 1502068k swap on /dev/hda2.  Priority:-1 extents:1 across:1502068k
Linux agpgart interface v0.101 (c) Dave Jones
ieee80211_crypt: registered algorithm 'NULL'
input: ImPS/2 Synaptics TouchPad as /class/input/input2
ieee80211: 802.11 data/management/control stack, git-1.1.7
ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
ieee80211_crypt: registered algorithm 'WEP'
ieee80211_crypt: registered algorithm 'TKIP'
ieee80211_crypt: registered algorithm 'CCMP'
NTFS driver 2.1.25 [Flags: R/W MODULE].
NTFS volume version 3.1.
ACPI: PCI Interrupt 0000:06:09.0[A] -> GSI 16 (level, low) -> IRQ 17
Yenta: CardBus bridge found at 0000:06:09.0 [144d:c01a]
Yenta: ISA IRQ mask 0x04b8, PCI irq 17
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x4000 - 0x4fff
cs: IO port probe 0x4000-0x4fff: clean.
pcmcia: parent PCI bridge Memory window: 0xb8000000 - 0xb80fffff
pcmcia: parent PCI bridge Memory window: 0x50000000 - 0x52ffffff
pcmcia: Detected deprecated PCMCIA ioctl usage.
pcmcia: This interface will soon be removed from the kernel; please expect breakage unless you upgrade to new tools.
pcmcia: see http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html for details.
cs: IO port probe 0xc00-0xcff: excluding 0xcf8-0xcff
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0x800-0x80f: clean.
cs: IO port probe 0x3e0-0x4ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x100-0x3af: clean.
cs: IO port probe 0xa00-0xaff: clean.
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1313 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt 0000:06:09.1[B] -> GSI 17 (level, low) -> IRQ 16
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[16]  MMIO=[b8003000-b80037ff]  Max Packet=[2048]
b44.c:v0.97 (Nov 30, 2005)
ACPI: PCI Interrupt 0000:06:05.0[A] -> GSI 22 (level, low) -> IRQ 20
eth0: Broadcom 4400 10/100BaseT Ethernet 00:13:77:02:ae:fa
i8xx TCO timer: heartbeat value must be 2<heartbeat<39, using 30
i8xx TCO timer: initialized (0x1060). heartbeat=30 sec (nowayout=0)
ACPI: PCI Interrupt 0000:00:1e.2[A] -> GSI 17 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1e.2 to 64
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0000f04120060ff3]
intel8x0_measure_ac97_clock: measured 53850 usecs
intel8x0: clocking to 48000
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 21, io mem 0xb0040000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 21, io base 0x00001820
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 22, io base 0x00001840
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 19, io base 0x00001860
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 2-1: new low speed USB device using uhci_hcd and address 2
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 17, io base 0x00001880
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
input: Logitech Optical USB Mouse as /class/input/input3
input: USB HID v1.10 Mouse [Logitech Optical USB Mouse] on usb-0000:00:1d.0-1
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
agpgart: Detected an Intel 915GM Chipset.
agpgart: Detected 7932K stolen memory.
agpgart: AGP aperture is 256M @ 0xc0000000
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
ADDRCONF(NETDEV_UP): eth0: link is not ready
IPv6 over IPv4 tunneling driver
Bluetooth: Core ver 2.8
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.7
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.

--------------030801090400060808070109
Content-Type: text/plain;
 name="dmesg-2.6.16.2.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-2.6.16.2.txt"

0
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:13 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
ACPI: HPET id: 0x8086a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
Built 1 zonelists
Kernel command line: root=/dev/hda3 ro vga=795 resume=/dev/hda2 init 3
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c03ea000 soft=c03e9000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 905824k/917504k available (2042k kernel code, 11252k reserved, 749k data, 164k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
hpet0: at MMIO 0xfed00000 (virtual 0xf8800000), IRQs 2, 8, 0
hpet0: 3 64-bit timers, 14318180 Hz
Using HPET for base-timer
Using HPET for gettimeofday
Detected 1729.170 MHz processor.
Using hpet for high-res timesource
Calibrating delay using timer specific routine.. 3461.32 BogoMIPS (lpj=1730661)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: afe9fbff 00000000 00000000 00000000 00000180 00000000 00000000
CPU: After vendor identify, caps: afe9fbff 00000000 00000000 00000000 00000180 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: After all inits, caps: afe9fbff 00000000 00000000 00000040 00000180 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1.73GHz stepping 08
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd914, last bus=6
PCI: Using MMCONFIG
ACPI: Subsystem revision 20060310
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:02.0
PCI quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH6 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
PCI: Bus #07 (-#0a) may be hidden behind transparent bridge #06 (-#06) (try 'pci=assign-busses')
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
ACPI: PCI Interrupt Link [LNKC] (IRQs *5)
ACPI: PCI Interrupt Link [LNKD] (IRQs *5)
ACPI: PCI Interrupt Link [LNKE] (IRQs *11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 10) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs *5)
ACPI: PCI Interrupt Link [LNKH] (IRQs *5)
ACPI: Embedded Controller [H_EC] (gpe 23) interrupt mode.
ACPI: Power Resource [CFAN] (on)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 10 devices
PnPBIOS: Disabled by ACPI PNP
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Bridge: 0000:00:1c.0
  IO window: 3000-3fff
  MEM window: b4000000-b7ffffff
  PREFETCH window: d0000000-d3ffffff
PCI: Bus 7, cardbus bridge: 0000:06:09.0
  IO window: 00004000-000040ff
  IO window: 00004400-000044ff
  PREFETCH window: 50000000-51ffffff
  MEM window: 54000000-55ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 4000-4fff
  MEM window: b8000000-b80fffff
  PREFETCH window: 50000000-52ffffff
ACPI (acpi_bus-0199): Device is not power manageable [20060310]
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1c.0 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
ACPI: PCI Interrupt 0000:06:09.0[A] -> GSI 16 (level, low) -> IRQ 177
Simple Boot Flag at 0x36 set to 0x1
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
Allocate Port Service[0000:00:1c.0:pcie02]
Allocate Port Service[0000:00:1c.0:pcie03]
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
vesafb: framebuffer at 0xc0000000, mapped to 0xf8880000, using 7872k, total 7872k
vesafb: mode is 1280x1024x32, linelength=5120, pages=0
vesafb: protected mode interface info at 00ff:44f0
vesafb: scrolling: redraw
vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
Console: switching to colour frame buffer device 160x64
fb0: VESA VGA frame buffer device
ACPI: AC Adapter [ADP1] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID0]
ACPI: Power Button (CM) [PWRB]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN1] (on)
ACPI: Video Device [GFX0] (multi-head: yes  rom: yes  post: no)
Using specific hotkey driver
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU0] (supports 2 throttling states)
ACPI: Thermal Zone [THRM] (42 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
hpet_resources: 0xfed00000 is busy
Non-volatile memory driver v1.2
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
ACPI (acpi_bus-0199): Device is not power manageable [20060310]
ACPI: PCI Interrupt 0000:00:1e.3[B] -> GSI 20 (level, low) -> IRQ 201
ACPI: PCI interrupt for device 0000:00:1e.3 disabled
floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH6: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 209
ICH6: chipset revision 3
ICH6: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1810-0x1817, BIOS settings: hda:DMA, hdb:DMA
Probing IDE interface ide0...
hda: FUJITSU MHV2080AH, ATA DISK drive
hdb: TSSTcorpCD/DVDW TS-L632B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: max request size: 128KiB
hda: Host Protected Area detected.
	current capacity is 155490289 sectors (79611 MB)
	native  capacity is 156301488 sectors (80026 MB)
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
ide: failed opcode was: 0xf9
hda: 155490289 sectors (79611 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4
hdb: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbmon: debugfs is not available
usbcore: registered new driver libusual
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input0
input: PC Speaker as /class/input/input1
device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
Netfilter messages via NETLINK v0.30.
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 7, 524288 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
ACPI: (supports S0 S3 S4 S5)
ReiserFS: hda3: found reiserfs format "3.6" with standard journal
ReiserFS: hda3: using ordered data mode
ReiserFS: hda3: journal params: device hda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda3: checking transaction log (hda3)
ReiserFS: hda3: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 164k freed
Adding 1502068k swap on /dev/hda2.  Priority:-1 extents:1 across:1502068k
Linux agpgart interface v0.101 (c) Dave Jones
ieee80211_crypt: registered algorithm 'NULL'
ieee80211: 802.11 data/management/control stack, git-1.1.7
ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
ieee80211_crypt: registered algorithm 'WEP'
ieee80211_crypt: registered algorithm 'TKIP'
ieee80211_crypt: registered algorithm 'CCMP'
NTFS driver 2.1.26 [Flags: R/W MODULE].
NTFS volume version 3.1.
input: ImPS/2 Synaptics TouchPad as /class/input/input2
ACPI: PCI Interrupt 0000:06:09.0[A] -> GSI 16 (level, low) -> IRQ 177
Yenta: CardBus bridge found at 0000:06:09.0 [144d:c01a]
Yenta: ISA IRQ mask 0x04b8, PCI irq 177
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x4000 - 0x4fff
cs: IO port probe 0x4000-0x4fff: clean.
pcmcia: parent PCI bridge Memory window: 0xb8000000 - 0xb80fffff
pcmcia: parent PCI bridge Memory window: 0x50000000 - 0x52ffffff
pcmcia: Detected deprecated PCMCIA ioctl usage.
pcmcia: This interface will soon be removed from the kernel; please expect breakage unless you upgrade to new tools.
pcmcia: see http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html for details.
cs: IO port probe 0xc00-0xcff: excluding 0xcf8-0xcff
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0x800-0x80f: clean.
cs: IO port probe 0x3e0-0x4ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x100-0x3af: clean.
cs: IO port probe 0xa00-0xaff: clean.
ieee1394: Initialized config rom entry `ip1394'
ACPI: PCI Interrupt 0000:06:09.1[B] -> GSI 17 (level, low) -> IRQ 169
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[169]  MMIO=[b8003000-b80037ff]  Max Packet=[2048]  IR/IT contexts=[4/4]
b44.c:v0.97 (Nov 30, 2005)
ACPI (acpi_bus-0199): Device is not power manageable [20060310]
ACPI: PCI Interrupt 0000:06:05.0[A] -> GSI 22 (level, low) -> IRQ 217
eth0: Broadcom 4400 10/100BaseT Ethernet 00:13:77:02:ae:fa
i8xx TCO timer: heartbeat value must be 2<heartbeat<39, using 30
i8xx TCO timer: initialized (0x1060). heartbeat=30 sec (nowayout=0)
ACPI (acpi_bus-0199): Device is not power manageable [20060310]
ACPI: PCI Interrupt 0000:00:1e.2[A] -> GSI 17 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1e.2 to 64
intel8x0_measure_ac97_clock: measured 50475 usecs
intel8x0: clocking to 48000
ACPI (acpi_bus-0199): Device is not power manageable [20060310]
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 225
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 225, io mem 0xb0040000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0000f04120060ff3]
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 225
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 225, io base 0x00001820
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 233
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 233, io base 0x00001840
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 209
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 209, io base 0x00001860
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 2-1: new low speed USB device using uhci_hcd and address 2
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 177, io base 0x00001880
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usb 2-1: configuration #1 chosen from 1 choice
input: Logitech Optical USB Mouse as /class/input/input3
input: USB HID v1.10 Mouse [Logitech Optical USB Mouse] on usb-0000:00:1d.0-1
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
agpgart: Detected an Intel 915GM Chipset.
agpgart: Detected 7932K stolen memory.
agpgart: AGP aperture is 256M @ 0xc0000000
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
ADDRCONF(NETDEV_UP): eth0: link is not ready
IPv6 over IPv4 tunneling driver
hdb: CHECK for good STATUS
Bluetooth: Core ver 2.8
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.7
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.

--------------030801090400060808070109
Content-Type: text/plain;
 name="lspci-v.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci-v.txt"

00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML Express Processor to DRAM Controller (rev 03)
	Subsystem: Samsung Electronics Co Ltd: Unknown device c01a
	Flags: bus master, fast devsel, latency 0
	Capabilities: [e0] #09 [2109]

00:02.0 VGA compatible controller: Intel Corporation Mobile 915GM/GMS/910GML Express Graphics Controller (rev 03) (prog-if 00 [VGA])
	Subsystem: Samsung Electronics Co Ltd: Unknown device c01a
	Flags: fast devsel, IRQ 11
	Memory at b0080000 (32-bit, non-prefetchable) [size=512K]
	I/O ports at 1800 [size=8]
	Memory at c0000000 (32-bit, prefetchable) [size=256M]
	Memory at b0000000 (32-bit, non-prefetchable) [size=256K]
	Expansion ROM at <unassigned> [disabled]
	Capabilities: [d0] Power Management version 2

00:02.1 Display controller: Intel Corporation Mobile 915GM/GMS/910GML Express Graphics Controller (rev 03)
	Subsystem: Samsung Electronics Co Ltd: Unknown device c01a
	Flags: fast devsel
	Memory at 53000000 (32-bit, non-prefetchable) [disabled] [size=512K]
	Capabilities: [d0] Power Management version 2

00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 1 (rev 03) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: b4000000-b7ffffff
	Prefetchable memory behind bridge: 00000000d0000000-00000000d3f00000
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2

00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Samsung Electronics Co Ltd: Unknown device c01a
	Flags: bus master, medium devsel, latency 0, IRQ 21
	I/O ports at 1820 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Samsung Electronics Co Ltd: Unknown device c01a
	Flags: bus master, medium devsel, latency 0, IRQ 22
	I/O ports at 1840 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Samsung Electronics Co Ltd: Unknown device c01a
	Flags: bus master, medium devsel, latency 0, IRQ 19
	I/O ports at 1860 [size=32]

00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #4 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Samsung Electronics Co Ltd: Unknown device c01a
	Flags: bus master, medium devsel, latency 0, IRQ 17
	I/O ports at 1880 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller (rev 03) (prog-if 20 [EHCI])
	Subsystem: Samsung Electronics Co Ltd: Unknown device c01a
	Flags: bus master, medium devsel, latency 0, IRQ 21
	Memory at b0040000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] #0a [20a0]

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev d3) (prog-if 01 [Subtractive decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=06, subordinate=06, sec-latency=32
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: b8000000-b80fffff
	Prefetchable memory behind bridge: 0000000050000000-0000000052f00000
	Capabilities: [50] #0d [0000]

00:1e.2 Multimedia audio controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97 Audio Controller (rev 03)
	Subsystem: Samsung Electronics Co Ltd: Unknown device c01a
	Flags: bus master, medium devsel, latency 0, IRQ 16
	I/O ports at 1c00 [size=256]
	I/O ports at 18c0 [size=64]
	Memory at b0040800 (32-bit, non-prefetchable) [size=512]
	Memory at b0040400 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2

00:1e.3 Modem: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97 Modem Controller (rev 03) (prog-if 00 [Generic])
	Subsystem: Samsung Electronics Co Ltd: Unknown device 2115
	Flags: medium devsel, IRQ 18
	I/O ports at 2400 [size=256]
	I/O ports at 2000 [size=128]
	Capabilities: [50] Power Management version 2

00:1f.0 ISA bridge: Intel Corporation 82801FBM (ICH6M) LPC Interface Bridge (rev 03)
	Subsystem: Samsung Electronics Co Ltd: Unknown device c01a
	Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) IDE Controller (rev 03) (prog-if 8a [Master SecP PriP])
	Subsystem: Samsung Electronics Co Ltd: Unknown device c01a
	Flags: bus master, medium devsel, latency 0, IRQ 19
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at 1810 [size=16]

00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus Controller (rev 03)
	Subsystem: Samsung Electronics Co Ltd: Unknown device c01a
	Flags: medium devsel, IRQ 5
	I/O ports at 18a0 [size=32]

06:05.0 Ethernet controller: Broadcom Corporation BCM4401-B0 100Base-TX (rev 02)
	Subsystem: Samsung Electronics Co Ltd: Unknown device c01a
	Flags: bus master, fast devsel, latency 32, IRQ 20
	Memory at b8000000 (32-bit, non-prefetchable) [size=8K]
	Expansion ROM at 52000000 [disabled] [size=64K]
	Capabilities: [40] Power Management version 2

06:07.0 Network controller: Intel Corporation PRO/Wireless 2200BG (rev 05)
	Subsystem: Intel Corporation: Unknown device 2731
	Flags: bus master, medium devsel, latency 32, IRQ 11
	Memory at b8002000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2

06:09.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev b3)
	Subsystem: Samsung Electronics Co Ltd: Unknown device c01a
	Flags: bus master, medium devsel, latency 168, IRQ 17
	Memory at 000da000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=06, secondary=07, subordinate=0a, sec-latency=176
	Memory window 0: 50000000-51fff000 (prefetchable)
	Memory window 1: 54000000-55fff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	16-bit legacy interface ports at 0001

06:09.1 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller (rev 08) (prog-if 10 [OHCI])
	Subsystem: Samsung Electronics Co Ltd: Unknown device c01a
	Flags: bus master, medium devsel, latency 64, IRQ 16
	Memory at b8003000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [dc] Power Management version 2

06:09.2 Class 0805: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro Host Adapter (rev 17)
	Subsystem: Samsung Electronics Co Ltd: Unknown device c01a
	Flags: bus master, medium devsel, latency 32, IRQ 255
	Memory at b8003800 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2

06:09.3 System peripheral: Ricoh Co Ltd R5C592 Memory Stick Bus Host Adapter (rev 08)
	Subsystem: Samsung Electronics Co Ltd: Unknown device c01a
	Flags: medium devsel, IRQ 255
	Memory at b8003c00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2


--------------030801090400060808070109--
