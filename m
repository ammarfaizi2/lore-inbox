Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263152AbTIFJ3N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 05:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264533AbTIFJ3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 05:29:13 -0400
Received: from eskuel.net ([81.56.212.215]:31174 "EHLO maverick.eskuel.net")
	by vger.kernel.org with ESMTP id S263152AbTIFJ26 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 05:28:58 -0400
Message-ID: <3F59A913.1080406@eskuel.net>
Date: Sat, 06 Sep 2003 11:29:55 +0200
From: Mathieu LESNIAK <maverick@eskuel.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030903 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, mochel@osdl.org, pavel@ucw.cz
Subject: Fs corruption with swsusp in test4-mm6 ?
Content-Type: multipart/mixed;
 boundary="------------020708030500000408050904"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020708030500000408050904
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I've tested the latest -mm6 kernel on a Compaq Presario 2157EA laptop 
(Celeron Mobile 2GHz)
Everything worked fine until I tested suspend to disk. After resuming, 
I've got random messages about reiserfs problem on the console :

vs-4080: reiserfs_free_block: free_block (hda2:95121)[dev:blocknr]: bit 
already cleared
Sep  6 10:30:51 herrbach kernel: vs-4080: reiserfs_free_block: 
free_block (hda2:95122)[dev:blocknr]: bit already cleared
Sep  6 10:30:58 herrbach kernel: vs-13060: reiserfs_update_sd: stat data 
of object [689 645 0x0 SD] (nlink == 1) not found (pos 25)
Sep  6 10:30:58 herrbach kernel: vs-13060: reiserfs_update_sd: stat data 
of object [689 652 0x0 SD] (nlink == 1) not found (pos 25)

Please find in attachement 1 syslog showing the suspend / resume cycle 
and the fs errors.

Thanks,

Mathieu LESNIAK

--------------020708030500000408050904
Content-Type: text/plain;
 name="syslog-fs_corruption"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="syslog-fs_corruption"



