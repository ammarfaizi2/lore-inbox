Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265600AbUALUyc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 15:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265610AbUALUyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 15:54:32 -0500
Received: from main.gmane.org ([80.91.224.249]:29141 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265600AbUALUwM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 15:52:12 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jens Benecke <jens-usenet@spamfreemail.de>
Subject: 2.6.1mm2: Crash on 'rmmod ehci-hcd' on shutdown
Date: Mon, 12 Jan 2004 21:52:14 +0100
Message-ID: <3745148.a9uGzvXAGr@spamfreemail.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: KNode/0.7.6
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This happens on _every_ shutdown.

This wasn't saved to disk (NUM lock still works but nothing else, after this
crash) so I took a photo with my digicam (30k): http:/
www.jensbenecke.de/2.6.1mm2-crash.jpg

Please have a look. Boot log of my machine, below, .config below that.

Thank you! :-)



syslogd 1.4.1#13: restart.
kernel: klogd 1.4.1#13, log source = /proc/kmsg started.
kernel: Inspecting /boot/System.map-2.6.1mm2-jb-k7
kernel: Loaded 27519 symbols from /boot/System.map-2.6.1mm2-jb-k7.
kernel: Symbols match kernel version 2.6.1.
kernel: No module symbols loaded - kernel modules not enabled.
kernel: Linux version 2.6.1mm2-jb-k7 (root@ds9) (gcc-Version 3.3.3 20031229
(prerelease) (Debian)) #1 SMP Sun Jan 11 23:48:16 CET 2
004
kernel: BIOS-provided physical RAM map:
kernel:  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
kernel:  BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
kernel:  BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
kernel:  BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
kernel: 127MB HIGHMEM available.
kernel: 896MB LOWMEM available.
kernel: On node 0 totalpages: 262128
kernel:   DMA zone: 4096 pages, LIFO batch:1
kernel:   Normal zone: 225280 pages, LIFO batch:16
kernel:   HighMem zone: 32752 pages, LIFO batch:7
kernel: DMI 2.2 present.
kernel: ACPI: RSDP (v000 Nvidia                                    ) @
0x000f6d80
kernel: ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @
0x3fff3000
kernel: ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @
0x3fff3040
kernel: ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @
0x00000000
kernel: ACPI: PM-Timer IO Port: 0x4008
kernel: Building zonelist for node : 0
kernel: Found and enabled local APIC!
kernel: current: c03741e0
kernel: current->thread_info: c03e8000
kernel: Initializing CPU#0
kernel: Kernel command line: auto BOOT_IMAGE=Linux rw root=301
max_scsi_luns=1
kernel: PID hash table entries: 4096 (order 12: 32768 bytes)
kernel: Detected 2079.735 MHz processor.
kernel: Using pmtmr for high-res timesource
kernel: Console: colour VGA+ 80x34
kernel: Memory: 1033368k/1048512k available (2184k kernel code, 14220k
reserved, 790k data, 220k init, 131008k highmem)
kernel: Calibrating delay loop... 2060.28 BogoMIPS
kernel: Security Scaffold v1.0.0 initialized
kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
kernel: CPU:     After generic identify, caps: 0383fbff c1c3fbff 00000000
00000000
kernel: CPU:     After vendor identify, caps: 0383fbff c1c3fbff 00000000
00000000
kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
kernel: CPU: L2 Cache: 256K (64 bytes/line)
kernel: CPU:     After all inits, caps: 0383fbff c1c3fbff 00000000 00000020
kernel: Intel machine check architecture supported.
kernel: Intel machine check reporting enabled on CPU#0.
kernel: Enabling fast FPU save and restore... done.
kernel: Enabling unmasked SIMD FPU exception support... done.
kernel: Checking 'hlt' instruction... OK.
kernel: POSIX conformance testing by UNIFIX
kernel: CPU0: AMD Athlon(tm) XP 2600+ stepping 01
kernel: per-CPU timeslice cutoff: 731.32 usecs.
kernel: task migration cache decay timeout: 1 msecs.
kernel: SMP motherboard not detected.
kernel: enabled ExtINT on CPU#0
kernel: ESR value before enabling vector: 00000000
kernel: ESR value after enabling vector: 00000000
kernel: Using local APIC timer interrupts.
kernel: calibrating APIC timer ...
kernel: ..... CPU clock speed is 2079.0159 MHz.
kernel: ..... host bus clock speed is 332.0665 MHz.
kernel: CPUS done 8
kernel: zapping low mappings.
kernel: NET: Registered protocol family 16
kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb490, last bus=3
kernel: PCI: Using configuration type 1
kernel: mtrr: v2.0 (20020519)
kernel: ACPI: Subsystem revision 20031203
kernel:  tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully
acquired
kernel: Parsing all Control
Methods:...............................................................................................
...................................................................................................................................
..................................
kernel: Table [DSDT](id F004) - 701 Objects with 75 Devices 260 Methods 27
Regions
kernel: ACPI Namespace successfully loaded at root c0453a3c
kernel: ACPI: IRQ9 SCI: Edge set to Level Trigger.
kernel: evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode
successful
kernel: evgpeblk-0747 [06] ev_create_gpe_block   : GPE 00 to 31 [_GPE] 4
regs at 0000000000004020 on int 9
kernel: evgpeblk-0747 [06] ev_create_gpe_block   : GPE 32 to 95 [_GPE] 8
regs at 00000000000044A0 on int 9
kernel: Completing Region/Field/Buffer/Package
initialization:................................................................................
kernel: Initialized 27/27 Regions 1/1 Fields 28/28 Buffers 24/24 Packages
(709 nodes)
kernel: Executing all Device _STA and_INI
methods:............................................................................spurious
8259A interrupt: IRQ7.
kernel: .
kernel: 77 Devices found containing: 77 _STA, 1 _INI methods
kernel: ACPI: Interpreter enabled
kernel: ACPI: Using PIC for interrupt routing
kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
kernel: PCI: Probing PCI hardware (bus 00)
kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB1._PRT]
kernel: ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 *11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 10 *11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 *5 6 7 10 11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 10 11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 10 11 *12 14 15)
kernel: ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 10 11 *12 14 15)
kernel: ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 *5 6 7 10 11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 10 11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 *5 6 7 10 11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10 11 *12 14 15)
kernel: ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 *11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15)
kernel: ACPI: PCI Interrupt Link [APC1] (IRQs *16)
kernel: ACPI: PCI Interrupt Link [APC2] (IRQs *17)
kernel: ACPI: PCI Interrupt Link [APC3] (IRQs 18)
kernel: ACPI: PCI Interrupt Link [APC4] (IRQs *19)
kernel: ACPI: PCI Interrupt Link [APC5] (IRQs 16)
kernel: pci_link-0262 [43] acpi_pci_link_get_curr: No IRQ resource found
kernel: ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22)
kernel: ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22)
kernel: pci_link-0262 [46] acpi_pci_link_get_curr: No IRQ resource found
kernel: ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22)
kernel: pci_link-0262 [48] acpi_pci_link_get_curr: No IRQ resource found
kernel: ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22)
kernel: pci_link-0262 [50] acpi_pci_link_get_curr: No IRQ resource found
kernel: ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22)
kernel: ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22)
kernel: ACPI: PCI Interrupt Link [APCS] (IRQs 23)
kernel: pci_link-0262 [54] acpi_pci_link_get_curr: No IRQ resource found
kernel: ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22)
kernel: pci_link-0262 [56] acpi_pci_link_get_curr: No IRQ resource found
kernel: ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22)
kernel: pci_link-0262 [58] acpi_pci_link_get_curr: No IRQ resource found
kernel: ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22)
kernel: ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22)
kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
kernel: ACPI: PCI Interrupt Link [LSMB] enabled at IRQ 11
kernel: ACPI: PCI Interrupt Link [LUBA] enabled at IRQ 11
kernel: ACPI: PCI Interrupt Link [LUBB] enabled at IRQ 10
kernel: ACPI: PCI Interrupt Link [LUB2] enabled at IRQ 5
kernel: ACPI: PCI Interrupt Link [LMAC] enabled at IRQ 12
kernel: ACPI: PCI Interrupt Link [LAPU] enabled at IRQ 12
kernel: ACPI: PCI Interrupt Link [LACI] enabled at IRQ 5
kernel: ACPI: PCI Interrupt Link [LFIR] enabled at IRQ 12
kernel: ACPI: PCI Interrupt Link [LNK2] enabled at IRQ 11
kernel: ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 11
kernel: ACPI: PCI Interrupt Link [L3CM] enabled at IRQ 11
kernel: ACPI: PCI Interrupt Link [LNK4] enabled at IRQ 5
kernel: PCI: Using ACPI for IRQ routing
kernel: PCI: if you experience problems, try using option 'pci=noacpi' or
even 'acpi=off'
kernel: Machine check exception polling timer started.
kernel: Total HugeTLB memory allocated, 0
kernel: highmem bounce pool size: 64 pages
kernel: VFS: Disk quotas dquot_6.5.1
kernel: devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
kernel: devfs: boot_options: 0x1
kernel: Initializing Cryptographic API
kernel: isapnp: Scanning for PnP cards...
kernel: isapnp: No Plug & Play device found
kernel: pty: 256 Unix98 ptys configured
kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024
blocksize
kernel: divert: not allocating divert_blk for non-ethernet device lo
kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
kernel: hda: ST340016A, ATA DISK drive
kernel: hdc: PLEXTOR CD-R PX-W2410A, ATAPI CD/DVD-ROM drive
kernel: hdd: TOSHIBA DVD-ROM SD-M1612, ATAPI CD/DVD-ROM drive
kernel: Using anticipatory io scheduler
kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
kernel: ide1 at 0x170-0x177,0x376 on irq 15
kernel: hda: max request size: 128KiB
kernel: hda: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=65535/16/63
kernel:  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 p6 > p4
kernel: mice: PS/2 mouse device common for all mice
kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
kernel: NET: Registered protocol family 2
kernel: IP: routing cache hash table of 4096 buckets, 64Kbytes
kernel: TCP: Hash tables configured (established 131072 bind 43690)
kernel: NET: Registered protocol family 1
kernel: NET: Registered protocol family 17
kernel: BIOS EDD facility v0.10 2003-Oct-11, 1 devices found
kernel: Please report your BIOS at http://domsch.com/linux/edd30
results.html
kernel: PM: Reading pmdisk image.
kernel: PM: Resume from disk failed.
kernel: ACPI: (supports S0 S1 S3 S4 S5)
kernel: found reiserfs format "3.6" with standard journal
kernel: Reiserfs journal params: device hda1, size 8192, journal first block
18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
kernel: reiserfs: checking transaction log (hda1) for (hda1)
kernel: reiserfs: replayed 19 transactions in 0 seconds
kernel: Using r5 hash to sort names
kernel: VFS: Mounted root (reiserfs filesystem).
kernel: Mounted devfs on /dev
kernel: Freeing unused kernel memory: 220k freed
kernel: Adding 497972k swap on /dev/hda6.  Priority:-1 extents:1
kernel: 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
kernel: 0000:02:01.0: 3Com PCI 3c920 Tornado at 0xa000. Vers LK1.1.19
kernel: divert: allocating divert_blk for eth0
kernel: Linux video capture interface: v1.00
kernel: bttv: Unknown parameter `vidmem'
kernel: Real Time Clock Driver v1.12
kernel: inserting floppy driver for 2.6.1mm2-jb-k7
kernel: Floppy drive(s): fd0 is 1.44M
kernel: FDC 0 is a post-1991 82077
kernel: drivers/usb/core/usb.c: registered new driver usbfs
kernel: drivers/usb/core/usb.c: registered new driver hub
kernel: ehci_hcd: block sizes: qh 128 qtd 96 itd 128 sitd 64
kernel: ehci_hcd 0000:00:02.2: EHCI Host Controller
kernel: ehci_hcd 0000:00:02.2: reset hcs_params 0x102486 dbg=1 cc=2
pcc=4 !ppc ports=6
kernel: ehci_hcd 0000:00:02.2: reset portroute 0 0 1 1 1 0
kernel: ehci_hcd 0000:00:02.2: reset hcc_params a086 caching frame
256/512/1024 park
kernel: ehci_hcd 0000:00:02.2: capability 0001 at a0
kernel: PCI: Setting latency timer of device 0000:00:02.2 to 64
kernel: ehci_hcd 0000:00:02.2: irq 5, pci mem f8939000
kernel: ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
kernel: ehci_hcd 0000:00:02.2: reset command 080b02 park=3 ithresh=8
period=1024 Reset HALT
kernel: PCI: cache line size of 64 is not supported by device 0000:00:02.2
kernel: ehci_hcd 0000:00:02.2: init command 010b09 park=3 ithresh=1
period=256 RUN
kernel: ehci_hcd 0000:00:02.2: USB 2.0 enabled, EHCI 1.00, driver
2003-Jun-13
kernel: ehci_hcd 0000:00:02.2: root hub device address 1
kernel: usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
kernel: drivers/usb/core/message.c: USB device number 1 default language ID
0x409
kernel: usb usb1: Product: EHCI Host Controller
kernel: usb usb1: Manufacturer: Linux 2.6.1mm2-jb-k7 ehci_hcd
kernel: usb usb1: SerialNumber: 0000:00:02.2
kernel: drivers/usb/core/usb.c: usb_hotplug
kernel: usb usb1: registering 1-0:1.0 (config #1, interface 0)
kernel: drivers/usb/core/usb.c: usb_hotplug
kernel: hub 1-0:1.0: usb_probe_interface
kernel: hub 1-0:1.0: usb_probe_interface - got id
kernel: hub 1-0:1.0: USB hub found
kernel: hub 1-0:1.0: 6 ports detected
kernel: hub 1-0:1.0: standalone hub
kernel: hub 1-0:1.0: ganged power switching
kernel: hub 1-0:1.0: individual port over-current protection
kernel: hub 1-0:1.0: Single TT
kernel: hub 1-0:1.0: TT requires at most 8 FS bit times
kernel: hub 1-0:1.0: Port indicators are not supported
kernel: hub 1-0:1.0: power on to power good time: 0ms
kernel: hub 1-0:1.0: hub controller current requirement: 0mA
kernel: hub 1-0:1.0: local power source is good
kernel: hub 1-0:1.0: no over-current condition exists
kernel: hub 1-0:1.0: enabling power on all ports
kernel: ehci_hcd 0000:00:02.2: GetStatus port 1 status 001803 POWER sig=j 
CSC CONNECT
kernel: hub 1-0:1.0: port 1, status 501, change 1, 480 Mb/s
kernel: drivers/usb/core/usb.c: registered new driver usbmouse
kernel: drivers/usb/input/usbmouse.c: v1.6:USB HID Boot Protocol mouse
driver
kernel: hub 1-0:1.0: debounce: port 1: delay 100ms stable 4 status 0x501
kernel: SCSI subsystem initialized
kernel: ehci_hcd 0000:00:02.2: port 1 high speed
kernel: ehci_hcd 0000:00:02.2: GetStatus port 1 status 001005 POWER sig=se0 
PE CONNECT
kernel: hub 1-0:1.0: new USB device on port 1, assigned address 2
kernel: ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev
hdX as device
kernel: scsi0 : SCSI host adapter emulation for IDE ATAPI devices
kernel:   Vendor: PLEXTOR   Model: CD-R   PX-W2410A  Rev: 1.03
kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
kernel: usb 1-1: new device strings: Mfr=1, Product=2, SerialNumber=0
kernel: drivers/usb/core/message.c: USB device number 2 default language ID
0x409
kernel: scsi1 : SCSI host adapter emulation for IDE ATAPI devices
kernel: usb 1-1: Product: EPSON Scanner
kernel: usb 1-1: Manufacturer: EPSON
kernel: drivers/usb/core/usb.c: usb_hotplug
kernel: usb 1-1: registering 1-1:1.0 (config #1, interface 0)
kernel: drivers/usb/core/usb.c: usb_hotplug
kernel: ehci_hcd 0000:00:02.2: GetStatus port 4 status 001403 POWER sig=k 
CSC CONNECT
kernel: hub 1-0:1.0: port 4, status 501, change 1, 480 Mb/s
kernel:   Vendor: TOSHIBA   Model: DVD-ROM SD-M1612  Rev: 1004
kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
kernel: Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 5
kernel: Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 5
kernel: usbscanner 1-1:1.0: usb_probe_interface
kernel: usbscanner 1-1:1.0: usb_probe_interface - got id
kernel: drivers/usb/core/file.c: looking for a minor, starting at 0
kernel: drivers/usb/image/scanner.c: USB scanner device (0x04b8/0x011b) now
attached to usb/scanner-4
kernel: drivers/usb/core/usb.c: registered new driver usbscanner
kernel: drivers/usb/image/scanner.c: 0.4.16:USB Scanner Driver
kernel: cdrom: sr0: unknown mrw mode page
kernel: sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
kernel: Uniform CD-ROM driver Revision: 3.20
kernel: Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
kernel: hub 1-0:1.0: debounce: port 4: delay 100ms stable 4 status 0x501
kernel: ehci_hcd 0000:00:02.2: port 4 low speed --> companion
kernel: cdrom: sr1: unknown mrw mode page
kernel: sr1: scsi3-mmc drive: 48x/48x cd/rw xa/form2 cdda tray
kernel: Attached scsi CD-ROM sr1 at scsi1, channel 0, id 0, lun 0
kernel: ehci_hcd 0000:00:02.2: GetStatus port 4 status 003002 POWER OWNER
sig=se0  CSC
kernel: ehci_hcd 0000:00:02.2: GetStatus port 4 status 003002 POWER OWNER
sig=se0  CSC
kernel: hub 1-0:1.0: port 4, status 0, change 1, 12 Mb/s
kernel: ohci1394: $Rev: 1087 $ Ben Collins <bcollins@debian.org>
kernel: PCI: Setting latency timer of device 0000:00:0d.0 to 64
kernel: ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[12] 
MMIO=[de084000-de0847ff]  Max Packet=[2048]
kernel: Debug: sleeping function called from invalid context at mm
slab.c:1868
kernel: in_atomic():1, irqs_disabled():0
kernel: Call Trace:
kernel:  [__might_sleep+171/208] __might_sleep+0xab/0xd0
kernel:  [kmem_cache_alloc+514/528] kmem_cache_alloc+0x202/0x210
kernel:  [freed_request+179/192] freed_request+0xb3/0xc0
kernel:  [dup_task_struct+41/240] dup_task_struct+0x29/0xf0
kernel:  [copy_process+209/3408] copy_process+0xd1/0xd50
kernel:  [poke_blanked_console+112/176] poke_blanked_console+0x70/0xb0
kernel:  [do_fork+77/384] do_fork+0x4d/0x180
kernel:  [kernel_thread+133/144] kernel_thread+0x85/0x90
kernel:  [__crc_path_release+1438798/3128146] nodemgr_host_thread+0x0/0x1a0
[ieee1394]
kernel:  [kernel_thread_helper+0/24] kernel_thread_helper+0x0/0x18
kernel:  [__crc_path_release+1439995/3128146] nodemgr_add_host+0xad/0x100
[ieee1394]
kernel:  [__crc_path_release+1438798/3128146] nodemgr_host_thread+0x0/0x1a0
[ieee1394]
kernel:  [__crc_path_release+1420748/3128146] highlevel_add_host+0x8e/0xa0
[ieee1394]
kernel:  [__crc_path_release+1417650/3128146] hpsb_add_host+0x14/0x40
[ieee1394]
kernel:  [__crc_path_release+610225/3128146] ohci1394_pci_probe+0x433/0x5b0
[ohci1394]
kernel:  [__crc_path_release+598894/3128146] ohci_irq_handler+0x0/0xe60
[ohci1394]
kernel:  [pci_device_probe_static+75/96] pci_device_probe_static+0x4b/0x60
kernel:  [__pci_device_probe+54/80] __pci_device_probe+0x36/0x50
kernel:  [pci_device_probe+44/80] pci_device_probe+0x2c/0x50
kernel:  [bus_match+61/112] bus_match+0x3d/0x70
kernel:  [driver_attach+90/144] driver_attach+0x5a/0x90
kernel:  [bus_add_driver+165/192] bus_add_driver+0xa5/0xc0
kernel:  [pci_register_driver+122/160] pci_register_driver+0x7a/0xa0
kernel:  [__crc_path_release+138659/3128146] ohci1394_init+0x15/0x3c
[ohci1394]
kernel:  [sys_init_module+363/768] sys_init_module+0x16b/0x300
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel:
kernel: raw1394: /dev/raw1394 device initialized
kernel: found reiserfs format "3.6" with standard journal
kernel: Reiserfs journal params: device hda5, size 8192, journal first block
18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
kernel: reiserfs: checking transaction log (hda5) for (hda5)
kernel: reiserfs: replayed 1 transactions in 0 seconds
kernel: Using r5 hash to sort names
kernel: found reiserfs format "3.6" with standard journal
kernel: Reiserfs journal params: device hda4, size 8192, journal first block
18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
kernel: reiserfs: checking transaction log (hda4) for (hda4)
kernel: reiserfs: replayed 4 transactions in 0 seconds
kernel: Using r5 hash to sort names
kernel: ohci_hcd: 2003 Oct 13 USB 1.1 'Open' Host Controller (OHCI) Driver
(PCI)
kernel: ohci_hcd: block sizes: ed 64 td 64
kernel: ohci_hcd 0000:00:02.0: OHCI Host Controller
kernel: ohci_hcd 0000:00:02.0: reset, control = 0x600
kernel: PCI: Setting latency timer of device 0000:00:02.0 to 64
kernel: ohci_hcd 0000:00:02.0: irq 11, pci mem f8a56000
kernel: ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
kernel: ohci_hcd 0000:00:02.0: root hub device address 1
kernel: usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
kernel: drivers/usb/core/message.c: USB device number 1 default language ID
0x409
kernel: usb usb2: Product: OHCI Host Controller
kernel: usb usb2: Manufacturer: Linux 2.6.1mm2-jb-k7 ohci_hcd
kernel: usb usb2: SerialNumber: 0000:00:02.0
kernel: drivers/usb/core/usb.c: usb_hotplug
kernel: usb usb2: registering 2-0:1.0 (config #1, interface 0)
kernel: drivers/usb/core/usb.c: usb_hotplug
kernel: hub 2-0:1.0: usb_probe_interface
kernel: hub 2-0:1.0: usb_probe_interface - got id
kernel: hub 2-0:1.0: USB hub found
kernel: hub 2-0:1.0: 3 ports detected
kernel: hub 2-0:1.0: standalone hub
kernel: hub 2-0:1.0: ganged power switching
kernel: hub 2-0:1.0: global over-current protection
kernel: hub 2-0:1.0: Port indicators are not supported
kernel: hub 2-0:1.0: power on to power good time: 2ms
kernel: hub 2-0:1.0: hub controller current requirement: 0mA
kernel: hub 2-0:1.0: local power source is good
kernel: hub 2-0:1.0: no over-current condition exists
kernel: hub 2-0:1.0: enabling power on all ports
kernel: ohci_hcd 0000:00:02.0: created debug files
kernel: ohci_hcd 0000:00:02.0: OHCI controller state
kernel: ohci_hcd 0000:00:02.0: OHCI 1.0, with legacy support registers
kernel: ohci_hcd 0000:00:02.0: control 0x68f RWE RWC HCFS=operational IE PLE
CBSR=3
kernel: ohci_hcd 0000:00:02.0: cmdstatus 0x00000 SOC=0
kernel: ohci_hcd 0000:00:02.0: intrstatus 0x00000004 SF
kernel: ohci_hcd 0000:00:02.0: intrenable 0x80000002 MIE WDH
kernel: ohci_hcd 0000:00:02.0: hcca frame #002f
kernel: ohci_hcd 0000:00:02.0: roothub.a 01000203 POTPGT=1 NPS NDP=3
kernel: ohci_hcd 0000:00:02.0: roothub.b 00000000 PPCM=0000 DR=0000
kernel: ohci_hcd 0000:00:02.0: roothub.status 00000000
kernel: ohci_hcd 0000:00:02.0: roothub.portstatus [0] 0x00000100 PPS
kernel: ohci_hcd 0000:00:02.0: roothub.portstatus [1] 0x00000100 PPS
kernel: ohci_hcd 0000:00:02.0: roothub.portstatus [2] 0x00000100 PPS
kernel: ohci_hcd 0000:00:02.1: OHCI Host Controller
kernel: ohci_hcd 0000:00:02.1: reset, control = 0x600
kernel: PCI: Setting latency timer of device 0000:00:02.1 to 64
kernel: ohci_hcd 0000:00:02.1: irq 10, pci mem f8a5d000
kernel: ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 3
kernel: ohci_hcd 0000:00:02.1: root hub device address 1
kernel: usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
kernel: drivers/usb/core/message.c: USB device number 1 default language ID
0x409
kernel: usb usb3: Product: OHCI Host Controller
kernel: usb usb3: Manufacturer: Linux 2.6.1mm2-jb-k7 ohci_hcd
kernel: usb usb3: SerialNumber: 0000:00:02.1
kernel: drivers/usb/core/usb.c: usb_hotplug
kernel: usb usb3: registering 3-0:1.0 (config #1, interface 0)
kernel: drivers/usb/core/usb.c: usb_hotplug
kernel: hub 3-0:1.0: usb_probe_interface
kernel: hub 3-0:1.0: usb_probe_interface - got id
kernel: hub 3-0:1.0: USB hub found
kernel: hub 3-0:1.0: 3 ports detected
kernel: hub 3-0:1.0: standalone hub
kernel: hub 3-0:1.0: ganged power switching
kernel: hub 3-0:1.0: global over-current protection
kernel: hub 3-0:1.0: Port indicators are not supported
kernel: hub 3-0:1.0: power on to power good time: 2ms
kernel: hub 3-0:1.0: hub controller current requirement: 0mA
kernel: hub 3-0:1.0: local power source is good
kernel: hub 3-0:1.0: no over-current condition exists
kernel: hub 3-0:1.0: enabling power on all ports
kernel: ohci_hcd 0000:00:02.1: created debug files
kernel: ohci_hcd 0000:00:02.1: OHCI controller state
kernel: ohci_hcd 0000:00:02.1: OHCI 1.0, with legacy support registers
kernel: ohci_hcd 0000:00:02.1: control 0x68f RWE RWC HCFS=operational IE PLE
CBSR=3
kernel: ohci_hcd 0000:00:02.1: cmdstatus 0x00000 SOC=0
kernel: ohci_hcd 0000:00:02.1: intrstatus 0x00000044 RHSC SF
kernel: ohci_hcd 0000:00:02.1: intrenable 0x80000002 MIE WDH
kernel: ohci_hcd 0000:00:02.1: hcca frame #002d
kernel: ohci_hcd 0000:00:02.1: roothub.a 01000203 POTPGT=1 NPS NDP=3
kernel: ohci_hcd 0000:00:02.1: roothub.b 00000000 PPCM=0000 DR=0000
kernel: ohci_hcd 0000:00:02.1: roothub.status 00000000
kernel: ohci_hcd 0000:00:02.1: roothub.portstatus [0] 0x00000100 PPS
kernel: ohci_hcd 0000:00:02.1: roothub.portstatus [1] 0x00010301 CSC LSDA
PPS CCS
kernel: ohci_hcd 0000:00:02.1: roothub.portstatus [2] 0x00000100 PPS
kernel: drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface
driver v2.1
kernel: ohci_hcd 0000:00:02.1: GetStatus roothub.portstatus [2] = 0x00010301
CSC LSDA PPS CCS
kernel: hub 3-0:1.0: port 2, status 301, change 1, 1.5 Mb/s
kernel: hub 3-0:1.0: debounce: port 2: delay 100ms stable 4 status 0x301
kernel: ohci_hcd 0000:00:02.1: GetStatus roothub.portstatus [2] = 0x00100303
PRSC LSDA PPS PES CCS
kernel: hub 3-0:1.0: new USB device on port 2, assigned address 2
kernel: usb 3-2: new device strings: Mfr=1, Product=3, SerialNumber=0
kernel: drivers/usb/core/message.c: USB device number 2 default language ID
0x409
kernel: usb 3-2: Product: Microsoft 5-Button Mouse with IntelliEye(TM)
kernel: usb 3-2: Manufacturer: Microsoft
kernel: drivers/usb/core/usb.c: usb_hotplug
kernel: usb 3-2: registering 3-2:1.0 (config #1, interface 0)
kernel: drivers/usb/core/usb.c: usb_hotplug
kernel: usbmouse 3-2:1.0: usb_probe_interface
kernel: usbmouse 3-2:1.0: usb_probe_interface - got id
kernel: input: Microsoft Microsoft 5-Button Mouse with IntelliEye(TM) on
usb-0000:00:02.1-2
kernel: nfs warning: mount version older than kernel
input.agent[379]: kernel driver evdev already loaded
usb.agent[431]: kernel driver usbcore already loaded
usb.agent[414]: kernel driver usbcore already loaded
input.agent[463]: kernel driver evdev already loaded
input.agent[469]: kernel driver evdev already loaded
input.agent[825]: kernel driver evdev already loaded
input.agent[475]: kernel driver evdev already loaded
usb.agent[457]: kernel driver usbmouse already loaded
kernel: ts: Compaq touchscreen protocol output
kernel: drivers/usb/core/usb.c: registered new driver hiddev
kernel: drivers/usb/core/usb.c: registered new driver hid
kernel: drivers/usb/input/hid-core.c: v2.0:USB HID core driver
kernel: NET: Registered protocol family 10
kernel: Disabled Privacy Extensions on device c03ae700(lo)
kernel: IPv6 over IPv4 tunneling driver
kernel: divert: not allocating divert_blk for non-ethernet device sit0
rpc.statd[1027]: Version 1.0.6 Starting
rpc.statd[1027]: statd running as root. chown /var/lib/nfs/sm to choose
different user
kdm: :0[883]: IO Error in XOpenDisplay
kdm[859]: X server for display :0 terminated unexpectedly
kdm[859]: Display :0 cannot be opened
kdm[859]: Unable to fire up local display :0; disabling.
kernel: eth0: no IPv6 routers present
kernel: request_module: failed /sbin/modprobe -- vmnet8. error = 256
kernel: Linux agpgart interface v0.100 (c) Dave Jones
kernel: agpgart: Detected NVIDIA nForce2 chipset
kernel: agpgart: Maximum main memory to use for agp memory: 941M
kernel: agpgart: AGP aperture is 128M @ 0xc0000000
kernel: NFORCE2: IDE controller at PCI slot 0000:00:09.0
kernel: NFORCE2: chipset revision 162
kernel: NFORCE2: not 100%% native mode: will probe irqs later
kernel: NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.
kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
kernel: NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
kernel: NFORCE2: port 0x01f0 already claimed by ide0
kernel: NFORCE2: port 0x0170 already claimed by ide1
kernel: NFORCE2: neither IDE port enabled (BIOS)
kernel: Module amd74xx cannot be unloaded due to unsafe usage in include
linux/module.h:483
shutdown[2064]: shutting down for system reboot
init: init_setenv: INIT_HALT, (null), 10
init: Switching to runlevel: 6
kernel: request_module: failed /sbin/modprobe -- vmnet8. error = 256
rpc.statd[1027]: Caught signal 15, un-registering and exiting.
kernel: Kernel logging (proc) stopped.
kernel: Kernel log daemon terminating.



.config:

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_STANDALONE=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=15
# CONFIG_IKCONFIG is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_GENERIC=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
# CONFIG_X86_4G is not set
# CONFIG_X86_SWITCH_PAGETABLES is not set
# CONFIG_X86_4G_VM_LAYOUT is not set
# CONFIG_X86_UACCESS_INDIRECT is not set
# CONFIG_X86_HIGH_ENTRY is not set
CONFIG_HPET_TIMER=y
# CONFIG_HPET_EMULATE_RTC is not set
CONFIG_SMP=y
CONFIG_NR_CPUS=8
CONFIG_PREEMPT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
CONFIG_TOSHIBA=m
CONFIG_I8K=m
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_EDD=y
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
# CONFIG_HIGHPTE is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_EFI=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_BOOT_IOREMAP=y

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_PM_DISK=y
CONFIG_PM_DISK_PARTITION=""

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_ASUS=m
CONFIG_ACPI_TOSHIBA=m
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_ACPI_RELAXED_AML=y
CONFIG_X86_PM_TIMER=y

#
# APM (Advanced Power Management) BIOS Support
#
CONFIG_APM=m
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y
# CONFIG_APM_RTC_IS_GMT is not set
CONFIG_APM_ALLOW_INTS=y
CONFIG_APM_REAL_MODE_POWER_OFF=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_PROC_INTF=m
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=m
CONFIG_CPU_FREQ_GOV_USERSPACE=m
CONFIG_CPU_FREQ_24_API=y
CONFIG_CPU_FREQ_TABLE=y

#
# CPUFreq processor drivers
#
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_PROC_INTF=y
CONFIG_X86_POWERNOW_K6=m
CONFIG_X86_POWERNOW_K7=m
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_GX_SUSPMOD=m
CONFIG_X86_SPEEDSTEP_CENTRINO=m
CONFIG_X86_SPEEDSTEP_ICH=m
CONFIG_X86_SPEEDSTEP_SMI=m
CONFIG_X86_SPEEDSTEP_LIB=m
CONFIG_X86_P4_CLOCKMOD=m
CONFIG_X86_LONGRUN=m
CONFIG_X86_LONGHAUL=m

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_USE_VECTOR is not set
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=m
CONFIG_PCMCIA_COMPAT=m
CONFIG_YENTA=m
CONFIG_CARDBUS=y
CONFIG_I82092=m
CONFIG_I82365=m
CONFIG_TCIC=m
CONFIG_PCMCIA_PROBE=y

#
# PCI Hotplug Support
#
CONFIG_HOTPLUG_PCI=m
# CONFIG_HOTPLUG_PCI_FAKE is not set
CONFIG_HOTPLUG_PCI_COMPAQ=m
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
CONFIG_HOTPLUG_PCI_IBM=m
CONFIG_HOTPLUG_PCI_ACPI=m
# CONFIG_HOTPLUG_PCI_CPCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_FW_LOADER=m

#
# Memory Technology Devices (MTD)
#
CONFIG_MTD=m
# CONFIG_MTD_DEBUG is not set
CONFIG_MTD_PARTITIONS=m
CONFIG_MTD_CONCAT=m
CONFIG_MTD_REDBOOT_PARTS=m
CONFIG_MTD_CMDLINE_PARTS=m

#
# User Modules And Translation Layers
#
CONFIG_MTD_CHAR=m
CONFIG_MTD_BLOCK=m
CONFIG_MTD_BLOCK_RO=m
CONFIG_FTL=m
CONFIG_NFTL=m
CONFIG_NFTL_RW=y
# CONFIG_INFTL is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=m
CONFIG_MTD_JEDECPROBE=m
CONFIG_MTD_GEN_PROBE=m
CONFIG_MTD_CFI_ADV_OPTIONS=y
CONFIG_MTD_CFI_NOSWAP=y
# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
# CONFIG_MTD_CFI_GEOMETRY is not set
CONFIG_MTD_CFI_INTELEXT=m
CONFIG_MTD_CFI_AMDSTD=m
CONFIG_MTD_CFI_STAA=m
CONFIG_MTD_RAM=m
CONFIG_MTD_ROM=m
CONFIG_MTD_ABSENT=m
CONFIG_MTD_OBSOLETE_CHIPS=y
CONFIG_MTD_AMDSTD=m
CONFIG_MTD_SHARP=m
CONFIG_MTD_JEDEC=m

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
CONFIG_MTD_PHYSMAP=m
CONFIG_MTD_PHYSMAP_START=0x8000000
CONFIG_MTD_PHYSMAP_LEN=0x4000000
CONFIG_MTD_PHYSMAP_BUSWIDTH=2
CONFIG_MTD_PNC2000=m
CONFIG_MTD_SC520CDP=m
CONFIG_MTD_NETSC520=m
CONFIG_MTD_SCx200_DOCFLASH=m
CONFIG_MTD_AMD76XROM=m
CONFIG_MTD_SCB2_FLASH=m
CONFIG_MTD_NETtel=m
CONFIG_MTD_DILNETPC=m
CONFIG_MTD_DILNETPC_BOOTSIZE=0x80000
CONFIG_MTD_L440GX=m

#
# Self-contained MTD device drivers
#
CONFIG_MTD_PMC551=m
CONFIG_MTD_PMC551_BUGFIX=y
CONFIG_MTD_PMC551_DEBUG=y
CONFIG_MTD_SLRAM=m
CONFIG_MTD_MTDRAM=m
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128
CONFIG_MTD_BLKMTD=m

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOC2000=m
CONFIG_MTD_DOC2001=m
CONFIG_MTD_DOC2001PLUS=m
CONFIG_MTD_DOCPROBE=m
CONFIG_MTD_DOCPROBE_ADVANCED=y
CONFIG_MTD_DOCPROBE_ADDRESS=0x0
CONFIG_MTD_DOCPROBE_HIGH=y
CONFIG_MTD_DOCPROBE_55AA=y

#
# NAND Flash Device Drivers
#
CONFIG_MTD_NAND=m
CONFIG_MTD_NAND_VERIFY_WRITE=y
CONFIG_MTD_NAND_IDS=m

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_SERIAL=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PARPORT_PC_PCMCIA=m
CONFIG_PARPORT_OTHER=y
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_ISAPNP=y
# CONFIG_PNPBIOS is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_DEV_XD is not set
CONFIG_PARIDE=m
CONFIG_PARIDE_PARPORT=m

#
# Parallel IDE high-level drivers
#
CONFIG_PARIDE_PD=m
CONFIG_PARIDE_PCD=m
CONFIG_PARIDE_PF=m
CONFIG_PARIDE_PT=m
CONFIG_PARIDE_PG=m

#
# Parallel IDE protocol modules
#
CONFIG_PARIDE_ATEN=m
CONFIG_PARIDE_BPCK=m
CONFIG_PARIDE_BPCK6=m
CONFIG_PARIDE_COMM=m
CONFIG_PARIDE_DSTR=m
CONFIG_PARIDE_FIT2=m
CONFIG_PARIDE_FIT3=m
CONFIG_PARIDE_EPAT=m
CONFIG_PARIDE_EPATC8=y
CONFIG_PARIDE_EPIA=m
CONFIG_PARIDE_FRIQ=m
CONFIG_PARIDE_FRPW=m
CONFIG_PARIDE_KBIC=m
CONFIG_PARIDE_KTTI=m
CONFIG_PARIDE_ON20=m
CONFIG_PARIDE_ON26=m
CONFIG_BLK_CPQ_DA=m
CONFIG_BLK_CPQ_CISS_DA=m
CONFIG_CISS_SCSI_TAPE=y
CONFIG_BLK_DEV_DAC960=m
CONFIG_BLK_DEV_UMEM=m
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_LBD=y

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_IDEDISK_STROKE=y
CONFIG_BLK_DEV_IDECS=m
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_IDE_TASK_IOCTL=y
CONFIG_IDE_TASKFILE_IO=y

#
# IDE chipset support/bugfixes
#
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_CMD640_ENHANCED=y
CONFIG_BLK_DEV_IDEPNP=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_OPTI621=m
CONFIG_BLK_DEV_RZ1000=m
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_IDEDMA_PCI_WIP=y
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_AEC62XX=m
CONFIG_BLK_DEV_ALI15X3=m
CONFIG_WDC_ALI15X3=y
CONFIG_BLK_DEV_AMD74XX=m
CONFIG_BLK_DEV_CMD64X=m
CONFIG_BLK_DEV_TRIFLEX=m
CONFIG_BLK_DEV_CY82C693=m
CONFIG_BLK_DEV_CS5520=m
CONFIG_BLK_DEV_CS5530=m
CONFIG_BLK_DEV_HPT34X=m
CONFIG_HPT34X_AUTODMA=y
CONFIG_BLK_DEV_HPT366=m
CONFIG_BLK_DEV_SC1200=m
CONFIG_BLK_DEV_PIIX=m
CONFIG_BLK_DEV_NS87415=m
CONFIG_BLK_DEV_PDC202XX_OLD=m
CONFIG_BLK_DEV_PDC202XX_NEW=m
CONFIG_BLK_DEV_SVWKS=m
CONFIG_BLK_DEV_SIIMAGE=m
CONFIG_BLK_DEV_SIS5513=m
CONFIG_BLK_DEV_SLC90E66=m
CONFIG_BLK_DEV_TRM290=m
CONFIG_BLK_DEV_VIA82CXXX=m
CONFIG_IDE_CHIPSETS=y

#
# Note: most of these also require special kernel boot parameters
#
CONFIG_BLK_DEV_4DRIVES=y
CONFIG_BLK_DEV_ALI14XX=m
CONFIG_BLK_DEV_DTC2278=m
CONFIG_BLK_DEV_HT6560B=m
CONFIG_BLK_DEV_PDC4030=m
CONFIG_BLK_DEV_QD65XX=m
CONFIG_BLK_DEV_UMC8672=m
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=m
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_MAX_SD_DISKS=256
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_REPORT_LUNS=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

#
# SCSI low-level drivers
#
CONFIG_BLK_DEV_3W_XXXX_RAID=m
CONFIG_SCSI_7000FASST=m
CONFIG_SCSI_ACARD=m
CONFIG_SCSI_AHA152X=m
CONFIG_SCSI_AHA1542=m
CONFIG_SCSI_AACRAID=m
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
CONFIG_AIC7XXX_RESET_DELAY_MS=5000
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=0
# CONFIG_AIC7XXX_REG_PRETTY_PRINT is not set
CONFIG_SCSI_AIC7XXX_OLD=m
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=32
CONFIG_AIC79XX_RESET_DELAY_MS=15000
# CONFIG_AIC79XX_BUILD_FIRMWARE is not set
# CONFIG_AIC79XX_ENABLE_RD_STRM is not set
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
CONFIG_SCSI_ADVANSYS=m
CONFIG_SCSI_IN2000=m
CONFIG_SCSI_MEGARAID=m
CONFIG_SCSI_SATA=y
CONFIG_SCSI_SATA_SVW=m
CONFIG_SCSI_ATA_PIIX=m
CONFIG_SCSI_SATA_PROMISE=m
CONFIG_SCSI_SATA_VIA=m
CONFIG_SCSI_BUSLOGIC=m
# CONFIG_SCSI_OMIT_FLASHPOINT is not set
CONFIG_SCSI_CPQFCTS=m
CONFIG_SCSI_DMX3191D=m
CONFIG_SCSI_DTC3280=m
CONFIG_SCSI_EATA=m
CONFIG_SCSI_EATA_TAGGED_QUEUE=y
CONFIG_SCSI_EATA_LINKED_COMMANDS=y
CONFIG_SCSI_EATA_MAX_TAGS=16
CONFIG_SCSI_EATA_PIO=m
CONFIG_SCSI_FUTURE_DOMAIN=m
CONFIG_SCSI_GDTH=m
CONFIG_SCSI_GENERIC_NCR5380=m
CONFIG_SCSI_GENERIC_NCR5380_MMIO=m
CONFIG_SCSI_GENERIC_NCR53C400=y
CONFIG_SCSI_IPS=m
CONFIG_SCSI_INIA100=m
CONFIG_SCSI_PPA=m
CONFIG_SCSI_IMM=m
CONFIG_SCSI_IZIP_EPP16=y
# CONFIG_SCSI_IZIP_SLOW_CTR is not set
CONFIG_SCSI_NCR53C406A=m
CONFIG_SCSI_SYM53C8XX_2=m
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
# CONFIG_SCSI_SYM53C8XX_IOMAPPED is not set
CONFIG_SCSI_PAS16=m
CONFIG_SCSI_PSI240I=m
CONFIG_SCSI_QLOGIC_FAS=m
CONFIG_SCSI_QLOGIC_ISP=m
CONFIG_SCSI_QLOGIC_FC=m
# CONFIG_SCSI_QLOGIC_FC_FIRMWARE is not set
CONFIG_SCSI_QLOGIC_1280=m
CONFIG_SCSI_SYM53C416=m
CONFIG_SCSI_DC395x=m
CONFIG_SCSI_DC390T=m
# CONFIG_SCSI_DC390T_NOGENSUPP is not set
CONFIG_SCSI_T128=m
CONFIG_SCSI_U14_34F=m
CONFIG_SCSI_U14_34F_TAGGED_QUEUE=y
CONFIG_SCSI_U14_34F_LINKED_COMMANDS=y
CONFIG_SCSI_U14_34F_MAX_TAGS=8
CONFIG_SCSI_ULTRASTOR=m
CONFIG_SCSI_NSP32=m
CONFIG_SCSI_DEBUG=m

#
# PCMCIA SCSI adapter support
#
CONFIG_PCMCIA_AHA152X=m
CONFIG_PCMCIA_FDOMAIN=m
CONFIG_PCMCIA_NINJA_SCSI=m
CONFIG_PCMCIA_QLOGIC=m

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
CONFIG_CD_NO_IDESCSI=y
CONFIG_AZTCD=m
CONFIG_GSCD=m
CONFIG_MCD=m
CONFIG_MCD_IRQ=11
CONFIG_MCD_BASE=0x300
CONFIG_MCDX=m
CONFIG_OPTCD=m
CONFIG_SJCD=m
CONFIG_ISP16_CDI=m
CONFIG_CDU535=m

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID5=m
CONFIG_MD_RAID6=m
CONFIG_MD_MULTIPATH=m
CONFIG_BLK_DEV_DM=m
CONFIG_DM_IOCTL_V4=y

#
# Fusion MPT device support
#
CONFIG_FUSION=m
CONFIG_FUSION_MAX_SGE=40
CONFIG_FUSION_ISENSE=m
CONFIG_FUSION_CTL=m
CONFIG_FUSION_LAN=m

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
CONFIG_IEEE1394=m

#
# Subsystem Options
#
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
CONFIG_IEEE1394_OUI_DB=y

#
# Device Drivers
#
CONFIG_IEEE1394_PCILYNX=m
CONFIG_IEEE1394_OHCI1394=m

#
# Protocol Drivers
#
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_SBP2=m
CONFIG_IEEE1394_SBP2_PHYS_DMA=y
CONFIG_IEEE1394_ETH1394=m
CONFIG_IEEE1394_DV1394=m
CONFIG_IEEE1394_RAWIO=m
CONFIG_IEEE1394_CMP=m
CONFIG_IEEE1394_AMDTP=m

#
# I2O device support
#
CONFIG_I2O=m
CONFIG_I2O_PCI=m
CONFIG_I2O_BLOCK=m
CONFIG_I2O_SCSI=m
CONFIG_I2O_PROC=m

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=m
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_NAT=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_TOS=y
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
# CONFIG_NET_IPGRE_BROADCAST is not set
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
# CONFIG_ARPD is not set
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
CONFIG_IPV6=m
CONFIG_IPV6_PRIVACY=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_TUNNEL=m
CONFIG_DECNET=m
CONFIG_DECNET_SIOCGIFCONF=y
CONFIG_DECNET_ROUTER=y
# CONFIG_DECNET_ROUTE_FWMARK is not set
CONFIG_BRIDGE=m
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_BRIDGE_NETFILTER=y

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
# CONFIG_IP_NF_MATCH_IPRANGE is not set
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_OWNER=m
# CONFIG_IP_NF_MATCH_PHYSDEV is not set
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
# CONFIG_IP_NF_TARGET_NETMAP is not set
# CONFIG_IP_NF_TARGET_SAME is not set
CONFIG_IP_NF_NAT_LOCAL=y
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
# CONFIG_IP_NF_TARGET_CLASSIFY is not set
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
CONFIG_IP_NF_COMPAT_IPCHAINS=m
CONFIG_IP_NF_COMPAT_IPFWADM=m

#
# IPv6: Netfilter Configuration
#
CONFIG_IP6_NF_QUEUE=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_LIMIT=m
CONFIG_IP6_NF_MATCH_MAC=m
CONFIG_IP6_NF_MATCH_RT=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_MULTIPORT=m
CONFIG_IP6_NF_MATCH_OWNER=m
CONFIG_IP6_NF_MATCH_MARK=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_AHESP=m
CONFIG_IP6_NF_MATCH_LENGTH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_LOG=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m

#
# DECnet: Netfilter Configuration
#
# CONFIG_DECNET_NF_GRABULATOR is not set

#
# Bridge: Netfilter Configuration
#
# CONFIG_BRIDGE_NF_EBTABLES is not set
CONFIG_XFRM=y
CONFIG_XFRM_USER=m

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=m
# CONFIG_IP_SCTP is not set
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
CONFIG_ATM_CLIP_NO_ICMP=y
CONFIG_ATM_LANE=m
CONFIG_ATM_MPOA=m
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_VLAN_8021Q=m
CONFIG_LLC=y
# CONFIG_LLC2 is not set
CONFIG_IPX=m
CONFIG_IPX_INTERN=y
CONFIG_ATALK=m
CONFIG_DEV_APPLETALK=y
CONFIG_LTPC=m
CONFIG_COPS=m
CONFIG_COPS_DAYNA=y
CONFIG_COPS_TANGENT=y
CONFIG_IPDDP=m
CONFIG_IPDDP_ENCAP=y
CONFIG_IPDDP_DECAP=y
CONFIG_X25=m
CONFIG_LAPB=m
CONFIG_NET_DIVERT=y
CONFIG_ECONET=m
CONFIG_ECONET_AUNUDP=y
CONFIG_ECONET_NATIVE=y
CONFIG_WAN_ROUTER=m
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_CSZ=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_POLICE=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
CONFIG_ARCNET=m
CONFIG_ARCNET_1201=m
CONFIG_ARCNET_1051=m
CONFIG_ARCNET_RAW=m
CONFIG_ARCNET_COM90xx=m
CONFIG_ARCNET_COM90xxIO=m
CONFIG_ARCNET_RIM_I=m
CONFIG_ARCNET_COM20020=m
CONFIG_ARCNET_COM20020_ISA=m
CONFIG_ARCNET_COM20020_PCI=m
CONFIG_DUMMY=m
CONFIG_BONDING=m
CONFIG_EQUALIZER=m
CONFIG_TUN=m
CONFIG_ETHERTAP=m
CONFIG_NET_SB1000=y

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
CONFIG_HAPPYMEAL=m
CONFIG_SUNGEM=m
CONFIG_NET_VENDOR_3COM=y
CONFIG_EL1=m
CONFIG_EL2=m
CONFIG_ELPLUS=m
CONFIG_EL16=m
CONFIG_EL3=m
CONFIG_3C515=m
CONFIG_VORTEX=m
CONFIG_TYPHOON=m
CONFIG_LANCE=m
CONFIG_NET_VENDOR_SMC=y
CONFIG_WD80x3=m
CONFIG_ULTRA=m
CONFIG_SMC9194=m
CONFIG_NET_VENDOR_RACAL=y
CONFIG_NI52=m
CONFIG_NI65=m

#
# Tulip family network device support
#
CONFIG_NET_TULIP=y
CONFIG_DE2104X=m
CONFIG_TULIP=m
# CONFIG_TULIP_MWI is not set
CONFIG_TULIP_MMIO=y
# CONFIG_TULIP_NAPI is not set
CONFIG_DE4X5=m
CONFIG_WINBOND_840=m
CONFIG_DM9102=m
CONFIG_PCMCIA_XIRCOM=m
CONFIG_AT1700=m
CONFIG_DEPCA=m
CONFIG_HP100=m
CONFIG_NET_ISA=y
CONFIG_E2100=m
CONFIG_EWRK3=m
CONFIG_EEXPRESS=m
CONFIG_EEXPRESS_PRO=m
CONFIG_HPLAN_PLUS=m
CONFIG_HPLAN=m
CONFIG_LP486E=m
CONFIG_ETH16I=m
CONFIG_NE2000=m
CONFIG_ZNET=m
CONFIG_SEEQ8005=m
CONFIG_NET_PCI=y
CONFIG_PCNET32=m
CONFIG_AMD8111_ETH=m
CONFIG_ADAPTEC_STARFIRE=m
CONFIG_ADAPTEC_STARFIRE_NAPI=y
CONFIG_AC3200=m
CONFIG_APRICOT=m
CONFIG_B44=m
CONFIG_FORCEDETH=m
CONFIG_CS89x0=m
CONFIG_DGRS=m
CONFIG_EEPRO100=m
# CONFIG_EEPRO100_PIO is not set
CONFIG_E100=m
# CONFIG_E100_NAPI is not set
CONFIG_FEALNX=m
CONFIG_NATSEMI=m
CONFIG_NE2K_PCI=m
CONFIG_8139CP=m
CONFIG_8139TOO=m
# CONFIG_8139TOO_PIO is not set
CONFIG_8139TOO_TUNE_TWISTER=y
CONFIG_8139TOO_8129=y
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_8139_RXBUF_IDX=2
CONFIG_SIS900=m
CONFIG_EPIC100=m
CONFIG_SUNDANCE=m
# CONFIG_SUNDANCE_MMIO is not set
CONFIG_TLAN=m
CONFIG_VIA_RHINE=m
# CONFIG_VIA_RHINE_MMIO is not set
CONFIG_NET_POCKET=y
CONFIG_ATP=m
CONFIG_DE600=m
CONFIG_DE620=m

#
# Ethernet (1000 Mbit)
#
CONFIG_ACENIC=m
# CONFIG_ACENIC_OMIT_TIGON_I is not set
CONFIG_DL2K=m
CONFIG_E1000=m
# CONFIG_E1000_NAPI is not set
CONFIG_NS83820=m
CONFIG_HAMACHI=m
CONFIG_YELLOWFIN=m
CONFIG_R8169=m
CONFIG_SIS190=m
CONFIG_SK98LIN=m
CONFIG_TIGON3=m

#
# Ethernet (10000 Mbit)
#
CONFIG_IXGB=m
# CONFIG_IXGB_NAPI is not set
CONFIG_FDDI=y
CONFIG_DEFXX=m
CONFIG_SKFP=m
CONFIG_HIPPI=y
CONFIG_ROADRUNNER=m
# CONFIG_ROADRUNNER_LARGE_RINGS is not set
CONFIG_PLIP=m
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
CONFIG_PPPOATM=m
CONFIG_SLIP=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
# CONFIG_SLIP_MODE_SLIP6 is not set

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=y

#
# Obsolete Wireless cards support (pre-802.11)
#
CONFIG_STRIP=m
CONFIG_ARLAN=m
CONFIG_WAVELAN=m
CONFIG_PCMCIA_WAVELAN=m
CONFIG_PCMCIA_NETWAVE=m

#
# Wireless 802.11 Frequency Hopping cards support
#
CONFIG_PCMCIA_RAYCS=m

#
# Wireless 802.11b ISA/PCI cards support
#
CONFIG_AIRO=m
CONFIG_HERMES=m
CONFIG_PLX_HERMES=m
CONFIG_TMD_HERMES=m
CONFIG_PCI_HERMES=m

#
# Wireless 802.11b Pcmcia/Cardbus cards support
#
CONFIG_PCMCIA_HERMES=m
CONFIG_AIRO_CS=m
CONFIG_PCMCIA_ATMEL=m
CONFIG_PCMCIA_WL3501=m
CONFIG_NET_WIRELESS=y

#
# Token Ring devices
#
CONFIG_TR=y
CONFIG_IBMTR=m
CONFIG_IBMOL=m
CONFIG_IBMLS=m
CONFIG_3C359=m
CONFIG_TMS380TR=m
CONFIG_TMSPCI=m
CONFIG_SKISA=m
CONFIG_PROTEON=m
CONFIG_ABYSS=m
CONFIG_SMCTR=m
CONFIG_NET_FC=y
CONFIG_RCPCI=m
CONFIG_SHAPER=m
CONFIG_NETCONSOLE=m

#
# Wan interfaces
#
CONFIG_WAN=y
CONFIG_HOSTESS_SV11=m
CONFIG_COSA=m
CONFIG_DSCC4=m
CONFIG_DSCC4_PCISYNC=y
CONFIG_DSCC4_PCI_RST=y
CONFIG_LANMEDIA=m
CONFIG_SEALEVEL_4021=m
CONFIG_SYNCLINK_SYNCPPP=m
CONFIG_HDLC=m
CONFIG_HDLC_RAW=y
CONFIG_HDLC_RAW_ETH=y
CONFIG_HDLC_CISCO=y
CONFIG_HDLC_FR=y
CONFIG_HDLC_PPP=y
CONFIG_HDLC_X25=y
CONFIG_PCI200SYN=m
CONFIG_WANXL=m
# CONFIG_WANXL_BUILD_FIRMWARE is not set
CONFIG_PC300=m
# CONFIG_PC300_MLPPP is not set
CONFIG_N2=m
CONFIG_C101=m
CONFIG_FARSYNC=m
CONFIG_DLCI=m
CONFIG_DLCI_COUNT=24
CONFIG_DLCI_MAX=8
CONFIG_SDLA=m
CONFIG_WAN_ROUTER_DRIVERS=y
CONFIG_CYCLADES_SYNC=m
CONFIG_CYCLOMX_X25=y
CONFIG_LAPBETHER=m
CONFIG_X25_ASY=m
CONFIG_SBNI=m
CONFIG_SBNI_MULTILINE=y

#
# PCMCIA network device support
#
CONFIG_NET_PCMCIA=y
CONFIG_PCMCIA_3C589=m
CONFIG_PCMCIA_3C574=m
CONFIG_PCMCIA_FMVJ18X=m
CONFIG_PCMCIA_PCNET=m
CONFIG_PCMCIA_NMCLAN=m
CONFIG_PCMCIA_SMC91C92=m
CONFIG_PCMCIA_XIRC2PS=m
CONFIG_PCMCIA_AXNET=m
CONFIG_ARCNET_COM20020_CS=m
CONFIG_PCMCIA_IBMTR=m

#
# ATM drivers
#
CONFIG_ATM_TCP=m
CONFIG_ATM_LANAI=m
CONFIG_ATM_ENI=m
# CONFIG_ATM_ENI_DEBUG is not set
CONFIG_ATM_ENI_TUNE_BURST=y
# CONFIG_ATM_ENI_BURST_TX_16W is not set
CONFIG_ATM_ENI_BURST_TX_8W=y
# CONFIG_ATM_ENI_BURST_TX_4W is not set
# CONFIG_ATM_ENI_BURST_TX_2W is not set
# CONFIG_ATM_ENI_BURST_RX_16W is not set
# CONFIG_ATM_ENI_BURST_RX_8W is not set
CONFIG_ATM_ENI_BURST_RX_4W=y
# CONFIG_ATM_ENI_BURST_RX_2W is not set
CONFIG_ATM_FIRESTREAM=m
CONFIG_ATM_ZATM=m
# CONFIG_ATM_ZATM_DEBUG is not set
CONFIG_ATM_NICSTAR=m
CONFIG_ATM_NICSTAR_USE_SUNI=y
CONFIG_ATM_NICSTAR_USE_IDT77105=y
CONFIG_ATM_IDT77252=m
# CONFIG_ATM_IDT77252_DEBUG is not set
# CONFIG_ATM_IDT77252_RCV_ALL is not set
CONFIG_ATM_IDT77252_USE_SUNI=y
CONFIG_ATM_AMBASSADOR=m
# CONFIG_ATM_AMBASSADOR_DEBUG is not set
CONFIG_ATM_HORIZON=m
# CONFIG_ATM_HORIZON_DEBUG is not set
CONFIG_ATM_IA=m
# CONFIG_ATM_IA_DEBUG is not set
CONFIG_ATM_FORE200E_MAYBE=m
CONFIG_ATM_FORE200E_PCA=y
CONFIG_ATM_FORE200E_PCA_DEFAULT_FW=y
CONFIG_ATM_FORE200E_TX_RETRY=16
CONFIG_ATM_FORE200E_DEBUG=0
CONFIG_ATM_FORE200E=m
CONFIG_ATM_HE=m
CONFIG_ATM_HE_USE_SUNI=y

#
# Amateur Radio support
#
CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
CONFIG_AX25=m
CONFIG_AX25_DAMA_SLAVE=y
CONFIG_NETROM=m
CONFIG_ROSE=m

#
# AX.25 network device drivers
#
CONFIG_BPQETHER=m
CONFIG_SCC=m
CONFIG_SCC_DELAY=y
CONFIG_SCC_TRXECHO=y
CONFIG_BAYCOM_SER_FDX=m
CONFIG_BAYCOM_SER_HDX=m
CONFIG_BAYCOM_PAR=m
CONFIG_BAYCOM_EPP=m
CONFIG_YAM=m

#
# IrDA (infrared) support
#
CONFIG_IRDA=m

#
# IrDA protocols
#
CONFIG_IRLAN=m
CONFIG_IRNET=m
CONFIG_IRCOMM=m
CONFIG_IRDA_ULTRA=y

#
# IrDA options
#
CONFIG_IRDA_CACHE_LAST_LSAP=y
CONFIG_IRDA_FAST_RR=y
CONFIG_IRDA_DEBUG=y

#
# Infrared-port device drivers
#

#
# SIR device drivers
#
CONFIG_IRTTY_SIR=m

#
# Dongle support
#
CONFIG_DONGLE=y
CONFIG_ESI_DONGLE=m
CONFIG_ACTISYS_DONGLE=m
CONFIG_TEKRAM_DONGLE=m

#
# Old SIR device drivers
#
CONFIG_IRPORT_SIR=m

#
# Old Serial dongle support
#
CONFIG_DONGLE_OLD=y
CONFIG_ESI_DONGLE_OLD=m
CONFIG_ACTISYS_DONGLE_OLD=m
CONFIG_TEKRAM_DONGLE_OLD=m
CONFIG_GIRBIL_DONGLE=m
CONFIG_LITELINK_DONGLE=m
CONFIG_MCP2120_DONGLE=m
CONFIG_OLD_BELKIN_DONGLE=m
CONFIG_ACT200L_DONGLE=m
CONFIG_MA600_DONGLE=m

#
# FIR device drivers
#
CONFIG_USB_IRDA=m
CONFIG_NSC_FIR=m
CONFIG_WINBOND_FIR=m
CONFIG_TOSHIBA_FIR=m
CONFIG_SMC_IRCC_FIR=m
CONFIG_ALI_FIR=m
CONFIG_VLSI_FIR=m
CONFIG_VIA_FIR=m

#
# Bluetooth support
#
CONFIG_BT=m
CONFIG_BT_L2CAP=m
CONFIG_BT_SCO=m
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y

#
# Bluetooth device drivers
#
CONFIG_BT_HCIUSB=m
CONFIG_BT_USB_SCO=y
CONFIG_BT_USB_ZERO_PACKET=y
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
# CONFIG_BT_HCIUART_BCSP_TXCRC is not set
CONFIG_BT_HCIDTL1=m
CONFIG_BT_HCIBT3C=m
CONFIG_BT_HCIBLUECARD=m
CONFIG_BT_HCIBTUART=m
CONFIG_BT_HCIVHCI=m
# CONFIG_KGDBOE is not set
CONFIG_NETPOLL=y
# CONFIG_NETPOLL_RX is not set
# CONFIG_NETPOLL_TRAP is not set
CONFIG_NET_POLL_CONTROLLER=y

#
# ISDN subsystem
#
CONFIG_ISDN_BOOL=y

#
# CAPI subsystem
#
CONFIG_ISDN_CAPI=m
# CONFIG_ISDN_DRV_AVMB1_VERBOSE_REASON is not set
CONFIG_ISDN_CAPI_MIDDLEWARE=y
CONFIG_ISDN_CAPI_CAPI20=m
CONFIG_ISDN_CAPI_CAPIFS_BOOL=y
CONFIG_ISDN_CAPI_CAPIFS=m

#
# CAPI hardware drivers
#

#
# Active AVM cards
#
CONFIG_CAPI_AVM=y

#
# Active Eicon DIVA Server cards
#
CONFIG_CAPI_EICON=y
CONFIG_ISDN_DIVAS=m
CONFIG_ISDN_DIVAS_BRIPCI=y
CONFIG_ISDN_DIVAS_PRIPCI=y
CONFIG_ISDN_DIVAS_DIVACAPI=m
CONFIG_ISDN_DIVAS_USERIDI=m
CONFIG_ISDN_DIVAS_MAINT=m

#
# Telephony Support
#
CONFIG_PHONE=m
CONFIG_PHONE_IXJ=m
CONFIG_PHONE_IXJ_PCMCIA=m

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1280
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1024
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_TSDEV=m
CONFIG_INPUT_TSDEV_SCREEN_X=240
CONFIG_INPUT_TSDEV_SCREEN_Y=320
CONFIG_INPUT_EVDEV=m
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
CONFIG_GAMEPORT=m
CONFIG_SOUND_GAMEPORT=m
CONFIG_GAMEPORT_NS558=m
CONFIG_GAMEPORT_L4=m
CONFIG_GAMEPORT_EMU10K1=m
CONFIG_GAMEPORT_VORTEX=m
CONFIG_GAMEPORT_FM801=m
CONFIG_GAMEPORT_CS461x=m
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=m
CONFIG_SERIO_PARKBD=m
CONFIG_SERIO_PCIPS2=m

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_SUNKBD=m
CONFIG_KEYBOARD_XTKBD=m
CONFIG_KEYBOARD_NEWTON=m
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_SERIAL=m
CONFIG_MOUSE_INPORT=m
CONFIG_MOUSE_ATIXL=y
CONFIG_MOUSE_LOGIBM=m
CONFIG_MOUSE_PC110PAD=m
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=m
CONFIG_JOYSTICK_A3D=m
CONFIG_JOYSTICK_ADI=m
CONFIG_JOYSTICK_COBRA=m
CONFIG_JOYSTICK_GF2K=m
CONFIG_JOYSTICK_GRIP=m
CONFIG_JOYSTICK_GRIP_MP=m
CONFIG_JOYSTICK_GUILLEMOT=m
CONFIG_JOYSTICK_INTERACT=m
CONFIG_JOYSTICK_SIDEWINDER=m
CONFIG_JOYSTICK_TMDC=m
CONFIG_JOYSTICK_IFORCE=m
CONFIG_JOYSTICK_IFORCE_USB=y
CONFIG_JOYSTICK_IFORCE_232=y
CONFIG_JOYSTICK_WARRIOR=m
CONFIG_JOYSTICK_MAGELLAN=m
CONFIG_JOYSTICK_SPACEORB=m
CONFIG_JOYSTICK_SPACEBALL=m
CONFIG_JOYSTICK_STINGER=m
CONFIG_JOYSTICK_TWIDDLER=m
CONFIG_JOYSTICK_DB9=m
CONFIG_JOYSTICK_GAMECON=m
CONFIG_JOYSTICK_TURBOGRAFX=m
CONFIG_INPUT_JOYDUMP=m
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_GUNZE=m
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=m
CONFIG_INPUT_UINPUT=m

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=m
CONFIG_SERIAL_8250_CS=m
CONFIG_SERIAL_8250_ACPI=y
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=m
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=m
CONFIG_TIPAR=m

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_CHARDEV=m

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCF=m

#
# I2C Hardware Bus support
#
CONFIG_I2C_ALI1535=m
CONFIG_I2C_ALI15X3=m
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD8111=m
CONFIG_I2C_ELV=m
CONFIG_I2C_I801=m
CONFIG_I2C_I810=m
CONFIG_I2C_ISA=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_PHILIPSPAR=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_PROSAVAGE=m
CONFIG_I2C_SAVAGE4=m
CONFIG_SCx200_ACB=m
CONFIG_I2C_SIS5595=m
CONFIG_I2C_SIS630=m
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VELLEMAN=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m
CONFIG_I2C_VOODOO3=m

#
# I2C Hardware Sensors Chip support
#
CONFIG_I2C_SENSOR=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_EEPROM=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_W83781D=m

#
# Mice
#
CONFIG_BUSMOUSE=m
CONFIG_QIC02_TAPE=m
CONFIG_QIC02_DYNCONF=y

#
# Setting runtime QIC-02 configuration is done with qic02conf
#

#
# from the tpqic02-support package.  It is available at
#

#
# metalab.unc.edu or ftp://titus.cfw.com/pub/Linux/util/
#

#
# IPMI
#
CONFIG_IPMI_HANDLER=m
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_KCS=m
CONFIG_IPMI_WATCHDOG=m

#
# Watchdog Cards
#
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_NOWAYOUT=y
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDT=m
CONFIG_WDT_501=y
CONFIG_WDT_501_FAN=y
CONFIG_WDTPCI=m
# CONFIG_WDT_501_PCI is not set
CONFIG_PCWATCHDOG=m
CONFIG_ACQUIRE_WDT=m
CONFIG_ADVANTECH_WDT=m
CONFIG_EUROTECH_WDT=m
CONFIG_IB700_WDT=m
CONFIG_I810_TCO=m
CONFIG_MIXCOMWD=m
CONFIG_SCx200_WDT=m
CONFIG_60XX_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_MACHZ_WDT=m
CONFIG_SC520_WDT=m
CONFIG_AMD7XX_TCO=m
CONFIG_ALIM7101_WDT=m
CONFIG_ALIM1535_WDT=m
CONFIG_SC1200_WDT=m
CONFIG_WAFER_WDT=m
CONFIG_CPU5_WDT=m
CONFIG_HW_RANDOM=m
CONFIG_NVRAM=m
CONFIG_RTC=m
CONFIG_GEN_RTC=m
CONFIG_GEN_RTC_X=y
CONFIG_DTLK=m
CONFIG_R3964=m
CONFIG_APPLICOM=m
CONFIG_SONYPI=m

#
# Ftape, the floppy tape device driver
#
CONFIG_AGP=m
CONFIG_AGP_ALI=m
CONFIG_AGP_ATI=m
CONFIG_AGP_AMD=m
CONFIG_AGP_AMD64=m
CONFIG_AGP_INTEL=m
CONFIG_AGP_NVIDIA=m
CONFIG_AGP_SIS=m
CONFIG_AGP_SWORKS=m
CONFIG_AGP_VIA=m
CONFIG_DRM=y
CONFIG_DRM_TDFX=m
CONFIG_DRM_GAMMA=m
CONFIG_DRM_R128=m
CONFIG_DRM_RADEON=m
CONFIG_DRM_I810=m
CONFIG_DRM_I830=m
CONFIG_DRM_MGA=m
CONFIG_DRM_SIS=m

#
# PCMCIA character devices
#
CONFIG_SYNCLINK_CS=m
CONFIG_MWAVE=m
CONFIG_RAW_DRIVER=m
CONFIG_MAX_RAW_DEVS=256
CONFIG_HANGCHECK_TIMER=m

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m

#
# Video For Linux
#

#
# Video Adapters
#
CONFIG_VIDEO_BT848=m
CONFIG_VIDEO_PMS=m
CONFIG_VIDEO_BWQCAM=m
CONFIG_VIDEO_CQCAM=m
CONFIG_VIDEO_W9966=m
CONFIG_VIDEO_CPIA=m
CONFIG_VIDEO_CPIA_PP=m
CONFIG_VIDEO_CPIA_USB=m
CONFIG_VIDEO_SAA5249=m
CONFIG_TUNER_3036=m
CONFIG_VIDEO_STRADIS=m
CONFIG_VIDEO_ZORAN=m
CONFIG_VIDEO_ZORAN_BUZ=m
CONFIG_VIDEO_ZORAN_DC10=m
CONFIG_VIDEO_ZORAN_DC30=m
CONFIG_VIDEO_ZORAN_LML33=m
CONFIG_VIDEO_ZORAN_LML33R10=m
CONFIG_VIDEO_MEYE=m
CONFIG_VIDEO_SAA7134=m
CONFIG_VIDEO_MXB=m
CONFIG_VIDEO_DPC=m
CONFIG_VIDEO_HEXIUM_ORION=m
CONFIG_VIDEO_HEXIUM_GEMINI=m

#
# Radio Adapters
#
CONFIG_RADIO_CADET=m
CONFIG_RADIO_RTRACK=m
CONFIG_RADIO_RTRACK2=m
CONFIG_RADIO_AZTECH=m
CONFIG_RADIO_GEMTEK=m
CONFIG_RADIO_GEMTEK_PCI=m
CONFIG_RADIO_MAXIRADIO=m
CONFIG_RADIO_MAESTRO=m
# CONFIG_RADIO_MIROPCM20 is not set
CONFIG_RADIO_SF16FMI=m
CONFIG_RADIO_TERRATEC=m
CONFIG_RADIO_TRUST=m
CONFIG_RADIO_TYPHOON=m
CONFIG_RADIO_TYPHOON_PROC_FS=y
CONFIG_RADIO_ZOLTRIX=m

#
# Digital Video Broadcasting Devices
#
CONFIG_DVB=y
CONFIG_DVB_CORE=m

#
# Supported Frontend Modules
#
CONFIG_DVB_TWINHAN_DST=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_SP887X_FIRMWARE_FILE="/etc/dvb/sc_main.mc"
CONFIG_DVB_ALPS_TDLB7=m
CONFIG_DVB_ALPS_TDMB7=m
CONFIG_DVB_ATMEL_AT76C651=m
CONFIG_DVB_CX24110=m
CONFIG_DVB_GRUNDIG_29504_491=m
CONFIG_DVB_GRUNDIG_29504_401=m
CONFIG_DVB_MT312=m
CONFIG_DVB_VES1820=m
CONFIG_DVB_VES1X93=m

#
# Supported SAA7146 based PCI Adapters
#
CONFIG_DVB_AV7110=m
CONFIG_DVB_AV7110_OSD=y
CONFIG_DVB_BUDGET=m
CONFIG_DVB_BUDGET_CI=m
CONFIG_DVB_BUDGET_AV=m
CONFIG_DVB_BUDGET_PATCH=m

#
# Supported USB Adapters
#
CONFIG_DVB_TTUSB_BUDGET=m
CONFIG_DVB_TTUSB_DEC=m

#
# Supported FlexCopII (B2C2) Adapters
#
CONFIG_DVB_B2C2_SKYSTAR=m

#
# Supported BT878 Adapters
#
CONFIG_DVB_BT8XX=m
CONFIG_VIDEO_SAA7146=m
CONFIG_VIDEO_SAA7146_VV=m
CONFIG_VIDEO_VIDEOBUF=m
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEO_BUF=m
CONFIG_VIDEO_BTCX=m

#
# Graphics support
#
CONFIG_FB=y
CONFIG_FB_CYBER2000=m
# CONFIG_FB_IMSTT is not set
CONFIG_FB_VGA16=m
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_HGA=m
CONFIG_FB_RIVA=m
CONFIG_FB_I810=m
# CONFIG_FB_I810_GTF is not set
CONFIG_FB_MATROX=m
CONFIG_FB_MATROX_MILLENIUM=y
CONFIG_FB_MATROX_MYSTIQUE=y
CONFIG_FB_MATROX_G450=y
CONFIG_FB_MATROX_G100=y
CONFIG_FB_MATROX_I2C=m
CONFIG_FB_MATROX_MAVEN=m
CONFIG_FB_MATROX_MULTIHEAD=y
CONFIG_FB_RADEON=m
CONFIG_FB_ATY128=m
CONFIG_FB_ATY=m
CONFIG_FB_ATY_CT=y
CONFIG_FB_ATY_GX=y
CONFIG_FB_ATY_XL_INIT=y
CONFIG_FB_SIS=m
CONFIG_FB_SIS_300=y
CONFIG_FB_SIS_315=y
CONFIG_FB_NEOMAGIC=m
CONFIG_FB_3DFX=m
CONFIG_FB_VOODOO1=m
CONFIG_FB_TRIDENT=m
CONFIG_FB_VIRTUAL=m

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_MDA_CONSOLE=m
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=m
CONFIG_PCI_CONSOLE=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Logo configuration
#
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_SEQUENCER=m
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_DUMMY=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
CONFIG_SND_SERIAL_U16550=m
CONFIG_SND_MPU401=m

#
# ISA devices
#
CONFIG_SND_AD1816A=m
CONFIG_SND_AD1848=m
CONFIG_SND_CS4231=m
CONFIG_SND_CS4232=m
CONFIG_SND_CS4236=m
CONFIG_SND_ES968=m
CONFIG_SND_ES1688=m
CONFIG_SND_ES18XX=m
CONFIG_SND_GUSCLASSIC=m
CONFIG_SND_GUSEXTREME=m
CONFIG_SND_GUSMAX=m
CONFIG_SND_INTERWAVE=m
CONFIG_SND_INTERWAVE_STB=m
CONFIG_SND_OPTI92X_AD1848=m
CONFIG_SND_OPTI92X_CS4231=m
CONFIG_SND_OPTI93X=m
CONFIG_SND_SB8=m
CONFIG_SND_SB16=m
CONFIG_SND_SBAWE=m
CONFIG_SND_SB16_CSP=y
CONFIG_SND_WAVEFRONT=m
CONFIG_SND_ALS100=m
CONFIG_SND_AZT2320=m
CONFIG_SND_CMI8330=m
CONFIG_SND_DT019X=m
CONFIG_SND_OPL3SA2=m
CONFIG_SND_SGALAXY=m
CONFIG_SND_SSCAPE=m

#
# PCI devices
#
CONFIG_SND_ALI5451=m
CONFIG_SND_AZT3328=m
CONFIG_SND_CS46XX=m
CONFIG_SND_CS46XX_NEW_DSP=y
CONFIG_SND_CS4281=m
CONFIG_SND_EMU10K1=m
CONFIG_SND_KORG1212=m
CONFIG_SND_NM256=m
CONFIG_SND_RME32=m
CONFIG_SND_RME96=m
CONFIG_SND_RME9652=m
CONFIG_SND_HDSP=m
CONFIG_SND_TRIDENT=m
CONFIG_SND_YMFPCI=m
CONFIG_SND_ALS4000=m
CONFIG_SND_CMIPCI=m
CONFIG_SND_ENS1370=m
CONFIG_SND_ENS1371=m
CONFIG_SND_ES1938=m
CONFIG_SND_ES1968=m
CONFIG_SND_MAESTRO3=m
CONFIG_SND_FM801=m
CONFIG_SND_ICE1712=m
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_SONICVIBES=m
CONFIG_SND_VIA82XX=m
CONFIG_SND_VX222=m

#
# ALSA USB devices
#
CONFIG_SND_USB_AUDIO=m

#
# PCMCIA devices
#
CONFIG_SND_VXPOCKET=m
CONFIG_SND_VXP440=m

#
# Open Sound System
#
CONFIG_SOUND_PRIME=m
CONFIG_SOUND_BT878=m
CONFIG_SOUND_CMPCI=m
CONFIG_SOUND_CMPCI_FM=y
CONFIG_SOUND_CMPCI_FMIO=0x388
CONFIG_SOUND_CMPCI_MIDI=y
CONFIG_SOUND_CMPCI_MPUIO=0x330
CONFIG_SOUND_CMPCI_JOYSTICK=y
CONFIG_SOUND_CMPCI_CM8738=y
# CONFIG_SOUND_CMPCI_SPDIFINVERSE is not set
# CONFIG_SOUND_CMPCI_SPDIFLOOP is not set
CONFIG_SOUND_CMPCI_SPEAKERS=2
CONFIG_SOUND_EMU10K1=m
CONFIG_MIDI_EMU10K1=y
CONFIG_SOUND_FUSION=m
CONFIG_SOUND_CS4281=m
CONFIG_SOUND_ES1370=m
CONFIG_SOUND_ES1371=m
CONFIG_SOUND_ESSSOLO1=m
CONFIG_SOUND_MAESTRO=m
CONFIG_SOUND_MAESTRO3=m
CONFIG_SOUND_ICH=m
CONFIG_SOUND_SONICVIBES=m
CONFIG_SOUND_TRIDENT=m
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
CONFIG_SOUND_VIA82CXXX=m
CONFIG_MIDI_VIA82CXXX=y
CONFIG_SOUND_OSS=m
# CONFIG_SOUND_TRACEINIT is not set
# CONFIG_SOUND_DMAP is not set
CONFIG_SOUND_AD1816=m
CONFIG_SOUND_AD1889=m
CONFIG_SOUND_SGALAXY=m
CONFIG_SOUND_ADLIB=m
CONFIG_SOUND_ACI_MIXER=m
CONFIG_SOUND_CS4232=m
CONFIG_SOUND_SSCAPE=m
CONFIG_SOUND_GUS=m
CONFIG_SOUND_GUS16=y
CONFIG_SOUND_GUSMAX=y
CONFIG_SOUND_VMIDI=m
CONFIG_SOUND_TRIX=m
CONFIG_SOUND_MSS=m
CONFIG_SOUND_MPU401=m
CONFIG_SOUND_NM256=m
CONFIG_SOUND_MAD16=m
CONFIG_MAD16_OLDCARD=y
CONFIG_SOUND_PAS=m
CONFIG_SOUND_PSS=m
CONFIG_PSS_MIXER=y
CONFIG_SOUND_SB=m
CONFIG_SOUND_AWE32_SYNTH=m
CONFIG_SOUND_WAVEFRONT=m
# CONFIG_SOUND_MAUI is not set
CONFIG_SOUND_YM3812=m
CONFIG_SOUND_OPL3SA1=m
CONFIG_SOUND_OPL3SA2=m
CONFIG_SOUND_YMFPCI=m
CONFIG_SOUND_YMFPCI_LEGACY=y
CONFIG_SOUND_UART6850=m
CONFIG_SOUND_AEDSP16=m
CONFIG_SC6600=y
CONFIG_SC6600_JOY=y
CONFIG_SC6600_CDROM=4
CONFIG_SC6600_CDROMBASE=0x0
# CONFIG_AEDSP16_MSS is not set
# CONFIG_AEDSP16_SBPRO is not set
CONFIG_AEDSP16_MPU401=y
CONFIG_SOUND_TVMIXER=m
CONFIG_SOUND_KAHLUA=m
CONFIG_SOUND_ALI5455=m
CONFIG_SOUND_FORTE=m
CONFIG_SOUND_RME96XX=m
CONFIG_SOUND_AD1980=m

#
# USB support
#
CONFIG_USB=m
CONFIG_USB_DEBUG=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
CONFIG_USB_DYNAMIC_MINORS=y

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_UHCI_HCD=m

#
# USB Device Class drivers
#
CONFIG_USB_AUDIO=m

#
# USB Bluetooth TTY can only be used with disabled Bluetooth subsystem
#
CONFIG_USB_MIDI=m
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_DEBUG=y
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_HP8200e=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_HID_FF=y
CONFIG_HID_PID=y
CONFIG_LOGITECH_FF=y
CONFIG_THRUSTMASTER_FF=y
CONFIG_USB_HIDDEV=y

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=m
CONFIG_USB_MOUSE=m
CONFIG_USB_AIPTEK=m
CONFIG_USB_WACOM=m
CONFIG_USB_KBTAB=m
CONFIG_USB_POWERMATE=m
CONFIG_USB_XPAD=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_SCANNER=m
CONFIG_USB_MICROTEK=m
CONFIG_USB_HPUSBSCSI=m

#
# USB Multimedia devices
#
CONFIG_USB_DABUSB=m
CONFIG_USB_VICAM=m
CONFIG_USB_DSBR=m
CONFIG_USB_IBMCAM=m
CONFIG_USB_KONICAWC=m
CONFIG_USB_OV511=m
CONFIG_USB_PWC=m
CONFIG_USB_SE401=m
CONFIG_USB_STV680=m
CONFIG_USB_W9968CF=m

#
# USB Network adaptors
#
CONFIG_USB_CATC=m
CONFIG_USB_KAWETH=m
CONFIG_USB_PEGASUS=m
CONFIG_USB_RTL8150=m
CONFIG_USB_USBNET=m

#
# USB Host-to-Host Cables
#
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_GENESYS=y
CONFIG_USB_NET1080=y
CONFIG_USB_PL2301=y

#
# Intelligent USB Devices/Gadgets
#
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_ZAURUS=y
CONFIG_USB_CDCETHER=y

#
# USB Network Adapters
#
CONFIG_USB_AX8817X=y

#
# USB port drivers
#
CONFIG_USB_USS720=m

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KEYSPAN_MPR=y
CONFIG_USB_SERIAL_KEYSPAN_USA28=y
CONFIG_USB_SERIAL_KEYSPAN_USA28X=y
CONFIG_USB_SERIAL_KEYSPAN_USA28XA=y
CONFIG_USB_SERIAL_KEYSPAN_USA28XB=y
CONFIG_USB_SERIAL_KEYSPAN_USA19=y
CONFIG_USB_SERIAL_KEYSPAN_USA18X=y
CONFIG_USB_SERIAL_KEYSPAN_USA19W=y
CONFIG_USB_SERIAL_KEYSPAN_USA19QW=y
CONFIG_USB_SERIAL_KEYSPAN_USA19QI=y
CONFIG_USB_SERIAL_KEYSPAN_USA49W=y
CONFIG_USB_SERIAL_KEYSPAN_USA49WLC=y
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_EZUSB=y

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI26=m
CONFIG_USB_TIGL=m
CONFIG_USB_AUERSWALD=m
CONFIG_USB_RIO500=m
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_BRLVGER=m
CONFIG_USB_LCD=m
CONFIG_USB_SPEEDTOUCH=m
CONFIG_USB_TEST=m
CONFIG_USB_GADGET=m
CONFIG_USB_NET2280=m
CONFIG_USB_ZERO=m
CONFIG_USB_ZERO_NET2280=y
CONFIG_USB_ETH=m
CONFIG_USB_ETH_NET2280=y
CONFIG_USB_GADGETFS=m
CONFIG_USB_GADGETFS_NET2280=y

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
# CONFIG_EXT2_FS_SECURITY is not set
CONFIG_EXT3_FS=m
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=m
CONFIG_JBD_DEBUG=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_JFS_FS=m
CONFIG_JFS_POSIX_ACL=y
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_XFS_FS=m
CONFIG_XFS_RT=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_MINIX_FS=m
CONFIG_ROMFS_FS=m
CONFIG_QUOTA=y
CONFIG_QFMT_V1=m
CONFIG_QFMT_V2=m
CONFIG_QUOTACTL=y
CONFIG_AUTOFS_FS=m
CONFIG_AUTOFS4_FS=m

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_UDF_FS=m

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_NTFS_FS=m
CONFIG_NTFS_DEBUG=y
CONFIG_NTFS_RW=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
CONFIG_ADFS_FS=m
CONFIG_ADFS_FS_RW=y
CONFIG_AFFS_FS=m
CONFIG_HFS_FS=m
CONFIG_BEFS_FS=m
# CONFIG_BEFS_DEBUG is not set
CONFIG_BFS_FS=m
CONFIG_EFS_FS=m
CONFIG_JFFS_FS=m
CONFIG_JFFS_FS_VERBOSE=0
CONFIG_JFFS2_FS=m
CONFIG_JFFS2_FS_DEBUG=0
# CONFIG_JFFS2_FS_NAND is not set
CONFIG_CRAMFS=y
CONFIG_VXFS_FS=m
CONFIG_HPFS_FS=m
CONFIG_QNX4FS_FS=m
CONFIG_QNX4FS_RW=y
CONFIG_SYSV_FS=m
CONFIG_UFS_FS=m
CONFIG_UFS_FS_WRITE=y

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFS_V4=y
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=m
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp850"
CONFIG_CIFS=m
CONFIG_NCP_FS=m
CONFIG_NCPFS_PACKET_SIGNING=y
CONFIG_NCPFS_IOCTL_LOCKING=y
CONFIG_NCPFS_STRONG=y
CONFIG_NCPFS_NFS_NS=y
CONFIG_NCPFS_OS2_NS=y
CONFIG_NCPFS_SMALLDOS=y
CONFIG_NCPFS_NLS=y
CONFIG_NCPFS_EXTRAS=y
CONFIG_CODA_FS=m
# CONFIG_CODA_FS_OLD_API is not set
CONFIG_INTERMEZZO_FS=m
CONFIG_AFS_FS=m
CONFIG_RXRPC=m

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
CONFIG_ACORN_PARTITION=y
CONFIG_ACORN_PARTITION_CUMANA=y
CONFIG_ACORN_PARTITION_EESOX=y
CONFIG_ACORN_PARTITION_ICS=y
CONFIG_ACORN_PARTITION_ADFS=y
CONFIG_ACORN_PARTITION_POWERTEC=y
CONFIG_ACORN_PARTITION_RISCIX=y
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
CONFIG_ATARI_PARTITION=y
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
CONFIG_LDM_PARTITION=y
# CONFIG_LDM_DEBUG is not set
CONFIG_NEC98_PARTITION=y
CONFIG_SGI_PARTITION=y
CONFIG_ULTRIX_PARTITION=y
CONFIG_SUN_PARTITION=y
CONFIG_EFI_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-15"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=m
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=m

#
# Profiling support
#
CONFIG_PROFILING=y
CONFIG_OPROFILE=m

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_IOVIRT=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_SPINLINE is not set
# CONFIG_DEBUG_HIGHMEM is not set
# CONFIG_DEBUG_INFO is not set
# CONFIG_LOCKMETER is not set
CONFIG_DEBUG_SPINLOCK_SLEEP=y
# CONFIG_KGDB is not set
CONFIG_FRAME_POINTER=y
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
CONFIG_SECURITY=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_CAPABILITIES=m
CONFIG_SECURITY_ROOTPLUG=m
# CONFIG_SECURITY_SELINUX is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_TEST=m

#
# Library routines
#
CONFIG_CRC32=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y
CONFIG_PC=y






-- 
Jens Benecke
