Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293348AbSC0XEG>; Wed, 27 Mar 2002 18:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293402AbSC0XD4>; Wed, 27 Mar 2002 18:03:56 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:9395 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S293348AbSC0XDp>; Wed, 27 Mar 2002 18:03:45 -0500
Date: Wed, 27 Mar 2002 16:20:10 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        jmerkey@timpanogas.org
Subject: Re: Putrid Elevator Behavior 2.4.18/19
Message-ID: <20020327162010.A25809@vger.timpanogas.org>
In-Reply-To: <20020320120455.A19074@vger.timpanogas.org> <20020320220241.GC29857@matchmail.com> <20020320152008.A19978@vger.timpanogas.org> <20020320152504.B19978@vger.timpanogas.org> <3C9935CA.38E6F56F@zip.com.au> <20020320234552.A21740@vger.timpanogas.org> <20020325181645.A17171@vger.timpanogas.org> <20020326014219.GA3536@matchmail.com> <20020326100330.A20201@vger.timpanogas.org> <20020327070325.GA20703@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2002 at 08:03:25AM +0100, Jens Axboe wrote:
> On Tue, Mar 26 2002, Jeff V. Merkey wrote:
> > > 
> > > That's good news.
> > > 
> > > Are you still working on the A/B list patch?  I'd imagine that it could make
> > > several problems easier to fix in the block layer.
> > > 
> > 
> > Yes.  I am asking Darren Major, who wrote the A/B implementation 
> > in NetWare to review the patch before we submit it.  It may affect
> > some drivers.  We are verifying that the change I instrumented 
> > will not break anything.
> 
> I'm curious how you are doing this cleanly in 2.4. There are lots of
> places in the kernel that do direct list management on the queue_head.
> Are you adding two separate hidden lists and splicing content to the
> queue_head?

Correct.  I am still reviewing drivers and kernel code to ascertain 
whether I am not leaving any holes.  I have spliced it as a non-obtrusive 
implementation that preserves the existing code with no changes.  

Some of the drivers may have problems if they cache the head address
of the current list.

> 
> 2.5 has this done much more cleanly (of course I'm very biased). See the
> deadline I/O scheduler patch I've posted before, stuff like this can be
> done a lot cleaner there. Internal I/O scheduler structures are
> completely hidden from drivers.
> 

2.5 would be nice, but 2.4.X needs it too and this is the kernel we are 
using for our development and testing, so we will need it there.  


Jeff

