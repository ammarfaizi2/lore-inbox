Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbTH3UeS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 16:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262204AbTH3UeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 16:34:18 -0400
Received: from luli.rootdir.de ([213.133.108.222]:47581 "HELO luli.rootdir.de")
	by vger.kernel.org with SMTP id S262181AbTH3UeH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 16:34:07 -0400
Date: Sat, 30 Aug 2003 22:33:53 +0200
From: Claas Langbehn <claas@rootdir.de>
To: kernel list <linux-kernel@vger.kernel.org>
Cc: andrew.grover@intel.com, paul.s.diefenbaugh@intel.com
Subject: 2.6.0-test4 acpi problems
Message-ID: <20030830203353.GA967@rootdir.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Reply-By: Di Sep  2 22:08:38 CEST 2003
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.0-test4 i686
X-No-archive: yes
X-Uptime: 22:08:38 up 6 min,  5 users,  load average: 0.02, 0.12, 0.08
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!


I have got an Epox 8K9A9i mainboard with an Athlon XP 1800+ CPU. The
chipset is an VIA KT400A. The bios is dated 12.05.2003.
When booting with ACPI enabled, the interrupts dont get enumerated
properly. with acpi=ht it works, but i dont have enough features.
Below you see my bootlog with acpi and further down the bootlog with 
acpi=off. Is there a way to use full acpi support and "normal"
interrupts? pci=noacpi was not really successful.

How can I help acip development and do more debugging?


Regards, claas


# ------------------------------------------
# booting normal, acpi and apm in kernel
# ------------------------------------------

