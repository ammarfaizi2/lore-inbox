Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266119AbUAGAmt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 19:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266120AbUAGAmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 19:42:49 -0500
Received: from [193.138.115.2] ([193.138.115.2]:32274 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S266119AbUAGAmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 19:42:47 -0500
Date: Wed, 7 Jan 2004 01:39:51 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: James Simmons <jsimmons@infradead.org>
cc: Paul Misner <paul@misner.org>, linux-kernel@vger.kernel.org
Subject: Re: Blank Screen in 2.6.0
In-Reply-To: <Pine.LNX.4.44.0401062313350.21143-100000@phoenix.infradead.org>
Message-ID: <Pine.LNX.4.56.0401070128130.8521@jju_lnx.backbone.dif.dk>
References: <Pine.LNX.4.44.0401062313350.21143-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 6 Jan 2004, James Simmons wrote:

>
> > > Fixed in my latest patches.
> > >
>
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
>

Ok, I grabbed those and I have both good and bad news.

The good news is that I no longer get just a black screen at boot.
The bad news is that it still doesn't work quite right.

No matter what mode I try to boot in I always get the same, and it's as if
the image is drawn only on every second scanline. One result of this is
that I can only visually see approximately the top half of what I'm
supposed to see - like, if I type in something in the shell, then I have
to press enter several times untill enough lines have passed for the text
to reach the top of the screen and thus is actually visible.  Another
result of this is ofcourse that what I /can/ see doesn't look very good.

Also, after starting X (using the "nv" driver, not a fb X server) - if I
switch back to a text console then the screen is completely garbled - I
can switch back to X just fine though.

My hardware is : ASUS V8200 Deluxe, GeForce3 64MB

lspci -vvv reports :

01:05.0 VGA compatible controller: nVidia Corporation NV20 [GeForce3] (rev a3) (prog-if 00 [VGA])
        Subsystem: Asustek Computer, Inc. AGP-V8200 DDR
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at ee000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at f0000000 (32-bit, prefetchable) [size=64M]
        Region 2: Memory at ef800000 (32-bit, prefetchable) [size=512K]
        Expansion ROM at ef7f0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>


/Jesper Juhl



PS. I initially tried applying your patch to 2.6.1-rc1-mm2 , it had a few
rejects, but I tried building it anyway - it wouldn't compile. So I went
back to a clean 2.6.0 to which the patch applied flawlessly.
