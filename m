Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319453AbSH3GrZ>; Fri, 30 Aug 2002 02:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319458AbSH3GrZ>; Fri, 30 Aug 2002 02:47:25 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:33683 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S319453AbSH3GrY>;
	Fri, 30 Aug 2002 02:47:24 -0400
Date: Fri, 30 Aug 2002 08:51:26 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Meelis Roos <mroos@tartu.cyber.ee>,
       linux-kernel@vger.kernel.org
Subject: Re: Hangs in 2.4.19 and 2.4.20-pre5 (IDE-related?)
Message-ID: <20020830085126.A19532@ucw.cz>
References: <20020830075147.D18904@ucw.cz> <Pine.LNX.4.10.10208292329150.7329-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10208292329150.7329-100000@master.linux-ide.org>; from andre@linux-ide.org on Thu, Aug 29, 2002 at 11:31:39PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2002 at 11:31:39PM -0700, Andre Hedrick wrote:
> 
> Vojtech,
> 
> Ball is in your court, DO IT!
> Lets see what you got and how we can debloat the driver more.
> 
> Looking to put the past behind, will you help?

Sure.

> Cheers,
> 
> Andre Hedrick
> LAD Storage Consulting Group
> 
> 
> On Fri, 30 Aug 2002, Vojtech Pavlik wrote:
> 
> > > Well if atapci is that complete then I see no reason to keep proc about.
> > > So if it needs to go we delete it.
> > 
> > I think you can drop the chipset specific /proc code. It'll simplify the
> > drivers a lot as well as making them smaller.
> > 
> > On the other hand, I'd suggest that some generic /proc code is put in
> > place instead of the chipset-specific one - the values that cannot be
> > read from PCI config registers, like:
> > 
> > The PIO/MMIO/(U)DMA mode (and transfer rate) the IDE driver is operating
> > the in. The bus speed the driver thinks is running at. Whether the IDE
> > driver has detected a 80 or 40 wire cable. Etc, etc. This would be very
> > useful, can be done by a single common routine, and most users actually
> > don't need the exact timings.

-- 
Vojtech Pavlik
SuSE Labs
