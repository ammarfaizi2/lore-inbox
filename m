Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264376AbUBDIko (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 03:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266337AbUBDIko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 03:40:44 -0500
Received: from postfix3-2.free.fr ([213.228.0.169]:32907 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S264376AbUBDIkK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 03:40:10 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <16416.45028.375327.580875@loria.fr>
Date: Wed, 4 Feb 2004 09:40:04 +0100
From: Juergen Stuber <stuber@loria.fr>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM] 2.6.2-rc1-bk1 Synaptics touchpad on IBM T30 not detected
In-Reply-To: <200402031757.27269.dtor_core@ameritech.net>
References: <86u127khxf.fsf@loria.fr>
	<200402031757.27269.dtor_core@ameritech.net>
X-Mailer: VM 7.03 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Dmitry Torokhov wrote:
> 
> As a workaround try booting with i8042.nomux kernel option.

that cures the problem.

> Also, could you please #define DEBUG in
> drivers/input/serio/i8042.c and post your dmesg?

Ok, here goes, for 2.6.2-rc1-bk1 without the i8042.nomux kernel option,
from Debian /var/log/syslog (for a log with i8042.nomux set see below):


Feb  4 09:20:02 freitag kernel: klogd 1.4.1#10, log source = /proc/kmsg started.
Feb  4 09:20:02 freitag kernel: Inspecting /boot/System.map-2.6.2-rc1-bk1-1
Feb  4 09:20:02 freitag kernel: Loaded 20424 symbols from /boot/System.map-2.6.2-rc1-bk1-1.
Feb  4 09:20:02 freitag kernel: Symbols match kernel version 2.6.2.
Feb  4 09:20:02 freitag kernel: No module symbols loaded - kernel modules not enabled. 
Feb  4 09:20:02 freitag kernel: Linux version 2.6.2-rc1-bk1-1 (root@freitag) (gcc version 3.3.2 (Debian)) #1 Wed Feb 4 08:29:31 CET 2004
Feb  4 09:20:02 freitag kernel: BIOS-provided physical RAM map:
Feb  4 09:20:02 freitag kernel:  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
Feb  4 09:20:02 freitag kernel:  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
Feb  4 09:20:02 freitag kernel:  BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
Feb  4 09:20:02 freitag kernel:  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
Feb  4 09:20:02 freitag kernel:  BIOS-e820: 0000000000100000 - 000000002ff60000 (usable)
Feb  4 09:20:02 freitag kernel:  BIOS-e820: 000000002ff60000 - 000000002ff7a000 (ACPI data)
Feb  4 09:20:02 freitag kernel:  BIOS-e820: 000000002ff7a000 - 000000002ff7c000 (ACPI NVS)
Feb  4 09:20:02 freitag kernel:  BIOS-e820: 000000002ff7c000 - 0000000030000000 (reserved)
Feb  4 09:20:02 freitag kernel:  BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
Feb  4 09:20:02 freitag kernel: 767MB LOWMEM available.
Feb  4 09:20:02 freitag kernel: On node 0 totalpages: 196448
Feb  4 09:20:02 freitag kernel:   DMA zone: 4096 pages, LIFO batch:1
Feb  4 09:20:02 freitag kernel:   Normal zone: 192352 pages, LIFO batch:16
Feb  4 09:20:02 freitag kernel:   HighMem zone: 0 pages, LIFO batch:1
Feb  4 09:20:02 freitag kernel: DMI present.
Feb  4 09:20:02 freitag kernel: IBM machine detected. Enabling interrupts during APM calls.
Feb  4 09:20:02 freitag kernel: IBM machine detected. Disabling SMBus accesses.
Feb  4 09:20:02 freitag kernel: Building zonelist for node : 0
Feb  4 09:20:02 freitag kernel: Kernel command line: auto BOOT_IMAGE=Linux ro root=307 pci=usepirqmask
Feb  4 09:20:02 freitag kernel: No local APIC present or hardware disabled
Feb  4 09:20:02 freitag kernel: Initializing CPU#0
Feb  4 09:20:02 freitag kernel: PID hash table entries: 4096 (order 12: 32768 bytes)
Feb  4 09:20:02 freitag kernel: Detected 1798.911 MHz processor.
Feb  4 09:20:02 freitag kernel: Using tsc for high-res timesource
Feb  4 09:20:02 freitag kernel: Console: colour VGA+ 80x25
Feb  4 09:20:02 freitag kernel: Memory: 774688k/785792k available (1420k kernel code, 10312k reserved, 635k data, 124k init, 0k highmem)
Feb  4 09:20:02 freitag kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Feb  4 09:20:02 freitag kernel: Calibrating delay loop... 3547.13 BogoMIPS
Feb  4 09:20:02 freitag kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Feb  4 09:20:02 freitag kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Feb  4 09:20:02 freitag kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Feb  4 09:20:02 freitag kernel: CPU:     After generic identify, caps: bfebf9ff 00000000 00000000 00000000
Feb  4 09:20:02 freitag kernel: CPU:     After vendor identify, caps: bfebf9ff 00000000 00000000 00000000
Feb  4 09:20:02 freitag kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Feb  4 09:20:02 freitag kernel: CPU: L2 cache: 512K
Feb  4 09:20:02 freitag kernel: CPU:     After all inits, caps: bfebf9ff 00000000 00000000 00000080
Feb  4 09:20:02 freitag kernel: Intel machine check architecture supported.
Feb  4 09:20:02 freitag kernel: Intel machine check reporting enabled on CPU#0.
Feb  4 09:20:02 freitag kernel: CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
Feb  4 09:20:02 freitag kernel: CPU#0: Thermal monitoring enabled
Feb  4 09:20:02 freitag kernel: CPU: Intel Mobile Intel(R) Pentium(R) 4 - M CPU 1.80GHz stepping 07
Feb  4 09:20:02 freitag kernel: Enabling fast FPU save and restore... done.
Feb  4 09:20:02 freitag kernel: Enabling unmasked SIMD FPU exception support... done.
Feb  4 09:20:02 freitag kernel: Checking 'hlt' instruction... OK.
Feb  4 09:20:02 freitag kernel: POSIX conformance testing by UNIFIX
Feb  4 09:20:02 freitag kernel: NET: Registered protocol family 16
Feb  4 09:20:02 freitag kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd8fe, last bus=8
Feb  4 09:20:02 freitag kernel: PCI: Using configuration type 1
Feb  4 09:20:02 freitag kernel: mtrr: v2.0 (20020519)
Feb  4 09:20:02 freitag kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Feb  4 09:20:02 freitag kernel: PnPBIOS: Scanning system for PnP BIOS support...
Feb  4 09:20:02 freitag kernel: PnPBIOS: Found PnP BIOS installation structure at 0xc00f7030
Feb  4 09:20:02 freitag kernel: PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x9d4e, dseg 0x400
Feb  4 09:20:02 freitag kernel: pnp: 00:0b: ioport range 0x4d0-0x4d1 has been reserved
Feb  4 09:20:02 freitag kernel: pnp: 00:0b: ioport range 0x1000-0x105f has been reserved
Feb  4 09:20:02 freitag kernel: pnp: 00:0b: ioport range 0x1060-0x107f has been reserved
Feb  4 09:20:02 freitag kernel: pnp: 00:0b: ioport range 0x1180-0x11bf has been reserved
Feb  4 09:20:02 freitag kernel: PnPBIOS: 22 nodes reported by PnP BIOS; 22 recorded by driver
Feb  4 09:20:02 freitag kernel: PCI: Probing PCI hardware
Feb  4 09:20:02 freitag kernel: PCI: Probing PCI hardware (bus 00)
Feb  4 09:20:02 freitag kernel: Transparent bridge - 0000:00:1e.0
Feb  4 09:20:02 freitag kernel: PCI: Discovered primary peer bus 09 [IRQ]
Feb  4 09:20:02 freitag kernel: PCI: Using IRQ router PIIX/ICH [8086/248c] at 0000:00:1f.0
Feb  4 09:20:02 freitag kernel: PCI: Found IRQ 11 for device 0000:00:1f.1
Feb  4 09:20:02 freitag kernel: PCI: Sharing IRQ 11 with 0000:00:1d.2
Feb  4 09:20:02 freitag kernel: PCI: Sharing IRQ 11 with 0000:02:02.0
Feb  4 09:20:02 freitag kernel: SBF: Simple Boot Flag extension found and enabled.
Feb  4 09:20:02 freitag kernel: SBF: Setting boot flags 0x1
Feb  4 09:20:02 freitag kernel: Machine check exception polling timer started.
Feb  4 09:20:02 freitag kernel: apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
Feb  4 09:20:02 freitag kernel: ikconfig 0.7 with /proc/config*
Feb  4 09:20:02 freitag kernel: Initializing Cryptographic API
Feb  4 09:20:02 freitag kernel: pty: 256 Unix98 ptys configured
Feb  4 09:20:02 freitag kernel: Using anticipatory io scheduler
Feb  4 09:20:02 freitag kernel: Floppy drive(s): fd0 is 1.44M
Feb  4 09:20:02 freitag kernel: FDC 0 is a National Semiconductor PC87306
Feb  4 09:20:02 freitag kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Feb  4 09:20:02 freitag kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Feb  4 09:20:02 freitag kernel: ICH3M: IDE controller at PCI slot 0000:00:1f.1
Feb  4 09:20:02 freitag kernel: PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
Feb  4 09:20:02 freitag kernel: PCI: Found IRQ 11 for device 0000:00:1f.1
Feb  4 09:20:02 freitag kernel: PCI: Sharing IRQ 11 with 0000:00:1d.2
Feb  4 09:20:02 freitag kernel: PCI: Sharing IRQ 11 with 0000:02:02.0
Feb  4 09:20:02 freitag kernel: ICH3M: chipset revision 2
Feb  4 09:20:02 freitag kernel: ICH3M: not 100%% native mode: will probe irqs later
Feb  4 09:20:02 freitag kernel:     ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
Feb  4 09:20:02 freitag kernel:     ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
Feb  4 09:20:02 freitag kernel: hda: IC25N040ATCS04-0, ATA DISK drive
Feb  4 09:20:02 freitag kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Feb  4 09:20:02 freitag kernel: hdc: HL-DT-STDVD-ROM GDR8081N, ATAPI CD/DVD-ROM drive
Feb  4 09:20:02 freitag kernel: ide1 at 0x170-0x177,0x376 on irq 15
Feb  4 09:20:02 freitag kernel: hda: max request size: 128KiB
Feb  4 09:20:02 freitag kernel: hda: 78140160 sectors (40007 MB) w/1768KiB Cache, CHS=65535/16/63, UDMA(100)
Feb  4 09:20:02 freitag kernel:  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
Feb  4 09:20:02 freitag kernel: mice: PS/2 mouse device common for all mice
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 20 -> i8042 (command) [0]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 47 <- i8042 (return) [0]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [2]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [2]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: d3 -> i8042 (command) [3]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 5a -> i8042 (parameter) [3]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: a5 <- i8042 (return) [3]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: a7 -> i8042 (command) [4]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 20 -> i8042 (command) [4]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 76 <- i8042 (return) [4]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: a8 -> i8042 (command) [6]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 20 -> i8042 (command) [6]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 56 <- i8042 (return) [6]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [7]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 74 -> i8042 (parameter) [7]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: d3 -> i8042 (command) [8]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: f0 -> i8042 (parameter) [8]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 0f <- i8042 (return) [8]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: d3 -> i8042 (command) [11]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [11]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: a9 <- i8042 (return) [11]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: d3 -> i8042 (command) [12]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: a4 -> i8042 (parameter) [12]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 53 <- i8042 (return) [12]
Feb  4 09:20:02 freitag kernel: i8042.c: Detected active multiplexing controller, rev 10.12.
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [13]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 74 -> i8042 (parameter) [13]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 90 -> i8042 (command) [13]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: a8 -> i8042 (command) [14]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 91 -> i8042 (command) [14]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: a8 -> i8042 (command) [14]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 92 -> i8042 (command) [15]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: a8 -> i8042 (command) [15]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 93 -> i8042 (command) [16]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: a8 -> i8042 (command) [16]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [16]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 54 -> i8042 (parameter) [16]
Feb  4 09:20:02 freitag kernel: serio: i8042 AUX0 port at 0x60,0x64 irq 12
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [17]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [17]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 90 -> i8042 (command) [18]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [18]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 90 -> i8042 (command) [213]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: ed -> i8042 (parameter) [213]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: ab <- i8042 (interrupt, kbd, 0) [214]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 0) [264]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [409]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 54 -> i8042 (parameter) [409]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [409]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 54 -> i8042 (parameter) [409]
Feb  4 09:20:02 freitag kernel: serio: i8042 AUX1 port at 0x60,0x64 irq 12
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [410]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [410]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 91 -> i8042 (command) [411]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [411]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 91 -> i8042 (command) [605]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: ed -> i8042 (parameter) [605]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 0) [606]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 0) [656]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [801]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 54 -> i8042 (parameter) [801]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [802]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 54 -> i8042 (parameter) [802]
Feb  4 09:20:02 freitag kernel: serio: i8042 AUX2 port at 0x60,0x64 irq 12
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [802]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [802]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 92 -> i8042 (command) [803]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [803]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 92 -> i8042 (command) [998]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: ed -> i8042 (parameter) [998]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 0) [999]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 0) [1049]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [1194]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 54 -> i8042 (parameter) [1194]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [1194]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 54 -> i8042 (parameter) [1194]
Feb  4 09:20:02 freitag kernel: serio: i8042 AUX3 port at 0x60,0x64 irq 12
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [1195]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [1195]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 93 -> i8042 (command) [1196]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [1196]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 93 -> i8042 (command) [1390]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: ed -> i8042 (parameter) [1390]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 0) [1391]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 0) [1441]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [1586]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 54 -> i8042 (parameter) [1586]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [1587]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 44 -> i8042 (parameter) [1587]
Feb  4 09:20:02 freitag kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [1587]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 45 -> i8042 (parameter) [1587]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: f2 -> i8042 (kbd-data) [1588]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [1589]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: ab <- i8042 (interrupt, kbd, 1) [1590]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 54 <- i8042 (interrupt, kbd, 1) [1590]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: ed -> i8042 (kbd-data) [1590]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [1591]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [1591]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [1592]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: f3 -> i8042 (kbd-data) [1592]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [1593]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [1593]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [1594]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: f4 -> i8042 (kbd-data) [1594]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [1595]
Feb  4 09:20:02 freitag kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Feb  4 09:20:02 freitag kernel: NET: Registered protocol family 2
Feb  4 09:20:02 freitag kernel: IP: routing cache hash table of 8192 buckets, 64Kbytes
Feb  4 09:20:02 freitag kernel: TCP: Hash tables configured (established 262144 bind 65536)
Feb  4 09:20:02 freitag kernel: NET: Registered protocol family 1
Feb  4 09:20:02 freitag kernel: NET: Registered protocol family 15
Feb  4 09:20:02 freitag kernel: kjournald starting.  Commit interval 5 seconds
Feb  4 09:20:02 freitag kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb  4 09:20:02 freitag kernel: VFS: Mounted root (ext3 filesystem) readonly.
Feb  4 09:20:02 freitag kernel: Freeing unused kernel memory: 124k freed
Feb  4 09:20:02 freitag kernel: blk: queue efc52e00, I/O limit 4095Mb (mask 0xffffffff)
Feb  4 09:20:02 freitag kernel: Adding 521600k swap on /dev/hda6.  Priority:-1 extents:1
Feb  4 09:20:02 freitag kernel: EXT3 FS on hda7, internal journal
Feb  4 09:20:02 freitag kernel: Real Time Clock Driver v1.12
Feb  4 09:20:02 freitag kernel: Linux Kernel Card Services
Feb  4 09:20:02 freitag kernel:   options:  [pci] [cardbus] [pm]
Feb  4 09:20:02 freitag kernel: PCI: Found IRQ 11 for device 0000:02:00.0
Feb  4 09:20:02 freitag kernel: PCI: Sharing IRQ 11 with 0000:00:1d.0
Feb  4 09:20:02 freitag kernel: PCI: Sharing IRQ 11 with 0000:01:00.0
Feb  4 09:20:02 freitag kernel: Yenta: CardBus bridge found at 0000:02:00.0 [1014:0512]
Feb  4 09:20:02 freitag kernel: Yenta: Using INTVAL to route CSC interrupts to PCI
Feb  4 09:20:02 freitag kernel: Yenta: Routing CardBus interrupts to PCI
Feb  4 09:20:02 freitag kernel: Yenta: ISA IRQ mask 0x06b8, PCI irq 11
Feb  4 09:20:02 freitag kernel: Socket status: 30000006
Feb  4 09:20:02 freitag kernel: PCI: Found IRQ 11 for device 0000:02:00.1
Feb  4 09:20:02 freitag kernel: PCI: Sharing IRQ 11 with 0000:00:1f.3
Feb  4 09:20:02 freitag kernel: PCI: Sharing IRQ 11 with 0000:00:1f.5
Feb  4 09:20:02 freitag kernel: PCI: Sharing IRQ 11 with 0000:00:1f.6
Feb  4 09:20:02 freitag kernel: Yenta: CardBus bridge found at 0000:02:00.1 [1014:0512]
Feb  4 09:20:02 freitag kernel: Yenta: Using INTVAL to route CSC interrupts to PCI
Feb  4 09:20:02 freitag kernel: Yenta: Routing CardBus interrupts to PCI
Feb  4 09:20:02 freitag kernel: Yenta: ISA IRQ mask 0x06b8, PCI irq 11
Feb  4 09:20:02 freitag kernel: Socket status: 30000010
Feb  4 09:20:02 freitag kernel: Intel(R) PRO/100 Network Driver - version 2.3.30-k1
Feb  4 09:20:02 freitag kernel: Copyright (c) 2003 Intel Corporation
Feb  4 09:20:02 freitag kernel: 
Feb  4 09:20:02 freitag kernel: PCI: Found IRQ 11 for device 0000:02:08.0
Feb  4 09:20:02 freitag kernel: e100: selftest OK.
Feb  4 09:20:02 freitag kernel: e100: eth0: Intel(R) PRO/100 Network Connection
Feb  4 09:20:02 freitag kernel:   Hardware receive checksums enabled
Feb  4 09:20:02 freitag kernel: 
Feb  4 09:20:02 freitag kernel: Linux agpgart interface v0.100 (c) Dave Jones
Feb  4 09:20:02 freitag kernel: NTFS driver 2.1.6 [Flags: R/O MODULE].
Feb  4 09:20:02 freitag kernel: NET: Registered protocol family 17
Feb  4 09:20:02 freitag kernel: [drm] Initialized radeon 1.9.0 20020828 on minor 0
Feb  4 09:20:02 freitag kernel: drivers/usb/core/usb.c: registered new driver usbfs
Feb  4 09:20:02 freitag kernel: drivers/usb/core/usb.c: registered new driver hub
Feb  4 09:20:02 freitag kernel: drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
Feb  4 09:20:02 freitag kernel: PCI: Found IRQ 11 for device 0000:00:1d.0
Feb  4 09:20:02 freitag kernel: PCI: Sharing IRQ 11 with 0000:01:00.0
Feb  4 09:20:02 freitag kernel: PCI: Sharing IRQ 11 with 0000:02:00.0
Feb  4 09:20:02 freitag kernel: uhci_hcd 0000:00:1d.0: UHCI Host Controller
Feb  4 09:20:02 freitag kernel: PCI: Setting latency timer of device 0000:00:1d.0 to 64
Feb  4 09:20:02 freitag kernel: uhci_hcd 0000:00:1d.0: irq 11, io base 00001800
Feb  4 09:20:02 freitag kernel: uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
Feb  4 09:20:02 freitag kernel: hub 1-0:1.0: USB hub found
Feb  4 09:20:02 freitag kernel: hub 1-0:1.0: 2 ports detected
Feb  4 09:20:02 freitag kernel: PCI: Found IRQ 11 for device 0000:00:1d.1
Feb  4 09:20:02 freitag kernel: uhci_hcd 0000:00:1d.1: UHCI Host Controller
Feb  4 09:20:02 freitag kernel: PCI: Setting latency timer of device 0000:00:1d.1 to 64
Feb  4 09:20:02 freitag kernel: uhci_hcd 0000:00:1d.1: irq 11, io base 00001820
Feb  4 09:20:02 freitag kernel: uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
Feb  4 09:20:02 freitag kernel: hub 2-0:1.0: USB hub found
Feb  4 09:20:02 freitag kernel: hub 2-0:1.0: 2 ports detected
Feb  4 09:20:02 freitag kernel: PCI: Found IRQ 11 for device 0000:00:1d.2
Feb  4 09:20:02 freitag kernel: PCI: Sharing IRQ 11 with 0000:00:1f.1
Feb  4 09:20:02 freitag kernel: PCI: Sharing IRQ 11 with 0000:02:02.0
Feb  4 09:20:02 freitag kernel: uhci_hcd 0000:00:1d.2: UHCI Host Controller
Feb  4 09:20:02 freitag kernel: PCI: Setting latency timer of device 0000:00:1d.2 to 64
Feb  4 09:20:02 freitag kernel: uhci_hcd 0000:00:1d.2: irq 11, io base 00001840
Feb  4 09:20:02 freitag kernel: uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
Feb  4 09:20:02 freitag kernel: hub 3-0:1.0: USB hub found
Feb  4 09:20:02 freitag kernel: hub 3-0:1.0: 2 ports detected
Feb  4 09:20:02 freitag kernel: drivers/usb/core/usb.c: registered new driver hiddev
Feb  4 09:20:02 freitag kernel: drivers/usb/core/usb.c: registered new driver hid
Feb  4 09:20:02 freitag kernel: drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [11474]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 47 -> i8042 (parameter) [11474]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 90 -> i8042 (command) [11474]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [11474]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [11475]
Feb  4 09:20:02 freitag kernel: atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
Feb  4 09:20:02 freitag kernel: atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: ab <- i8042 (interrupt, kbd, 1) [11476]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 54 <- i8042 (interrupt, kbd, 1) [11476]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [11998]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 45 -> i8042 (parameter) [11998]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [11998]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 47 -> i8042 (parameter) [11998]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 91 -> i8042 (command) [11998]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [11998]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [11999]
Feb  4 09:20:02 freitag kernel: atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
Feb  4 09:20:02 freitag kernel: atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: ab <- i8042 (interrupt, kbd, 1) [11999]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 54 <- i8042 (interrupt, kbd, 1) [11999]
Feb  4 09:20:02 freitag kernel: hub 2-0:1.0: new USB device on port 2, assigned address 2
Feb  4 09:20:02 freitag kernel: hub 2-2:1.0: USB hub found
Feb  4 09:20:02 freitag kernel: hub 2-2:1.0: 4 ports detected
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [12362]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 45 -> i8042 (parameter) [12362]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [12362]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 47 -> i8042 (parameter) [12362]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 92 -> i8042 (command) [12362]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [12362]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [12363]
Feb  4 09:20:02 freitag kernel: atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
Feb  4 09:20:02 freitag kernel: atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: ab <- i8042 (interrupt, kbd, 1) [12363]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 54 <- i8042 (interrupt, kbd, 1) [12363]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [12504]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 45 -> i8042 (parameter) [12504]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [12504]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 47 -> i8042 (parameter) [12504]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 93 -> i8042 (command) [12504]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [12504]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [12505]
Feb  4 09:20:02 freitag kernel: atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
Feb  4 09:20:02 freitag kernel: atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: ab <- i8042 (interrupt, kbd, 1) [12505]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 54 <- i8042 (interrupt, kbd, 1) [12505]
Feb  4 09:20:02 freitag kernel: hub 2-2:1.0: new USB device on port 1, assigned address 3
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [12615]
Feb  4 09:20:02 freitag kernel: drivers/input/serio/i8042.c: 45 -> i8042 (parameter) [12615]


