Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbTDMTSS (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 15:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbTDMTSS (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 15:18:18 -0400
Received: from main.gmane.org ([80.91.224.249]:4546 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261695AbTDMTSG (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Apr 2003 15:18:06 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Nicholas Wourms <nwourms@myrealbox.com>
Subject: Early boot oops with 2.5.67-bk(current) on a dual Athlon-MP [Asus
 A7M266-D] machine
Date: Sun, 13 Apr 2003 15:25:40 -0400
Message-ID: <3E99B9B4.8000304@myrealbox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000706030207000504030303"
X-Complaints-To: usenet@main.gmane.org
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000706030207000504030303
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Attached is the oops (which results in a panic) when I 
attempt to boot the lastest bk current on my machine.  The 
only things I've added to the sources were:
1)Petr's latest matroxfb patch (fb won't work without it)
2)Rusty's kmsgdump (for obvious reasons)
3)A few cosmetic changes to resolve some module symbols and 
to get the kernel to compile with gcc-3.3.

As noted, I'm using a recent gcc-3.3 snapshot with the 
latest build of binutils head.  I've tried the -ac and -mm 
trees as well, with no success.  Each time it gets stuck 
around the same place (when the kernel is starting the 
migration threads).  I've tried booting with acpi=off and 
noapic, but the same things happens.  I attached my config 
file in which I intentionally enabled "the kitchen sink" in 
order to help catch compiler errors.  Any ideas?

Cheers,
Nicholas

--------------000706030207000504030303
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

