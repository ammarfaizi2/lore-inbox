Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266693AbVBDU3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266693AbVBDU3g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 15:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265196AbVBDUND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 15:13:03 -0500
Received: from sd291.sivit.org ([194.146.225.122]:39072 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S264150AbVBDUFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 15:05:20 -0500
Date: Fri, 4 Feb 2005 21:05:07 +0100
From: Stelian Pop <stelian@popies.net>
To: lm@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Linux Kernel Subversion Howto
Message-ID: <20050204200507.GE5028@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>, lm@bitmover.com,
	linux-kernel@vger.kernel.org
References: <200502030028.j130SNU9004640@terminus.zytor.com> <20050203033459.GA29409@bitmover.com> <20050203193220.GB29712@sd291.sivit.org> <20050203202049.GC20389@bitmover.com> <20050203220059.GD5028@deep-space-9.dsnet> <20050203222854.GC20914@bitmover.com> <20050204130127.GA3467@crusoe.alcove-fr> <20050204160631.GB26748@bitmover.com> <20050204170306.GB3467@crusoe.alcove-fr> <20050204183922.GC27707@bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050204183922.GC27707@bitmover.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2005 at 10:39:22AM -0800, Larry McVoy wrote:

> > > I suppose what we could do is stick the BK changeset key into the 
> > > delta history so that if you really wanted to get the BK level
> > > granularity you could.
> > 
> > This would be nice indeed and I think it would end up all whinning
> > since using that, one could be able to get the full history from the
> > bkcvs repository. But would you do that ?
> 
> You get a commitment from the group of BK complainers that that is good 
> enough and we'll do it.  It may take a while because in the current way
> that BK stores metadata it would be prohibitively expensive.  But we
> want to change that anyway so we can prototype it on an internal tree
> and see how well it works.
> 
> If/when we do this we'll reexport the 2.4 and 2.5 histories from scratch
> so you get the info going backwards in time.

If we find enough information in the CVS tree which would allow
anybody to trace back each change to what was submitted by the author
of the change (this being a GNU patch and a patch comment), this
would be perfect for me. I can't speak for the 'group of BK 
complainers' but I can't see a *technical* reason why they would
disagree with this.

> So, do you think you can sign up the usual suspects to being happy with
> this answer?

I'll let them answer themselves.

> And do you mind spelling out exactly what it is that you
> think is being offered so there is no confusion later?

Informaly, exactly what I said before: Be able to find enough information
in the CVS tree which would allow anybody to trace back each change
to what was submitted by the author of the change (= patch + comment).

How you can make this happen is another problem. The obvious way to
implement this is using CVS branches and merges but this could be
too much work for you.

You said before that:
> > I suppose what we could do is stick the BK changeset key into the 
> > delta history so that if you really wanted to get the BK level
> > granularity you could.
(and know I agreed at the moment), but thinking again about this I'm not
sure anymore how "sticking the BK changeset key into the delta history"
gives us "BK level granularity". From what I understand (but you are the
SCM expert not me so I may be missing something) there is exactly 
one delta per 'trunk' changeset, so if you have a file being modified
several times on a branch you will end with one single delta which is
the merge of the separate patches. I'm not sure how, by adding several
'BK changeset keys' into the log entry of the merged delta you make
one able to resplit the delta later.

What am I missing here ?

Thanks,

Stelian.
-- 
Stelian Pop <stelian@popies.net>
