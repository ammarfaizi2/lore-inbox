Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267909AbRGRQRq>; Wed, 18 Jul 2001 12:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267901AbRGRQRi>; Wed, 18 Jul 2001 12:17:38 -0400
Received: from delta.Colorado.EDU ([128.138.139.9]:50441 "EHLO
	ibg.colorado.edu") by vger.kernel.org with ESMTP id <S267904AbRGRQRZ>;
	Wed, 18 Jul 2001 12:17:25 -0400
Message-Id: <200107181617.KAA326921@ibg.colorado.edu>
To: andrewm@uow.edu.au
cc: linux-kernel@vger.kernel.org
Subject: Re: Too much memory causes crash when reading/writing to disk
Organization: Institute for Behavioral Genetics
              University of Colorado
              Boulder, CO  80309-0447
X-Phone: +1 303 492 2843
X-FAX: +1 303 492 0852
X-URL: http://ibgwww.Colorado.EDU/~lessem/
X-Copyright: All original content is copyright 2001 Jeff Lessem.
X-Copyright: Quoted and non-original content may be copyright the
X-Copyright: original author or others.
Date: Wed, 18 Jul 2001 10:17:26 -0600
From: Jeff Lessem <Jeff.Lessem@Colorado.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Jeff Lessem wrote:
>> I tried that, but the Symbios SCSI controller freaks out with noapic.
>> I can be more detailed if that would be useful.
>
>Please do - that sounds like a strange interaction.

I tried with nosmp and that gave the same response as noapic, so here
it is:  It will keep repeating sym53c8xx_reset until the machine is
reset.  I banged on SysRq to try to get some useful information.

[After this log I have more stuff]

BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e000 (usable)
 BIOS-e820: 000000000009e000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000003ff8000 (usable)
 BIOS-e820: 0000000003ff8000 - 0000000003fffc00 (ACPI data)
 BIOS-e820: 0000000003fffc00 - 0000000004000000 (ACPI NVS)
 BIOS-e820: 0000000004000000 - 00000000f0000000 (usable)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000210000000 (usable)
7552MB HIGHMEM available.
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
found SMP MP-table at 000f6590
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
hm, page 0009f000 reserved twice.
On node 0 totalpages: 2162688
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 1933312 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: INTEL    Product ID: OCPRF100     APIC at: 0xFEE00000
Processor #7 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
    PAT  present.
    PSE  present.
    MMX  present.
    FXSR  present.
    XMM  present.
    Bootup CPU
Processor #0 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
    PAT  present.
    PSE  present.
    MMX  present.
    FXSR  present.
    XMM  present.
Processor #1 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
    PAT  present.
    PSE  present.
    MMX  present.
    FXSR  present.
    XMM  present.
Processor #2 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
    PAT  present.
    PSE  present.
    MMX  present.
    FXSR  present.
    XMM  present.
Processor #3 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
    PAT  present.
    PSE  present.
    MMX  present.
    FXSR  present.
    XMM  present.
Processor #4 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
    PAT  present.
    PSE  present.
    MMX  present.
    FXSR  present.
    XMM  present.
Processor #5 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
    PAT  present.
    PSE  present.
    MMX  present.
    FXSR  present.
    XMM  present.
Processor #6 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
    PAT  present.
    PSE  present.
    MMX  present.
    FXSR  present.
    XMM  present.
Bus #0 is PCI   
Bus #1 is PCI   
Bus #2 is PCI   
Bus #3 is PCI   
Bus #4 is PCI   
Bus #5 is PCI   
Bus #6 is ISA   
I/O APIC #8 Version 19 at 0xFEC00000.
Int: type 3, pol 1, trig 1, bus 6, IRQ 00, APIC ID 8, APIC INT 00
Int: type 0, pol 1, trig 1, bus 6, IRQ 01, APIC ID 8, APIC INT 01
Int: type 0, pol 1, trig 1, bus 6, IRQ 00, APIC ID 8, APIC INT 02
Int: type 0, pol 1, trig 1, bus 6, IRQ 03, APIC ID 8, APIC INT 03
Int: type 0, pol 1, trig 1, bus 6, IRQ 04, APIC ID 8, APIC INT 04
Int: type 0, pol 3, trig 3, bus 0, IRQ 14, APIC ID 8, APIC INT 36
Int: type 0, pol 1, trig 1, bus 6, IRQ 06, APIC ID 8, APIC INT 06
Int: type 0, pol 1, trig 1, bus 6, IRQ 07, APIC ID 8, APIC INT 07
Int: type 0, pol 3, trig 1, bus 6, IRQ 08, APIC ID 8, APIC INT 08
Int: type 0, pol 1, trig 1, bus 6, IRQ 09, APIC ID 8, APIC INT 09
Int: type 0, pol 3, trig 3, bus 0, IRQ 00, APIC ID 8, APIC INT 3b
Int: type 0, pol 3, trig 3, bus 0, IRQ 28, APIC ID 8, APIC INT 3a
Int: type 0, pol 1, trig 1, bus 6, IRQ 0c, APIC ID 8, APIC INT 0c
Int: type 0, pol 1, trig 1, bus 6, IRQ 0d, APIC ID 8, APIC INT 0d
Int: type 0, pol 1, trig 1, bus 6, IRQ 0e, APIC ID 8, APIC INT 0e
Int: type 0, pol 3, trig 3, bus 0, IRQ 10, APIC ID 8, APIC INT 3d
Int: type 0, pol 3, trig 3, bus 0, IRQ 29, APIC ID 8, APIC INT 12
Int: type 0, pol 3, trig 3, bus 0, IRQ 30, APIC ID 8, APIC INT 30
Int: type 0, pol 3, trig 3, bus 0, IRQ 3f, APIC ID 8, APIC INT 31
Int: type 0, pol 3, trig 3, bus 2, IRQ 00, APIC ID 8, APIC INT 3b
Int: type 0, pol 3, trig 3, bus 2, IRQ 10, APIC ID 8, APIC INT 32
Int: type 0, pol 3, trig 3, bus 2, IRQ 18, APIC ID 8, APIC INT 28
Int: type 0, pol 3, trig 3, bus 4, IRQ 00, APIC ID 8, APIC INT 3b
Int: type 0, pol 3, trig 3, bus 5, IRQ 00, APIC ID 8, APIC INT 3b
Lint: type 3, pol 1, trig 1, bus 6, IRQ 00, APIC ID ff, APIC LINT 00
Lint: type 1, pol 1, trig 1, bus 0, IRQ 00, APIC ID ff, APIC LINT 01
Processors: 8
mapped APIC to ffffe000 (fee00000)
mapped IOAPIC to ffffd000 (fec00000)
Kernel command line: root=/dev/sda2 console=ttyS0,38400 console=tty0 nosmp mem=8650752K
Initializing CPU#0
Detected 700.070 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1395.91 BogoMIPS
Memory: 8504728k/8650752k available (892k kernel code, 145636k reserved, 338k data, 204k init, 7733248k highmem)
Dentry-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Mount-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Buffer-cache hash table entries: 524288 (order: 9, 2097152 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
Intel machine check reporting enabled on CPU#0.
CPU0: Intel Pentium III (Cascades) stepping 01
per-CPU timeslice cutoff: 2923.17 usecs.
Getting VERSION: 40011
Getting VERSION: 40011
Getting ID: 7000000
Getting ID: 8000000
Getting LVT0: 700
Getting LVT1: 400
SMP mode deactivated, forcing use of dummy APIC emulation.
Setting commenced=1, go go go
PCI: PCI BIOS revision 2.10 entry at 0xfdaca, last bus=5
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Discovered primary peer bus 02 [IRQ]
PCI: Discovered primary peer bus 04 [IRQ]
PCI: Discovered primary peer bus 05 [IRQ]
PCI: Using IRQ router PIIX [8086/7110] at 00:0f.0
querying PCI -> IRQ mapping bus:0, slot:0, pin:0.
PCI->APIC IRQ transform: (B0,I0,P0) -> 59
querying PCI -> IRQ mapping bus:0, slot:4, pin:0.
PCI->APIC IRQ transform: (B0,I4,P0) -> 61
querying PCI -> IRQ mapping bus:0, slot:5, pin:0.
PCI->APIC IRQ transform: (B0,I5,P0) -> 54
querying PCI -> IRQ mapping bus:0, slot:10, pin:0.
PCI->APIC IRQ transform: (B0,I10,P0) -> 58
querying PCI -> IRQ mapping bus:0, slot:10, pin:1.
PCI->APIC IRQ transform: (B0,I10,P1) -> 18
querying PCI -> IRQ mapping bus:0, slot:12, pin:0.
PCI->APIC IRQ transform: (B0,I12,P0) -> 48
querying PCI -> IRQ mapping bus:0, slot:15, pin:3.
PCI->APIC IRQ transform: (B0,I15,P3) -> 49
querying PCI -> IRQ mapping bus:2, slot:0, pin:0.
PCI->APIC IRQ transform: (B2,I0,P0) -> 59
querying PCI -> IRQ mapping bus:2, slot:4, pin:0.
PCI->APIC IRQ transform: (B2,I4,P0) -> 50
querying PCI -> IRQ mapping bus:2, slot:6, pin:0.
PCI->APIC IRQ transform: (B2,I6,P0) -> 40
querying PCI -> IRQ mapping bus:4, slot:0, pin:0.
PCI->APIC IRQ transform: (B4,I0,P0) -> 59
querying PCI -> IRQ mapping bus:5, slot:0, pin:0.
PCI->APIC IRQ transform: (B5,I0,P0) -> 59
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
allocated 32 pages and 32 bhs reserved for the highmem bounces
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: queued sectors max/low 5662773kB/5531701kB, 8192 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 79
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
hda: SAMSUNG CD-ROM SC-148F, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eth0: OEM i82557/i82558 10/100 Ethernet, 00:D0:B7:8E:DB:EB, IRQ 54.
  Board assembly a08922-001, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
SCSI subsystem driver Revision: 1.00
sym53c8xx: at PCI bus 0, device 10, function 0
sym53c8xx: 53c896 detected 
sym53c8xx: at PCI bus 0, device 10, function 1
sym53c8xx: 53c896 detected 
sym53c896-0: rev 0x5 on pci bus 0 device 10 function 0 irq 58
sym53c896-0: ID 7, Fast-40, Parity Checking
sym53c896-0: handling phase mismatch from SCRIPTS.
sym53c896-1: rev 0x5 on pci bus 0 device 10 function 1 irq 18
sym53c896-1: ID 7, Fast-40, Parity Checking
sym53c896-1: handling phase mismatch from SCRIPTS.
scsi0 : sym53c8xx-1.7.3c-20010512
scsi1 : sym53c8xx-1.7.3c-20010512
scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 0, lun 0 Inquiry 00 00 00 ff 00 
sym53c8xx_abort: pid=0 serial_number=1 serial_number_at_timeout=1
SCSI host 0 abort (pid 0) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
sym53c8xx_reset: pid=0 reset_flags=2 serial_number=1 serial_number_at_timeout=1
SCSI host 0 abort (pid 0) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
sym53c8xx_reset: pid=0 reset_flags=2 serial_number=2 serial_number_at_timeout=2
SCSI host 0 abort (pid 0) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
sym53c8xx_reset: pid=0 reset_flags=2 serial_number=3 serial_number_at_timeout=3
SysRq: unRaw Boot Sync Unmount showPc showTasks showMem loglevel0-8 tErm kIll killalL
SysRq: Show Regs

EIP: 0010:[<c01051fc>] CPU: 0 EFLAGS: 00000246
EAX: 00000000 EBX: c01051d0 ECX: 00000001 EDX: c0234000
ESI: c0234000 EDI: c01051d0 EBP: 0008e000 DS: 0018 ES: 0018
CR0: 8005003b CR2: 00000000 CR3: 00101000 CR4: 000006f0
Call Trace: [<c0105262>] [<c0105000>] [<c010505a>] 
SCSI host 0 abort (pid 0) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
sym53c8xx_reset: pid=0 reset_flags=2 serial_number=4 serial_number_at_timeout=4
SCSI host 0 abort (pid 0) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
sym53c8xx_reset: pid=0 reset_flags=2 serial_number=5 serial_number_at_timeout=5
SysRq: Show Memory
Mem-info:
Free pages:      8492416kB (7733248kB HighMem)
( Active: 0, inactive_dirty: 0, inactive_clean: 0, free: 2123104 (638 1276 1914) )
1*4kB 2*8kB 3*16kB 3*32kB 2*64kB 1*128kB 2*256kB 0*512kB 1*1024kB 6*2048kB = 14244kB)
1*4kB 1*8kB 1*16kB 0*32kB 1*64kB 1*128kB 1*256kB 0*512kB 1*1024kB 363*2048kB = 744924kB)
0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 3776*2048kB = 7733248kB)
Swap cache: add 0, delete 0, find 0/0
Free swap:            0kB
2162688 pages of RAM
1933312 pages of HIGHMEM
36506 reserved pages
-13 pages shared
0 pages swap cached
0 pages in page table cache
Buffer memory:        0kB
SCSI host 0 abort (pid 0) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
sym53c8xx_reset: pid=0 reset_flags=2 serial_number=6 serial_number_at_timeout=6
SysRq: unRaw Boot Sync Unmount showPc showTasks showMem loglevel0-8 tErm kIll killalL
SCSI host 0 abort (pid 0) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
sym53c8xx_reset: pid=0 reset_flags=2 serial_number=7 serial_number_at_timeout=7
SysRq: Resetting

