Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282190AbRKWRHF>; Fri, 23 Nov 2001 12:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282195AbRKWRGu>; Fri, 23 Nov 2001 12:06:50 -0500
Received: from mail.gmd.de ([129.26.8.90]:6413 "EHLO mail.gmd.de")
	by vger.kernel.org with ESMTP id <S282192AbRKWRGh>;
	Fri, 23 Nov 2001 12:06:37 -0500
Message-ID: <3BFE818B.3050408@gmd.de>
Date: Fri, 23 Nov 2001 18:04:11 +0100
From: Pavel Frolov <pavel.frolov@gmd.de>
Reply-To: pavel.frolov@gmd.de
Organization: GMD
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, ru
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.15 oops (2.4.14 freeze continuation)
Content-Type: multipart/mixed;
 boundary="------------090801070304020806070609"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090801070304020806070609
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

Hi, all!
    Here is oops, it decoding and kernel config in attachment.
   This occur when i enable HIGHMEMORY = 4G in kernel configuration.
    After the booting it working some time when I dont run syslog and 
klog deamons.
    And after random time system freeze.
    Computer comfiguration:
       Dual Pentium4 Xeon 1.7 GHz
       2G RAM
       MB chipset i860

Can anyone help?
 
                             pasha.


--------------090801070304020806070609
Content-Type: text/plain;
 name="decoded"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="decoded"

ksymoops 2.4.3 on i686 2.4.15-greased-turkey.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.15-greased-turkey/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

1150MB HIGHMEM available.
 WARNING: unexpected IO-APIC, please mail
cpu: 0, clocks: 997628, slice: 332542
cpu: 1, clocks: 997628, slice: 332542
Unable to handle kernel NULL pointer dereference at virtual address 00000800
Unable to handle kernel NULL pointer dereference at virtual address 00000400
c018dd5e
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c018dd5e>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 00000400   ebx: f77f7800   ecx: 00000100   edx: 00000800
esi: f77f7800   edi: 00000800   ebp: c2edffc0   esp: f77fbf40
ds: 0018   es: 0018   ss: 0018
c018dd5e
*pde = 00000000
Process loop1 (pid: 29, stackpage=f77fb000)
Stack: 00000800 00000400 00000800 c018dfa5 f7bbb11c 00000001 00000800 f77f7800 
       00000400 00000002 00000008 f7bbb11c f7bd9c00 f7bbb11c 00000c00 00000c00 
       f7bbb228 00000002 00000400 00000000 f77f7800 c02233c0 f7a08930 f7ab5e80 
Call Trace: [<c018dfa5>] [<c018e265>] [<c018e829>] [<c0105594>] 
Code: f3 a5 a8 02 74 02 66 a5 a8 01 74 01 a4 31 c0 5b 5e 5f c3 8d 

>>EIP; c018dd5e <transfer_none+2e/44>   <=====
Trace; c018dfa4 <lo_send+124/1f0>
Trace; c018e264 <do_bh_filebacked+58/94>
Trace; c018e828 <loop_thread+100/224>
Trace; c0105594 <kernel_thread+28/38>
Code;  c018dd5e <transfer_none+2e/44>
00000000 <_EIP>:
Code;  c018dd5e <transfer_none+2e/44>   <=====
   0:   f3 a5                     repz movsl %ds:(%esi),%es:(%edi)   <=====
Code;  c018dd60 <transfer_none+30/44>
   2:   a8 02                     test   $0x2,%al
Code;  c018dd62 <transfer_none+32/44>
   4:   74 02                     je     8 <_EIP+0x8> c018dd66 <transfer_none+36/44>
Code;  c018dd64 <transfer_none+34/44>
   6:   66 a5                     movsw  %ds:(%esi),%es:(%edi)
Code;  c018dd66 <transfer_none+36/44>
   8:   a8 01                     test   $0x1,%al
Code;  c018dd68 <transfer_none+38/44>
   a:   74 01                     je     d <_EIP+0xd> c018dd6a <transfer_none+3a/44>
Code;  c018dd6a <transfer_none+3a/44>
   c:   a4                        movsb  %ds:(%esi),%es:(%edi)
Code;  c018dd6a <transfer_none+3a/44>
   d:   31 c0                     xor    %eax,%eax
Code;  c018dd6c <transfer_none+3c/44>
   f:   5b                        pop    %ebx
Code;  c018dd6e <transfer_none+3e/44>
  10:   5e                        pop    %esi
Code;  c018dd6e <transfer_none+3e/44>
  11:   5f                        pop    %edi
