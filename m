Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274951AbRJNJHY>; Sun, 14 Oct 2001 05:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274990AbRJNJHP>; Sun, 14 Oct 2001 05:07:15 -0400
Received: from destructo.gearboxsoftware.com ([12.37.36.2]:23304 "HELO
	gearboxsoftware.com") by vger.kernel.org with SMTP
	id <S274951AbRJNJG6>; Sun, 14 Oct 2001 05:06:58 -0400
From: "Sean Cavanaugh" <seanc@gearboxsoftware.com>
To: "'Martin J. Bligh'" <Martin.Bligh@us.ibm.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: P4 SMP load balancing
Date: Sun, 14 Oct 2001 04:07:30 -0500
Message-ID: <000101c1548f$a6f6c050$150a10ac@gearboxsoftware.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
Importance: Normal
In-Reply-To: <2157008025.1002884387@mbligh.des.sequent.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Martin J. Bligh [mailto:Martin.Bligh@us.ibm.com] 
> Sent: Friday, October 12, 2001 1:00 PM
> To: Sean Cavanaugh
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: P4 SMP load balancing
> 
> 
> Which isn't perfectly balanced, but it looks a damned sight better
than yours does ;-) Do you have something in the log that looks like
this?
> 
> Oct 11 15:35:04 elm3b76 kernel: IO APIC #13...... 
> Oct 11 15:35:04 elm3b76 kernel: .... register #00: 0D000000 
> Oct 11 15:35:04 elm3b76 kernel: .......    : physical APIC id: 0D 
> Oct 11 15:35:04 elm3b76 kernel: .... register #01: 00170011 
> Oct 11 15:35:04 elm3b76 kernel: .......     : max redirection entries:
0017 
> Oct 11 15:35:04 elm3b76 kernel: .......     : IO APIC version: 0011 
> Oct 11 15:35:04 elm3b76 kernel: .... register #02: 00000000 
> Oct 11 15:35:04 elm3b76 kernel: .......     : arbitration: 00 
> Oct 11 15:35:04 elm3b76 kernel: .... IRQ redirection table: 
> Oct 11 15:35:04 elm3b76 kernel:  NR Log Phy Mask Trig IRR Pol Stat
Dest Deli Vect:    
> Oct 11 15:35:04 elm3b76 kernel:  00 000 00  1    0    0   0   0    0
0    00 
> Oct 11 15:35:05 elm3b76 kernel:  01 00F 0F  0    0    0   0   0    0
1    39 

<snip>



Relevent:  APIC info from dmesg (with some lead-in/lead-out):


Calibrating delay loop... 3368.55 BogoMIPS
CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU1: Intel(R) Xeon(TM) CPU 1700MHz stepping 0a
Total of 2 processors activated (6723.99 BogoMIPS).
ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-5, 2-10, 2-11, 2-12, 2-17, 2-20, 2-21, 2-22
not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 18.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
 WARNING: unexpected IO-APIC, please mail
          to linux-smp@vger.kernel.org
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
 0c 000 00  1    0    0   0   0    0    0    00
 0d 003 03  0    0    0   0   0    1    1    71
 0e 003 03  0    0    0   0   0    1    1    79
 0f 003 03  0    0    0   0   0    1    1    81
 10 003 03  1    1    0   1   0    1    1    89
 11 000 00  1    0    0   0   0    0    0    00
 12 003 03  1    1    0   1   0    1    1    91
 13 003 03  1    1    0   1   0    1    1    99
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 003 03  1    1    0   1   0    1    1    A1
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ23 -> 0:23
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1685.2574 MHz.
..... host bus clock speed is 99.1326 MHz.
cpu: 0, clocks: 991326, slice: 330442
CPU0<T0:991312,T1:660864,D:6,S:330442,C:991326>
cpu: 1, clocks: 991326, slice: 330442
CPU1<T0:991312,T1:330416,D:12,S:330442,C:991326>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xfb3e0, last bus=4
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/2440] at 00:1f.0
PCI->APIC IRQ transform: (B0,I31,P3) -> 19
PCI->APIC IRQ transform: (B0,I31,P1) -> 19
PCI->APIC IRQ transform: (B0,I31,P2) -> 23
PCI->APIC IRQ transform: (B3,I4,P0) -> 18
PCI->APIC IRQ transform: (B3,I4,P1) -> 18
PCI->APIC IRQ transform: (B4,I4,P0) -> 16
PCI->APIC IRQ transform: (B4,I7,P0) -> 16
isapnp: Scanning for PnP cards...



	- Sean

