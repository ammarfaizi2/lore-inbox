Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262514AbUKWMUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262514AbUKWMUY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 07:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbUKWMTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 07:19:50 -0500
Received: from out009pub.verizon.net ([206.46.170.131]:20972 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S262514AbUKWMTD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 07:19:03 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-bk7, back to an irq 12 "nobody cared!"
Date: Tue, 23 Nov 2004 07:19:00 -0500
User-Agent: KMail/1.7
References: <200411230014.15354.gene.heskett@verizon.net> <20041122233852.43f93aa9.akpm@osdl.org>
In-Reply-To: <20041122233852.43f93aa9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411230719.00445.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [151.205.10.220] at Tue, 23 Nov 2004 06:19:01 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 November 2004 02:38, Andrew Morton wrote:
>Gene Heskett <gene.heskett@verizon.net> wrote:
>> Just built bk7 after running the bk4-kjt1 version for a cpouple of
>>
>>  days, and noticed this in /var/log/dmesg:
>>  >From grub.conf to dmesg:
>>
>>  Kernel command line: ro root=/dev/hda7 acpi_skip_timer_override
>>
>>  Then, quite a ways down in that logfile:
>
>Please post the full dmesg output.

Linux version 2.6.10-rc2-bk7 (root@coyote.coyote.den) (gcc version 3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #1 Mon Nov 22 22:59:00 EST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 262128
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32752 pages, LIFO batch:7
DMI 2.2 present.
ACPI: RSDP (v000 Nvidia                                ) @ 0x000f7220
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3000
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3040
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff7dc0
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:10 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
Built 1 zonelists
Kernel command line: ro root=/dev/hda7 acpi_skip_timer_override 
Found and enabled local APIC!
mapped APIC to ffffd000 (fee00000)
Initializing CPU#0
CPU 0 irqstacks, hard=c044b000 soft=c044a000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2079.822 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1035252k/1048512k available (2270k kernel code, 12676k reserved, 901k data, 172k init, 131008k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 4112.38 BogoMIPS (lpj=2056192)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU: After vendor identify, caps:  0383fbff c1c3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After all inits, caps:        0383fbff c1c3fbff 00000000 00000020
CPU: AMD Athlon(tm) XP 2800+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: IRQ9 SCI: Edge set to Level Trigger.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb4c0, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041105
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: nForce2 C1 Halt Disconnect fixup
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: Power Resource [ISAV] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [APC1] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs *17), disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs *18), disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs *19), disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs *23), disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 15 devices
PnPBIOS: Disabled by ACPI
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
spurious 8259A interrupt: IRQ7.
pnp: 00:00: ioport range 0x4000-0x407f could not be reserved
pnp: 00:00: ioport range 0x4080-0x40ff has been reserved
pnp: 00:00: ioport range 0x4400-0x447f has been reserved
pnp: 00:00: ioport range 0x4480-0x44ff could not be reserved
pnp: 00:00: ioport range 0x4200-0x427f has been reserved
pnp: 00:00: ioport range 0x4280-0x42ff has been reserved
pnp: 00:01: ioport range 0x5000-0x503f has been reserved
pnp: 00:01: ioport range 0x5100-0x513f has been reserved
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
apm: overridden by ACPI.
highmem bounce pool size: 64 pages
ACPI: PCI Interrupt Link [LNK4] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 5 (level, low) -> IRQ 5
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=200.00 Mhz, System=166.00 MHz
radeonfb: PLL min 20000 max 40000
radeonfb: Monitor 1 type CRT found
radeonfb: Monitor 2 type no found
radeonfb: ATI Radeon Yd  DDR SGRAM 128 MB
vesafb: probe of vesafb0 failed with error -6
ACPI: Thermal Zone [THRM] (54 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected NVIDIA nForce2 chipset
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: AGP aperture is 128M @ 0xc0000000
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 5 (level, low) -> IRQ 5
[drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI Technologies Inc RV280 [Radeon 9200 SE]
ipmi message handler version v33
ipmi device interface version v33
irq 12: nobody cared!
 [<c0130aea>] __report_bad_irq+0x2a/0x90
 [<c01304a0>] handle_IRQ_event+0x30/0x70
 [<c0130bdc>] note_interrupt+0x6c/0xd0
 [<c0130610>] __do_IRQ+0x130/0x160
 [<c01042fe>] do_IRQ+0x3e/0x60
 =======================
 [<c01028aa>] common_interrupt+0x1a/0x20
 [<c011a370>] __do_softirq+0x30/0x90
 [<c0104401>] do_softirq+0x41/0x50
 =======================
 [<c0130464>] irq_exit+0x34/0x40
 [<c0104305>] do_IRQ+0x45/0x60
 [<c01028aa>] common_interrupt+0x1a/0x20
 [<c0130899>] setup_irq+0x99/0x120
 [<c0259950>] i8042_interrupt+0x0/0x190
 [<c0130a91>] request_irq+0x81/0xb0
 [<c0432172>] i8042_check_aux+0x32/0x170
 [<c0259950>] i8042_interrupt+0x0/0x190
 [<c04326f0>] i8042_init+0x130/0x1b0
 [<c041a81b>] do_initcalls+0x2b/0xc0
 [<c04379bd>] sock_init+0x3d/0x80
 [<c0100440>] init+0x0/0x110
 [<c010046f>] init+0x2f/0x110
 [<c010086c>] kernel_thread_helper+0x0/0x14
 [<c0100871>] kernel_thread_helper+0x5/0x14
handlers:
[<c0259950>] (i8042_interrupt+0x0/0x190)
Disabling IRQ #12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 6 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
lp0: using parport0 (interrupt-driven).
io scheduler noop registered
io scheduler cfq registered
elevator: using cfq as default io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE2: IDE controller at PCI slot 0000:00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: Maxtor 6Y120P0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: LITE-ON DVDRW LDW-451S, ATAPI CD/DVD-ROM drive
hdd: WDC WD2000JB-00EVA0, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 128KiB
hda: 240121728 sectors (122942 MB) w/7936KiB Cache, CHS=65535/16/63, UDMA(133)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
hdd: max request size: 1024KiB
hdd: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63, UDMA(100)
hdd: cache flushes supported
 hdd: hdd1 hdd2 hdd3
hdc: ATAPI 40X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ACPI: PCI Interrupt Link [LUB2] enabled at IRQ 5
ACPI: PCI interrupt 0000:00:02.2[C] -> GSI 5 (level, low) -> IRQ 5
ehci_hcd 0000:00:02.2: nVidia Corporation nForce2 USB Controller
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: irq 5, pci mem 0xdc004000
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: USB 2.0 initialized, EHCI 1.00, driver 26 Oct 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [LUBA] enabled at IRQ 12
PCI: setting IRQ 12 as level-triggered
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 12 (level, low) -> IRQ 12
ohci_hcd 0000:00:02.0: nVidia Corporation nForce2 USB Controller
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: irq 12, pci mem 0xdc002000
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ACPI: PCI Interrupt Link [LUBB] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 11 (level, low) -> IRQ 11
ohci_hcd 0000:00:02.1: nVidia Corporation nForce2 USB Controller (#2)
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: irq 11, pci mem 0xdc003000
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usb 2-1: new full speed USB device using ohci_hcd and address 2
usb 2-2: new low speed USB device using ohci_hcd and address 3
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usb 3-1: new full speed USB device using ohci_hcd and address 2
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 2 if 0 alt 0 proto 2 vid 0x04B8 pid 0x0005
usb 3-2: new full speed USB device using ohci_hcd and address 3
hub 3-2:1.0: USB hub found
hub 3-2:1.0: 4 ports detected
usb 3-3: new full speed USB device using ohci_hcd and address 4
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 4 if 0 alt 0 proto 2 vid 0x04B8 pid 0x0005
usbcore: registered new driver hiddev
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:02.0-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
usb 3-2.3: new full speed USB device using ohci_hcd and address 5
usb 3-2.4: new full speed USB device using ohci_hcd and address 6
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
drivers/usb/serial/usb-serial.c: USB Serial support registered for PL-2303
pl2303 3-2.4:1.0: PL-2303 converter detected
usb 3-2.4: PL-2303 converter now attached to ttyUSB0
usbcore: registered new driver pl2303
drivers/usb/serial/pl2303.c: Prolific PL2303 USB to serial adaptor driver v0.12
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: PC Speaker
i2c /dev entries driver
i2c_adapter i2c-5: nForce2 SMBus adapter at 0x5000
i2c_adapter i2c-6: nForce2 SMBus adapter at 0x5100
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 172k freed
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
Adding 987956k swap on /dev/hdd1.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on hdd2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdd3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
----------
This occurs during a time when I am blind as this system
gives no screen output during the bootup until the
rc.sysinit script is running for some little time.
The cursor can be seen to be moving occasionally,
and my guess is that up to that point it has no
displayable fonts.  All are compiled in, and this has been a
problem for me since around 2.6.0.  So I automaticly
take a look at dmesg as soon as I'm logged in at
initlevel 3.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.29% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
