Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130129AbRCPTJU>; Fri, 16 Mar 2001 14:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130216AbRCPTJK>; Fri, 16 Mar 2001 14:09:10 -0500
Received: from [216.184.166.130] ([216.184.166.130]:55160 "EHLO
	scsoftware.sc-software.com") by vger.kernel.org with ESMTP
	id <S130129AbRCPTJE>; Fri, 16 Mar 2001 14:09:04 -0500
Date: Fri, 16 Mar 2001 11:03:40 +0000 (   )
From: John Heil <kerndev@sc-software.com>
Reply-To: John Heil <kerndev@sc-software.com>
To: linux-kernel@vger.kernel.org
Subject: IDE UDMA on a CMD-648 Chip
Message-ID: <Pine.LNX.3.95.1010315113407.21451A-100000@scsoftware.sc-software.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've acquired a UDMA66 capable IDE card with a CMD-648 chip,
which is supposed to provide me with ide2 and ide3.

ide2 is empty and ide3 has a writeable cdrom and an IDE zip
drive on it.

At boot up, the card's bios scan recognizes the cdrom and zip
as master and slave on its secondary ide i/f, which is correct.

However, it indicates that since it... 
'Can't find a UDMA66 capable device' 
it is 
'Disabling the UDMA66 bios'.

I've done the usual append for ide3, in lilo.conf but w/o benefit.

Kernel is currently 2.2.16,
The mobo is an Asus A7V133 and the CPU is an 1.1 Athlon
South bridge is a via 686b which runs fine at UDMA100 on a 
pair of Maxtors on IDE-0.  

I'll be upgrading this machine to 2.4.n-whatever in about 3 wks but...
...I'd like to get the 2 devices operational on this or 
some other 2.2.x, before that, if I can.

I can't find the chip's datasheet. CMD only gives it to direct customers.
I do have the datasheet for the CMD-646U, a prior UDMA supporting chip.

I take this to be a bug in the on-card Bios.

I am hoping to circumvent the bios. I assume it will involve some
measure of IDE initialization  which  I don't mind coding if 
it does not exist yet.


So has anyone encountered this chip yet and 
are there any existing solutions or suggestions.


Thanx much


The CMD-648 chip's vital statistics follow...

root@scsoftware50:~# lspci -vvxxxs 00:0c.0
00:0c.0 RAID bus controller: CMD Technology Inc PCI0648 (rev 01)
        Subsystem: CMD Technology Inc PCI0648
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 1000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 9400
        Region 1: I/O ports at 9000
        Region 2: I/O ports at 8800
        Region 3: I/O ports at 8400
        Region 4: I/O ports at 8000
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=3 PME-
00: 95 10 48 06 07 00 90 02 01 00 04 01 00 20 00 00
10: 01 94 00 00 01 90 00 00 01 88 00 00 01 84 00 00
20: 01 80 00 00 00 00 00 00 00 00 00 00 95 10 48 06
30: 00 00 00 00 60 00 00 00 00 00 00 00 0b 01 02 04
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
50: 40 ec 00 c0 00 c0 00 dc 32 40 00 00 00 00 00 00
60: 01 00 21 06 00 60 00 f0 00 00 00 00 00 00 00 00
70: 00 08 00 f0 94 0a 00 00 00 82 00 f0 c8 01 48 2a
80: 00 00 00 00 00 00 00 00 00 00 00 00 95 10 48 06
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00



-----------------------------------------------------------------
John Heil
South Coast Software
Custom systems software for UNIX and IBM MVS mainframes
1-714-774-6952
johnhscs@sc-software.com
http://www.sc-software.com
-----------------------------------------------------------------


