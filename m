Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287951AbSABUYZ>; Wed, 2 Jan 2002 15:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287944AbSABUYG>; Wed, 2 Jan 2002 15:24:06 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:17169 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S287945AbSABUXr>;
	Wed, 2 Jan 2002 15:23:47 -0500
Date: Wed, 2 Jan 2002 21:23:35 +0100
From: Jens Axboe <axboe@suse.de>
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
        Matthew Dharm <mdharm@one-eyed-alien.net>, Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] Re: highmem and usb [was "sr: unaligned transfer" in 2.5.2-pre1]
Message-ID: <20020102212335.B482@suse.de>
In-Reply-To: <20011230212700.B652@one-eyed-alien.net> <20011231125157.D1246@suse.de> <20011231145455.C6465@one-eyed-alien.net> <065e01c192fd$fe066e20$6800000a@brownell.org> <20020101233423.I16092@suse.de> <06c801c1934e$1fc01a20$6800000a@brownell.org> <20020102103252.B28530@suse.de> <07c401c193bc$90ad5d60$6800000a@brownell.org> <20020102194404.A482@suse.de> <07e501c193bf$14cb7800$6800000a@brownell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07e501c193bf$14cb7800$6800000a@brownell.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02 2002, David Brownell wrote:
> > > OK, I think I'm clear on this much then:  in 2.5, to support block drivers
> > > over USB (usb-storage only, for now) there needs to be an addition to
> > > the buffer addressing model in usbcore, as exposed by URBs.
> > > 
> > >   - Current "transfer_buffer" + "transfer_buffer_length" mode needs to
> > >     stay, since most drivers aren't block drivers.
> > 
> > Why? Surely USB block drivers are not the only ones that want to support
> > highmem.
> 
> Once the capability is there, it'll find other uses.  But allowing
> them is not the same as requiring them.  Getting rid of the current
> model would break every USB driver, rather than just ones that want to
> support highmem.

So? Either you want to fix this now, or leave it that way forever. Just
IMO of course, but you might as well just make a clean break.

> > >   - Add some kind of "page + offset" addressing model.
> > 
> > Yes
> > 
> > > Discussion of details can be taken off LKML, it'd seem.  Though
> > > I'm curious when the scatterlist->address field will vanish,
> > > making these changes a requirement.  Is that a 2.5.2 thing?
> > 
> > Maybe 2.5.3, dunno for sure.
> 
> A bit of  a delay would make things a bit easier ... :) Of course, if
> scatterlist->address doesn't work any more, it won't matter much.

A bit of delay will only make things worse, afaics.

-- 
Jens Axboe

