Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbVBMAJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVBMAJr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 19:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVBMAJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 19:09:47 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:1434 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261221AbVBMAJn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 19:09:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=D7c1cfQcNaw/l0oL4gmS92LBV5FtqZRg3LSTCyz9JFKeyajg70NxRI24RiafM5qhOqDBUG2h9UtorRdQb1T4pPNi6EJ9JS7/WJkhGsbI2GBJv5MS6ht6Z0y4yEfkZXY0E3qIrETpkjtRrK6IPhqjopbLPj38sLisX0Ees2gRj80=
Message-ID: <5a4c581d05021216095ec00bf9@mail.gmail.com>
Date: Sun, 13 Feb 2005 01:09:43 +0100
From: Alessandro Suardi <alessandro.suardi@gmail.com>
Reply-To: Alessandro Suardi <alessandro.suardi@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.11-rc3-bk9 (radeon) hangs hard my laptop
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1108291975.6698.7.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <5a4c581d0502120649423a2504@mail.gmail.com>
	 <5a4c581d05021207593fae0c93@mail.gmail.com>
	 <5a4c581d050212135716fa6a17@mail.gmail.com>
	 <1108291975.6698.7.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Feb 2005 21:52:55 +1100, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> 
> > It's definitely the new radeon changes - replacing
> >  drivers/video/aty/* and include/video/radeon.h in the
> >  -bk9 tree with the ones from -bk8 causes the hang to
> >  not reproduce anymore. CC'd Ben and edited subject
> >  to more accurately reflect the issue.
> 
> Grrr...
> 
> Can you try booting with radeonfb.default_dynclk=-1 and if it doesn't
> help, radeonfb.default_dynclk=0 on the kernel command line ?

I'm currently booted with -bk9 with default_dynclk = -1 :)

> Also, what is the exact revision of the chip ? (send me an lspci -vv
> dump).

Here you go:

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon
Mobility M7 LW [Radeon Mobility 7500] (prog-if 00 [VGA])
        Subsystem: Dell Computer Corporation Latitude C640
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+
ParErr- Stepping+ SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), Cache Line Size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e0000000 (32-bit, prefetchable)
        Region 1: I/O ports at c000 [size=256]
        Region 2: Memory at fcff0000 (32-bit, non-prefetchable) [size=64K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit-
FW- Rate=x1
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

> Finally, what X version are you using ?

Latest FC2 RPM - xorg-x11-6.7.0-11.

--alessandro

  "There is no distance that I don't see
  I do have a will - No limit to my reach"
  
    (Wallflowers, "Empire In My Mind")
