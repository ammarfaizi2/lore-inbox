Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315439AbSHXU62>; Sat, 24 Aug 2002 16:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315758AbSHXU62>; Sat, 24 Aug 2002 16:58:28 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:32266
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S315439AbSHXU61>; Sat, 24 Aug 2002 16:58:27 -0400
Date: Sat, 24 Aug 2002 14:01:30 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org
Subject: Re: IDE janitoring comments
In-Reply-To: <1030220051.3196.5.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10208241400360.20141-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yep, just be careful of how to decouple the hwif->iops from procfs for pci
and the general lameness of x86 centric issues.

On 24 Aug 2002, Alan Cox wrote:

> On Sat, 2002-08-24 at 16:15, Benjamin Herrenschmidt wrote:
> >  - Do we really want to keep all those _P versions around ?
> > A quick grep showed _only_ by the non-portable x86 specific
> > recovery timer stuff that taps ISA timers (well, I think ports
> > 0x40 and 0x43 and an ISA timer). I would strongly suggest to
> 
> I'd like to keep them around for the moment. They should be using
> udelay() but thats a general issue with _p inb/outb etc.
> 
> > After much thinking about the above, I came to the conslusion
> > we probably want to just kill all the IN_BYTE, OUT_BYTE, etc.
> 
> Agreed entirely
> 
> 
> > Also, getting rid of the _P version would make things a lot
> > easier as well here too.
> 
> What currently uses the _P versions ?
> 

Andre Hedrick
LAD Storage Consulting Group

