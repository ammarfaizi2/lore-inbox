Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282839AbRLQUbt>; Mon, 17 Dec 2001 15:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282844AbRLQUbl>; Mon, 17 Dec 2001 15:31:41 -0500
Received: from c007-h000.c007.snv.cp.net ([209.228.33.206]:27057 "HELO
	c007.snv.cp.net") by vger.kernel.org with SMTP id <S282839AbRLQUbg>;
	Mon, 17 Dec 2001 15:31:36 -0500
X-Sent: 17 Dec 2001 20:31:29 GMT
Message-ID: <006501c18739$cd504500$930aa8c0@octane>
From: "Eric Balsa" <eric@activebuddy.com>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel Panic 2.4.7
Date: Mon, 17 Dec 2001 12:31:26 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

  This is my first kernel panic posting, so please bear with me! We received
this kernel panic on an Pentium III 850 machine with an L440GX+ motherboard.
This machine has 512MB of memory. This machine is our development database
server which is running kernel revision 2.4.7. Sorry for the old revision,
but uptime has been more important than staying with the newest kernel.
However, that may prove to be the problem! Thanks for any suggestions as to
what the problem may be. Feel free to email me with additional questions.

Here is the ksysoops output:

ksymoops 2.4.0 on i686 2.4.7.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.7/ (default)
     -m /boot/System.map-2.4.7 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod
file?
Unable to handle kernel paging request at virtual address a97ea8d8
c01138df
*pde = 00000000
oops:  0000
CPU:   0
EIP:   0010:[<c01138df>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010087
eax: c176fdd4 ebx: a97ea8d8 ecx: 00000001 edx: 00000003
esi: c176fdac edi: a97ca8d0 ebp: c026deb0 esp: c026de90
ds:  0018     es:  0018     ss:  0018
Process Swapper (pid:0, stackpage=c026d000)
Stack: c176fdd8 00000001 00000086 00000003 c176fdd4 c176fdd4 c176fdac
00000002 d9359348 c013592c d9359300 c18efae0 00000008 00000001 c017a770
d4359300 00000001 c18efae0 c18bbe60 00000046 dbff7e00 c0186b72 c18efae0
00000001
Call Trace: [<c013592c>] [<c017a770>] [<c0186b72>] [<c018f663>] [<c011d9b6>]
[<c018849e>] [<c018f560>] [<c010881e>] [<c0108a24>] [<c0105220>]
[<c0105220>] [<c0106f54>] [<c0105220>] [<c0105220>] [<c010524c>]
[<c01052d2>] [<c0105000>]
Code: 8b 1b 8b 4f 04 8b 01 85 45 ec 74 ec 31 c0 9c 5e fa f0 fe 0d

>>EIP; c01138df <__wake_up+3f/d0>   <=====
Trace; c013592c <end_buffer_io_async+11c/140>
Trace; c017a770 <end_that_request_first+80/d0>
Trace; c0186b72 <ide_end_request+32/70>
Trace; c018f663 <read_intr+103/140>
Trace; c011d9b6 <timer_bh+36/2b0>
Trace; c018849e <ide_intr+11e/190>
Trace; c018f560 <read_intr+0/140>
Trace; c010881e <handle_IRQ_event+5e/90>
Trace; c0108a24 <do_IRQ+a4/f0>
Trace; c0105220 <default_idle+0/40>
Trace; c0105220 <default_idle+0/40>
Trace; c0106f54 <ret_from_intr+0/7>
Trace; c0105220 <default_idle+0/40>
Trace; c0105220 <default_idle+0/40>
Trace; c010524c <default_idle+2c/40>
Trace; c01052d2 <cpu_idle+52/70>
Trace; c0105000 <_stext+0/0>
Code;  c01138df <__wake_up+3f/d0>
00000000 <_EIP>:
Code;  c01138df <__wake_up+3f/d0>   <=====
   0:   8b 1b                     mov    (%ebx),%ebx   <=====
Code;  c01138e1 <__wake_up+41/d0>
   2:   8b 4f 04                  mov    0x4(%edi),%ecx
Code;  c01138e4 <__wake_up+44/d0>
   5:   8b 01                     mov    (%ecx),%eax
Code;  c01138e6 <__wake_up+46/d0>
   7:   85 45 ec                  test   %eax,0xffffffec(%ebp)
Code;  c01138e9 <__wake_up+49/d0>
   a:   74 ec                     je     fffffff8 <_EIP+0xfffffff8> c01138d7
<__wake_up+37/d0>
Code;  c01138eb <__wake_up+4b/d0>
   c:   31 c0                     xor    %eax,%eax
Code;  c01138ed <__wake_up+4d/d0>
   e:   9c                        pushf
Code;  c01138ee <__wake_up+4e/d0>
   f:   5e                        pop    %esi
Code;  c01138ef <__wake_up+4f/d0>
  10:   fa                        cli
Code;  c01138f0 <__wake_up+50/d0>
  11:   f0 fe 0d 00 00 00 00      lock decb 0x0

Kernel panic: Aiee, killing interrupt handler!

2 warnings issued.  Results may not be reliable.

dmesg output:

Linux version 2.4.7 (root@db02) (gcc version 2.96 20000731 (Red Hat Linux
7.1 2.96-81)) #1 SMP Sun Jul 22 20:05:31 PDT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001ffffc00 (ACPI data)
 BIOS-e820: 000000001ffffc00 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
found SMP MP-table at 000f6ab0
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: INTEL    Product ID: Lancewood    APIC at: 0xFEE00000
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
    PSN  present.
    MMX  present.
    FXSR  present.
    XMM  present.
    Bootup CPU
Bus #0 is PCI
Bus #1 is PCI
Bus #2 is PCI
Bus #3 is ISA
I/O APIC #1 Version 17 at 0xFEC00000.
Int: type 3, pol 1, trig 1, bus 3, IRQ 00, APIC ID 1, APIC INT 00
Int: type 0, pol 1, trig 1, bus 3, IRQ 01, APIC ID 1, APIC INT 01
Int: type 0, pol 1, trig 1, bus 3, IRQ 00, APIC ID 1, APIC INT 02
Int: type 0, pol 1, trig 1, bus 3, IRQ 03, APIC ID 1, APIC INT 03
Int: type 0, pol 1, trig 1, bus 3, IRQ 04, APIC ID 1, APIC INT 04
Int: type 0, pol 1, trig 1, bus 3, IRQ 05, APIC ID 1, APIC INT 05
Int: type 0, pol 1, trig 1, bus 3, IRQ 06, APIC ID 1, APIC INT 06
Int: type 0, pol 1, trig 1, bus 3, IRQ 07, APIC ID 1, APIC INT 07
Int: type 0, pol 1, trig 1, bus 3, IRQ 08, APIC ID 1, APIC INT 08
Int: type 0, pol 1, trig 1, bus 3, IRQ 0c, APIC ID 1, APIC INT 0c
Int: type 0, pol 1, trig 1, bus 3, IRQ 0d, APIC ID 1, APIC INT 0d
Int: type 0, pol 1, trig 1, bus 3, IRQ 0e, APIC ID 1, APIC INT 0e
Int: type 0, pol 1, trig 1, bus 3, IRQ 0f, APIC ID 1, APIC INT 0f
Int: type 0, pol 3, trig 3, bus 0, IRQ 30, APIC ID 1, APIC INT 13
Int: type 0, pol 3, trig 3, bus 0, IRQ 30, APIC ID 1, APIC INT 13
Int: type 0, pol 3, trig 3, bus 0, IRQ 38, APIC ID 1, APIC INT 15
Int: type 0, pol 3, trig 3, bus 0, IRQ 4b, APIC ID 1, APIC INT 15
Lint: type 3, pol 1, trig 1, bus 3, IRQ 00, APIC ID ff, APIC LINT 00
Lint: type 1, pol 1, trig 1, bus 0, IRQ 00, APIC ID ff, APIC LINT 01
Processors: 1
mapped APIC to ffffe000 (fee00000)
mapped IOAPIC to ffffd000 (fec00000)
Kernel command line: BOOT_IMAGE=247 ro root=302
BOOT_FILE=/boot/vmlinuz-2.4.7
Initializing CPU#0
Detected 846.330 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1690.82 BogoMIPS
Memory: 513128k/524224k available (1056k kernel code, 10708k reserved, 397k
data, 220k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel Pentium III (Coppermine) stepping 03
per-CPU timeslice cutoff: 731.27 usecs.
Getting VERSION: 40011
Getting VERSION: 40011
Getting ID: 0
Getting ID: f000000
Getting LVT0: 700
Getting LVT1: 400
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
CPU present map: 1
Before bogomips.
Error: only one processor found.
Boot done.
ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 1 ... ok.
Synchronizing Arb IDs.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 1-0, 1-9, 1-10, 1-11, 1-16, 1-17, 1-18, 1-20, 1-22,
1-23 not connected.
..TIMER: vector=31 pin1=2 pin2=0
number of MP IRQ sources: 17.
number of IO-APIC #1 registers: 24.
testing the IO APIC.......................

IO APIC #1......
.... register #00: 01000000
.......    : physical APIC id: 01
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 001 01  0    0    0   0   0    1    1    71
 0d 001 01  0    0    0   0   0    1    1    79
 0e 001 01  0    0    0   0   0    1    1    81
 0f 001 01  0    0    0   0   0    1    1    89
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 001 01  1    1    0   1   0    1    1    91
 14 000 00  1    0    0   0   0    0    0    00
 15 001 01  1    1    0   1   0    1    1    99
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 2
IRQ1 -> 1
IRQ3 -> 3
IRQ4 -> 4
IRQ5 -> 5
IRQ6 -> 6
IRQ7 -> 7
IRQ8 -> 8
IRQ12 -> 12
IRQ13 -> 13
IRQ14 -> 14
IRQ15 -> 15
IRQ19 -> 19
IRQ21 -> 21
.................................... done.
calibrating APIC timer ...
..... CPU clock speed is 846.3445 MHz.
..... host bus clock speed is 99.5699 MHz.
cpu: 0, clocks: 995699, slice: 497849
CPU0<T0:995696,T1:497840,D:7,S:497849,C:995699>
Setting commenced=1, go go go
PCI: PCI BIOS revision 2.10 entry at 0xfdab0, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Discovered primary peer bus ff [IRQ]
PCI: Using IRQ router PIIX [8086/7110] at 00:12.0
querying PCI -> IRQ mapping bus:0, slot:12, pin:0.
PCI->APIC IRQ transform: (B0,I12,P0) -> 19
querying PCI -> IRQ mapping bus:0, slot:12, pin:0.
PCI->APIC IRQ transform: (B0,I12,P0) -> 19
querying PCI -> IRQ mapping bus:0, slot:14, pin:0.
PCI->APIC IRQ transform: (B0,I14,P0) -> 21
querying PCI -> IRQ mapping bus:0, slot:18, pin:3.
PCI->APIC IRQ transform: (B0,I18,P3) -> 21
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: queued sectors max/low 340981kB/209909kB, 1024 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 91
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x2860-0x2867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x2868-0x286f, BIOS settings: hdc:pio, hdd:pio
hda: IC35L060AVER07-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=7476/255/63
Partition check:
 hda: hda1 hda2 hda3
FDC 0 is a National Semiconductor PC87306
loop: loaded (max 8 devices)
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
<saw@saw.sw.com.sg> and others
eth0: Intel Corporation 82557 [Ethernet Pro 100], 00:D0:B7:A8:73:DB, IRQ 21.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.13
        <Adaptec aic7896/97 Ultra2 SCSI adapter>
        aic7896/97: Ultra2 Wide Channel A, SCSI Id=7, 32/255 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.13
        <Adaptec aic7896/97 Ultra2 SCSI adapter>
        aic7896/97: Ultra2 Wide Channel B, SCSI Id=7, 32/255 SCBs

NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 220k freed
Adding Swap: 1028120k swap-space (priority -1)

Regards,
--Eric

----------
Eric Balsa
Activebuddy, Inc
Add SmarterChild to your AIM buddy list



