Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265921AbVBDUQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265921AbVBDUQx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 15:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265719AbVBDUQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 15:16:21 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:52934 "EHLO
	postbox.bitmover.com") by vger.kernel.org with ESMTP
	id S265605AbVBDUOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 15:14:08 -0500
Date: Fri, 4 Feb 2005 12:11:57 -0800
To: Stelian Pop <stelian@popies.net>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Linux Kernel Subversion Howto
Message-ID: <20050204201157.GN27707@bitmover.com>
Mail-Followup-To: lm@bitmover.com, Stelian Pop <stelian@popies.net>,
	linux-kernel@vger.kernel.org
References: <20050203033459.GA29409@bitmover.com> <20050203193220.GB29712@sd291.sivit.org> <20050203202049.GC20389@bitmover.com> <20050203220059.GD5028@deep-space-9.dsnet> <20050203222854.GC20914@bitmover.com> <20050204130127.GA3467@crusoe.alcove-fr> <20050204160631.GB26748@bitmover.com> <20050204170306.GB3467@crusoe.alcove-fr> <20050204183922.GC27707@bitmover.com> <20050204200507.GE5028@deep-space-9.dsnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050204200507.GE5028@deep-space-9.dsnet>
User-Agent: Mutt/1.5.6+20040907i
From: lm@bitmover.com (Larry McVoy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > So, do you think you can sign up the usual suspects to being happy with
> > this answer?
> 
> I'll let them answer themselves.

You'll need to rally them to speak up or this is going nowhere.  We
can't afford to spend engineering dollars one unhappy person at a time
to try and get you happy.  We need concensus.

> > And do you mind spelling out exactly what it is that you
> > think is being offered so there is no confusion later?
> 
> Informaly, exactly what I said before: Be able to find enough information
> in the CVS tree which would allow anybody to trace back each change
> to what was submitted by the author of the change (= patch + comment).

Yup, seems reasonable.

> How you can make this happen is another problem. The obvious way to
> implement this is using CVS branches and merges but this could be
> too much work for you.

Yeah, that's insane, CVS just isn't up to the task.  We know, we import
history from CVS to BitKeeper all the time and it is very painful.  We
probably understand the impedence mismatch better than anyone and it is
large.

> (and know I agreed at the moment), but thinking again about this I'm not
> sure anymore how "sticking the BK changeset key into the delta history"
> gives us "BK level granularity". From what I understand (but you are the
> SCM expert not me so I may be missing something) there is exactly 
> one delta per 'trunk' changeset, so if you have a file being modified
> several times on a branch you will end with one single delta which is
> the merge of the separate patches. I'm not sure how, by adding several
> 'BK changeset keys' into the log entry of the merged delta you make
> one able to resplit the delta later.

First, you have to remember that BK is capturing 96% of the deltas made
to files.  Some of those deltas get clumped into one CVS commit because
of the flattening of the graph structure.  If each delta had the
changeset key for the BK changeset to which it belonged you could 
split the coarse commit into the sub patches which happened on the
collapsed branch.  You wouldn't get 100% of the information but you'd
have 96% of it in a way that could be used for debugging, which is what
I suspect you are after.  

If that's not good enough then I'm not sure there is much point in
continuing the conversation.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