Code;  c018dd70 <transfer_none+40/44>
  12:   c3                        ret    
Code;  c018dd70 <transfer_none+40/44>
  13:   8d 00                     lea    (%eax),%eax

 Oops: 0002
Unable to handle kernel NULL pointer dereference at virtual address 00000800
c018dd5e
*pde = 00000000
CPU:    1
EIP:    0010:[<c018dd5e>]    Not tainted
EFLAGS: 00010206
eax: 00000400   ebx: f77f0400   ecx: 00000100   edx: 00000400
esi: f77f0400   edi: 00000400   ebp: c2edc400   esp: f77f5f40
ds: 0018   es: 0018   ss: 0018
Process loop2 (pid: 34, stackpage=f77f5000)
Stack: 00000400 00000400 00000400 c018dfa5 f7bbb238 00000001 00000400 f77f0400 
       00000400 00000001 00000008 f7bbb238 f7bd9780 f7bbb238 00000800 00000800 
       f7bbb344 00000001 00000400 00000000 f77f0400 c02233c0 f7a08530 f7ae2900 
Call Trace: [<c018dfa5>] [<c018e265>] [<c018e829>] [<c0105594>] 
Code: f3 a5 a8 02 74 02 66 a5 a8 01 74 01 a4 31 c0 5b 5e 5f c3 8d 

>>EIP; c018dd5e <transfer_none+2e/44>   <=====
Trace; c018dfa4 <lo_send+124/1f0>
Trace; c018e264 <do_bh_filebacked+58/94>
Trace; c018e828 <loop_thread+100/224>
Trace; c0105594 <kernel_thread+28/38>
Code;  c018dd5e <transfer_none+2e/44>
00000000 <_EIP>:
Code;  c018dd5e <transfer_none+2e/44>   <=====
   0:   f3 a5                     repz movsl %ds:(%esi),%es:(%edi)   <=====
Code;  c018dd60 <transfer_none+30/44>
   2:   a8 02                     test   $0x2,%al
Code;  c018dd62 <transfer_none+32/44>
   4:   74 02                     je     8 <_EIP+0x8> c018dd66 <transfer_none+36/44>
Code;  c018dd64 <transfer_none+34/44>
   6:   66 a5                     movsw  %ds:(%esi),%es:(%edi)
Code;  c018dd66 <transfer_none+36/44>
   8:   a8 01                     test   $0x1,%al
Code;  c018dd68 <transfer_none+38/44>
   a:   74 01                     je     d <_EIP+0xd> c018dd6a <transfer_none+3a/44>
Code;  c018dd6a <transfer_none+3a/44>
   c:   a4                        movsb  %ds:(%esi),%es:(%edi)
Code;  c018dd6a <transfer_none+3a/44>
   d:   31 c0                     xor    %eax,%eax
Code;  c018dd6c <transfer_none+3c/44>
   f:   5b                        pop    %ebx
Code;  c018dd6e <transfer_none+3e/44>
  10:   5e                        pop    %esi
Code;  c018dd6e <transfer_none+3e/44>
  11:   5f                        pop    %edi
Code;  c018dd70 <transfer_none+40/44>
  12:   c3                        ret    
Code;  c018dd70 <transfer_none+40/44>
  13:   8d 00                     lea    (%eax),%eax

 Oops: 0002
CPU:    0
EIP:    0010:[<c018dd5e>]    Not tainted
EFLAGS: 00010206
eax: 00000400   ebx: f7a01800   ecx: 00000100   edx: 00000800
esi: f7a01800   edi: 00000800   ebp: c2ff1700   esp: f7a07f40
ds: 0018   es: 0018   ss: 0018
Process loop0 (pid: 23, stackpage=f7a07000)
Stack: 00000800 00000400 00000800 c018dfa5 f7bbb000 00000001 00000800 f7a01800 
       00000400 00000002 00000008 f7bbb000 f7a00f00 f7bbb000 00000c00 00000c00 
       f7bbb10c 00000002 00000400 00000000 f7a01800 c02233c0 f7a3ebb0 f7ae2b00 
Call Trace: [<c018dfa5>] [<c018e265>] [<c018e829>] [<c0105594>] 
Code: f3 a5 a8 02 74 02 66 a5 a8 01 74 01 a4 31 c0 5b 5e 5f c3 8d 

