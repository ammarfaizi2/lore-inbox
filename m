Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132790AbRASBwy>; Thu, 18 Jan 2001 20:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132769AbRASBwo>; Thu, 18 Jan 2001 20:52:44 -0500
Received: from Cantor.suse.de ([194.112.123.193]:63761 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132656AbRASBw3>;
	Thu, 18 Jan 2001 20:52:29 -0500
Date: Fri, 19 Jan 2001 02:48:21 +0100
From: Andi Kleen <ak@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: multi-queue scheduler update
Message-ID: <20010119024821.A7634@gruyere.muc.suse.de>
In-Reply-To: <20010119012616.D32087@athlon.random> <Pine.LNX.4.10.10101181956300.8128-100000@coffee.psychology.mcmaster.ca> <20010119023502.G32087@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010119023502.G32087@athlon.random>; from andrea@suse.de on Fri, Jan 19, 2001 at 02:35:02AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 19, 2001 at 02:35:02AM +0100, Andrea Arcangeli wrote:
> On Thu, Jan 18, 2001 at 08:00:16PM -0500, Mark Hahn wrote:
> > > >                            microseconds/yield
> > > > # threads      2.2.16-22           2.4        2.4-multi-queue
> > > > ------------   ---------         --------     ---------------
> > > > 16               18.740            4.603         1.455
> > > 
> > > I remeber the O(1) scheduler from Davide Libenzi was beating the mainline O(N)
> > 
> > isn't the normal case (as in "The Right Case to optimize") 
> > where there are close to zero runnable tasks?  what realistic/sane
> > scenarios have very large numbers of spinning threads?  all server
> > situations I can think of do not.  not volanomark -loopback, surely!
> 
> This is why the numbers with 2/4/8 threads in the runqueue are the most
> interesting ones 8)

With Arjan's patch to use prefetching for the runqueue scan the numbers
will be likely different [at least on cpus that can benefit from prefetching
like p2+ or athlon] 

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
