Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131603AbRDAED0>; Sat, 31 Mar 2001 23:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131612AbRDAEDJ>; Sat, 31 Mar 2001 23:03:09 -0500
Received: from c213.89.109.26.cm-upc.chello.se ([213.89.109.26]:36613 "EHLO
	pescadero.ampr.org") by vger.kernel.org with ESMTP
	id <S131603AbRDAECx>; Sat, 31 Mar 2001 23:02:53 -0500
Message-ID: <3AC61C54.B2AEE21C@ufh.se>
Date: Sat, 31 Mar 2001 20:05:10 +0200
From: Peter Enderborg <pme@ufh.se>
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Version 6.1.6 of the aic7xxx driver availalbe
In-Reply-To: <200103311500.f2VF0Qs50837@aslan.scsiguy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Justin T. Gibbs" wrote:

> >I upgraded to 2.4.3 from 2.4.1 today and I get a lot of recovery on the scsi
> >bus.
> >I also upgraded to the "latest" aic7xxx driver but still the sam problems.
> >A typical revery in my logs.
>
> Can you resend the recovery information after booting with "aic7xxx=verbose".
> This will provide more information about the timeout which will hopefully
> allow me to narrow down the problem.  A full dmesg of the system would
> be useful too as that will include the device inquiry data.
>
> --
> Justin
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

OK. This is it:
Mar 31 16:39:03 pescadero kernel: UnexpecteMar 31 17:37:48 pescadero kernel:
klogd 1.3-3, log source = /proc/kmsg started.
Mar 31 17:37:48 pescadero kernel: Cannot find map file.
Mar 31 17:37:48 pescadero kernel: No module symbols loaded.
Mar 31 17:37:48 pescadero kernel:  IRQ 00, APIC ID 2, APIC INT 10
Mar 31 17:37:48 pescadero kernel: Int: type 0, pol 3, trig 3, bus 0, IRQ 13,
APIC ID 2, APIC INT 13
Mar 31 17:37:48 pescadero kernel: Int: type 0, pol 3, trig 3, bus 0, IRQ 18,
APIC ID 2, APIC INT 13
Mar 31 17:37:48 pescadero kernel: Int: type 0, pol 3, trig 3, bus 0, IRQ 24,
APIC ID 2, APIC INT 13
Mar 31 17:37:48 pescadero kernel: Int: type 0, pol 3, trig 3, bus 2, IRQ 10,
APIC ID 2, APIC INT 12
Mar 31 17:37:48 pescadero kernel: Int: type 0, pol 3, trig 3, bus 2, IRQ 14,
APIC ID 2, APIC INT 13
Mar 31 17:37:48 pescadero kernel: Int: type 0, pol 3, trig 3, bus 2, IRQ 18,
APIC ID 2, APIC INT 10
Mar 31 17:37:48 pescadero kernel: Int: type 0, pol 3, trig 3, bus 2, IRQ 1c,
APIC ID 2, APIC INT 11
Mar 31 17:37:48 pescadero kernel: Int: type 0, pol 3, trig 3, bus 0, IRQ 2c,
APIC ID 2, APIC INT 11
Mar 31 17:37:48 pescadero kernel: Int: type 0, pol 3, trig 3, bus 0, IRQ 30,
APIC ID 2, APIC INT 10
Mar 31 17:37:48 pescadero kernel: Lint: type 3, pol 1, trig 1, bus 3, IRQ 00,
APIC ID ff, APIC LINT 00
Mar 31 17:37:48 pescadero kernel: Lint: type 1, pol 1, trig 1, bus 3, IRQ 00,
APIC ID ff, APIC LINT 01
Mar 31 17:37:48 pescadero kernel: Processors: 2
Mar 31 17:37:48 pescadero kernel: mapped APIC to ffffe000 (fee00000)
Mar 31 17:37:48 pescadero kernel: mapped IOAPIC to ffffd000 (fec00000)
Mar 31 17:37:48 pescadero kernel: Kernel command line: BOOT_IMAGE=linux.test1 ro
root=801 aic7xxx=verbose pirq=0,0,0,0,18,16,17,5,19,19,19,19 ether=9,0,eth0
ether=9,0,eth1 ether=9,0,eth2 ether=9,0,eth3
Mar 31 17:37:48 pescadero kernel: PIRQ redirection, working around broken
MP-BIOS.
Mar 31 17:37:48 pescadero kernel: ... PIRQ0 -> IRQ 0
Mar 31 17:37:48 pescadero kernel: ... PIRQ1 -> IRQ 0
Mar 31 17:37:48 pescadero kernel: ... PIRQ2 -> IRQ 0
Mar 31 17:37:48 pescadero kernel: ... PIRQ3 -> IRQ 0
Mar 31 17:37:48 pescadero kernel: ... PIRQ4 -> IRQ 18
Mar 31 17:37:48 pescadero kernel: ... PIRQ5 -> IRQ 16
Mar 31 17:37:48 pescadero kernel: ... PIRQ6 -> IRQ 17
Mar 31 17:37:48 pescadero kernel: ... PIRQ7 -> IRQ 5
Mar 31 17:37:48 pescadero kernel: Initializing CPU#0
Mar 31 17:37:48 pescadero kernel: Detected 300.687 MHz processor.
Mar 31 17:37:48 pescadero kernel: Console: colour VGA+ 132x60
Mar 31 17:37:48 pescadero kernel: Calibrating delay loop... 599.65 BogoMIPS
Mar 31 17:37:48 pescadero kernel: Memory: 125936k/131060k available (1458k
kernel code, 4736k reserved, 554k data, 200k init, 0k highmem)
Mar 31 17:37:48 pescadero kernel: Dentry-cache hash table entries: 16384 (order:
5, 131072 bytes)
Mar 31 17:37:48 pescadero kernel: Buffer-cache hash table entries: 4096 (order:
2, 16384 bytes)
Mar 31 17:37:48 pescadero kernel: Page-cache hash table entries: 32768 (order:
5, 131072 bytes)
Mar 31 17:37:48 pescadero kernel: Inode-cache hash table entries: 8192 (order:
4, 65536 bytes)
Mar 31 17:37:48 pescadero kernel: CPU: Before vendor init, caps: 0080fbff
00000000 00000000, vendor = 0
Mar 31 17:37:48 pescadero kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Mar 31 17:37:48 pescadero kernel: CPU: L2 cache: 512K
Mar 31 17:37:48 pescadero kernel: Intel machine check architecture supported.
Mar 31 17:37:48 pescadero kernel: Intel machine check reporting enabled on
CPU#0.
Mar 31 17:37:48 pescadero kernel: CPU: After vendor init, caps: 0080fbff
00000000 00000000 00000000
Mar 31 17:37:48 pescadero kernel: CPU: After generic, caps: 0080fbff 00000000
00000000 00000000
Mar 31 17:37:48 pescadero kernel: CPU: Common caps: 0080fbff 00000000 00000000
00000000
Mar 31 17:37:48 pescadero kernel: Checking 'hlt' instruction... OK.
Mar 31 17:37:48 pescadero kernel: POSIX conformance testing by UNIFIX
Mar 31 17:37:48 pescadero kernel: mtrr: v1.37 (20001109) Richard Gooch
(rgooch@atnf.csiro.au)
Mar 31 17:37:48 pescadero kernel: mtrr: detected mtrr type: Intel
Mar 31 17:37:48 pescadero kernel: CPU: Before vendor init, caps: 0080fbff
00000000 00000000, vendor = 0
Mar 31 17:37:48 pescadero kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Mar 31 17:37:48 pescadero kernel: CPU: L2 cache: 512K
Mar 31 17:37:48 pescadero kernel: Intel machine check reporting enabled on
CPU#0.
Mar 31 17:37:48 pescadero kernel: CPU: After vendor init, caps: 0080fbff
00000000 00000000 00000000
Mar 31 17:37:48 pescadero kernel: CPU: After generic, caps: 0080fbff 00000000
00000000 00000000
Mar 31 17:37:48 pescadero kernel: CPU: Common caps: 0080fbff 00000000 00000000
00000000
Mar 31 17:37:48 pescadero kernel: CPU0: Intel Pentium II (Klamath) stepping 04
Mar 31 17:37:48 pescadero kernel: per-CPU timeslice cutoff: 1463.01 usecs.
Mar 31 17:37:48 pescadero kernel: Getting VERSION: 40011
Mar 31 17:37:48 pescadero kernel: Getting VERSION: 40011
Mar 31 17:37:48 pescadero kernel: Getting ID: 1000000
Mar 31 17:37:48 pescadero kernel: Getting ID: e000000
Mar 31 17:37:48 pescadero kernel: Getting LVT0: 8700
Mar 31 17:37:48 pescadero kernel: Getting LVT1: 400
Mar 31 17:37:48 pescadero kernel: enabled ExtINT on CPU#0
Mar 31 17:37:48 pescadero kernel: ESR value before enabling vector: 00000000
Mar 31 17:37:48 pescadero kernel: ESR value after enabling vector: 00000000
Mar 31 17:37:48 pescadero kernel: CPU present map: 3
Mar 31 17:37:48 pescadero kernel: Booting processor 1/0 eip 2000
Mar 31 17:37:48 pescadero kernel: Setting warm reset code and vector.
Mar 31 17:37:48 pescadero kernel: 1.
Mar 31 17:37:48 pescadero kernel: 2.
Mar 31 17:37:48 pescadero kernel: 3.
Mar 31 17:37:48 pescadero kernel: Asserting INIT.
Mar 31 17:37:48 pescadero kernel: Waiting for send to finish...
Mar 31 17:37:48 pescadero kernel: +Deasserting INIT.
Mar 31 17:37:48 pescadero kernel: Waiting for send to finish...
Mar 31 17:37:48 pescadero kernel: +#startup loops: 2.
Mar 31 17:37:48 pescadero kernel: Sending STARTUP #1.
Mar 31 17:37:48 pescadero kernel: After apic_write.
Mar 31 17:37:48 pescadero kernel: Initializing CPU#1
Mar 31 17:37:48 pescadero kernel: CPU#1 (phys ID: 0) waiting for CALLOUT
Mar 31 17:37:48 pescadero kernel: Startup point 1.
Mar 31 17:37:48 pescadero kernel: Waiting for send to finish...
Mar 31 17:37:48 pescadero kernel: +Sending STARTUP #2.
Mar 31 17:37:48 pescadero kernel: After apic_write.
Mar 31 17:37:48 pescadero kernel: Startup point 1.
Mar 31 17:37:48 pescadero kernel: Waiting for send to finish...
Mar 31 17:37:48 pescadero kernel: +After Startup.
Mar 31 17:37:48 pescadero kernel: Before Callout 1.
Mar 31 17:37:48 pescadero kernel: After Callout 1.
Mar 31 17:37:48 pescadero kernel: CALLIN, before setup_local_APIC().
Mar 31 17:37:48 pescadero kernel: masked ExtINT on CPU#1
Mar 31 17:37:48 pescadero kernel: ESR value before enabling vector: 00000000
Mar 31 17:37:48 pescadero kernel: ESR value after enabling vector: 00000000
Mar 31 17:37:48 pescadero kernel: Calibrating delay loop... 601.29 BogoMIPS
Mar 31 17:37:48 pescadero kernel: Stack at about c7ff1fbc
Mar 31 17:37:48 pescadero kernel: CPU: Before vendor init, caps: 0080fbff
00000000 00000000, vendor = 0
Mar 31 17:37:48 pescadero kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Mar 31 17:37:48 pescadero kernel: CPU: L2 cache: 512K
Mar 31 17:37:48 pescadero kernel: Intel machine check reporting enabled on
CPU#1.
Mar 31 17:37:48 pescadero kernel: CPU: After vendor init, caps: 0080fbff
00000000 00000000 00000000
Mar 31 17:37:48 pescadero kernel: CPU: After generic, caps: 0080fbff 00000000
00000000 00000000
Mar 31 17:37:48 pescadero kernel: CPU: Common caps: 0080fbff 00000000 00000000
00000000
Mar 31 17:37:48 pescadero kernel: OK.
Mar 31 17:37:48 pescadero kernel: CPU1: Intel Pentium II (Klamath) stepping 04
Mar 31 17:37:48 pescadero kernel: CPU has booted.
Mar 31 17:37:48 pescadero kernel: Before bogomips.
Mar 31 17:37:48 pescadero kernel: Total of 2 processors activated (1200.94
BogoMIPS).
Mar 31 17:37:48 pescadero kernel: Before bogocount - setting activated=1.
Mar 31 17:37:48 pescadero kernel: Boot done.
Mar 31 17:37:48 pescadero kernel: ENABLING IO-APIC IRQs
Mar 31 17:37:48 pescadero kernel: ...changing IO-APIC physical APIC ID to 2 ...
ok.
Mar 31 17:37:48 pescadero kernel: Synchronizing Arb IDs.
Mar 31 17:37:48 pescadero kernel: init IO_APIC IRQs
Mar 31 17:37:48 pescadero kernel:  IO-APIC (apicid-pin) 2-0, 2-5, 2-9, 2-11,
2-13<7>using PIRQ0 -> IRQ 5
Mar 31 17:37:48 pescadero kernel: using PIRQ0 -> IRQ 5
Mar 31 17:37:48 pescadero kernel: using PIRQ1 -> IRQ 17
Mar 31 17:37:48 pescadero kernel: using PIRQ0 -> IRQ 5
Mar 31 17:37:48 pescadero kernel: using PIRQ1 -> IRQ 17
Mar 31 17:37:48 pescadero kernel: using PIRQ2 -> IRQ 16
Mar 31 17:37:48 pescadero kernel: using PIRQ0 -> IRQ 5
Mar 31 17:37:48 pescadero kernel: using PIRQ1 -> IRQ 17
Mar 31 17:37:48 pescadero kernel: using PIRQ2 -> IRQ 16
Mar 31 17:37:48 pescadero kernel: using PIRQ3 -> IRQ 18
Mar 31 17:37:48 pescadero kernel: using PIRQ0 -> IRQ 5
Mar 31 17:37:48 pescadero kernel: using PIRQ1 -> IRQ 17
Mar 31 17:37:48 pescadero kernel: using PIRQ2 -> IRQ 16
Mar 31 17:37:48 pescadero kernel: using PIRQ3 -> IRQ 18
Mar 31 17:37:48 pescadero kernel: , 2-20, 2-21, 2-22, 2-23 not connected.
Mar 31 17:37:48 pescadero kernel: ..TIMER: vector=49 pin1=2 pin2=0
Mar 31 17:37:48 pescadero kernel: number of MP IRQ sources: 22.
Mar 31 17:37:48 pescadero kernel: number of IO-APIC #2 registers: 24.
Mar 31 17:37:48 pescadero kernel: testing the IO APIC.......................
Mar 31 17:37:48 pescadero kernel:
Mar 31 17:37:48 pescadero kernel: IO APIC #2......
Mar 31 17:37:48 pescadero kernel: .... register #00: 02000000
Mar 31 17:37:48 pescadero kernel: .......    : physical APIC id: 02
Mar 31 17:37:48 pescadero kernel: .... register #01: 00170011
Mar 31 17:37:48 pescadero kernel: .......     : max redirection entries: 0017
Mar 31 17:37:48 pescadero kernel: .......     : IO APIC version: 0011
Mar 31 17:37:48 pescadero kernel: .... register #02: 00000000
Mar 31 17:37:48 pescadero kernel: .......     : arbitration: 00
Mar 31 17:37:48 pescadero kernel: .... IRQ redirection table:
Mar 31 17:37:48 pescadero kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli
Vect:
Mar 31 17:37:48 pescadero kernel:  00 000 00  1    0    0   0   0    0    0
00
Mar 31 17:37:48 pescadero kernel:  01 003 03  0    0    0   0   0    1    1
39
Mar 31 17:37:48 pescadero kernel:  02 003 03  0    0    0   0   0    1    1
31
Mar 31 17:37:48 pescadero kernel:  03 003 03  0    0    0   0   0    1    1
41
Mar 31 17:37:48 pescadero kernel:  04 003 03  0    0    0   0   0    1    1
49
Mar 31 17:37:48 pescadero kernel:  05 000 00  1    0    0   0   0    0    0
00
Mar 31 17:37:48 pescadero kernel:  06 003 03  0    0    0   0   0    1    1
51
Mar 31 17:37:48 pescadero kernel:  07 003 03  0    0    0   0   0    1    1
59
Mar 31 17:37:48 pescadero kernel:  08 003 03  0    0    0   0   0    1    1
61
Mar 31 17:37:48 pescadero kernel:  09 000 00  1    0    0   0   0    0    0
00
Mar 31 17:37:48 pescadero kernel:  0a 003 03  0    0    0   0   0    1    1
69
Mar 31 17:37:48 pescadero kernel:  0b 000 00  1    0    0   0   0    0    0
00
Mar 31 17:37:48 pescadero kernel:  0c 003 03  0    0    0   0   0    1    1
71
Mar 31 17:37:48 pescadero kernel:  0d 000 00  1    0    0   0   0    0    0
00
Mar 31 17:37:48 pescadero kernel:  0e 003 03  0    0    0   0   0    1    1
79
Mar 31 17:37:48 pescadero kernel:  0f 003 03  0    0    0   0   0    1    1
81
Mar 31 17:37:48 pescadero kernel:  10 003 03  1    1    0   1   0    1    1
89
Mar 31 17:37:48 pescadero kernel:  11 003 03  1    1    0   1   0    1    1
91
Mar 31 17:37:48 pescadero kernel:  12 003 03  1    1    0   1   0    1    1
99
Mar 31 17:37:48 pescadero kernel:  13 003 03  1    1    0   1   0    1    1
A1
Mar 31 17:37:48 pescadero kernel:  14 000 00  1    0    0   0   0    0    0
00
Mar 31 17:37:48 pescadero kernel:  15 000 00  1    0    0   0   0    0    0
00
Mar 31 17:37:48 pescadero kernel:  16 000 00  1    0    0   0   0    0    0
00
Mar 31 17:37:48 pescadero kernel:  17 000 00  1    0    0   0   0    0    0
00
Mar 31 17:37:48 pescadero kernel: IRQ to pin mappings:
Mar 31 17:37:48 pescadero kernel: IRQ0 -> 2
Mar 31 17:37:48 pescadero kernel: IRQ1 -> 1
Mar 31 17:37:48 pescadero kernel: IRQ3 -> 3
Mar 31 17:37:48 pescadero kernel: IRQ4 -> 4
Mar 31 17:37:48 pescadero kernel: IRQ5 -> 16
Mar 31 17:37:48 pescadero kernel: IRQ6 -> 6
Mar 31 17:37:48 pescadero kernel: IRQ7 -> 7
Mar 31 17:37:48 pescadero kernel: IRQ8 -> 8
Mar 31 17:37:48 pescadero kernel: IRQ10 -> 10
Mar 31 17:37:48 pescadero kernel: IRQ12 -> 12
Mar 31 17:37:48 pescadero kernel: IRQ14 -> 14
Mar 31 17:37:48 pescadero kernel: IRQ15 -> 15
Mar 31 17:37:48 pescadero kernel: IRQ16 -> 18
Mar 31 17:37:48 pescadero kernel: IRQ17 -> 17
Mar 31 17:37:48 pescadero kernel: IRQ18 -> 19
Mar 31 17:37:48 pescadero kernel: .................................... done.
Mar 31 17:37:48 pescadero kernel: calibrating APIC timer ...
Mar 31 17:37:48 pescadero kernel: ..... CPU clock speed is 300.6724 MHz.
Mar 31 17:37:48 pescadero kernel: ..... host bus clock speed is 100.2236 MHz.
Mar 31 17:37:48 pescadero kernel: cpu: 0, clocks: 1002236, slice: 334078
Mar 31 17:37:48 pescadero kernel:
CPU0<T0:1002224,T1:668144,D:2,S:334078,C:1002236>
Mar 31 17:37:48 pescadero kernel: cpu: 1, clocks: 1002236, slice: 334078
Mar 31 17:37:48 pescadero kernel:
CPU1<T0:1002224,T1:334064,D:4,S:334078,C:1002236>
Mar 31 17:37:48 pescadero kernel: checking TSC synchronization across CPUs:
passed.
Mar 31 17:37:48 pescadero kernel: Setting commenced=1, go go go
Mar 31 17:37:48 pescadero kernel: mtrr: your CPUs had inconsistent fixed MTRR
settings
Mar 31 17:37:48 pescadero kernel: mtrr: your CPUs had inconsistent variable MTRR
settings
Mar 31 17:37:48 pescadero kernel: mtrr: probably your BIOS does not setup all
CPUs
Mar 31 17:37:48 pescadero kernel: PCI: PCI BIOS revision 2.10 entry at 0xf0730,
last bus=2
Mar 31 17:37:48 pescadero kernel: PCI: Using configuration type 1
Mar 31 17:37:48 pescadero kernel: PCI: Probing PCI hardware
Mar 31 17:37:48 pescadero kernel: Unknown bridge resource 0: assuming
transparent
Mar 31 17:37:48 pescadero kernel: PCI: Using IRQ router PIIX [8086/7110] at
00:04.0
Mar 31 17:37:48 pescadero kernel: using PIRQ3 -> IRQ 18
Mar 31 17:37:48 pescadero kernel: PCI->APIC IRQ transform: (B0,I4,P3) -> 18
Mar 31 17:37:48 pescadero kernel: using PIRQ3 -> IRQ 18
Mar 31 17:37:48 pescadero kernel: PCI->APIC IRQ transform: (B0,I6,P0) -> 18
Mar 31 17:37:48 pescadero kernel: using PIRQ3 -> IRQ 18
Mar 31 17:37:48 pescadero kernel: PCI->APIC IRQ transform: (B0,I9,P0) -> 18
Mar 31 17:37:48 pescadero kernel: using PIRQ1 -> IRQ 17
Mar 31 17:37:48 pescadero kernel: PCI->APIC IRQ transform: (B0,I11,P0) -> 17
Mar 31 17:37:48 pescadero kernel: using PIRQ0 -> IRQ 5
Mar 31 17:37:48 pescadero kernel: PCI->APIC IRQ transform: (B0,I12,P0) -> 5
Mar 31 17:37:48 pescadero kernel: using PIRQ0 -> IRQ 5
Mar 31 17:37:48 pescadero kernel: PCI->APIC IRQ transform: (B1,I0,P0) -> 5
Mar 31 17:37:48 pescadero kernel: using PIRQ2 -> IRQ 16
Mar 31 17:37:48 pescadero kernel: PCI->APIC IRQ transform: (B2,I4,P0) -> 16
Mar 31 17:37:48 pescadero kernel: using PIRQ3 -> IRQ 18
Mar 31 17:37:48 pescadero kernel: PCI->APIC IRQ transform: (B2,I5,P0) -> 18
Mar 31 17:37:48 pescadero kernel: using PIRQ0 -> IRQ 5
Mar 31 17:37:48 pescadero kernel: PCI->APIC IRQ transform: (B2,I6,P0) -> 5
Mar 31 17:37:48 pescadero kernel: using PIRQ1 -> IRQ 17
Mar 31 17:37:48 pescadero kernel: PCI->APIC IRQ transform: (B2,I7,P0) -> 17
Mar 31 17:37:48 pescadero kernel: Limiting direct PCI/PCI transfers.
Mar 31 17:37:48 pescadero kernel: isapnp: Scanning for Pnp cards...
Mar 31 17:37:48 pescadero kernel: isapnp: No Plug & Play device found
Mar 31 17:37:48 pescadero kernel: Linux NET4.0 for Linux 2.4
Mar 31 17:37:48 pescadero kernel: Based upon Swansea University Computer Society
NET3.039
Mar 31 17:37:48 pescadero kernel: Starting kswapd v1.8
Mar 31 17:37:48 pescadero kernel: parport0: PC-style at 0x3bc [PCSPP(,...)]
Mar 31 17:37:48 pescadero kernel: parport0: irq 7 detected
Mar 31 17:37:48 pescadero kernel: pty: 256 Unix98 ptys configured
Mar 31 17:37:48 pescadero kernel: lp0: using parport0 (polling).
Mar 31 17:37:48 pescadero kernel: block: queued sectors max/low 83570kB/27856kB,
256 slots per queue
Mar 31 17:37:48 pescadero kernel: Uniform Multi-Platform E-IDE driver Revision:
6.31
Mar 31 17:37:48 pescadero kernel: ide: Assuming 33MHz system bus speed for PIO
modes; override with idebus=xx
Mar 31 17:37:48 pescadero kernel: PIIX4: IDE controller on PCI bus 00 dev 21
Mar 31 17:37:48 pescadero kernel: PIIX4: chipset revision 1
Mar 31 17:37:48 pescadero kernel: PIIX4: not 100ative mode: will probe irqs
later
Mar 31 17:37:48 pescadero kernel:     ide0: BM-DMA at 0xd800-0xd807, BIOS
settings: hda:DMA, hdb:pio
Mar 31 17:37:48 pescadero kernel:     ide1: BM-DMA at 0xd808-0xd80f, BIOS
settings: hdc:pio, hdd:pio
Mar 31 17:37:48 pescadero kernel: hda: IBM-DHEA-38451, ATA DISK drive
Mar 31 17:37:48 pescadero kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Mar 31 17:37:48 pescadero kernel: hda: 16514064 sectors (8455 MB) w/472KiB
Cache, CHS=16383/16/63, UDMA(33)
Mar 31 17:37:48 pescadero kernel: Partition check:
Mar 31 17:37:48 pescadero kernel:  hda: hda1 hda2 hda3
Mar 31 17:37:48 pescadero kernel: Floppy drive(s): fd0 is 1.44M
Mar 31 17:37:48 pescadero kernel: FDC 0 is a post-1991 82077
Mar 31 17:37:48 pescadero kernel: SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic
channels, max=256).
Mar 31 17:37:48 pescadero kernel: udf: registering filesystem
Mar 31 17:37:48 pescadero kernel: loop: loaded (max 8 devices)
Mar 31 17:37:48 pescadero kernel: Serial driver version 5.05 (2000-12-13) with
MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
Mar 31 17:37:48 pescadero kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Mar 31 17:37:48 pescadero kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
Mar 31 17:37:48 pescadero kernel: ttyS02 at 0x03e8 (irq = 4) is a 16550A
Mar 31 17:37:48 pescadero kernel: ttyS03 at 0x02e8 (irq = 3) is a 16550A
Mar 31 17:37:48 pescadero kernel: Real Time Clock Driver v1.10d
Mar 31 17:37:48 pescadero kernel: Non-volatile memory driver v1.1
Mar 31 17:37:48 pescadero kernel: Linux Tulip driver version 0.9.14 (February
20, 2001)
Mar 31 17:37:48 pescadero kernel: eth0: Digital DS21140 Tulip rev 34 at 0xa800,
00:C0:95:E0:1F:74, IRQ 16.
Mar 31 17:37:48 pescadero kernel: eth0:  EEPROM default media type Autosense.
Mar 31 17:37:48 pescadero kernel: eth0:  Index #0 - Media 10baseT (#0) described
by a 21140 non-MII (0) block.
Mar 31 17:37:48 pescadero kernel: eth0:  Index #1 - Media 100baseTx (#3)
described by a 21140 non-MII (0) block.
Mar 31 17:37:48 pescadero kernel: eth0:  MII transceiver #1 config 3000 status
7829 advertising 01e1.
Mar 31 17:37:48 pescadero kernel: eth1: Digital DS21140 Tulip rev 34 at 0xa400,
00:C0:95:E0:1F:75, IRQ 18.
Mar 31 17:37:48 pescadero kernel: eth1:  EEPROM default media type Autosense.
Mar 31 17:37:48 pescadero kernel: eth1:  Index #0 - Media 10baseT (#0) described
by a 21140 non-MII (0) block.
Mar 31 17:37:48 pescadero kernel: eth1:  Index #1 - Media 100baseTx (#3)
described by a 21140 non-MII (0) block.
Mar 31 17:37:48 pescadero kernel: eth1:  MII transceiver #1 config 3000 status
7829 advertising 01e1.
Mar 31 17:37:48 pescadero kernel: eth2: Digital DS21140 Tulip rev 34 at 0xa000,
00:C0:95:E0:1F:76, IRQ 5.
Mar 31 17:37:48 pescadero kernel: eth2:  EEPROM default media type Autosense.
Mar 31 17:37:48 pescadero kernel: eth2:  Index #0 - Media 10baseT (#0) described
by a 21140 non-MII (0) block.
Mar 31 17:37:48 pescadero kernel: eth2:  Index #1 - Media 100baseTx (#3)
described by a 21140 non-MII (0) block.
Mar 31 17:37:48 pescadero kernel: eth2:  MII transceiver #1 config 3000 status
7809 advertising 01e1.
Mar 31 17:37:48 pescadero kernel: eth3: Digital DS21140 Tulip rev 34 at 0x9800,
00:C0:95:E0:1F:77, IRQ 17.
Mar 31 17:37:48 pescadero kernel: eth3:  EEPROM default media type Autosense.
Mar 31 17:37:48 pescadero kernel: eth3:  Index #0 - Media 10baseT (#0) described
by a 21140 non-MII (0) block.
Mar 31 17:37:48 pescadero kernel: eth3:  Index #1 - Media 100baseTx (#3)
described by a 21140 non-MII (0) block.
Mar 31 17:37:48 pescadero kernel: eth3:  MII transceiver #1 config 3000 status
7809 advertising 01e1.
Mar 31 17:37:48 pescadero kernel: PPP generic driver version 2.4.1
Mar 31 17:37:48 pescadero kernel: Linux agpgart interface v0.99 (c) Jeff
Hartmann
Mar 31 17:37:48 pescadero kernel: agpgart: Maximum main memory to use for agp
memory: 94M
Mar 31 17:37:48 pescadero kernel: agpgart: Detected Intel 440BX chipset
Mar 31 17:37:48 pescadero kernel: agpgart: AGP aperture is 64M @ 0xe4000000
Mar 31 17:37:48 pescadero kernel: [drm] AGP 0.99 on Intel 440BX @ 0xe4000000
64MB
Mar 31 17:37:48 pescadero kernel: [drm] Initialized tdfx 1.0.0 20000928 on minor
63
Mar 31 17:37:48 pescadero kernel: SCSI subsystem driver Revision: 1.00
Mar 31 17:37:48 pescadero kernel: request_module[scsi_hostadapter]: Root fs not
mounted
Mar 31 17:37:48 pescadero last message repeated 3 times
Mar 31 17:37:48 pescadero kernel: ahc_pci:0:6:0: Reading SEEPROM...done.
Mar 31 17:37:48 pescadero kernel: ahc_pci:0:6:0: Manual LVD Termination
Mar 31 17:37:48 pescadero kernel: ahc_pci:0:6:0: BIOS eeprom is present
Mar 31 17:37:48 pescadero kernel: ahc_pci:0:6:0: Secondary High byte termination
Enabled
Mar 31 17:37:57 pescadero kernel: ahc_pci:0:6:0: Secondary Low byte termination
Enabled
Mar 31 17:37:57 pescadero kernel: ahc_pci:0:6:0: Primary Low Byte termination
Enabled
Mar 31 17:37:57 pescadero kernel: ahc_pci:0:6:0: Primary High Byte termination
Enabled
Mar 31 17:37:57 pescadero kernel: ahc_pci:0:6:0: Downloading Sequencer
Program... 428 instructions downloaded
Mar 31 17:37:57 pescadero kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA
DRIVER, Rev 6.1.8
Mar 31 17:37:57 pescadero kernel:         <Adaptec aic7890/91 Ultra2 SCSI
adapter>
Mar 31 17:37:57 pescadero kernel:         aic7890/91: Wide Channel A, SCSI Id=7,
32/255 SCBs
Mar 31 17:37:57 pescadero kernel:
Mar 31 17:37:57 pescadero kernel:   Vendor: YAMAHA    Model: CRW8824S
Rev: 1.0j
Mar 31 17:37:57 pescadero kernel:   Type:   CD-ROM
ANSI SCSI revision: 02
Mar 31 17:37:57 pescadero kernel: Detected scsi CD-ROM sr0 at scsi0, channel 0,
id 3, lun 0
Mar 31 17:37:57 pescadero kernel: (scsi0:A:3:1): Sending SDTR period c, offset
7f
Mar 31 17:37:57 pescadero kernel: (scsi0:A:3:1): Received SDTR period c, offset
f
Mar 31 17:37:57 pescadero kernel: ^IFiltered to period c, offset f
Mar 31 17:37:57 pescadero kernel: (scsi0:A:3): 20.000MB/s transfers (20.000MHz,
offset 15)
Mar 31 17:37:57 pescadero kernel: scsi0: target 3 synchronous at 20.0MHz, offset
= 0xf
Mar 31 17:37:57 pescadero kernel:   Vendor: IBM       Model: DNES-318350W
Rev: SA30
Mar 31 17:37:57 pescadero kernel:   Type:   Direct-Access
ANSI SCSI revision: 03
Mar 31 17:37:57 pescadero kernel: Detected scsi disk sda at scsi0, channel 0, id
4, lun 0
Mar 31 17:37:57 pescadero kernel: (scsi0:A:4:1): Sending WDTR 1
Mar 31 17:37:57 pescadero kernel: (scsi0:A:4:1): Received WDTR 1 filtered to 1
Mar 31 17:37:57 pescadero kernel: (scsi0:A:4): 6.600MB/s transfers (16bit)
Mar 31 17:37:57 pescadero kernel: scsi0: target 4 using 16bit transfers
Mar 31 17:37:57 pescadero kernel: (scsi0:A:4:1): Sending SDTR period a, offset
7f
Mar 31 17:37:57 pescadero kernel: (scsi0:A:4:1): Received SDTR period a, offset
1f
Mar 31 17:37:57 pescadero kernel: ^IFiltered to period a, offset 1f
Mar 31 17:37:57 pescadero kernel: (scsi0:A:4): 80.000MB/s transfers (40.000MHz,
offset 31, 16bit)
Mar 31 17:37:57 pescadero kernel: scsi0: target 4 synchronous at 40.0MHz, offset
= 0x1f
Mar 31 17:37:57 pescadero kernel: (scsi0:A:4): 80.000MB/s transfers (40.000MHz,
offset 31, 16bit)
Mar 31 17:37:57 pescadero kernel: scsi0:0:4:0: Tagged Queuing enabled.  Depth 8
Mar 31 17:37:57 pescadero kernel: (scsi0:A:3:0): Sending SDTR period c, offset f

