Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287798AbSBZN5z>; Tue, 26 Feb 2002 08:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287596AbSBZN5p>; Tue, 26 Feb 2002 08:57:45 -0500
Received: from brev.stud.ntnu.no ([129.241.56.70]:15772 "EHLO
	brev.stud.ntnu.no") by vger.kernel.org with ESMTP
	id <S287798AbSBZN5c>; Tue, 26 Feb 2002 08:57:32 -0500
Date: Tue, 26 Feb 2002 14:57:30 +0100
From: =?iso-8859-1?Q?Thomas_Lang=E5s?= <tlan@stud.ntnu.no>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com,
        linux-net@vger.kernel.org
Subject: Re: [BETA] First test release of Tigon3 driver
Message-ID: <20020226145730.A20268@stud.ntnu.no>
Reply-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020225.165914.123908101.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020225.165914.123908101.davem@redhat.com>; from davem@redhat.com on Mon, Feb 25, 2002 at 04:59:14PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller:
> Gigabit and fibre are the big areas where our testing has been
> lacking.  We have also not done any tuning of the driver at all,
> although we do consider the driver feature complete.

I've tested the driver from broadcom (yeah, yeah, the sucky driver :) and
now I've tested yours, and this is the result (from dmesg):

tg3.c:v0.90 (Feb 25, 2002)
tg3: Problem fetching invariants of chip, aborting.


This is lspci -vvvxx:
01:08.0 Ethernet controller: BROADCOM Corporation BCM5700 1000BaseTX (rev 12)
        Subsystem: Dell Computer Corporation: Unknown device 00d1
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 17
        Region 0: Memory at feb00000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40] PCI-X non-bridge device.
                Command: DPERE- ERO+ RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-      Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
                Address: 9b8dc9bb84b8f3a8  Data: bed9
00: e4 14 44 16 02 01 b0 02 12 00 00 02 08 20 00 00
10: 04 00 b0 fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 d1 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 01 40 00


If you need any more info, I'll be happy to provide. 

-- 
Thomas
