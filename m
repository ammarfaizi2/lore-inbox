Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263963AbUFBTxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263963AbUFBTxo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 15:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263995AbUFBTxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 15:53:44 -0400
Received: from bgp01360964bgs.sandia01.nm.comcast.net ([68.35.68.128]:63130
	"EHLO orion.dwf.com") by vger.kernel.org with ESMTP id S263963AbUFBTxl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 15:53:41 -0400
Message-Id: <200406021952.i52JqCVe004899@orion.dwf.com>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4
To: root@chaos.analogic.com
From: clemens@dwf.com
cc: reg@dwf.com, linux-kernel@vger.kernel.org, linux@horizon.com
Subject: Re: Intel 875 Motherboard cant use 4GB of Memory. 
In-Reply-To: Message from "Richard B. Johnson" <root@chaos.analogic.com> 
   of "Wed, 02 Jun 2004 08:17:21 EDT." <Pine.LNX.4.53.0406020812440.2552@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 02 Jun 2004 13:52:12 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 1 Jun 2004 reg@dwf.com wrote:
> 
> >
> > > That could be PCI devices.  Some (particularly high-end video cards)
> > > take up a lot of address space, which comes straight out of the available
> > > 4 GB physical address space.
> > >
> > > Check /proc/iomem.
> > >
> >
> > OK, that leaves me more confused, and (to me) it still looks like a
> > BIOS problem rather than a greedy device.  Here is the /proc/iomem
> > with some decimal annotations: (as noted, there is 4x1GB of memory installed)
> >
> 
> 
> Not just Intel motherboards. There is 32 bits of address-space.
> This needs to be shared between RAM and the I/O addresses of
> PCI/Bus and AGP boards. Unfortunately, the PCI/AGP specification
> wastes a lot of address space because something that needs 1 megabyte
> of address-space must sit on a 1 megabyte boundary.  If this
> comes after something that used 128 bytes, there is nearly a megabyte
> wasted to get to the next boundary. A megabyte here a megabyte there..
> pretty soon you are talking about a lot of wasted address-space.
> 
> Solution: A 64 bit machine will have the same problem, you end up
> wasting RAM address space if it overlays PCI/Bus space. But, you
> probably would never opt for a gazzzilion bytes of RAM anyway?
> 
> 	One gazzzilion = 1844 6744 0737 0955 1615  (2 ^ 64)
> 
> Just don't put 4 gigs of RAM in a 4 gig address-space and expect
> to use it all. Sell the spare 2 gigs or build another PC with it!
> 
> 
I understand what you are saying, I just hadnt expected the system
to grab quite so much space.  After all there is only a video card
(Radeon 9600) and a sound card (Sound Blaster Live!) plugged into
the bus.

Im sure that the sound card doesnt use all that much space, but I
find it hard to believe that the video card is grabbing ALL of that space.
Possibly grabbing space at too low an address, but that should be correctable.

I had expected to loose some space, just not as much as is missing.

And this board does like paired memory cards, so perhaps the solution
would be 2x 1GB and 2x 500MB.


-- 
                                        Reg.Clemens
                                        reg@dwf.com