<4>Linux version 2.5.67 (root@metamorph) (gcc version 3.3 20030403 (prerelease)) #2 SMP Sun Apr 13 14:46:51 EDT 2003
<4>Video mode to be used for restore is f00
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
<4> BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
<4> BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
<4> BIOS-e820: 0000000000100000 - 000000003ffec000 (usable)
<4> BIOS-e820: 000000003ffec000 - 000000003ffef000 (ACPI data)
<4> BIOS-e820: 000000003ffef000 - 000000003ffff000 (reserved)
<4> BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
<4> BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
<4> BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
<4> BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
<5>127MB HIGHMEM available.
<5>896MB LOWMEM available.
<6>found SMP MP-table at 000f7e90
<4>hm, page 000f7000 reserved twice.
<4>hm, page 000f8000 reserved twice.
<4>hm, page 000f7000 reserved twice.
<4>hm, page 000f8000 reserved twice.
<4>On node 0 totalpages: 262124
<4>  DMA zone: 4096 pages, LIFO batch:1
<4>  Normal zone: 225280 pages, LIFO batch:16
<4>  HighMem zone: 32748 pages, LIFO batch:7
<6>ACPI: RSDP (v000 ASUS                       ) @ 0x000f85e0
<6>ACPI: RSDT (v001 ASUS   A7M266-D 12336.12337) @ 0x3ffec000
<6>ACPI: FADT (v001 ASUS   A7M266-D 12336.12337) @ 0x3ffec100
<6>ACPI: BOOT (v001 ASUS   A7M266-D 12336.12337) @ 0x3ffec040
<6>ACPI: MADT (v001 ASUS   A7M266-D 12336.12337) @ 0x3ffec080
<6>ACPI: DSDT (v001   ASUS A7M266-D 00000.04096) @ 0x00000000
<5>ACPI: BIOS passes blacklist
<6>ACPI: Local APIC address 0xfee00000
<6>ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
<4>Processor #0 6:6 APIC version 16
<6>ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
<4>Processor #1 6:6 APIC version 16
<6>ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
<6>ACPI: LAPIC_NMI (acpi_id[0x01] polarity[0x1] trigger[0x1] lint[0x1])
<6>ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
<6>IOAPIC[0]: Assigned apic_id 2
<4>IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-23
<6>ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x0])
<6>ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x3] trigger[0x3])
<4>Enabling APIC mode:  Flat.  Using 1 I/O APICs
<6>Using ACPI (MADT) for SMP configuration information
<4>Building zonelist for node : 0
<4>Kernel command line: root=/dev/hda4
<6>Initializing CPU#0
<4>PID hash table entries: 4096 (order 12: 32768 bytes)
<4>Detected 1680.279 MHz processor.
<4>Console: colour VGA+ 80x25
<4>Calibrating delay loop... 3309.56 BogoMIPS
<6>Memory: 1030920k/1048496k available (3954k kernel code, 16668k reserved, 1675k data, 220k init, 130992k highmem)
<6>Security Scaffold v1.0.0 initialized
<6>Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
<4>Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
<4>Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
<6>-> /dev
<6>-> /dev/console
<6>-> /root
<6>CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
<6>CPU: L2 Cache: 256K (64 bytes/line)
<7>CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
<6>Intel machine check architecture supported.
<6>Intel machine check reporting enabled on CPU#0.
<6>Machine check exception polling timer started.
<6>Enabling fast FPU save and restore... done.
<6>Enabling unmasked SIMD FPU exception support... done.
<6>Checking 'hlt' instruction... OK.
<4>POSIX conformance testing by UNIFIX
<4>CPU0: AMD Athlon(TM) MP 2000+ stepping 02
<4>per-CPU timeslice cutoff: 731.14 usecs.
<4>task migration cache decay timeout: 1 msecs.
<4>enabled ExtINT on CPU#0
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>Booting processor 1/1 eip 3000
<6>Initializing CPU#1
<4>masked ExtINT on CPU#1
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>Calibrating delay loop... 3350.52 BogoMIPS
<6>CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
<6>CPU: L2 Cache: 256K (64 bytes/line)
<7>CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
<6>Intel machine check architecture supported.
<6>Intel machine check reporting enabled on CPU#1.
<4>CPU1: AMD Athlon(TM) MP 2000+ stepping 02
<6>Total of 2 processors activated (6660.09 BogoMIPS).
<4>ENABLING IO-APIC IRQs
<7>init IO_APIC IRQs
<7> IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
<6>..TIMER: vector=0x31 pin1=2 pin2=0
<7>number of MP IRQ sources: 16.
<7>number of IO-APIC #2 registers: 24.
<6>testing the IO APIC.......................
<4>
<7>IO APIC #2......
<7>.... register #00: 02000000
<7>.......    : physical APIC id: 02
<7>.......    : Delivery Type: 0
<7>.......    : LTS          : 0
<7>.... register #01: 00170011
<7>.......     : max redirection entries: 0017
<7>.......     : PRQ implemented: 0
<7>.......     : IO APIC version: 0011
<7>.... register #02: 00000000
<7>.......     : arbitration: 00
<7>.... IRQ redirection table:
<7> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
<7> 00 000 00  1    0    0   0   0    0    0    00
<7> 01 001 01  0    0    0   0   0    1    1    39
<7> 02 001 01  0    0    0   0   0    1    1    31
<7> 03 001 01  0    0    0   0   0    1    1    41
<7> 04 001 01  0    0    0   0   0    1    1    49
<7> 05 001 01  0    0    0   0   0    1    1    51
<7> 06 001 01  0    0    0   0   0    1    1    59
<7> 07 001 01  0    0    0   0   0    1    1    61
<7> 08 001 01  0    0    0   0   0    1    1    69
<7> 09 001 01  1    1    0   1   0    1    1    71
<7> 0a 001 01  0    0    0   0   0    1    1    79
<7> 0b 001 01  0    0    0   0   0    1    1    81
<7> 0c 001 01  0    0    0   0   0    1    1    89
<7> 0d 001 01  0    0    0   0   0    1    1    91
<7> 0e 001 01  0    0    0   0   0    1    1    99
<7> 0f 001 01  0    0    0   0   0    1    1    A1
<7> 10 000 00  1    0    0   0   0    0    0    00
<7> 11 000 00  1    0    0   0   0    0    0    00
<7> 12 000 00  1    0    0   0   0    0    0    00
<7> 13 000 00  1    0    0   0   0    0    0    00
<7> 14 000 00  1    0    0   0   0    0    0    00
<7> 15 000 00  1    0    0   0   0    0    0    00
<7> 16 000 00  1    0    0   0   0    0    0    00
<7> 17 000 00  1    0    0   0   0    0    0    00
<7>IRQ to pin mappings:
<7>IRQ0 -> 0:2
<7>IRQ1 -> 0:1
<7>IRQ3 -> 0:3
<7>IRQ4 -> 0:4
<7>IRQ5 -> 0:5
<7>IRQ6 -> 0:6
<7>IRQ7 -> 0:7
<7>IRQ8 -> 0:8
<7>IRQ9 -> 0:9
<7>IRQ10 -> 0:10
<7>IRQ11 -> 0:11
<7>IRQ12 -> 0:12
<7>IRQ13 -> 0:13
<7>IRQ14 -> 0:14
<7>IRQ15 -> 0:15
<6>.................................... done.
<4>Using local APIC timer interrupts.
<4>calibrating APIC timer ...
<4>..... CPU clock speed is 1680.0031 MHz.
<4>..... host bus clock speed is 268.0805 MHz.
<4>checking TSC synchronization across 2 CPUs: passed.
<4>Starting migration thread for cpu 0
<4>Bringing up 1
<4>CPU 1 IS NOW UP!
<4>Starting migration thread for cpu 1
<1>Unable to handle kernel paging request at virtual address fffffff8
<4> printing eip:
<4>f7df6400
<1>*pde = 00004067
<4>Oops: 0002 [#1]
<4>CPU:    0
<4>EIP:    0060:[<f7df6400>]    Not tainted
<4>EFLAGS: 00010082
<4>EIP is at 0xf7df6400
<4>eax: f000ff48   ebx: 00000000   ecx: 00000003   edx: f000ff54
<4>esi: 00000000   edi: 00000001   ebp: c0681ebc   esp: c0681e9c
<4>ds: 007b   es: 007b   ss: 0068
<4>Process swapper (pid: 0, threadinfo=c0680000 task=c055e800)
<4>Stack: c012a82a f000ff48 00000003 00000000 00000014 c0680000 00000010 00000292 
<4>       c0681ee0 c012a887 00000010 00000003 00000001 00000000 00000000 c0680000 
<4>       c05607e4 c0681ef8 c01400a7 00000246 c0680000 c1a14640 00000000 c0681f04 
<4>Call Trace:
<4> [<c012a82a>] __wake_up_common+0x3a/0x58
<4> [<c012a887>] __wake_up+0x3f/0x68
<4> [<c01400a7>] queue_work+0x87/0x114
<4> [<c011b7ea>] mce_timerfunc+0xa2/0xa4
<4> [<c0138b3b>] run_timer_softirq+0xff/0x1d4
<4> [<c011b748>] mce_timerfunc+0x0/0xa4
<4> [<c0133cbb>] do_softirq+0xcb/0xd0
<4> [<c0122975>] smp_apic_timer_interrupt+0xd9/0x140
<4> [<c010f02c>] default_idle+0x0/0x3c
<4> [<c011246a>] apic_timer_interrupt+0x1a/0x20
<4> [<c010f02c>] default_idle+0x0/0x3c
<4> [<c010f05b>] default_idle+0x2f/0x3c
<4> [<c010f0f9>] cpu_idle+0x51/0x5c
<4> [<c0105000>] _stext+0x0/0x64
<4> [<c0682bf3>] start_kernel+0x1a3/0x1ec
<4> [<c0682688>] unknown_bootoption+0x0/0xf8
<4>
<4>Code: 00 64 df f7 80 a4 e0 f7 e0 e9 5a c0 00 00 00 00 00 00 00 00 
<4> <0>Kernel panic: Fatal exception in interrupt
<0>In interrupt handler - not syncing
<4> <0>Dumping messages in 0 seconds : last chance for Alt-SysRq...
--------------000706030207000504030303
Content-Type: text/plain;
 name="ksymoops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ksymoops.txt"

ksymoops 2.4.8 on i686 2.4.21-pre5-xfs-ac3.  Options used
     -v /usr/src/linux-beta/vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.5.67/ (specified)
     -m /usr/src/linux-beta/System.map (specified)
     -S

No modules in ksyms, skipping objects
<6>ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
<6>ACPI: LAPIC_NMI (acpi_id[0x01] polarity[0x1] trigger[0x1] lint[0x1])
<6>Machine check exception polling timer started.
<4>CPU 1 IS NOW UP!
<1>Unable to handle kernel paging request at virtual address fffffff8
<4>f7df6400
<1>*pde = 00004067
<4>Oops: 0002 [#1]
<4>CPU:    0
<4>EIP:    0060:[<f7df6400>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
<4>EFLAGS: 00010082
<4>eax: f000ff48   ebx: 00000000   ecx: 00000003   edx: f000ff54
<4>esi: 00000000   edi: 00000001   ebp: c0681ebc   esp: c0681e9c
<4>ds: 007b   es: 007b   ss: 0068
<4>Stack: c012a82a f000ff48 00000003 00000000 00000014 c0680000 00000010 00000292 
<4>       c0681ee0 c012a887 00000010 00000003 00000001 00000000 00000000 c0680000 
<4>       c05607e4 c0681ef8 c01400a7 00000246 c0680000 c1a14640 00000000 c0681f04 
<4>Call Trace:
<4> [<c012a82a>] __wake_up_common+0x3a/0x58
<4> [<c012a887>] __wake_up+0x3f/0x68
<4> [<c01400a7>] queue_work+0x87/0x114
<4> [<c011b7ea>] mce_timerfunc+0xa2/0xa4
<4> [<c0138b3b>] run_timer_softirq+0xff/0x1d4
<4> [<c011b748>] mce_timerfunc+0x0/0xa4
<4> [<c0133cbb>] do_softirq+0xcb/0xd0
<4> [<c0122975>] smp_apic_timer_interrupt+0xd9/0x140
<4> [<c010f02c>] default_idle+0x0/0x3c
<4> [<c011246a>] apic_timer_interrupt+0x1a/0x20
<4> [<c010f02c>] default_idle+0x0/0x3c
<4> [<c010f05b>] default_idle+0x2f/0x3c
<4> [<c010f0f9>] cpu_idle+0x51/0x5c
<4> [<c0105000>] _stext+0x0/0x64
<4> [<c0682bf3>] start_kernel+0x1a3/0x1ec
<4> [<c0682688>] unknown_bootoption+0x0/0xf8
<4>Code: 00 64 df f7 80 a4 e0 f7 e0 e9 5a c0 00 00 00 00 00 00 00 00 


>>EIP; f7df6400 <__crc_pnp_device_attach+147b67/2771ce>   <=====

>>eax; f000ff48 <__crc_taskfile_input_data+109a15/4fd437>
>>edx; f000ff54 <__crc_taskfile_input_data+109a21/4fd437>
>>ebp; c0681ebc <init_thread_union+1ebc/2000>
>>esp; c0681e9c <init_thread_union+1e9c/2000>

Trace; c012a82a <__wake_up_common+3a/58>
Trace; c012a887 <__wake_up+3f/68>
Trace; c01400a7 <queue_work+87/114>
Trace; c011b7ea <mce_timerfunc+a2/a4>
Trace; c0138b3b <run_timer_softirq+ff/1d4>
Trace; c011b748 <mce_timerfunc+0/a4>
Trace; c0133cbb <do_softirq+cb/d0>
Trace; c0122975 <smp_apic_timer_interrupt+d9/140>
Trace; c010f02c <default_idle+0/3c>
Trace; c011246a <apic_timer_interrupt+1a/20>
Trace; c010f02c <default_idle+0/3c>
Trace; c010f05b <default_idle+2f/3c>
Trace; c010f0f9 <cpu_idle+51/5c>
Trace; c0105000 <_stext+0/0>
Trace; c0682bf3 <start_kernel+1a3/1ec>
Trace; c0682688 <unknown_bootoption+0/f8>

Code;  f7df6400 <__crc_pnp_device_attach+147b67/2771ce> 00000000 <_EIP>:
Code;  f7df6400 <__crc_pnp_device_attach+147b67/2771ce>    0:   00 64 df f7               add    %ah,0xfffffff7(%edi,%ebx,8)   <=====
Code;  f7df6404 <__crc_pnp_device_attach+147b6b/2771ce>    4:   80 a4 e0 f7 e0 e9 5a      andb   $0xc0,0x5ae9e0f7(%eax,8)
Code;  f7df640b <__crc_pnp_device_attach+147b72/2771ce>    b:   c0 

<4> <0>Kernel panic: Fatal exception in interrupt

--------------000706030207000504030303
Content-Type: application/octet-stream;
 name=".config.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename=".config.bz2"

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
CQfe3kaw
--------------000706030207000504030303--