Mar 31 17:37:57 pescadero kernel: (scsi0:A:3:0): Received SDTR period c, offset
f
Mar 31 17:37:57 pescadero kernel: ^IFiltered to period c, offset f
Mar 31 17:37:57 pescadero kernel: sr0: scsi3-mmc drive: 24x/16x writer cd/rw
xa/form2 cdda tray
Mar 31 17:37:57 pescadero kernel: Uniform CD-ROM driver Revision: 3.12
Mar 31 17:37:57 pescadero kernel: (scsi0:A:4:0): Sending WDTR 1
Mar 31 17:37:57 pescadero kernel: (scsi0:A:4:0): Received WDTR 1 filtered to 1
Mar 31 17:37:57 pescadero kernel: (scsi0:A:4): 6.600MB/s transfers (16bit)
Mar 31 17:37:57 pescadero kernel: scsi0: target 4 using asynchronous transfers
Mar 31 17:37:57 pescadero kernel: (scsi0:A:4:0): Sending SDTR period a, offset
1f
Mar 31 17:37:57 pescadero kernel: (scsi0:A:4:0): Received SDTR period a, offset
1f
Mar 31 17:37:57 pescadero kernel: ^IFiltered to period a, offset 1f
Mar 31 17:37:57 pescadero kernel: (scsi0:A:4): 80.000MB/s transfers (40.000MHz,
offset 31, 16bit)
Mar 31 17:37:57 pescadero kernel: scsi0: target 4 synchronous at 40.0MHz, offset
= 0x1f
Mar 31 17:37:57 pescadero kernel: SCSI device sda: 35843670 512-byte hdwr
sectors (18352 MB)
Mar 31 17:37:57 pescadero kernel:  sda: sda1 sda2 sda3 sda4
Mar 31 17:37:57 pescadero kernel: usb.c: registered new driver hub
Mar 31 17:37:57 pescadero kernel: usb-uhci.c: $Revision: 1.251 $ time 11:39:27
Mar 31 2001
Mar 31 17:37:57 pescadero kernel: usb-uhci.c: High bandwidth mode enabled
Mar 31 17:37:57 pescadero kernel: usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 18
Mar 31 17:37:57 pescadero kernel: usb-uhci.c: Detected 2 ports
Mar 31 17:37:57 pescadero kernel: usb.c: new USB bus registered, assigned bus
number 1
Mar 31 17:37:57 pescadero kernel: usb.c: kmalloc IF c7ff26e0, numif 1
Mar 31 17:37:57 pescadero kernel: usb.c: new device strings: Mfr=0, Product=2,
SerialNumber=1
Mar 31 17:37:57 pescadero kernel: usb.c: USB device number 1 default language ID
0x0
Mar 31 17:37:57 pescadero kernel: Product: USB UHCI Root Hub
Mar 31 17:37:57 pescadero kernel: SerialNumber: d400
Mar 31 17:37:57 pescadero kernel: hub.c: USB hub found
Mar 31 17:37:57 pescadero kernel: hub.c: 2 ports detected
Mar 31 17:37:57 pescadero kernel: hub.c: standalone hub
Mar 31 17:37:57 pescadero kernel: hub.c: ganged power switching
Mar 31 17:37:57 pescadero kernel: hub.c: global over-current protection
Mar 31 17:37:57 pescadero kernel: hub.c: power on to power good time: 2ms
Mar 31 17:37:57 pescadero kernel: hub.c: hub controller current requirement: 0mA

