Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265238AbVBDNA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265238AbVBDNA1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 08:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265233AbVBDNA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 08:00:26 -0500
Received: from sd291.sivit.org ([194.146.225.122]:39880 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S264736AbVBDM7z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 07:59:55 -0500
Date: Fri, 4 Feb 2005 14:01:27 +0100
From: Stelian Pop <stelian@popies.net>
To: lm@bitmover.com, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Linux Kernel Subversion Howto
Message-ID: <20050204130127.GA3467@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>, lm@bitmover.com,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <20050202155403.GE3117@crusoe.alcove-fr> <200502030028.j130SNU9004640@terminus.zytor.com> <20050203033459.GA29409@bitmover.com> <20050203193220.GB29712@sd291.sivit.org> <20050203202049.GC20389@bitmover.com> <20050203220059.GD5028@deep-space-9.dsnet> <20050203222854.GC20914@bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050203222854.GC20914@bitmover.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2005 at 02:28:54PM -0800, Larry McVoy wrote:

> > > 		CVS		BitKeeper [*]
> > > 	Deltas	235,956		280,212
> > 
> > Indeed, for now the differences are rather small. But with more and
> > more BK trees and more merges between them the proportion will raise.
> 
> Actually that's not been the case to date, it's held pretty constant
> and in fact the ratio has gotten better.  The last time we visited 
> these numbers it wasn't as good as it is today in CVS>

In fact I am looking at the number of *changesets*, not the sum of all
file revisions.

			CVS		BitKeeper
	Changesets:	26419		59220 (minus 6994 empty merges)

This isn't 16%, its more or less 50%, and this is the loss I was
complaining about.

It is true that 34% of the changesets could be recreated by analysing
the 'per file' commit logs, but the 16% are not recreatable (those
16% correspond to the case when someone makes several changes to a same
file without pushing to Linus between the two).

>> It is a bit difficult to get it right wrt renames, deletes etc, and
>> it can take quite a while to execute, but 3 man month work is a bit
>> extreme.

> I stand by the 3 month number.

If all that bothers you is the amount of work implied, I have an idea.

I could write a script which does use BK and exports the metadata into
CVS (or SVN directly), without losing any changeset information. I'll
do this for free. 

But you may consider this contrary to the 'non competitor' clause of
the BKL (clause 3d), that's why I need some authorization from you
before starting.

Also, I won't work on that if I cannot distribute the result of my work.
The distribution of the metadata is contrary to the 3 (g) clause in bkl,
so I need your authorization to distribute the resulting CVS (or SVN)
repository.

Note that for the distribution it doesn't need to be me, it could be a 
third party who would run the script and distribute the result
(kernel.org, osdl, Linus himself etc), or it could even be you if you
want to be in control.

How is that ?

> As a business strategy it was foolish.  But it wasn't a business decision,
> it was a choice that I made because I wanted to help Linus.
> 
> And it worked.  That ought to have some value in your eyes.

It has and I don't question the use of BitKeeper for the kernel 
development, as long as it is useful for it (and it is !)  and as
long as the data (with the metadata) is also available outside of BK.

>   Maybe
> enough to respect our terms.

If I didn't respect your terms I wouldn't ask for permission to do
what I want to.

Stelian.
-- 
Stelian Pop <stelian@popies.net>
