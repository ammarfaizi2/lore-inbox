Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262325AbSI1Uo2>; Sat, 28 Sep 2002 16:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262327AbSI1Uo2>; Sat, 28 Sep 2002 16:44:28 -0400
Received: from triton.neptune.on.ca ([205.233.176.2]:42392 "EHLO
	triton.neptune.on.ca") by vger.kernel.org with ESMTP
	id <S262325AbSI1Uo0>; Sat, 28 Sep 2002 16:44:26 -0400
Date: Sat, 28 Sep 2002 16:49:50 -0400 (EDT)
From: Steve Mickeler <steve@neptune.ca>
X-X-Sender: steve@triton.neptune.on.ca
To: Ben Greear <greearb@candelatech.com>
Cc: Jes Sorensen <jes@trained-monkey.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: can't run two acenics in the same machine??
In-Reply-To: <3D951E46.5070402@candelatech.com>
Message-ID: <Pine.LNX.4.44.0209281644510.12634-100000@triton.neptune.on.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've got 4 3com 3c985 acenic based chips running in a box without any
probs.

00:01.0 Ethernet controller: 3Com Corporation 3c985 1000BaseSX (rev 01)
        Subsystem: Unknown device 9850:0001
        Flags: bus master, 66Mhz, medium devsel, latency 96, IRQ 15
        Memory at febfc000 (32-bit, non-prefetchable) [size=16K]

--
01:02.0 Ethernet controller: 3Com Corporation 3c985 1000BaseSX (rev 01)
        Subsystem: Unknown device 9850:0001
        Flags: bus master, 66Mhz, medium devsel, latency 96, IRQ 4
        Memory at efffc000 (32-bit, non-prefetchable) [size=16K]

01:03.0 Ethernet controller: 3Com Corporation 3c985 1000BaseSX (rev 01)
        Subsystem: Unknown device 9850:0001
        Flags: bus master, 66Mhz, medium devsel, latency 96, IRQ 11
        Memory at efff8000 (32-bit, non-prefetchable) [size=16K]

--
02:04.0 Ethernet controller: 3Com Corporation 3c985 1000BaseSX (rev 01)
        Subsystem: Unknown device 9850:0001
        Flags: bus master, 66Mhz, medium devsel, latency 96, IRQ 4
        Memory at edffc000 (32-bit, non-prefetchable) [size=16K]


I've also got 3 tigon3 nics running in another box without any probs.


01:02.0 Ethernet controller: BROADCOM Corporation NetXtreme BCM5701 Gigabit Ethernet (rev 15)
        Subsystem: 3Com Corporation 3C996-SX 1000BaseSX
        Flags: bus master, 66Mhz, medium devsel, latency 96, IRQ 15
        Memory at efff0000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40] #07 [0000]
        Capabilities: [48] Power Management version 2
--
01:03.0 Ethernet controller: BROADCOM Corporation NetXtreme BCM5701 Gigabit Ethernet (rev 15)
        Subsystem: 3Com Corporation 3C996-SX 1000BaseSX
        Flags: bus master, 66Mhz, medium devsel, latency 96, IRQ 5
        Memory at effe0000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40] #07 [0000]
        Capabilities: [48] Power Management version 2
--
02:04.0 Ethernet controller: BROADCOM Corporation NetXtreme BCM5701 Gigabit Ethernet (rev 15)
        Subsystem: 3Com Corporation 3C996-SX 1000BaseSX
        Flags: bus master, 66Mhz, medium devsel, latency 96, IRQ 15
        Memory at edff0000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40] #07 [0000]
        Capabilities: [48] Power Management version 2


On Fri, 27 Sep 2002, Ben Greear wrote:

> Since the e1000 keeps scribbling over my memory (it appears), I tried
> to tie-break with two NetGear GA 620 nics.
>
> Well, it only finds one!!
>
> In the meantime, I hear that tigonIII is a reasonably good performer.
> Anyone suggest a NIC based on this chipset that is well supported?
>
>  From dmesg:
>
> acenic.c: v0.92 08/05/2002  Jes Sorensen, linux-acenic@SunSITE.dk
>                              http://home.cern.ch/~jes/gige/acenic.html
> eth2: NetGear GA620 Gigabit Ethernet at 0xf4000000, irq 10
>    Tigon II (Rev. 6), Firmware: 12.4.11, MAC: 00:a0:cc:73:37:3a
>    PCI bus width: 64 bits, speed: 66MHz, latency: 64 clks
>    Disabling PCI memory write and invalidate
> eth2: Firmware NOT running!
> eth2: NetGear GA620 Gigabit Ethernet at 0xf4004000, irq 9
>    Tigon II (Rev. 6), Firmware: 12.4.11, MAC: 00:a0:cc:73:35:d6
>    PCI bus width: 64 bits, speed: 66MHz, latency: 64 clks
>    Disabling PCI memory write and invalidate
> eth2: Firmware up and running
>
> from lspci -v:
>
>
> 00:08.0 Ethernet controller: Netgear GA620 (rev 01)
>          Subsystem: Netgear: Unknown device 0001
>          Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>          Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>          Latency: 64 (16000ns min), cache line size 10
>          Interrupt: pin A routed to IRQ 10
>          Region 0: Memory at f4000000 (32-bit, non-prefetchable) [size=16K]
>
> 00:09.0 Ethernet controller: Netgear GA620 (rev 01)
>          Subsystem: Netgear: Unknown device 0001
>          Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>          Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>          Latency: 64 (16000ns min), cache line size 10
>          Interrupt: pin A routed to IRQ 9
>          Region 0: Memory at f4004000 (32-bit, non-prefetchable) [size=16K]
>
>
> Any ideas?
>
> Thanks,
> Ben
>
> --
> Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
> President of Candela Technologies Inc      http://www.candelatech.com
> ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>



[-] Steve Mickeler [ steve@neptune.ca ]

[|] Todays root password is brought to you by /dev/random

[+] 1024D/9AA80CDF = 4103 9E35 2713 D432 924F  3C2E A7B9 A0FE 9AA8 0CDF