Mar 31 17:37:57 pescadero kernel: hub.c: port removable status: RR
Mar 31 17:37:57 pescadero kernel: hub.c: local power source is good
Mar 31 17:37:57 pescadero kernel: hub.c: no over-current condition exists
Mar 31 17:37:57 pescadero kernel: hub.c: enabling power on all ports
Mar 31 17:37:57 pescadero kernel: usb.c: hub driver claimed interface c7ff26e0
Mar 31 17:37:57 pescadero kernel: usb.c: call_policy add, num 1 -- no FS yet
Mar 31 17:37:57 pescadero kernel: usb.c: registered new driver hid
Mar 31 17:37:57 pescadero kernel: usb.c: registered new driver usblp
Mar 31 17:37:57 pescadero kernel: Initializing USB Mass Storage driver...
Mar 31 17:37:57 pescadero kernel: usb.c: registered new driver usb-storage
Mar 31 17:37:57 pescadero kernel: USB Mass Storage support registered.
Mar 31 17:37:57 pescadero kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Mar 31 17:37:57 pescadero kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Mar 31 17:37:57 pescadero kernel: IP: routing cache hash table of 512 buckets,
4Kbytes
Mar 31 17:37:57 pescadero kernel: TCP: Hash tables configured (established 8192
bind 8192)
Mar 31 17:37:57 pescadero kernel: NET4: Unix domain sockets 1.0/SMP for Linux
NET4.0.
Mar 31 17:37:57 pescadero kernel: VFS: Mounted root (ext2 filesystem) readonly.
Mar 31 17:37:57 pescadero kernel: Freeing unused kernel memory: 200k freed
Mar 31 17:37:57 pescadero kernel: Adding Swap: 265064k swap-space (priority -1)
Mar 31 17:37:57 pescadero kernel: Adding Swap: 237880k swap-space (priority -2)
Mar 31 17:37:57 pescadero kernel: ip_conntrack (1023 buckets, 8184 max)
Mar 31 17:37:57 pescadero kernel: i2c-core.o: i2c core module
Mar 31 17:37:57 pescadero kernel: sensors.o version 2.5.4 (20001012)
Mar 31 17:37:57 pescadero kernel: lm78.o version 2.5.4 (20001012)
Mar 31 17:37:57 pescadero kernel: i2c-core.o: driver LM78(-J) and LM79 sensor
driver registered.
Mar 31 17:37:57 pescadero kernel: w83781d.o version 2.5.4 (20001012)
Mar 31 17:37:57 pescadero kernel: i2c-core.o: driver W83781D sensor driver
registered.
Mar 31 17:37:57 pescadero kernel: piix4.o version 2.5.4 (20001012)
Mar 31 17:37:57 pescadero kernel: i2c-core.o: client [W83781D chip] registered
to adapter [SMBus PIIX4 adapter at e800](pos. 0).
Mar 31 17:37:57 pescadero kernel: i2c-core.o: client [W83781D subclient]
registered to adapter [SMBus PIIX4 adapter at e800](pos. 1).
Mar 31 17:37:57 pescadero kernel: i2c-core.o: client [W83781D subclient]
registered to adapter [SMBus PIIX4 adapter at e800](pos. 2).
Mar 31 17:37:57 pescadero kernel: i2c-core.o: adapter SMBus PIIX4 adapter at
e800 registered as adapter 0.
Mar 31 17:37:57 pescadero kernel: i2c-piix4.o: PIIX4 bus detected and
initialized
Mar 31 17:46:22 pescadero kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Mar 31 17:46:22 pescadero kernel: scsi0: Dumping Card State in Data-out phase,
at SEQADDR 0x54
Mar 31 17:46:22 pescadero kernel: SCSISEQ = 0x12, SBLKCTL = 0xa
Mar 31 17:46:22 pescadero kernel:  DFCNTRL = 0x2c, DFSTATUS = 0x82
Mar 31 17:46:22 pescadero kernel: LASTPHASE = 0x0, SCSISIGI = 0x4, SXFRCTL0 =
0x80
Mar 31 17:46:22 pescadero kernel: SSTAT0 = 0x0, SSTAT1 = 0x2
Mar 31 17:46:22 pescadero kernel: STACK == 0x67, 0x16b, 0x0, 0x8e
Mar 31 17:46:22 pescadero kernel: SCB count = 12
Mar 31 17:46:22 pescadero kernel: Kernel NEXTQSCB = 0
Mar 31 17:46:22 pescadero kernel: Card NEXTQSCB = 0
Mar 31 17:46:22 pescadero kernel: QINFIFO entries:
Mar 31 17:46:22 pescadero kernel: Waiting Queue entries:
Mar 31 17:46:22 pescadero kernel: Disconnected Queue entries: 5:7 7:11 1:1 0:3
2:2 6:6 4:5
Mar 31 17:46:22 pescadero kernel: QOUTFIFO entries:
Mar 31 17:46:22 pescadero kernel: Sequencer Free SCB List: 8 9 10 11 12 13 14 15
16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
Mar 31 17:46:22 pescadero kernel: Pending list: 7 11 1 3 2 6 5 4
Mar 31 17:46:22 pescadero kernel: Kernel Free SCB list: 10 9 8
Mar 31 17:46:22 pescadero kernel: DevQ(0:3:0): 0 waiting
Mar 31 17:46:22 pescadero kernel: DevQ(0:4:0): 0 waiting
Mar 31 17:46:22 pescadero kernel: (scsi0:A:4:0): Queuing a recovery SCB
Mar 31 17:46:22 pescadero kernel: scsi0:0:4:0: Device is disconnected,
re-queuing SCB
Mar 31 17:46:22 pescadero kernel: Recovery code sleeping
Mar 31 17:46:27 pescadero kernel: Recovery code awake
Mar 31 17:46:27 pescadero kernel: Timer Expired
Mar 31 17:46:27 pescadero kernel: aic7xxx_abort returns 8195
Mar 31 17:46:27 pescadero kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Mar 31 17:46:27 pescadero kernel: scsi0: Dumping Card State in Data-out phase,
at SEQADDR 0x90
Mar 31 17:46:27 pescadero kernel: SCSISEQ = 0x12, SBLKCTL = 0xa
Mar 31 17:46:27 pescadero kernel:  DFCNTRL = 0x2c, DFSTATUS = 0x82
Mar 31 17:46:27 pescadero kernel: LASTPHASE = 0x0, SCSISIGI = 0x4, SXFRCTL0 =
0x80
Mar 31 17:46:27 pescadero kernel: SSTAT0 = 0x0, SSTAT1 = 0x2
Mar 31 17:46:27 pescadero kernel: STACK == 0x8e, 0x67, 0x16b, 0x0
Mar 31 17:46:27 pescadero kernel: SCB count = 12
Mar 31 17:46:27 pescadero kernel: Kernel NEXTQSCB = 0
Mar 31 17:46:27 pescadero kernel: Card NEXTQSCB = 11
Mar 31 17:46:27 pescadero kernel: QINFIFO entries: 11
Mar 31 17:46:27 pescadero kernel: Waiting Queue entries:
Mar 31 17:46:27 pescadero kernel: Disconnected Queue entries: 5:7 1:1 0:3 2:2
6:6 4:5
Mar 31 17:46:27 pescadero kernel: QOUTFIFO entries:
Mar 31 17:46:27 pescadero kernel: Sequencer Free SCB List: 7 8 9 10 11 12 13 14
15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
Mar 31 17:46:27 pescadero kernel: Pending list: 7 11 1 3 2 6 5 4
Mar 31 17:46:27 pescadero kernel: Kernel Free SCB list: 10 9 8
Mar 31 17:46:27 pescadero kernel: DevQ(0:3:0): 0 waiting
Mar 31 17:46:27 pescadero kernel: DevQ(0:4:0): 0 waiting
Mar 31 17:46:27 pescadero kernel: Recovery SCB completes
Mar 31 17:46:27 pescadero kernel: (scsi0:A:4:0): Queuing a recovery SCB
Mar 31 17:46:27 pescadero kernel: scsi0:0:4:0: Device is disconnected,
re-queuing SCB
Mar 31 17:46:27 pescadero kernel: Recovery code sleeping
Mar 31 17:46:27 pescadero kernel: Recovery code awake
Mar 31 17:46:27 pescadero kernel: aic7xxx_abort returns 8194
Mar 31 17:46:37 pescadero kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Mar 31 17:46:37 pescadero kernel: scsi0: Dumping Card State in Data-out phase,
at SEQADDR 0x55
Mar 31 17:46:37 pescadero kernel: SCSISEQ = 0x12, SBLKCTL = 0xa
Mar 31 17:46:37 pescadero kernel:  DFCNTRL = 0x2c, DFSTATUS = 0x82
Mar 31 17:46:37 pescadero kernel: LASTPHASE = 0x0, SCSISIGI = 0x4, SXFRCTL0 =
0x80
Mar 31 17:46:37 pescadero kernel: SSTAT0 = 0x0, SSTAT1 = 0x2
Mar 31 17:46:37 pescadero kernel: STACK == 0x67, 0x16b, 0x0, 0x8e
Mar 31 17:46:37 pescadero kernel: SCB count = 12
Mar 31 17:46:37 pescadero kernel: Kernel NEXTQSCB = 11
Mar 31 17:46:37 pescadero kernel: Card NEXTQSCB = 1
Mar 31 17:46:37 pescadero kernel: QINFIFO entries: 1 0
Mar 31 17:46:37 pescadero kernel: Waiting Queue entries:
Mar 31 17:46:37 pescadero kernel: Disconnected Queue entries: 5:7 0:3 2:2 6:6
4:5
Mar 31 17:46:37 pescadero kernel: QOUTFIFO entries:
Mar 31 17:46:37 pescadero kernel: Sequencer Free SCB List: 1 7 8 9 10 11 12 13
14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
Mar 31 17:46:37 pescadero kernel: Pending list: 0 7 1 3 2 6 5 4
Mar 31 17:46:37 pescadero kernel: Kernel Free SCB list: 10 9 8
Mar 31 17:46:37 pescadero kernel: DevQ(0:3:0): 0 waiting
Mar 31 17:46:37 pescadero kernel: DevQ(0:4:0): 0 waiting
Mar 31 17:46:37 pescadero kernel: scsi0:0:4:0: Cmd aborted from QINFIFO
Mar 31 17:46:37 pescadero kernel: aic7xxx_abort returns 8194
Mar 31 17:46:37 pescadero kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Mar 31 17:46:37 pescadero kernel: scsi0: Dumping Card State in Data-out phase,
at SEQADDR 0x8f
Mar 31 17:46:37 pescadero kernel: SCSISEQ = 0x12, SBLKCTL = 0xa
Mar 31 17:46:37 pescadero kernel:  DFCNTRL = 0x2c, DFSTATUS = 0x82
Mar 31 17:46:37 pescadero kernel: LASTPHASE = 0x0, SCSISIGI = 0x4, SXFRCTL0 =
0x80
Mar 31 17:46:37 pescadero kernel: SSTAT0 = 0x0, SSTAT1 = 0x2
Mar 31 17:46:37 pescadero kernel: STACK == 0x8e, 0x67, 0x16b, 0x0
Mar 31 17:46:37 pescadero kernel: SCB count = 12
Mar 31 17:46:37 pescadero kernel: Kernel NEXTQSCB = 1
Mar 31 17:46:37 pescadero kernel: Card NEXTQSCB = 11
Mar 31 17:46:37 pescadero kernel: QINFIFO entries: 11
Mar 31 17:46:37 pescadero kernel: Waiting Queue entries:
Mar 31 17:46:37 pescadero kernel: Disconnected Queue entries: 5:7 0:3 2:2 6:6
4:5
Mar 31 17:46:37 pescadero kernel: QOUTFIFO entries:
Mar 31 17:46:37 pescadero kernel: Sequencer Free SCB List: 1 7 8 9 10 11 12 13
14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
Mar 31 17:46:37 pescadero kernel: Pending list: 7 11 3 2 6 5 4
Mar 31 17:46:37 pescadero kernel: Kernel Free SCB list: 0 10 9 8
Mar 31 17:46:37 pescadero kernel: DevQ(0:3:0): 0 waiting
Mar 31 17:46:37 pescadero kernel: DevQ(0:4:0): 0 waiting
Mar 31 17:46:37 pescadero kernel: Recovery SCB completes
Mar 31 17:46:37 pescadero kernel: (scsi0:A:4:0): Queuing a recovery SCB
Mar 31 17:46:37 pescadero kernel: scsi0:0:4:0: Device is disconnected,
re-queuing SCB
Mar 31 17:46:37 pescadero kernel: Recovery code sleeping
Mar 31 17:46:37 pescadero kernel: Recovery code awake
Mar 31 17:46:37 pescadero kernel: aic7xxx_abort returns 8194
Mar 31 17:46:47 pescadero kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Mar 31 17:46:47 pescadero kernel: scsi0: Dumping Card State in Data-out phase,
at SEQADDR 0x8f
Mar 31 17:46:47 pescadero kernel: SCSISEQ = 0x12, SBLKCTL = 0xa
Mar 31 17:46:47 pescadero kernel:  DFCNTRL = 0x2c, DFSTATUS = 0x82
Mar 31 17:46:47 pescadero kernel: LASTPHASE = 0x0, SCSISIGI = 0x4, SXFRCTL0 =
0x80
Mar 31 17:46:47 pescadero kernel: SSTAT0 = 0x0, SSTAT1 = 0x2
Mar 31 17:46:47 pescadero kernel: STACK == 0x8e, 0x67, 0x16b, 0x0
Mar 31 17:46:47 pescadero kernel: SCB count = 12
Mar 31 17:46:47 pescadero kernel: Kernel NEXTQSCB = 11
Mar 31 17:46:47 pescadero kernel: Card NEXTQSCB = 2
Mar 31 17:46:47 pescadero kernel: QINFIFO entries: 2 1
Mar 31 17:46:47 pescadero kernel: Waiting Queue entries:
Mar 31 17:46:47 pescadero kernel: Disconnected Queue entries: 5:7 0:3 6:6 4:5
Mar 31 17:46:47 pescadero kernel: QOUTFIFO entries:
Mar 31 17:46:47 pescadero kernel: Sequencer Free SCB List: 2 1 7 8 9 10 11 12 13
14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
Mar 31 17:46:47 pescadero kernel: Pending list: 1 7 3 2 6 5 4
Mar 31 17:46:47 pescadero kernel: Kernel Free SCB list: 0 10 9 8
Mar 31 17:46:47 pescadero kernel: DevQ(0:3:0): 0 waiting
Mar 31 17:46:47 pescadero kernel: DevQ(0:4:0): 0 waiting
Mar 31 17:46:47 pescadero kernel: scsi0:0:4:0: Cmd aborted from QINFIFO
Mar 31 17:46:47 pescadero kernel: aic7xxx_abort returns 8194
Mar 31 17:46:47 pescadero kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Mar 31 17:46:47 pescadero kernel: scsi0: Dumping Card State in Data-out phase,
at SEQADDR 0x55
Mar 31 17:46:47 pescadero kernel: SCSISEQ = 0x12, SBLKCTL = 0xa
Mar 31 17:46:47 pescadero kernel:  DFCNTRL = 0x2c, DFSTATUS = 0x82
Mar 31 17:46:47 pescadero kernel: LASTPHASE = 0x0, SCSISIGI = 0x4, SXFRCTL0 =
0x80
Mar 31 17:46:47 pescadero kernel: SSTAT0 = 0x0, SSTAT1 = 0x2
Mar 31 17:46:47 pescadero kernel: STACK == 0x67, 0x16b, 0x0, 0x8e
Mar 31 17:46:47 pescadero kernel: SCB count = 12
Mar 31 17:46:47 pescadero kernel: Kernel NEXTQSCB = 2
Mar 31 17:46:47 pescadero kernel: Card NEXTQSCB = 11
Mar 31 17:46:47 pescadero kernel: QINFIFO entries: 11
Mar 31 17:46:47 pescadero kernel: Waiting Queue entries:
Mar 31 17:46:47 pescadero kernel: Disconnected Queue entries: 5:7 0:3 6:6 4:5
Mar 31 17:46:47 pescadero kernel: QOUTFIFO entries:
Mar 31 17:46:47 pescadero kernel: Sequencer Free SCB List: 2 1 7 8 9 10 11 12 13
14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
Mar 31 17:46:47 pescadero kernel: Pending list: 7 3 11 6 5 4
Mar 31 17:46:47 pescadero kernel: Kernel Free SCB list: 1 0 10 9 8
Mar 31 17:46:47 pescadero kernel: DevQ(0:3:0): 0 waiting
Mar 31 17:46:47 pescadero kernel: DevQ(0:4:0): 0 waiting
Mar 31 17:46:47 pescadero kernel: scsi0:0:4:0: Device is active, asserting ATN
Mar 31 17:46:47 pescadero kernel: Recovery code sleeping
Mar 31 17:46:52 pescadero kernel: Recovery code awake
Mar 31 17:46:52 pescadero kernel: Timer Expired
Mar 31 17:46:52 pescadero kernel: aic7xxx_abort returns 8195
Mar 31 17:46:52 pescadero kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Mar 31 17:46:52 pescadero kernel: scsi0: Dumping Card State in Data-out phase,
at SEQADDR 0x8f
Mar 31 17:46:52 pescadero kernel: SCSISEQ = 0x12, SBLKCTL = 0xa
Mar 31 17:46:52 pescadero kernel:  DFCNTRL = 0x2c, DFSTATUS = 0x82
Mar 31 17:46:52 pescadero kernel: LASTPHASE = 0x0, SCSISIGI = 0x14, SXFRCTL0 =
0x80
Mar 31 17:46:52 pescadero kernel: SSTAT0 = 0x0, SSTAT1 = 0x2
Mar 31 17:46:52 pescadero kernel: STACK == 0x8e, 0x67, 0x16b, 0x0
Mar 31 17:46:52 pescadero kernel: SCB count = 12
Mar 31 17:46:52 pescadero kernel: Kernel NEXTQSCB = 2
Mar 31 17:46:52 pescadero kernel: Card NEXTQSCB = 11
Mar 31 17:46:52 pescadero kernel: QINFIFO entries: 11
Mar 31 17:46:52 pescadero kernel: Waiting Queue entries:
Mar 31 17:46:52 pescadero kernel: Disconnected Queue entries: 5:7 0:3 6:6 4:5
Mar 31 17:46:52 pescadero kernel: QOUTFIFO entries:
Mar 31 17:46:52 pescadero kernel: Sequencer Free SCB List: 2 1 7 8 9 10 11 12 13
14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
Mar 31 17:46:52 pescadero kernel: Pending list: 7 3 11 6 5 4
Mar 31 17:46:52 pescadero kernel: Kernel Free SCB list: 1 0 10 9 8
Mar 31 17:46:52 pescadero kernel: DevQ(0:3:0): 0 waiting
Mar 31 17:46:52 pescadero kernel: DevQ(0:4:0): 0 waiting
Mar 31 17:46:52 pescadero kernel: Recovery SCB completes
Mar 31 17:46:52 pescadero kernel: (scsi0:A:4:0): Queuing a recovery SCB
Mar 31 17:46:52 pescadero kernel: scsi0:0:4:0: Device is disconnected,
re-queuing SCB
Mar 31 17:46:52 pescadero kernel: Recovery code sleeping
Mar 31 17:46:52 pescadero kernel: Recovery code awake
Mar 31 17:46:52 pescadero kernel: aic7xxx_abort returns 8194
Mar 31 17:47:02 pescadero kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Mar 31 17:47:02 pescadero kernel: scsi0: Dumping Card State in Data-out phase,
at SEQADDR 0x1ac
Mar 31 17:47:02 pescadero kernel: SCSISEQ = 0x12, SBLKCTL = 0xa
Mar 31 17:47:02 pescadero kernel:  DFCNTRL = 0x2c, DFSTATUS = 0x82
Mar 31 17:47:02 pescadero kernel: LASTPHASE = 0x0, SCSISIGI = 0x14, SXFRCTL0 =
0x80
Mar 31 17:47:02 pescadero kernel: SSTAT0 = 0x0, SSTAT1 = 0x2
Mar 31 17:47:02 pescadero kernel: STACK == 0x67, 0x16b, 0x0, 0x8e
Mar 31 17:47:02 pescadero kernel: SCB count = 12
Mar 31 17:47:02 pescadero kernel: Kernel NEXTQSCB = 11
Mar 31 17:47:02 pescadero kernel: Card NEXTQSCB = 5
Mar 31 17:47:02 pescadero kernel: QINFIFO entries: 5 2
Mar 31 17:47:02 pescadero kernel: Waiting Queue entries:
Mar 31 17:47:02 pescadero kernel: Disconnected Queue entries: 5:7 0:3 6:6
Mar 31 17:47:02 pescadero kernel: QOUTFIFO entries:
Mar 31 17:47:02 pescadero kernel: Sequencer Free SCB List: 4 2 1 7 8 9 10 11 12
13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
Mar 31 17:47:02 pescadero kernel: Pending list: 2 7 3 6 5 4
Mar 31 17:47:02 pescadero kernel: Kernel Free SCB list: 1 0 10 9 8
Mar 31 17:47:02 pescadero kernel: DevQ(0:3:0): 0 waiting
Mar 31 17:47:02 pescadero kernel: DevQ(0:4:0): 0 waiting
Mar 31 17:47:02 pescadero kernel: scsi0:0:4:0: Cmd aborted from QINFIFO
Mar 31 17:47:02 pescadero kernel: aic7xxx_abort returns 8194
Mar 31 17:47:02 pescadero kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Mar 31 17:47:02 pescadero kernel: scsi0: Dumping Card State in Data-out phase,
at SEQADDR 0x90
Mar 31 17:47:02 pescadero kernel: SCSISEQ = 0x12, SBLKCTL = 0xa
Mar 31 17:47:02 pescadero kernel:  DFCNTRL = 0x2c, DFSTATUS = 0x82
Mar 31 17:47:02 pescadero kernel: LASTPHASE = 0x0, SCSISIGI = 0x14, SXFRCTL0 =
0x80
Mar 31 17:47:02 pescadero kernel: SSTAT0 = 0x0, SSTAT1 = 0x2
Mar 31 17:47:02 pescadero kernel: STACK == 0x8e, 0x67, 0x16b, 0x0
Mar 31 17:47:02 pescadero kernel: SCB count = 12
Mar 31 17:47:02 pescadero kernel: Kernel NEXTQSCB = 5
Mar 31 17:47:02 pescadero kernel: Card NEXTQSCB = 11
Mar 31 17:47:02 pescadero kernel: QINFIFO entries: 11
Mar 31 17:47:02 pescadero kernel: Waiting Queue entries:
Mar 31 17:47:02 pescadero kernel: Disconnected Queue entries: 5:7 0:3 6:6
Mar 31 17:47:02 pescadero kernel: QOUTFIFO entries:
Mar 31 17:47:02 pescadero kernel: Sequencer Free SCB List: 4 2 1 7 8 9 10 11 12
13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
Mar 31 17:47:02 pescadero kernel: Pending list: 7 3 6 11 4
Mar 31 17:47:02 pescadero kernel: Kernel Free SCB list: 2 1 0 10 9 8
Mar 31 17:47:02 pescadero kernel: DevQ(0:3:0): 0 waiting
Mar 31 17:47:02 pescadero kernel: DevQ(0:4:0): 0 waiting
Mar 31 17:47:02 pescadero kernel: Recovery SCB completes
Mar 31 17:47:02 pescadero kernel: (scsi0:A:4:0): Queuing a recovery SCB
Mar 31 17:47:02 pescadero kernel: scsi0:0:4:0: Device is disconnected,
re-queuing SCB
Mar 31 17:47:02 pescadero kernel: Recovery code sleeping
Mar 31 17:47:02 pescadero kernel: Recovery code awake
Mar 31 17:47:02 pescadero kernel: aic7xxx_abort returns 8194
Mar 31 17:47:12 pescadero kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Mar 31 17:47:12 pescadero kernel: scsi0: Dumping Card State in Data-out phase,
at SEQADDR 0x1ac
Mar 31 17:47:12 pescadero kernel: SCSISEQ = 0x12, SBLKCTL = 0xa
Mar 31 17:47:12 pescadero kernel:  DFCNTRL = 0x2c, DFSTATUS = 0x82
Mar 31 17:47:12 pescadero kernel: LASTPHASE = 0x0, SCSISIGI = 0x14, SXFRCTL0 =
0x80
Mar 31 17:47:12 pescadero kernel: SSTAT0 = 0x0, SSTAT1 = 0x2
Mar 31 17:47:12 pescadero kernel: STACK == 0x67, 0x16b, 0x0, 0x8e
Mar 31 17:47:12 pescadero kernel: SCB count = 12
Mar 31 17:47:12 pescadero kernel: Kernel NEXTQSCB = 11
Mar 31 17:47:12 pescadero kernel: Card NEXTQSCB = 6
Mar 31 17:47:12 pescadero kernel: QINFIFO entries: 6 5
Mar 31 17:47:12 pescadero kernel: Waiting Queue entries:
Mar 31 17:47:12 pescadero kernel: Disconnected Queue entries: 5:7 0:3
Mar 31 17:47:12 pescadero kernel: QOUTFIFO entries:
Mar 31 17:47:12 pescadero kernel: Sequencer Free SCB List: 6 4 2 1 7 8 9 10 11
12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
Mar 31 17:47:12 pescadero kernel: Pending list: 5 7 3 6 4
Mar 31 17:47:12 pescadero kernel: Kernel Free SCB list: 2 1 0 10 9 8
Mar 31 17:47:12 pescadero kernel: DevQ(0:3:0): 0 waiting
Mar 31 17:47:12 pescadero kernel: DevQ(0:4:0): 0 waiting
Mar 31 17:47:12 pescadero kernel: scsi0:0:4:0: Cmd aborted from QINFIFO
Mar 31 17:47:12 pescadero kernel: aic7xxx_abort returns 8194
Mar 31 17:47:12 pescadero kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Mar 31 17:47:12 pescadero kernel: scsi0: Dumping Card State in Data-out phase,
at SEQADDR 0x56
Mar 31 17:47:12 pescadero kernel: SCSISEQ = 0x12, SBLKCTL = 0xa
Mar 31 17:47:12 pescadero kernel:  DFCNTRL = 0x2c, DFSTATUS = 0x82
Mar 31 17:47:12 pescadero kernel: LASTPHASE = 0x0, SCSISIGI = 0x14, SXFRCTL0 =
0x80
Mar 31 17:47:12 pescadero kernel: SSTAT0 = 0x0, SSTAT1 = 0x2
Mar 31 17:47:12 pescadero kernel: STACK == 0x67, 0x16b, 0x0, 0x8e
Mar 31 17:47:12 pescadero kernel: SCB count = 12
Mar 31 17:47:12 pescadero kernel: Kernel NEXTQSCB = 6
Mar 31 17:47:12 pescadero kernel: Card NEXTQSCB = 11
Mar 31 17:47:12 pescadero kernel: QINFIFO entries: 11
Mar 31 17:47:12 pescadero kernel: Waiting Queue entries:
Mar 31 17:47:12 pescadero kernel: Disconnected Queue entries: 5:7 0:3
Mar 31 17:47:12 pescadero kernel: QOUTFIFO entries:
Mar 31 17:47:12 pescadero kernel: Sequencer Free SCB List: 6 4 2 1 7 8 9 10 11
12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
Mar 31 17:47:12 pescadero kernel: Pending list: 7 3 11 4
Mar 31 17:47:12 pescadero kernel: Kernel Free SCB list: 5 2 1 0 10 9 8
Mar 31 17:47:12 pescadero kernel: DevQ(0:3:0): 0 waiting
Mar 31 17:47:12 pescadero kernel: DevQ(0:4:0): 0 waiting
Mar 31 17:47:12 pescadero kernel: Recovery SCB completes
Mar 31 17:47:12 pescadero kernel: (scsi0:A:4:0): Queuing a recovery SCB
Mar 31 17:47:12 pescadero kernel: scsi0:0:4:0: Device is disconnected,
re-queuing SCB
Mar 31 17:47:12 pescadero kernel: Recovery code sleeping
Mar 31 17:47:12 pescadero kernel: Recovery code awake
Mar 31 17:47:12 pescadero kernel: aic7xxx_abort returns 8194
Mar 31 17:47:22 pescadero kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Mar 31 17:47:22 pescadero kernel: scsi0: Dumping Card State in Data-out phase,
at SEQADDR 0x1ac
Mar 31 17:47:22 pescadero kernel: SCSISEQ = 0x12, SBLKCTL = 0xa
Mar 31 17:47:22 pescadero kernel:  DFCNTRL = 0x2c, DFSTATUS = 0x82
Mar 31 17:47:22 pescadero kernel: LASTPHASE = 0x0, SCSISIGI = 0x14, SXFRCTL0 =
0x80
Mar 31 17:47:22 pescadero kernel: SSTAT0 = 0x0, SSTAT1 = 0x2
Mar 31 17:47:22 pescadero kernel: STACK == 0x67, 0x16b, 0x0, 0x8e
Mar 31 17:47:22 pescadero kernel: SCB count = 12
Mar 31 17:47:22 pescadero kernel: Kernel NEXTQSCB = 11
Mar 31 17:47:22 pescadero kernel: Card NEXTQSCB = 3
Mar 31 17:47:22 pescadero kernel: QINFIFO entries: 3 6
Mar 31 17:47:22 pescadero kernel: Waiting Queue entries:
Mar 31 17:47:22 pescadero kernel: Disconnected Queue entries: 5:7
Mar 31 17:47:22 pescadero kernel: QOUTFIFO entries:
Mar 31 17:47:22 pescadero kernel: Sequencer Free SCB List: 0 6 4 2 1 7 8 9 10 11
12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
Mar 31 17:47:22 pescadero kernel: Pending list: 6 7 3 4
Mar 31 17:47:22 pescadero kernel: Kernel Free SCB list: 5 2 1 0 10 9 8
Mar 31 17:47:22 pescadero kernel: DevQ(0:3:0): 0 waiting
Mar 31 17:47:22 pescadero kernel: DevQ(0:4:0): 0 waiting
Mar 31 17:47:22 pescadero kernel: scsi0:0:4:0: Cmd aborted from QINFIFO
Mar 31 17:47:22 pescadero kernel: aic7xxx_abort returns 8194
Mar 31 17:47:22 pescadero kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Mar 31 17:47:22 pescadero kernel: scsi0: Dumping Card State in Data-out phase,
at SEQADDR 0x54
Mar 31 17:47:22 pescadero kernel: SCSISEQ = 0x12, SBLKCTL = 0xa
Mar 31 17:47:22 pescadero kernel:  DFCNTRL = 0x2c, DFSTATUS = 0x82
Mar 31 17:47:22 pescadero kernel: LASTPHASE = 0x0, SCSISIGI = 0x14, SXFRCTL0 =
0x80
Mar 31 17:47:22 pescadero kernel: SSTAT0 = 0x0, SSTAT1 = 0x2
Mar 31 17:47:22 pescadero kernel: STACK == 0x67, 0x16b, 0x0, 0x8e
Mar 31 17:47:22 pescadero kernel: SCB count = 12
Mar 31 17:47:22 pescadero kernel: Kernel NEXTQSCB = 3
Mar 31 17:47:22 pescadero kernel: Card NEXTQSCB = 11
Mar 31 17:47:22 pescadero kernel: QINFIFO entries: 11
Mar 31 17:47:22 pescadero kernel: Waiting Queue entries:
Mar 31 17:47:22 pescadero kernel: Disconnected Queue entries: 5:7
Mar 31 17:47:22 pescadero kernel: QOUTFIFO entries:
Mar 31 17:47:22 pescadero kernel: Sequencer Free SCB List: 0 6 4 2 1 7 8 9 10 11
12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
Mar 31 17:47:22 pescadero kernel: Pending list: 7 11 4
Mar 31 17:47:22 pescadero kernel: Kernel Free SCB list: 6 5 2 1 0 10 9 8
Mar 31 17:47:22 pescadero kernel: DevQ(0:3:0): 0 waiting
Mar 31 17:47:22 pescadero kernel: DevQ(0:4:0): 0 waiting
Mar 31 17:47:22 pescadero kernel: Recovery SCB completes
Mar 31 17:47:22 pescadero kernel: (scsi0:A:4:0): Queuing a recovery SCB
Mar 31 17:47:22 pescadero kernel: scsi0:0:4:0: Device is disconnected,
re-queuing SCB
Mar 31 17:50:01 pescadero kernel: Recovery code sleeping
Mar 31 17:50:01 pescadero kernel: Recovery code awake
Mar 31 17:50:01 pescadero kernel: aic7xxx_abort returns 8194
Mar 31 17:50:01 pescadero kernel: ffset f
Mar 31 17:50:01 pescadero kernel: (scsi0:A:3:0): Sending SDTR period c, offset f

