Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262480AbTCRPkQ>; Tue, 18 Mar 2003 10:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262482AbTCRPkQ>; Tue, 18 Mar 2003 10:40:16 -0500
Received: from landfill.ihatent.com ([217.13.24.22]:44930 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id <S262480AbTCRPkP>;
	Tue, 18 Mar 2003 10:40:15 -0500
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.65-mm1
References: <20030318031104.13fb34cc.akpm@digeo.com>
	<87adfs4sqk.fsf@lapper.ihatent.com>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 18 Mar 2003 16:51:11 +0100
In-Reply-To: <87adfs4sqk.fsf@lapper.ihatent.com>
Message-ID: <87bs08vfkg.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Hoogerhuis <alexh@ihatent.com> writes:

> Andrew Morton <akpm@digeo.com> writes:
> >
> > [SNIP]
> >
> 
> [SNIP MYSELF]
>

Oh well, I've had one hang within 10 minutes of booting, came back and
the machine was unresponsive (mouse and keyboard under X, unable to
switch to console). Apart from that I've got two funnies in my boot
messages:

PCI: Cannot allocate resource region 0 of device 02:0e.2

THe device is my USB hub in the laptop:

lapper root # lspci -vv -s  02:0e.2
02:0e.2 USB Controller: NEC Corporation USB 2.0 (rev 02) (prog-if 20 [EHCI])
        Subsystem: Compaq Computer Corporation: Unknown device 004a
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (4000ns min, 8500ns max), cache line size 20
        Interrupt: pin C routed to IRQ 10
        Region 0: Memory at 30000000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
And this one when probing for my PCIC:

Intel PCIC probe: PNP <6>pnp: res: The PnP device '00:0f' is already
active.

And related to the video trouble, I fond this in the bootlog:

agpgart: Putting AGP V2 device at 00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 01:00.0 into 1x mode

lapper root # lspci
00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev 04)
00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev 04)

With 2.4 I used 4x AGP with X with no hassle.

mvh,
A

-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
