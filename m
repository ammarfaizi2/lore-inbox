Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262053AbTCMDAf>; Wed, 12 Mar 2003 22:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262118AbTCMDAf>; Wed, 12 Mar 2003 22:00:35 -0500
Received: from almesberger.net ([63.105.73.239]:19460 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S262053AbTCMDAe>; Wed, 12 Mar 2003 22:00:34 -0500
Date: Thu, 13 Mar 2003 00:11:09 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Daniel Phillips <phillips@arcor.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Zack Brown <zbrown@tumblerings.org>, linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Message-ID: <20030313001109.Y2791@almesberger.net>
References: <200303020011.QAA13450@adam.yggdrasil.com> <20030311192639.E72163C5BE@mx01.nexgo.de> <20030312031407.W2791@almesberger.net> <20030313024421.9C6DC109407@mx12.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030313024421.9C6DC109407@mx12.arcor-online.net>; from phillips@arcor.de on Thu, Mar 13, 2003 at 03:48:17AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> Naming is a matter of taste, and you ought to be able to do it according to 
> your own taste, including hooking in your own name-generating script.

Yup, what I mean is that the system shouldn't have to depend on a
human-usable name. It's usually very hard to generate unique names
that are also human-friendly, so I think it's better not to try in
the first place. (Just look at e-mail message-ids for an example.)

> > I think, for simplicity, changesets should just carry their history
> > with them. This can later be compressed, e.g. by omitting items
> > before major convergence points (releases), by using automatically
> > generated reference points, or simply by fetching additional
> > information from a repository if needed (hairy).
> 
> I would not call that hairy, it sounds more like fun.

I called it hairy, because you need to retrieve something from a
machine that may not be available at that time. Waiting until it
comes back usually isn't a choice. Of course, this information
may be replicated on other machines that are available, and that
your repository/agent knows of, etc.

In any case, this would be an optimization. Bandwidth and disk
space are cheap, so it's not so bad to carry a few kB of history
around for each file.

> getting the underlying framework to function properly.  Larry is entirely 
> correct in pointing out that it's hard, though in my opinion, not nearly as 
> hard as kernel development.  Your edit/compile/test cycle is a fraction as 
> long for one thing.

Oh, I'd say it's an entirely different type of development. The
kernel has to deal with real-time concurrency and subtle
performance issues. An SCM can quite easily eliminate concurrency
to the point that all operations become nice, linear batch jobs
on a completely static data set. On the other hand, the SCM is
likely to work on more complex data structures, and will have a
closer interaction with what is user policy.

While performance is certainly an important issue for an SCM, I'd
expect this to be something that can be safely ignored for a good
while during development. (I'm a firm believer in the
prototype-burn-rewrite-burn_again-... type of software development.
Maybe this shows :-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
