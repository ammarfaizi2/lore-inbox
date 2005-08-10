Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965172AbVHJP77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965172AbVHJP77 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 11:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965173AbVHJP77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 11:59:59 -0400
Received: from smtp100.rog.mail.re2.yahoo.com ([206.190.36.78]:40087 "HELO
	smtp100.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S965172AbVHJP76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 11:59:58 -0400
Date: Wed, 10 Aug 2005 11:59:49 -0400
From: Masoud Sharbiani <masouds@masoud.ir>
To: linux-kernel@vger.kernel.org
Subject: Re: Crash on boot when switching between 2.4.32-pre2 and 2.6.13-pre6
Message-ID: <20050810155949.GA3921@masoud.ir>
References: <42FA1A02.6070207@masoud.ir>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42FA1A02.6070207@masoud.ir>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, a bit more info :-) 
It happened with 2.4.32-pre2, cold started; here is the portion of dmesg I captured.
---
Buffer cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU0: Intel Pentium III (Coppermine) stepping 0a
per-CPU timeslice cutoff: 731.72 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 3000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1736.70 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU1: Intel Pentium III (Coppermine) stepping 0a
Total of 2 processors activated (3466.85 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
..changing IO-APIC physical APIC ID to 2 ... ok.
.TIMER: vector=0x31 pin1=2 pin2=0
testing the IO APIC.......................

................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
.... CPU clock speed is 868.6519 MHz.
.... host bus clock speed is 133.6387 MHz.
cpu: 0, clocks: 1336387, slice: 445462
CPU0<T0:1336384,T1:890912,D:10,S:445462,C:1336387>
cpu: 1, clocks: 1336387, slice: 445462
CPU1<T0:1336384,T1:445456,D:4,S:445462,C:1336387>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs
ACPI: Subsystem revision 20040326
ACPI: Interpreter disabled.
PCI: PCI BIOS revision 2.10 entry at 0xfb2c0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Via IRQ fixup
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
PCI->APIC IRQ transform: (B0,I7,P3) -> 7
PCI->APIC IRQ transform: (B0,I7,P3) -> 7
PCI->APIC IRQ transform: (B0,I14,P0) -> 11
PCI->APIC IRQ transform: (B0,I18,P0) -> 5
PCI: Enabling Via external APIC routing
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
BIOS EDD facility v0.11 2004-Jun-21, 1 devices found
Starting kswapd
Journalled Block Device driver loaded
pty: 512 Unix98 ptys configured
<1>Unable to handle Skeerrnielal N UdrrLi vppro ivnterrrsiidoenr 55f.e05reen c(_
RQQppSriiRRtIAAnn_g  Ceii pI:S                                                 I
PN0P0 000nn0abb88e            A

pe =ttyS00 at 0x03f8 (irq = 4) is    1
                                      50A
:    00 0:[<000000(ir]    N is a nted0A
                                       EFLAGSl 00010246
 Driver v1.10f
                ebx: c0106atc   ecx:mer: 0.05   edx: c1rgin: 60 esi: c1b02000  0
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c1b03000)
Stack: c01070a2 00000002 00000000 00000000 00000000 c011f855 00000b1a 00000b1a 
       00000286 c03ac81c 00000001 00000000 00000001 c044cbea 00000246 0000002a 
       000000ff c011facf 00000000 00000400 
Call Trace:    [<c01070a2>] [<c011f855>] [<c011facf>]

Code:  Bad EIP value.
 <0>Kernel panic: Attempted to kill the idle task!
In idle task - not syncing
---


Thanks in advance, 
Masoud


On Wed, Aug 10, 2005 at 11:15:14AM -0400, Masoud Sharbiani wrote:
> Hello,
> I have a dual P3 machine that crashes when I first (cold) start it with 
> 2.6.13-rc6 and then reboot it to use 2.4.32-pre2.
> It boots, and during booting, around the time it is supposed to 
> initalize serial device and software watchdog, it hangs with a message 
> like this: (Note: It is garbled on my serial terminal):
> ----
>  v ((r20t0u1all0 7ad-d0r8e)s ww itt00 0M000N0YY8_
> R TSS rSiHnttiREn_gI Reii  SS                     P
> IAA0L0_PP0000 1I8            E
> P**Ppddee naabb0l0ed0
> 
> 0000
>    ttyS00 at 00
>                3fCPU:    1
>                           ) is a    0010:[<00000018 0x02f8 (itainted
> sEFLAGS: 0
>          010Real Time Clock0000   ebx.10f
> 6foftware Wat0000001  er: 0.05, timer mesiin: 60 se0   edi: c1b02000   
> ebp: ffff
> e000   esp: c1b03fb0
> ds: 0018   es: 0018   ss: 0018
> Process swapper (pid: 0, stackpage=c1b03000)
> Stack: c01070a2 00000002 00000000 00000000 00000000 c011f855 00000b1a 
> 00000b1a
>       00000286 c03ac81c 00000001 00000000 00000001 c044cbea 00000246 
> 0000002a
>       000000ff c011facf 00000000 00000400
> Call Trace:    [<c01070a2>] [<c011f855>] [<c011facf>]
> 
> Code:  Bad EIP value.
> <0>Kernel panic: Attempted to kill the idle task!
> In idle task - not syncing
> ---
> If it matters, I am booting this machine with 'acpi=off' as with ACPI 
> enabled, whenever I reboot the machine, It just turns itself off.
> Cold starting from 2.4 and 2.6 works just fine. The machine runs the ltp 
> test and can compile kernels several times with -j8
> Please let me know if you need more information.
> cheers,
> Masoud
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
