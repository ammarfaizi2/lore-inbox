Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261907AbREPM7M>; Wed, 16 May 2001 08:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261912AbREPM7C>; Wed, 16 May 2001 08:59:02 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:32776 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261907AbREPM6y>;
	Wed, 16 May 2001 08:58:54 -0400
Date: Wed, 16 May 2001 14:58:00 +0200
From: Jens Axboe <axboe@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
Message-ID: <20010516145800.M4742@suse.de>
In-Reply-To: <Pine.LNX.4.21.0105150819420.1802-100000@penguin.transmeta.com> <01051603005402.00406@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01051603005402.00406@starship>; from phillips@bonn-fries.net on Wed, May 16, 2001 at 03:00:54AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16 2001, Daniel Phillips wrote:
> On Tuesday 15 May 2001 17:34, Linus Torvalds wrote:
> > On Tue, 15 May 2001, Neil Brown wrote:
> > > Ofcourse setting the "queue" function that __blk_get_queue call to
> > > do a lookup of the minor and choose an appropriate queue for the
> > > "real" device wont work as you need to munge bh->b_rdev too.
> >
> > What I would do is:
> >  - remove b_rdev completely.
> 
> :-) And b_rsector too?

Way ahead of you, it's gone :-)

Neither of these are part of the buffer_head as a caching entity, they
belong purely in the I/O path. I'll show code in a day or two.

> > [...]
> 
> >  - replace is with b_index
> >
> > Then, the "get_queue" functions basically end up doing the mapping of
> >
> > 	b_dev -> <queue,b_index>
> 
> To clarify, will be b_index be in the buffer_head or not?

It should not

-- 
Jens Axboe

