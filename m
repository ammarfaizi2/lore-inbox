Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288295AbSACUKy>; Thu, 3 Jan 2002 15:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288298AbSACUKf>; Thu, 3 Jan 2002 15:10:35 -0500
Received: from [66.189.64.253] ([66.189.64.253]:18080 "HELO majere.epithna.com")
	by vger.kernel.org with SMTP id <S288295AbSACUK1>;
	Thu, 3 Jan 2002 15:10:27 -0500
Date: Thu, 3 Jan 2002 15:10:10 -0500 (EST)
From: <listmail@majere.epithna.com>
To: Steve Snyder <swsnyder@home.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "APIC error on CPUx" - what does this mean?
In-Reply-To: <20020103195551.BEHH23959.femail47.sdc1.sfba.home.com@there>
Message-ID: <Pine.LNX.4.33.0201031506400.5246-100000@majere.epithna.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure if it will help or if its relavant toy uor situation, but I was
seeing this often several months ago on one of my machines.  I took it
down for some work one day, and just happened to take the heat sync off...
This machine has a celeron CPU in it(2 in fact) well you know how you can
see the tops of the PINs in the packaging material.  turns out that my
cooler was working too well, and I had been getting condensation on the
underside of the heatsync.  well that caused many pins to become cross
connected, due to the oxidation of the metal.  Your issue might be
similar.

On Thu, 3 Jan 2002, Steve Snyder wrote:

> I just noticed the following events in my system log:
>
>   Jan  3 14:03:39 mercury kernel: APIC error on CPU1: 00(02)
>   Jan  3 14:03:39 mercury kernel: APIC error on CPU0: 00(02)
>
> Below I've listed the CPU/APIC-related parts of my system start-up.
>
> This kernel is not patched with anything; it's just a generic v2.4.17.
>
> I didn't notice any problem in operation when these events were logged.
>
> Looking at the older logs I see that I got the same set of events on Dec.
> 8th, so I guess that rules out any 2.4.17-specific changes as a culprit.
> Also, I wasn't updating the CPU microcode (see below) on Dec. 8th, so this
> can be held blameless as well.
>
> Please let me know if I can provide any additional info needed to diagnose
> this error.
>
> Thanks.
>
> -------------------------------
>
>  kernel: Linux version 2.4.17 (root@mercury.snydernet.lan) (gcc version
> 2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #1 SMP Fri Dec 21 17:19:29 EST
> 2001
>  kernel: BIOS-provided physical RAM map:
>  kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>  kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>  kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>  kernel:  BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
>  kernel:  BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
>  kernel:  BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
>  kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
>  kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
>  kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
>  kernel: found SMP MP-table at 000f5a60
>  kernel: hm, page 000f5000 reserved twice.
>  kernel: hm, page 000f6000 reserved twice.
>  kernel: hm, page 000f1000 reserved twice.
>  kernel: hm, page 000f2000 reserved twice.
>  kernel: On node 0 totalpages: 131056
>  kernel: zone(0): 4096 pages.
>  kernel: zone(1): 126960 pages.
>  kernel: zone(2): 0 pages.
>  kernel: Intel MultiProcessor Specification v1.1
>  kernel:     Virtual Wire compatibility mode.
>  kernel: OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
>  kernel: Processor #0 Pentium(tm) Pro APIC version 17
>  kernel: Processor #1 Pentium(tm) Pro APIC version 17
>  kernel: I/O APIC #2 Version 17 at 0xFEC00000.
>  kernel: Processors: 2
>  kernel: Kernel command line: ro root=/dev/sda3 nousb
>  kernel: Initializing CPU#0
>  kernel: Detected 847.753 MHz processor.
>  kernel: Console: colour VGA+ 80x25
>  kernel: Calibrating delay loop... 1690.82 BogoMIPS
>  kernel: Memory: 513464k/524224k available (1227k kernel code, 10372k
> reserved, 334k data, 212k init, 0k highmem)
>  kernel: Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
>  kernel: Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
>  kernel: Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
>  kernel: Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
>  kernel: Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
>  kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
>  kernel: CPU: L2 cache: 256K
>  kernel: Intel machine check architecture supported.
>  kernel: Intel machine check reporting enabled on CPU#0.
>  kernel: Enabling fast FPU save and restore... done.
>  kernel: Enabling unmasked SIMD FPU exception support... done.
>  kernel: Checking 'hlt' instruction... OK.
>  kernel: POSIX conformance testing by UNIFIX
>  kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
>  kernel: mtrr: detected mtrr type: Intel
>  kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
>  kernel: CPU: L2 cache: 256K
>  random: Initializing random number generator:  succeededJan  2 23:06:08
>  kernel: Intel machine check reporting enabled on CPU#0.
>  kernel: CPU0: Intel Pentium III (Coppermine) stepping 03
>  kernel: per-CPU timeslice cutoff: 731.29 usecs.
>  kernel: enabled ExtINT on CPU#0
>  kernel: ESR value before enabling vector: 00000000
>  kernel: ESR value after enabling vector: 00000000
>  kernel: Booting processor 1/1 eip 2000
>  kernel: Initializing CPU#1
>  kernel: masked ExtINT on CPU#1
>  kernel: ESR value before enabling vector: 00000000
>  kernel: ESR value after enabling vector: 00000000
>  kernel: Calibrating delay loop... 1690.82 BogoMIPS
>  kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
>  kernel: CPU: L2 cache: 256K
>  kernel: Intel machine check reporting enabled on CPU#1.
>  kernel: CPU1: Intel Pentium III (Coppermine) stepping 03
>  kernel: Total of 2 processors activated (3381.65 BogoMIPS).
>  kernel: ENABLING IO-APIC IRQs
>  kernel: Setting 2 in the phys_id_present_map
>  kernel: ...changing IO-APIC physical APIC ID to 2 ... ok.
>  kernel: ..TIMER: vector=0x31 pin1=2 pin2=0
>  kernel: testing the IO APIC.......................
>  kernel:
>  kernel: .................................... done.
>  kernel: Using local APIC timer interrupts.
>  kernel: calibrating APIC timer ...
>  kernel: ..... CPU clock speed is 847.7664 MHz.
>  kernel: ..... host bus clock speed is 99.7368 MHz.
>  kernel: cpu: 0, clocks: 997368, slice: 332456
>  kernel: CPU0<T0:997360,T1:664896,D:8,S:332456,C:997368>
>  kernel: cpu: 1, clocks: 997368, slice: 332456
>  kernel: CPU1<T0:997360,T1:332448,D:0,S:332456,C:997368>
>  kernel: checking TSC synchronization across CPUs: passed.
>  kernel: Waiting on wait_init_idle (map = 0x2)
>  kernel: All processors have done init_idle
>  kernel: mtrr: your CPUs had inconsistent fixed MTRR settings
>  kernel: mtrr: probably your BIOS does not setup all CPUsJan  2 23:06:09
>  kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb150, last bus=1
>  kernel: PCI: Using configuration type 1
>  kernel: PCI: Probing PCI hardware
>  kernel: PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
>  kernel: Limiting direct PCI/PCI transfers.
>  .
>  .
>  .
>  kernel: IA-32 Microcode Update Driver: v1.09 <tigran@veritas.com>
>  kernel: microcode: CPU1 updated from revision 12 to 19, date=02062001
>  kernel: microcode: CPU0 updated from revision 12 to 19, date=02062001
>  kernel: microcode: freed 4096 bytes
>  kernel: IA-32 Microcode Update Driver v1.09 unregistered
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

