Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263416AbTC2NsP>; Sat, 29 Mar 2003 08:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263417AbTC2NsP>; Sat, 29 Mar 2003 08:48:15 -0500
Received: from nms.rz.uni-kiel.de ([134.245.1.2]:3764 "EHLO uni-kiel.de")
	by vger.kernel.org with ESMTP id <S263416AbTC2NsO>;
	Sat, 29 Mar 2003 08:48:14 -0500
Date: Sat, 29 Mar 2003 14:59:26 +0100
From: Torsten Landschoff <torsten@debian.org>
To: Danny ter Haar <dth@ncc1701.cistron.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE DMA problems
Message-ID: <20030329135925.GA25789@pclab.ifg.uni-kiel.de>
References: <20030328192717.GA16621@pclab.ifg.uni-kiel.de> <b62dmb$bad$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b62dmb$bad$1@news.cistron.nl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Danny, 

On Fri, Mar 28, 2003 at 09:09:31PM +0000, Danny ter Haar wrote:
> >Using hdparm -X 66 to set it to udma2 just kills off dma with these
> >error messages:
> >
> >  hda: timeout waiting for DMA
> >  ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> >  hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> >  hda: drive not ready for command
> >  blk: queue c0370084, I/O limit 4095Mb (mask 0xffffffff)
> >  hda: lost interrupt
> >
> 
> I've experienced similar "problems/events".
> 
> If i enable unix processor apic but NOT IO-APIC i don't have these
> problems.

The system in question is actually SMP but currently running with a 
single CPU because of a fan failure. So I think that option is enabled
by default. 

In fact it was a dumb error on my side. I did /not/ enable PIIX_TUNING
while I was sure I did. With that option the kernel configure the bus
just fine for whatever DMA the board supports. 

Currently I got another problem: When rebuilding the raid5 it fails
with an I/O error. The IDE message is not very helpful but it seems
the second disk in the raid is defective. But I guess I am down to 
pure hardware problems.

Thanks, Guys

	Torsten
