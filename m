Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbUE0IEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbUE0IEq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 04:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbUE0IEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 04:04:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:12182 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261718AbUE0IEl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 04:04:41 -0400
Date: Thu, 27 May 2004 01:04:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFD] Explicitly documenting patch submission
Message-Id: <20040527010409.66e76397.akpm@osdl.org>
In-Reply-To: <20040527062002.GA20872@work.bitmover.com>
References: <20040527062002.GA20872@work.bitmover.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy <lm@bitmover.com> wrote:
>
> I just read the whole thread and I can't help but wonder if you aren't
> trying to solve the 5% problem while avoiding the 95% problem.  Right now,
> because of how patches are fanned in through maintainers, lots and lots
> of patches are going into the SCM system (BK and/or CVS since that is
> derived from BK) as authored by a handful of people.  Just go look at
> the stats: http://linux.bkbits.net:8080/linux-2.5/stats?nav=index.html
> As productive as Andrew is I find it difficult to believe he has
> personally authored more than 5000 patches.  He hasn't, he doesn't
> pretend to have done so but we are not getting the authorship right.

Numerous people have asked Linus to make that small change to his scripts
but he prefers it the way it is, because the current practice better
represents how the patch got into the tree.  The authors names are in the
changelog and the submitter's name is in the SCM metadata.

The scripts which Linus uses to generate the kernel release announcements
do fish inside the changelog and do accurately represent who-did-what.

Once the Signed-off-by: thing is fully underway perhaps he'll change this,
I don't know.

The problem is that the question "how did this code get into the tree" is
usually different from "who wrote that code".  And Linus values the former.

> You currently aren't recording the original author

We are, with care.  It's in the changelogs.  Every single patch which I
didn't originate has a From: line at the start of the changelog.

> and you are trying
> to record all the people who touched the patch along the way.  If you
> can't get the easy part right what makes you think you are going to get
> the hard part right?

We've got it as Linus wants it.

If you want to enhance BK to parse the Signed-off-by: stuff, or to embed it
in some manner as a first-class thing then that'd be neat, but parsing the
changelogs will suffice I expect.

> ...
> I think it's great that you are looking for a better audit trail but
> I think it is strange that you are trying to get a perfect audit trail
> when you don't even have the basics in place.

Disagree.  When multiple people work on a patch their identities are
already captured.  The Signed-off-by: stuff changes the format and
formalises it a bit.

What we're not capturing fully is who-did-what amongst the multiple
authors, unless that is specifically itemised in the changelog.

What also tends to not be captured is that in a quite large percentage of
cases I've diddled people's patches on the way through - bugfixes,
cleanups, spelling fixes and very frequent changelog improvements.  I'll
sometimes mention that in the changelog but usually don't bother.

A purist would say "that should have been a separate changeset" but I
disagree - I'd prefer that the patch which hits the tree is a single,
complete, logical whole.  Because the quality and integrity of the
changeset is more important than precisely tracking the little fixes which
got added on the way through.
