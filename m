Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130517AbRCPThz>; Fri, 16 Mar 2001 14:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130636AbRCPThp>; Fri, 16 Mar 2001 14:37:45 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:25096
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S130517AbRCPThd>; Fri, 16 Mar 2001 14:37:33 -0500
Date: Fri, 16 Mar 2001 11:36:36 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: John Heil <kerndev@sc-software.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: IDE UDMA on a CMD-648 Chip
In-Reply-To: <Pine.LNX.3.95.1010315113407.21451A-100000@scsoftware.sc-software.com>
Message-ID: <Pine.LNX.4.10.10103161136020.14210-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Unless you have patches for 2.2 kernels most addon hosts will not be seen.

On Fri, 16 Mar 2001, John Heil wrote:

> 
> I've acquired a UDMA66 capable IDE card with a CMD-648 chip,
> which is supposed to provide me with ide2 and ide3.
> 
> ide2 is empty and ide3 has a writeable cdrom and an IDE zip
> drive on it.
> 
> At boot up, the card's bios scan recognizes the cdrom and zip
> as master and slave on its secondary ide i/f, which is correct.
> 
> However, it indicates that since it... 
> 'Can't find a UDMA66 capable device' 
> it is 
> 'Disabling the UDMA66 bios'.
> 
> I've done the usual append for ide3, in lilo.conf but w/o benefit.
> 
> Kernel is currently 2.2.16,
> The mobo is an Asus A7V133 and the CPU is an 1.1 Athlon
> South bridge is a via 686b which runs fine at UDMA100 on a 
> pair of Maxtors on IDE-0.  
> 
> I'll be upgrading this machine to 2.4.n-whatever in about 3 wks but...
> ...I'd like to get the 2 devices operational on this or 
> some other 2.2.x, before that, if I can.
> 
> I can't find the chip's datasheet. CMD only gives it to direct customers.
> I do have the datasheet for the CMD-646U, a prior UDMA supporting chip.
> 
> I take this to be a bug in the on-card Bios.
> 
> I am hoping to circumvent the bios. I assume it will involve some
> measure of IDE initialization  which  I don't mind coding if 
> it does not exist yet.
> 
> 
> So has anyone encountered this chip yet and 
> are there any existing solutions or suggestions.
> 
> 
> Thanx much
> 
> 
> The CMD-648 chip's vital statistics follow...
> 
> root@scsoftware50:~# lspci -vvxxxs 00:0c.0
> 00:0c.0 RAID bus controller: CMD Technology Inc PCI0648 (rev 01)
>         Subsystem: CMD Technology Inc PCI0648
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32 (500ns min, 1000ns max)
>         Interrupt: pin A routed to IRQ 11
>         Region 0: I/O ports at 9400
>         Region 1: I/O ports at 9000
>         Region 2: I/O ports at 8800
>         Region 3: I/O ports at 8400
>         Region 4: I/O ports at 8000
>         Capabilities: [60] Power Management version 1
>                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=3 PME-
> 00: 95 10 48 06 07 00 90 02 01 00 04 01 00 20 00 00
> 10: 01 94 00 00 01 90 00 00 01 88 00 00 01 84 00 00
> 20: 01 80 00 00 00 00 00 00 00 00 00 00 95 10 48 06
> 30: 00 00 00 00 60 00 00 00 00 00 00 00 0b 01 02 04
> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
> 50: 40 ec 00 c0 00 c0 00 dc 32 40 00 00 00 00 00 00
> 60: 01 00 21 06 00 60 00 f0 00 00 00 00 00 00 00 00
> 70: 00 08 00 f0 94 0a 00 00 00 82 00 f0 c8 01 48 2a
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 95 10 48 06
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 
> 
> -----------------------------------------------------------------
> John Heil
> South Coast Software
> Custom systems software for UNIX and IBM MVS mainframes
> 1-714-774-6952
> johnhscs@sc-software.com
> http://www.sc-software.com
> -----------------------------------------------------------------
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

