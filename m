Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268875AbTBZTUt>; Wed, 26 Feb 2003 14:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268876AbTBZTUt>; Wed, 26 Feb 2003 14:20:49 -0500
Received: from fmr01.intel.com ([192.55.52.18]:22211 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S268875AbTBZTUl>;
	Wed, 26 Feb 2003 14:20:41 -0500
Message-ID: <F760B14C9561B941B89469F59BA3A8471380D0@orsmsx401.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: Joel Jaeggli <joelja@darkwing.uoregon.edu>,
       Andrew Theurer <habanero@us.ibm.com>
Cc: Andrew Walrond <andrew@walrond.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: /proc/cpuinfo shows only 2 processors on dual P4-Xeon system
Date: Wed, 26 Feb 2003 11:30:46 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Processors are LOCAL apics, not IO APICS.

Your system may have 4 IO APICs but that is a coincidence. There should
have been some LAPIC lines, and these are the processors.

-- Andy

> -----Original Message-----
> From: Joel Jaeggli [mailto:joelja@darkwing.uoregon.edu] 
> Sent: Wednesday, February 26, 2003 11:15 AM
> To: Andrew Theurer
> Cc: Andrew Walrond; Grover, Andrew; Linux Kernel Mailing List
> Subject: Re: /proc/cpuinfo shows only 2 processors on dual 
> P4-Xeon system
> Importance: High
> 
> 
> On Wed, 26 Feb 2003, Andrew Theurer wrote:
> 
> > Does your system BIOS have an option to enable/disable HT 
> support?  If it 
> > does, make sure it is enabled.
> > 
> > I would have expected to see 4 ioapics, but hmm, I don't 
> really know.
> 
> you should, here is the dmesg output from a working system with ht 
> enabled...
> 
> 00000
> ESR value after enabling vector: 00000000
> Calibrating delay loop... 5590.08 BogoMIPS
> CPU: Before vendor init, caps: bfebfbff 00000000 00000000, vendor = 0
> CPU: L1 I cache: 0K, L1 D cache: 8K
> CPU: L2 cache: 512K
> CPU: Physical Processor ID: 0
> CPU: After vendor init, caps: bfebfbff 00000000 00000000 00000000
> Intel machine check reporting enabled on CPU#3.
> CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
> CPU:             Common caps: bfebfbff 00000000 00000000 00000000
> CPU3: Intel(R) Xeon(TM) CPU 2.80GHz stepping 07
> Total of 4 processors activated (22326.91 BogoMIPS).
> cpu_sibling_map[0] = 3
> cpu_sibling_map[1] = 2
> cpu_sibling_map[2] = 1
> cpu_sibling_map[3] = 0
> ENABLING IO-APIC IRQs
> Setting 8 in the phys_id_present_map
> ...changing IO-APIC physical APIC ID to 8 ... ok.
> Setting 9 in the phys_id_present_map
> ...changing IO-APIC physical APIC ID to 9 ... ok.
> Setting 10 in the phys_id_present_map
> ...changing IO-APIC physical APIC ID to 10 ... ok.
> Setting 11 in the phys_id_present_map
> ...changing IO-APIC physical APIC ID to 11 ... ok.
> init IO_APIC IRQs
>  IO-APIC (apicid-pin) 8-0, 8-5, 8-9, 8-11, 9-0, 9-5, 9-6, 
> 9-7, 9-8, 9-9, 
> 9-10, 9
> -11, 9-12, 9-13, 10-0, 10-1, 10-2, 10-3, 10-4, 10-5, 10-6, 
> 10-7, 10-8, 
> 10-9, 10-
> 10, 10-11, 10-12, 10-13, 10-14, 10-15, 11-0, 11-1, 11-2, 
> 11-3, 11-4, 11-5, 
> 11-6,
>  11-7, 11-8, 11-9, 11-10, 11-11, 11-12, 11-13, 11-14, 11-15 
> not connected.
> ..TIMER: vector=0x31 pin1=2 pin2=0
> ..MP-BIOS bug: 8254 timer not connected to IO-APIC
> ...trying to set up timer (IRQ0) through the 8259A ... 
> ..... (found pin 0) ...works.
> number of MP IRQ sources: 19.
> number of IO-APIC #8 registers: 16.
> number of IO-APIC #9 registers: 16.
> number of IO-APIC #10 registers: 16.
> number of IO-APIC #11 registers: 16.
> testing the IO APIC.......................
> IO APIC #8......
> .... register #00: 08000000
> .......    : physical APIC id: 08
> .... register #01: 000F0011
> .......     : max redirection entries: 000F
> .......     : PRQ implemented: 0
> .......     : IO APIC version: 0011
> .... register #02: 08000000
> .......     : arbitration: 08
> .... IRQ redirection table:
>  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
>  00 004 04  0    0    0   0   0    1    1    31
>  01 00F 0F  0    0    0   0   0    1    1    39
>  02 008 08  1    0    0   0   0    0    0    00
>  03 00F 0F  0    0    0   0   0    1    1    41
>  04 00F 0F  0    0    0   0   0    1    1    49
>  05 000 00  1    0    0   0   0    0    0    00
>  06 00F 0F  0    0    0   0   0    1    1    51
>  07 00F 0F  0    0    0   0   0    1    1    59
>  08 00F 0F  0    0    0   0   0    1    1    61
>  09 000 00  1    0    0   0   0    0    0    00
>  0a 00F 0F  1    1    0   1   0    1    1    69
>  0b 000 00  1    0    0   0   0    0    0    00
>  0c 00F 0F  0    0    0   0   0    1    1    71
>  0d 00F 0F  0    0    0   0   0    1    1    79
>  0e 00F 0F  0    0    0   0   0    1    1    81
>  0f 00F 0F  0    0    0   0   0    1    1    89
> 
> IO APIC #9......
> .... register #00: 09000000
> .......    : physical APIC id: 09
> .... register #01: 000F0011
> .......     : max redirection entries: 000F
> .......     : PRQ implemented: 0
> .......     : IO APIC version: 0011
> .... register #02: 09000000
> .......     : arbitration: 09
> .... IRQ redirection table:
>  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
>  00 000 00  1    0    0   0   0    0    0    00
>  01 00F 0F  1    1    0   1   0    1    1    91
>  02 00F 0F  1    1    0   1   0    1    1    99
>  03 00F 0F  1    1    0   1   0    1    1    A1
>  04 00F 0F  1    1    0   1   0    1    1    A9
>  05 000 00  1    0    0   0   0    0    0    00
>  06 000 00  1    0    0   0   0    0    0    00
>  07 000 00  1    0    0   0   0    0    0    00
>  08 000 00  1    0    0   0   0    0    0    00
>  09 000 00  1    0    0   0   0    0    0    00
>  0a 000 00  1    0    0   0   0    0    0    00
>  0b 000 00  1    0    0   0   0    0    0    00
>  0c 000 00  1    0    0   0   0    0    0    00
>  0d 000 00  1    0    0   0   0    0    0    00
>  0e 00F 0F  1    1    0   1   0    1    1    B1
>  0f 00F 0F  1    1    0   1   0    1    1    B9
> 
> IO APIC #10......
> .... register #00: 0A000000
> .......    : physical APIC id: 0A
> .... register #01: 000F0011
> .......     : max redirection entries: 000F
> .......     : PRQ implemented: 0
> .......     : IO APIC version: 0011
> .... register #02: 0A000000
> .......     : arbitration: 0A
> .... IRQ redirection table:
>  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
>  00 000 00  1    0    0   0   0    0    0    00
>  01 000 00  1    0    0   0   0    0    0    00
>  02 000 00  1    0    0   0   0    0    0    00
>  03 000 00  1    0    0   0   0    0    0    00
>  04 000 00  1    0    0   0   0    0    0    00
>  05 000 00  1    0    0   0   0    0    0    00
>  06 000 00  1    0    0   0   0    0    0    00
>  07 000 00  1    0    0   0   0    0    0    00
>  08 000 00  1    0    0   0   0    0    0    00
>  09 000 00  1    0    0   0   0    0    0    00
>  0a 000 00  1    0    0   0   0    0    0    00
>  0b 000 00  1    0    0   0   0    0    0    00
>  0c 000 00  1    0    0   0   0    0    0    00
>  0d 000 00  1    0    0   0   0    0    0    00
>  0e 000 00  1    0    0   0   0    0    0    00
>  0f 000 00  1    0    0   0   0    0    0    00
> 
> IO APIC #11......
> .... register #00: 0B000000
> .......    : physical APIC id: 0B
> .... register #01: 000F0011
> .......     : max redirection entries: 000F
> .......     : PRQ implemented: 0
> .......     : IO APIC version: 0011
> .... register #02: 0B000000
> .......     : arbitration: 0B
> .... IRQ redirection table:
>  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
>  00 000 00  1    0    0   0   0    0    0    00
>  01 000 00  1    0    0   0   0    0    0    00
>  02 000 00  1    0    0   0   0    0    0    00
>  03 000 00  1    0    0   0   0    0    0    00
>  04 000 00  1    0    0   0   0    0    0    00
>  05 000 00  1    0    0   0   0    0    0    00
>  06 000 00  1    0    0   0   0    0    0    00
>  07 000 00  1    0    0   0   0    0    0    00
>  08 000 00  1    0    0   0   0    0    0    00
>  09 000 00  1    0    0   0   0    0    0    00
>  0a 000 00  1    0    0   0   0    0    0    00
>  0b 000 00  1    0    0   0   0    0    0    00
>  0c 000 00  1    0    0   0   0    0    0    00
>  0d 000 00  1    0    0   0   0    0    0    00
>  0e 000 00  1    0    0   0   0    0    0    00
>  0f 000 00  1    0    0   0   0    0    0    00
> IRQ to pin mappings:
> IRQ0 -> 0:0
> IRQ1 -> 0:1
> IRQ3 -> 0:3
> IRQ4 -> 0:4
> IRQ6 -> 0:6
> IRQ7 -> 0:7
> IRQ8 -> 0:8
> IRQ10 -> 0:10
> IRQ12 -> 0:12
> IRQ13 -> 0:13
> IRQ14 -> 0:14
> IRQ15 -> 0:15
> IRQ17 -> 1:1
> IRQ18 -> 1:2
> IRQ19 -> 1:3
> IRQ20 -> 1:4
> IRQ30 -> 1:14
> IRQ31 -> 1:15
> .................................... done.
> Using local APIC timer interrupts.
> calibrating APIC timer ...
> ..... CPU clock speed is 2799.1543 MHz.
> ..... host bus clock speed is 99.1938 MHz.
> cpu: 0, clocks: 195285, slice: 39057
> CPU0<T0:195280,T1:156208,D:15,S:39057,C:195285>
> cpu: 1, clocks: 195285, slice: 39057
> cpu: 3, clocks: 195285, slice: 39057
> cpu: 2, clocks: 195285, slice: 39057
> CPU1<T0:195280,T1:117152,D:14,S:39057,C:195285>
> CPU2<T0:195280,T1:78096,D:13,S:39057,C:195285>
> CPU3<T0:195280,T1:39040,D:12,S:39057,C:195285>
> checking TSC synchronization across CPUs: passed.
> migration_task 0 on cpu=0
> migration_task 1 on cpu=1
> migration_task 2 on cpu=2
> migration_task 3 on cpu=3
>  
> > -Andrew Theurer
> > 
> > On Wednesday 26 February 2003 12:37, Andrew Walrond wrote:
> > > Grover, Andrew wrote:
> > > > Enable the ACPI "CPU enumeration only" option.
> > >
> > > Ok - just tried that, but I still see only two processors 
> in cpuinfo
> > >
> > > Any ideas?
> > >
> > > Relevant part of dmesg:
> > >
> > > Using ACPI for processor (LAPIC) configuration information
> > > KERN_INFO Intel MultiProcessor Specification v1.4
> > >      Virtual Wire compatibility mode.
> > > OEM ID: ASUS     Product ID: PROD00000000 APIC at: 0xFEE00000
> > > I/O APIC #8 Version 17 at 0xFEC00000.
> > > I/O APIC #9 Version 17 at 0xFEC01000.
> > > I/O APIC #10 Version 17 at 0xFEC02000.
> > > Enabling APIC mode:  Flat.  Using 3 I/O APICs
> > > Processors: 4
> > > Building zonelist for node : 0
> > > Kernel command line: ro root=/dev/nfs ip=dhcp 
> console=ttyS0,115200n8
> > > console=tty0 init=/boot/boot.sh
> > > Initializing CPU#0
> > > PID hash table entries: 4096 (order 12: 32768 bytes)
> > > Detected 2591.629 MHz processor.
> > > Calibrating delay loop... 5111.80 BogoMIPS
> > > Memory: 3100936k/4194304k available (1348k kernel code, 
> 43644k reserved,
> > > 310k data, 304k init, 2228200k highmem)
> > > Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
> > > Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
> > > Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> > > -> /dev
> > > -> /dev/console
> > > -> /root
> > > CPU: Trace cache: 12K uops, L1 D cache: 8K
> > > CPU: L2 cache: 512K
> > > CPU: Physical Processor ID: 0
> > > CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
> > > Intel machine check architecture supported.
> > > Intel machine check reporting enabled on CPU#0.
> > > CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
> > > CPU#0: Thermal monitoring enabled
> > > Machine check exception polling timer started.
> > > Enabling fast FPU save and restore... done.
> > > Enabling unmasked SIMD FPU exception support... done.
> > > Checking 'hlt' instruction... OK.
> > > POSIX conformance testing by UNIFIX
> > > CPU0: Intel(R) Xeon(TM) CPU 2.60GHz stepping 07
> > > per-CPU timeslice cutoff: 1462.69 usecs.
> > > task migration cache decay timeout: 2 msecs.
> > > enabled ExtINT on CPU#0
> > > ESR value before enabling vector: 00000000
> > > ESR value after enabling vector: 00000000
> > > Booting processor 1/1 eip 2000
> > > Initializing CPU#1
> > > masked ExtINT on CPU#1
> > > ESR value before enabling vector: 00000000
> > > ESR value after enabling vector: 00000000
> > > Calibrating delay loop... 5177.34 BogoMIPS
> > > CPU: Trace cache: 12K uops, L1 D cache: 8K
> > > CPU: L2 cache: 512K
> > > CPU: Physical Processor ID: 0
> > > CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
> > > Intel machine check architecture supported.
> > > Intel machine check reporting enabled on CPU#1.
> > > CPU#1: Intel P4/Xeon Extended MCE MSRs (12) available
> > > CPU#1: Thermal monitoring enabled
> > > CPU1: Intel(R) Xeon(TM) CPU 2.60GHz stepping 07
> > > Total of 2 processors activated (10289.15 BogoMIPS).
> > >
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> -- 
> --------------------------------------------------------------
> ------------ 
> Joel Jaeggli	      Academic User Services   
> joelja@darkwing.uoregon.edu    
> --    PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 
> 121E      --
>   In Dr. Johnson's famous dictionary patriotism is defined as the last
>   resort of the scoundrel.  With all due respect to an enlightened but
>   inferior lexicographer I beg to submit that it is the first.
> 	   	            -- Ambrose Bierce, "The Devil's Dictionary"
> 
> 