*** End log

>Can you please send a couple more ksymoops traces from the
>NMI watchdog trap?

Here is a ksymoops trace from 2.4.7-pre7.  This kernel still crashes,
but the high i/o performance up until the crash is much better than
under 2.4.6.

>Have you tried 2.2.19, 2.4.4 and -ac kernels? 

The -ac kernels haven't booted for me due to the softirq problem, I
believe.  I'll try -ac? when the fix from -pre7 (or wherever) is
incorporated.  I'll continue trying 2.4.4 and 2.2.19.  One thing about
an 8 processor machine with 8GB of ram, I can build a new kernel in
less time than it takes for the machine to reboot...

ksymoops 2.4.1 on i686 2.4.7-pre7.  Options used
     -V (specified)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.7-pre7/ (specified)
     -m /boot/System.map-2.4.7-pre7 (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
NMI Watchdog detected LOCKUP on CPU0, registers:
CPU:    0
EIP:    0010:[<c010b5d7>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00000046
eax: a2a3bb07   ebx: c0235f90   ecx: 06fa48ee   edx: 000000c2
esi: 20000001   edi: 00000000   ebp: 00000000   esp: c0235f40
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c0235000)
Stack: c0221f68 c0108431 00000000 00000000 c0235f90 c0280dc0 c026b800 00000000 
       c0235f88 c0108616 00000000 c0235f90 c0221f68 c01051d0 c0234000 c01051d0 
       00000000 c0221f68 0008e000 c0106d84 c01051d0 00000001 c0234000 c0234000 
Call Trace: [<c0108431>] [<c0108616>] [<c01051d0>] [<c01051d0>] [<c0106d84>] [<c01051d0>] [<c01051d0>] 
       [<c01051fc>] [<c0105262>] [<c0105000>] [<c010505a>] 
Code: 0f b6 c0 c1 e0 08 09 c2 c6 05 64 1f 22 c0 01 b8 9b 2e 00 00 

>>EIP; c010b5d7 <timer_interrupt+43/130>   <=====
Trace; c0108431 <handle_IRQ_event+4d/78>
Trace; c0108616 <do_IRQ+a6/ec>
Trace; c01051d0 <default_idle+0/34>
Trace; c01051d0 <default_idle+0/34>
Trace; c0106d84 <ret_from_intr+0/7>
Trace; c01051d0 <default_idle+0/34>
Trace; c01051d0 <default_idle+0/34>
Trace; c01051fc <default_idle+2c/34>
Trace; c0105262 <cpu_idle+3e/54>
Trace; c0105000 <_stext+0/0>
Trace; c010505a <rest_init+5a/5c>
Code;  c010b5d7 <timer_interrupt+43/130>
00000000 <_EIP>:
Code;  c010b5d7 <timer_interrupt+43/130>   <=====
   0:   0f b6 c0                  movzbl %al,%eax   <=====
Code;  c010b5da <timer_interrupt+46/130>
   3:   c1 e0 08                  shl    $0x8,%eax
Code;  c010b5dd <timer_interrupt+49/130>
   6:   09 c2                     or     %eax,%edx
Code;  c010b5df <timer_interrupt+4b/130>
   8:   c6 05 64 1f 22 c0 01      movb   $0x1,0xc0221f64
Code;  c010b5e6 <timer_interrupt+52/130>
   f:   b8 9b 2e 00 00            mov    $0x2e9b,%eax

