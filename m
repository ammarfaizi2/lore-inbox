Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267208AbTAFXti>; Mon, 6 Jan 2003 18:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267209AbTAFXti>; Mon, 6 Jan 2003 18:49:38 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:34323 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267208AbTAFXtf>; Mon, 6 Jan 2003 18:49:35 -0500
Date: Mon, 6 Jan 2003 18:55:25 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE changes that affect upper layer drivers
In-Reply-To: <1041895478.18831.7.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.3.96.1030106185147.12023B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Jan 2003, Alan Cox wrote:

I really hope this isn't going to be a replay of "new modules" where
major stuff gets broken. I would really not like to contemplate turning
off DMA until all the drivers get rewritten. Going without modules costs
only a bit of memory, going without DMA costs a LOT of CPU with some
hardware.

> I'm about to enable the vmda logic for non disk drivers. That means IDE
> tape, scsi, cd and friends need updating to follow the new rules
> 
> Before it was simply:
> 	->dma = 1   - do DMA
> 
> Some devices and a lot of upcoming ones support DMA to the host while
> doing PIO to the device "Virtual DMA". That means the drivers now
> need to do
> 
> 	DMA	VDMA
> 	 0	  X		PIO
> 	 1	  0		Issue PIO commands, set up for DMA xfers
> 	 1        1		Issue DMA commands, set up for DMA xfers
> 
> 
> Alan

Wishing you the best of luck with this one...

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

