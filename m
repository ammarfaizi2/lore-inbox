Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130397AbRANATY>; Sat, 13 Jan 2001 19:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130150AbRANATO>; Sat, 13 Jan 2001 19:19:14 -0500
Received: from jalon.able.es ([212.97.163.2]:48588 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S131061AbRANASz>;
	Sat, 13 Jan 2001 19:18:55 -0500
Date: Sun, 14 Jan 2001 01:18:46 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Call for testers: ne2k-pci and io apic
Message-ID: <20010114011846.A11015@werewolf.able.es>
In-Reply-To: <200101131237.f0DCb8g15518@flint.arm.linux.org.uk> <3A6071C2.47E8418A@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3A6071C2.47E8418A@colorfullife.com>; from manfred@colorfullife.com on Sat, Jan 13, 2001 at 16:18:26 +0100
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2001.01.13 Manfred Spraul wrote:
> 
> Any volunteers with ne2k-pci cards and other motherboards that include
> an io apic (e.g. all Intel motherboards that use an IO Controller Hub,
> Via Apollo Pro133, Pro133A, KX133)?
> 
> Please:
> * apply the attached patch.
> * compile the kernel for SMP, or at least enable uniprocessor io apic
> support.
> * reboot..
> * flood ping the computer with 2 concurrent flood pings from a second
> computer.
> * wait one minute.
> 

Volunteer. Mine is a Realtek 8029:
00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8029(AS)
        Flags: medium devsel, IRQ 11
        I/O ports at ef40 [size=32]

Board: SuperMicro P6DGU (440GX,PIIX4), 256Mb, 2xPII@400(Deschutes,512Kb).
The only problem is that I just have a cable connection. Is it enough
a 'loopback' connection (ie, ping myself) ? Does it goes at least until
the card and generates interrupts or stops at the kernel soft level ?
Anyways, if a 128K connection can generate enough flood for you, i'll send
you my results. I am going to test it anyways...

dmesg selected info:
I/O APIC #2 Version 17 at 0xFEC00000.
Int: type 3, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 00
Int: type 0, pol 0, trig 0, bus 2, IRQ 01, APIC ID 2, APIC INT 01
Int: type 0, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 02
Int: type 0, pol 0, trig 0, bus 2, IRQ 03, APIC ID 2, APIC INT 03
Int: type 0, pol 0, trig 0, bus 2, IRQ 04, APIC ID 2, APIC INT 04
Int: type 0, pol 0, trig 0, bus 2, IRQ 06, APIC ID 2, APIC INT 06
Int: type 0, pol 0, trig 0, bus 2, IRQ 07, APIC ID 2, APIC INT 07
Int: type 0, pol 1, trig 1, bus 2, IRQ 08, APIC ID 2, APIC INT 08
Int: type 0, pol 0, trig 0, bus 2, IRQ 09, APIC ID 2, APIC INT 09
Int: type 0, pol 0, trig 0, bus 2, IRQ 0c, APIC ID 2, APIC INT 0c
Int: type 0, pol 0, trig 0, bus 2, IRQ 0d, APIC ID 2, APIC INT 0d
Int: type 0, pol 0, trig 0, bus 2, IRQ 0e, APIC ID 2, APIC INT 0e
Int: type 0, pol 0, trig 0, bus 2, IRQ 0f, APIC ID 2, APIC INT 0f
Int: type 0, pol 3, trig 3, bus 2, IRQ 0a, APIC ID 2, APIC INT 10
Int: type 0, pol 3, trig 3, bus 2, IRQ 0b, APIC ID 2, APIC INT 11
Int: type 0, pol 3, trig 3, bus 2, IRQ 0b, APIC ID 2, APIC INT 12
Int: type 0, pol 3, trig 3, bus 2, IRQ 05, APIC ID 2, APIC INT 13
Int: type 2, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 17
Lint: type 3, pol 0, trig 0, bus 0, IRQ 00, APIC ID ff, APIC LINT 00
Lint: type 1, pol 0, trig 0, bus 0, IRQ 00, APIC ID ff, APIC LINT 01
Processors: 2
mapped APIC to ffffe000 (fee00000)
mapped IOAPIC to ffffd000 (fec00000)
..
ENABLING IO-APIC IRQs
..changing IO-APIC physical APIC ID to 2 ... ok.
Synchronizing Arb IDs.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-5, 2-10, 2-11, 2-20, 2-21, 2-22, 2-23 not connected
.
.TIMER: vector=49 pin1=2 pin2=0
activating NMI Watchdog ... done.
testing NMI watchdog ... OK.
number of MP IRQ sources: 18.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
... register #00: 02000000
......    : physical APIC id: 02
... register #01: 00170011
......     : max redirection entries: 0017
......     : IO APIC version: 0011
... register #02: 00000000
......     : arbitration: 00
... IRQ redirection table:
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
 0d 000 00  1    0    0   0   0    0    0    00
 0e 003 03  0    0    0   0   0    1    1    79
 0f 003 03  0    0    0   0   0    1    1    81
 10 003 03  1    1    0   1   0    1    1    89
 11 003 03  1    1    0   1   0    1    1    91
 12 003 03  1    1    0   1   0    1    1    91
 13 003 03  1    1    0   1   0    1    1    99
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 2
IRQ1 -> 1
IRQ3 -> 3
IRQ4 -> 4
IRQ5 -> 19
IRQ6 -> 6
IRQ7 -> 7
IRQ8 -> 8
IRQ9 -> 9
IRQ10 -> 16
IRQ11 -> 17-> 18
IRQ12 -> 12
IRQ13 -> 13
IRQ14 -> 14
IRQ15 -> 15
................................... done.
calibrating APIC timer ...
.... CPU clock speed is 400.9147 MHz.
.... host bus clock speed is 100.2284 MHz.
cpu: 0, clocks: 1002284, slice: 334094
CPU0<T0:1002272,T1:668176,D:2,S:334094,C:1002284>
cpu: 1, clocks: 1002284, slice: 334094
CPU1<T0:1002272,T1:334080,D:4,S:334094,C:1002284>
checking TSC synchronization across CPUs: passed.
Setting commenced=1, go go go
..
Board Vendor: Supermicro Inc..
Board Name: Intel 440BX/440GX.

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.0-ac8 #1 SMP Fri Jan 12 18:02:50 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
