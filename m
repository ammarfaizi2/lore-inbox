Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261949AbUJYXgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261949AbUJYXgW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 19:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbUJYXdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 19:33:13 -0400
Received: from zeus.kernel.org ([204.152.189.113]:7868 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262034AbUJYX2g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 19:28:36 -0400
Date: Mon, 25 Oct 2004 16:01:28 -0700
From: Larry McVoy <lm@bitmover.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Larry McVoy <lm@bitmover.com>,
       akpm@osdl.org
Subject: Re: BK kernel workflow
Message-ID: <20041025230128.GA1232@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jon Smirl <jonsmirl@gmail.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Larry McVoy <lm@bitmover.com>, akpm@osdl.org
References: <20041023161253.GA17537@work.bitmover.com> <4d8e3fd304102403241e5a69a5@mail.gmail.com> <20041024144448.GA575@work.bitmover.com> <4d8e3fd304102409443c01c5da@mail.gmail.com> <20041024233214.GA9772@work.bitmover.com> <20041025114641.GU14325@dualathlon.random> <1098707342.7355.44.camel@localhost.localdomain> <20041025133951.GW14325@dualathlon.random> <20041025162022.GA27979@work.bitmover.com> <9e47339104102511182f916705@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e47339104102511182f916705@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 02:18:43PM -0400, Jon Smirl wrote:
> On Mon, 25 Oct 2004 09:20:22 -0700, Larry McVoy <lm@bitmover.com> wrote:
> > That's strange, I wonder why you think BK doesn't help.  The prevailing
> > wisdom is that it has helped.  It's well documented by third parties
> > who have nothing to do with you or me.
> 
> >From what I see BitKeeper has definitely helped the kernel development
> processes. On the other hand BitKeeper has been stable for the last
> couple of years. Are we going to see any large changes in BK any time
> soon? For example BK could be extended to handle the workflow AndrewM
> does. Another extension would be for moving signed patches through the
> system to help avoid another SCO problem. Any hints on where the
> future is going? Can BK be extended to further automate the kernel
> development workflow?

While BK has been stable that doesn't mean it is even remotely close to
being done.  We've got more people working on BK now than ever before.
I think you might be used to scm systems sucking so you look at BK and
say it's better therefor it's done.  We don't agree.

Things we are working on include performance (Wayne has a hot cache
linux-2.5 tree consistency check down to around 2 seconds, that's
about a 10x improvement over what it is now), we're revamping the GUIs
to be useable by normal humans, we're working on scaling to >500,000
changesets in one tree, we're working on scaling the number of files and
source to millions of files and GB of source (we just had to recompile
with largefile support for a customer this weekend, while it worked,
we thought the performance on a 2GB file was pathetic, it is pathetic,
it should run at the platter speed but as I dug into I found it out
wasn't that easy), we're working bug database integration, we're working
on review queues, we're working on project management, we're working on
large binary management, etc.

The list goes on, if anyone wants to come work on it we are always looking
for good systems people and we pay well.  Try userland, you might like it :)

As for digital signatures, we quietly added that a long time ago,
every push by Linus or Marcelo to bkbits.net is digitally signed twice,
once over all the data including BK metadata and once over the checked
out files.  The reason we do both is so people not using BK can verify
the signatures.  If you want to be on the mailing list which gets these
signatures send me mail, if I get swamped I'll push it over to mailman.
Right now they go to Linus, Ted T'so, AndrewM, and Marcelo.  They should
go more places so we have more people who can archive them in case 
something goes wrong.

As for handling AndrewM's workflow, we're very interested in that
area because there seems to be a sort of bimodal development model,
changes which are not yet "frozen" (best managed by something like
quilt it seems) and changes which are frozen (best managed by BK).
We do well at part of it and suck at the other part.  I've always 
excepted arch to come into use for the unfrozen part but for some
reason people seem to like quilt better.  I haven't played with 
quilt enough to know why yet.

The unfrozen management works for Adrew because he is doing all the work,
the tools help as much as they can but he is really very much in control.
That model doesn't scale to a distributed/replicated development model, at
least it doesn't scale as well as BK scales, it scales as well as diff &
patch & wiggle scale.  For Andrew, it's more or less fine, but if Andrew
tried to scale that to a few hundred developers all doing additional
work on the moving target of patches he'd go nuts.  As it is I can't
imagine how he doesn't go nuts.

We'd like to handle it better and I've had conversations with various
people over the years and so far no lightbulb has come on.  If there is
one, we'll find it, some of the problems we solved in BK felt sort of
similar and had to cook for around 3 years before the lightbulb came on.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