Mar 31 17:50:01 pescadero kernel: (scsi0:A:3:0): Received SDTR period c, offset
f
Mar 31 17:50:01 pescadero kernel: ^IFiltered to period c, offset f
Mar 31 17:50:01 pescadero kernel: Device not ready.  Make sure there is a disc
in the drive.
Mar 31 17:50:01 pescadero kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Mar 31 17:50:01 pescadero kernel: scsi0: Dumping Card State in Data-out phase,
at SEQADDR 0x1ac
Mar 31 17:50:01 pescadero kernel: SCSISEQ = 0x12, SBLKCTL = 0xa
Mar 31 17:50:01 pescadero kernel:  DFCNTRL = 0x2c, DFSTATUS = 0x0
Mar 31 17:50:01 pescadero kernel: LASTPHASE = 0x0, SCSISIGI = 0x4, SXFRCTL0 =
0x80
Mar 31 17:50:01 pescadero kernel: SSTAT0 = 0x0, SSTAT1 = 0x2
Mar 31 17:50:01 pescadero kernel: STACK == 0x67, 0x16b, 0x0, 0x8e
Mar 31 17:50:01 pescadero kernel: SCB count = 12
Mar 31 17:50:01 pescadero kernel: Kernel NEXTQSCB = 1
Mar 31 17:50:01 pescadero kernel: Card NEXTQSCB = 1
Mar 31 17:50:01 pescadero kernel: QINFIFO entries:
Mar 31 17:50:01 pescadero kernel: Waiting Queue entries:
Mar 31 17:50:01 pescadero kernel: Disconnected Queue entries: 4:6 2:0 0:4 8:11
7:7 5:5 1:2
Mar 31 17:50:01 pescadero kernel: QOUTFIFO entries:
Mar 31 17:50:01 pescadero kernel: Sequencer Free SCB List: 3 9 10 11 12 13 14 15
16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
Mar 31 17:50:01 pescadero kernel: Pending list: 6 0 4 11 7 5 2 3
Mar 31 17:50:01 pescadero kernel: Kernel Free SCB list: 10 9 8
Mar 31 17:50:01 pescadero kernel: DevQ(0:3:0): 0 waiting
Mar 31 17:50:01 pescadero kernel: DevQ(0:4:0): 0 waiting
Mar 31 17:50:01 pescadero kernel: (scsi0:A:4:0): Queuing a recovery SCB
Mar 31 17:50:01 pescadero kernel: scsi0:0:4:0: Device is disconnected,
re-queuing SCB
Mar 31 17:50:01 pescadero kernel: Recovery code sleeping
Mar 31 17:50:01 pescadero kernel: Recovery code awake
Mar 31 17:50:01 pescadero kernel: aic7xxx_abort returns 8194
Mar 31 17:50:01 pescadero kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Mar 31 17:50:01 pescadero kernel: scsi0: Dumping Card State in Data-out phase,
at SEQADDR 0x5f
Mar 31 17:50:01 pescadero kernel: SCSISEQ = 0x12, SBLKCTL = 0xa
Mar 31 17:50:01 pescadero kernel:  DFCNTRL = 0x2c, DFSTATUS = 0x0
Mar 31 17:50:01 pescadero kernel: LASTPHASE = 0x0, SCSISIGI = 0x4, SXFRCTL0 =
0x80
Mar 31 17:50:01 pescadero kernel: SSTAT0 = 0x0, SSTAT1 = 0x2
Mar 31 17:50:01 pescadero kernel: STACK == 0x67, 0x16b, 0x0, 0x8e
Mar 31 17:50:01 pescadero kernel: SCB count = 12
Mar 31 17:50:01 pescadero kernel: Kernel NEXTQSCB = 10
Mar 31 17:50:01 pescadero kernel: Card NEXTQSCB = 7
Mar 31 17:50:01 pescadero kernel: QINFIFO entries: 7 1
Mar 31 17:50:01 pescadero kernel: Waiting Queue entries:
Mar 31 17:50:01 pescadero kernel: Disconnected Queue entries: 4:6 2:0 0:4 8:11
5:5 1:2
Mar 31 17:50:01 pescadero kernel: QOUTFIFO entries:
Mar 31 17:50:01 pescadero kernel: Sequencer Free SCB List: 7 3 9 10 11 12 13 14
15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
Mar 31 17:50:01 pescadero kernel: Pending list: 1 6 0 4 11 7 5 2 3
Mar 31 17:50:01 pescadero kernel: Kernel Free SCB list: 9 8
Mar 31 17:50:01 pescadero kernel: DevQ(0:3:0): 0 waiting
Mar 31 17:50:01 pescadero kernel: DevQ(0:4:0): 0 waiting
Mar 31 17:50:01 pescadero kernel: scsi0:0:4:0: Cmd aborted from QINFIFO
Mar 31 17:50:01 pescadero kernel: aic7xxx_abort returns 8194
Mar 31 17:50:01 pescadero kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Mar 31 17:50:01 pescadero kernel: scsi0: Dumping Card State in Data-out phase,
at SEQADDR 0x57
Mar 31 17:50:01 pescadero kernel: SCSISEQ = 0x12, SBLKCTL = 0xa
Mar 31 17:50:01 pescadero kernel:  DFCNTRL = 0x2c, DFSTATUS = 0x0
Mar 31 17:50:01 pescadero kernel: LASTPHASE = 0x0, SCSISIGI = 0x4, SXFRCTL0 =
0x80
Mar 31 17:50:01 pescadero kernel: SSTAT0 = 0x0, SSTAT1 = 0x2
Mar 31 17:50:01 pescadero kernel: STACK == 0x67, 0x16b, 0x0, 0x8e
Mar 31 17:50:01 pescadero kernel: SCB count = 12
Mar 31 17:50:01 pescadero kernel: Kernel NEXTQSCB = 7
Mar 31 17:50:01 pescadero kernel: Card NEXTQSCB = 10
Mar 31 17:50:01 pescadero kernel: QINFIFO entries: 10
Mar 31 17:50:01 pescadero kernel: Waiting Queue entries:
Mar 31 17:50:01 pescadero kernel: Disconnected Queue entries: 4:6 2:0 0:4 8:11
5:5 1:2
Mar 31 17:50:01 pescadero kernel: QOUTFIFO entries:
Mar 31 17:50:01 pescadero kernel: Sequencer Free SCB List: 7 3 9 10 11 12 13 14
15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
Mar 31 17:50:01 pescadero kernel: Pending list: 6 0 4 11 10 5 2 3
Mar 31 17:50:01 pescadero kernel: Kernel Free SCB list: 1 9 8
Mar 31 17:50:01 pescadero kernel: DevQ(0:3:0): 0 waiting
Mar 31 17:50:01 pescadero kernel: DevQ(0:4:0): 0 waiting
Mar 31 17:50:01 pescadero kernel: Recovery SCB completes
Mar 31 17:50:01 pescadero kernel: (scsi0:A:4:0): Queuing a recovery SCB
Mar 31 17:50:01 pescadero kernel: scsi0:0:4:0: Device is disconnected,
re-queuing SCB
Mar 31 17:50:01 pescadero kernel: Recovery code sleeping
Mar 31 17:50:01 pescadero kernel: Recovery code awake
Mar 31 17:50:01 pescadero kernel: aic7xxx_abort returns 8194
Mar 31 17:50:01 pescadero kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Mar 31 17:50:01 pescadero kernel: scsi0: Dumping Card State in Data-out phase,
at SEQADDR 0x54
Mar 31 17:50:01 pescadero kernel: SCSISEQ = 0x12, SBLKCTL = 0xa
Mar 31 17:50:01 pescadero kernel:  DFCNTRL = 0x2c, DFSTATUS = 0x0
Mar 31 17:50:01 pescadero kernel: LASTPHASE = 0x0, SCSISIGI = 0x4, SXFRCTL0 =
0x80
Mar 31 17:50:01 pescadero kernel: SSTAT0 = 0x0, SSTAT1 = 0x2
Mar 31 17:50:01 pescadero kernel: STACK == 0x67, 0x16b, 0x0, 0x8e
Mar 31 17:50:01 pescadero kernel: SCB count = 12
Mar 31 17:50:01 pescadero kernel: Kernel NEXTQSCB = 10
Mar 31 17:50:01 pescadero kernel: Card NEXTQSCB = 2
Mar 31 17:50:01 pescadero kernel: QINFIFO entries: 2 7
Mar 31 17:50:01 pescadero kernel: Waiting Queue entries:
Mar 31 17:50:01 pescadero kernel: Disconnected Queue entries: 4:6 2:0 0:4 8:11
5:5
Mar 31 17:50:01 pescadero kernel: QOUTFIFO entries:
Mar 31 17:50:01 pescadero kernel: Sequencer Free SCB List: 1 7 3 9 10 11 12 13
14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
Mar 31 17:50:01 pescadero kernel: Pending list: 7 6 0 4 11 5 2 3
Mar 31 17:50:01 pescadero kernel: Kernel Free SCB list: 1 9 8
Mar 31 17:50:01 pescadero kernel: DevQ(0:3:0): 0 waiting
Mar 31 17:50:01 pescadero kernel: DevQ(0:4:0): 0 waiting
Mar 31 17:50:01 pescadero kernel: scsi0:0:4:0: Cmd aborted from QINFIFO
Mar 31 17:50:01 pescadero kernel: aic7xxx_abort returns 8194
Mar 31 17:50:01 pescadero kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Mar 31 17:50:01 pescadero kernel: scsi0: Dumping Card State in Data-out phase,
at SEQADDR 0x90
Mar 31 17:50:01 pescadero kernel: SCSISEQ = 0x12, SBLKCTL = 0xa
Mar 31 17:50:01 pescadero kernel:  DFCNTRL = 0x2c, DFSTATUS = 0x0
Mar 31 17:50:01 pescadero kernel: LASTPHASE = 0x0, SCSISIGI = 0x4, SXFRCTL0 =
0x80
Mar 31 17:50:01 pescadero kernel: SSTAT0 = 0x0, SSTAT1 = 0x2
Mar 31 17:50:01 pescadero kernel: STACK == 0x8e, 0x67, 0x16b, 0x0
Mar 31 17:50:01 pescadero kernel: SCB count = 12
Mar 31 17:50:01 pescadero kernel: Kernel NEXTQSCB = 2
Mar 31 17:50:01 pescadero kernel: Card NEXTQSCB = 10
Mar 31 17:50:01 pescadero kernel: QINFIFO entries: 10
Mar 31 17:50:01 pescadero kernel: Waiting Queue entries:
Mar 31 17:50:01 pescadero kernel: Disconnected Queue entries: 4:6 2:0 0:4 8:11
5:5
Mar 31 17:50:01 pescadero kernel: QOUTFIFO entries:
Mar 31 17:50:01 pescadero kernel: Sequencer Free SCB List: 1 7 3 9 10 11 12 13
14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
Mar 31 17:50:01 pescadero kernel: Pending list: 6 0 4 11 5 10 3
Mar 31 17:50:01 pescadero kernel: Kernel Free SCB list: 7 1 9 8
Mar 31 17:50:01 pescadero kernel: DevQ(0:3:0): 0 waiting
Mar 31 17:50:01 pescadero kernel: DevQ(0:4:0): 0 waiting
Mar 31 17:50:01 pescadero kernel: Recovery SCB completes
Mar 31 17:50:01 pescadero kernel: (scsi0:A:4:0): Queuing a recovery SCB
Mar 31 17:50:01 pescadero kernel: scsi0:0:4:0: Device is disconnected,
re-queuing SCB
Mar 31 17:50:01 pescadero kernel: Recovery code sleeping
Mar 31 17:50:01 pescadero kernel: Recovery code awake
Mar 31 17:50:01 pescadero kernel: aic7xxx_abort returns 8194
Mar 31 17:50:01 pescadero kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Mar 31 17:50:01 pescadero kernel: scsi0: Dumping Card State in Data-out phase,
at SEQADDR 0x57
Mar 31 17:50:01 pescadero kernel: SCSISEQ = 0x12, SBLKCTL = 0xa
Mar 31 17:50:01 pescadero kernel:  DFCNTRL = 0x2c, DFSTATUS = 0x0
Mar 31 17:50:01 pescadero kernel: LASTPHASE = 0x0, SCSISIGI = 0x4, SXFRCTL0 =
0x80
Mar 31 17:50:01 pescadero kernel: SSTAT0 = 0x0, SSTAT1 = 0x2
Mar 31 17:50:01 pescadero kernel: STACK == 0x67, 0x16b, 0x0, 0x8e
Mar 31 17:50:01 pescadero kernel: SCB count = 12
Mar 31 17:50:01 pescadero kernel: Kernel NEXTQSCB = 10
Mar 31 17:50:01 pescadero kernel: Card NEXTQSCB = 6
Mar 31 17:50:01 pescadero kernel: QINFIFO entries: 6 2
Mar 31 17:50:01 pescadero kernel: Waiting Queue entries:
Mar 31 17:50:01 pescadero kernel: Disconnected Queue entries: 2:0 0:4 8:11 5:5
Mar 31 17:50:01 pescadero kernel: QOUTFIFO entries:
Mar 31 17:50:01 pescadero kernel: Sequencer Free SCB List: 4 1 7 3 9 10 11 12 13
14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
Mar 31 17:50:01 pescadero kernel: Pending list: 2 6 0 4 11 5 3
Mar 31 17:50:01 pescadero kernel: Kernel Free SCB list: 7 1 9 8
Mar 31 17:50:01 pescadero kernel: DevQ(0:3:0): 0 waiting
Mar 31 17:50:01 pescadero kernel: DevQ(0:4:0): 0 waiting
Mar 31 17:50:01 pescadero kernel: scsi0:0:4:0: Cmd aborted from QINFIFO
Mar 31 17:50:01 pescadero kernel: aic7xxx_abort returns 8194
Mar 31 17:50:01 pescadero kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Mar 31 17:50:01 pescadero kernel: scsi0: Dumping Card State in Data-out phase,
at SEQADDR 0x90
Mar 31 17:50:01 pescadero kernel: SCSISEQ = 0x12, SBLKCTL = 0xa
Mar 31 17:50:01 pescadero kernel:  DFCNTRL = 0x2c, DFSTATUS = 0x0
Mar 31 17:50:01 pescadero kernel: LASTPHASE = 0x0, SCSISIGI = 0x4, SXFRCTL0 =
0x80
Mar 31 17:50:01 pescadero kernel: SSTAT0 = 0x0, SSTAT1 = 0x2
Mar 31 17:50:01 pescadero kernel: STACK == 0x8e, 0x67, 0x16b, 0x0
Mar 31 17:50:01 pescadero kernel: SCB count = 12
Mar 31 17:50:01 pescadero kernel: Kernel NEXTQSCB = 6
Mar 31 17:50:01 pescadero kernel: Card NEXTQSCB = 10
Mar 31 17:50:01 pescadero kernel: QINFIFO entries: 10
Mar 31 17:50:01 pescadero kernel: Waiting Queue entries:
Mar 31 17:50:01 pescadero kernel: Disconnected Queue entries: 2:0 0:4 8:11 5:5
Mar 31 17:50:01 pescadero kernel: QOUTFIFO entries:
Mar 31 17:50:01 pescadero kernel: Sequencer Free SCB List: 4 1 7 3 9 10 11 12 13
14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
Mar 31 17:50:01 pescadero kernel: Pending list: 10 0 4 11 5 3
Mar 31 17:50:01 pescadero kernel: Kernel Free SCB list: 2 7 1 9 8
Mar 31 17:50:01 pescadero kernel: DevQ(0:3:0): 0 waiting
Mar 31 17:50:01 pescadero kernel: DevQ(0:4:0): 0 waiting
Mar 31 17:50:01 pescadero kernel: Recovery SCB completes
Mar 31 17:50:01 pescadero kernel: (scsi0:A:4:0): Queuing a recovery SCB
Mar 31 17:50:01 pescadero kernel: scsi0:0:4:0: Device is disconnected,
re-queuing SCB
Mar 31 17:50:01 pescadero kernel: Recovery code sleeping
Mar 31 17:50:01 pescadero kernel: Recovery code awake
Mar 31 17:50:01 pescadero kernel: aic7xxx_abort returns 8194
Mar 31 17:50:01 pescadero kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Mar 31 17:50:01 pescadero kernel: scsi0: Dumping Card State in Data-out phase,
at SEQADDR 0x8f
Mar 31 17:50:01 pescadero kernel: SCSISEQ = 0x12, SBLKCTL = 0xa
Mar 31 17:50:01 pescadero kernel:  DFCNTRL = 0x2c, DFSTATUS = 0x0
Mar 31 17:50:01 pescadero kernel: LASTPHASE = 0x0, SCSISIGI = 0x4, SXFRCTL0 =
0x80
Mar 31 17:50:01 pescadero kernel: SSTAT0 = 0x0, SSTAT1 = 0x2
Mar 31 17:50:01 pescadero kernel: STACK == 0x8e, 0x67, 0x16b, 0x0
Mar 31 17:50:01 pescadero kernel: SCB count = 12
Mar 31 17:50:01 pescadero kernel: Kernel NEXTQSCB = 10
Mar 31 17:50:01 pescadero kernel: Card NEXTQSCB = 0
Mar 31 17:50:01 pescadero kernel: QINFIFO entries: 0 6
Mar 31 17:50:01 pescadero kernel: Waiting Queue entries:
Mar 31 17:50:01 pescadero kernel: Disconnected Queue entries: 0:4 8:11 5:5
Mar 31 17:50:01 pescadero kernel: QOUTFIFO entries:
Mar 31 17:50:01 pescadero kernel: Sequencer Free SCB List: 2 4 1 7 3 9 10 11 12
13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
Mar 31 17:50:01 pescadero kernel: Pending list: 6 0 4 11 5 3
Mar 31 17:50:01 pescadero kernel: Kernel Free SCB list: 2 7 1 9 8
Mar 31 17:50:01 pescadero kernel: DevQ(0:3:0): 0 waiting
Mar 31 17:50:01 pescadero kernel: DevQ(0:4:0): 0 waiting
Mar 31 17:50:01 pescadero kernel: scsi0:0:4:0: Cmd aborted from QINFIFO
Mar 31 17:50:01 pescadero kernel: aic7xxx_abort returns 8194
Mar 31 17:50:01 pescadero kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Mar 31 17:50:01 pescadero kernel: scsi0: Dumping Card State in Data-out phase,
at SEQADDR 0x8f
Mar 31 17:50:01 pescadero kernel: SCSISEQ = 0x12, SBLKCTL = 0xa
Mar 31 17:50:01 pescadero kernel:  DFCNTRL = 0x2c, DFSTATUS = 0x0
Mar 31 17:50:01 pescadero kernel: LASTPHASE = 0x0, SCSISIGI = 0x4, SXFRCTL0 =
0x80
Mar 31 17:50:01 pescadero kernel: SSTAT0 = 0x0, SSTAT1 = 0x2
Mar 31 17:50:01 pescadero kernel: STACK == 0x8e, 0x67, 0x16b, 0x0
Mar 31 17:50:01 pescadero kernel: SCB count = 12
Mar 31 17:50:01 pescadero kernel: Kernel NEXTQSCB = 0
Mar 31 17:50:01 pescadero kernel: Card NEXTQSCB = 10
Mar 31 17:50:01 pescadero kernel: QINFIFO entries: 10
Mar 31 17:50:01 pescadero kernel: Waiting Queue entries:
Mar 31 17:50:01 pescadero kernel: Disconnected Queue entries: 0:4 8:11 5:5
Mar 31 17:50:01 pescadero kernel: QOUTFIFO entries:
Mar 31 17:50:01 pescadero kernel: Sequencer Free SCB List: 2 4 1 7 3 9 10 11 12
13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
Mar 31 17:50:01 pescadero kernel: Pending list: 10 4 11 5 3
Mar 31 17:50:01 pescadero kernel: Kernel Free SCB list: 6 2 7 1 9 8
Mar 31 17:50:01 pescadero kernel: DevQ(0:3:0): 0 waiting
Mar 31 17:50:01 pescadero kernel: DevQ(0:4:0): 0 waiting
Mar 31 17:50:01 pescadero kernel: scsi0:0:4:0: Device is active, asserting ATN
Mar 31 17:50:01 pescadero kernel: Recovery code sleeping
Mar 31 17:50:01 pescadero kernel: Recovery code awake
Mar 31 17:50:01 pescadero kernel: aic7xxx_abort returns 8194
Mar 31 17:50:01 pescadero kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Mar 31 17:50:01 pescadero kernel: scsi0: Dumping Card State in Data-out phase,
at SEQADDR 0x8f
Mar 31 17:50:01 pescadero kernel: SCSISEQ = 0x12, SBLKCTL = 0xa
Mar 31 17:50:01 pescadero kernel:  DFCNTRL = 0x2c, DFSTATUS = 0x0
Mar 31 17:50:01 pescadero kernel: LASTPHASE = 0x0, SCSISIGI = 0x14, SXFRCTL0 =
0x80
Mar 31 17:50:01 pescadero kernel: SSTAT0 = 0x0, SSTAT1 = 0x2
Mar 31 17:50:01 pescadero kernel: STACK == 0x8e, 0x67, 0x16b, 0x0
Mar 31 17:50:01 pescadero kernel: SCB count = 12
Mar 31 17:50:01 pescadero kernel: Kernel NEXTQSCB = 6
Mar 31 17:50:01 pescadero kernel: Card NEXTQSCB = 10
Mar 31 17:50:01 pescadero kernel: QINFIFO entries: 10 0
Mar 31 17:50:01 pescadero kernel: Waiting Queue entries:
Mar 31 17:50:01 pescadero kernel: Disconnected Queue entries: 0:4 8:11 5:5
Mar 31 17:50:01 pescadero kernel: QOUTFIFO entries:
Mar 31 17:50:01 pescadero kernel: Sequencer Free SCB List: 2 4 1 7 3 9 10 11 12
13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
Mar 31 17:50:01 pescadero kernel: Pending list: 0 10 4 11 5 3
Mar 31 17:50:01 pescadero kernel: Kernel Free SCB list: 2 7 1 9 8
Mar 31 17:50:01 pescadero kernel: DevQ(0:3:0): 0 waiting
Mar 31 17:50:01 pescadero kernel: DevQ(0:4:0): 0 waiting
Mar 31 17:50:01 pescadero kernel: scsi0:0:4:0: Cmd aborted from QINFIFO
Mar 31 17:50:01 pescadero kernel: aic7xxx_abort returns 8194
Mar 31 17:50:10 pescadero kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Mar 31 17:50:10 pescadero kernel: scsi0: Dumping Card State in Data-out phase,
at SEQADDR 0x54
Mar 31 17:50:10 pescadero kernel: SCSISEQ = 0x12, SBLKCTL = 0xa
Mar 31 17:50:10 pescadero kernel:  DFCNTRL = 0x2c, DFSTATUS = 0x0
Mar 31 17:50:10 pescadero kernel: LASTPHASE = 0x0, SCSISIGI = 0x14, SXFRCTL0 =
0x80
Mar 31 17:50:10 pescadero kernel: SSTAT0 = 0x0, SSTAT1 = 0x2
Mar 31 17:50:10 pescadero kernel: STACK == 0x67, 0x16b, 0x0, 0x8e
Mar 31 17:50:10 pescadero kernel: SCB count = 12
Mar 31 17:50:10 pescadero kernel: Kernel NEXTQSCB = 10
Mar 31 17:50:10 pescadero kernel: Card NEXTQSCB = 6
Mar 31 17:50:10 pescadero kernel: QINFIFO entries: 6
Mar 31 17:50:10 pescadero kernel: Waiting Queue entries:
Mar 31 17:50:10 pescadero kernel: Disconnected Queue entries: 0:4 8:11 5:5
Mar 31 17:50:10 pescadero kernel: QOUTFIFO entries:
Mar 31 17:50:10 pescadero kernel: Sequencer Free SCB List: 2 4 1 7 3 9 10 11 12
13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
Mar 31 17:50:10 pescadero kernel: Pending list: 6 4 11 5 3
Mar 31 17:50:10 pescadero kernel: Kernel Free SCB list: 0 2 7 1 9 8
Mar 31 17:50:10 pescadero kernel: DevQ(0:3:0): 0 waiting
Mar 31 17:50:10 pescadero kernel: DevQ(0:4:0): 0 waiting
Mar 31 17:50:10 pescadero kernel: Recovery SCB completes
Mar 31 17:50:10 pescadero kernel: (scsi0:A:4:0): Queuing a recovery SCB
Mar 31 17:50:10 pescadero kernel: scsi0:0:4:0: Device is disconnected,
re-queuing SCB
Mar 31 17:50:10 pescadero kernel: Recovery code sleeping
Mar 31 17:50:10 pescadero kernel: Recovery code awake
Mar 31 17:50:10 pescadero kernel: aic7xxx_abort returns 8194
Mar 31 17:50:10 pescadero kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Mar 31 17:50:10 pescadero kernel: scsi0: Dumping Card State in Data-out phase,
at SEQADDR 0x8e
Mar 31 17:50:10 pescadero kernel: SCSISEQ = 0x12, SBLKCTL = 0xa
Mar 31 17:50:10 pescadero kernel:  DFCNTRL = 0x2c, DFSTATUS = 0x0
Mar 31 17:50:10 pescadero kernel: LASTPHASE = 0x0, SCSISIGI = 0x14, SXFRCTL0 =
0x80
Mar 31 17:50:10 pescadero kernel: SSTAT0 = 0x0, SSTAT1 = 0x2
Mar 31 17:50:10 pescadero kernel: STACK == 0x8e, 0x67, 0x16b, 0x0
Mar 31 17:50:10 pescadero kernel: SCB count = 12
Mar 31 17:50:10 pescadero kernel: Kernel NEXTQSCB = 6
Mar 31 17:50:10 pescadero kernel: Card NEXTQSCB = 4
Mar 31 17:50:10 pescadero kernel: QINFIFO entries: 4 10
Mar 31 17:50:10 pescadero kernel: Waiting Queue entries:
Mar 31 17:50:10 pescadero kernel: Disconnected Queue entries: 8:11 5:5
Mar 31 17:50:10 pescadero kernel: QOUTFIFO entries:
Mar 31 17:50:10 pescadero kernel: Sequencer Free SCB List: 0 2 4 1 7 3 9 10 11
12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
Mar 31 17:50:10 pescadero kernel: Pending list: 10 4 11 5 3
Mar 31 17:50:10 pescadero kernel: Kernel Free SCB list: 0 2 7 1 9 8
Mar 31 17:50:10 pescadero kernel: DevQ(0:3:0): 0 waiting
Mar 31 17:50:10 pescadero kernel: DevQ(0:4:0): 0 waiting
Mar 31 17:50:10 pescadero kernel: scsi0:0:4:0: Cmd aborted from QINFIFO
Mar 31 17:50:10 pescadero kernel: aic7xxx_abort returns 8194
Mar 31 17:50:10 pescadero kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Mar 31 17:50:10 pescadero kernel: scsi0: Dumping Card State in Data-out phase,
at SEQADDR 0x54
Mar 31 17:50:10 pescadero kernel: SCSISEQ = 0x12, SBLKCTL = 0xa
Mar 31 17:50:10 pescadero kernel:  DFCNTRL = 0x2c, DFSTATUS = 0x0
Mar 31 17:50:10 pescadero kernel: LASTPHASE = 0x0, SCSISIGI = 0x14, SXFRCTL0 =
0x80
Mar 31 17:50:10 pescadero kernel: SSTAT0 = 0x0, SSTAT1 = 0x2
Mar 31 17:50:10 pescadero kernel: STACK == 0x67, 0x16b, 0x0, 0x8e
Mar 31 17:50:10 pescadero kernel: SCB count = 12
Mar 31 17:50:10 pescadero kernel: Kernel NEXTQSCB = 4
Mar 31 17:50:10 pescadero kernel: Card NEXTQSCB = 6
Mar 31 17:50:10 pescadero kernel: QINFIFO entries: 6
Mar 31 17:50:10 pescadero kernel: Waiting Queue entries:
Mar 31 17:50:10 pescadero kernel: Disconnected Queue entries: 8:11 5:5
Mar 31 17:50:10 pescadero kernel: QOUTFIFO entries:
Mar 31 17:50:10 pescadero kernel: Sequencer Free SCB List: 0 2 4 1 7 3 9 10 11
12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
Mar 31 17:50:10 pescadero kernel: Pending list: 6 11 5 3
Mar 31 17:50:10 pescadero kernel: Kernel Free SCB list: 10 0 2 7 1 9 8
Mar 31 17:50:10 pescadero kernel: DevQ(0:3:0): 0 waiting
Mar 31 17:50:10 pescadero kernel: DevQ(0:4:0): 0 waiting
Mar 31 17:50:10 pescadero kernel: Recovery SCB completes
Mar 31 17:50:10 pescadero kernel: (scsi0:A:4:0): Queuing a recovery SCB
Mar 31 17:50:10 pescadero kernel: scsi0:0:4:0: Device is disconnected,
re-queuing SCB
Mar 31 17:50:10 pescadero kernel: Recovery code sleeping
Mar 31 17:50:10 pescadero kernel: Recovery code awake
Mar 31 17:50:10 pescadero kernel: aic7xxx_abort returns 8194
Mar 31 17:50:10 pescadero kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Mar 31 17:50:10 pescadero kernel: scsi0: Dumping Card State in Data-out phase,
at SEQADDR 0x55
Mar 31 17:50:10 pescadero kernel: SCSISEQ = 0x12, SBLKCTL = 0xa
Mar 31 17:50:10 pescadero kernel:  DFCNTRL = 0x2c, DFSTATUS = 0x0
Mar 31 17:50:10 pescadero kernel: LASTPHASE = 0x0, SCSISIGI = 0x14, SXFRCTL0 =
0x80
Mar 31 17:50:10 pescadero kernel: SSTAT0 = 0x0, SSTAT1 = 0x2
Mar 31 17:50:10 pescadero kernel: STACK == 0x67, 0x16b, 0x0, 0x8e
Mar 31 17:50:10 pescadero kernel: SCB count = 12
Mar 31 17:50:10 pescadero kernel: Kernel NEXTQSCB = 6
Mar 31 17:50:10 pescadero kernel: Card NEXTQSCB = 5
Mar 31 17:50:10 pescadero kernel: QINFIFO entries: 5 4
Mar 31 17:50:10 pescadero kernel: Waiting Queue entries:
Mar 31 17:50:10 pescadero kernel: Disconnected Queue entries: 8:11
Mar 31 17:50:10 pescadero kernel: QOUTFIFO entries:
Mar 31 17:50:10 pescadero kernel: Sequencer Free SCB List: 5 0 2 4 1 7 3 9 10 11
12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
Mar 31 17:50:10 pescadero kernel: Pending list: 4 11 5 3
Mar 31 17:50:10 pescadero kernel: Kernel Free SCB list: 10 0 2 7 1 9 8
Mar 31 17:50:10 pescadero kernel: DevQ(0:3:0): 0 waiting
Mar 31 17:50:10 pescadero kernel: DevQ(0:4:0): 0 waiting
Mar 31 17:50:10 pescadero kernel: scsi0:0:4:0: Cmd aborted from QINFIFO
Mar 31 17:50:10 pescadero kernel: aic7xxx_abort returns 8194
Mar 31 17:50:10 pescadero kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Mar 31 17:50:10 pescadero kernel: scsi0: Dumping Card State in Data-out phase,
at SEQADDR 0x54
Mar 31 17:50:10 pescadero kernel: SCSISEQ = 0x12, SBLKCTL = 0xa
Mar 31 17:50:10 pescadero kernel:  DFCNTRL = 0x2c, DFSTATUS = 0x0
Mar 31 17:50:10 pescadero kernel: LASTPHASE = 0x0, SCSISIGI = 0x14, SXFRCTL0 =
0x80
Mar 31 17:50:10 pescadero kernel: SSTAT0 = 0x0, SSTAT1 = 0x2
Mar 31 17:50:10 pescadero kernel: STACK == 0x67, 0x16b, 0x0, 0x8e
Mar 31 17:50:10 pescadero kernel: SCB count = 12
Mar 31 17:50:10 pescadero kernel: Kernel NEXTQSCB = 5
Mar 31 17:50:10 pescadero kernel: Card NEXTQSCB = 6
Mar 31 17:50:10 pescadero kernel: QINFIFO entries: 6
Mar 31 17:50:10 pescadero kernel: Waiting Queue entries:
Mar 31 17:50:10 pescadero kernel: Disconnected Queue entries: 8:11
Mar 31 17:50:10 pescadero kernel: QOUTFIFO entries:
Mar 31 17:50:10 pescadero kernel: Sequencer Free SCB List: 5 0 2 4 1 7 3 9 10 11
12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
Mar 31 17:50:10 pescadero kernel: Pending list: 11 6 3
Mar 31 17:50:10 pescadero kernel: Kernel Free SCB list: 4 10 0 2 7 1 9 8
Mar 31 17:50:10 pescadero kernel: DevQ(0:3:0): 0 waiting
Mar 31 17:50:10 pescadero kernel: DevQ(0:4:0): 0 waiting
Mar 31 17:50:10 pescadero kernel: Recovery SCB completes
Mar 31 17:50:10 pescadero kernel: (scsi0:A:4:0): Queuing a recovery SCB
Mar 31 17:50:10 pescadero kernel: scsi0:0:4:0: Device is disconnected,
re-queuing SCB
Mar 31 17:50:10 pescadero kernel: Recovery code sleeping
Mar 31 17:50:10 pescadero kernel: Recovery code awake
Mar 31 17:50:10 pescadero kernel: aic7xxx_abort returns 8194
Mar 31 17:50:10 pescadero kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Mar 31 17:50:10 pescadero kernel: scsi0: Dumping Card State in Data-out phase,
at SEQADDR 0x5f
Mar 31 17:50:10 pescadero kernel: SCSISEQ = 0x12, SBLKCTL = 0xa
Mar 31 17:50:10 pescadero kernel:  DFCNTRL = 0x2c, DFSTATUS = 0x0
Mar 31 17:50:10 pescadero kernel: LASTPHASE = 0x0, SCSISIGI = 0x14, SXFRCTL0 =
0x80
Mar 31 17:50:10 pescadero kernel: SSTAT0 = 0x0, SSTAT1 = 0x2
Mar 31 17:50:10 pescadero kernel: STACK == 0x67, 0x16b, 0x0, 0x8e
Mar 31 17:50:10 pescadero kernel: SCB count = 12
Mar 31 17:50:10 pescadero kernel: Kernel NEXTQSCB = 6
Mar 31 17:50:10 pescadero kernel: Card NEXTQSCB = 11
Mar 31 17:50:10 pescadero kernel: QINFIFO entries: 11 5
Mar 31 17:50:10 pescadero kernel: Waiting Queue entries:
Mar 31 17:50:10 pescadero kernel: Disconnected Queue entries:
Mar 31 17:50:10 pescadero kernel: QOUTFIFO entries:
Mar 31 17:50:10 pescadero kernel: Sequencer Free SCB List: 8 5 0 2 4 1 7 3 9 10
11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
Mar 31 17:50:10 pescadero kernel: Pending list: 5 11 3
Mar 31 17:50:10 pescadero kernel: Kernel Free SCB list: 4 10 0 2 7 1 9 8
Mar 31 17:50:10 pescadero kernel: DevQ(0:3:0): 0 waiting
Mar 31 17:50:10 pescadero kernel: DevQ(0:4:0): 0 waiting
Mar 31 17:50:10 pescadero kernel: scsi0:0:4:0: Cmd aborted from QINFIFO
Mar 31 17:50:10 pescadero kernel: aic7xxx_abort returns 8194
Mar 31 17:50:10 pescadero kernel: scsi0:0:4:0: Attempting to queue a TARGET
RESET message
Mar 31 17:50:10 pescadero kernel: scsi0:0:4:0: Command not found
Mar 31 17:50:10 pescadero kernel: aic7xxx_dev_reset returns 8194
Mar 31 17:50:10 pescadero kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Mar 31 17:50:10 pescadero kernel: scsi0: Dumping Card State in Data-out phase,
at SEQADDR 0x90
Mar 31 17:50:10 pescadero kernel: SCSISEQ = 0x12, SBLKCTL = 0xa
Mar 31 17:50:10 pescadero kernel:  DFCNTRL = 0x2c, DFSTATUS = 0x0
Mar 31 17:50:10 pescadero kernel: LASTPHASE = 0x0, SCSISIGI = 0x14, SXFRCTL0 =
0x80
Mar 31 17:50:10 pescadero kernel: SSTAT0 = 0x0, SSTAT1 = 0x2
Mar 31 17:50:10 pescadero kernel: STACK == 0x8e, 0x67, 0x16b, 0x0
Mar 31 17:50:10 pescadero kernel: SCB count = 12
Mar 31 17:50:10 pescadero kernel: Kernel NEXTQSCB = 5
Mar 31 17:50:10 pescadero kernel: Card NEXTQSCB = 6
Mar 31 17:50:10 pescadero kernel: QINFIFO entries: 6 11
Mar 31 17:50:10 pescadero kernel: Waiting Queue entries:
Mar 31 17:50:10 pescadero kernel: Disconnected Queue entries:
Mar 31 17:50:10 pescadero kernel: QOUTFIFO entries:
Mar 31 17:50:10 pescadero kernel: Sequencer Free SCB List: 8 5 0 2 4 1 7 3 9 10
11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
Mar 31 17:50:10 pescadero kernel: Pending list: 11 6 3
Mar 31 17:50:10 pescadero kernel: Kernel Free SCB list: 4 10 0 2 7 1 9 8
Mar 31 17:50:10 pescadero kernel: DevQ(0:3:0): 0 waiting
Mar 31 17:50:10 pescadero kernel: DevQ(0:4:0): 0 waiting
Mar 31 17:50:10 pescadero kernel: scsi0:0:4:0: Cmd aborted from QINFIFO
Mar 31 17:50:10 pescadero kernel: aic7xxx_abort returns 8194
Mar 31 17:50:10 pescadero kernel: Recovery SCB completes
Mar 31 17:50:10 pescadero kernel: Recovery SCB completes
Mar 31 17:50:10 pescadero kernel: (scsi0:A:3): 3.300MB/s transfers
Mar 31 17:50:10 pescadero kernel: scsi0: target 3 using asynchronous transfers
Mar 31 17:50:10 pescadero kernel: (scsi0:A:4): 40.000MB/s transfers (40.000MHz,
offset 31)
Mar 31 17:50:10 pescadero kernel: scsi0: target 4 using 8bit transfers
Mar 31 17:50:10 pescadero kernel: (scsi0:A:4): 3.300MB/s transfers
Mar 31 17:50:10 pescadero kernel: scsi0: target 4 using asynchronous transfers
Mar 31 17:50:10 pescadero kernel: scsi0: SCSI bus reset delivered. 2 SCBs
aborted.
Mar 31 17:50:10 pescadero kernel: (scsi0:A:4:0): Sending WDTR 1
Mar 31 17:50:10 pescadero kernel: (scsi0:A:4:0): Received WDTR 1 filtered to 1
Mar 31 17:50:10 pescadero kernel: (scsi0:A:4): 6.600MB/s transfers (16bit)
Mar 31 17:50:10 pescadero kernel: scsi0: target 4 using 16bit transfers
Mar 31 17:50:10 pescadero kernel: (scsi0:A:4:0): Sending SDTR period a, offset
1f
Mar 31 17:50:10 pescadero kernel: (scsi0:A:4:0): Received SDTR period a, offset
1f
Mar 31 17:50:10 pescadero kernel: ^IFiltered to period a, offset 1f
Mar 31 17:50:10 pescadero kernel: (scsi0:A:4): 80.000MB/s transfers (40.000MHz,
offset 31, 16bit)
Mar 31 17:50:10 pescadero kernel: scsi0: target 4 synchronous at 40.0MHz, offset
= 0x1f
Mar 31 17:50:10 pescadero kernel: (scsi0:A:4:0): Sending WDTR 1
Mar 31 17:50:10 pescadero kernel: (scsi0:A:4:0): Received WDTR 1 filtered to 1
Mar 31 17:50:10 pescadero kernel: (scsi0:A:4): 6.600MB/s transfers (16bit)
Mar 31 17:50:10 pescadero kernel: scsi0: target 4 using asynchronous transfers
Mar 31 17:50:10 pescadero kernel: (scsi0:A:4:0): Sending SDTR period a, offset
1f
Mar 31 17:50:10 pescadero kernel: (scsi0:A:4:0): Received SDTR period a, offset
1f
Mar 31 17:50:10 pescadero kernel: ^IFiltered to period a, offset 1f
Mar 31 17:50:10 pescadero kernel: (scsi0:A:4): 80.000MB/s transfers (40.000MHz,
offset 31, 16bit)
Mar 31 17:50:10 pescadero kernel: scsi0: target 4 synchronous at 40.0MHz, offset
= 0x1f
Mar 31 17:50:10 pescadero kernel: (scsi0:A:3:0): Sending SDTR period c, offset f

