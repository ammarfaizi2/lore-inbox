Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136011AbRASBJ2>; Thu, 18 Jan 2001 20:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132539AbRASBJS>; Thu, 18 Jan 2001 20:09:18 -0500
Received: from Cantor.suse.de ([194.112.123.193]:22288 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S136332AbRASBJJ>;
	Thu, 18 Jan 2001 20:09:09 -0500
Date: Fri, 19 Jan 2001 02:08:52 +0100
From: Andi Kleen <ak@suse.de>
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: multi-queue scheduler update
Message-ID: <20010119020852.A6973@gruyere.muc.suse.de>
In-Reply-To: <20010119012616.D32087@athlon.random> <Pine.LNX.4.10.10101181956300.8128-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10101181956300.8128-100000@coffee.psychology.mcmaster.ca>; from hahn@coffee.psychology.mcmaster.ca on Thu, Jan 18, 2001 at 08:00:16PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2001 at 08:00:16PM -0500, Mark Hahn wrote:
> > >                            microseconds/yield
> > > # threads      2.2.16-22           2.4        2.4-multi-queue
> > > ------------   ---------         --------     ---------------
> > > 16               18.740            4.603         1.455
> > 
> > I remeber the O(1) scheduler from Davide Libenzi was beating the mainline O(N)
> 
> isn't the normal case (as in "The Right Case to optimize") 
> where there are close to zero runnable tasks?  what realistic/sane
> scenarios have very large numbers of spinning threads?  all server
> situations I can think of do not.  not volanomark -loopback, surely!

I think the main point of Mike's patch is decreasing locking and cache line
bouncing overhead of multi cpu scheduling, not optimizing lots of runnable tasks.


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
