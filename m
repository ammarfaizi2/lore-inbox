Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268926AbRHFTBy>; Mon, 6 Aug 2001 15:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268929AbRHFTBs>; Mon, 6 Aug 2001 15:01:48 -0400
Received: from www.jamescleland.com ([208.185.9.98]:19328 "EHLO
	ria.jamescleland.com") by vger.kernel.org with ESMTP
	id <S268926AbRHFTB1>; Mon, 6 Aug 2001 15:01:27 -0400
Date: Mon, 6 Aug 2001 15:01:31 -0400 (EDT)
From: root <root@ria.jamescleland.com>
To: <linux-kernel@vger.kernel.org>
Subject: MTRR errors at startup... (fwd)
Message-ID: <Pine.LNX.4.33.0108061449360.10211-100000@ria.jamescleland.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was encouraged to forward this linux-smp mail to the lkml, so here you
go. I have recently subscribed to the digest, but I would still appreciate
a mail reply as I have not received a digest yet. The log messages in
question are those related to MTRR settings between the boot and the
second CPU. Please let me know if I can provide additional information.

James

___SNIP___

...what's the severity of the mtrr errors? Here are the hardware
specifics:

Abit VP6 dual w/PIII-1000's, both stepping 0x0A
512megs of Mushkin Rev3/CL2
AGP video
1 NIC/Tulip (LNE100TX v4)
Maxtor udma5 drives(2), etc, etc
Not using the highpoint controller, just the Via

This is, of course, a 2.4.7 build without patches.

Here is the relevant output from messages:
Aug  6 04:02:38 valerie syslogd 1.3-3: restart.
Aug  6 04:02:38 valerie syslog: syslogd startup succeeded
Aug  6 04:02:38 valerie kernel: klogd 1.3-3, log source = /proc/kmsg started.
Aug  6 04:02:38 valerie kernel: Inspecting /boot/System.map-2.4.7
Aug  6 04:02:38 valerie syslog: klogd startup succeeded
Aug  6 04:02:38 valerie portmap: portmap startup succeeded
Aug  6 04:02:38 valerie kernel: Loaded 15664 symbols from /boot/System.map-2.4.7.
Aug  6 04:02:38 valerie kernel: Symbols match kernel version 2.4.7.
Aug  6 04:02:38 valerie kernel: Loaded 35 symbols from 1 module.
Aug  6 04:02:38 valerie kernel: Linux version 2.4.7 (root@valerie.jamescleland.com) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-85)) #1 SMP Sat Aug 4 03:20:33 EDT 2001
Aug  6 04:02:38 valerie kernel: BIOS-provided physical RAM map:
Aug  6 04:02:38 valerie kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Aug  6 04:02:38 valerie kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Aug  6 04:02:38 valerie kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Aug  6 04:02:38 valerie kernel:  BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
Aug  6 04:02:38 valerie kernel:  BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
Aug  6 04:02:38 valerie kernel:  BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
Aug  6 04:02:38 valerie kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
Aug  6 04:02:38 valerie kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Aug  6 04:02:38 valerie kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Aug  6 04:02:38 valerie kernel: Scan SMP from c0000000 for 1024 bytes.
Aug  6 04:02:38 valerie kernel: Scan SMP from c009fc00 for 1024 bytes.
Aug  6 04:02:38 valerie kernel: Scan SMP from c00f0000 for 65536 bytes.
Aug  6 04:02:38 valerie kernel: found SMP MP-table at 000f5610
Aug  6 04:02:38 valerie kernel: hm, page 000f5000 reserved twice.
Aug  6 04:02:38 valerie kernel: hm, page 000f6000 reserved twice.
Aug  6 04:02:38 valerie kernel: hm, page 000f1000 reserved twice.
Aug  6 04:02:38 valerie kernel: hm, page 000f2000 reserved twice.
Aug  6 04:02:38 valerie kernel: On node 0 totalpages: 131056
Aug  6 04:02:38 valerie kernel: zone(0): 4096 pages.
Aug  6 04:02:38 valerie kernel: zone(1): 126960 pages.
Aug  6 04:02:38 valerie kernel: zone(2): 0 pages.
Aug  6 04:02:38 valerie kernel: Intel MultiProcessor Specification v1.4
Aug  6 04:02:38 valerie kernel:     Virtual Wire compatibility mode.
Aug  6 04:02:38 valerie kernel: OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Aug  6 04:02:38 valerie kernel: Processor #0 Pentium(tm) Pro APIC version 17
Aug  6 04:02:38 valerie rpc.statd[392]: Version 0.3.1 Starting
Aug  6 04:02:38 valerie kernel:     Floating point unit present.
Aug  6 04:02:38 valerie nfslock: rpc.statd startup succeeded
Aug  6 04:02:38 valerie kernel:     Machine Exception supported.
Aug  6 04:02:38 valerie kernel:     64 bit compare & exchange supported.
Aug  6 04:02:38 valerie kernel:     Internal APIC present.
Aug  6 04:02:38 valerie kernel:     SEP present.
Aug  6 04:02:38 valerie random: Initializing random number generator:  succeeded
Aug  6 04:02:38 valerie kernel:     MTRR  present.
Aug  6 04:02:38 valerie kernel:     PGE  present.
Aug  6 04:02:38 valerie kernel:     MCA  present.
Aug  6 04:02:38 valerie kernel:     CMOV  present.
Aug  6 04:02:38 valerie kernel:     Bootup CPU
Aug  6 04:02:38 valerie kernel: Processor #1 Pentium(tm) Pro APIC version 17
Aug  6 04:02:38 valerie kernel:     Floating point unit present.
Aug  6 04:02:38 valerie kernel:     Machine Exception supported.
Aug  6 04:02:38 valerie kernel:     64 bit compare & exchange supported.
Aug  6 04:02:38 valerie kernel:     Internal APIC present.
Aug  6 04:02:38 valerie kernel:     SEP present.
Aug  6 04:02:38 valerie kernel:     MTRR  present.
Aug  6 04:02:38 valerie kernel:     PGE  present.
Aug  6 04:02:38 valerie kernel:     MCA  present.
Aug  6 04:02:38 valerie kernel:     CMOV  present.
Aug  6 04:02:38 valerie kernel: Bus #0 is PCI
Aug  6 04:02:38 valerie kernel: Bus #1 is PCI
Aug  6 04:02:38 valerie kernel: Bus #2 is ISA
Aug  6 04:02:38 valerie kernel: I/O APIC #2 Version 17 at 0xFEC00000.
Aug  6 04:02:38 valerie kernel: Int: type 3, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 00
Aug  6 04:02:38 valerie kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 01, APIC ID 2, APIC INT 01
Aug  6 04:02:38 valerie kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 02
Aug  6 04:02:38 valerie kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 03, APIC ID 2, APIC INT 03
Aug  6 04:02:38 valerie kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 04, APIC ID 2, APIC INT 04
Aug  6 04:02:38 valerie kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 06, APIC ID 2, APIC INT 06
Aug  6 04:02:38 valerie kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 07, APIC ID 2, APIC INT 07
Aug  6 04:02:38 valerie kernel: Int: type 0, pol 1, trig 1, bus 2, IRQ 08, APIC ID 2, APIC INT 08
Aug  6 04:02:38 valerie kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 09, APIC ID 2, APIC INT 09
Aug  6 04:02:38 valerie kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 0a, APIC ID 2, APIC INT 0a
Aug  6 04:02:38 valerie kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 0c, APIC ID 2, APIC INT 0c
Aug  6 04:02:38 valerie kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 0d, APIC ID 2, APIC INT 0d
Aug  6 04:02:38 valerie kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 0e, APIC ID 2, APIC INT 0e
Aug  6 04:02:38 valerie kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 0f, APIC ID 2, APIC INT 0f
Aug  6 04:02:38 valerie kernel: Int: type 0, pol 3, trig 3, bus 0, IRQ 30, APIC ID 2, APIC INT 13
Aug  6 04:02:38 valerie kernel: Int: type 0, pol 3, trig 3, bus 1, IRQ 00, APIC ID 2, APIC INT 10
Aug  6 04:02:38 valerie kernel: Int: type 2, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 17
Aug  6 04:02:38 valerie kernel: Lint: type 3, pol 0, trig 0, bus 0, IRQ 00, APIC ID ff, APIC LINT 00
Aug  6 04:02:39 valerie kernel: Lint: type 1, pol 0, trig 0, bus 0, IRQ 00, APIC ID ff, APIC LINT 01
Aug  6 04:02:39 valerie kernel: Processors: 2
Aug  6 04:02:39 valerie kernel: mapped APIC to ffffe000 (fee00000)
Aug  6 04:02:39 valerie kernel: mapped IOAPIC to ffffd000 (fec00000)
Aug  6 04:02:39 valerie kernel: Kernel command line: auto BOOT_IMAGE=linux-2.4.7 ro root=305 BOOT_FILE=/boot/bzImage-2.4.7
Aug  6 04:02:39 valerie netfs: Mounting other filesystems:  succeeded
Aug  6 04:02:39 valerie kernel: Initializing CPU#0
Aug  6 04:02:39 valerie kernel: Detected 998.380 MHz processor.
Aug  6 04:02:39 valerie kernel: Console: colour VGA+ 80x25
Aug  6 04:02:39 valerie kernel: Calibrating delay loop... 1992.29 BogoMIPS
Aug  6 04:02:39 valerie kernel: Memory: 512852k/524224k available (1255k kernel code, 10984k reserved, 476k data, 208k init, 0k highmem)
Aug  6 04:02:39 valerie kernel: Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Aug  6 04:02:39 valerie kernel: Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Aug  6 04:02:39 valerie kernel: Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Aug  6 04:02:39 valerie kernel: Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Aug  6 04:02:39 valerie kernel: Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
Aug  6 04:02:39 valerie kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Aug  6 04:02:39 valerie kernel: CPU: L2 cache: 256K
Aug  6 04:02:39 valerie kernel: Intel machine check architecture supported.
Aug  6 04:02:39 valerie kernel: Intel machine check reporting enabled on CPU#0.
Aug  6 04:02:39 valerie kernel: CPU serial number disabled.
Aug  6 04:02:39 valerie identd: identd startup succeeded
Aug  6 04:02:39 valerie kernel: Enabling fast FPU save and restore... done.
Aug  6 04:02:39 valerie kernel: Enabling unmasked SIMD FPU exception support... done.
Aug  6 04:02:39 valerie kernel: Checking 'hlt' instruction... OK.
Aug  6 04:02:39 valerie kernel: POSIX conformance testing by UNIFIX
Aug  6 04:02:39 valerie kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
Aug  6 04:02:39 valerie kernel: mtrr: detected mtrr type: Intel
Aug  6 04:02:39 valerie kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Aug  6 04:02:39 valerie kernel: CPU: L2 cache: 256K
Aug  6 04:02:39 valerie kernel: Intel machine check reporting enabled on CPU#0.
Aug  6 04:02:39 valerie kernel: CPU0: Intel Pentium III (Coppermine) stepping 0a
Aug  6 04:02:39 valerie kernel: per-CPU timeslice cutoff: 730.97 usecs.
Aug  6 04:02:39 valerie kernel: Getting VERSION: 40011
Aug  6 04:02:39 valerie kernel: Getting VERSION: 40011
Aug  6 04:02:39 valerie kernel: Getting ID: 0
Aug  6 04:02:39 valerie kernel: Getting ID: f000000
Aug  6 04:02:39 valerie kernel: Getting LVT0: 700
Aug  6 04:02:39 valerie kernel: Getting LVT1: 400
Aug  6 04:02:39 valerie kernel: enabled ExtINT on CPU#0
Aug  6 04:02:39 valerie kernel: ESR value before enabling vector: 00000000
Aug  6 04:02:39 valerie kernel: ESR value after enabling vector: 00000000
Aug  6 04:02:39 valerie kernel: CPU present map: 3
Aug  6 04:02:39 valerie kernel: Booting processor 1/1 eip 2000
Aug  6 04:02:39 valerie atd: atd startup succeeded
Aug  6 04:02:39 valerie kernel: Setting warm reset code and vector.
Aug  6 04:02:39 valerie kernel: 1.
Aug  6 04:02:39 valerie kernel: 2.
Aug  6 04:02:39 valerie kernel: 3.
Aug  6 04:02:39 valerie kernel: Asserting INIT.
Aug  6 04:02:39 valerie kernel: Waiting for send to finish...
Aug  6 04:02:39 valerie kernel: +Deasserting INIT.
Aug  6 04:02:39 valerie kernel: Waiting for send to finish...
Aug  6 04:02:39 valerie kernel: +#startup loops: 2.
Aug  6 04:02:39 valerie kernel: Sending STARTUP #1.
Aug  6 04:02:39 valerie kernel: After apic_write.
Aug  6 04:02:39 valerie kernel: Initializing CPU#1
Aug  6 04:02:39 valerie kernel: CPU#1 (phys ID: 1) waiting for CALLOUT
Aug  6 04:02:39 valerie rc: Starting pcmcia:  succeeded
Aug  6 04:02:39 valerie kernel: Startup point 1.
Aug  6 04:02:39 valerie kernel: Waiting for send to finish...
Aug  6 04:02:39 valerie kernel: +Sending STARTUP #2.
Aug  6 04:02:39 valerie kernel: After apic_write.
Aug  6 04:02:39 valerie kernel: Startup point 1.
Aug  6 04:02:39 valerie kernel: Waiting for send to finish...
Aug  6 04:02:39 valerie kernel: +After Startup.
Aug  6 04:02:39 valerie kernel: Before Callout 1.
Aug  6 04:02:39 valerie kernel: After Callout 1.
Aug  6 04:02:39 valerie kernel: CALLIN, before setup_local_APIC().
Aug  6 04:02:39 valerie kernel: masked ExtINT on CPU#1
Aug  6 04:02:39 valerie kernel: ESR value before enabling vector: 00000000
Aug  6 04:02:39 valerie kernel: ESR value after enabling vector: 00000000
Aug  6 04:02:39 valerie kernel: Calibrating delay loop... 1992.29 BogoMIPS
Aug  6 04:02:39 valerie kernel: Stack at about c189dfb8
Aug  6 04:02:39 valerie kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Aug  6 04:02:39 valerie kernel: CPU: L2 cache: 256K
Aug  6 04:02:39 valerie kernel: Intel machine check reporting enabled on CPU#1.
Aug  6 04:02:39 valerie kernel: CPU serial number disabled.
Aug  6 04:02:39 valerie kernel: OK.
Aug  6 04:02:39 valerie kernel: CPU1: Intel Pentium III (Coppermine) stepping 0a
Aug  6 04:02:39 valerie kernel: CPU has booted.
Aug  6 04:02:39 valerie kernel: Before bogomips.
Aug  6 04:02:39 valerie kernel: Total of 2 processors activated (3984.58 BogoMIPS).
Aug  6 04:02:39 valerie kernel: Before bogocount - setting activated=1.
Aug  6 04:02:39 valerie kernel: Boot done.
Aug  6 04:02:39 valerie kernel: ENABLING IO-APIC IRQs
Aug  6 04:02:39 valerie kernel: ...changing IO-APIC physical APIC ID to 2 ... ok.
Aug  6 04:02:39 valerie kernel: Synchronizing Arb IDs.
Aug  6 04:02:39 valerie kernel: ..TIMER: vector=31 pin1=2 pin2=0
Aug  6 04:02:39 valerie kernel: testing the IO APIC.......................
Aug  6 04:02:39 valerie kernel:
Aug  6 04:02:40 valerie kernel:  WARNING: unexpected IO-APIC, please mail
Aug  6 04:02:40 valerie kernel:           to linux-smp@vger.kernel.org
Aug  6 04:02:40 valerie kernel: .................................... done.
Aug  6 04:02:40 valerie kernel: calibrating APIC timer ...
Aug  6 04:02:40 valerie kernel: ..... CPU clock speed is 998.4022 MHz.
Aug  6 04:02:40 valerie kernel: ..... host bus clock speed is 133.1201 MHz.
Aug  6 04:02:40 valerie kernel: cpu: 0, clocks: 1331201, slice: 443733
Aug  6 04:02:40 valerie kernel: CPU0<T0:1331200,T1:887456,D:11,S:443733,C:1331201>
Aug  6 04:02:40 valerie kernel: cpu: 1, clocks: 1331201, slice: 443733
Aug  6 04:02:40 valerie kernel: CPU1<T0:1331200,T1:443728,D:6,S:443733,C:1331201>
Aug  6 04:02:40 valerie kernel: checking TSC synchronization across CPUs: passed.
Aug  6 04:02:40 valerie kernel: Setting commenced=1, go go go
Aug  6 04:02:40 valerie kernel: mtrr: your CPUs had inconsistent variable MTRR settings
Aug  6 04:02:40 valerie kernel: mtrr: probably your BIOS does not setup all CPUs
Aug  6 04:02:40 valerie kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb370, last bus=1
Aug  6 04:02:40 valerie kernel: PCI: Using configuration type 1
Aug  6 04:02:40 valerie kernel: PCI: Probing PCI hardware
Aug  6 04:02:40 valerie kernel: Unknown bridge resource 0: assuming transparent
Aug  6 04:02:40 valerie kernel: PCI: Using IRQ router VIA [1106/0686] at 00:07.0
Aug  6 04:02:40 valerie kernel: querying PCI -> IRQ mapping bus:0, slot:12, pin:0.
Aug  6 04:02:40 valerie kernel: PCI->APIC IRQ transform: (B0,I12,P0) -> 19
Aug  6 04:02:40 valerie kernel: querying PCI -> IRQ mapping bus:1, slot:0, pin:0.
Aug  6 04:02:40 valerie kernel: PCI->APIC IRQ transform: (B1,I0,P0) -> 16
Aug  6 04:02:40 valerie kernel: PCI: Enabling Via external APIC routing
Aug  6 04:02:40 valerie kernel: isapnp: Scanning for PnP cards...
Aug  6 04:02:40 valerie kernel: isapnp: No Plug & Play device found
Aug  6 04:02:40 valerie kernel: Linux NET4.0 for Linux 2.4
Aug  6 04:02:40 valerie kernel: Based upon Swansea University Computer Society NET3.039
Aug  6 04:02:40 valerie kernel: Initializing RT netlink socket
Aug  6 04:02:40 valerie kernel: Starting kswapd v1.8
Aug  6 04:02:40 valerie kernel: pty: 256 Unix98 ptys configured
Aug  6 04:02:40 valerie kernel: Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
Aug  6 04:02:40 valerie kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Aug  6 04:02:40 valerie kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
Aug  6 04:02:40 valerie kernel: request_module[parport_lowlevel]: Root fs not mounted
Aug  6 04:02:40 valerie kernel: lp: driver loaded but no devices found
Aug  6 04:02:40 valerie kernel: Real Time Clock Driver v1.10d
Aug  6 04:02:40 valerie kernel: Non-volatile memory driver v1.1
Aug  6 04:02:40 valerie kernel: ppdev: user-space parallel port driver
Aug  6 04:02:40 valerie kernel: block: queued sectors max/low 340754kB/209682kB, 1024 slots per queue
Aug  6 04:02:40 valerie kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
Aug  6 04:02:40 valerie kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Aug  6 04:02:40 valerie kernel: VP_IDE: IDE controller on PCI bus 00 dev 39
Aug  6 04:02:40 valerie kernel: VP_IDE: chipset revision 6
Aug  6 04:02:40 valerie kernel: VP_IDE: not 100%% native mode: will probe irqs later
Aug  6 04:02:40 valerie kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Aug  6 04:02:40 valerie kernel: VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
Aug  6 04:02:40 valerie kernel:     ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
Aug  6 04:02:40 valerie kernel:     ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:pio

