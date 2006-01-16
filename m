Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750862AbWAPPHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbWAPPHs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 10:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbWAPPHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 10:07:48 -0500
Received: from mx02.qsc.de ([213.148.130.14]:36270 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S1750862AbWAPPHr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 10:07:47 -0500
From: =?iso-8859-1?q?Ren=E9_Rebe?= <rene@exactcode.de>
Organization: ExactCODE
To: linux-kernel@vger.kernel.org
Subject: interrupt routing ATi RS480M (MSI Megabook S270)
Date: Mon, 16 Jan 2006 16:07:24 +0100
User-Agent: KMail/1.9
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601161607.24209.rene@exactcode.de>
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "grum.localhost", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi all, I have a MSI Megabook S270 with AMD Turion MT-30
	and the interrupt routing never worked quite right. I'll describe the
	problems with 2.6.15, since I reinstalled the system recently and do not
	have older kernels to quote logs for those. [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have a MSI Megabook S270 with AMD Turion MT-30 and the interrupt routing 
never worked quite right. I'll describe the problems with 2.6.15, since I 
reinstalled the system recently and do not have older kernels to quote logs 
for those.

First I have to boot with e.g. noapic, otherwise the system time runs twice as 
fast but with and without noapic. pci=routeirq, pci=assign-busses or irqpoll 
the interrupt assigned to the USB controllers gets disabled and thus renders 
USB unfunctional.

Attached are dmesg and /proc/interrupts of 2.6.15 once vanilla and once with 
noapic. Just drop a note if more information, option or patch to test is 
welcome:

Bootdata ok (command line is root=/dev/hda3 ro)
Linux version 2.6.15-dist (root@localhost) (gcc version 4.0.2) #1 Sun Jan 15 
16:04:52 CET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001df40000 (usable)
 BIOS-e820: 000000001df40000 - 000000001df50000 (ACPI data)
 BIOS-e820: 000000001df50000 - 000000001e000000 (ACPI NVS)
 BIOS-e820: 000000001e000000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
ACPI: RSDP (v000 MSI                                   ) @ 0x00000000000f8340
ACPI: RSDT (v001 MSI    1013     0x06272005 MSFT 0x00000097) @ 
0x000000001df40000
ACPI: FADT (v002 MSI    1013     0x06272005 MSFT 0x00000097) @ 
0x000000001df40200
ACPI: MADT (v001 MSI    OEMAPIC  0x06272005 MSFT 0x00000097) @ 
0x000000001df40300
ACPI: WDRT (v001 MSI    MSI_OEM  0x06272005 MSFT 0x00000097) @ 
0x000000001df40360
ACPI: MCFG (v001 MSI    OEMMCFG  0x06272005 MSFT 0x00000097) @ 
0x000000001df403b0
ACPI: SSDT (v001 OEM_ID OEMTBLID 0x00000001 INTL 0x02002026) @ 
0x000000001df43560
ACPI: OEMB (v001 MSI    MSI_OEM  0x06272005 MSFT 0x00000097) @ 
0x000000001df50040
ACPI: DSDT (v001    MSI     1013 0x06272005 INTL 0x02002026) @ 
0x0000000000000000
No mptable found.
On node 0 totalpages: 120168
  DMA zone: 3197 pages, LIFO batch:0
  DMA32 zone: 116971 pages, LIFO batch:31
  Normal zone: 0 pages, LIFO batch:0
  HighMem zone: 0 pages, LIFO batch:0
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 16
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 33, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 21 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 30000000 (gap: 20000000:c0000000)
Checking aperture...
CPU 0: aperture @ e062000000 size 32 MB
Aperture from northbridge cpu 0 too small (32 MB)
No AGP bridge found
Built 1 zonelists
Kernel command line: root=/dev/hda3 ro
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 65536 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 1591.890 MHz processor.
time.c: Using PIT/TSC based timekeeping.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Memory: 475600k/490752k available (1709k kernel code, 14464k reserved, 731k 
data, 172k init)
Calibrating delay using timer specific routine.. 3190.45 BogoMIPS 
(lpj=6380907)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
mtrr: v2.0 (20020519)
CPU: AMD Turion(tm) 64 Mobile Technology MT-30 stepping 02
Using local APIC timer interrupts.
Detected 12.436 MHz APIC timer.
testing NMI watchdog ... OK.
checking if image is initramfs... it is
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
GSI 21 sharing vector 0xA9 and IRQ 21
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:14.1
Boot video device is 0000:01:05.0
PCI: Transparent bridge - 0000:00:14.4
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: Embedded Controller [EC] (gpe 6)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.POP2._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 5 *6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 5 6 *7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 5 6 7 10 11 12 14 15) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 10 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI-DMA: Disabling IOMMU.
PCI: Bridge: 0000:00:01.0
  IO window: d000-dfff
  MEM window: fbe00000-fbefffff
  PREFETCH window: f4000000-faffffff
PCI: Bus 3, cardbus bridge: 0000:02:04.0
  IO window: 0000e000-0000e0ff
  IO window: 0000e400-0000e4ff
  PREFETCH window: 30000000-31ffffff
  MEM window: 36000000-37ffffff
PCI: Bus 7, cardbus bridge: 0000:02:04.1
  IO window: 0000ec00-0000ecff
  IO window: 00001000-000010ff
  PREFETCH window: 32000000-33ffffff
  MEM window: 38000000-39ffffff
PCI: Bridge: 0000:00:14.4
  IO window: e000-efff
  MEM window: fbf00000-fbffffff
  PREFETCH window: 30000000-34ffffff
GSI 16 sharing vector 0xB1 and IRQ 16
ACPI: PCI Interrupt 0000:02:04.0[A] -> GSI 19 (level, low) -> IRQ 16
GSI 17 sharing vector 0xB9 and IRQ 17
ACPI: PCI Interrupt 0000:02:04.1[B] -> GSI 20 (level, low) -> IRQ 17
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Squashfs 2.2-r2 (released 2005/09/08) (C) 2002-2005 Phillip Lougher
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
ACPI: AC Adapter [ADP1] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID0]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Power Button (CM) [PWRB]
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Thermal Zone [THRM] (47 C)
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
PPP generic driver version 2.4.2
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
usbmon: debugfs is not available
ACPI: PCI Interrupt 0000:00:13.2[A] -> GSI 19 (level, low) -> IRQ 16
ehci_hcd 0000:00:13.2: EHCI Host Controller
ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:13.2: irq 16, io mem 0xfbdff000
ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input0
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 3, 32768 bytes)
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI wakeup devices: 
POP2  RTL AC97 MC97 
ACPI: (supports S0 S1 S3 S4 S5)
Freeing unused kernel memory: 172k freed
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 19 (level, low) -> IRQ 16
ohci_hcd 0000:00:13.0: OHCI Host Controller
ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:13.0: irq 16, io mem 0xfbdfd000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 4 ports detected
APIC error on CPU0: 00(40)
irq 16: nobody cared (try booting with the "irqpoll" option)

