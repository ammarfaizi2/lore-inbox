Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129042AbRBMT0d>; Tue, 13 Feb 2001 14:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129181AbRBMT0X>; Tue, 13 Feb 2001 14:26:23 -0500
Received: from sense-gold-134.oz.net ([216.39.162.134]:29956 "EHLO
	sense-gold-134.oz.net") by vger.kernel.org with ESMTP
	id <S129042AbRBMT0I>; Tue, 13 Feb 2001 14:26:08 -0500
Date: Tue, 13 Feb 2001 11:26:23 -0800 (PST)
From: al goldstein <gold@sense-gold-134.oz.net>
To: Andrew Morton <andrewm@uow.edu.au>
cc: al goldstein <gold@sense-gold-134.oz.net>,
        kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1 swaps hardware addresses for ethernet cards
In-Reply-To: <3A891B97.4F9805A6@uow.edu.au>
Message-ID: <Pine.LNX.4.21.0102131119250.2457-100000@sense-gold-134.oz.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2001, Andrew Morton wrote:

Thanks Andrew, I appreciate your note. I'll try it again with 509 as a module.
I had forgotten about linkage order problems.


> al goldstein wrote:
> > 
> > I have 2 ether cards 59x (eth0) and 509 (eth1). I have been adding 509
> > at boot in lilo.conf. Using this same config in 2.4.1 results in
> > the hardware addresses for the cards to be swapped. If I remove 509 from
> > Lilo I get the same result. Suggestions would be appreciated
> 
> If both drivers are statically linked into the kernel then
> I guess this is entirely dependent upon the linkage order of
> net/core/dev.o and drivers/net/3c59x.o.
> 
> If you make the drivers modular then you can force the order
> within your boot scripts.
> 
> If you make just one driver modular then that one will be
> "eth1".
> 
> You can grab Andi's "nameif" app which allows you to rename
> interfaces based on their MAC address, which will certainly
> put and end to the issue.  I'm not sure whether this
> app is in net-tools yet.
> 
> Finally, you can wait until the Linux hotplug architecture
> is fully implemented, after which the naming order will
> be nicely randomised each time you boot :)
> 
> It's fun, isn't it?
> 
> -
> 

