Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbTKTGxg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 01:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbTKTGxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 01:53:36 -0500
Received: from waste.org ([209.173.204.2]:42151 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261506AbTKTGxd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 01:53:33 -0500
Date: Thu, 20 Nov 2003 00:52:41 -0600
From: Matt Mackall <mpm@selenic.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Jeff Garzik <jgarzik@pobox.com>, jt@hpl.hp.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Pontus Fuchs <pof@users.sourceforge.net>
Subject: Re: Announce: ndiswrapper
Message-ID: <20031120065241.GF22139@waste.org>
References: <20031120031137.GA8465@bougret.hpl.hp.com> <3FBC3483.4060706@pobox.com> <20031120040034.GF19856@holomorphy.com> <3FBC402E.6070109@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FBC402E.6070109@cyberone.com.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 20, 2003 at 03:16:46PM +1100, Nick Piggin wrote:
> 
> 
> William Lee Irwin III wrote:
> 
> >Jean Tourrilhes wrote:
> >
> >>>	Even better :
> >>>		1) go to the Wireless LAN Howto
> >>>		2) find a card are supported under Linux that suit your needs
> >>>		3) buy this card
> >>>	I don't see the point of giving our money to vendors that
> >>>don't care about us when there are vendors making a real effort toward
> >>>us.
> >>>
> >
> >On Wed, Nov 19, 2003 at 10:26:59PM -0500, Jeff Garzik wrote:
> >
> >>Unfortunately that leaves users without support for any recent wireless 
> >>hardware.  It gets more and more difficult to even find Linux-supported 
> >>wireless at Fry's and other retail locations...
> >>
> >
> >And what good would it be to have an entire driver subsystem populated
> >by binary-only drivers? That's not part of Linux, that's "welcome to
> >nvidia hell" for that subsystem too, and not just graphics cards.
> >
> >I say we should go the precise opposite direction and take a hard line
> >stance against binary drivers, lest we find there are none left we even
> >have source to and are bombarded with unfixable bugreports.
> >
> >No, it's not my call to make, but basically, I don't see many benefits
> >left. The additional drivers we got out of this were highly version-
> >dependent, extremely fragile, and have been generating massive numbers
> >of bugreports nonstop on a daily basis since their inception.
> >
> >We'd lose a few things, like vmware, but it's not worth the threat of
> >vendors migrating en masse to NDIS/etc. emulation layers and dropping
> >all spec publication and source drivers, leaving us entirely at the
> >mercy of BBB's (Buggy Binary Blobs) to do any io whatsoever.
> >
> >Seriously, the binary-only business has been doing us a disservice, and
> >is threatening to do worse.
> >
> 
> You have to admit its good for end users though. And indirectly, what
> is good for them is good for us.

No. It is bad for the end users - they get sold a bill of goods. And
it is bad for developers. And it is bad for developers as users. And
it's hopelessly short-sighted as pragmatism often is.

Look, there's basically one thing that has ever historically enabled
developers to get specs for writing decent Linux drivers, and that's
demand from Linux users. If companies are presented with alternatives
that pointy haired folks prefer like binary-only drivers or running
their one and only Windows driver on an emulation layer, which are
they going to choose and where are they going to tell users to stick
their penguin? We'll be in worse shape than we were when no one had
ever heard of Linux.

Scenario to think about: an NDIS driver layer ends up getting firmed
up and debugged and when the next generation of wireless appears,
basically all vendors go the easy route and only ship NDIS drivers, no
specs, and buggy as usual. Then they say hey, this worked out well,
might as well do this with gigabit. Meanwhile, hardware's changing so
quickly that by the time we manage to reverse-engineer any of this
stuff (provided the legal climate allows it), it's already off the
shelves. Two to three years from now, it's impossible to build a
decent server or laptop that doesn't have bug-ridden, untested, low
performance network drivers and all the reputation Linux has for being
a good network OS goes down the tubes. It's safe to assume that
latency and stability will go all to hell as well.

An open operating system without open drivers is pointless and if we
don't do something about all this binary crap soon, the above scenario
-will- play out. Expect SCSI and perhaps sound to follow soon
afterwards. And graphics cards and modems are obviously half-way there
already. 

Personally, I think it's time to do some sort of trademark enforcement
or something so that companies can't get away with slapping penguins
on devices that only work with 2.2.14 Red Hat kernels.

--
Matt Mackall : http://www.selenic.com : Linux development and consulting
