Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270737AbUJUPCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270737AbUJUPCq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 11:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270728AbUJUPBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 11:01:37 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:60939 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S270747AbUJUO6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 10:58:47 -0400
Message-ID: <4177D163.2000503@techsource.com>
Date: Thu, 21 Oct 2004 11:10:27 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
References: <4176E08B.2050706@techsource.com> <1098313825.12374.74.camel@localhost.localdomain>
In-Reply-To: <1098313825.12374.74.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan Cox wrote:
> On Mer, 2004-10-20 at 23:02, Timothy Miller wrote:
> 
>>- The card "just works" with Linux because, maybe, the drivers would go 
>>into main-line
> 
> 
> That bit ought to "just work" 8)

Well, if you're in favor of it, it will, but not every patch submitted 
to Linus or Andrew ends up in the mainline kernel.  I'm a total unknown 
here.  I don't expect special treatment.

> 
> 
>>- The drivers are easy to work on, since you don't ever have to guess 
>>about anything.
>>- The drivers are easy to debug because
>>     (a) we document everything, and
>>     (b) we'll talk to you.
> 
> 
> Some other vendors pretty much did this but the takeup isn't that vast
> because writing 3D drivers is not trivial (we have docs for about 5
> cards and no drivers, some are pretty old some are fairly passable
> cards)

I would do the basic 3D drivers.  I'm going to have to spend a good bit 
of time learning all the math behind 3D graphics anyhow.  I mean, I 
understand the basics, and I do just fine with linear algebra, but I 
don't live in that zone right now, so I don't grok every detail.  In 
order to design the chip, I'll have to go there, and as a result, I 
should have little trouble doing the software portion.  After I'm done 
with it, others can do whatever they want with it.

Note:  It would be nice to release partial drivers early so others can 
hack at them, but we cannot sell a product without a complete, working, 
tested, driver suite for several platforms.  A beta period would be 
nice, where developers can get prototype boards, but prototypes can be 
very expensive to produce.

> 
>>and they STILL don't document the internals of the BIOS so that the card 
>>can be ported to a non-x86 system.  Furthermore, since all these vendors
> 
> 
> Talking to one very large motherboard video company they actually can't
> because the analogue side is done by the board vendor as is things like
> the RAM choice.

Yes, that is definately an issue.  Fortunately, if you have both specs 
for the RAM chips and the full register set for the GPU documented, then 
getting it to work with any arbitrary RAM chip is trivial.

Of course, generally speaking, since we're selling the boards, we'd 
simply just publish numbers and a code snippet for configuring the 
memory controller properly, so it's no big deal.

We're not expecting the community to do software development for this 
product, but we DO want them to be able to easily and freely address 
bugs and compatibility issues.

> 
>>give me sufficient funding to produce an ASIC.  What this means is that 
>>the design has to be small and simple and focus primarily on 2D 
>>performance so that it can fit into an FPGA.
> 
> 
> X actually needs very little functionality nowdays, although some of it
> does not map well onto a generic 2D rendering card. Notably most 2D
> engines lack alpha blend.

Well, adding alpha blend to 2D isn't that hard.  But when you want, say, 
oversampling AA, and then you start adding other features, then the 
point in having a separate 2D pipeline diminishes.

> 
> Essentially if you can do alpha, bitblit, blit from main memory and
> a couple of fills and colour-expands X is happy.

How about text, stipple fills, tile fills, and lines?  :)

Actually, if you do it right, only lines are a special case, and you can 
even hide that.

> 
>>(1) Would the sales volumes of this product be enough to make it worth 
>>producing (ie. profitable)?
> 
> 
> I'm very dubious I must admit. 
> 
> 
> I've actually always wondered what a hybrid video device would look like
> for 3D. Doing the alpha blend and very basic operations only in the
> hardware that are expensive in software - alpha and perhaps some of the
> texture scaling, but walking textures in software, doing shaders in
> software and so on.

Well, if a specific set of needs can be identified, we could easily 
enough develop a GPU which does only those things.


Something to keep in mind:  The chip contains more than just a rendering 
engine.  The VGA core, host interface (AGP/PCI), video controller, 
memory controller, and other misc things all take up a fair amount of 
space on their own.