>>EIP; c018dd5e <transfer_none+2e/44>   <=====
Trace; c018dfa4 <lo_send+124/1f0>
Trace; c018e264 <do_bh_filebacked+58/94>
Trace; c018e828 <loop_thread+100/224>
Trace; c0105594 <kernel_thread+28/38>
Code;  c018dd5e <transfer_none+2e/44>
00000000 <_EIP>:
Code;  c018dd5e <transfer_none+2e/44>   <=====
   0:   f3 a5                     repz movsl %ds:(%esi),%es:(%edi)   <=====
Code;  c018dd60 <transfer_none+30/44>
   2:   a8 02                     test   $0x2,%al
Code;  c018dd62 <transfer_none+32/44>
   4:   74 02                     je     8 <_EIP+0x8> c018dd66 <transfer_none+36/44>
Code;  c018dd64 <transfer_none+34/44>
   6:   66 a5                     movsw  %ds:(%esi),%es:(%edi)
Code;  c018dd66 <transfer_none+36/44>
   8:   a8 01                     test   $0x1,%al
Code;  c018dd68 <transfer_none+38/44>
   a:   74 01                     je     d <_EIP+0xd> c018dd6a <transfer_none+3a/44>
Code;  c018dd6a <transfer_none+3a/44>
   c:   a4                        movsb  %ds:(%esi),%es:(%edi)
Code;  c018dd6a <transfer_none+3a/44>
   d:   31 c0                     xor    %eax,%eax
Code;  c018dd6c <transfer_none+3c/44>
   f:   5b                        pop    %ebx
Code;  c018dd6e <transfer_none+3e/44>
  10:   5e                        pop    %esi
Code;  c018dd6e <transfer_none+3e/44>
  11:   5f                        pop    %edi
Code;  c018dd70 <transfer_none+40/44>
  12:   c3                        ret    
Code;  c018dd70 <transfer_none+40/44>
  13:   8d 00                     lea    (%eax),%eax


1 warning issued.  Results may not be reliable.

--------------090801070304020806070609
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

Linux version 2.4.15-greased-turkey (root@pc-3) (gcc version 2.95.3 20010315 (release)) #1 SMP Fri Nov 23 17:06:00 CET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009ec00 (usable)
 BIOS-e820: 000000000009ec00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ea000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fef0000 (usable)
 BIOS-e820: 000000007fef0000 - 000000007feff000 (ACPI data)
 BIOS-e820: 000000007feff000 - 000000007ff00000 (ACPI NVS)
 BIOS-e820: 000000007ff80000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
