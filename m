Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265728AbUADPTh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 10:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265726AbUADPTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 10:19:37 -0500
Received: from hauptpostamt.charite.de ([193.175.66.220]:60852 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S265729AbUADPTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 10:19:24 -0500
Date: Sun, 4 Jan 2004 16:19:16 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: ACPI errors / FB problems with 2.6.1-rc1-bk4
Message-ID: <20040104151916.GC27197@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a Toshiba Tecra 8000.
dmesg/kernel.log output is below.

There are serveral problems:

a) I get these ACPI errors.

Jan  4 15:55:00 hummus kernel:     ACPI-0109: *** Error: No object was returned from [\_SB_.LNKA._STA] (Node cbfee840), AE_NOT_EXIST
Jan  4 15:55:00 hummus kernel:     ACPI-0109: *** Error: No object was returned from [\_SB_.LNKB._STA] (Node cbfee940), AE_NOT_EXIST
Jan  4 15:55:00 hummus kernel:     ACPI-0109: *** Error: No object was returned from [\_SB_.LNKC._STA] (Node cbfdd5c0), AE_NOT_EXIST
Jan  4 15:55:00 hummus kernel:     ACPI-0109: *** Error: No object was returned from [\_SB_.LNKD._STA] (Node cbfdd4c0), AE_NOT_EXIST
Jan  4 15:55:00 hummus kernel:     ACPI-0109: *** Error: No object was returned from [\_SB_.PCI0.FNC0.FDD_._STA] (Node cbf45220), AE_NOT_EXIST
Jan  4 15:55:00 hummus kernel:     ACPI-0109: *** Error: No object was returned from [\_SB_.PCI0.FNC0.COM_._STA] (Node cbf45f00), AE_NOT_EXIST
Jan  4 15:55:00 hummus kernel:     ACPI-0109: *** Error: No object was returned from [\_SB_.PCI0.FNC0.PRT_._STA] (Node cbf45d80), AE_NOT_EXIST
Jan  4 15:55:00 hummus kernel:     ACPI-0109: *** Error: No object was returned from [\_SB_.PCI0.FNC0.PRT1._STA] (Node cbf45ca0), AE_NOT_EXIST
Jan  4 15:55:00 hummus kernel:     ACPI-0109: *** Error: No object was returned from [\_SB_.PCI0.FNC0.PCC0._STA] (Node cbf45ba0), AE_NOT_EXIST
Jan  4 15:55:00 hummus kernel:     ACPI-0109: *** Error: No object was returned from [\_SB_.PCI0.FNC0.SND_._STA] (Node cbf45960), AE_NOT_EXIST
Jan  4 15:55:00 hummus kernel:     ACPI-0109: *** Error: No object was returned from [\_SB_.PCI0.FNC0.ATA_._STA] (Node cbf44800), AE_NOT_EXIST
Jan  4 15:55:00 hummus kernel:     ACPI-0109: *** Error: No object was returned from [\_SB_.PCI0.FNC0.MDM_._STA] (Node cbf44720), AE_NOT_EXIST

b) The Framebuffer doesn't set the mode correctly when switching back
   from X11. I can always fix this using "fbset -depth 16" which
   restores the display. Screenshots available at request.
   The FB works flawlessly undert 2.4.23 et al.

--- snip ---