Call Trace: <IRQ> <ffffffff80144240>{__report_bad_irq+48} 
<ffffffff80144436>{note_interrupt+425}
       <ffffffff802302f3>{usb_hcd_irq+41} <ffffffff80143e83>{__do_IRQ+139}
       <ffffffff80110bcc>{do_IRQ+48} <ffffffff8010ea60>{ret_from_intr+0}
        <EOI> <ffffffff801d669f>{acpi_hw_register_read+196}
       <ffffffff801ea7ae>{acpi_processor_idle+432} 
<ffffffff8010d143>{cpu_idle+63}
       <ffffffff803ba751>{start_kernel+447} <ffffffff803ba247>{_sinittext+583}
       
handlers:
[<ffffffff802302ca>] (usb_hcd_irq+0x0/0x56)
[<ffffffff802302ca>] (usb_hcd_irq+0x0/0x56)
Disabling IRQ #16
ACPI: PCI Interrupt 0000:00:13.1[A] -> GSI 19 (level, low) -> IRQ 16
ohci_hcd 0000:00:13.1: OHCI Host Controller
ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:13.1: irq 16, io mem 0xfbdfe000
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 4 ports detected
ATIIXP: IDE controller at PCI slot 0000:00:14.1
GSI 18 sharing vector 0xC1 and IRQ 18
ACPI: PCI Interrupt 0000:00:14.1[A] -> GSI 16 (level, low) -> IRQ 18
ATIIXP: chipset revision 0
ATIIXP: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
input: AT Translated Set 2 keyboard as /class/input/input1
hda: TOSHIBA MK8025GAS, ATA DISK drive
logips2pp: Detected unknown logitech mouse model 99
input: ImPS/2 Logitech Wheel Mouse as /class/input/input2
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
logips2pp: Detected unknown logitech mouse model 99
input: ImPS/2 Logitech Wheel Mouse as /class/input/input3
hdc: HL-DT-ST DVD-RW GCA-4080N, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1313 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt 0000:02:04.2[C] -> GSI 21 (level, low) -> IRQ 21
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[21]  MMIO=[fbfff000-fbfff7ff]  
Max Packet=[2048]
sbp2: $Rev: 1306 $ Ben Collins <bcollins@debian.org>
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
ieee1394: sbp2: Try serialize_io=0 for better performance
hda: max request size: 128KiB
hda: 156301488 sectors (80026 MB), CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4
hdc: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
JFS: nTxBlock = 3719, nTxLock = 29754
NTFS driver 2.1.25 [Flags: R/O MODULE].
SGI XFS with large block/inode numbers, no debug enabled
Registering unionfs 1.1.1
ReiserFS: hda3: found reiserfs format "3.6" with standard journal
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0010dc0000a82438]
ReiserFS: hda3: using ordered data mode
ReiserFS: hda3: journal params: device hda3, size 8192, journal first block 
18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda3: checking transaction log (hda3)
ReiserFS: hda3: Using r5 hash to sort names
Adding 498004k swap on /dev/hda2.  Priority:-1 extents:1 across:498004k
ReiserFS: hda4: found reiserfs format "3.6" with standard journal
ReiserFS: hda4: using ordered data mode
ReiserFS: hda4: journal params: device hda4, size 8192, journal first block 
18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda4: checking transaction log (hda4)
ReiserFS: hda4: Using r5 hash to sort names
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
GSI 19 sharing vector 0xC9 and IRQ 19
ACPI: PCI Interrupt 0000:00:14.5[B] -> GSI 17 (level, low) -> IRQ 19
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ACPI: PCI Interrupt 0000:00:14.6[B] -> GSI 17 (level, low) -> IRQ 19
ACPI: PCI interrupt for device 0000:00:14.6 disabled
ACPI: PCI Interrupt 0000:00:14.6[B] -> GSI 17 (level, low) -> IRQ 19
8139cp: 10/100 PCI Ethernet driver v1.2 (Mar 22, 2004)
8139cp: pci dev 0000:02:03.0 (id 10ec:8139 rev 10) is not an 8139C+ compatible 
chip
8139cp: Try the "8139too" driver instead.
8139too Fast Ethernet driver 0.9.27
GSI 20 sharing vector 0xD1 and IRQ 20
ACPI: PCI Interrupt 0000:02:03.0[A] -> GSI 18 (level, low) -> IRQ 20
eth0: RealTek RTL8139 at 0xe800, 00:0c:76:f8:ac:a7, IRQ 20
eth0:  Identified 8139 chip type 'RTL-8101'
ACPI: PCI Interrupt 0000:02:04.0[A] -> GSI 19 (level, low) -> IRQ 16
Yenta: CardBus bridge found at 0000:02:04.0 [1462:0131]
Yenta: ISA IRQ mask 0x04b8, PCI irq 16
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0xe000 - 0xefff
pcmcia: parent PCI bridge Memory window: 0xfbf00000 - 0xfbffffff
pcmcia: parent PCI bridge Memory window: 0x30000000 - 0x34ffffff
ACPI: PCI Interrupt 0000:02:04.1[B] -> GSI 20 (level, low) -> IRQ 17
Yenta: CardBus bridge found at 0000:02:04.1 [1462:0131]
Yenta: ISA IRQ mask 0x0cb8, PCI irq 17
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0xe000 - 0xefff
pcmcia: parent PCI bridge Memory window: 0xfbf00000 - 0xfbffffff
pcmcia: parent PCI bridge Memory window: 0x30000000 - 0x34ffffff
ieee80211_crypt: registered algorithm 'NULL'
ieee80211: 802.11 data/management/control stack, git-1.1.7
ieee80211: Copyright (C) 2004-2005 Intel Corporation 
<jketreno@linux.intel.com>
ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, git-1.0.8
ipw2200: Copyright(c) 2003-2005 Intel Corporation
GSI 22 sharing vector 0xD9 and IRQ 22
ACPI: PCI Interrupt 0000:02:09.0[A] -> GSI 22 (level, low) -> IRQ 22
ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
usb 3-1: new low speed USB device using ohci_hcd and address 2
ohci_hcd 0000:00:13.1: Unlink after no-IRQ?  Controller is probably using the 
wrong IRQ.
           CPU0       
  0:      36321    IO-APIC-edge  timer
  1:        217    IO-APIC-edge  i8042
  8:          0    IO-APIC-edge  rtc
 12:        217    IO-APIC-edge  i8042
 14:       1474    IO-APIC-edge  ide0
 15:         11    IO-APIC-edge  ide1
 16:     188264   IO-APIC-level  ehci_hcd:usb1, ohci_hcd:usb2, ohci_hcd:usb3, 
