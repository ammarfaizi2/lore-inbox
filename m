Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273912AbRJKJOh>; Thu, 11 Oct 2001 05:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274964AbRJKJO2>; Thu, 11 Oct 2001 05:14:28 -0400
Received: from trantor.dso.org.sg ([192.190.204.1]:53974 "EHLO
	trantor.dso.org.sg") by vger.kernel.org with ESMTP
	id <S273912AbRJKJON>; Thu, 11 Oct 2001 05:14:13 -0400
Date: Thu, 11 Oct 2001 17:16:53 +0800
From: Richard Shih-Ping Chan <cshihpin@dso.org.sg>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Richard Chan <cshihpin@dso.org.sg>, linux-kernel@vger.kernel.org
Subject: Re: -ac10,-ac11 no boot on SMP PentiumII box
Message-ID: <20011011171653.C1174@cshihpin.dso.org.sg>
In-Reply-To: <20011011110327.B25934@cshihpin.dso.org.sg> <E15rZx5-0002H4-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15rZx5-0002H4-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Oct 11, 2001 at 08:08:19AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK - it's definitely related to the change in -ac8 to -ac9
where CONFIG_X86_PPRO_FENCE was introduced.
If I make a vanilla kernel (CONFIG_X86_PPRO_FENCE defined)
it hangs after booting CPU#0 and console detection.

If I undef CONFIG_X86_PPRO_FENCE the thing boots OK.

Front of dmesg

        Linux version 2.4.10-1ac9smp (root@titian) (gcc version 3.0.1) #2 SMP Thu Oct 11 17:00:05 SGT 2001
        BIOS-provided physical RAM map:
         BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
         BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
         BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
         BIOS-e820: 0000000000100000 - 0000000010000000 (usable)
         BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
         BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
         BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
        found SMP MP-table at 000f5a60
        hm, page 000f5000 reserved twice.
        hm, page 000f6000 reserved twice.
        hm, page 000f1000 reserved twice.
        hm, page 000f2000 reserved twice.
        On node 0 totalpages: 65536
        zone(0): 4096 pages.
        zone(1): 61440 pages.
        zone(2): 0 pages.
        Intel MultiProcessor Specification v1.1
            Virtual Wire compatibility mode.
        OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
        Processor #0 Pentium(tm) Pro APIC version 17
        Processor #1 Pentium(tm) Pro APIC version 17
        I/O APIC #2 Version 17 at 0xFEC00000.
        Processors: 2
        Kernel command line: mem=262144K  root=/dev/sda1 ro
        Initializing CPU#0
        Detected 448.809 MHz processor.
        Console: colour VGA+ 80x25
=========================> HANG HEAR IF CONFIG_X86_PPRO_FENCE is defined<===================
        Calibrating delay loop... 894.56 BogoMIPS
        Memory: 251860k/262144k available (1462k kernel code, 9896k reserved, 370k data, 236k init, 0k highmem)
        Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
        Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
        Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
        Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
        Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
        CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor = 0
        CPU: L1 I cache: 16K, L1 D cache: 16K
        CPU: L2 cache: 512K
        CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
        Intel machine check architecture supported.
        Intel machine check reporting enabled on CPU#0.
        CPU:     After generic, caps: 0183fbff 00000000 00000000 00000000
        CPU:             Common caps: 0183fbff 00000000 00000000 00000000
        Enabling fast FPU save and restore... done.
        Checking 'hlt' instruction... OK.
        POSIX conformance testing by UNIFIX
        mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
        mtrr: detected mtrr type: Intel
        CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor = 0
        CPU: L1 I cache: 16K, L1 D cache: 16K
        CPU: L2 cache: 512K
        CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
        Intel machine check reporting enabled on CPU#0.
        CPU:     After generic, caps: 0183fbff 00000000 00000000 00000000
        CPU:             Common caps: 0183fbff 00000000 00000000 00000000
        CPU0: Intel Pentium II (Deschutes) stepping 02
        per-CPU timeslice cutoff: 1464.52 usecs.
        enabled ExtINT on CPU#0
        ESR value before enabling vector: 00000000
        ESR value after enabling vector: 00000000
        Booting processor 1/1 eip 2000
        Initializing CPU#1
        masked ExtINT on CPU#1
        ESR value before enabling vector: 00000000
        ESR value after enabling vector: 00000000
        Calibrating delay loop... 894.56 BogoMIPS
        CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor = 0
        CPU: L1 I cache: 16K, L1 D cache: 16K
        CPU: L2 cache: 512K
        CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
        Intel machine check reporting enabled on CPU#1.
        CPU:     After generic, caps: 0183fbff 00000000 00000000 00000000
        CPU:             Common caps: 0183fbff 00000000 00000000 00000000
        CPU1: Intel Pentium II (Deschutes) stepping 02
        Total of 2 processors activated (1789.13 BogoMIPS).
        ENABLING IO-APIC IRQs
        ...changing IO-APIC physical APIC ID to 2 ... ok.
        init IO_APIC IRQs
         IO-APIC (apicid-pin) 2-0, 2-10, 2-11, 2-17, 2-18, 2-20, 2-21, 2-22, 2-23 not connected.
        ..TIMER: vector=0x31 pin1=2 pin2=0
        number of MP IRQ sources: 16.
        number of IO-APIC #2 registers: 24.
        testing the IO APIC.......................
        
        IO APIC #2......
        .... register #00: 02000000
        .......    : physical APIC id: 02
        .... register #01: 00170011
        .......     : max redirection entries: 0017
        .......     : PRQ implemented: 0
        .......     : IO APIC version: 0011
        .... register #02: 00000000
        .......     : arbitration: 00
        .... IRQ redirection table:
         NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
         00 000 00  1    0    0   0   0    0    0    00
         01 003 03  0    0    0   0   0    1    1    39
         02 003 03  0    0    0   0   0    1    1    31
         03 003 03  0    0    0   0   0    1    1    41
         04 003 03  0    0    0   0   0    1    1    49
         05 003 03  0    0    0   0   0    1    1    51
         06 003 03  0    0    0   0   0    1    1    59
         07 003 03  0    0    0   0   0    1    1    61
         08 003 03  0    0    0   0   0    1    1    69
         09 003 03  0    0    0   0   0    1    1    71
         0a 000 00  1    0    0   0   0    0    0    00
         0b 000 00  1    0    0   0   0    0    0    00
         0c 003 03  0    0    0   0   0    1    1    79
         0d 003 03  0    0    0   0   0    1    1    81
         0e 003 03  0    0    0   0   0    1    1    89
         0f 003 03  0    0    0   0   0    1    1    91
         10 003 03  1    1    0   1   0    1    1    99
         11 000 00  1    0    0   0   0    0    0    00
         12 000 00  1    0    0   0   0    0    0    00
         13 003 03  1    1    0   1   0    1    1    A1
         14 000 00  1    0    0   0   0    0    0    00
         15 000 00  1    0    0   0   0    0    0    00
         16 000 00  1    0    0   0   0    0    0    00
         17 000 00  1    0    0   0   0    0    0    00
        IRQ to pin mappings:
        IRQ0 -> 0:2
        IRQ1 -> 0:1
        IRQ3 -> 0:3
        IRQ4 -> 0:4
        IRQ5 -> 0:5
        IRQ6 -> 0:6
        IRQ7 -> 0:7
        IRQ8 -> 0:8
        IRQ9 -> 0:9
        IRQ10 -> 0:16
        IRQ11 -> 0:19
        IRQ12 -> 0:12
        IRQ13 -> 0:13
        IRQ14 -> 0:14
        IRQ15 -> 0:15
        .................................... done.
        Using local APIC timer interrupts.
        calibrating APIC timer ...
        ..... CPU clock speed is 448.7981 MHz.
        ..... host bus clock speed is 99.7324 MHz.
        cpu: 0, clocks: 997324, slice: 332441
        CPU0<T0:997312,T1:664864,D:7,S:332441,C:997324>
        cpu: 1, clocks: 997324, slice: 332441
        CPU1<T0:997312,T1:332416,D:14,S:332441,C:997324>
        checking TSC synchronization across CPUs: passed.
        Waiting on wait_init_idle (map = 0x2)
        All processors have done init_idle
        mtrr: your CPUs had inconsistent fixed MTRR settings
        mtrr: probably your BIOS does not setup all CPUs
        PCI: PCI BIOS revision 2.10 entry at 0xfafd0, last bus=1
        PCI: Using configuration type 1
        PCI: Probing PCI hardware
        Unknown bridge resource 2: assuming transparent
        PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
        Limiting direct PCI/PCI transfers.




On Thu, Oct 11, 2001 at 08:08:19AM +0100, Alan Cox wrote:
> > Normally I would expect "Calibrating delay loop..." but no go.
> > 
> > Last -ac kernel tried was 2.4.9-ac10 with success.
> > 2.4.10 stock also works.
> > 
> > Has anything affected the CPU startup code?
> 
> Not that I am aware of. There are some locking changes in specific cases
> but I tested that still booted on my dual PPro
> 
> Alan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Richard Chan <cshihpin@dso.org.sg>
DSO National Laboratories
20 Science Park Drive
Singapore 118230
Tel: 7727045
Fax: 7766476
