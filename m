Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129806AbRAWKs5>; Tue, 23 Jan 2001 05:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130509AbRAWKsr>; Tue, 23 Jan 2001 05:48:47 -0500
Received: from Huntington-Beach.Blue-Labs.org ([208.179.0.198]:50764 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S129806AbRAWKsh>; Tue, 23 Jan 2001 05:48:37 -0500
Message-ID: <3A6D616F.63EB34A6@linux.com>
Date: Tue, 23 Jan 2001 10:48:16 +0000
From: David Ford <david@linux.com>
Organization: Blue Labs Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: NETDEV timeout on tulips [was: Re: 2.4.1-test10]
In-Reply-To: <Pine.LNX.4.10.10101221711560.1309-100000@penguin.transmeta.com> <3A6CF5B7.57DEDA11@linux.com> <3A6D2D54.619AFA7E@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Do the tulip driver updates address the increasingly common NETDEV timeout
> > repots?
>
> In general you can answer this yourself by reading
> drivers/net/tulip/ChangeLog.
>
> I don't see increasingly common timeout reports.. with which hardware?
> They are likely on the newer LinkSys 4.1 cards, and there are still
> problesm with PNIC.  Outside of that, other cards should be ok.

I have four machines now that exhibit this problem.  Three have in them the
Linksys card family, similar PCI cards, one is my laptop which I have three
different cardbus cards but they all use the tulip driver.

In the PCI situation, not all machines using these cards act the same way.
I got a 10 pack of LNE100TX cards and so far only two out of the batch are doing
this, they are all the same revision, identical in every way that I've found.

The three cardbus cards are slightly different in numerous ways.  For them they
normally fault with an APM event, an eject/insert cycle via software will reset
them and a link down/up won't fix it.  For the PCI cards most times a link
down/up cycle will fix them.  It's a 2.4 v.s. 2.2 issue, the 2.2 kernels aren't
exhibiting this error.

The PCI cards are hard to get into this state, sometimes they'll run millions of
packets for months on end before they'll burp.  Sometimes it'll happen three
times a night.  The amount of traffic doesn't seem to matter, nor does the type
of traffic.

00:0a.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
        Subsystem: Netgear FA310TX
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 set
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at 6400 [size=256]
        Region 1: Memory at e4000000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at <unassigned> [disabled] [size=256K]


I say increasingly common because the more machines I bring on with 2.4 v.s. 2.3
or testNN kernels, the more the systems burp on this.  I.e. a kernel from 6
months ago takes 2-3 months to burp.  Last week's kernel burps once a week.

-d

--
  There is a natural aristocracy among men. The grounds of this are virtue and talents. Thomas Jefferson
  The good thing about standards is that there are so many to choose from. Andrew S. Tanenbaum



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