1150MB HIGHMEM available.
found SMP MP-table at 000f6c20
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
On node 0 totalpages: 524016
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 294640 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID:   Product ID: HP_WOMBAT  APIC at: 0xFEE00000
Processor #0 Unknown CPU [15:1] APIC version 20
Processor #6 Unknown CPU [15:1] APIC version 20
I/O APIC #1 Version 32 at 0xFEC00000.
I/O APIC #2 Version 32 at 0xFEC80000.
Processors: 2
Kernel command line: nfsroot=192.168.77.1:/cluster, BOOT_IMAGE=vmlinuz-P4 ip=192.168.77.3:192.168.77.1:192.168.77.1:255.255.255.0 
Initializing CPU#0
Detected 1695.876 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3381.65 BogoMIPS
Memory: 2060916k/2096064k available (944k kernel code, 34756k reserved, 291k data, 228k init, 1178560k highmem)
Dentry-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Mount-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 131072 (order: 7, 524288 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 256K
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU0: Intel(R) Xeon(TM) CPU 1.70GHz stepping 02
per-CPU timeslice cutoff: 731.74 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/6 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3381.65 BogoMIPS
CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 256K
Intel machine check reporting enabled on CPU#1.
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU1: Intel(R) Xeon(TM) CPU 1.70GHz stepping 02
Total of 2 processors activated (6763.31 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 1 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 1 ... ok.
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 1-0, 1-5, 1-10, 1-11, 1-18, 1-20, 1-22, 2-0, 2-1, 2-2, 2-3, 2-4, 2-5, 2-6, 2-7, 2-8, 2-9, 2-10, 2-11, 2-12, 2-13, 2-14, 2-15, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 21.
number of IO-APIC #1 registers: 24.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #1......
.... register #00: 01008000
.......    : physical APIC id: 01
 WARNING: unexpected IO-APIC, please mail
          to linux-smp@vger.kernel.org
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 000 00  1    0    0   0   0    0    0    00
 06 003 03  0    0    0   0   0    1    1    51
 07 003 03  0    0    0   0   0    1    1    59
 08 003 03  0    0    0   0   0    1    1    61
 09 003 03  0    0    0   0   0    1    1    69
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 003 03  0    0    0   0   0    1    1    71
 0d 003 03  0    0    0   0   0    1    1    79
 0e 003 03  0    0    0   0   0    1    1    81
 0f 003 03  0    0    0   0   0    1    1    89
 10 003 03  1    1    0   1   0    1    1    91
 11 003 03  1    1    0   1   0    1    1    99
 12 000 00  1    0    0   0   0    0    0    00
 13 003 03  1    1    0   1   0    1    1    A1
 14 000 00  1    0    0   0   0    0    0    00
 15 003 03  1    1    0   1   0    1    1    A9
 16 000 00  1    0    0   0   0    0    0    00
 17 003 03  1    1    0   1   0    1    1    B1

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 02000000
.......     : arbitration: 02
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ19 -> 0:19
IRQ21 -> 0:21
IRQ23 -> 0:23
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1695.9728 MHz.
..... host bus clock speed is 99.7628 MHz.
cpu: 0, clocks: 997628, slice: 332542
CPU0<T0:997616,T1:665072,D:2,S:332542,C:997628>
cpu: 1, clocks: 997628, slice: 332542
CPU1<T0:997616,T1:332528,D:4,S:332542,C:997628>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xfd91b, last bus=4
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/2440] at 00:1f.0
PCI->APIC IRQ transform: (B0,I31,P3) -> 19
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
PCI->APIC IRQ transform: (B3,I8,P0) -> 23
PCI->APIC IRQ transform: (B3,I8,P1) -> 19
PCI->APIC IRQ transform: (B4,I13,P0) -> 21
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Non-volatile memory driver v1.1
block: 128 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev f9
PIIX4: chipset revision 4
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x10e0-0x10e7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x10e8-0x10ef, BIOS settings: hdc:DMA, hdd:pio
hdc: HITACHI DVD-ROM GD-8000, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
loop: loaded (max 8 devices)
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eth0: OEM i82557/i82558 10/100 Ethernet, 00:E0:81:00:2C:74, IRQ 21.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
    Secondary interface chip i82555.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x3258698e).
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
IP-Config: Complete:
      device=eth0, addr=192.168.77.3, mask=255.255.255.0, gw=192.168.77.1,
     host=192.168.77.3, domain=, nis-domain=(none),
     bootserver=192.168.77.1, rootserver=192.168.77.1, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 192.168.77.1
Looking up port of RPC 100005/1 on 192.168.77.1
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 228k freed
Unable to handle kernel NULL pointer dereference at virtual address 00000800
Unable to handle kernel NULL pointer dereference at virtual address 00000400
 printing eip:
c018dd5e
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c018dd5e>]    Not tainted
EFLAGS: 00010206
eax: 00000400   ebx: f77f7800   ecx: 00000100   edx: 00000800
esi: f77f7800   edi: 00000800   ebp: c2edffc0   esp: f77fbf40
ds: 0018   es: 0018   ss: 0018
 printing eip:
c018dd5e
*pde = 00000000
Process loop1 (pid: 29, stackpage=f77fb000)
Stack: 00000800 00000400 00000800 c018dfa5 f7bbb11c 00000001 00000800 f77f7800 
       00000400 00000002 00000008 f7bbb11c f7bd9c00 f7bbb11c 00000c00 00000c00 
       f7bbb228 00000002 00000400 00000000 f77f7800 c02233c0 f7a08930 f7ab5e80 
Call Trace: [<c018dfa5>] [<c018e265>] [<c018e829>] [<c0105594>] 

Code: f3 a5 a8 02 74 02 66 a5 a8 01 74 01 a4 31 c0 5b 5e 5f c3 8d 
 Oops: 0002
Unable to handle kernel NULL pointer dereference at virtual address 00000800
 printing eip:
c018dd5e
*pde = 00000000
CPU:    1
EIP:    0010:[<c018dd5e>]    Not tainted
EFLAGS: 00010206
eax: 00000400   ebx: f77f0400   ecx: 00000100   edx: 00000400
esi: f77f0400   edi: 00000400   ebp: c2edc400   esp: f77f5f40
ds: 0018   es: 0018   ss: 0018
Process loop2 (pid: 34, stackpage=f77f5000)
Stack: 00000400 00000400 00000400 c018dfa5 f7bbb238 00000001 00000400 f77f0400 
       00000400 00000001 00000008 f7bbb238 f7bd9780 f7bbb238 00000800 00000800 
       f7bbb344 00000001 00000400 00000000 f77f0400 c02233c0 f7a08530 f7ae2900 
Call Trace: [<c018dfa5>] [<c018e265>] [<c018e829>] [<c0105594>] 