Mar 31 17:50:10 pescadero kernel: (scsi0:A:3:0): Received SDTR period c, offset
f
Mar 31 17:50:10 pescadero kernel: ^IFiltered to period c, offset f
Mar 31 17:50:10 pescadero kernel: (scsi0:A:3): 20.000MB/s transfers (20.000MHz,
offset 15)
Mar 31 17:50:10 pescadero kernel: scsi0: target 3 synchronous at 20.0MHz, offset
= 0xf
Mar 31 17:50:10 pescadero kernel: (scsi0:A:3:0): Sending SDTR period c, offset f

Mar 31 17:50:10 pescadero kernel: (scsi0:A:3:0): Received SDTR period c, offset
f
Mar 31 17:50:10 pescadero kernel: ^IFiltered to period c, offset f
Mar 31 17:50:10 pescadero kernel: (scsi0:A:3:0): Sending SDTR period c, offset f

Mar 31 17:50:10 pescadero kernel: (scsi0:A:3:0): Received SDTR period c, offset
f
Mar 31 17:50:10 pescadero kernel: ^IFiltered to period c, offset f
Mar 31 17:50:10 pescadero kernel: Device not ready.  Make sure there is a disc
in the drive.


I have removed some packet filter loggings and some messages from alsa. I hope
this
could sovle some the problems. I have the same problems with 2.2.19 but 2.2.18
is
running  without problems and  2.4.1 is also OK. The revovery takes about four
minutes if that
could be of any help.

<--
foo!



