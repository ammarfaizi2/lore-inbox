Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263534AbTE3J6M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 05:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263535AbTE3J6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 05:58:12 -0400
Received: from mail.ithnet.com ([217.64.64.8]:44562 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S263534AbTE3J6J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 05:58:09 -0400
Date: Fri, 30 May 2003 12:11:08 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: marcelo@conectiva.com.br, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: 21rc6 serverworks IDE blows even more than is usual :)
Message-Id: <20030530121108.6a6a82de.skraw@ithnet.com>
In-Reply-To: <20030529114001.GD7217@louise.pinerecords.com>
References: <20030529114001.GD7217@louise.pinerecords.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 May 2003 13:40:01 +0200
Tomas Szepe <szepe@pinerecords.com> wrote:

> Hi Alan, Bartolomiej, Marcelo,
> 
> I can't seem to get the onboard Serverworks CSB5 IDE controller (rev 93)
> in a Compaq Proliant ML350 G3 to work (reliably/at all) no matter what
> kernel I use:
> 
> o  2.4.21-rc6
> 	intrerrupt timeouts, can't r/w from/to drive reliably in pio, dma hosed
> 
> o  2.4.21-rc2-ac3
> 	r/w in pio ok, dma hosed
> 
> o  2.4.20
> 	intrerrupt timeouts, can't r/w from/to drive reliably in pio, dma hosed
> 
> o  2.4.20-pre8-ac3 (has always worked on OSB4 beasts for me)
> 	intrerrupt timeouts, can't r/w from/to drive reliably in pio, dma hosed
> 
> lspci & .config excerpts plus other bits of info follow.
> The box is SMP + highmem.
> 
> --
> 
> 00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93) (prog-if 8a
> [Master SecP PriP])
> 	Subsystem: ServerWorks CSB5 IDE Controller
> 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
> 	Stepping- SERR+ FastB2B- Status: Cap- 66Mhz- UDF- FastB2B- ParErr-
> 	DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- Latency: 64
> 	Region 0: I/O ports at <ignored>
> 	Region 1: I/O ports at <ignored>
> 	Region 2: I/O ports at <unassigned>
> 	Region 3: I/O ports at <unassigned>
> 	Region 4: I/O ports at 2000 [size=16]

I don't know if this is in anyway interesting for you, but I got the same
chipset on an Asus board and been burning GBs of data onto DVDs with it and no
(ide) problem.

Mine:

00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93) (prog-if 8a
	[Master SecP PriP])
        Subsystem: ServerWorks CSB5 IDE Controller
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
	Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
	<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 08
        Region 0: I/O ports at <ignored>
        Region 1: I/O ports at <ignored>
        Region 2: I/O ports at <ignored>
        Region 3: I/O ports at <ignored>
        Region 4: I/O ports at 9400 [size=16]

/dev/hdc:

 Model=SONY DVD RW DRU-500A, FwRev=2.0c, SerialNo=XXXXXXXX
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=0kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=on/off, tPIO={min:180,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 *udma2 
 AdvancedPM=no
 Drive conforms to: device does not report version:  4 5 6



Regards,
Stephan