Sep  6 10:29:16 herrbach syslogd 1.4.1#11: restart.
Sep  6 10:29:16 herrbach kernel: klogd 1.4.1#11, log source = /proc/kmsg started.
Sep  6 10:29:16 herrbach kernel: Inspecting /boot/System.map-2.6.0-test4-mm6
Sep  6 10:29:17 herrbach kernel: Loaded 26011 symbols from /boot/System.map-2.6.0-test4-mm6.
Sep  6 10:29:17 herrbach kernel: Symbols match kernel version 2.6.0.
Sep  6 10:29:17 herrbach kernel: No module symbols loaded - kernel modules not enabled. 
Sep  6 10:29:17 herrbach kernel: Linux version 2.6.0-test4-mm6 (root@athlon) (version gcc 3.3.2 20030831 (Debian prerelease)) #3 Sat Sep 6 10:17:01 CEST 2003
Sep  6 10:29:17 herrbach kernel: Video mode to be used for restore is 317
Sep  6 10:29:17 herrbach kernel: BIOS-provided physical RAM map:
Sep  6 10:29:17 herrbach kernel:  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
Sep  6 10:29:17 herrbach kernel:  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
Sep  6 10:29:17 herrbach kernel:  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
Sep  6 10:29:17 herrbach kernel:  BIOS-e820: 0000000000100000 - 000000000bf70000 (usable)
Sep  6 10:29:17 herrbach kernel:  BIOS-e820: 000000000bf70000 - 000000000bf7f000 (ACPI data)
Sep  6 10:29:17 herrbach kernel:  BIOS-e820: 000000000bf7f000 - 000000000bf80000 (ACPI NVS)
Sep  6 10:29:17 herrbach kernel:  BIOS-e820: 000000000bf80000 - 000000000c000000 (reserved)
Sep  6 10:29:17 herrbach kernel:  BIOS-e820: 000000001bf80000 - 000000001c000000 (reserved)
Sep  6 10:29:17 herrbach kernel:  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
Sep  6 10:29:17 herrbach kernel: 191MB LOWMEM available.
Sep  6 10:29:17 herrbach kernel: On node 0 totalpages: 49008
Sep  6 10:29:17 herrbach kernel:   DMA zone: 4096 pages, LIFO batch:1
Sep  6 10:29:17 herrbach kernel:   Normal zone: 44912 pages, LIFO batch:10
Sep  6 10:29:17 herrbach kernel:   HighMem zone: 0 pages, LIFO batch:1
Sep  6 10:29:17 herrbach kernel: DMI 2.3 present.
Sep  6 10:29:17 herrbach kernel: ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f6c90
Sep  6 10:29:17 herrbach kernel: ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x0bf78eb1
Sep  6 10:29:17 herrbach kernel: ACPI: FADT (v001 ATI    Salmon   0x06040000 ATI  0x000f4240) @ 0x0bf7ef64
Sep  6 10:29:17 herrbach kernel: ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x0bf7efd8
Sep  6 10:29:17 herrbach kernel: ACPI: DSDT (v001    ATI MS2_1535 0x06040000 MSFT 0x0100000e) @ 0x00000000
Sep  6 10:29:17 herrbach kernel: Building zonelist for node : 0
Sep  6 10:29:17 herrbach kernel: Kernel command line: BOOT_IMAGE=Linux ro root=302 hdc=ide-scsi
Sep  6 10:29:17 herrbach kernel: ide_setup: hdc=ide-scsi
Sep  6 10:29:17 herrbach kernel: current: c03ba9c0
Sep  6 10:29:17 herrbach kernel: current->thread_info: c0436000
Sep  6 10:29:17 herrbach kernel: Initializing CPU#0
Sep  6 10:29:17 herrbach kernel: PID hash table entries: 1024 (order 10: 8192 bytes)
Sep  6 10:29:17 herrbach kernel: Detected 1993.827 MHz processor.
Sep  6 10:29:17 herrbach kernel: Console: colour dummy device 80x25
Sep  6 10:29:17 herrbach kernel: Memory: 189768k/196032k available (2382k kernel code, 5616k reserved, 905k data, 152k init, 0k highmem)
Sep  6 10:29:17 herrbach kernel: zapping low mappings.
Sep  6 10:29:17 herrbach kernel: Calibrating delay loop... 3932.16 BogoMIPS
Sep  6 10:29:17 herrbach kernel: Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Sep  6 10:29:17 herrbach kernel: Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Sep  6 10:29:17 herrbach kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Sep  6 10:29:17 herrbach kernel: -> /dev
Sep  6 10:29:17 herrbach kernel: -> /dev/console
Sep  6 10:29:17 herrbach kernel: -> /root
Sep  6 10:29:17 herrbach kernel: CPU:     After generic identify, caps: bfebf9ff 00000000 00000000 00000000
Sep  6 10:29:17 herrbach kernel: CPU:     After vendor identify, caps: bfebf9ff 00000000 00000000 00000000
Sep  6 10:29:17 herrbach kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Sep  6 10:29:17 herrbach kernel: CPU: L2 cache: 256K
Sep  6 10:29:17 herrbach kernel: CPU:     After all inits, caps: bfebf9ff 00000000 00000000 00000080
Sep  6 10:29:17 herrbach kernel: Intel machine check architecture supported.
Sep  6 10:29:17 herrbach kernel: Intel machine check reporting enabled on CPU#0.
Sep  6 10:29:17 herrbach kernel: CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
Sep  6 10:29:17 herrbach kernel: CPU: Intel Mobile Intel(R) Celeron(R) CPU 2.00GHz stepping 07
Sep  6 10:29:17 herrbach kernel: Enabling fast FPU save and restore... done.
Sep  6 10:29:17 herrbach kernel: Enabling unmasked SIMD FPU exception support... done.
Sep  6 10:29:17 herrbach kernel: Checking 'hlt' instruction... OK.
Sep  6 10:29:17 herrbach kernel: POSIX conformance testing by UNIFIX
Sep  6 10:29:17 herrbach kernel: PM: Adding info for No Bus:legacy
Sep  6 10:29:17 herrbach kernel: Initializing RT netlink socket
Sep  6 10:29:17 herrbach kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd89b, last bus=2
Sep  6 10:29:17 herrbach kernel: PCI: Using configuration type 1
Sep  6 10:29:17 herrbach kernel: mtrr: v2.0 (20020519)
Sep  6 10:29:17 herrbach kernel: ACPI: Subsystem revision 20030813
Sep  6 10:29:17 herrbach kernel: ACPI: Interpreter enabled
Sep  6 10:29:17 herrbach kernel: ACPI: Using PIC for interrupt routing
Sep  6 10:29:17 herrbach kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Sep  6 10:29:17 herrbach kernel: PCI: Probing PCI hardware (bus 00)
Sep  6 10:29:17 herrbach kernel: PM: Adding info for No Bus:pci0000:00
Sep  6 10:29:17 herrbach kernel: PM: Adding info for pci:0000:00:00.0
Sep  6 10:29:17 herrbach kernel: PM: Adding info for pci:0000:00:01.0
Sep  6 10:29:17 herrbach kernel: PM: Adding info for pci:0000:00:02.0
Sep  6 10:29:17 herrbach kernel: PM: Adding info for pci:0000:00:06.0
Sep  6 10:29:17 herrbach kernel: PM: Adding info for pci:0000:00:07.0
Sep  6 10:29:17 herrbach kernel: PM: Adding info for pci:0000:00:08.0
Sep  6 10:29:17 herrbach kernel: PM: Adding info for pci:0000:00:0a.0
Sep  6 10:29:17 herrbach kernel: PM: Adding info for pci:0000:00:10.0
Sep  6 10:29:17 herrbach kernel: PM: Adding info for pci:0000:00:11.0
Sep  6 10:29:17 herrbach kernel: PM: Adding info for pci:0000:00:12.0
Sep  6 10:29:17 herrbach kernel: PM: Adding info for pci:0000:01:05.0
Sep  6 10:29:17 herrbach kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Sep  6 10:29:17 herrbach kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
Sep  6 10:29:17 herrbach kernel: ACPI: PCI Interrupt Link [LNK0] (IRQs 7 10)
Sep  6 10:29:17 herrbach kernel: ACPI: PCI Interrupt Link [LNK1] (IRQs 7 *10)
Sep  6 10:29:17 herrbach kernel: ACPI: PCI Interrupt Link [LNK2] (IRQs 10)
Sep  6 10:29:17 herrbach kernel: ACPI: PCI Interrupt Link [LNK3] (IRQs 10)
Sep  6 10:29:17 herrbach kernel: ACPI: PCI Interrupt Link [LNK4] (IRQs 10)
Sep  6 10:29:17 herrbach kernel: ACPI: PCI Interrupt Link [LNK5] (IRQs 7 *11)
Sep  6 10:29:17 herrbach kernel: ACPI: PCI Interrupt Link [LNK6] (IRQs 10)
Sep  6 10:29:17 herrbach kernel: ACPI: PCI Interrupt Link [LNK7] (IRQs *5)
Sep  6 10:29:17 herrbach kernel: ACPI: PCI Interrupt Link [LNK8] (IRQs *10)
Sep  6 10:29:17 herrbach kernel: ACPI: Embedded Controller [EC0] (gpe 24)
Sep  6 10:29:17 herrbach kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Sep  6 10:29:17 herrbach kernel: PnPBIOS: Scanning system for PnP BIOS support...
Sep  6 10:29:17 herrbach kernel: PnPBIOS: Found PnP BIOS installation structure at 0xc00f6cc0
Sep  6 10:29:17 herrbach kernel: PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xaff0, dseg 0x400
Sep  6 10:29:17 herrbach kernel: PM: Adding info for No Bus:pnp0
Sep  6 10:29:17 herrbach kernel: PM: Adding info for pnp:00:00
Sep  6 10:29:17 herrbach kernel: PM: Adding info for pnp:00:01
Sep  6 10:29:17 herrbach kernel: PM: Adding info for pnp:00:02
Sep  6 10:29:17 herrbach kernel: PM: Adding info for pnp:00:03
Sep  6 10:29:17 herrbach kernel: PM: Adding info for pnp:00:04
Sep  6 10:29:17 herrbach kernel: PM: Adding info for pnp:00:05
Sep  6 10:29:17 herrbach kernel: PM: Adding info for pnp:00:06
Sep  6 10:29:17 herrbach kernel: PM: Adding info for pnp:00:07
Sep  6 10:29:17 herrbach kernel: PM: Adding info for pnp:00:08
Sep  6 10:29:17 herrbach kernel: PM: Adding info for pnp:00:09
Sep  6 10:29:17 herrbach kernel: PM: Adding info for pnp:00:0a
Sep  6 10:29:17 herrbach kernel: PM: Adding info for pnp:00:0b
Sep  6 10:29:17 herrbach kernel: PM: Adding info for pnp:00:0c
Sep  6 10:29:17 herrbach kernel: PM: Adding info for pnp:00:0d
Sep  6 10:29:17 herrbach kernel: PM: Adding info for pnp:00:0f
Sep  6 10:29:17 herrbach kernel: PM: Adding info for pnp:00:10
Sep  6 10:29:17 herrbach kernel: PM: Adding info for pnp:00:13
Sep  6 10:29:17 herrbach kernel: PnPBIOS: 17 nodes reported by PnP BIOS; 17 recorded by driver
Sep  6 10:29:17 herrbach kernel: SCSI subsystem initialized
Sep  6 10:29:17 herrbach kernel: drivers/usb/core/usb.c: registered new driver usbfs
Sep  6 10:29:17 herrbach kernel: drivers/usb/core/usb.c: registered new driver hub
Sep  6 10:29:17 herrbach kernel: ACPI: PCI Interrupt Link [LNK8] enabled at IRQ 10
Sep  6 10:29:17 herrbach kernel: ACPI: PCI Interrupt Link [LNK7] enabled at IRQ 5
Sep  6 10:29:17 herrbach kernel: ACPI: PCI Interrupt Link [LNK6] enabled at IRQ 10
Sep  6 10:29:17 herrbach kernel: ACPI: PCI Interrupt Link [LNK5] enabled at IRQ 11
Sep  6 10:29:17 herrbach kernel: ACPI: No IRQ known for interrupt pin A of device 0000:00:10.0
Sep  6 10:29:17 herrbach kernel: ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 10
Sep  6 10:29:17 herrbach kernel: ACPI: PCI Interrupt Link [LNK0] enabled at IRQ 10
Sep  6 10:29:17 herrbach kernel: PCI: Using ACPI for IRQ routing
Sep  6 10:29:17 herrbach kernel: PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Sep  6 10:29:17 herrbach kernel: vesafb: framebuffer at 0xd8000000, mapped to 0xcc80c000, size 16384k
Sep  6 10:29:17 herrbach kernel: vesafb: mode is 1024x768x16, linelength=2048, pages=41
Sep  6 10:29:17 herrbach kernel: vesafb: protected mode interface info at c000:51bf
Sep  6 10:29:17 herrbach kernel: vesafb: scrolling: redraw
Sep  6 10:29:17 herrbach kernel: vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
Sep  6 10:29:17 herrbach kernel: fb0: VESA VGA frame buffer device
Sep  6 10:29:17 herrbach kernel: Console: switching to colour frame buffer device 128x48
Sep  6 10:29:17 herrbach kernel: pty: 256 Unix98 ptys configured
Sep  6 10:29:17 herrbach kernel: SBF: Simple Boot Flag extension found and enabled.
Sep  6 10:29:17 herrbach kernel: SBF: Setting boot flags 0x1
Sep  6 10:29:17 herrbach kernel: Machine check exception polling timer started.
Sep  6 10:29:17 herrbach kernel: powernow: AMD processor not detected.
Sep  6 10:29:17 herrbach kernel: cpufreq: P4/Xeon(TM) CPU On-Demand Clock Modulation available
Sep  6 10:29:17 herrbach kernel: cpufreq: Intel(R) SpeedStep(TM) for this chipset not (yet) available.
Sep  6 10:29:17 herrbach kernel: ikconfig 0.6 with /proc/config*
Sep  6 10:29:17 herrbach kernel: Initializing Cryptographic API
Sep  6 10:29:17 herrbach kernel: ACPI: AC Adapter [ACAD] (on-line)
Sep  6 10:29:17 herrbach kernel: ACPI: Battery Slot [BAT1] (battery absent)
Sep  6 10:29:17 herrbach kernel: ACPI: Power Button (FF) [PWRF]
Sep  6 10:29:17 herrbach kernel: ACPI: Lid Switch [LID]
Sep  6 10:29:17 herrbach kernel: ACPI: Processor [CPU0] (supports C1 C2, 8 throttling states)
Sep  6 10:29:17 herrbach kernel: ACPI: Thermal Zone [THRM] (38 C)
Sep  6 10:29:17 herrbach kernel: PM: Adding info for No Bus:pnp1
Sep  6 10:29:17 herrbach kernel: isapnp: Scanning for PnP cards...
Sep  6 10:29:17 herrbach kernel: isapnp: No Plug & Play device found
Sep  6 10:29:17 herrbach kernel: Real Time Clock Driver v1.12
Sep  6 10:29:17 herrbach kernel: [drm] Initialized radeon 1.9.0 20020828 on minor 0
Sep  6 10:29:17 herrbach kernel: Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
Sep  6 10:29:17 herrbach kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Sep  6 10:29:17 herrbach kernel: PCI: Enabling device 0000:00:08.0 (0000 -> 0003)
Sep  6 10:29:17 herrbach kernel: ttyS1 at I/O 0x1428 (irq = 10) is a 8250
Sep  6 10:29:17 herrbach kernel: ttyS2 at I/O 0x1440 (irq = 10) is a 8250
Sep  6 10:29:17 herrbach kernel: ttyS3 at I/O 0x1450 (irq = 10) is a 8250
Sep  6 10:29:17 herrbach kernel: Using anticipatory scheduling io scheduler
Sep  6 10:29:17 herrbach kernel: floppy0: no floppy controllers found
Sep  6 10:29:17 herrbach kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Sep  6 10:29:17 herrbach kernel: loop: loaded (max 8 devices)
Sep  6 10:29:17 herrbach kernel: nbd: registered device at major 43
Sep  6 10:29:17 herrbach kernel: natsemi dp8381x driver, version 1.07+LK1.0.17, Sep 27, 2002
Sep  6 10:29:17 herrbach kernel:   originally by Donald Becker <becker@scyld.com>
Sep  6 10:29:17 herrbach kernel:   http://www.scyld.com/network/natsemi.html
Sep  6 10:29:17 herrbach kernel:   2.4.x kernel port by Jeff Garzik, Tjeerd Mulder
Sep  6 10:29:17 herrbach kernel: eth0: NatSemi DP8381[56] at 0xcd80f000, 00:0b:cd:a7:40:b4, IRQ 10.
Sep  6 10:29:17 herrbach kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Sep  6 10:29:17 herrbach kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Sep  6 10:29:17 herrbach kernel: ALI15X3: IDE controller at PCI slot 0000:00:10.0
Sep  6 10:29:17 herrbach kernel: ACPI: No IRQ known for interrupt pin A of device 0000:00:10.0
Sep  6 10:29:17 herrbach kernel: ALI15X3: chipset revision 196
Sep  6 10:29:17 herrbach kernel: ALI15X3: not 100%% native mode: will probe irqs later
Sep  6 10:29:17 herrbach kernel:     ide0: BM-DMA at 0x2000-0x2007, BIOS settings: hda:DMA, hdb:pio
Sep  6 10:29:17 herrbach kernel:     ide1: BM-DMA at 0x2008-0x200f, BIOS settings: hdc:pio, hdd:pio
Sep  6 10:29:17 herrbach kernel: hda: HITACHI_DK23EA-30, ATA DISK drive
Sep  6 10:29:17 herrbach kernel: PM: Adding info for No Bus:ide0
Sep  6 10:29:17 herrbach kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Sep  6 10:29:17 herrbach kernel: PM: Adding info for ide:0.0
Sep  6 10:29:17 herrbach kernel: hdc: HL-DT-STCD-RW/DVD DRIVE GCC-4241N, ATAPI CD/DVD-ROM drive
Sep  6 10:29:17 herrbach kernel: PM: Adding info for No Bus:ide1
Sep  6 10:29:17 herrbach kernel: ide1 at 0x170-0x177,0x376 on irq 15
Sep  6 10:29:17 herrbach kernel: PM: Adding info for ide:1.0
Sep  6 10:29:17 herrbach kernel: hda: max request size: 128KiB
Sep  6 10:29:17 herrbach kernel: hda: 58605120 sectors (30005 MB) w/2048KiB Cache, CHS=58140/16/63, UDMA(100)
Sep  6 10:29:17 herrbach kernel:  hda: hda1 hda2 hda3
Sep  6 10:29:17 herrbach kernel: Console: switching to colour frame buffer device 128x48
Sep  6 10:29:17 herrbach kernel: Initializing USB Mass Storage driver...
Sep  6 10:29:17 herrbach kernel: drivers/usb/core/usb.c: registered new driver usb-storage
Sep  6 10:29:17 herrbach kernel: USB Mass Storage support registered.
Sep  6 10:29:17 herrbach kernel: drivers/usb/core/usb.c: registered new driver hiddev
Sep  6 10:29:17 herrbach kernel: drivers/usb/core/usb.c: registered new driver hid
Sep  6 10:29:17 herrbach kernel: drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Sep  6 10:29:17 herrbach kernel: mice: PS/2 mouse device common for all mice
Sep  6 10:29:17 herrbach kernel: Synaptics Touchpad, model: 1
Sep  6 10:29:17 herrbach kernel:  Firmware: 5.8
Sep  6 10:29:17 herrbach kernel:  Sensor: 35
Sep  6 10:29:17 herrbach kernel:  new absolute packet format
Sep  6 10:29:17 herrbach kernel:  Touchpad has extended capability bits
Sep  6 10:29:17 herrbach kernel:  -> multifinger detection
Sep  6 10:29:17 herrbach kernel:  -> palm detection
Sep  6 10:29:17 herrbach kernel: input: Synaptics Synaptics TouchPad on isa0060/serio1
Sep  6 10:29:17 herrbach kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Sep  6 10:29:17 herrbach kernel: input: AT Set 2 keyboard on isa0060/serio0
Sep  6 10:29:17 herrbach kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Sep  6 10:29:17 herrbach kernel: Advanced Linux Sound Architecture Driver Version 0.9.6 (Wed Aug 20 20:27:13 2003 UTC).
Sep  6 10:29:17 herrbach kernel: ALSA device list:
Sep  6 10:29:17 herrbach kernel:   No soundcards found.
Sep  6 10:29:17 herrbach kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Sep  6 10:29:17 herrbach kernel: IP: routing cache hash table of 1024 buckets, 8Kbytes
Sep  6 10:29:17 herrbach kernel: TCP: Hash tables configured (established 16384 bind 32768)
Sep  6 10:29:17 herrbach kernel: Linux IP multicast router 0.06 plus PIM-SM
Sep  6 10:29:17 herrbach kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Sep  6 10:29:17 herrbach kernel: cpufreq: No CPUs supporting ACPI performance management found.
Sep  6 10:29:17 herrbach kernel: BIOS EDD facility v0.09 2003-Jan-22, 1 devices found
Sep  6 10:29:17 herrbach kernel: PM: Reading swsusp image.
Sep  6 10:29:17 herrbach kernel: PM: Resume from disk failed.
Sep  6 10:29:17 herrbach kernel: ACPI: (supports S0 S3 S4 S5)
Sep  6 10:29:17 herrbach kernel: found reiserfs format "3.6" with standard journal
Sep  6 10:29:17 herrbach kernel: Reiserfs journal params: device hda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Sep  6 10:29:17 herrbach kernel: reiserfs: checking transaction log (hda2) for (hda2)
Sep  6 10:29:17 herrbach kernel: Using r5 hash to sort names
Sep  6 10:29:17 herrbach kernel: VFS: Mounted root (reiserfs filesystem) readonly.
Sep  6 10:29:17 herrbach kernel: Freeing unused kernel memory: 152k freed
Sep  6 10:29:17 herrbach kernel: Adding 200804k swap on /dev/hda3.  Priority:-1 extents:1
Sep  6 10:29:17 herrbach kernel: ohci-hcd: 2003 Feb 24 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
Sep  6 10:29:17 herrbach kernel: ohci-hcd: block sizes: ed 64 td 64
Sep  6 10:29:17 herrbach kernel: ohci-hcd 0000:00:02.0: OHCI Host Controller
Sep  6 10:29:17 herrbach kernel: ohci-hcd 0000:00:02.0: irq 10, pci mem cd8db000
Sep  6 10:29:17 herrbach kernel: ohci-hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
Sep  6 10:29:17 herrbach kernel: PM: Adding info for usb:usb1
Sep  6 10:29:17 herrbach kernel: PM: Adding info for usb:1-0:0
Sep  6 10:29:17 herrbach kernel: hub 1-0:0: USB hub found
Sep  6 10:29:17 herrbach kernel: hub 1-0:0: 4 ports detected
Sep  6 10:29:17 herrbach kernel: PM: Adding info for No Bus:ide-scsi
Sep  6 10:29:17 herrbach kernel: scsi0 : SCSI host adapter emulation for IDE ATAPI devices
Sep  6 10:29:17 herrbach kernel: PM: Adding info for No Bus:host0
Sep  6 10:29:17 herrbach kernel:   Vendor: HL-DT-ST  Model: RW/DVD GCC-4241N  Rev: 0C27
Sep  6 10:29:17 herrbach kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Sep  6 10:29:17 herrbach kernel: PM: Adding info for scsi:0:0:0:0
Sep  6 10:29:17 herrbach kernel: PCI: Enabling device 0000:00:06.0 (0005 -> 0007)
Sep  6 10:29:17 herrbach modprobe: FATAL: Module snd_card_1 not found. 
Sep  6 10:29:17 herrbach modprobe: FATAL: Module snd_card_1 not found. 
Sep  6 10:29:17 herrbach modprobe: FATAL: Module snd_card_2 not found. 
Sep  6 10:29:17 herrbach modprobe: FATAL: Module snd_card_2 not found. 
Sep  6 10:29:17 herrbach modprobe: FATAL: Module snd_card_3 not found. 
Sep  6 10:29:17 herrbach modprobe: FATAL: Module snd_card_3 not found. 
Sep  6 10:29:18 herrbach kernel: eth0: link up.
Sep  6 10:29:18 herrbach kernel: eth0: Setting full-duplex based on negotiated link capability.
Sep  6 10:29:18 herrbach ifplugd(eth0)[248]: Using interface eth0/00:0B:CD:A7:40:B4 with driver <natsemi> (version: 1.07+LK1.0.17)
Sep  6 10:29:18 herrbach ifplugd(eth0)[248]: Using detection mode: SIOCETHTOOL
Sep  6 10:29:18 herrbach ifplugd(eth0)[248]: ifplugd 0.15 successfully initialized, link beat detected.
Sep  6 10:29:18 herrbach ifplugd(eth0)[248]: Executing '/etc/ifplugd/ifplugd.action eth0 up'.
Sep  6 10:29:18 herrbach dhclient: Internet Software Consortium DHCP Client 2.0pl5
Sep  6 10:29:18 herrbach ifplugd(eth0)[248]: client: Internet Software Consortium DHCP Client 2.0pl5
Sep  6 10:29:18 herrbach dhclient: Copyright 1995, 1996, 1997, 1998, 1999 The Internet Software Consortium.
Sep  6 10:29:18 herrbach ifplugd(eth0)[248]: client: Copyright 1995, 1996, 1997, 1998, 1999 The Internet Software Consortium.
Sep  6 10:29:18 herrbach dhclient: All rights reserved.
Sep  6 10:29:18 herrbach ifplugd(eth0)[248]: client: All rights reserved.
Sep  6 10:29:18 herrbach dhclient: 
Sep  6 10:29:18 herrbach dhclient: Please contribute if you find this software useful.
Sep  6 10:29:18 herrbach ifplugd(eth0)[248]: client: Please contribute if you find this software useful.
Sep  6 10:29:18 herrbach dhclient: For info, please visit http://www.isc.org/dhcp-contrib.html
Sep  6 10:29:18 herrbach ifplugd(eth0)[248]: client: For info, please visit http://www.isc.org/dhcp-contrib.html
Sep  6 10:29:18 herrbach dhclient: 
Sep  6 10:29:19 herrbach dhclient: Listening on LPF/eth0/00:0b:cd:a7:40:b4
Sep  6 10:29:19 herrbach dhclient: Sending on   LPF/eth0/00:0b:cd:a7:40:b4
Sep  6 10:29:19 herrbach dhclient: Sending on   Socket/fallback/fallback-net
Sep  6 10:29:19 herrbach dhclient: DHCPREQUEST on eth0 to 255.255.255.255 port 67
Sep  6 10:29:19 herrbach ifplugd(eth0)[248]: client: Listening on LPF/eth0/00:0b:cd:a7:40:b4
Sep  6 10:29:19 herrbach ifplugd(eth0)[248]: client: Sending on   LPF/eth0/00:0b:cd:a7:40:b4
Sep  6 10:29:19 herrbach ifplugd(eth0)[248]: client: Sending on   Socket/fallback/fallback-net
Sep  6 10:29:19 herrbach ifplugd(eth0)[248]: client: DHCPREQUEST on eth0 to 255.255.255.255 port 67
Sep  6 10:29:19 herrbach dhclient: DHCPACK from 192.168.100.1
Sep  6 10:29:19 herrbach ifplugd(eth0)[248]: client: DHCPACK from 192.168.100.1
Sep  6 10:29:19 herrbach dhclient: bound to 192.168.100.8 -- renewal in 900 seconds.
Sep  6 10:29:19 herrbach ifplugd(eth0)[248]: client: bound to 192.168.100.8 -- renewal in 900 seconds.
Sep  6 10:29:19 herrbach ifplugd(eth0)[248]: Program executed successfully.
Sep  6 10:29:20 herrbach /usr/sbin/cron[285]: (CRON) INFO (pidfile fd = 3)
Sep  6 10:29:20 herrbach /usr/sbin/cron[286]: (CRON) STARTUP (fork ok)
Sep  6 10:29:20 herrbach /usr/sbin/cron[286]: (CRON) INFO (Running @reboot jobs)
Sep  6 10:29:23 herrbach kernel: Losing too many ticks!
Sep  6 10:29:23 herrbach kernel: TSC cannot be used as a timesource. (Are you running with SpeedStep?)
Sep  6 10:29:23 herrbach kernel: Falling back to a sane timesource.
Sep  6 10:30:42 herrbach kernel: Stopping tasks: ====================|
Sep  6 10:30:43 herrbach kernel: Freeing memory: ....|
Sep  6 10:30:43 herrbach kernel: hdc: start_power_step(step: 0)
Sep  6 10:30:43 herrbach kernel: hdc: completing PM request, suspend
Sep  6 10:30:43 herrbach kernel: hda: start_power_step(step: 0)
Sep  6 10:30:43 herrbach kernel: hda: start_power_step(step: 1)
Sep  6 10:30:43 herrbach kernel: hda: complete_power_step(step: 1, stat: 50, err: 0)
Sep  6 10:30:43 herrbach kernel: hda: completing PM request, suspend
Sep  6 10:30:43 herrbach kernel: eth0: remaining active for wake-on-lan
Sep  6 10:30:43 herrbach kernel: PM: Attempting to suspend to disk.
Sep  6 10:30:43 herrbach kernel: PM: snapshotting memory.
Sep  6 10:30:43 herrbach kernel: resume= option should be used to set suspend device/critical section: Counting pages to copy[nosave c0434000] (pages needed: 3692+512=4204 free: 45315)
Sep  6 10:30:43 herrbach kernel: Alloc pagedir
Sep  6 10:30:43 herrbach kernel: [nosave c0434000]<7>PM: Image restored successfully.
Sep  6 10:30:43 herrbach kernel: Freeing prev allocated pagedir
Sep  6 10:30:43 herrbach kernel: PCI: Enabling device 0000:00:06.0 (0005 -> 0007)
Sep  6 10:30:43 herrbach kernel: eth0: Setting full-duplex based on negotiated link capability.
Sep  6 10:30:43 herrbach kernel: hda: Wakeup request inited, waiting for !BSY...
Sep  6 10:30:43 herrbach kernel: hda: start_power_step(step: 1000)
Sep  6 10:30:43 herrbach kernel: blk: queue c12d6c00, I/O limit 4095Mb (mask 0xffffffff)
Sep  6 10:30:43 herrbach kernel: hda: completing PM request, resume
Sep  6 10:30:43 herrbach kernel: hdc: Wakeup request inited, waiting for !BSY...
Sep  6 10:30:43 herrbach kernel: hdc: start_power_step(step: 1000)
Sep  6 10:30:43 herrbach kernel: hdc: completing PM request, resume
Sep  6 10:30:43 herrbach kernel: Restarting tasks... done
Sep  6 10:30:51 herrbach kernel: vs-4080: reiserfs_free_block: free_block (hda2:95121)[dev:blocknr]: bit already cleared
Sep  6 10:30:51 herrbach kernel: vs-4080: reiserfs_free_block: free_block (hda2:95122)[dev:blocknr]: bit already cleared
Sep  6 10:30:58 herrbach kernel: vs-13060: reiserfs_update_sd: stat data of object [689 645 0x0 SD] (nlink == 1) not found (pos 25)
Sep  6 10:30:58 herrbach kernel: vs-13060: reiserfs_update_sd: stat data of object [689 652 0x0 SD] (nlink == 1) not found (pos 25)
Sep  6 10:31:17 herrbach last message repeated 9 times
Sep  6 10:31:21 herrbach shutdown[337]: shutting down for sy

--------------020708030500000408050904--