yenta
 17:          0   IO-APIC-level  yenta
 19:          2   IO-APIC-level  ATI IXP, ATI IXP Modem
 21:          7   IO-APIC-level  acpi, ohci1394
 22:       6135   IO-APIC-level  ipw2200
NMI:         39 
LOC:      18137 
ERR:          1
MIS:          0

Bootdata ok (command line is root=/dev/hda3 ro noapic)
Linux version 2.6.15-dist (root@localhost) (gcc version 4.0.2) #1 Sun Jan 15 
16:04:52 CET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001df40000 (usable)
 BIOS-e820: 000000001df40000 - 000000001df50000 (ACPI data)
 BIOS-e820: 000000001df50000 - 000000001e000000 (ACPI NVS)
 BIOS-e820: 000000001e000000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
ACPI: RSDP (v000 MSI                                   ) @ 0x00000000000f8340
ACPI: RSDT (v001 MSI    1013     0x06272005 MSFT 0x00000097) @ 
0x000000001df40000
ACPI: FADT (v002 MSI    1013     0x06272005 MSFT 0x00000097) @ 
0x000000001df40200
ACPI: MADT (v001 MSI    OEMAPIC  0x06272005 MSFT 0x00000097) @ 
0x000000001df40300
ACPI: WDRT (v001 MSI    MSI_OEM  0x06272005 MSFT 0x00000097) @ 
0x000000001df40360
ACPI: MCFG (v001 MSI    OEMMCFG  0x06272005 MSFT 0x00000097) @ 
0x000000001df403b0
ACPI: SSDT (v001 OEM_ID OEMTBLID 0x00000001 INTL 0x02002026) @ 
0x000000001df43560
ACPI: OEMB (v001 MSI    MSI_OEM  0x06272005 MSFT 0x00000097) @ 
0x000000001df50040
ACPI: DSDT (v001    MSI     1013 0x06272005 INTL 0x02002026) @ 
0x0000000000000000
No mptable found.
On node 0 totalpages: 120168
  DMA zone: 3197 pages, LIFO batch:0
  DMA32 zone: 116971 pages, LIFO batch:31
  Normal zone: 0 pages, LIFO batch:0
  HighMem zone: 0 pages, LIFO batch:0
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 16
ACPI: Skipping IOAPIC probe due to 'noapic' option.
Allocating PCI resources starting at 30000000 (gap: 20000000:c0000000)
Checking aperture...
CPU 0: aperture @ e062000000 size 32 MB
Aperture from northbridge cpu 0 too small (32 MB)
No AGP bridge found
Built 1 zonelists
Kernel command line: root=/dev/hda3 ro noapic
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 65536 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 1591.893 MHz processor.
time.c: Using PIT/TSC based timekeeping.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Memory: 475600k/490752k available (1709k kernel code, 14464k reserved, 731k 
data, 172k init)
Calibrating delay using timer specific routine.. 3190.40 BogoMIPS 
(lpj=6380813)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
mtrr: v2.0 (20020519)
CPU: AMD Turion(tm) 64 Mobile Technology MT-30 stepping 02
ACPI: setting ELCR to 0200 (from 0ce0)
Using local APIC timer interrupts.
Detected 12.436 MHz APIC timer.
testing NMI watchdog ... OK.
checking if image is initramfs... it is
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:14.1
Boot video device is 0000:01:05.0
PCI: Transparent bridge - 0000:00:14.4
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: Embedded Controller [EC] (gpe 6)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.POP2._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 5 *6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 5 6 *7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 5 6 7 10 11 12 14 15) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 10 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI-DMA: Disabling IOMMU.
PCI: Bridge: 0000:00:01.0
  IO window: d000-dfff
  MEM window: fbe00000-fbefffff
  PREFETCH window: f4000000-faffffff
