Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262042AbTCLWNA>; Wed, 12 Mar 2003 17:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262044AbTCLWNA>; Wed, 12 Mar 2003 17:13:00 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:40435 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S262042AbTCLWM5>; Wed, 12 Mar 2003 17:12:57 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Larry McVoy <lm@bitmover.com>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org
Date: Wed, 12 Mar 2003 14:21:49 -0800 (PST)
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
In-Reply-To: <20030312220156.GE30788@work.bitmover.com>
Message-ID: <Pine.LNX.4.44.0303121409300.11045-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

and if you did real-time updates but once a month or so redid the
'longest-path' thing that would change the CVS version info, correct?

David Lang

On Wed, 12 Mar 2003, Larry McVoy wrote:

> Date: Wed, 12 Mar 2003 14:01:56 -0800
> From: Larry McVoy <lm@bitmover.com>
> To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
> Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
> Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
>
> On Wed, Mar 12, 2003 at 03:45:39PM -0600, Kai Germaschewski wrote:
> > On Wed, 12 Mar 2003, Larry McVoy wrote:
> >
> > > > Larry, this brings up something I was meaning to ask you before this
> > > > thread exploded.  What happens to those "logical change" numbers over
> > > > time?
> > >
> > > They are stable in the CVS tree because the CVS tree isn't distributed.
> > > So "Logical change 1.900" in the context of the exported CVS tree is
> > > always the same thing.  That's one advantage centralized has, things
> > > don't shift around on you.
> >
> > Isn't there a more general problem, though? (I hope I'm wrong)
> >
> > You want to update the CVS tree near-realtime. However, the longest-path
> > through your graph may change with new merges, but CVS of course cannot
> > cope with already committed data changing (already committed csets may
> > all of a sudden not be in the longest path anymore)? This is a CVS
> > limitation, of course, but still a problem AFAICS.
>
> Yup, you're right, there is a tradeoff between real time updates and
> best path.  We've already seen it in incremental updates.
>
> We were talking about this internally when your mail came in.  I suspect
> it isn't really a problem in practice because we can always redo the
> entire export from scratch and get an optimal path.
>
> Wayne pointed out that in the cases where it collapses a pile of csets
> that is usually because Linus pulled some wad from somebody and one could
> argue the collapse is a good thing.  But it depends, sometimes it is and
> sometimes it isn't.  Our commercial users have frequently asked for a
> way to "collapse the tree and clean up the noise in the graphs", in fact,
> one called this morning and said "that BK to CVS thing, could that be a BK
> to cleaner-BK thing?" so opinions vary on what is the perfect granularity.
>
> My belief is that the real time updates is something that people value
> more than the granularity.  You guys can vote and if you reach agreement
> we'll do what you want.
> --
> ---
> Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
