Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbWIKRjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWIKRjc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 13:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWIKRjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 13:39:31 -0400
Received: from nef2.ens.fr ([129.199.96.40]:56838 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S1751290AbWIKRjb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 13:39:31 -0400
Date: Mon, 11 Sep 2006 19:39:12 +0200
From: David Madore <david.madore@ens.fr>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: capability inheritance (was: Re: patch to make Linux capabilities into something useful (v 0.3.1))
Message-ID: <20060911173912.GA6079@clipper.ens.fr>
References: <20060910142540.GA19804@clipper.ens.fr> <20060911160002.78419.qmail@web36614.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060911160002.78419.qmail@web36614.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Mon, 11 Sep 2006 19:39:12 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2006 at 09:00:02AM -0700, Casey Schaufler wrote:
> --- David Madore <david.madore@ens.fr> wrote:
> > I can see no way of reconciling the POSIX rules with
> > sane Unix behavior.
> 
> While one strives to maintain the decorum of
> friendly debate, "Them's fighting words"*.

I am sorry if you find this offensive, but, with due respect to the
editor, I find the POSIX draft's description of the capability
inheritance mechanism in general and its rational or its interaction
with norma Unix mechanisms in particular (a) highly unclear and (b)
entirely unconvincing.

> Have you read the POSIX DRAFT rationale section?

Yes.  At least, I have read the version made available, through you,
at <URL: http://wt.tuxomania.net/publications/posix.1e/download.html
 >, which seems to be draft 17.  I don't have access to any earlier
draft (nor do I wish to discuss documents which aren't publicly
available for download).

I fail to see, however, where the rationale section gives a
justification for the exact inheritance rules which were chosen:
section B.25.2.6, for example, is extremely vague and only describes
the rules rather than justifying them.  Setion B.25.6 gives a few
examples of use, but no better.  I see no real explanation of the
rules themselves, let alone any explanation why they are better than
any other system.  Could you state, precisely, what you think is wrong
with the semantics I advocate?

(Not to mention the fact that I find the "principle of least
privilege", as stated in section B.25.1, of rather dubious value.
This sounds exactly like a sort of general principle which sounds nice
in general but which becomes disastrous when you actually try to apply
it systematically.)

> Have you read any of the DRAFT, for that matter?

I can't deny that it is hard to read, being essentially a diff to
another document which is, itself, hard to find and hard to read.  And
I certainly haven't read the sections on auditing, etc.

If there's a specific part you think I missed, please give its
reference rather than just waving a several-hundred-page document at
me.

> Breaking privilege apart from UID==0 and the
> setuid mechanism while allowing a system that
> could still work without requiring programs
> to be rewritten took quite a while. The DRAFT
> versions don't differ that greatly after about
> DRAFT 12. The scheme has been implemented
> several times.

If you have any pointers to documentations describing specific
implementations, I am certainly interested.

> The relationship between setuid and file based
> capabilitiy sets is straitforward. There is
> none.

That won't do: that could mean several things, including at least: (a)
processes are given the ability to do <whatever> when they have
*either* EUID==0 *or* the appropriate capability, (b) processes
having, at any time, EUID==0 are automatically given full capability
sets, (c) processes exec()uted with EUID==0 are automatically given
full capability sets,...  I can think of a million different ways of
having "no" relationship.  Which is it?  It would seem that (a) is the
most likely meaning, but this contradicts the way Linux has
implemented capabilities so far (it only checks the capability sets,
not EUID).

>	If your system supports root or capability
> (like Irix) or strictly capability (like Trix)
> the calculation is identical. There is a full
> descrition of the rules in the DRAFT. If you
> have questions about it, I'd be happy to dust
> off my copy to help you understand it.

I am interested in a description of how to reconcile Unix semantics
with POSIX capabilities, but I find it nowhere in the draft.  So I
would appreciate it if you could point me to the very precise place
where I am supposed to find it or, better, explain it with less
legalese than the draft uses (but just as precisely).  A pointer to a
description of how other implementations solve the problem would also
be welcome.

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.madore.org/~david/ )
