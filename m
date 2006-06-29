Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932437AbWF2UiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbWF2UiS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 16:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbWF2UiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 16:38:17 -0400
Received: from mail.charite.de ([160.45.207.131]:4583 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S932432AbWF2UiO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 16:38:14 -0400
Date: Thu, 29 Jun 2006 22:38:09 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: BUG: held lock freed! with 2.6.17-mm3 and 2.6.17-mm4
Message-ID: <20060629203809.GD20456@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

2.6.17-mm3 and mm4 both report a "BUG: held lock freed!" while booting
up. Find the two dmesg outputs attached.

=========================
[ BUG: held lock freed! ]
-------------------------
init/1 is freeing memory dbab7750-dbab77e3, with a lock still held there!
3 locks held by init/1:
 #0:  (&type->s_umount_key#13){--..}, at: [<c0167961>] sget+0x1b1/0x350
 #1:  (&(&ip->i_iolock)->mr_lock){--..}, at: [<c01cf011>] xfs_ilock+0xa1/0xb0
 #2:  (&(&ip->i_lock)->mr_lock){--..}, at: [<c01cefed>] xfs_ilock+0x7d/0xb0

-- 
Ralf Hildebrandt (i.A. des IT-Zentrums)         Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de

--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lock.held-mm3"

 level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 30000000 (gap: 20000000:dff80000)
Detected 1591.934 MHz processor.
Built 1 zonelists.  Total pages: 114496
Kernel command line: auto BOOT_IMAGE=Linux ro root=301 hdc=noprobe hdc=cdrom video=vesafb:ywrap,mtrr:4 pci=assign-busses lapic panic=15
ide_setup: hdc=noprobe
ide_setup: hdc=cdrom
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c03f1000 soft=c03f0000
PID hash table entries: 2048 (order: 11, 8192 bytes)
Console: colour dummy device 80x25
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:    8
... MAX_LOCK_DEPTH:          30
... MAX_LOCKDEP_KEYS:        2048
... CLASSHASH_SIZE:           1024
... MAX_LOCKDEP_ENTRIES:     8192
... MAX_LOCKDEP_CHAINS:      8192
... CHAINHASH_SIZE:          4096
 memory used by lock dependency info: 696 kB
 per task-struct memory footprint: 1200 bytes
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 449036k/457984k available (2016k kernel code, 8508k reserved, 766k data, 200k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3187.75 BogoMIPS (lpj=6375500)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 078bfbff e3d3fbff 00000000 00000000 00000001 00000000 00000001
CPU: After vendor identify, caps: 078bfbff e3d3fbff 00000000 00000000 00000001 00000000 00000001
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU: After all inits, caps: 078bfbff e3d3fbff 00000000 00000410 00000001 00000000 00000001
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
CPU: AMD Turion(tm) 64 Mobile Technology ML-30 stepping 02
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 0k freed
ACPI: Core revision 20060608
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...  failed.
...trying to set up timer as Virtual Wire IRQ... works.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: BIOS Bug: MCFG area at e0000000 is not E820-reserved
PCI: Not using MMCONFIG.
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:14.1
Boot video device is 0000:01:05.0
PCI: Transparent bridge - 0000:00:14.4
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: Embedded Controller [EC] (gpe 6) interrupt mode.
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
pnp: PnP ACPI: found 11 devices
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Device 0000:02:03.0 not found by BIOS
PCI: Device 0000:02:04.0 not found by BIOS
PCI: Device 0000:02:04.1 not found by BIOS
PCI: Device 0000:02:04.2 not found by BIOS
PCI: Device 0000:02:09.0 not found by BIOS
PCI: Bridge: 0000:00:01.0
  IO window: d000-dfff
  MEM window: fbe00000-fbefffff
  PREFETCH window: f0000000-faffffff
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
ACPI: PCI Interrupt 0000:02:04.0[A] -> GSI 19 (level, low) -> IRQ 16
ACPI: PCI Interrupt 0000:02:04.1[B] -> GSI 20 (level, low) -> IRQ 17
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 8, 1572864 bytes)
TCP bind hash table entries: 8192 (order: 7, 819200 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
SGI XFS with no debug enabled
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
vesafb: framebuffer at 0xf0000000, mapped to 0xdc880000, using 3072k, total 65536k
vesafb: mode is 1024x768x16, linelength=2048, pages=41
vesafb: protected mode interface info at c000:52f9
vesafb: pmi: set display start = c00c5367, set palette = c00c53a1
vesafb: pmi: ports = d810 d816 d854 d838 d83c d85c d800 d804 d8b0 d8b2 d8b4 
vesafb: scrolling: ywrap using protected mode interface, yres_virtual=1536
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
lp: driver loaded but no devices found
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ATIIXP: IDE controller at PCI slot 0000:00:14.1
ACPI: PCI Interrupt 0000:00:14.1[A] -> GSI 16 (level, low) -> IRQ 18
ATIIXP: chipset revision 0
ATIIXP: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: WDC WD600VE-00HDT0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 117210240 sectors (60011 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 < hda5 >
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
TCP bic registered
Using IPI Shortcut mode
ACPI: (supports S0 S1 S3 S4 S5)
Time: tsc clocksource has been installed.
Freeing unused kernel memory: 200k freed
XFS mounting filesystem hda1
Starting XFS recovery on filesystem: hda1 (logdev: internal)
input: AT Translated Set 2 keyboard as /class/input/input0

=========================
[ BUG: held lock freed! ]
-------------------------
init/1 is freeing memory dbe68750-dbe687e3, with a lock still held there!
3 locks held by init/1:
 #0:  (&type->s_umount_key#13){--..}, at: [<c0166bd1>] sget+0x1b1/0x350
 #1:  (&(&ip->i_iolock)->mr_lock){--..}, at: [<c01cd161>] xfs_ilock+0xa1/0xb0
 #2:  (&(&ip->i_lock)->mr_lock){--..}, at: [<c01cd13d>] xfs_ilock+0x7d/0xb0

stack backtrace:
 [<c0104192>] show_trace+0x12/0x20
 [<c0104859>] dump_stack+0x19/0x20
 [<c0135434>] debug_check_no_locks_freed+0x154/0x170
 [<c0216c81>] __init_rwsem+0x21/0x60
 [<c01cd495>] xfs_inode_lock_init+0x25/0xe0
 [<c01cdaca>] xfs_iget+0x17a/0x59a
 [<c01ddc16>] xlog_recover_process_iunlinks+0x316/0x500
 [<c01de0c8>] xlog_recover_finish+0x2c8/0x380
 [<c01d9b07>] xfs_log_mount_finish+0x37/0x50
 [<c01e26a2>] xfs_mountfs+0xe52/0x1020
 [<c01d40b9>] xfs_ioinit+0x29/0x40
 [<c01e9afd>] xfs_mount+0x66d/0xa20
 [<c01fc415>] vfs_mount+0x25/0x30
 [<c01fc236>] xfs_fs_fill_super+0x76/0x1e0
 [<c0167516>] get_sb_bdev+0xf6/0x130
 [<c01fb3b1>] xfs_fs_get_sb+0x21/0x30
 [<c0167010>] vfs_kern_mount+0x40/0xa0
 [<c01670c6>] do_kern_mount+0x36/0x50
 [<c017d712>] do_mount+0x232/0x610
 [<c017db5f>] sys_mount+0x6f/0xb0
 [<c01030db>] syscall_call+0x7/0xb
Ending XFS recovery on filesystem: hda1 (logdev: internal)
NET: Registered protocol family 1
Yenta: CardBus bridge found at 0000:02:04.0 [1462:0131]
Yenta: ISA IRQ mask 0x0cb8, PCI irq 16
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0xe000 - 0xefff
cs: IO port probe 0xe000-0xefff: clean.
pcmcia: parent PCI bridge Memory window: 0xfbf00000 - 0xfbffffff
pcmcia: parent PCI bridge Memory window: 0x30000000 - 0x34ffffff
Yenta: CardBus bridge found at 0000:02:04.1 [1462:0131]
Synaptics Touchpad, model: 1, fw: 5.9, id: 0x116eb1, caps: 0xa04713/0x0
Yenta: ISA IRQ mask 0x0cb8, PCI irq 17
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0xe000 - 0xefff
cs: IO port probe 0xe000-0xefff: clean.
pcmcia: parent PCI bridge Memory window: 0xfbf00000 - 0xfbffffff
pcmcia: parent PCI bridge Memory window: 0x30000000 - 0x34ffffff
ACPI: PCI Interrupt 0000:02:09.0[A] -> GSI 22 (level, low) -> IRQ 19
rt2500 1.1.0 CVS 2005/07/10 http://rt2x00.serialmonkey.com
8139too Fast Ethernet driver 0.9.27
ACPI: PCI Interrupt 0000:02:03.0[A] -> GSI 18 (level, low) -> IRQ 20
eth1: RealTek RTL8139 at 0xdcb92c00, 00:10:dc:e8:c8:4f, IRQ 20
eth1:  Identified 8139 chip type 'RTL-8101'
input: SynPS/2 Synaptics TouchPad as /class/input/input1
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
piix4_smbus 0000:00:14.0: Found 0000:00:14.0 device
usbcore: registered new driver usbfs
usbcore: registered new driver hub
hdc: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
Linux agpgart interface v0.101 (c) Dave Jones
ACPI: PCI Interrupt 0000:00:14.6[B] -> GSI 17 (level, low) -> IRQ 22
hda: cache flushes supported
ACPI: PCI Interrupt 0000:00:13.2[A] -> GSI 19 (level, low) -> IRQ 16
ehci_hcd 0000:00:13.2: EHCI Host Controller
ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:13.2: irq 16, io mem 0xfbdff000
ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: new device found, idVendor=0000, idProduct=0000
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.17-mm3 ehci_hcd
usb usb1: SerialNumber: 0000:00:13.2
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ohci_hcd: 2006 May 24 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ts: Compaq touchscreen protocol output
ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 19 (level, low) -> IRQ 16
ohci_hcd 0000:00:13.0: OHCI Host Controller
ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:13.0: irq 16, io mem 0xfbdfd000
usb usb2: new device found, idVendor=0000, idProduct=0000
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: OHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.17-mm3 ohci_hcd
usb usb2: SerialNumber: 0000:00:13.0
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 4 ports detected
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
ACPI: PCI Interrupt 0000:00:13.1[A] -> GSI 19 (level, low) -> IRQ 16
ohci_hcd 0000:00:13.1: OHCI Host Controller
ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:13.1: irq 16, io mem 0xfbdfe000
usb usb3: new device found, idVendor=0000, idProduct=0000
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: OHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.17-mm3 ohci_hcd
usb usb3: SerialNumber: 0000:00:13.1
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 4 ports detected
ACPI: PCI Interrupt 0000:00:14.5[B] -> GSI 17 (level, low) -> IRQ 22
usb 3-1: new low speed USB device using ohci_hcd and address 2
cs: IO port probe 0x100-0x4ff: excluding 0x408-0x40f 0x4d0-0x4d7
cs: IO port probe 0x800-0x8ff: clean.
cs: IO port probe 0xc00-0xcff: excluding 0xc00-0xc07 0xc10-0xc17 0xc50-0xc57 0xc68-0xc6f 0xcd0-0xcdf 0xcf8-0xcff
cs: IO port probe 0xa00-0xaff: clean.
cs: IO port probe 0x100-0x4ff: excluding 0x408-0x40f 0x4d0-0x4d7
cs: IO port probe 0x800-0x8ff: clean.
cs: IO port probe 0xc00-0xcff: excluding 0xc00-0xc07 0xc10-0xc17 0xc50-0xc57 0xc68-0xc6f 0xcd0-0xcdf 0xcf8-0xcff
cs: IO port probe 0xa00-0xaff: clean.
usb 3-1: new device found, idVendor=046d, idProduct=c00c
usb 3-1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 3-1: Product: USB Optical Mouse
usb 3-1: Manufacturer: Logitech
usb 3-1: configuration #1 chosen from 1 choice
input: Logitech USB Optical Mouse as /class/input/input2
usbcore: registered new driver usbmouse
drivers/usb/input/usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
hda: cache flushes supported
Adding 1349420k swap on /dev/hda5.  Priority:-1 extents:1 across:1349420k
Linux video capture interface: v2.00
saa7130/34: v4l2 driver version 0.2.14 loaded
pcmcia: Detected deprecated PCMCIA ioctl usage from process: discover.
pcmcia: This interface will soon be removed from the kernel; please expect breakage unless you upgrade to new tools.
pcmcia: see http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html for details.
NET: Registered protocol family 17
ACPI: Battery Slot [BAT1] (battery present)
ACPI: AC Adapter [ADP1] (on-line)
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID0]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Power Button (CM) [PWRB]
Time: acpi_pm clocksource has been installed.
ACPI: Thermal Zone [THRM] (64 C)
powernow-k8: Found 1 AMD Turion(tm) 64 Mobile Technology ML-30 processors (version 2.00.00)
powernow-k8:    0 : fid 0x0 (800 MHz), vid 0x12
powernow-k8:    1 : fid 0x8 (1600 MHz), vid 0x4
powernow-k8: ph2 null fid transition 0x8
[drm] Initialized drm 1.0.1 20051102
APIC error on CPU0: 00(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
psmouse.c: TouchPad at isa0060/serio2/input0 - driver resynched.
APIC error on CPU0: 40(40)

--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lock.held-mm4"

0x08242005 MSFT 0x00000097) @ 0x1bf40200
ACPI: MADT (v001 MSI    OEMAPIC  0x08242005 MSFT 0x00000097) @ 0x1bf40300
ACPI: WDRT (v001 MSI    MSI_OEM  0x08242005 MSFT 0x00000097) @ 0x1bf40360
ACPI: MCFG (v001 MSI    OEMMCFG  0x08242005 MSFT 0x00000097) @ 0x1bf403b0
ACPI: SSDT (v001 OEM_ID OEMTBLID 0x00000001 INTL 0x02002026) @ 0x1bf43620
ACPI: OEMB (v001 MSI    MSI_OEM  0x08242005 MSFT 0x00000097) @ 0x1bf50040
ACPI: DSDT (v001    MSI     1013 0x08242005 INTL 0x02002026) @ 0x00000000
ATI board detected. Disabling timer routing over 8254.
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
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 30000000 (gap: 20000000:dff80000)
Detected 1592.032 MHz processor.
Built 1 zonelists.  Total pages: 114496
Kernel command line: BOOT_IMAGE=Linux ro root=301 hdc=noprobe hdc=cdrom video=vesafb:ywrap,mtrr:4 pci=assign-busses lapic panic=15
ide_setup: hdc=noprobe
ide_setup: hdc=cdrom
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c03f6000 soft=c03f5000
PID hash table entries: 2048 (order: 11, 8192 bytes)
Console: colour dummy device 80x25
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:    8
... MAX_LOCK_DEPTH:          30
... MAX_LOCKDEP_KEYS:        2048
... CLASSHASH_SIZE:           1024
... MAX_LOCKDEP_ENTRIES:     8192
... MAX_LOCKDEP_CHAINS:      8192
... CHAINHASH_SIZE:          4096
 memory used by lock dependency info: 696 kB
 per task-struct memory footprint: 1200 bytes
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 449016k/457984k available (2034k kernel code, 8528k reserved, 769k data, 200k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3187.58 BogoMIPS (lpj=6375170)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 078bfbff e3d3fbff 00000000 00000000 00000001 00000000 00000001
CPU: After vendor identify, caps: 078bfbff e3d3fbff 00000000 00000000 00000001 00000000 00000001
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU: After all inits, caps: 078bfbff e3d3fbff 00000000 00000410 00000001 00000000 00000001
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
CPU: AMD Turion(tm) 64 Mobile Technology ML-30 stepping 02
Checking 'hlt' instruction... OK.
ACPI: Core revision 20060623
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...  failed.
...trying to set up timer as Virtual Wire IRQ... works.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: BIOS Bug: MCFG area at e0000000 is not E820-reserved
PCI: Not using MMCONFIG.
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:14.1
Boot video device is 0000:01:05.0
PCI: Transparent bridge - 0000:00:14.4
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: Embedded Controller [EC] (gpe 6) interrupt mode.
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
pnp: PnP ACPI: found 11 devices
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Device 0000:02:03.0 not found by BIOS
PCI: Device 0000:02:04.0 not found by BIOS
PCI: Device 0000:02:04.1 not found by BIOS
PCI: Device 0000:02:04.2 not found by BIOS
PCI: Device 0000:02:09.0 not found by BIOS
PCI: Bridge: 0000:00:01.0
  IO window: d000-dfff
  MEM window: fbe00000-fbefffff
  PREFETCH window: f0000000-faffffff
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
Device `[CBC0]' is not power manageable<6>ACPI: PCI Interrupt 0000:02:04.0[A] -> GSI 19 (level, low) -> IRQ 16
Device `[CBC1]' is not power manageable<6>ACPI: PCI Interrupt 0000:02:04.1[B] -> GSI 20 (level, low) -> IRQ 17
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 8, 1572864 bytes)
TCP bind hash table entries: 8192 (order: 7, 819200 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
SGI XFS with no debug enabled
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
vesafb: framebuffer at 0xf0000000, mapped to 0xdc880000, using 3072k, total 65536k
vesafb: mode is 1024x768x16, linelength=2048, pages=41
vesafb: protected mode interface info at c000:52f9
vesafb: pmi: set display start = c00c5367, set palette = c00c53a1
vesafb: pmi: ports = d810 d816 d854 d838 d83c d85c d800 d804 d8b0 d8b2 d8b4 
vesafb: scrolling: ywrap using protected mode interface, yres_virtual=1536
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
lp: driver loaded but no devices found
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ATIIXP: IDE controller at PCI slot 0000:00:14.1
ACPI: PCI Interrupt 0000:00:14.1[A] -> GSI 16 (level, low) -> IRQ 18
ATIIXP: chipset revision 0
ATIIXP: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: WDC WD600VE-00HDT0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 117210240 sectors (60011 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 < hda5 >
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
TCP bic registered
Using IPI Shortcut mode
ACPI: (supports S0 S1 S3 S4 S5)
Time: tsc clocksource has been installed.
Freeing unused kernel memory: 200k freed
XFS mounting filesystem hda1
Starting XFS recovery on filesystem: hda1 (logdev: internal)
input: AT Translated Set 2 keyboard as /class/input/input0

=========================
[ BUG: held lock freed! ]
-------------------------
init/1 is freeing memory dbab7750-dbab77e3, with a lock still held there!
3 locks held by init/1:
 #0:  (&type->s_umount_key#13){--..}, at: [<c0167961>] sget+0x1b1/0x350
 #1:  (&(&ip->i_iolock)->mr_lock){--..}, at: [<c01cf011>] xfs_ilock+0xa1/0xb0
 #2:  (&(&ip->i_lock)->mr_lock){--..}, at: [<c01cefed>] xfs_ilock+0x7d/0xb0

stack backtrace:
 [<c0104192>] show_trace+0x12/0x20
 [<c0104859>] dump_stack+0x19/0x20
 [<c0135b24>] debug_check_no_locks_freed+0x154/0x170
 [<c0218da1>] __init_rwsem+0x21/0x60
 [<c01cf345>] xfs_inode_lock_init+0x25/0xe0
 [<c01cf97a>] xfs_iget+0x17a/0x59a
 [<c01dfad6>] xlog_recover_process_iunlinks+0x316/0x500
 [<c01dff88>] xlog_recover_finish+0x2c8/0x380
 [<c01db9c7>] xfs_log_mount_finish+0x37/0x50
 [<c01e4532>] xfs_mountfs+0xe52/0x1020
 [<c01d5f89>] xfs_ioinit+0x29/0x40
 [<c01eb98d>] xfs_mount+0x66d/0xa20
 [<c01fe365>] vfs_mount+0x25/0x30
 [<c01fe186>] xfs_fs_fill_super+0x76/0x1e0
 [<c0168296>] get_sb_bdev+0xf6/0x130
 [<c01fd301>] xfs_fs_get_sb+0x21/0x30
 [<c0167d90>] vfs_kern_mount+0x40/0xa0
 [<c0167e46>] do_kern_mount+0x36/0x50
 [<c017ecfe>] do_mount+0x27e/0x6d0
 [<c017f1bf>] sys_mount+0x6f/0xb0
 [<c01030db>] syscall_call+0x7/0xb
Ending XFS recovery on filesystem: hda1 (logdev: internal)
NET: Registered protocol family 1
Yenta: CardBus bridge found at 0000:02:04.0 [1462:0131]
Yenta: ISA IRQ mask 0x0cb8, PCI irq 16
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0xe000 - 0xefff
cs: IO port probe 0xe000-0xefff: clean.
pcmcia: parent PCI bridge Memory window: 0xfbf00000 - 0xfbffffff
pcmcia: parent PCI bridge Memory window: 0x30000000 - 0x34ffffff
Yenta: CardBus bridge found at 0000:02:04.1 [1462:0131]
Yenta: ISA IRQ mask 0x0cb8, PCI irq 17
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0xe000 - 0xefff
cs: IO port probe 0xe000-0xefff: clean.
pcmcia: parent PCI bridge Memory window: 0xfbf00000 - 0xfbffffff
pcmcia: parent PCI bridge Memory window: 0x30000000 - 0x34ffffff
8139too Fast Ethernet driver 0.9.27
Device `[RTL]' is not power manageable<6>ACPI: PCI Interrupt 0000:02:03.0[A] -> GSI 18 (level, low) -> IRQ 19
eth0: RealTek RTL8139 at 0xdc87ec00, 00:10:dc:e8:c8:4f, IRQ 19
eth0:  Identified 8139 chip type 'RTL-8101'
ACPI: PCI Interrupt 0000:02:09.0[A] -> GSI 22 (level, low) -> IRQ 20
rt2500 1.1.0 CVS 2005/07/10 http://rt2x00.serialmonkey.com
hdc: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
Synaptics Touchpad, model: 1, fw: 5.9, id: 0x116eb1, caps: 0xa04713/0x0
input: SynPS/2 Synaptics TouchPad as /class/input/input1
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
usbcore: registered new driver usbfs
usbcore: registered new driver hub
piix4_smbus 0000:00:14.0: Found 0000:00:14.0 device
ohci_hcd: 2006 May 24 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 19 (level, low) -> IRQ 16
ohci_hcd 0000:00:13.0: OHCI Host Controller
ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:13.0: irq 16, io mem 0xfbdfd000
ts: Compaq touchscreen protocol output
usb usb1: new device found, idVendor=0000, idProduct=0000
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: OHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.17-mm4 ohci_hcd
usb usb1: SerialNumber: 0000:00:13.0
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
hda: cache flushes supported
ACPI: PCI Interrupt 0000:00:13.1[A] -> GSI 19 (level, low) -> IRQ 16
ohci_hcd 0000:00:13.1: OHCI Host Controller
ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:13.1: irq 16, io mem 0xfbdfe000
Linux agpgart interface v0.101 (c) Dave Jones
usb usb2: new device found, idVendor=0000, idProduct=0000
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: OHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.17-mm4 ohci_hcd
usb usb2: SerialNumber: 0000:00:13.1
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 4 ports detected
Device `[EUSB]' is not power manageable<6>ACPI: PCI Interrupt 0000:00:13.2[A] -> GSI 19 (level, low) -> IRQ 16
ehci_hcd 0000:00:13.2: EHCI Host Controller
ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 3
ehci_hcd 0000:00:13.2: irq 16, io mem 0xfbdff000
ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb3: new device found, idVendor=0000, idProduct=0000
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: EHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.17-mm4 ehci_hcd
usb usb3: SerialNumber: 0000:00:13.2
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 8 ports detected
ACPI: PCI Interrupt 0000:00:14.6[B] -> GSI 17 (level, low) -> IRQ 22
ACPI: PCI Interrupt 0000:00:14.5[B] -> GSI 17 (level, low) -> IRQ 22
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
cs: IO port probe 0x100-0x4ff: excluding 0x408-0x40f 0x4d0-0x4d7
cs: IO port probe 0x800-0x8ff: clean.
cs: IO port probe 0xc00-0xcff: excluding 0xc00-0xc07 0xc10-0xc17 0xc50-0xc57 0xc68-0xc6f 0xcd0-0xcdf 0xcf8-0xcff
cs: IO port probe 0xa00-0xaff: clean.
cs: IO port probe 0x100-0x4ff: excluding 0x408-0x40f 0x4d0-0x4d7
cs: IO port probe 0x800-0x8ff: clean.
cs: IO port probe 0xc00-0xcff: excluding 0xc00-0xc07 0xc10-0xc17 0xc50-0xc57 0xc68-0xc6f 0xcd0-0xcdf 0xcf8-0xcff
cs: IO port probe 0xa00-0xaff: clean.
hda: cache flushes supported
Adding 1349420k swap on /dev/hda5.  Priority:-1 extents:1 across:1349420k
Linux video capture interface: v2.00
saa7130/34: v4l2 driver version 0.2.14 loaded
pcmcia: Detected deprecated PCMCIA ioctl usage from process: discover.
pcmcia: This interface will soon be removed from the kernel; please expect breakage unless you upgrade to new tools.
pcmcia: see http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html for details.
NET: Registered protocol family 17
ACPI: Battery Slot [BAT1] (battery present)
ACPI: AC Adapter [ADP1] (on-line)
ACPI: duty_cycle spans bit 4
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID0]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Power Button (CM) [PWRB]
ACPI: Thermal Zone [THRM] (64 C)
Time: acpi_pm clocksource has been installed.
powernow-k8: Found 1 AMD Turion(tm) 64 Mobile Technology ML-30 processors (version 2.00.00)
ACPI: Invalid package argument
ACPI Exception (acpi_processor-0272): AE_BAD_PARAMETER, Invalid _PSS data [20060623]
powernow-k8:    0 : fid 0x0 (800 MHz), vid 0x12
powernow-k8:    1 : fid 0x8 (1600 MHz), vid 0x4
powernow-k8: ph2 null fid transition 0x8
[drm] Initialized drm 1.0.1 20051102
psmouse.c: TouchPad at isa0060/serio2/input0 - driver resynched.

--y0ulUmNC+osPPQO6--
