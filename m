Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129996AbQKVKPj>; Wed, 22 Nov 2000 05:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131330AbQKVKP3>; Wed, 22 Nov 2000 05:15:29 -0500
Received: from ext.lri.fr ([129.175.15.4]:678 "EHLO ext.lri.fr")
	by vger.kernel.org with ESMTP id <S129996AbQKVKPV>;
	Wed, 22 Nov 2000 05:15:21 -0500
From: "Benjamin Monate <Benjamin Monate" <Benjamin.Monate@lri.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14875.38318.5084.502248@sun-demons>
Date: Wed, 22 Nov 2000 10:45:18 +0100 (MET)
To: linux-kernel@vger.kernel.org
Subject: Re: Strange lockup of the timer with 2.4.0-test10 SMP (and older)
In-Reply-To: <Pine.GSO.3.96.1001121175618.28403A-100000@delta.ds2.pg.gda.pl>
In-Reply-To: <14874.41589.359267.717984@sun-demons>
	<Pine.GSO.3.96.1001121175618.28403A-100000@delta.ds2.pg.gda.pl>
X-Mailer: VM 6.62 under Emacs 20.7.1
Reply-To: Benjamin.Monate@lri.fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dans son message du Tue 21 November, Maciej W. Rozycki ecrit : 
>  But this message is printed when a workaround for certain early SMP EISA
> boards gets activated.  You shouldn't normally get it for anything newer
> than P5/66 unless your MP-table is broken.  Can you send me a dump of your
> MP-table (just issue `dmesg -s 32768' after a bootstrap -- the table is at
> the top). 
Ok: here is the begining of dmesg.
 
Linux version 2.4.0-test10 (root@pc8-118) (gcc version 2.95.2 20000220 (Debian GNU/Linux)) #1 SMP Thu Nov 16 13:18:57 CET 2000
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009f000 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000001000 @ 000000000009f000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 000000007fefb000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000004000 @ 000000007fffb000 (ACPI data)
 BIOS-e820: 0000000000001000 @ 000000007ffff000 (ACPI NVS)
 BIOS-e820: 0000000000010000 @ 00000000fec00000 (reserved)
 BIOS-e820: 0000000000001000 @ 00000000fee00000 (reserved)
 BIOS-e820: 0000000000080000 @ 00000000fff80000 (reserved)
1151MB HIGHMEM available.
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
found SMP MP-table at 000f5270
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f4000 reserved twice.
hm, page 000f5000 reserved twice.
On node 0 totalpages: 524283
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 294907 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #3 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    Bootup CPU
Processor #0 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
Bus #0 is PCI   
Bus #1 is PCI   
Bus #2 is ISA   
I/O APIC #2 Version 17 at 0xFEC00000.
I/O APIC #3 Version 17 at 0xFEC01000.
Int: type 3, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 00
Int: type 0, pol 0, trig 0, bus 2, IRQ 01, APIC ID 2, APIC INT 01
Int: type 0, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 02
Int: type 0, pol 0, trig 0, bus 2, IRQ 03, APIC ID 2, APIC INT 03
Int: type 0, pol 0, trig 0, bus 2, IRQ 04, APIC ID 2, APIC INT 04
Int: type 0, pol 0, trig 0, bus 2, IRQ 06, APIC ID 2, APIC INT 06
Int: type 0, pol 0, trig 0, bus 2, IRQ 07, APIC ID 2, APIC INT 07
Int: type 0, pol 0, trig 0, bus 2, IRQ 08, APIC ID 2, APIC INT 08
Int: type 0, pol 0, trig 0, bus 2, IRQ 0c, APIC ID 2, APIC INT 0c
Int: type 0, pol 3, trig 3, bus 0, IRQ 08, APIC ID 3, APIC INT 04
Int: type 0, pol 3, trig 3, bus 0, IRQ 0c, APIC ID 3, APIC INT 00
Int: type 0, pol 3, trig 3, bus 0, IRQ 10, APIC ID 3, APIC INT 01
Int: type 0, pol 3, trig 3, bus 2, IRQ 09, APIC ID 2, APIC INT 09
Int: type 0, pol 3, trig 3, bus 1, IRQ 14, APIC ID 3, APIC INT 08
Int: type 0, pol 3, trig 3, bus 1, IRQ 15, APIC ID 3, APIC INT 09
Lint: type 3, pol 1, trig 1, bus 2, IRQ 00, APIC ID ff, APIC LINT 00
Lint: type 1, pol 1, trig 1, bus 2, IRQ 00, APIC ID ff, APIC LINT 01
Processors: 2
mapped APIC to ffffe000 (fee00000)
mapped IOAPIC to ffffd000 (fec00000)
mapped IOAPIC to ffffc000 (fec01000)
Kernel command line: BOOT_IMAGE=new ro root=803 BOOT_FILE=/boot/vmlinuz-2.4.0-test2 nmi_watchdog=1
Initializing CPU#0
Detected 933.446 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1861.22 BogoMIPS
Memory: 2059660k/2097132k available (1537k kernel code, 37084k reserved, 89k data, 200k init, 1179628k highmem)
Dentry-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Buffer-cache hash table entries: 131072 (order: 7, 524288 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.36 (20000221) Richard Gooch (rgooch@atnf.csiro.au)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel Pentium III (Coppermine) stepping 03
per-CPU timeslice cutoff: 731.32 usecs.
Getting VERSION: 40011
Getting VERSION: 40011
Getting ID: 3000000
Getting ID: c000000
Getting LVT0: 8700
Getting LVT1: 400
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
CPU present map: 9
Booting processor 1/0 eip 2000
Setting warm reset code and vector.
1.
2.
3.
Asserting INIT.
Waiting for send to finish...
+Deasserting INIT.
Waiting for send to finish...
+#startup loops: 2.
Sending STARTUP #1.
After apic_write.
Startup point 1.
Waiting for send to finish...
+Initializing CPU#1
CPU#1 (phys ID: 0) waiting for CALLOUT
Sending STARTUP #2.
After apic_write.
Startup point 1.
Waiting for send to finish...
+After Startup.
Before Callout 1.
After Callout 1.
CALLIN, before setup_local_APIC().
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1861.22 BogoMIPS
Stack at about c322bfbc
Intel machine check reporting enabled on CPU#1.
OK.
CPU1: Intel Pentium III (Coppermine) stepping 03
CPU has booted.
Before bogomips.
Total of 2 processors activated (3722.44 BogoMIPS).
Before bogocount - setting activated=1.
Boot done.
ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 2 ... ok.
BIOS bug, IO-APIC#1 ID 3 is already used!...
... fixing up to 1. (tell your hw vendor)
...changing IO-APIC physical APIC ID to 1 ... ok.
Synchronizing Arb IDs.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-5, 2-10, 2-11, 2-13, 2-14, 2-15, 1-2, 1-3, 1-5, 1-6, 1-7, 1-10, 1-11, 1-12, 1-13, 1-14, 1-15 not connected.
..TIMER: vector=49 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ... 
..... (found pin 0) ...works.
activating NMI Watchdog ... done.
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 16.
number of IO-APIC #1 registers: 16.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 003 03  0    0    0   0   0    1    1    31
 01 003 03  0    0    0   0   0    1    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 000 00  1    0    0   0   0    0    0    00
 06 003 03  0    0    0   0   0    1    1    51
 07 003 03  0    0    0   0   0    1    1    59
 08 003 03  0    0    0   0   0    1    1    61
 09 003 03  1    1    0   1   0    1    1    69
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 003 03  0    0    0   0   0    1    1    71
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00

IO APIC #1......
.... register #00: 01000000
.......    : physical APIC id: 01
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : IO APIC version: 0011
.... register #02: 03000000
.......     : arbitration: 03
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 003 03  1    1    0   1   0    1    1    79
 01 003 03  1    1    0   1   0    1    1    81
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 003 03  1    1    0   1   0    1    1    89
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 003 03  1    1    0   1   0    1    1    91
 09 003 03  1    1    0   1   0    1    1    99
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 2
IRQ1 -> 1
IRQ3 -> 3
IRQ4 -> 4
IRQ6 -> 6
IRQ7 -> 7
IRQ8 -> 8
IRQ9 -> 9
IRQ12 -> 12
IRQ16 -> 0
IRQ17 -> 1
IRQ20 -> 4
IRQ24 -> 8
IRQ25 -> 9
.................................... done.
calibrating APIC timer ...
..... CPU clock speed is 933.4306 MHz.
..... host bus clock speed is 133.3472 MHz.
cpu: 0, clocks: 1333472, slice: 444490
CPU0<T0:1333472,T1:888976,D:6,S:444490,C:1333472>
cpu: 1, clocks: 1333472, slice: 444490
CPU1<T0:1333472,T1:444480,D:12,S:444490,C:1333472>
checking TSC synchronization across CPUs: passed.
Setting commenced=1, go go go
PCI: PCI BIOS revision 2.10 entry at 0xf0aa0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: ServerWorks host bridge: secondary bus 00
PCI: ServerWorks host bridge: secondary bus 01
PCI: Using IRQ router default [1166/0200] at 00:0f.0
PCI->APIC IRQ transform: (B1,I5,P0) -> 24
PCI->APIC IRQ transform: (B1,I5,P1) -> 25
PCI->APIC IRQ transform: (B0,I2,P0) -> 20
PCI->APIC IRQ transform: (B0,I3,P0) -> 16
PCI->APIC IRQ transform: (B0,I4,P0) -> 17
Linux NET4.0 for Linux 2.4

> > Is there anyway to restore the 8254 to a valid state without rebooting ?
> 
>  Well, in this specific configuration, it may be either the 8254 timer or
> the 8259 legacy PIC as when the workaround gets activated both timer IRQs
> and NMIs go through the latter.  It is certainly possible to reprogram
> the chips but maybe we can find a way to avoid the lockup.

Yes, this would clearly be better.

Thank you again.

-- 
| Benjamin Monate         | mailto:Benjamin.Monate@lri.fr |


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