For reference with the i8042.nomux kernel option:


Feb  4 08:59:18 freitag syslogd 1.4.1#10: restart.
Feb  4 08:59:19 freitag kernel: klogd 1.4.1#10, log source = /proc/kmsg started.
Feb  4 08:59:19 freitag kernel: Inspecting /boot/System.map-2.6.2-rc1-bk1-1
Feb  4 08:59:19 freitag kernel: Loaded 20424 symbols from /boot/System.map-2.6.2-rc1-bk1-1.
Feb  4 08:59:19 freitag kernel: Symbols match kernel version 2.6.2.
Feb  4 08:59:19 freitag kernel: No module symbols loaded - kernel modules not enabled. 
Feb  4 08:59:19 freitag kernel: Linux version 2.6.2-rc1-bk1-1 (root@freitag) (gcc version 3.3.2 (Debian)) #1 Wed Feb 4 08:29:31 CET 2004
Feb  4 08:59:19 freitag kernel: BIOS-provided physical RAM map:
Feb  4 08:59:19 freitag kernel:  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
Feb  4 08:59:19 freitag kernel:  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
Feb  4 08:59:19 freitag kernel:  BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
Feb  4 08:59:19 freitag kernel:  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
Feb  4 08:59:19 freitag kernel:  BIOS-e820: 0000000000100000 - 000000002ff60000 (usable)
Feb  4 08:59:19 freitag kernel:  BIOS-e820: 000000002ff60000 - 000000002ff7a000 (ACPI data)
Feb  4 08:59:19 freitag kernel:  BIOS-e820: 000000002ff7a000 - 000000002ff7c000 (ACPI NVS)
Feb  4 08:59:19 freitag kernel:  BIOS-e820: 000000002ff7c000 - 0000000030000000 (reserved)
Feb  4 08:59:19 freitag kernel:  BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
Feb  4 08:59:19 freitag kernel: 767MB LOWMEM available.
Feb  4 08:59:19 freitag kernel: On node 0 totalpages: 196448
Feb  4 08:59:19 freitag kernel:   DMA zone: 4096 pages, LIFO batch:1
Feb  4 08:59:19 freitag kernel:   Normal zone: 192352 pages, LIFO batch:16
Feb  4 08:59:19 freitag kernel:   HighMem zone: 0 pages, LIFO batch:1
Feb  4 08:59:19 freitag kernel: DMI present.
Feb  4 08:59:19 freitag kernel: IBM machine detected. Enabling interrupts during APM calls.
Feb  4 08:59:19 freitag kernel: IBM machine detected. Disabling SMBus accesses.
Feb  4 08:59:19 freitag kernel: Building zonelist for node : 0
Feb  4 08:59:19 freitag kernel: Kernel command line: auto BOOT_IMAGE=Linux ro root=307 pci=usepirqmask i8042.nomux
Feb  4 08:59:19 freitag kernel: No local APIC present or hardware disabled
Feb  4 08:59:19 freitag kernel: Initializing CPU#0
Feb  4 08:59:19 freitag kernel: PID hash table entries: 4096 (order 12: 32768 bytes)
Feb  4 08:59:19 freitag kernel: Detected 1798.710 MHz processor.
Feb  4 08:59:19 freitag kernel: Using tsc for high-res timesource
Feb  4 08:59:19 freitag kernel: Console: colour VGA+ 80x25
Feb  4 08:59:19 freitag kernel: Memory: 774688k/785792k available (1420k kernel code, 10312k reserved, 635k data, 124k init, 0k highmem)
Feb  4 08:59:19 freitag kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Feb  4 08:59:19 freitag kernel: Calibrating delay loop... 3555.32 BogoMIPS
Feb  4 08:59:19 freitag kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Feb  4 08:59:19 freitag kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Feb  4 08:59:19 freitag kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Feb  4 08:59:19 freitag kernel: CPU:     After generic identify, caps: bfebf9ff 00000000 00000000 00000000
Feb  4 08:59:19 freitag kernel: CPU:     After vendor identify, caps: bfebf9ff 00000000 00000000 00000000
Feb  4 08:59:19 freitag kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Feb  4 08:59:19 freitag kernel: CPU: L2 cache: 512K
Feb  4 08:59:19 freitag kernel: CPU:     After all inits, caps: bfebf9ff 00000000 00000000 00000080
Feb  4 08:59:19 freitag kernel: Intel machine check architecture supported.
Feb  4 08:59:19 freitag kernel: Intel machine check reporting enabled on CPU#0.
Feb  4 08:59:19 freitag kernel: CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
Feb  4 08:59:19 freitag kernel: CPU#0: Thermal monitoring enabled
Feb  4 08:59:19 freitag kernel: CPU: Intel Mobile Intel(R) Pentium(R) 4 - M CPU 1.80GHz stepping 07
Feb  4 08:59:19 freitag kernel: Enabling fast FPU save and restore... done.
Feb  4 08:59:19 freitag kernel: Enabling unmasked SIMD FPU exception support... done.
Feb  4 08:59:19 freitag kernel: Checking 'hlt' instruction... OK.
Feb  4 08:59:19 freitag kernel: POSIX conformance testing by UNIFIX
Feb  4 08:59:19 freitag kernel: NET: Registered protocol family 16
Feb  4 08:59:19 freitag kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd8fe, last bus=8
Feb  4 08:59:19 freitag kernel: PCI: Using configuration type 1
Feb  4 08:59:19 freitag kernel: mtrr: v2.0 (20020519)
Feb  4 08:59:19 freitag kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Feb  4 08:59:19 freitag kernel: PnPBIOS: Scanning system for PnP BIOS support...
Feb  4 08:59:19 freitag kernel: PnPBIOS: Found PnP BIOS installation structure at 0xc00f7030
Feb  4 08:59:19 freitag kernel: PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x9d4e, dseg 0x400
Feb  4 08:59:19 freitag kernel: pnp: 00:0b: ioport range 0x4d0-0x4d1 has been reserved
Feb  4 08:59:19 freitag kernel: pnp: 00:0b: ioport range 0x1000-0x105f has been reserved
Feb  4 08:59:19 freitag kernel: pnp: 00:0b: ioport range 0x1060-0x107f has been reserved
Feb  4 08:59:19 freitag kernel: pnp: 00:0b: ioport range 0x1180-0x11bf has been reserved
Feb  4 08:59:19 freitag kernel: PnPBIOS: 22 nodes reported by PnP BIOS; 22 recorded by driver
Feb  4 08:59:19 freitag kernel: PCI: Probing PCI hardware
Feb  4 08:59:19 freitag kernel: PCI: Probing PCI hardware (bus 00)
Feb  4 08:59:19 freitag kernel: Transparent bridge - 0000:00:1e.0
Feb  4 08:59:19 freitag kernel: PCI: Discovered primary peer bus 09 [IRQ]
Feb  4 08:59:19 freitag kernel: PCI: Using IRQ router PIIX/ICH [8086/248c] at 0000:00:1f.0
Feb  4 08:59:19 freitag kernel: PCI: Found IRQ 11 for device 0000:00:1f.1
Feb  4 08:59:19 freitag kernel: PCI: Sharing IRQ 11 with 0000:00:1d.2
Feb  4 08:59:19 freitag kernel: PCI: Sharing IRQ 11 with 0000:02:02.0
Feb  4 08:59:19 freitag kernel: SBF: Simple Boot Flag extension found and enabled.
Feb  4 08:59:19 freitag kernel: SBF: Setting boot flags 0x1
Feb  4 08:59:19 freitag kernel: Machine check exception polling timer started.
Feb  4 08:59:19 freitag kernel: apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
Feb  4 08:59:19 freitag kernel: ikconfig 0.7 with /proc/config*
Feb  4 08:59:19 freitag kernel: Initializing Cryptographic API
Feb  4 08:59:19 freitag kernel: pty: 256 Unix98 ptys configured
Feb  4 08:59:19 freitag kernel: Using anticipatory io scheduler
Feb  4 08:59:19 freitag kernel: Floppy drive(s): fd0 is 1.44M
Feb  4 08:59:19 freitag kernel: FDC 0 is a National Semiconductor PC87306
Feb  4 08:59:19 freitag kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Feb  4 08:59:19 freitag kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Feb  4 08:59:19 freitag kernel: ICH3M: IDE controller at PCI slot 0000:00:1f.1
Feb  4 08:59:19 freitag kernel: PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
Feb  4 08:59:19 freitag kernel: PCI: Found IRQ 11 for device 0000:00:1f.1
Feb  4 08:59:19 freitag kernel: PCI: Sharing IRQ 11 with 0000:00:1d.2
Feb  4 08:59:19 freitag kernel: PCI: Sharing IRQ 11 with 0000:02:02.0
Feb  4 08:59:19 freitag kernel: ICH3M: chipset revision 2
Feb  4 08:59:19 freitag kernel: ICH3M: not 100%% native mode: will probe irqs later
Feb  4 08:59:19 freitag kernel:     ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
Feb  4 08:59:19 freitag kernel:     ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
Feb  4 08:59:19 freitag kernel: hda: IC25N040ATCS04-0, ATA DISK drive
Feb  4 08:59:19 freitag kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Feb  4 08:59:19 freitag kernel: hdc: HL-DT-STDVD-ROM GDR8081N, ATAPI CD/DVD-ROM drive
Feb  4 08:59:19 freitag kernel: ide1 at 0x170-0x177,0x376 on irq 15
Feb  4 08:59:19 freitag kernel: hda: max request size: 128KiB
Feb  4 08:59:19 freitag kernel: hda: 78140160 sectors (40007 MB) w/1768KiB Cache, CHS=65535/16/63, UDMA(100)
Feb  4 08:59:19 freitag kernel:  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
Feb  4 08:59:19 freitag kernel: mice: PS/2 mouse device common for all mice
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 20 -> i8042 (command) [0]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 47 <- i8042 (return) [0]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [1]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [1]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d3 -> i8042 (command) [2]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 5a -> i8042 (parameter) [2]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: a5 <- i8042 (return) [2]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: a7 -> i8042 (command) [3]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 20 -> i8042 (command) [3]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 76 <- i8042 (return) [3]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: a8 -> i8042 (command) [5]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 20 -> i8042 (command) [5]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 56 <- i8042 (return) [5]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [7]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 74 -> i8042 (parameter) [7]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [7]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 54 -> i8042 (parameter) [7]
Feb  4 08:59:19 freitag kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [8]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [8]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [10]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [10]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [14]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux, 12) [15]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [15]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 54 -> i8042 (parameter) [15]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [16]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 44 -> i8042 (parameter) [16]
Feb  4 08:59:19 freitag kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [17]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 45 -> i8042 (parameter) [17]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: f2 -> i8042 (kbd-data) [18]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [19]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: ab <- i8042 (interrupt, kbd, 1) [19]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 54 <- i8042 (interrupt, kbd, 1) [19]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: ed -> i8042 (kbd-data) [19]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [20]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [20]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [22]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: f3 -> i8042 (kbd-data) [22]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [23]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [23]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [23]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: f4 -> i8042 (kbd-data) [23]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [24]
Feb  4 08:59:19 freitag kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Feb  4 08:59:19 freitag kernel: NET: Registered protocol family 2
Feb  4 08:59:19 freitag kernel: IP: routing cache hash table of 8192 buckets, 64Kbytes
Feb  4 08:59:19 freitag kernel: TCP: Hash tables configured (established 262144 bind 65536)
Feb  4 08:59:19 freitag kernel: NET: Registered protocol family 1
Feb  4 08:59:19 freitag kernel: NET: Registered protocol family 15
Feb  4 08:59:19 freitag kernel: kjournald starting.  Commit interval 5 seconds
Feb  4 08:59:19 freitag kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb  4 08:59:19 freitag kernel: VFS: Mounted root (ext3 filesystem) readonly.
Feb  4 08:59:19 freitag kernel: Freeing unused kernel memory: 124k freed
Feb  4 08:59:19 freitag kernel: blk: queue efc52e00, I/O limit 4095Mb (mask 0xffffffff)
Feb  4 08:59:19 freitag kernel: Adding 521600k swap on /dev/hda6.  Priority:-1 extents:1
Feb  4 08:59:19 freitag kernel: EXT3 FS on hda7, internal journal
Feb  4 08:59:19 freitag kernel: Real Time Clock Driver v1.12
Feb  4 08:59:19 freitag kernel: Linux Kernel Card Services
Feb  4 08:59:19 freitag kernel:   options:  [pci] [cardbus] [pm]
Feb  4 08:59:19 freitag kernel: PCI: Found IRQ 11 for device 0000:02:00.0
Feb  4 08:59:19 freitag kernel: PCI: Sharing IRQ 11 with 0000:00:1d.0
Feb  4 08:59:19 freitag kernel: PCI: Sharing IRQ 11 with 0000:01:00.0
Feb  4 08:59:19 freitag kernel: Yenta: CardBus bridge found at 0000:02:00.0 [1014:0512]
Feb  4 08:59:19 freitag kernel: Yenta: Using INTVAL to route CSC interrupts to PCI
Feb  4 08:59:19 freitag kernel: Yenta: Routing CardBus interrupts to PCI
Feb  4 08:59:19 freitag kernel: Yenta: ISA IRQ mask 0x06b8, PCI irq 11
Feb  4 08:59:19 freitag kernel: Socket status: 30000006
Feb  4 08:59:19 freitag kernel: PCI: Found IRQ 11 for device 0000:02:00.1
Feb  4 08:59:19 freitag kernel: PCI: Sharing IRQ 11 with 0000:00:1f.3
Feb  4 08:59:19 freitag kernel: PCI: Sharing IRQ 11 with 0000:00:1f.5
Feb  4 08:59:19 freitag kernel: PCI: Sharing IRQ 11 with 0000:00:1f.6
Feb  4 08:59:19 freitag kernel: Yenta: CardBus bridge found at 0000:02:00.1 [1014:0512]
Feb  4 08:59:19 freitag kernel: Yenta: Using INTVAL to route CSC interrupts to PCI
Feb  4 08:59:19 freitag kernel: Yenta: Routing CardBus interrupts to PCI
Feb  4 08:59:19 freitag kernel: Yenta: ISA IRQ mask 0x06b8, PCI irq 11
Feb  4 08:59:19 freitag kernel: Socket status: 30000010
Feb  4 08:59:19 freitag kernel: Intel(R) PRO/100 Network Driver - version 2.3.30-k1
Feb  4 08:59:19 freitag kernel: Copyright (c) 2003 Intel Corporation
Feb  4 08:59:19 freitag kernel: 
Feb  4 08:59:19 freitag kernel: PCI: Found IRQ 11 for device 0000:02:08.0
Feb  4 08:59:19 freitag kernel: e100: selftest OK.
Feb  4 08:59:19 freitag kernel: e100: eth0: Intel(R) PRO/100 Network Connection
Feb  4 08:59:19 freitag kernel:   Hardware receive checksums enabled
Feb  4 08:59:19 freitag kernel: 
Feb  4 08:59:19 freitag kernel: Linux agpgart interface v0.100 (c) Dave Jones
Feb  4 08:59:19 freitag kernel: NTFS driver 2.1.6 [Flags: R/O MODULE].
Feb  4 08:59:19 freitag kernel: NET: Registered protocol family 17
Feb  4 08:59:19 freitag kernel: [drm] Initialized radeon 1.9.0 20020828 on minor 0
Feb  4 08:59:19 freitag kernel: drivers/usb/core/usb.c: registered new driver usbfs
Feb  4 08:59:19 freitag kernel: drivers/usb/core/usb.c: registered new driver hub
Feb  4 08:59:19 freitag kernel: drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
Feb  4 08:59:19 freitag kernel: PCI: Found IRQ 11 for device 0000:00:1d.0
Feb  4 08:59:19 freitag kernel: PCI: Sharing IRQ 11 with 0000:01:00.0
Feb  4 08:59:19 freitag kernel: PCI: Sharing IRQ 11 with 0000:02:00.0
Feb  4 08:59:19 freitag kernel: uhci_hcd 0000:00:1d.0: UHCI Host Controller
Feb  4 08:59:19 freitag kernel: PCI: Setting latency timer of device 0000:00:1d.0 to 64
Feb  4 08:59:19 freitag kernel: uhci_hcd 0000:00:1d.0: irq 11, io base 00001800
Feb  4 08:59:19 freitag kernel: uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
Feb  4 08:59:19 freitag kernel: hub 1-0:1.0: USB hub found
Feb  4 08:59:19 freitag kernel: hub 1-0:1.0: 2 ports detected
Feb  4 08:59:19 freitag kernel: PCI: Found IRQ 11 for device 0000:00:1d.1
Feb  4 08:59:19 freitag kernel: uhci_hcd 0000:00:1d.1: UHCI Host Controller
Feb  4 08:59:19 freitag kernel: PCI: Setting latency timer of device 0000:00:1d.1 to 64
Feb  4 08:59:19 freitag kernel: uhci_hcd 0000:00:1d.1: irq 11, io base 00001820
Feb  4 08:59:19 freitag kernel: uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
Feb  4 08:59:19 freitag kernel: hub 2-0:1.0: USB hub found
Feb  4 08:59:19 freitag kernel: hub 2-0:1.0: 2 ports detected
Feb  4 08:59:19 freitag kernel: PCI: Found IRQ 11 for device 0000:00:1d.2
Feb  4 08:59:19 freitag kernel: PCI: Sharing IRQ 11 with 0000:00:1f.1
Feb  4 08:59:19 freitag kernel: PCI: Sharing IRQ 11 with 0000:02:02.0
Feb  4 08:59:19 freitag kernel: uhci_hcd 0000:00:1d.2: UHCI Host Controller
Feb  4 08:59:19 freitag kernel: PCI: Setting latency timer of device 0000:00:1d.2 to 64
Feb  4 08:59:19 freitag kernel: uhci_hcd 0000:00:1d.2: irq 11, io base 00001840
Feb  4 08:59:19 freitag kernel: uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
Feb  4 08:59:19 freitag kernel: hub 3-0:1.0: USB hub found
Feb  4 08:59:19 freitag kernel: hub 3-0:1.0: 2 ports detected
Feb  4 08:59:19 freitag kernel: drivers/usb/core/usb.c: registered new driver hiddev
Feb  4 08:59:19 freitag kernel: drivers/usb/core/usb.c: registered new driver hid
Feb  4 08:59:19 freitag kernel: drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [10546]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 47 -> i8042 (parameter) [10546]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [10546]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [10546]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [10550]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux, 12) [10551]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [10551]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: f6 -> i8042 (parameter) [10551]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [10554]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [10554]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [10554]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [10559]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [10559]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [10559]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [10562]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [10562]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [10562]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [10566]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [10566]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [10566]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [10571]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [10571]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [10571]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [10573]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [10573]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [10573]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [10577]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [10993]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [10993]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [10996]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [10996]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [10996]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [10999]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [10999]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: e9 -> i8042 (parameter) [10999]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [11002]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 09 <- i8042 (interrupt, aux, 12) [11004]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 47 <- i8042 (interrupt, aux, 12) [11006]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 15 <- i8042 (interrupt, aux, 12) [11007]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [11007]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: ff -> i8042 (parameter) [11007]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [11010]
Feb  4 08:59:19 freitag kernel: hub 2-0:1.0: new USB device on port 2, assigned address 2
Feb  4 08:59:19 freitag kernel: hub 2-2:1.0: USB hub found
Feb  4 08:59:19 freitag kernel: hub 2-2:1.0: 4 ports detected
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: aa <- i8042 (interrupt, aux, 12) [11411]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux, 12) [11412]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [11412]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: e6 -> i8042 (parameter) [11412]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [11415]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [11415]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [11415]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [11418]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [11418]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [11418]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [11421]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [11421]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [11421]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [11423]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [11423]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [11423]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [11426]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [11426]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [11426]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [11429]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [11429]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [11429]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [11431]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [11431]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [11431]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [11434]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [11434]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [11434]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [11437]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [11437]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: e9 -> i8042 (parameter) [11437]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [11440]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 09 <- i8042 (interrupt, aux, 12) [11441]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 47 <- i8042 (interrupt, aux, 12) [11442]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 15 <- i8042 (interrupt, aux, 12) [11444]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [11444]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: e6 -> i8042 (parameter) [11444]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [11447]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [11447]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [11447]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [11449]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [11479]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [11479]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [11482]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [11482]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [11482]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [11485]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [11485]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [11485]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [11488]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [11488]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [11488]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [11491]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [11491]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [11491]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [11493]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [11493]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [11493]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [11496]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [11496]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 03 -> i8042 (parameter) [11496]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [11499]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [11499]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: e9 -> i8042 (parameter) [11499]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [11502]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 2c <- i8042 (interrupt, aux, 12) [11503]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 6a <- i8042 (interrupt, aux, 12) [11505]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: b1 <- i8042 (interrupt, aux, 12) [11507]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [11507]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: e6 -> i8042 (parameter) [11507]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [11510]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [11510]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [11510]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [11513]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [11513]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [11513]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [11516]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [11516]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [11516]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [11519]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [11519]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [11519]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [11522]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [11522]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [11522]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [11525]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [11525]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [11525]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [11527]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [11527]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [11527]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [11530]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [11530]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 02 -> i8042 (parameter) [11530]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [11533]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [11533]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: e9 -> i8042 (parameter) [11533]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [11535]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 88 <- i8042 (interrupt, aux, 12) [11537]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 47 <- i8042 (interrupt, aux, 12) [11538]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 93 <- i8042 (interrupt, aux, 12) [11539]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [11539]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: e6 -> i8042 (parameter) [11539]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [11542]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [11542]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [11542]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [11545]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [11545]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 03 -> i8042 (parameter) [11545]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [11548]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [11548]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [11548]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [11550]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [11550]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [11550]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [11553]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [11553]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [11553]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [11556]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [11556]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 01 -> i8042 (parameter) [11556]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [11559]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [11559]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [11559]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [11562]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [11562]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 01 -> i8042 (parameter) [11562]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [11565]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [11565]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: f3 -> i8042 (parameter) [11565]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [11568]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [11568]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: 14 -> i8042 (parameter) [11568]
Feb  4 08:59:19 freitag kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [11571]
Feb  4 08:59:19 freitag kernel: Synaptics Touchpad, model: 1
Feb  4 08:59:19 freitag kernel:  Firmware: 5.9
Feb  4 08:59:19 freitag kernel:  Sensor: 44
Feb  4 08:59:19 freitag kernel:  new absolute packet format
Feb  4 08:59:19 freitag kernel:  Touchpad has extended capability bits
Feb  4 08:59:19 freitag kernel:  -> multifinger detection
Feb  4 08:59:19 freitag kernel:  -> palm detection
Feb  4 08:59:19 freitag kernel:  -> pass-through port
Feb  4 08:59:19 freitag kernel: input: SynPS/2 Synaptics TouchPad on isa0060/serio1


Now off to burning my logfiles ...

Jürgen

-- 
Jürgen Stuber <stuber@loria.fr>
http://www.loria.fr/~stuber/
