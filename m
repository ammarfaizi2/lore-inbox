Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267619AbSLSLzK>; Thu, 19 Dec 2002 06:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267621AbSLSLzK>; Thu, 19 Dec 2002 06:55:10 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:39319 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267619AbSLSLzJ>; Thu, 19 Dec 2002 06:55:09 -0500
Date: Thu, 19 Dec 2002 13:03:07 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19, don't "hdparm -I /dev/hde" if hde is on a Asus A7V133 Promise ctrlr, or...
Message-ID: <20021219120307.GE17201@louise.pinerecords.com>
References: <20021219111450.GD17201@louise.pinerecords.com> <Pine.LNX.4.10.10212190314260.8350-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10212190314260.8350-100000@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > > > So.  I /think/ that somehow the Promise controller isn't being
> > > > > > initialized properly by the Linux kernel, UNLESS the mobo's BIOS
> > > > > > inits it first?
> > > > >
> > > > > In some situations yes. The BIOS does stuff including fixups we mere
> > > > > mortals arent permitted to know about.
> > > > 
> > > > OTOH mere mortals are allowed to make full dump of PCI config ;)
> > > > 
> > > > "D.A.M. Revok" <marvin@synapse.net>, can you send lspci -vvvxxx
> > > > outputs when you boot with BIOS enabled and BIOS disabled?
> > > 
> > > Promise knows this point.
> > > Thus they moved the setting to a push/pull in the vendor space in the
> > > dma_base+1 and dma_base+3 respectively.
> > > 
> > > lspci -vvvxxx fails when the content is located in bar4 io space.
> > 
> > Clearly Promise is the one storage vendor whose products are best avoided.
> 
> I would not say this is the case.  What is going on is people are wanting
> to migrate to more of an internal hidden operation.
> 
> Think about it from their side.
> They want to make it easier to program the card.

The result of their attempts has seemed to be the exact opposite
so far, so I'd say they're either hiding a bit too much or the
hardware doesn't cut it.

Anyway, what are the chances of the 2.4.21-pre PDC driver getting
fixed up so it works like it did in 2.4.18?

> Linux is an OS that like to know what is going on all the time,
> and the two clash.

Are you suggesting something to the point of Windows not having
to cope with the same issues?  There has to be some kind of fundamental
difference given Promise themselves successfully hosed the Linux driver
the instant they touched it, while the Windows one just works. :)

-- 
Tomas Szepe <szepe@pinerecords.com>
