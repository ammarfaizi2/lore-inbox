Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267641AbSLSMfo>; Thu, 19 Dec 2002 07:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267643AbSLSMfo>; Thu, 19 Dec 2002 07:35:44 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:47634
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S267641AbSLSMfm>; Thu, 19 Dec 2002 07:35:42 -0500
Date: Thu, 19 Dec 2002 04:41:23 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Tomas Szepe <szepe@pinerecords.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19, don't "hdparm -I /dev/hde" if hde is on a Asus A7V133
 Promise ctrlr, or...
In-Reply-To: <20021219120307.GE17201@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.10.10212190427370.8350-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Dec 2002, Tomas Szepe wrote:

> > > > > > > So.  I /think/ that somehow the Promise controller isn't being
> > > > > > > initialized properly by the Linux kernel, UNLESS the mobo's BIOS
> > > > > > > inits it first?
> > > > > >
> > > > > > In some situations yes. The BIOS does stuff including fixups we mere
> > > > > > mortals arent permitted to know about.
> > > > > 
> > > > > OTOH mere mortals are allowed to make full dump of PCI config ;)
> > > > > 
> > > > > "D.A.M. Revok" <marvin@synapse.net>, can you send lspci -vvvxxx
> > > > > outputs when you boot with BIOS enabled and BIOS disabled?
> > > > 
> > > > Promise knows this point.
> > > > Thus they moved the setting to a push/pull in the vendor space in the
> > > > dma_base+1 and dma_base+3 respectively.
> > > > 
> > > > lspci -vvvxxx fails when the content is located in bar4 io space.
> > > 
> > > Clearly Promise is the one storage vendor whose products are best avoided.
> > 
> > I would not say this is the case.  What is going on is people are wanting
> > to migrate to more of an internal hidden operation.
> > 
> > Think about it from their side.
> > They want to make it easier to program the card.
> 
> The result of their attempts has seemed to be the exact opposite
> so far, so I'd say they're either hiding a bit too much or the
> hardware doesn't cut it.
> 
> Anyway, what are the chances of the 2.4.21-pre PDC driver getting
> fixed up so it works like it did in 2.4.18?

Well, there is an issue.
I have a consulting contract with Promise outstanding.
It is on my desk, but there is on issue I refuse to agree to period.

Nobody in the right mind agrees to disclose their entire IP portfolio, as
a contractor or consultant.  This allow the client to box you into a
corner so tight, that anything in the future they can claim as their own
and tie it back to an contract collecting dust.

> > Linux is an OS that like to know what is going on all the time,
> > and the two clash.
> 
> Are you suggesting something to the point of Windows not having
> to cope with the same issues?  There has to be some kind of fundamental
> difference given Promise themselves successfully hosed the Linux driver
> the instant they touched it, while the Windows one just works. :)

So I am not fixing anything until this issue is resolved.
They pay for what you clearly have stated above.

As for the Windows issue, the scsi-mini-port is a whole differenct beast.
Everyone jokes and laughs at my quote:
	"The world of Storage is nothing but a BIG LIE"

SCSI is a run,poke,sense,verify,transform world.
ATA is a run,check,return world.

That being said, as far as I can tell, the WDDK for mini-port only cares
about the state returned.  So if you do not like the state your hardware
is in, you boost the return and hook a TDI callback or poll check.
It is obvious the OEM Windows driver has unlimited power to fake the
response.

At this point I expect any contract is dead, so use 2.4.18.


Cheers,

Andre Hedrick
LAD Storage Consulting Group