kernel: klogd 1.4.1#11, log source = /proc/kmsg started.
kernel: Cannot find map file.
kernel: No module symbols loaded - kernel modules not enabled. 
#--------> it seems like there are some lines missing here. strange thing
kernel: 022.84 BogoMIPS       
kernel: Memory: 514228k/524224k available (2669k kernel code, 9252k reserved, 827k data, 344k init, 0k highmem)
kernel: Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
kernel: Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
kernel: -> /dev
kernel: -> /dev/console
kernel: -> /root
kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
kernel: CPU: L2 Cache: 256K (64 bytes/line)
kernel: Intel machine check architecture supported.
kernel: Intel machine check reporting enabled on CPU#0.
kernel: CPU: AMD Athlon(tm) XP 1800+ stepping 01
kernel: Enabling fast FPU save and restore... done.
kernel: Enabling unmasked SIMD FPU exception support... done.
kernel: Checking 'hlt' instruction... OK.
kernel: POSIX conformance testing by UNIFIX
kernel: enabled ExtINT on CPU#0
kernel: ESR value before enabling vector: 00000000
kernel: ESR value after enabling vector: 00000000
kernel: ENABLING IO-APIC IRQs
kernel: ..TIMER: vector=0x31 pin1=2 pin2=-1
kernel: testing the IO APIC.......................
kernel: .................................... done.
kernel: Using local APIC timer interrupts.
kernel: calibrating APIC timer ...
kernel: ..... CPU clock speed is 1532.0957 MHz.
kernel: ..... host bus clock speed is 266.0601 MHz.
kernel: Initializing RT netlink socket
kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb370, last bus=1
kernel: PCI: Using configuration type 1
kernel: mtrr: v2.0 (20020519)
kernel: BIO: pool of 256 setup, 15Kb (60 bytes/bio)
kernel: biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
kernel: biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
kernel: biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
kernel: biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
kernel: biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
kernel: biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
kernel: ACPI: Subsystem revision 20030813
kernel:  tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
kernel: Parsing all Control Methods:............................................................................................................................................
kernel: Table [DSDT](id F004) - 515 Objects with 48 Devices 140 Methods 28 Regions
kernel: ACPI Namespace successfully loaded at root c04d79dc
kernel: evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
kernel: evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at 0000000000004020 on int 9
kernel: Completing Region/Field/Buffer/Package initialization:...............................................................................
kernel: Initialized 28/28 Regions 13/13 Fields 20/20 Buffers 18/18 Packages (523 nodes)
kernel: Executing all Device _STA and_INI methods:.................................................
kernel: 49 Devices found containing: 49 _STA, 2 _INI methods
kernel: ACPI: Interpreter enabled
kernel: ACPI: Using IOAPIC for interrupt routing
kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
kernel: PCI: Probing PCI hardware (bus 00)
kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 11 *12 14 15)
kernel: pci_link-0263 [17] acpi_pci_link_get_curr: No IRQ resource found
kernel: ACPI: PCI Interrupt Link [ALKA] (IRQs 20, disabled)
kernel: pci_link-0263 [19] acpi_pci_link_get_curr: No IRQ resource found
kernel: ACPI: PCI Interrupt Link [ALKB] (IRQs 21, disabled)
kernel: pci_link-0263 [21] acpi_pci_link_get_curr: No IRQ resource found
kernel: ACPI: PCI Interrupt Link [ALKC] (IRQs 22, disabled)
kernel: pci_link-0263 [23] acpi_pci_link_get_curr: No IRQ resource found
kernel: ACPI: PCI Interrupt Link [ALKD] (IRQs 23, disabled)
kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
kernel: SCSI subsystem initialized
kernel: drivers/usb/core/usb.c: registered new driver usbfs
kernel: drivers/usb/core/usb.c: registered new driver hub
kernel: pci_link-0263 [22] acpi_pci_link_get_curr: No IRQ resource found
kernel: ACPI: Unable to set IRQ for PCI Interrupt Link [ALKB] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
last message repeated 3 times
kernel: ACPI: Unable to set IRQ for PCI Interrupt Link [ALKA] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
kernel: ACPI: Unable to set IRQ for PCI Interrupt Link [ALKB] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
kernel: ACPI: Unable to set IRQ for PCI Interrupt Link [ALKC] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
kernel: ACPI: Unable to set IRQ for PCI Interrupt Link [ALKD] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
kernel: pci_link-0263 [38] acpi_pci_link_get_curr: No IRQ resource found
kernel: ACPI: Unable to set IRQ for PCI Interrupt Link [ALKD] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
last message repeated 3 times
kernel: ACPI: Unable to set IRQ for PCI Interrupt Link [ALKB] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
kernel: pci_link-0263 [50] acpi_pci_link_get_curr: No IRQ resource found
kernel: ACPI: Unable to set IRQ for PCI Interrupt Link [ALKB] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
kernel: pci_link-0263 [52] acpi_pci_link_get_curr: No IRQ resource found
kernel: ACPI: Unable to set IRQ for PCI Interrupt Link [ALKB] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
kernel: pci_link-0263 [54] acpi_pci_link_get_curr: No IRQ resource found
kernel: ACPI: Unable to set IRQ for PCI Interrupt Link [ALKB] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
kernel: pci_link-0263 [56] acpi_pci_link_get_curr: No IRQ resource found
kernel: ACPI: Unable to set IRQ for PCI Interrupt Link [ALKA] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
kernel: pci_link-0263 [58] acpi_pci_link_get_curr: No IRQ resource found
kernel: ACPI: Unable to set IRQ for PCI Interrupt Link [ALKC] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
kernel: pci_link-0263 [60] acpi_pci_link_get_curr: No IRQ resource found
kernel: ACPI: Unable to set IRQ for PCI Interrupt Link [ALKD] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
kernel: PCI: Using ACPI for IRQ routing
kernel: PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
kernel: pty: 256 Unix98 ptys configured
kernel: apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
kernel: apm: overridden by ACPI.
kernel: ikconfig 0.5 with /proc/ikconfig
kernel: Journalled Block Device driver loaded
kernel: devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
kernel: devfs: boot_options: 0x1
kernel: udf: registering filesystem
kernel: SGI XFS for Linux with no debug enabled
kernel: Initializing Cryptographic API
kernel: PCI: Via IRQ fixup for 0000:00:10.0, from 11 to 13
kernel: PCI: Via IRQ fixup for 0000:00:10.1, from 5 to 13
kernel: PCI: Via IRQ fixup for 0000:00:10.2, from 10 to 13


# ------------------------------------------
# booting with acip=off
# ------------------------------------------

