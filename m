Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267223AbRGQW5L>; Tue, 17 Jul 2001 18:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267338AbRGQW5E>; Tue, 17 Jul 2001 18:57:04 -0400
Received: from mail.zmailer.org ([194.252.70.162]:3598 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S267223AbRGQW44>;
	Tue, 17 Jul 2001 18:56:56 -0400
Date: Wed, 18 Jul 2001 02:01:20 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: linux-kernel@vger.kernel.org, linux-smp@vger.kernel.org
Subject: ASUS CUV4X-D** MPS1.1/MPS1.4 data differences...
Message-ID: <20010718020120.G5559@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	This is recently popularly problematic system with
	BIOS version 1010.  This is sister model of ASUS CUV4X-DLS;
	without the onboard ethernet, and the onboard SCSI.
	Same BIOS is used at all versions of the board.

	The logs below are with same kernel (2.4.6-ac5) at
	same machine (ASUS CUV4X-D, 512 MB, 2xP-III 866)

	With MPSpec1.4 active, only "noapic" boots.
	With MPSpec1.1 active, even apicfull setup boots.

	Indeed reading the code gives me an impression that
	the  arch/i386/kernel/mpparse.c  understands only
	MPSpec1.1 data, and that Linux should not attempt to
	boot with anything else.  (No, I don't know, this
	is just an impression.)   The MPSpec1.4 data has
	some extended dataset, which possibly needs to be
	analyzed for successfull booting.

	On the other hand, my old Dual-CPU PPro200 system
	with MPS1.1 data does not boot without 'noapic' :-/


	My kernel has been modified slightly to do some
	debug printouts which are by default off, or don't
	exist at all...

	There are marked differences in the IRQ data.

	The ACPI data in case of MPSpec1.1 and MPSpec1.4
	are the same (while MP data are not):

	- I/O APIC #2 @ 0xfec00000
	- Interrupt source override 0->2
	- Interrupt source override 9->9
	- Processor local APIC #3 for cpu #0
	- Processor local APIC #0 for cpu #1

/Matti Aarnio


Jul 19 00:50:42 mea kernel: Intel MultiProcessor Specification v1.1
Jul 19 00:50:42 mea kernel:     Virtual Wire compatibility mode.
Jul 19 00:50:42 mea kernel:  000f50c4   0: 50 43 4d 50 fc 00 01 e3 4f 45 4d 30 30 30 30 30
Jul 19 00:50:42 mea kernel:  000f50d4  16: 50 52 4f 44 30 30 30 30 30 30 30 30 00 00 00 00
Jul 19 00:50:42 mea kernel:  000f50e4  32: 00 00 17 00 00 00 e0 fe 00 00 00 00
Jul 19 00:50:42 mea kernel: OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Jul 19 00:50:42 mea kernel: Processor #3 Pentium(tm) Pro APIC version 17
Jul 19 00:50:42 mea kernel:     Floating point unit present.
Jul 19 00:50:42 mea kernel:     Machine Exception supported.
Jul 19 00:50:42 mea kernel:     64 bit compare & exchange supported.
Jul 19 00:50:42 mea kernel:     Internal APIC present.
Jul 19 00:50:42 mea kernel:     SEP present.
Jul 19 00:50:42 mea kernel:     MTRR  present.
Jul 19 00:50:42 mea kernel:     PGE  present.
Jul 19 00:50:42 mea kernel:     MCA  present.
Jul 19 00:50:42 mea kernel:     CMOV  present.
Jul 19 00:50:42 mea kernel:     PAT  present.
Jul 19 00:50:42 mea kernel:     PSE  present.
Jul 19 00:50:42 mea kernel:     PSN  present.
Jul 19 00:50:42 mea kernel:     MMX  present.
Jul 19 00:50:42 mea kernel:     FXSR  present.
Jul 19 00:50:42 mea kernel:     XMM  present.
Jul 19 00:50:42 mea kernel:     Bootup CPU
Jul 19 00:50:42 mea kernel: Processor #0 Pentium(tm) Pro APIC version 17
Jul 19 00:50:42 mea kernel:     Floating point unit present.
Jul 19 00:50:42 mea kernel:     Machine Exception supported.
Jul 19 00:50:42 mea kernel:     64 bit compare & exchange supported.
Jul 19 00:50:42 mea kernel:     Internal APIC present.
Jul 19 00:50:42 mea kernel:     SEP present.
Jul 19 00:50:42 mea kernel:     MTRR  present.
Jul 19 00:50:42 mea kernel:     PGE  present.
Jul 19 00:50:42 mea kernel:     MCA  present.
Jul 19 00:50:42 mea kernel:     CMOV  present.
Jul 19 00:50:42 mea kernel:     PAT  present.
Jul 19 00:50:42 mea kernel:     PSE  present.
Jul 19 00:50:42 mea kernel:     PSN  present.
Jul 19 00:50:42 mea kernel:     MMX  present.
Jul 19 00:50:42 mea kernel:     FXSR  present.
Jul 19 00:50:42 mea kernel:     XMM  present.
Jul 19 00:50:42 mea kernel: Bus #0 is PCI   
Jul 19 00:50:42 mea kernel: Bus #1 is PCI   
Jul 19 00:50:42 mea kernel: Bus #2 is ISA   
Jul 19 00:50:42 mea kernel: I/O APIC #2 Version 17 at 0xFEC00000.
Jul 19 00:50:42 mea kernel: Int: type 3, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 00
Jul 19 00:50:42 mea kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 01, APIC ID 2, APIC INT 01
Jul 19 00:50:42 mea kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 02
Jul 19 00:50:42 mea kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 03, APIC ID 2, APIC INT 03
Jul 19 00:50:42 mea kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 04, APIC ID 2, APIC INT 04
Jul 19 00:50:42 mea kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 06, APIC ID 2, APIC INT 06
Jul 19 00:50:42 mea kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 07, APIC ID 2, APIC INT 07
Jul 19 00:50:42 mea kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 08, APIC ID 2, APIC INT 08
Jul 19 00:50:42 mea kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 0c, APIC ID 2, APIC INT 0c
Jul 19 00:50:42 mea kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 0e, APIC ID 2, APIC INT 0e
Jul 19 00:50:42 mea kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 0f, APIC ID 2, APIC INT 0f
Jul 19 00:50:42 mea kernel: Int: type 0, pol 3, trig 3, bus 2, IRQ 0b, APIC ID 2, APIC INT 0b
Jul 19 00:50:42 mea kernel: Int: type 0, pol 3, trig 3, bus 2, IRQ 0a, APIC ID 2, APIC INT 0a
Jul 19 00:50:42 mea kernel: Int: type 0, pol 3, trig 3, bus 2, IRQ 05, APIC ID 2, APIC INT 05
Jul 19 00:50:42 mea kernel: Int: type 0, pol 3, trig 3, bus 2, IRQ 09, APIC ID 2, APIC INT 09
Jul 19 00:50:42 mea kernel: Lint: type 3, pol 1, trig 1, bus 2, IRQ 00, APIC ID ff, APIC LINT 00
Jul 19 00:50:42 mea kernel: Lint: type 1, pol 1, trig 1, bus 2, IRQ 00, APIC ID ff, APIC LINT 01
Jul 19 00:50:42 mea kernel: Processors: 2
Jul 19 00:50:42 mea kernel: mapped APIC to ffffe000 (fee00000)
Jul 19 00:50:42 mea kernel: mapped IOAPIC to ffffd000 (fec00000)
Jul 19 00:50:42 mea kernel: Kernel command line: auto BOOT_IMAGE=new ro root=902 BOOT_FILE=/boot/vmlinuz-2.4.6-ac5m
Jul 19 00:50:42 mea kernel: Initializing CPU#0
Jul 19 00:50:42 mea kernel: Detected 870.606 MHz processor.
Jul 19 00:50:42 mea kernel: Console: colour VGA+ 80x25
Jul 19 00:50:42 mea kernel: Calibrating delay loop... 1736.70 BogoMIPS
Jul 19 00:50:42 mea kernel: Memory: 511540k/524272k available (1872k kernel code, 12344k reserved, 645k data, 108k init, 0k highmem)
Jul 19 00:50:42 mea kernel: Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Jul 19 00:50:42 mea kernel: Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Jul 19 00:50:42 mea kernel: Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Jul 19 00:50:42 mea kernel: Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Jul 19 00:50:42 mea kernel: Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
Jul 19 00:50:42 mea kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Jul 19 00:50:42 mea kernel: CPU: L2 cache: 256K
Jul 19 00:50:42 mea kernel: Intel machine check architecture supported.
Jul 19 00:50:42 mea kernel: Intel machine check reporting enabled on CPU#0.
Jul 19 00:50:42 mea kernel: CPU serial number disabled.
Jul 19 00:50:42 mea kernel: Enabling fast FPU save and restore... done.
Jul 19 00:50:42 mea kernel: Enabling unmasked SIMD FPU exception support... done.
Jul 19 00:50:42 mea kernel: Checking 'hlt' instruction... OK.
Jul 19 00:50:42 mea kernel: POSIX conformance testing by UNIFIX
Jul 19 00:50:42 mea kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
Jul 19 00:50:42 mea kernel: mtrr: detected mtrr type: Intel
Jul 19 00:50:42 mea kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Jul 19 00:50:42 mea kernel: CPU: L2 cache: 256K
Jul 19 00:50:42 mea kernel: Intel machine check reporting enabled on CPU#0.
Jul 19 00:50:42 mea kernel: CPU0: Intel Pentium III (Coppermine) stepping 0a
Jul 19 00:50:42 mea kernel: per-CPU timeslice cutoff: 731.76 usecs.
Jul 19 00:50:42 mea kernel: Getting VERSION: 40011
Jul 19 00:50:42 mea kernel: Getting VERSION: 40011
Jul 19 00:50:42 mea kernel: Getting ID: 3000000
Jul 19 00:50:42 mea kernel: Getting ID: c000000
Jul 19 00:50:42 mea kernel: Getting LVT0: 8700
Jul 19 00:50:42 mea kernel: Getting LVT1: 400
Jul 19 00:50:42 mea kernel: enabled ExtINT on CPU#0
Jul 19 00:50:42 mea kernel: ESR value before enabling vector: 00000000
Jul 19 00:50:42 mea kernel: ESR value after enabling vector: 00000000
Jul 19 00:50:42 mea kernel: CPU present map: 9
Jul 19 00:50:42 mea kernel: Booting processor 1/0 eip 2000
Jul 19 00:50:42 mea kernel: Setting warm reset code and vector.
Jul 19 00:50:42 mea kernel: 1.
Jul 19 00:50:42 mea kernel: 2.
Jul 19 00:50:42 mea kernel: 3.
Jul 19 00:50:42 mea kernel: Asserting INIT.
Jul 19 00:50:42 mea kernel: Waiting for send to finish...
Jul 19 00:50:42 mea kernel: +Deasserting INIT.
Jul 19 00:50:42 mea kernel: Waiting for send to finish...
Jul 19 00:50:42 mea kernel: +#startup loops: 2.
Jul 19 00:50:42 mea kernel: Sending STARTUP #1.
Jul 19 00:50:42 mea kernel: After apic_write.
Jul 19 00:50:42 mea kernel: Initializing CPU#1
Jul 19 00:50:42 mea kernel: CPU#1 (phys ID: 0) waiting for CALLOUT
Jul 19 00:50:42 mea kernel: Startup point 1.
Jul 19 00:50:42 mea kernel: Waiting for send to finish...
Jul 19 00:50:42 mea kernel: +Sending STARTUP #2.
Jul 19 00:50:42 mea kernel: After apic_write.
Jul 19 00:50:42 mea kernel: Startup point 1.
Jul 19 00:50:42 mea kernel: Waiting for send to finish...
Jul 19 00:50:42 mea kernel: +After Startup.
Jul 19 00:50:42 mea kernel: Before Callout 1.
Jul 19 00:50:42 mea kernel: After Callout 1.
Jul 19 00:50:42 mea kernel: CALLIN, before setup_local_APIC().
Jul 19 00:50:42 mea kernel: masked ExtINT on CPU#1
Jul 19 00:50:42 mea kernel: ESR value before enabling vector: 00000000
Jul 19 00:50:42 mea kernel: ESR value after enabling vector: 00000000
Jul 19 00:50:42 mea kernel: Calibrating delay loop... 1736.70 BogoMIPS
Jul 19 00:50:42 mea kernel: Stack at about dfff1fb8
Jul 19 00:50:42 mea kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Jul 19 00:50:42 mea kernel: CPU: L2 cache: 256K
Jul 19 00:50:42 mea kernel: Intel machine check reporting enabled on CPU#1.
Jul 19 00:50:42 mea kernel: CPU serial number disabled.
Jul 19 00:50:42 mea kernel: OK.
Jul 19 00:50:42 mea kernel: CPU1: Intel Pentium III (Coppermine) stepping 0a
Jul 19 00:50:42 mea kernel: CPU has booted.
Jul 19 00:50:42 mea kernel: Before bogomips.
Jul 19 00:50:42 mea kernel: Total of 2 processors activated (3473.40 BogoMIPS).
Jul 19 00:50:42 mea kernel: Before bogocount - setting activated=1.
Jul 19 00:50:42 mea kernel: Boot done.
Jul 19 00:50:42 mea kernel: ENABLING IO-APIC IRQs
Jul 19 00:50:42 mea kernel: ...changing IO-APIC physical APIC ID to 2 ... ok.
Jul 19 00:50:42 mea kernel: Synchronizing Arb IDs.
Jul 19 00:50:42 mea kernel: ..TIMER: vector=0x31 pin1=2 pin2=0
Jul 19 00:50:42 mea kernel: testing the IO APIC.......................
Jul 19 00:50:42 mea kernel: 
Jul 19 00:50:42 mea kernel:  WARNING: unexpected IO-APIC, please mail
Jul 19 00:50:42 mea kernel:           to linux-smp@vger.kernel.org
Jul 19 00:50:42 mea kernel: .................................... done.
Jul 19 00:50:42 mea kernel: Using local APIC timer interrupts.
Jul 19 00:50:42 mea kernel: calibrating APIC timer ...
Jul 19 00:50:42 mea kernel: ..... CPU clock speed is 870.6079 MHz.
Jul 19 00:50:42 mea kernel: ..... host bus clock speed is 133.9395 MHz.
Jul 19 00:50:42 mea kernel: cpu: 0, clocks: 1339395, slice: 446465
Jul 19 00:50:42 mea kernel: CPU0<T0:1339392,T1:892912,D:15,S:446465,C:1339395>
Jul 19 00:50:42 mea kernel: cpu: 1, clocks: 1339395, slice: 446465
Jul 19 00:50:42 mea kernel: CPU1<T0:1339392,T1:446448,D:14,S:446465,C:1339395>
Jul 19 00:50:42 mea kernel: checking TSC synchronization across CPUs: passed.
Jul 19 00:50:42 mea kernel: Setting commenced=1, go go go
Jul 19 00:50:42 mea kernel: PCI: PCI BIOS revision 2.10 entry at 0xf0d20, last bus=1
Jul 19 00:50:42 mea kernel: PCI: Using configuration type 1
Jul 19 00:50:42 mea kernel: PCI: Probing PCI hardware
Jul 19 00:50:42 mea kernel: Unknown bridge resource 0: assuming transparent
Jul 19 00:50:42 mea kernel: PCI: Using IRQ router VIA [1106/0686] at 00:04.0
Jul 19 00:50:42 mea kernel: querying PCI -> IRQ mapping bus:0, slot:4, pin:3.
Jul 19 00:50:42 mea kernel: querying PCI -> IRQ mapping bus:0, slot:4, pin:3.
Jul 19 00:50:42 mea kernel: querying PCI -> IRQ mapping bus:0, slot:9, pin:0.
Jul 19 00:50:42 mea kernel: querying PCI -> IRQ mapping bus:0, slot:9, pin:1.
Jul 19 00:50:42 mea kernel: querying PCI -> IRQ mapping bus:0, slot:10, pin:0.
Jul 19 00:50:42 mea kernel: querying PCI -> IRQ mapping bus:0, slot:11, pin:0.
Jul 19 00:50:42 mea kernel: querying PCI -> IRQ mapping bus:0, slot:12, pin:0.
Jul 19 00:50:42 mea kernel: querying PCI -> IRQ mapping bus:0, slot:13, pin:0.
Jul 19 00:50:42 mea kernel: querying PCI -> IRQ mapping bus:1, slot:0, pin:0.
Jul 19 00:50:42 mea kernel: querying PCI -> IRQ mapping bus:0, slot:1, pin:0.
Jul 19 00:50:42 mea kernel: PCI: Enabling Via external APIC routing
Jul 19 00:50:42 mea kernel: Linux NET4.0 for Linux 2.4
Jul 19 00:50:42 mea kernel: Based upon Swansea University Computer Society NET3.039
Jul 19 00:50:42 mea kernel: Initializing RT netlink socket
Jul 19 00:50:42 mea kernel: Simple Boot Flag extension found and enabled.
Jul 19 00:50:42 mea kernel: Starting kswapd v1.8
Jul 19 00:50:42 mea kernel: devfs: v0.106 (20010617) Richard Gooch (rgooch@atnf.csiro.au)
Jul 19 00:50:42 mea kernel: devfs: boot_options: 0x2
Jul 19 00:50:42 mea kernel: ACPI: Core Subsystem version [20010615]
Jul 19 00:50:42 mea kernel: ACPI: Subsystem enabled
Jul 19 00:50:42 mea kernel: ACPI: System firmware supports S0 S1 S4 S5
Jul 19 00:50:42 mea kernel: Processor[0]: C0 C1
Jul 19 00:50:42 mea kernel: Processor[1]: C0 C1
Jul 19 00:50:42 mea kernel: Power Button: found
Jul 19 00:50:42 mea kernel: Power Button: found
Jul 19 00:50:42 mea kernel: pty: 256 Unix98 ptys configured
Jul 19 00:50:42 mea kernel: Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
Jul 19 00:50:42 mea kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Jul 19 00:50:42 mea kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A




Jul 19 00:41:23 mea kernel: Intel MultiProcessor Specification v1.4
Jul 19 00:41:23 mea kernel:     Virtual Wire compatibility mode.
Jul 19 00:41:23 mea kernel:  000f50c4   0: 50 43 4d 50 0c 01 04 f9 4f 45 4d 30 30 30 30 30
Jul 19 00:41:23 mea kernel:  000f50d4  16: 50 52 4f 44 30 30 30 30 30 30 30 30 00 00 00 00
Jul 19 00:41:23 mea kernel:  000f50e4  32: 00 00 19 00 00 00 e0 fe 7c 00 9a 00
Jul 19 00:41:23 mea kernel: OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Jul 19 00:41:23 mea kernel: Processor #3 Pentium(tm) Pro APIC version 17
Jul 19 00:41:23 mea kernel:     Floating point unit present.
Jul 19 00:41:23 mea kernel:     Machine Exception supported.
Jul 19 00:41:23 mea kernel:     64 bit compare & exchange supported.
Jul 19 00:41:23 mea kernel:     Internal APIC present.
Jul 19 00:41:23 mea kernel:     SEP present.
Jul 19 00:41:23 mea kernel:     MTRR  present.
Jul 19 00:41:23 mea kernel:     PGE  present.
Jul 19 00:41:23 mea kernel:     MCA  present.
Jul 19 00:41:23 mea kernel:     CMOV  present.
Jul 19 00:41:23 mea kernel:     PAT  present.
Jul 19 00:41:23 mea kernel:     PSE  present.
Jul 19 00:41:23 mea kernel:     PSN  present.
Jul 19 00:41:23 mea kernel:     MMX  present.
Jul 19 00:41:23 mea kernel:     FXSR  present.
Jul 19 00:41:23 mea kernel:     XMM  present.
Jul 19 00:41:23 mea kernel:     Bootup CPU
Jul 19 00:41:23 mea kernel: Processor #0 Pentium(tm) Pro APIC version 17
Jul 19 00:41:23 mea kernel:     Floating point unit present.
Jul 19 00:41:23 mea kernel:     Machine Exception supported.
Jul 19 00:41:23 mea kernel:     64 bit compare & exchange supported.
Jul 19 00:41:23 mea kernel:     Internal APIC present.
Jul 19 00:41:23 mea kernel:     SEP present.
Jul 19 00:41:23 mea kernel:     MTRR  present.
Jul 19 00:41:23 mea kernel:     PGE  present.
Jul 19 00:41:23 mea kernel:     MCA  present.
Jul 19 00:41:23 mea kernel:     CMOV  present.
Jul 19 00:41:23 mea kernel:     PAT  present.
Jul 19 00:41:23 mea kernel:     PSE  present.
Jul 19 00:41:23 mea kernel:     PSN  present.
Jul 19 00:41:23 mea kernel:     MMX  present.
Jul 19 00:41:23 mea kernel:     FXSR  present.
Jul 19 00:41:23 mea kernel:     XMM  present.
Jul 19 00:41:23 mea kernel: Bus #0 is PCI   
Jul 19 00:41:23 mea kernel: Bus #1 is PCI   
Jul 19 00:41:23 mea kernel: Bus #2 is ISA   
Jul 19 00:41:23 mea kernel: I/O APIC #2 Version 17 at 0xFEC00000.
Jul 19 00:41:23 mea kernel: Int: type 3, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 00
Jul 19 00:41:23 mea kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 01, APIC ID 2, APIC INT 01
Jul 19 00:41:23 mea kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 02
Jul 19 00:41:23 mea kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 03, APIC ID 2, APIC INT 03
Jul 19 00:41:23 mea kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 04, APIC ID 2, APIC INT 04
Jul 19 00:41:23 mea kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 06, APIC ID 2, APIC INT 06
Jul 19 00:41:23 mea kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 07, APIC ID 2, APIC INT 07
Jul 19 00:41:23 mea kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 08, APIC ID 2, APIC INT 08
Jul 19 00:41:23 mea kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 0c, APIC ID 2, APIC INT 0c
Jul 19 00:41:23 mea kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 0e, APIC ID 2, APIC INT 0e
Jul 19 00:41:23 mea kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 0f, APIC ID 2, APIC INT 0f
Jul 19 00:41:23 mea kernel: Int: type 0, pol 3, trig 3, bus 1, IRQ 00, APIC ID 2, APIC INT 10
Jul 19 00:41:23 mea kernel: Int: type 0, pol 3, trig 3, bus 2, IRQ 00, APIC ID 2, APIC INT 00
Jul 19 00:41:23 mea kernel: Int: type 0, pol 3, trig 3, bus 0, IRQ 13, APIC ID 2, APIC INT 12
Jul 19 00:41:23 mea kernel: Int: type 0, pol 3, trig 3, bus 0, IRQ 24, APIC ID 2, APIC INT 13
Jul 19 00:41:23 mea kernel: Int: type 0, pol 3, trig 3, bus 0, IRQ 25, APIC ID 2, APIC INT 10
Jul 19 00:41:23 mea kernel: Int: type 0, pol 3, trig 3, bus 0, IRQ 30, APIC ID 2, APIC INT 10
Jul 19 00:41:23 mea kernel: Lint: type 3, pol 1, trig 1, bus 2, IRQ 00, APIC ID ff, APIC LINT 00
Jul 19 00:41:23 mea kernel: Lint: type 1, pol 1, trig 1, bus 2, IRQ 00, APIC ID ff, APIC LINT 01
Jul 19 00:41:23 mea kernel: Processors: 2
Jul 19 00:41:23 mea kernel: mapped APIC to ffffe000 (fee00000)
Jul 19 00:41:23 mea kernel: mapped IOAPIC to ffffd000 (fec00000)
Jul 19 00:41:23 mea kernel: Kernel command line: BOOT_IMAGE=new ro root=902 BOOT_FILE=/boot/vmlinuz-2.4.6-ac5m noapic
Jul 19 00:41:23 mea kernel: Initializing CPU#0
Jul 19 00:41:23 mea kernel: Detected 870.589 MHz processor.
Jul 19 00:41:23 mea kernel: Console: colour VGA+ 80x25
Jul 19 00:41:23 mea kernel: Calibrating delay loop... 1736.70 BogoMIPS
Jul 19 00:41:23 mea kernel: Memory: 511540k/524272k available (1872k kernel code, 12344k reserved, 645k data, 108k init, 0k highmem)
Jul 19 00:41:23 mea kernel: Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Jul 19 00:41:23 mea kernel: Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Jul 19 00:41:23 mea kernel: Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Jul 19 00:41:23 mea kernel: Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Jul 19 00:41:23 mea kernel: Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
Jul 19 00:41:23 mea kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Jul 19 00:41:23 mea kernel: CPU: L2 cache: 256K
Jul 19 00:41:23 mea kernel: Intel machine check architecture supported.
Jul 19 00:41:23 mea kernel: Intel machine check reporting enabled on CPU#0.
Jul 19 00:41:23 mea kernel: CPU serial number disabled.
Jul 19 00:41:23 mea kernel: Enabling fast FPU save and restore... done.
Jul 19 00:41:23 mea kernel: Enabling unmasked SIMD FPU exception support... done.
Jul 19 00:41:23 mea kernel: Checking 'hlt' instruction... OK.
Jul 19 00:41:23 mea kernel: POSIX conformance testing by UNIFIX
Jul 19 00:41:23 mea kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
Jul 19 00:41:23 mea kernel: mtrr: detected mtrr type: Intel
Jul 19 00:41:23 mea kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Jul 19 00:41:23 mea kernel: CPU: L2 cache: 256K
Jul 19 00:41:23 mea kernel: Intel machine check reporting enabled on CPU#0.
Jul 19 00:41:23 mea kernel: CPU0: Intel Pentium III (Coppermine) stepping 0a
Jul 19 00:41:23 mea kernel: per-CPU timeslice cutoff: 731.76 usecs.
Jul 19 00:41:23 mea kernel: Getting VERSION: 40011
Jul 19 00:41:23 mea kernel: Getting VERSION: 40011
Jul 19 00:41:23 mea kernel: Getting ID: 3000000
Jul 19 00:41:23 mea kernel: Getting ID: c000000
Jul 19 00:41:23 mea kernel: Getting LVT0: 8700
Jul 19 00:41:23 mea kernel: Getting LVT1: 400
Jul 19 00:41:23 mea kernel: enabled ExtINT on CPU#0
Jul 19 00:41:23 mea kernel: ESR value before enabling vector: 00000000
Jul 19 00:41:23 mea kernel: ESR value after enabling vector: 00000000
Jul 19 00:41:23 mea kernel: CPU present map: 9
Jul 19 00:41:23 mea kernel: Booting processor 1/0 eip 2000
Jul 19 00:41:23 mea kernel: Setting warm reset code and vector.
Jul 19 00:41:23 mea kernel: 1.
Jul 19 00:41:23 mea kernel: 2.
Jul 19 00:41:23 mea kernel: 3.
Jul 19 00:41:23 mea kernel: Asserting INIT.
Jul 19 00:41:23 mea kernel: Waiting for send to finish...
Jul 19 00:41:23 mea kernel: +Deasserting INIT.
Jul 19 00:41:23 mea kernel: Waiting for send to finish...
Jul 19 00:41:23 mea kernel: +#startup loops: 2.
Jul 19 00:41:23 mea kernel: Sending STARTUP #1.
Jul 19 00:41:23 mea kernel: After apic_write.
Jul 19 00:41:23 mea kernel: Initializing CPU#1
Jul 19 00:41:23 mea kernel: CPU#1 (phys ID: 0) waiting for CALLOUT
Jul 19 00:41:23 mea kernel: Startup point 1.
Jul 19 00:41:23 mea kernel: Waiting for send to finish...
Jul 19 00:41:23 mea kernel: +Sending STARTUP #2.
Jul 19 00:41:23 mea kernel: After apic_write.
Jul 19 00:41:23 mea kernel: Startup point 1.
Jul 19 00:41:23 mea kernel: Waiting for send to finish...
Jul 19 00:41:23 mea kernel: +After Startup.
Jul 19 00:41:23 mea kernel: Before Callout 1.
Jul 19 00:41:23 mea kernel: After Callout 1.
Jul 19 00:41:23 mea kernel: CALLIN, before setup_local_APIC().
Jul 19 00:41:23 mea kernel: masked ExtINT on CPU#1
Jul 19 00:41:23 mea kernel: ESR value before enabling vector: 00000000
Jul 19 00:41:23 mea kernel: ESR value after enabling vector: 00000000
Jul 19 00:41:23 mea kernel: Calibrating delay loop... 1736.70 BogoMIPS
Jul 19 00:41:23 mea kernel: Stack at about dfff1fb8
Jul 19 00:41:23 mea kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Jul 19 00:41:23 mea kernel: CPU: L2 cache: 256K
Jul 19 00:41:23 mea kernel: Intel machine check reporting enabled on CPU#1.
Jul 19 00:41:23 mea kernel: CPU serial number disabled.
Jul 19 00:41:23 mea kernel: OK.
Jul 19 00:41:23 mea kernel: CPU1: Intel Pentium III (Coppermine) stepping 0a
Jul 19 00:41:23 mea kernel: CPU has booted.
Jul 19 00:41:23 mea kernel: Before bogomips.
Jul 19 00:41:23 mea kernel: Total of 2 processors activated (3473.40 BogoMIPS).
Jul 19 00:41:23 mea kernel: Before bogocount - setting activated=1.
Jul 19 00:41:23 mea kernel: Boot done.
Jul 19 00:41:23 mea kernel: Using local APIC timer interrupts.
Jul 19 00:41:23 mea kernel: calibrating APIC timer ...
Jul 19 00:41:23 mea kernel: ..... CPU clock speed is 870.5463 MHz.
Jul 19 00:41:23 mea kernel: ..... host bus clock speed is 133.9300 MHz.
Jul 19 00:41:23 mea kernel: cpu: 0, clocks: 1339300, slice: 446433
Jul 19 00:41:23 mea kernel: CPU0<T0:1339296,T1:892848,D:15,S:446433,C:1339300>
Jul 19 00:41:23 mea kernel: cpu: 1, clocks: 1339300, slice: 446433
Jul 19 00:41:23 mea kernel: CPU1<T0:1339296,T1:446416,D:14,S:446433,C:1339300>
Jul 19 00:41:23 mea kernel: checking TSC synchronization across CPUs: passed.
Jul 19 00:41:23 mea kernel: Setting commenced=1, go go go
Jul 19 00:41:23 mea kernel: PCI: PCI BIOS revision 2.10 entry at 0xf0d20, last bus=1
Jul 19 00:41:23 mea kernel: PCI: Using configuration type 1
Jul 19 00:41:23 mea kernel: PCI: Probing PCI hardware
Jul 19 00:41:23 mea kernel: Unknown bridge resource 0: assuming transparent
Jul 19 00:41:23 mea kernel: PCI: Using IRQ router VIA [1106/0686] at 00:04.0
Jul 19 00:41:23 mea kernel: PCI: Found IRQ 5 for device 00:0a.0
Jul 19 00:41:23 mea kernel: PCI: Sharing IRQ 5 with 00:04.2
Jul 19 00:41:23 mea kernel: PCI: Sharing IRQ 5 with 00:04.3
Jul 19 00:41:23 mea kernel: PCI: Found IRQ 9 for device 00:0d.0
Jul 19 00:41:23 mea kernel: PCI: Sharing IRQ 9 with 00:09.0
Jul 19 00:41:23 mea kernel: PCI: Enabling Via external APIC routing
Jul 19 00:41:23 mea kernel: Linux NET4.0 for Linux 2.4
Jul 19 00:41:23 mea kernel: Based upon Swansea University Computer Society NET3.039
Jul 19 00:41:23 mea kernel: Initializing RT netlink socket
Jul 19 00:41:23 mea kernel: Simple Boot Flag extension found and enabled.
Jul 19 00:41:23 mea kernel: Starting kswapd v1.8
Jul 19 00:41:23 mea kernel: devfs: v0.106 (20010617) Richard Gooch (rgooch@atnf.csiro.au)
Jul 19 00:41:23 mea kernel: devfs: boot_options: 0x2
Jul 19 00:41:23 mea kernel: ACPI: Core Subsystem version [20010615]
Jul 19 00:41:23 mea kernel: ACPI: Subsystem enabled
Jul 19 00:41:23 mea kernel: ACPI: System firmware supports S0 S1 S4 S5
Jul 19 00:41:23 mea kernel: Processor[0]: C0 C1
Jul 19 00:41:23 mea kernel: Processor[1]: C0 C1
Jul 19 00:41:23 mea kernel: Power Button: found
Jul 19 00:41:23 mea kernel: Power Button: found
Jul 19 00:41:23 mea kernel: pty: 256 Unix98 ptys configured
Jul 19 00:41:23 mea kernel: Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
Jul 19 00:41:23 mea kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Jul 19 00:41:23 mea kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A


