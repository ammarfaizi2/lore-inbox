Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319588AbSIHJzL>; Sun, 8 Sep 2002 05:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319589AbSIHJzL>; Sun, 8 Sep 2002 05:55:11 -0400
Received: from gate.in-addr.de ([212.8.193.158]:51206 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S319588AbSIHJzK>;
	Sun, 8 Sep 2002 05:55:10 -0400
Date: Sun, 8 Sep 2002 11:59:33 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] mount flag "direct"
Message-ID: <20020908095933.GC24476@marowsky-bree.de>
References: <20020907211452.GA24476@marowsky-bree.de> <200209080923.g889Ndp03091@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200209080923.g889Ndp03091@oboe.it.uc3m.es>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-09-08T11:23:39,
   "Peter T. Breuer" <ptb@it.uc3m.es> said:

> > do it if you don't know what the node had been working on prior to its
> > failure.
> Yes we do. Its place in the topology of the network dictates what it was
> working on, and anyway that's just a standard parallelism "barrier"
> problem.

I meant wrt what is had been working on in the filesystem. You'll need to do a
full fsck locally if it isn't journaled. Oh well.

Maybe it would help if you outlined your architecture as you see it right now.

> > Well, you are taking quite a risk trying to run a
> > not-aimed-at-distributed-environments fs and trying to make it distributed
> > by force. I _believe_ that you are missing where the real trouble lurks.
> There is no risk, because, as you say, we can always use nfs or another off
> the shelf solution. 

Oh, so the discussion is a purely academic mind experiment; it would have been
helpful if you told us in the beginning.

> But 10% better is 10% more experiment for each timeslot
> for each group of investigators.

> > What does this supposed "flexibility" buy you? Is there any real value in
> > it
> Ask the people ho might scream for 10% more experiment in their 2 weeks.

> > > You mean "what's wrong with X"? Well, it won't be mainstream, for a start,
> > > and that's surely enough.
> > I have pulled these two sentences out because I don't get them. What "X" are
> > you referring to?
> Any X that is not a standard FS. Yes, I agree, not exact.

So, your extensions are going to be "more" mainstream than OpenGFS / OCFS etc?
What the hell have you been smoking?

It has become apparent in the discussion that you are optimizing for a very
rare special case. OpenGFS, Lustre etc at least try to remain useable for
generic filesystem operation.

That it won't be mainstream is wrong about _your_ approach, not about those
"off the shelves" solutions.

And your special "optimisations" (like, no caching, no journaling...) are
supposed to be 10% _faster_ overall than these which are - to a certain extent
- from the ground up optimised for this case?

One of us isn't listening while clue is knocking. 

Now it might be me, but then I apologize for having wasted your time and will
stand corrected as soon as you have produced working code.

Until then, have fun. I feel like I am wasting both your and my time, and this
isn't strictly necessary.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Immortality is an adequate definition of high availability for me.
	--- Gregory F. Pfister