PCI: Bus 3, cardbus bridge: 0000:02:04.0
  IO window: 0000e000-0000e0ff
  IO window: 0000e400-0000e4ff
  PREFETCH window: 30000000-31ffffff
  MEM window: 36000000-37ffffff
PCI: Bus 7, cardbus bridge: 0000:02:04.1
  IO window: 0000ec00-0000ecff
  IO window: 00001000-000010ff
  PREFETCH window: 32000000-33ffffff
  MEM window: 38000000-39ffffff
PCI: Bridge: 0000:00:14.4
  IO window: e000-efff
  MEM window: fbf00000-fbffffff
  PREFETCH window: 30000000-34ffffff
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:02:04.0[A] -> Link [LNKD] -> GSI 11 (level, low) -> 
IRQ 11
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 6
PCI: setting IRQ 6 as level-triggered
ACPI: PCI Interrupt 0000:02:04.1[B] -> Link [LNKE] -> GSI 6 (level, low) -> 
IRQ 6
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Squashfs 2.2-r2 (released 2005/09/08) (C) 2002-2005 Phillip Lougher
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
ACPI: AC Adapter [ADP1] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID0]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Power Button (CM) [PWRB]
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Thermal Zone [THRM] (48 C)
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
PPP generic driver version 2.4.2
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
usbmon: debugfs is not available
ACPI: PCI Interrupt 0000:00:13.2[A] -> Link [LNKD] -> GSI 11 (level, low) -> 
IRQ 11
ehci_hcd 0000:00:13.2: EHCI Host Controller
ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:13.2: irq 11, io mem 0xfbdff000
ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input0
spurious 8259A interrupt: IRQ7.
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 3, 32768 bytes)
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI wakeup devices: 
POP2  RTL AC97 MC97 
ACPI: (supports S0 S1 S3 S4 S5)
Freeing unused kernel memory: 172k freed
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt 0000:00:13.0[A] -> Link [LNKD] -> GSI 11 (level, low) -> 
IRQ 11
ohci_hcd 0000:00:13.0: OHCI Host Controller
ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:13.0: irq 11, io mem 0xfbdfd000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 4 ports detected
ACPI: PCI Interrupt 0000:00:13.1[A] -> Link [LNKD] -> GSI 11 (level, low) -> 
IRQ 11
ohci_hcd 0000:00:13.1: OHCI Host Controller
ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:13.1: irq 11, io mem 0xfbdfe000
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 4 ports detected
input: AT Translated Set 2 keyboard as /class/input/input1
ATIIXP: IDE controller at PCI slot 0000:00:14.1
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:14.1[A] -> Link [LNKA] -> GSI 10 (level, low) -> 
IRQ 10
ATIIXP: chipset revision 0
ATIIXP: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
usb 3-1: new low speed USB device using ohci_hcd and address 2
logips2pp: Detected unknown logitech mouse model 99
input: ImPS/2 Logitech Wheel Mouse as /class/input/input2
hda: TOSHIBA MK8025GAS, ATA DISK drive
input: Logitech USB Optical Mouse as /class/input/input3
input: USB HID v1.10 Mouse [Logitech USB Optical Mouse] on usb-0000:00:13.1-1
logips2pp: Detected unknown logitech mouse model 99
input: ImPS/2 Logitech Wheel Mouse as /class/input/input4
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
irq 11: nobody cared (try booting with the "irqpoll" option)