Code: f3 a5 a8 02 74 02 66 a5 a8 01 74 01 a4 31 c0 5b 5e 5f c3 8d 
 Oops: 0002
CPU:    0
EIP:    0010:[<c018dd5e>]    Not tainted
EFLAGS: 00010206
eax: 00000400   ebx: f7a01800   ecx: 00000100   edx: 00000800
esi: f7a01800   edi: 00000800   ebp: c2ff1700   esp: f7a07f40
ds: 0018   es: 0018   ss: 0018
Process loop0 (pid: 23, stackpage=f7a07000)
Stack: 00000800 00000400 00000800 c018dfa5 f7bbb000 00000001 00000800 f7a01800 
       00000400 00000002 00000008 f7bbb000 f7a00f00 f7bbb000 00000c00 00000c00 
       f7bbb10c 00000002 00000400 00000000 f7a01800 c02233c0 f7a3ebb0 f7ae2b00 
Call Trace: [<c018dfa5>] [<c018e265>] [<c018e829>] [<c0105594>] 

Code: f3 a5 a8 02 74 02 66 a5 a8 01 74 01 a4 31 c0 5b 5e 5f c3 8d 
 

--------------090801070304020806070609
Content-Type: text/plain;
 name=".config"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename=".config"

#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
CONFIG_MPENTIUM4=y
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_SMP=y
# CONFIG_MULTIQUAD is not set
CONFIG_HAVE_DEC_LOCK=y

#
# General setup
#
CONFIG_NET=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set
# CONFIG_HOTPLUG_PCI is not set
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
# CONFIG_PM is not set
# CONFIG_ACPI is not set
# CONFIG_APM is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play configuration
#
# CONFIG_PNP is not set
# CONFIG_ISAPNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_BLK_DEV_INITRD is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK is not set
# CONFIG_NETFILTER is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_INET_ECN is not set
CONFIG_SYN_COOKIES=y
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=m
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
# CONFIG_BLK_DEV_IDECS is not set
# CONFIG_BLK_DEV_IDECD is not set
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_IDEPCI_SHARE_IRQ is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_AEC62XX_TUNING is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_PDC202XX_FORCE is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set

#
# SCSI support
#
CONFIG_SCSI=m
CONFIG_BLK_DEV_SD=m
CONFIG_SD_EXTRA_DEVS=40
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set
# CONFIG_SCSI_DEBUG_QUEUES is not set
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_NCR53C8XX is not set
CONFIG_SCSI_SYM53C8XX=m
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=4
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
CONFIG_SCSI_NCR53C8XX_SYNC=20
# CONFIG_SCSI_NCR53C8XX_PROFILE is not set
# CONFIG_SCSI_NCR53C8XX_IOMAPPED is not set
# CONFIG_SCSI_NCR53C8XX_PQS_PDS is not set
# CONFIG_SCSI_NCR53C8XX_SYMBIOS_COMPAT is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_DEBUG is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_SUNLANCE is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNLANCE is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_CS89x0 is not set
# CONFIG_TULIP is not set
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
CONFIG_EEPRO100=y
# CONFIG_LNE390 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_RHINE_MMIO is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_MYRI_SBUS is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
# CONFIG_INPUT is not set
# CONFIG_INPUT_KEYBDEV is not set
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
# CONFIG_SERIAL_CONSOLE is not set
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set

#
# Joysticks
#
# CONFIG_INPUT_GAMEPORT is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
CONFIG_INTEL_RNG=y
CONFIG_NVRAM=y
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_MWAVE is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y
# CONFIG_REISERFS_FS is not set
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
# CONFIG_JBD_DEBUG is not set
# CONFIG_FAT_FS is not set
# CONFIG_MSDOS_FS is not set
# CONFIG_UMSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=y
# CONFIG_RAMFS is not set
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_MINIX_FS=m
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=m
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_ROOT_NFS=y
# CONFIG_NFSD is not set
# CONFIG_NFSD_V3 is not set
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
CONFIG_ZISOFS_FS=m
CONFIG_ZLIB_FS_INFLATE=m

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_SMB_NLS is not set
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VIDEO_SELECT is not set
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB is not set
# CONFIG_USB_UHCI is not set
# CONFIG_USB_UHCI_ALT is not set
# CONFIG_USB_OHCI is not set
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH is not set
# CONFIG_USB_STORAGE is not set
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set
# CONFIG_USB_SERIAL_GENERIC is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XA is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XB is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19W is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_RIO500 is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set

--------------090801070304020806070609--