kernel: klogd 1.4.1#11, log source = /proc/kmsg started.
kernel: Cannot find map file.
kernel: No module symbols loaded - kernel modules not enabled. 
) (gcc version 3.3.2 20030812 (Debian prerelease)) #6 Sat Aug 30 21:08:06 CEST 2003
kernel: Video mode to be used for restore is ffff
kernel: BIOS-provided physical RAM map:
kernel:  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
kernel:  BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
kernel:  BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
kernel:  BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
kernel: 511MB LOWMEM available.
kernel: found SMP MP-table at 000f5a10
kernel: hm, page 000f5000 reserved twice.
kernel: hm, page 000f6000 reserved twice.
kernel: hm, page 000f1000 reserved twice.
kernel: hm, page 000f2000 reserved twice.
kernel: On node 0 totalpages: 131056
kernel:   DMA zone: 4096 pages, LIFO batch:1
kernel:   Normal zone: 126960 pages, LIFO batch:16
kernel:   HighMem zone: 0 pages, LIFO batch:1
kernel: DMI 2.2 present.
kernel: Intel MultiProcessor Specification v1.4
kernel:     Virtual Wire compatibility mode.
kernel: OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
kernel: Processor #0 6:8 APIC version 17
kernel: I/O APIC #2 Version 17 at 0xFEC00000.
kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
kernel: Processors: 1
kernel: Building zonelist for node : 0
kernel: Kernel command line: root=/dev/hda1 devfs=mount acpi=off
kernel: Initializing CPU#0
kernel: PID hash table entries: 2048 (order 11: 16384 bytes)
kernel: Detected 1533.329 MHz processor.
kernel: Console: colour VGA+ 80x25
kernel: Calibrating delay loop... 3022.84 BogoMIPS
kernel: Memory: 514228k/524224k available (2669k kernel code, 9252k reserved, 827k data, 344k init, 0k highmem)
kernel: Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
kernel: Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
kernel: -> /dev
kernel: -> /dev/console
kernel: -> /root
kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
kernel: CPU: L2 Cache: 256K (64 bytes/line)
kernel: Intel machine check architecture supported.
kernel: Intel machine check reporting enabled on CPU#0.
kernel: CPU: AMD Athlon(tm) XP 1800+ stepping 01
kernel: Enabling fast FPU save and restore... done.
kernel: Enabling unmasked SIMD FPU exception support... done.
kernel: Checking 'hlt' instruction... OK.
kernel: POSIX conformance testing by UNIFIX
kernel: enabled ExtINT on CPU#0
kernel: ESR value before enabling vector: 00000000
kernel: ESR value after enabling vector: 00000000
kernel: ENABLING IO-APIC IRQs
kernel: Setting 2 in the phys_id_present_map
kernel: ...changing IO-APIC physical APIC ID to 2 ... ok.
kernel: ..TIMER: vector=0x31 pin1=2 pin2=0
kernel: testing the IO APIC.......................
kernel: .................................... done.
kernel: Using local APIC timer interrupts.
kernel: calibrating APIC timer ...
kernel: ..... CPU clock speed is 1532.0957 MHz.
kernel: ..... host bus clock speed is 266.0601 MHz.
kernel: Initializing RT netlink socket
kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb370, last bus=1
kernel: PCI: Using configuration type 1
kernel: mtrr: v2.0 (20020519)
kernel: BIO: pool of 256 setup, 15Kb (60 bytes/bio)
kernel: biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
kernel: biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
kernel: biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
kernel: biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
kernel: biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
kernel: biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
kernel: ACPI: Subsystem revision 20030813
kernel: ACPI: Interpreter disabled.
kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
kernel: SCSI subsystem initialized
kernel: drivers/usb/core/usb.c: registered new driver usbfs
kernel: drivers/usb/core/usb.c: registered new driver hub
kernel: ACPI: ACPI tables contain no PCI IRQ routing entries
kernel: PCI: Invalid ACPI-PCI IRQ routing table
kernel: PCI: Probing PCI hardware
kernel: PCI: Probing PCI hardware (bus 00)
kernel: PCI: Using IRQ router VIA [1106/3177] at 0000:00:11.0
kernel: PCI->APIC IRQ transform: (B0,I16,P0) -> 21
kernel: PCI->APIC IRQ transform: (B0,I16,P1) -> 21
kernel: PCI->APIC IRQ transform: (B0,I16,P2) -> 21
kernel: PCI->APIC IRQ transform: (B0,I16,P3) -> 21
kernel: PCI->APIC IRQ transform: (B0,I17,P0) -> 22
kernel: PCI->APIC IRQ transform: (B0,I17,P2) -> 22
kernel: PCI->APIC IRQ transform: (B0,I18,P0) -> 23
kernel: PCI->APIC IRQ transform: (B1,I0,P0) -> 16
kernel: pty: 256 Unix98 ptys configured
kernel: apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
kernel: ikconfig 0.5 with /proc/ikconfig
kernel: Journalled Block Device driver loaded
kernel: devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
kernel: devfs: boot_options: 0x1
kernel: udf: registering filesystem
kernel: SGI XFS for Linux with no debug enabled
kernel: Initializing Cryptographic API
kernel: PCI: Via IRQ fixup for 0000:00:10.0, from 11 to 5
kernel: PCI: Via IRQ fixup for 0000:00:10.2, from 10 to 5




EOF