Call Trace: <IRQ> <ffffffff80144240>{__report_bad_irq+48} 
<ffffffff80144436>{note_interrupt+425}
       <ffffffff802302f3>{usb_hcd_irq+41} <ffffffff80143e83>{__do_IRQ+139}
       <ffffffff80110bcc>{do_IRQ+48} <ffffffff8010ea60>{ret_from_intr+0}
        <EOI> <ffffffff801ea7ae>{acpi_processor_idle+432} 
<ffffffff8010d143>{cpu_idle+63}
       <ffffffff803ba751>{start_kernel+447} <ffffffff803ba247>{_sinittext+583}
       
handlers:
[<ffffffff802302ca>] (usb_hcd_irq+0x0/0x56)
[<ffffffff802302ca>] (usb_hcd_irq+0x0/0x56)
[<ffffffff802302ca>] (usb_hcd_irq+0x0/0x56)
Disabling IRQ #11
hdc: HL-DT-ST DVD-RW GCA-4080N, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1313 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 7
PCI: setting IRQ 7 as level-triggered
ACPI: PCI Interrupt 0000:02:04.2[C] -> Link [LNKF] -> GSI 7 (level, low) -> 
IRQ 7
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[7]  MMIO=[fbfff000-fbfff7ff]  
Max Packet=[2048]
sbp2: $Rev: 1306 $ Ben Collins <bcollins@debian.org>
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
ieee1394: sbp2: Try serialize_io=0 for better performance
hda: max request size: 128KiB
hda: 156301488 sectors (80026 MB), CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4
hdc: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
JFS: nTxBlock = 3719, nTxLock = 29754
NTFS driver 2.1.25 [Flags: R/O MODULE].
SGI XFS with large block/inode numbers, no debug enabled
Registering unionfs 1.1.1
ReiserFS: hda3: found reiserfs format "3.6" with standard journal
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0010dc0000a82438]
ReiserFS: hda3: using ordered data mode
ReiserFS: hda3: journal params: device hda3, size 8192, journal first block 
18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda3: checking transaction log (hda3)
ReiserFS: hda3: Using r5 hash to sort names
Adding 498004k swap on /dev/hda2.  Priority:-1 extents:1 across:498004k
ReiserFS: hda4: found reiserfs format "3.6" with standard journal
ReiserFS: hda4: using ordered data mode
ReiserFS: hda4: journal params: device hda4, size 8192, journal first block 
18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda4: checking transaction log (hda4)
ReiserFS: hda4: replayed 12 transactions in 0 seconds
ReiserFS: hda4: Using r5 hash to sort names
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:14.5[B] -> Link [LNKB] -> GSI 10 (level, low) -> 
IRQ 10
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ACPI: PCI Interrupt 0000:00:14.6[B] -> Link [LNKB] -> GSI 10 (level, low) -> 
IRQ 10
ACPI: PCI interrupt for device 0000:00:14.6 disabled
ACPI: PCI Interrupt 0000:00:14.6[B] -> Link [LNKB] -> GSI 10 (level, low) -> 
IRQ 10
8139cp: 10/100 PCI Ethernet driver v1.2 (Mar 22, 2004)
8139cp: pci dev 0000:02:03.0 (id 10ec:8139 rev 10) is not an 8139C+ compatible 
chip
8139cp: Try the "8139too" driver instead.
8139too Fast Ethernet driver 0.9.27
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:02:03.0[A] -> Link [LNKC] -> GSI 5 (level, low) -> 
IRQ 5
eth0: RealTek RTL8139 at 0xe800, 00:0c:76:f8:ac:a7, IRQ 5
eth0:  Identified 8139 chip type 'RTL-8101'
ACPI: PCI Interrupt 0000:02:04.0[A] -> Link [LNKD] -> GSI 11 (level, low) -> 
IRQ 11
Yenta: CardBus bridge found at 0000:02:04.0 [1462:0131]
Yenta: ISA IRQ mask 0x0018, PCI irq 11
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0xe000 - 0xefff
pcmcia: parent PCI bridge Memory window: 0xfbf00000 - 0xfbffffff
pcmcia: parent PCI bridge Memory window: 0x30000000 - 0x34ffffff
ACPI: PCI Interrupt 0000:02:04.1[B] -> Link [LNKE] -> GSI 6 (level, low) -> 
IRQ 6
Yenta: CardBus bridge found at 0000:02:04.1 [1462:0131]
Yenta: ISA IRQ mask 0x0018, PCI irq 6
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0xe000 - 0xefff
pcmcia: parent PCI bridge Memory window: 0xfbf00000 - 0xfbffffff
pcmcia: parent PCI bridge Memory window: 0x30000000 - 0x34ffffff
ieee80211_crypt: registered algorithm 'NULL'
ieee80211: 802.11 data/management/control stack, git-1.1.7
ieee80211: Copyright (C) 2004-2005 Intel Corporation 
<jketreno@linux.intel.com>
ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, git-1.0.8
ipw2200: Copyright(c) 2003-2005 Intel Corporation
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 5
ACPI: PCI Interrupt 0000:02:09.0[A] -> Link [LNKG] -> GSI 5 (level, low) -> 
IRQ 5
ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
psmouse.c: Wheel Mouse at isa0060/serio2/input0 lost synchronization, throwing 
1 bytes away.
usb 3-1: USB disconnect, address 2
ohci_hcd 0000:00:13.1: IRQ INTR_SF lossage
hotplug++[1446]: segfault at 00002aaa2aabe110 rip 000000000040d6e9 rsp 
00007fffffa97e70 error 4
usb 3-1: new low speed USB device using ohci_hcd and address 3
ACPI: PCI interrupt for device 0000:02:04.1 disabled
ACPI: PCI interrupt for device 0000:02:04.0 disabled
           CPU0       
  0:      41758          XT-PIC  timer
  1:        754          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:       7283          XT-PIC  ipw2200
  7:       7271          XT-PIC  ohci1394
  8:          0          XT-PIC  rtc
  9:          5          XT-PIC  acpi
 10:          2          XT-PIC  ATI IXP, ATI IXP Modem
 11:     100000          XT-PIC  ehci_hcd:usb1, ohci_hcd:usb2, ohci_hcd:usb3
 12:        349          XT-PIC  i8042
 14:       1762          XT-PIC  ide0
 15:         11          XT-PIC  ide1
NMI:         31 
LOC:      41735 
ERR:         36
MIS:          0

-- 
René Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
            http://www.exactcode.de | http://www.t2-project.org
            +49 (0)30  255 897 45
