Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267191AbRGKDUC>; Tue, 10 Jul 2001 23:20:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267193AbRGKDTx>; Tue, 10 Jul 2001 23:19:53 -0400
Received: from c526559-a.rchdsn1.tx.home.com ([24.0.107.130]:22400 "EHLO
	ledzep.dyndns.org") by vger.kernel.org with ESMTP
	id <S267191AbRGKDTi>; Tue, 10 Jul 2001 23:19:38 -0400
Message-ID: <3B4BC5C0.BDDC12A6@home.com>
Date: Tue, 10 Jul 2001 22:19:28 -0500
From: Jordan <ledzep37@home.com>
Reply-To: Jordan <ledzep37@home.com>,
        Jordan Breeding <jordan.breeding@inet.com>
Organization: University of Texas at Dallas - Student
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-ac2-acpi-reiserfs-3.6.25 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: Dave J <davej@suse.de>
Subject: Discrepancies between /proc/cpuinfo and Dave J's x86info
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While trying to figure out what happened to make my two identical
processors show up differently in /proc/cpuinfo I noticed that they do
not appear differently in the x86info utility.  Here is a copy of my
/proc/cpuinfo:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 999.682
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse
bogomips        : 1992.29

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 999.682
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 3
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse
bogomips        : 1998.84

Notice that the cpuid level and bogomips values are reported to be
different, but look at the output of `x86info -a`:

x86info v1.3.  Dave Jones 2001
Feedback to <davej@suse.de>.

Found 2 CPUs
eax in: 0, eax = 00000002 ebx = 756e6547 ecx = 6c65746e edx = 49656e69
eax in: 1, eax = 00000686 ebx = 00000002 ecx = 00000000 edx = 0383fbff
eax in: 2, eax = 03020101 ebx = 00000000 ecx = 00000000 edx = 0c040882
Vendor ID: "GenuineIntel"; Max CPUID level 2

Intel-specific functions
Family: 6 Model: 8 Type 0 [Celeron / Pentium III (Coppermine) Original
OEM]
Stepping: 6
Reserved: 0

Feature flags 0383fbff:
FPU    Floating Point Unit
VME    Virtual 8086 Mode Enhancements
DE     Debugging Extensions
PSE    Page Size Extensions
TSC    Time Stamp Counter
MSR    Model Specific Registers
PAE    Physical Address Extension
MCE    Machine Check Exception
CX8    COMPXCHG8B Instruction
APIC   On-chip Advanced Programmable Interrupt Controller present and
enabled
SEP    Fast System Call
MTRR   Memory Type Range Registers
PGE    PTE Global Flag
MCA    Machine Check Architecture
CMOV   Conditional Move and Compare Instructions
FGPAT  Page Attribute Table
PSE-36 36-bit Page Size Extension
MMX    MMX instruction set
FXSR   Fast FP/MMX Streaming SIMD Extensions save/restore
XMM    Streaming SIMD Extensions instruction set
Instruction TLB: 4KB pages, 4-way set assoc, 32 entries
Instruction TLB: 4MB pages, fully assoc, 2 entries
Data TLB: 4KB pages, 4-way set assoc, 64 entries
L2 unified cache: Sectored, 32 byte cache line, 8 way set associative,
256K
Instruction cache: 16KB, 4-way set assoc, 32 byte line size
Data TLB: 4MB pages, 4-way set assoc, 8 entries
Data cache: 16KB, 2-way or 4-way set assoc, 32 byte line size
Erk, MCG_CTL not present!
eax in: 0, eax = 00000002 ebx = 756e6547 ecx = 6c65746e edx = 49656e69
eax in: 1, eax = 00000686 ebx = 00000002 ecx = 00000000 edx = 0383fbff
eax in: 2, eax = 03020101 ebx = 00000000 ecx = 00000000 edx = 0c040882
Vendor ID: "GenuineIntel"; Max CPUID level 2

Intel-specific functions
Family: 6 Model: 8 Type 0 [Celeron / Pentium III (Coppermine) Original
OEM]
Stepping: 6
Reserved: 0

Feature flags 0383fbff:
FPU    Floating Point Unit
VME    Virtual 8086 Mode Enhancements
DE     Debugging Extensions
PSE    Page Size Extensions
TSC    Time Stamp Counter
MSR    Model Specific Registers
PAE    Physical Address Extension
MCE    Machine Check Exception
CX8    COMPXCHG8B Instruction
APIC   On-chip Advanced Programmable Interrupt Controller present and
enabled
SEP    Fast System Call
MTRR   Memory Type Range Registers
PGE    PTE Global Flag
MCA    Machine Check Architecture
CMOV   Conditional Move and Compare Instructions
FGPAT  Page Attribute Table
PSE-36 36-bit Page Size Extension
MMX    MMX instruction set
FXSR   Fast FP/MMX Streaming SIMD Extensions save/restore
XMM    Streaming SIMD Extensions instruction set
Instruction TLB: 4KB pages, 4-way set assoc, 32 entries
Instruction TLB: 4MB pages, fully assoc, 2 entries
Data TLB: 4KB pages, 4-way set assoc, 64 entries
L2 unified cache: Sectored, 32 byte cache line, 8 way set associative,
256K
Instruction cache: 16KB, 4-way set assoc, 32 byte line size
Data TLB: 4MB pages, 4-way set assoc, 8 entries
Data cache: 16KB, 2-way or 4-way set assoc, 32 byte line size
Erk, MCG_CTL not present!
999MHz processor (estimate).

According to Dave J's utility the cpu's appear to be exactly the same
just as the Intel boxes said when I bought them.  What might be causing
these values to be different.  And if the BIOS is setting things up
incorrectly then why does Dave J's utility show the correct values? 
Thanks for any help.

Jordan
