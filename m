Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264423AbRFSQxK>; Tue, 19 Jun 2001 12:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264422AbRFSQxA>; Tue, 19 Jun 2001 12:53:00 -0400
Received: from sdsl-208-184-147-195.dsl.sjc.megapath.net ([208.184.147.195]:5923
	"EHLO bitmover.com") by vger.kernel.org with ESMTP
	id <S264423AbRFSQwo>; Tue, 19 Jun 2001 12:52:44 -0400
Date: Tue, 19 Jun 2001 09:52:39 -0700
From: Larry McVoy <lm@bitmover.com>
To: Matthew Kirkwood <matthew@hairy.beasts.org>
Cc: Larry McVoy <lm@bitmover.com>, Dan Kegel <dank@kegel.com>,
        ognen@gene.pbi.nrc.ca,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        laughing@shared-source.org
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
Message-ID: <20010619095239.T3089@work.bitmover.com>
Mail-Followup-To: Matthew Kirkwood <matthew@hairy.beasts.org>,
	Larry McVoy <lm@bitmover.com>, Dan Kegel <dank@kegel.com>,
	ognen@gene.pbi.nrc.ca,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	laughing@shared-source.org
In-Reply-To: <20010619090956.R3089@work.bitmover.com> <Pine.LNX.4.30.0106191714320.11271-100000@sphinx.mythic-beasts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.30.0106191714320.11271-100000@sphinx.mythic-beasts.com>; from matthew@hairy.beasts.org on Tue, Jun 19, 2001 at 05:26:09PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2001 at 05:26:09PM +0100, Matthew Kirkwood wrote:
> On Tue, 19 Jun 2001, Larry McVoy wrote:
> 
> >     ``Think of it this way: threads are like salt, not like pasta. You
> >     like salt, I like salt, we all like salt. But we eat more pasta.''
> 
> This is oft-quoted but has, IMO, the property of not actually
> making any sense.

Hmm.  Makes sense to me.  All it is saying is that you can't make a good
dinner out of a pile of salt.  It was originally said to some GUI people
who wanted to use a thread per object, every button, scrollbar, canvas,
text widget, menu, etc., are all threads.  What they didn't figure out is
that a thread needs a stack, the stack is the dominating space term, and
they were looking at a typical desktop with around 9,000 objects.  Times,
at that point, an 8K stack.  That was 73MB in stacks.  Pretty darned stupid
when you look at it that way, huh?

Nobody is arguing that having more than one thread of execution in an
application is a bad idea.  On an SMP machine, having the same number of
processes/threads as there are CPUs is a requirement to get the scaling
if that app is all you are running.  That's fine.  But on a uniprocessor,
threads are basically stupid.  The only place that I know of where it is
necessary is for I/O which blocks.  And even there you only need enough
to overlap the I/O such that it streams.  And processes will, and do,
work fine for that.

I think the general thrust of us ``anti-thread'' people is that a few
are fine, a lot is stupid, and the model encourages a lot.  It's just
like perl5, C++, pick-your-favorite-feature-rich-language in that
exceptional programmers will do a good job with the problem but average
programmers will do a horrible job.  Given that there are only a few
exceptional programmers and a never ending wave of average programmers,
the argument is that one should tailor the paradigm for the common case,
not for the exceptional case.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
