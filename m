Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbTL2Bvn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 20:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbTL2Bvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 20:51:43 -0500
Received: from tolkor.SGI.COM ([198.149.18.6]:34231 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S262283AbTL2Bvk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 20:51:40 -0500
Message-ID: <3FEF7F13.4D598171@sgi.com>
Date: Sun, 28 Dec 2003 19:10:44 -0600
From: Colin Ngam <cngam@sgi.com>
Organization: SGI
X-Mailer: Mozilla 4.79C-SGI [en] (X11; I; IRIX 6.5 IP32)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Pat Gefre <pfg@sgi.com>, akpm@osdl.org, davidm@napali.hpl.hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Updating our sn code in 2.6
References: <20031220122749.A5223@infradead.org> <Pine.SGI.3.96.1031222204757.20064A-100000@fsgi900.americas.sgi.com> <20031223090227.A5027@infradead.org> <3FE85533.E026DE86@sgi.com> <20031223165506.A8624@infradead.org> <3FEC8F0B.A8C30677@sgi.com> <20031228144415.B20391@infradead.org> <3FEF05B2.9184ABA0@sgi.com> <20031228172214.B21182@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

Hi Christoph,

> On Sun, Dec 28, 2003 at 10:32:51AM -0600, Colin Ngam wrote:
> > > the now almost legacy SHUB/PIC based Altixens?  Well, even if SGI does this
> >
> > SHUB/PIC based Altixens are not Legacy in any form shape or manner.  I expect
> > these IO Chipsets to drive Altix for the foreseable near future ..
>
> Well, it looks like TIO is replacing it soon, doesn't it?

I am not privy to that kind of information.  SGI has always
maintained and supported systems with more than 1 IO Chipset on
the same system.  So, we will have SHUB/PIC and TIO IO
Chipset on the same system once TIO goes into production.


>
>
> > Please do not question my resolve to drive us towards this direction.  Things can
> > always change, but I am heading this direction.
>
> Well, again talk is cheap, if you show the code this whole discussion
> would be avoid.  I've done my part of showing the code and the only thing
> I get in reply is bad flames and random obsfucations to break that code.

All I am saying is that we have an effort going towards that direction.  I
am trying to work with you, letting you know ahead of time what is coming
down so that future effort you are expanding is not wasted.

>
>
> > architecture.  That is not a problem at all.  For ia64 Altix line, we want
> > to follow what's being done on other ia64 platform.  Is this not the
> > right approach?  You yourself had mentioned above that this is the
> > way to go?
>
> Again, I'd be more than happy if you moved that code to the PROM.  But as
> long as we have code in the kernel to deal with that hardware different ports
> should share it.  And as mentioned above I have that strong feeling that
> for the first generation Altixens this is never going to happen.  Of course
> I'd be more than happy to be proven wrong.

I am not out to prove you right or wrong - that is irrelevent.  We are not moving
code to Prom, we are enhancing our current functionality in Prom so that
we will not need these code in the Linux kernel anymore.  Prom already
has most of these functionalities.

>
>
> > This code sharing will not be possible when we do all of our initialization
> > in System BIOS, just like every other ia64 platform.
>
> Again, if you do that I'd be more than happy.  But as long as we need that
> code in the kernel it should be done properly.
>
> > Moreover, the ia64
> > Altix line does not support Bridge/Xbridge chipsets and we do not want
> > to be burdened by these legacy code as we move forward with the ia64
> > product line.
>
> Guess what, the current iommu code has exactly three lines of code that
> make sense only for bridge.  Not to mention that I'll have no problem with
> maintaining all that code, so you don't have to maintain more but rather
> less code.  (In a double sense, given that the new code is also much
> smaller despite support for the older revisions).

I will have a problem, if SGI is not the maintainer of our IO Chipset code for
ia64/Altix.  When this is done, there will be very little kernel code left
to be maintained anyway.  It will make life much better for us all, as we can
concentrate on other parts of the kernel.

I believe we have beaten this topic to death now.  You know what we are trying
to accomplish - that is to follow as closely as possible the current methodology
ia32/ia64 platforms are using for platform initialization - in System BIOS and
ACPI.  This will enable us to yank a tremendous amount of code from the
kernel, making sn2 only and also Generic ia64 kernel much smaller, and the
sn2 platform specific code much easier to maintain and understand.

It would have been very rude of us, not to inform you of our plans, given the fact
that you have shared your intention.  That would just waste your time.

Thanks.

colin

>

>

>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

