Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311057AbSCMTWt>; Wed, 13 Mar 2002 14:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311059AbSCMTWm>; Wed, 13 Mar 2002 14:22:42 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:18451 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S311057AbSCMTWL>; Wed, 13 Mar 2002 14:22:11 -0500
Message-ID: <3C8FA65E.484B47A7@zip.com.au>
Date: Wed, 13 Mar 2002 11:19:58 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Andrea Arcangeli <andrea@suse.de>, wli@holomorphy.com,
        wli@parcelfarce.linux.theplanet.co.uk,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org, hch@infradead.org,
        phillips@bonn-fries.net
Subject: Re: 2.4.19pre2aa1
In-Reply-To: <20020313115713.E1703@dualathlon.random> <Pine.LNX.4.44L.0203131050440.2181-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Wed, 13 Mar 2002, Andrea Arcangeli wrote:
> > On Wed, Mar 13, 2002 at 08:30:55AM +0100, Andrea Arcangeli wrote:
> > >  {
> > >     clear_bit(BH_Wait_IO, &bh->b_state);
> > >     clear_bit(BH_Lock, &bh->b_state);
> > > +   clear_bit(BH_Launder, &bh->b_state);
> > >     smp_mb__after_clear_bit();
> > >     if (waitqueue_active(&bh->b_wait))
> >
> > actually, while refining the patch and integrating it, I audited it some
> > more carefully and the above was wrong,
> 
> It's complex.
> 
> Would there be a way to simplify the thing so the author
> of the code can at least get it right and there's a chance
> of other people understanding it too ? ;)

I'll be documenting the BH state bits, and sync_page_buffers(),
when it settles down.

> ...
> <insert bitkeeper endorsement here>

You should lubricate it first.

-
