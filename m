Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130113AbRBFTdP>; Tue, 6 Feb 2001 14:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129840AbRBFTdF>; Tue, 6 Feb 2001 14:33:05 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:26897 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S130112AbRBFTc4>;
	Tue, 6 Feb 2001 14:32:56 -0500
Date: Tue, 6 Feb 2001 20:32:19 +0100
From: Jens Axboe <axboe@suse.de>
To: Ben LaHaise <bcrl@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, "Stephen C. Tweedie" <sct@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
Message-ID: <20010206203219.A2975@suse.de>
In-Reply-To: <Pine.LNX.4.30.0102061955380.7919-100000@elte.hu> <Pine.LNX.4.30.0102061402200.15204-100000@today.toronto.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0102061402200.15204-100000@today.toronto.redhat.com>; from bcrl@redhat.com on Tue, Feb 06, 2001 at 02:11:23PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06 2001, Ben LaHaise wrote:
> > > 	- make asynchronous io possible in the block layer.  This is
> > > 	  impossible with the current ll_rw_block scheme and io request
> > > 	  plugging.
> >
> > why is it impossible?
> 
> s/impossible/unpleasant/.  ll_rw_blk blocks; it should be possible to have
> a non blocking variant that does all of the setup in the caller's context.
> Yes, I know that we can do it with a kernel thread, but that isn't as
> clean and it significantly penalises small ios (hint: databases issue
> *lots* of small random ios and a good chunk of large ios).

So make a non-blocking variant, not a big deal. Users of async I/O
know how to deal with resource limits anyway.

-- 
Jens Axboe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
