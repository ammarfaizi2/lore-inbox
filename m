Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313731AbSDPP64>; Tue, 16 Apr 2002 11:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313732AbSDPP6z>; Tue, 16 Apr 2002 11:58:55 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:7298 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S313731AbSDPP6p>; Tue, 16 Apr 2002 11:58:45 -0400
Date: Tue, 16 Apr 2002 09:58:22 -0600
Message-Id: <200204161558.g3GFwMH10945@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        David Lang <david.lang@digitalinsight.com>,
        Vojtech Pavlik <vojtech@suse.cz>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.8 IDE 36
In-Reply-To: <Pine.LNX.4.33.0204160837530.1167-100000@penguin.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
> 
> On Tue, 16 Apr 2002, Richard Gooch wrote:
> > 
> > This gratuitous removal of features in the guise of "cleanups" is why
> > you got flamed earlier this year. I thought you'd learned :-/
> 
> Richard, have you looked at the IDE mess?

Yeah, years ago when I was adding devfs calls. I've tried to forget
about it since then...

> Also note that performance is likely to _increase_ by removing that
> stupid feature - using DMA to do the actual IO and them byteswapping
> in some higher level than the driver is likely to be a _lot_ faster
> than doing PIO (and byteswap in-place, resulting in random mmap
> corruption).

I'm actually not that concerned about performance for this case,
because it's not a common operation. If we had some kind of loop
driver that supported partitioning then I'd be satisfied. In fact, I
agree that would probably be better.

What I object to is the removal of a feature that people depend on,
*without a replacement being made available prior to removal*. If you
want to remove a feature, build the replacement *first*. Don't remove
the feature and say "the rest of you can pick up the pieces".

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