Jan  4 15:54:59 hummus kernel: Linux version 2.6.1-bk4 (root@hummus) (gcc version 3.3.3 20031229 (prerelease) (Debian)) #1 Sun Jan 4 13:38:32 CET 2004
Jan  4 15:54:59 hummus kernel: BIOS-provided physical RAM map:
Jan  4 15:54:59 hummus kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Jan  4 15:54:59 hummus kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Jan  4 15:54:59 hummus kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Jan  4 15:54:59 hummus kernel:  BIOS-e820: 0000000000100000 - 000000000bff0000 (usable)
Jan  4 15:54:59 hummus kernel:  BIOS-e820: 000000000bff0000 - 000000000c000000 (ACPI data)
Jan  4 15:54:59 hummus kernel:  BIOS-e820: 00000000100a0000 - 00000000100b6e00 (reserved)
Jan  4 15:54:59 hummus kernel:  BIOS-e820: 00000000100b6e00 - 00000000100b7000 (ACPI NVS)
Jan  4 15:54:59 hummus kernel:  BIOS-e820: 00000000100b7000 - 0000000010100000 (reserved)
Jan  4 15:54:59 hummus kernel:  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
Jan  4 15:54:59 hummus kernel: 191MB LOWMEM available.
Jan  4 15:54:59 hummus kernel: On node 0 totalpages: 49136
Jan  4 15:54:59 hummus kernel:   DMA zone: 4096 pages, LIFO batch:1
Jan  4 15:54:59 hummus kernel:   Normal zone: 45040 pages, LIFO batch:10
Jan  4 15:54:59 hummus kernel:   HighMem zone: 0 pages, LIFO batch:1
Jan  4 15:54:59 hummus kernel: DMI not present.
Jan  4 15:54:59 hummus kernel: ACPI: RSDP (v000 TOSHIB                                    ) @ 0x000f1130
Jan  4 15:54:59 hummus kernel: ACPI: RSDT (v001 TOSHIB 750      0x00970814 TASM 0x04010000) @ 0x0bff0000
Jan  4 15:54:59 hummus kernel: ACPI: FADT (v001 TOSHIB 750      0x00970814 TASM 0x04010000) @ 0x0bff0054
Jan  4 15:54:59 hummus kernel: ACPI: DSDT (v001 TOSHIB 8000     0x19991112 MSFT 0x0100000a) @ 0x00000000
Jan  4 15:54:59 hummus kernel: Building zonelist for node : 0
Jan  4 15:54:59 hummus kernel: Kernel command line: BOOT_IMAGE=Linux ro root=302 video=neofb:ywrap,depth:16
Jan  4 15:54:59 hummus kernel: Initializing CPU#0
Jan  4 15:54:59 hummus kernel: PID hash table entries: 1024 (order 10: 8192 bytes)
Jan  4 15:54:59 hummus kernel: Detected 299.998 MHz processor.
Jan  4 15:54:59 hummus kernel: Using tsc for high-res timesource
Jan  4 15:54:59 hummus kernel: Console: colour dummy device 80x25
Jan  4 15:54:59 hummus kernel: Memory: 191236k/196544k available (1689k kernel code, 4672k reserved, 718k data, 140k init, 0k highmem)
Jan  4 15:54:59 hummus kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Jan  4 15:54:59 hummus kernel: Calibrating delay loop... 589.82 BogoMIPS
Jan  4 15:54:59 hummus kernel: Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Jan  4 15:54:59 hummus kernel: Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Jan  4 15:54:59 hummus kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Jan  4 15:54:59 hummus kernel: CPU:     After generic identify, caps: 0183f9ff 00000000 00000000 00000000
Jan  4 15:54:59 hummus kernel: CPU:     After vendor identify, caps: 0183f9ff 00000000 00000000 00000000
Jan  4 15:54:59 hummus kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Jan  4 15:54:59 hummus kernel: CPU: L2 cache: 512K
Jan  4 15:54:59 hummus kernel: CPU:     After all inits, caps: 0183f9ff 00000000 00000000 00000040
Jan  4 15:54:59 hummus kernel: Intel machine check architecture supported.
Jan  4 15:54:59 hummus kernel: Intel machine check reporting enabled on CPU#0.
Jan  4 15:54:59 hummus kernel: CPU: Intel Pentium II (Deschutes) stepping 02
Jan  4 15:54:59 hummus kernel: Enabling fast FPU save and restore... done.
Jan  4 15:54:59 hummus kernel: Checking 'hlt' instruction... OK.
Jan  4 15:54:59 hummus kernel: POSIX conformance testing by UNIFIX
Jan  4 15:54:59 hummus kernel: NET: Registered protocol family 16
Jan  4 15:54:59 hummus kernel: PCI: Using configuration type 1
Jan  4 15:54:59 hummus input.agent[350]: ... no modules for INPUT product 3/46d/c00c/2110
Jan  4 15:54:59 hummus kernel: Loaded 22697 symbols from /boot/System.map-2.6.1-bk4.
Jan  4 15:54:59 hummus kernel: Symbols match kernel version 2.6.1.
Jan  4 15:54:59 hummus kernel: No module symbols loaded - kernel modules not enabled. 
Jan  4 15:54:59 hummus kernel: Linux version 2.6.1-bk4 (root@hummus) (gcc version 3.3.3 20031229 (prerelease) (Debian)) #1 Sun Jan 4 13:38:32 CET 2004
Jan  4 15:54:59 hummus kernel: BIOS-provided physical RAM map:
Jan  4 15:54:59 hummus kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Jan  4 15:54:59 hummus kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Jan  4 15:54:59 hummus kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Jan  4 15:54:59 hummus kernel:  BIOS-e820: 0000000000100000 - 000000000bff0000 (usable)
Jan  4 15:54:59 hummus kernel:  BIOS-e820: 000000000bff0000 - 000000000c000000 (ACPI data)
Jan  4 15:54:59 hummus kernel:  BIOS-e820: 00000000100a0000 - 00000000100b6e00 (reserved)
Jan  4 15:54:59 hummus kernel:  BIOS-e820: 00000000100b6e00 - 00000000100b7000 (ACPI NVS)
Jan  4 15:54:59 hummus kernel:  BIOS-e820: 00000000100b7000 - 0000000010100000 (reserved)
Jan  4 15:54:59 hummus kernel:  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
Jan  4 15:54:59 hummus kernel: 191MB LOWMEM available.
Jan  4 15:54:59 hummus kernel: On node 0 totalpages: 49136
Jan  4 15:54:59 hummus kernel:   DMA zone: 4096 pages, LIFO batch:1
Jan  4 15:54:59 hummus kernel:   Normal zone: 45040 pages, LIFO batch:10
Jan  4 15:54:59 hummus kernel:   HighMem zone: 0 pages, LIFO batch:1
Jan  4 15:54:59 hummus kernel: DMI not present.
Jan  4 15:54:59 hummus kernel: ACPI: RSDP (v000 TOSHIB                                    ) @ 0x000f1130
Jan  4 15:54:59 hummus kernel: ACPI: RSDT (v001 TOSHIB 750      0x00970814 TASM 0x04010000) @ 0x0bff0000
Jan  4 15:54:59 hummus kernel: ACPI: FADT (v001 TOSHIB 750      0x00970814 TASM 0x04010000) @ 0x0bff0054
Jan  4 15:54:59 hummus kernel: ACPI: DSDT (v001 TOSHIB 8000     0x19991112 MSFT 0x0100000a) @ 0x00000000
Jan  4 15:54:59 hummus kernel: Building zonelist for node : 0
Jan  4 15:54:59 hummus kernel: Kernel command line: BOOT_IMAGE=Linux ro root=302 video=neofb:ywrap,depth:16
Jan  4 15:54:59 hummus kernel: Initializing CPU#0
Jan  4 15:54:59 hummus kernel: PID hash table entries: 1024 (order 10: 8192 bytes)
Jan  4 15:54:59 hummus kernel: Detected 299.998 MHz processor.
Jan  4 15:54:59 hummus kernel: Using tsc for high-res timesource
Jan  4 15:54:59 hummus kernel: Console: colour dummy device 80x25
Jan  4 15:54:59 hummus kernel: Memory: 191236k/196544k available (1689k kernel code, 4672k reserved, 718k data, 140k init, 0k highmem)
Jan  4 15:54:59 hummus kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Jan  4 15:54:59 hummus kernel: Calibrating delay loop... 589.82 BogoMIPS
Jan  4 15:54:59 hummus kernel: Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Jan  4 15:54:59 hummus kernel: Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Jan  4 15:54:59 hummus kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Jan  4 15:54:59 hummus kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Jan  4 15:54:59 hummus kernel: CPU: L2 cache: 512K
Jan  4 15:54:59 hummus kernel: Intel machine check architecture supported.
Jan  4 15:54:59 hummus kernel: Intel machine check reporting enabled on CPU#0.
Jan  4 15:54:59 hummus kernel: CPU: Intel Pentium II (Deschutes) stepping 02
Jan  4 15:54:59 hummus kernel: Enabling fast FPU save and restore... done.
Jan  4 15:54:59 hummus kernel: Checking 'hlt' instruction... OK.
Jan  4 15:54:59 hummus kernel: POSIX conformance testing by UNIFIX
Jan  4 15:54:59 hummus kernel: NET: Registered protocol family 16
Jan  4 15:54:59 hummus kernel: PCI: Using configuration type 1
Jan  4 15:54:59 hummus input.agent[350]: ... no modules for INPUT product 3/46d/c00c/2110
Jan  4 15:55:00 hummus kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Jan  4 15:55:00 hummus kernel: pnp: the driver 'system' has been registered
Jan  4 15:55:00 hummus kernel: pnp: match found with the PnP device '00:01' and the driver 'system'
Jan  4 15:55:00 hummus kernel: pnp: match found with the PnP device '00:0a' and the driver 'system'
Jan  4 15:55:00 hummus kernel: pnp: the driver 'serial' has been registered
Jan  4 15:55:00 hummus kernel: pnp: match found with the PnP device '00:0e' and the driver 'serial'
Jan  4 15:55:00 hummus kernel: ohci_hcd: 2003 Oct 13 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
Jan  4 15:55:00 hummus kernel: ohci_hcd: block sizes: ed 64 td 64
Jan  4 15:55:00 hummus kernel: mtrr: v2.0 (20020519)
Jan  4 15:55:00 hummus kernel: ACPI: Subsystem revision 20031002
Jan  4 15:55:00 hummus kernel:     ACPI-0109: *** Error: No object was returned from [\_SB_.LNKA._STA] (Node cbfee840), AE_NOT_EXIST
Jan  4 15:55:00 hummus kernel:     ACPI-0109: *** Error: No object was returned from [\_SB_.LNKB._STA] (Node cbfee940), AE_NOT_EXIST
Jan  4 15:55:00 hummus kernel:     ACPI-0109: *** Error: No object was returned from [\_SB_.LNKC._STA] (Node cbfdd5c0), AE_NOT_EXIST
Jan  4 15:55:00 hummus kernel:     ACPI-0109: *** Error: No object was returned from [\_SB_.LNKD._STA] (Node cbfdd4c0), AE_NOT_EXIST
Jan  4 15:55:00 hummus kernel:     ACPI-0109: *** Error: No object was returned from [\_SB_.PCI0.FNC0.FDD_._STA] (Node cbf45220), AE_NOT_EXIST
Jan  4 15:55:00 hummus kernel:     ACPI-0109: *** Error: No object was returned from [\_SB_.PCI0.FNC0.COM_._STA] (Node cbf45f00), AE_NOT_EXIST
Jan  4 15:55:00 hummus kernel:     ACPI-0109: *** Error: No object was returned from [\_SB_.PCI0.FNC0.PRT_._STA] (Node cbf45d80), AE_NOT_EXIST
Jan  4 15:55:00 hummus kernel:     ACPI-0109: *** Error: No object was returned from [\_SB_.PCI0.FNC0.PRT1._STA] (Node cbf45ca0), AE_NOT_EXIST
Jan  4 15:55:00 hummus kernel:     ACPI-0109: *** Error: No object was returned from [\_SB_.PCI0.FNC0.PCC0._STA] (Node cbf45ba0), AE_NOT_EXIST
Jan  4 15:55:00 hummus kernel:     ACPI-0109: *** Error: No object was returned from [\_SB_.PCI0.FNC0.SND_._STA] (Node cbf45960), AE_NOT_EXIST
Jan  4 15:55:00 hummus kernel:     ACPI-0109: *** Error: No object was returned from [\_SB_.PCI0.FNC0.ATA_._STA] (Node cbf44800), AE_NOT_EXIST
Jan  4 15:55:00 hummus kernel:     ACPI-0109: *** Error: No object was returned from [\_SB_.PCI0.FNC0.MDM_._STA] (Node cbf44720), AE_NOT_EXIST
Jan  4 15:55:00 hummus kernel: ACPI: Interpreter enabled
Jan  4 15:55:00 hummus kernel: ACPI: Using PIC for interrupt routing
Jan  4 15:55:00 hummus kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Jan  4 15:55:00 hummus kernel: PCI: Probing PCI hardware (bus 00)
Jan  4 15:55:00 hummus kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Jan  4 15:55:00 hummus kernel: ACPI: Power Resource [PIHD] (on)
Jan  4 15:55:00 hummus kernel: ACPI: Power Resource [PMHD] (on)
Jan  4 15:55:00 hummus kernel: ACPI: Power Resource [PFAN] (off)
Jan  4 15:55:00 hummus kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Jan  4 15:55:00 hummus kernel: pnp: the driver 'system' has been registered
Jan  4 15:55:00 hummus kernel: PnPBIOS: Scanning system for PnP BIOS support...
Jan  4 15:55:00 hummus kernel: PnPBIOS: Found PnP BIOS installation structure at 0xc00fed00
Jan  4 15:55:00 hummus kernel: PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x92c6, dseg 0x0
Jan  4 15:55:00 hummus kernel: pnp: match found with the PnP device '00:01' and the driver 'system'
Jan  4 15:55:00 hummus kernel: pnp: match found with the PnP device '00:0a' and the driver 'system'
Jan  4 15:55:00 hummus kernel: PnPBIOS: Unknown tag '0x82', length '21'.
Jan  4 15:55:00 hummus kernel: PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver
Jan  4 15:55:00 hummus kernel: SCSI subsystem initialized
Jan  4 15:55:00 hummus kernel: drivers/usb/core/usb.c: registered new driver usbfs
Jan  4 15:55:00 hummus kernel: drivers/usb/core/usb.c: registered new driver hub
Jan  4 15:55:00 hummus kernel: ACPI: No IRQ known for interrupt pin A of device 0000:00:04.0
Jan  4 15:55:00 hummus kernel: ACPI: No IRQ known for interrupt pin D of device 0000:00:05.2
Jan  4 15:55:00 hummus kernel: ACPI: No IRQ known for interrupt pin A of device 0000:00:09.0
Jan  4 15:55:00 hummus kernel: ACPI: No IRQ known for interrupt pin A of device 0000:00:0b.0
Jan  4 15:55:00 hummus kernel: ACPI: No IRQ known for interrupt pin B of device 0000:00:0b.1
Jan  4 15:55:00 hummus kernel: PCI: Using ACPI for IRQ routing
Jan  4 15:55:00 hummus kernel: PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Jan  4 15:55:00 hummus kernel: PCI: Cannot allocate resource region 4 of device 0000:00:05.1
Jan  4 15:55:00 hummus kernel: ACPI: No IRQ known for interrupt pin A of device 0000:00:04.0
Jan  4 15:55:00 hummus kernel: neofb: mapped io at cc810000
Jan  4 15:55:00 hummus kernel: Autodetected internal display
Jan  4 15:55:00 hummus kernel: Panel is a 1024x768 color TFT display
Jan  4 15:55:00 hummus kernel: neofb: mapped framebuffer at cca11000
Jan  4 15:55:00 hummus kernel: neofb v0.4.1: 2560kB VRAM, using 1024x768, 48.361kHz, 60Hz
Jan  4 15:55:00 hummus kernel: fb0: MagicGraph 256AV frame buffer device
Jan  4 15:55:00 hummus kernel: ikconfig 0.7 with /proc/config*
Jan  4 15:55:00 hummus kernel: devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
Jan  4 15:55:00 hummus kernel: devfs: boot_options: 0x1
Jan  4 15:55:00 hummus kernel: Initializing Cryptographic API
Jan  4 15:55:00 hummus kernel: Limiting direct PCI/PCI transfers.
Jan  4 15:55:00 hummus kernel: isapnp: Scanning for PnP cards...
Jan  4 15:55:00 hummus kernel: isapnp: No Plug & Play device found
Jan  4 15:55:00 hummus kernel: Console: switching to colour frame buffer device 128x48
Jan  4 15:55:00 hummus kernel: pty: 256 Unix98 ptys configured
Jan  4 15:55:00 hummus kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
Jan  4 15:55:00 hummus kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jan  4 15:55:00 hummus kernel: pnp: the driver 'serial' has been registered
Jan  4 15:55:00 hummus kernel: pnp: match found with the PnP device '00:0e' and the driver 'serial'
Jan  4 15:55:00 hummus kernel: Using anticipatory io scheduler
Jan  4 15:55:00 hummus kernel: Floppy drive(s): fd0 is 1.44M
Jan  4 15:55:00 hummus kernel: FDC 0 is an 8272A
Jan  4 15:55:00 hummus kernel: loop: loaded (max 8 devices)
Jan  4 15:55:00 hummus kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Jan  4 15:55:00 hummus kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Jan  4 15:55:00 hummus kernel: PIIX4: IDE controller at PCI slot 0000:00:05.1
Jan  4 15:55:00 hummus kernel: PIIX4: chipset revision 1
Jan  4 15:55:00 hummus kernel: PIIX4: not 100%% native mode: will probe irqs later
Jan  4 15:55:00 hummus kernel:     ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:DMA, hdb:pio
Jan  4 15:55:00 hummus kernel:     ide1: BM-DMA at 0x1008-0x100f, BIOS settings: hdc:DMA, hdd:pio
Jan  4 15:55:00 hummus kernel: hda: TOSHIBA MK6409MAV, ATA DISK drive
Jan  4 15:55:00 hummus kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jan  4 15:55:00 hummus kernel: hdc: CD-224E, ATAPI CD/DVD-ROM drive
Jan  4 15:55:00 hummus kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jan  4 15:55:00 hummus kernel: hda: max request size: 128KiB
Jan  4 15:55:00 hummus kernel: hda: 12685680 sectors (6495 MB), CHS=13424/15/63, UDMA(33)
Jan  4 15:55:00 hummus kernel:  /dev/ide/host0/bus0/target0/lun0: p1 p2
Jan  4 15:55:00 hummus kernel: hdc: ATAPI 24X CD-ROM drive, 128kB Cache, DMA
Jan  4 15:55:00 hummus kernel: Uniform CD-ROM driver Revision: 3.12
Jan  4 15:55:00 hummus kernel: Console: switching to colour frame buffer device 128x48
Jan  4 15:55:00 hummus kernel: mice: PS/2 mouse device common for all mice
Jan  4 15:55:00 hummus kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Jan  4 15:55:00 hummus kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Jan  4 15:55:00 hummus kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Jan  4 15:55:00 hummus kernel: NET: Registered protocol family 2
Jan  4 15:55:00 hummus kernel: IP: routing cache hash table of 1024 buckets, 8Kbytes
Jan  4 15:55:00 hummus kernel: TCP: Hash tables configured (established 16384 bind 32768)
Jan  4 15:55:00 hummus kernel: NET: Registered protocol family 1
Jan  4 15:55:00 hummus kernel: NET: Registered protocol family 17
Jan  4 15:55:00 hummus kernel: NET: Registered protocol family 15
Jan  4 15:55:00 hummus kernel: ACPI: (supports S0 S1 S3 S4 S4bios S5)
Jan  4 15:55:00 hummus kernel: kjournald starting.  Commit interval 5 seconds
Jan  4 15:55:00 hummus kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jan  4 15:55:00 hummus kernel: VFS: Mounted root (ext3 filesystem) readonly.
Jan  4 15:55:00 hummus kernel: Mounted devfs on /dev
Jan  4 15:55:00 hummus kernel: Freeing unused kernel memory: 140k freed
Jan  4 15:55:00 hummus kernel: EXT3 FS on hda2, internal journal
Jan  4 15:55:00 hummus kernel: Real Time Clock Driver v1.12
Jan  4 15:55:00 hummus kernel: kjournald starting.  Commit interval 5 seconds
Jan  4 15:55:00 hummus kernel: EXT3 FS on hda1, internal journal
Jan  4 15:55:00 hummus kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jan  4 15:55:00 hummus kernel: ohci_hcd: 2003 Oct 13 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
Jan  4 15:55:00 hummus kernel: ohci_hcd: block sizes: ed 64 td 64
Jan  4 15:55:00 hummus kernel: drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
Jan  4 15:55:00 hummus kernel: ACPI: No IRQ known for interrupt pin D of device 0000:00:05.2
Jan  4 15:55:00 hummus kernel: uhci_hcd 0000:00:05.2: UHCI Host Controller
Jan  4 15:55:00 hummus kernel: uhci_hcd 0000:00:05.2: irq 11, io base 0000ffe0
Jan  4 15:55:00 hummus kernel: uhci_hcd 0000:00:05.2: new USB bus registered, assigned bus number 1
Jan  4 15:55:00 hummus kernel: hub 1-0:1.0: USB hub found
Jan  4 15:55:00 hummus kernel: hub 1-0:1.0: 2 ports detected
Jan  4 15:55:00 hummus kernel: hub 1-0:1.0: new USB device on port 1, assigned address 2
Jan  4 15:55:00 hummus kernel: hub 1-1:1.0: USB hub found
Jan  4 15:55:00 hummus kernel: hub 1-1:1.0: 4 ports detected
Jan  4 15:55:00 hummus kernel: hub 1-1:1.0: new USB device on port 3, assigned address 3
Jan  4 15:55:00 hummus kernel: ttyS3: LSR safety check engaged!
Jan  4 15:55:00 hummus kernel: blk: queue cbd18c00, I/O limit 4095Mb (mask 0xffffffff)
Jan  4 15:55:00 hummus kernel: input: USB HID v1.10 Mouse [Logitech USB Optical Mouse] on usb-0000:00:05.2-1.3
Jan  4 15:55:00 hummus kernel: drivers/usb/core/usb.c: registered new driver hid
Jan  4 15:55:00 hummus kernel: drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Jan  4 15:55:00 hummus kernel: Linux Kernel Card Services
Jan  4 15:55:00 hummus kernel:   options:  [pci] [cardbus] [pm]
Jan  4 15:55:00 hummus kernel: PCI: Enabling device 0000:00:0b.0 (0000 -> 0002)
Jan  4 15:55:00 hummus kernel: ACPI: No IRQ known for interrupt pin A of device 0000:00:0b.0
Jan  4 15:55:00 hummus kernel: Yenta: CardBus bridge found at 0000:00:0b.0 [1179:0001]
Jan  4 15:55:00 hummus kernel: Yenta: ISA IRQ mask 0x0498, PCI irq 11
Jan  4 15:55:00 hummus kernel: Socket status: 30000011
Jan  4 15:55:00 hummus kernel: PCI: Enabling device 0000:00:0b.1 (0000 -> 0002)
Jan  4 15:55:00 hummus kernel: ACPI: No IRQ known for interrupt pin B of device 0000:00:0b.1
Jan  4 15:55:00 hummus kernel: Yenta: CardBus bridge found at 0000:00:0b.1 [1179:0001]
Jan  4 15:55:00 hummus kernel: Yenta: ISA IRQ mask 0x0498, PCI irq 11
Jan  4 15:55:00 hummus kernel: Socket status: 30000007
Jan  4 15:55:00 hummus kernel: mtrr: v2.0 (20020519)
Jan  4 15:55:00 hummus kernel: ACPI: Subsystem revision 20031002
Jan  4 15:55:00 hummus kernel:     ACPI-0109: *** Error: No object was returned from [\_SB_.LNKA._STA] (Node cbfee840), AE_NOT_EXIST
Jan  4 15:55:00 hummus kernel:     ACPI-0109: *** Error: No object was returned from [\_SB_.LNKB._STA] (Node cbfee940), AE_NOT_EXIST
Jan  4 15:55:00 hummus kernel:     ACPI-0109: *** Error: No object was returned from [\_SB_.LNKC._STA] (Node cbfdd5c0), AE_NOT_EXIST
Jan  4 15:55:00 hummus kernel:     ACPI-0109: *** Error: No object was returned from [\_SB_.LNKD._STA] (Node cbfdd4c0), AE_NOT_EXIST
Jan  4 15:55:00 hummus kernel:     ACPI-0109: *** Error: No object was returned from [\_SB_.PCI0.FNC0.FDD_._STA] (Node cbf45220), AE_NOT_EXIST
Jan  4 15:55:00 hummus kernel:     ACPI-0109: *** Error: No object was returned from [\_SB_.PCI0.FNC0.COM_._STA] (Node cbf45f00), AE_NOT_EXIST
Jan  4 15:55:00 hummus kernel:     ACPI-0109: *** Error: No object was returned from [\_SB_.PCI0.FNC0.PRT_._STA] (Node cbf45d80), AE_NOT_EXIST
Jan  4 15:55:00 hummus kernel:     ACPI-0109: *** Error: No object was returned from [\_SB_.PCI0.FNC0.PRT1._STA] (Node cbf45ca0), AE_NOT_EXIST
Jan  4 15:55:00 hummus kernel:     ACPI-0109: *** Error: No object was returned from [\_SB_.PCI0.FNC0.PCC0._STA] (Node cbf45ba0), AE_NOT_EXIST
Jan  4 15:55:00 hummus kernel:     ACPI-0109: *** Error: No object was returned from [\_SB_.PCI0.FNC0.SND_._STA] (Node cbf45960), AE_NOT_EXIST
Jan  4 15:55:00 hummus kernel:     ACPI-0109: *** Error: No object was returned from [\_SB_.PCI0.FNC0.ATA_._STA] (Node cbf44800), AE_NOT_EXIST
Jan  4 15:55:00 hummus kernel:     ACPI-0109: *** Error: No object was returned from [\_SB_.PCI0.FNC0.MDM_._STA] (Node cbf44720), AE_NOT_EXIST
Jan  4 15:55:00 hummus kernel: ACPI: Interpreter enabled
Jan  4 15:55:00 hummus kernel: ACPI: Using PIC for interrupt routing
Jan  4 15:55:00 hummus kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Jan  4 15:55:00 hummus kernel: PCI: Probing PCI hardware (bus 00)
Jan  4 15:55:00 hummus kernel: ACPI: Power Resource [PIHD] (on)
Jan  4 15:55:00 hummus kernel: ACPI: Power Resource [PMHD] (on)
Jan  4 15:55:00 hummus kernel: ACPI: Power Resource [PFAN] (off)
Jan  4 15:55:00 hummus kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Jan  4 15:55:00 hummus kernel: PnPBIOS: Scanning system for PnP BIOS support...
Jan  4 15:55:00 hummus kernel: PnPBIOS: Found PnP BIOS installation structure at 0xc00fed00
Jan  4 15:55:00 hummus kernel: PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x92c6, dseg 0x0
Jan  4 15:55:00 hummus kernel: PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver
Jan  4 15:55:00 hummus kernel: SCSI subsystem initialized
Jan  4 15:55:00 hummus kernel: drivers/usb/core/usb.c: registered new driver usbfs
Jan  4 15:55:00 hummus kernel: drivers/usb/core/usb.c: registered new driver hub
Jan  4 15:55:00 hummus kernel: ACPI: No IRQ known for interrupt pin A of device 0000:00:04.0
Jan  4 15:55:00 hummus kernel: ACPI: No IRQ known for interrupt pin D of device 0000:00:05.2
Jan  4 15:55:00 hummus kernel: ACPI: No IRQ known for interrupt pin A of device 0000:00:09.0
Jan  4 15:55:00 hummus kernel: ACPI: No IRQ known for interrupt pin A of device 0000:00:0b.0
Jan  4 15:55:00 hummus kernel: ACPI: No IRQ known for interrupt pin B of device 0000:00:0b.1
Jan  4 15:55:00 hummus kernel: PCI: Using ACPI for IRQ routing
Jan  4 15:55:00 hummus kernel: PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Jan  4 15:55:00 hummus kernel: ACPI: No IRQ known for interrupt pin A of device 0000:00:04.0
Jan  4 15:55:00 hummus kernel: neofb: mapped io at cc810000
Jan  4 15:55:00 hummus kernel: Autodetected internal display
Jan  4 15:55:00 hummus kernel: Panel is a 1024x768 color TFT display
Jan  4 15:55:00 hummus kernel: neofb: mapped framebuffer at cca11000
Jan  4 15:55:00 hummus kernel: neofb v0.4.1: 2560kB VRAM, using 1024x768, 48.361kHz, 60Hz
Jan  4 15:55:00 hummus kernel: fb0: MagicGraph 256AV frame buffer device
Jan  4 15:55:00 hummus kernel: ikconfig 0.7 with /proc/config*
Jan  4 15:55:00 hummus kernel: devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
Jan  4 15:55:00 hummus kernel: devfs: boot_options: 0x1
Jan  4 15:55:00 hummus kernel: Initializing Cryptographic API
Jan  4 15:55:00 hummus kernel: Limiting direct PCI/PCI transfers.
Jan  4 15:55:00 hummus kernel: isapnp: Scanning for PnP cards...
Jan  4 15:55:00 hummus kernel: isapnp: No Plug & Play device found
Jan  4 15:55:00 hummus kernel: Console: switching to colour frame buffer device 128x48
Jan  4 15:55:00 hummus kernel: pty: 256 Unix98 ptys configured
Jan  4 15:55:00 hummus kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
Jan  4 15:55:00 hummus kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jan  4 15:55:00 hummus kernel: Using anticipatory io scheduler
Jan  4 15:55:00 hummus kernel: Floppy drive(s): fd0 is 1.44M
Jan  4 15:55:00 hummus kernel: FDC 0 is an 8272A
Jan  4 15:55:00 hummus kernel: loop: loaded (max 8 devices)
Jan  4 15:55:00 hummus kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Jan  4 15:55:00 hummus kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Jan  4 15:55:00 hummus kernel: PIIX4: IDE controller at PCI slot 0000:00:05.1
Jan  4 15:55:00 hummus kernel: PIIX4: chipset revision 1
Jan  4 15:55:00 hummus kernel: PIIX4: not 100%% native mode: will probe irqs later
Jan  4 15:55:00 hummus kernel:     ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:DMA, hdb:pio
Jan  4 15:55:00 hummus kernel:     ide1: BM-DMA at 0x1008-0x100f, BIOS settings: hdc:DMA, hdd:pio
Jan  4 15:55:00 hummus kernel: hda: TOSHIBA MK6409MAV, ATA DISK drive
Jan  4 15:55:00 hummus kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jan  4 15:55:00 hummus kernel: hdc: CD-224E, ATAPI CD/DVD-ROM drive
Jan  4 15:55:00 hummus kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jan  4 15:55:00 hummus kernel: hda: max request size: 128KiB
Jan  4 15:55:00 hummus kernel: hda: 12685680 sectors (6495 MB), CHS=13424/15/63, UDMA(33)
Jan  4 15:55:00 hummus kernel:  /dev/ide/host0/bus0/target0/lun0: p1 p2
Jan  4 15:55:00 hummus kernel: hdc: ATAPI 24X CD-ROM drive, 128kB Cache, DMA
Jan  4 15:55:00 hummus kernel: Uniform CD-ROM driver Revision: 3.12
Jan  4 15:55:00 hummus kernel: Console: switching to colour frame buffer device 128x48
Jan  4 15:55:00 hummus kernel: mice: PS/2 mouse device common for all mice
Jan  4 15:55:00 hummus kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Jan  4 15:55:00 hummus kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Jan  4 15:55:00 hummus kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Jan  4 15:55:00 hummus kernel: NET: Registered protocol family 2
Jan  4 15:55:00 hummus kernel: IP: routing cache hash table of 1024 buckets, 8Kbytes
Jan  4 15:55:00 hummus kernel: TCP: Hash tables configured (established 16384 bind 32768)
Jan  4 15:55:00 hummus kernel: NET: Registered protocol family 1
Jan  4 15:55:00 hummus kernel: NET: Registered protocol family 17
Jan  4 15:55:00 hummus kernel: NET: Registered protocol family 15
Jan  4 15:55:00 hummus kernel: ACPI: (supports S0 S1 S3 S4 S4bios S5)
Jan  4 15:55:00 hummus kernel: kjournald starting.  Commit interval 5 seconds
Jan  4 15:55:00 hummus kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jan  4 15:55:00 hummus kernel: VFS: Mounted root (ext3 filesystem) readonly.
Jan  4 15:55:00 hummus kernel: Mounted devfs on /dev
Jan  4 15:55:00 hummus kernel: Freeing unused kernel memory: 140k freed
Jan  4 15:55:00 hummus kernel: EXT3 FS on hda2, internal journal
Jan  4 15:55:00 hummus kernel: Real Time Clock Driver v1.12
Jan  4 15:55:00 hummus kernel: kjournald starting.  Commit interval 5 seconds
Jan  4 15:55:00 hummus kernel: EXT3 FS on hda1, internal journal
Jan  4 15:55:00 hummus kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jan  4 15:55:00 hummus kernel: drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
Jan  4 15:55:00 hummus kernel: ACPI: No IRQ known for interrupt pin D of device 0000:00:05.2
Jan  4 15:55:00 hummus kernel: uhci_hcd 0000:00:05.2: UHCI Host Controller
Jan  4 15:55:00 hummus kernel: uhci_hcd 0000:00:05.2: irq 11, io base 0000ffe0
Jan  4 15:55:00 hummus kernel: uhci_hcd 0000:00:05.2: new USB bus registered, assigned bus number 1
Jan  4 15:55:00 hummus kernel: hub 1-0:1.0: USB hub found
Jan  4 15:55:00 hummus kernel: hub 1-0:1.0: 2 ports detected
Jan  4 15:55:00 hummus kernel: hub 1-0:1.0: new USB device on port 1, assigned address 2
Jan  4 15:55:00 hummus kernel: hub 1-1:1.0: USB hub found
Jan  4 15:55:00 hummus kernel: hub 1-1:1.0: 4 ports detected
Jan  4 15:55:00 hummus kernel: hub 1-1:1.0: new USB device on port 3, assigned address 3
Jan  4 15:55:00 hummus kernel: ttyS3: LSR safety check engaged!
Jan  4 15:55:00 hummus kernel: blk: queue cbd18c00, I/O limit 4095Mb (mask 0xffffffff)
Jan  4 15:55:00 hummus kernel: input: USB HID v1.10 Mouse [Logitech USB Optical Mouse] on usb-0000:00:05.2-1.3
Jan  4 15:55:00 hummus kernel: drivers/usb/core/usb.c: registered new driver hid
Jan  4 15:55:00 hummus kernel: drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Jan  4 15:55:00 hummus kernel: Linux Kernel Card Services
Jan  4 15:55:00 hummus kernel:   options:  [pci] [cardbus] [pm]
Jan  4 15:55:00 hummus kernel: PCI: Enabling device 0000:00:0b.0 (0000 -> 0002)
Jan  4 15:55:00 hummus kernel: ACPI: No IRQ known for interrupt pin A of device 0000:00:0b.0
Jan  4 15:55:00 hummus kernel: Yenta: CardBus bridge found at 0000:00:0b.0 [1179:0001]
Jan  4 15:55:00 hummus kernel: Yenta: ISA IRQ mask 0x0498, PCI irq 11
Jan  4 15:55:00 hummus kernel: Socket status: 30000011
Jan  4 15:55:00 hummus kernel: PCI: Enabling device 0000:00:0b.1 (0000 -> 0002)
Jan  4 15:55:00 hummus kernel: ACPI: No IRQ known for interrupt pin B of device 0000:00:0b.1
Jan  4 15:55:00 hummus kernel: Yenta: CardBus bridge found at 0000:00:0b.1 [1179:0001]
Jan  4 15:55:00 hummus kernel: Yenta: ISA IRQ mask 0x0498, PCI irq 11
Jan  4 15:55:00 hummus kernel: Socket status: 30000007
Jan  4 15:55:01 hummus cardmgr[376]: watching 2 sockets
Jan  4 15:55:01 hummus cardmgr[377]: starting, version is 3.2.5
Jan  4 15:55:01 hummus cardmgr[377]: socket 0: Xircom CEM56 Ethernet/Modem
Jan  4 15:55:01 hummus cardmgr[377]: executing: 'modprobe xirc2ps_cs'

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-916
Referat V a - Kommunikationsnetze -             AIM.  ralfpostfix
