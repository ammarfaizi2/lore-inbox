Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293251AbSCWOk6>; Sat, 23 Mar 2002 09:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293245AbSCWOki>; Sat, 23 Mar 2002 09:40:38 -0500
Received: from group1.mxgrp.airmail.net ([209.196.77.106]:60934 "EHLO
	mx9.airmail.net") by vger.kernel.org with ESMTP id <S293218AbSCWOkd>;
	Sat, 23 Mar 2002 09:40:33 -0500
Date: Sat, 23 Mar 2002 08:51:59 -0600
From: Art Haas <ahaas@neosoft.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: 2.4.18 & ALI15X3 DMA hang on boot
Message-ID: <20020323085159.A484@debian>
In-Reply-To: <200203231419.g2NEJuV01771@gs176.sp.cs.cmu.edu> <3C9C8FA2.4090204@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2002 at 03:22:26PM +0100, Martin Dalecki wrote:
> John Langford wrote:
> >>But before could you just tell the m5229_revision value
> >>on your system?
> >
> >I'm not sure what you mean.  Certainly, lspci says:
> >
> >
> >>00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c3)
> 
> That's it. Thank you.
> 

Hi.

I've been 'cc'd on the mail going to John Langford and everyone else
having trouble with the alim15x3 driver. As another data point, here's
what my machine has ...

$ lspci -vv
00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1531 [Aladdin IV] (rev b3)
	Subsystem: Acer Laboratories Inc. [ALi] M1531 [Aladdin IV]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32

00:02.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV] (rev b4)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
	Latency: 0

00:05.0 VGA compatible controller: S3 Inc. ViRGE/DX or /GX (rev 01) (prog-if 00 [VGA])
	Subsystem: S3 Inc. ViRGE/DX
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at ec000000 (32-bit, non-prefetchable) [size=64M]
	Expansion ROM at ebff0000 [disabled] [size=64K]

00:0b.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev 20) (prog-if fa)
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 14
	Region 4: I/O ports at ffa0 [size=16]
$

I'm currently running 2.4.19-pre3-ac6, and when I boot I've added "pci=biosirq"
to the command line.

-- 
They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
