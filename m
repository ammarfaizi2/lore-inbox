Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261550AbUJXRpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261550AbUJXRpH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 13:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbUJXRpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 13:45:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:7844 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261550AbUJXRoz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 13:44:55 -0400
Date: Sun, 24 Oct 2004 10:44:44 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
cc: Larry McVoy <lm@work.bitmover.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>, akpm@osdl.org
Subject: Re: BK kernel workflow
In-Reply-To: <4d8e3fd304102403241e5a69a5@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0410241027320.13209@ppc970.osdl.org>
References: <41752E53.8060103@pobox.com>  <20041019153126.GG18939@work.bitmover.com>
  <41753B99.5090003@pobox.com>  <4d8e3fd304101914332979f86a@mail.gmail.com>
  <20041019213803.GA6994@havoc.gtf.org>  <4d8e3fd3041019145469f03527@mail.gmail.com>
  <Pine.LNX.4.58.0410191510210.2317@ppc970.osdl.org>  <20041023161253.GA17537@work.bitmover.com>
 <4d8e3fd304102403241e5a69a5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 24 Oct 2004, Paolo Ciarrocchi wrote:
> 
> Well, I'm not interested in having the list of all the bk trees used
> during the develpoment of a release.
> I was looking to the trees used by mantainers.

Well, not only is "maintainer" fairly fluid, as Larry said, even if you 
accept the fact that things will change, there's the issue that

 - I do _not_ want people to "own" subsystems. And that's not so much an 
   anti-maintainer issue (I _love_ maintainers), as more of a "conceptual" 
   issue. When people expect one person or one group of person to be the 
   only way to touch a certain subsystem, we have problems. I really 
   really want everybody (users, developers _and_ maintainers) to realize 
   that no code is an island, and work with other people touching their 
   subsystem.

   And part of that is that I do not like codifying maintainership. Even 
   something as simple as saying "this tree is the xxxx tree" is in my 
   opinion _bad_. Yes, a lot of core development for subsystems happen in 
   some specific "subsystem tree", but every time that has turned into 
   something "exclusive", it's been a _major_ problem.

   And yes, we've had that problem several times. People having CVS trees 
   for networking, sound drivers, and other special development 
   subprojects invariably ended up breakign and throwing away work that 
   happened "unofficially". And often the "unofficial" work is nearly as 
   important as the official one.

   So BK helps this model, because the distributed nature of BK means that 
   you can have several pseudo-official trees _and_ totally unofficial
   ones, and merging is automatic and basically impossible to avoid, so 
   the "official" tree never gets to drown out the unofficial work. But 
   despite that, I want to make people _aware_ that maintainership does
   not imply total ownership, and that we don't have a "hierarchy" of 
   developers but a *network* of developers.

   To make a long story short: I do not ever even WANT "official" trees. 
   Because it gives the wrong idea to people.

   I don't know if you've noticed, but I try to encourage other people to
   make their own version of _my_ "official" tree, and unlike pretty much
   all other open source projects I'm aware of, the Linux kernel
   development model has always encouraged things like the "Alan Cox" tree
   or "Andrew Morton" tree or "Andrea Arcangeli" tree. Or all the vendor 
   trees.

   Many other projects try to control "the one true tree". Linux never 
   really did, and for the last several years it's been a conscious
   decision for me to _encourage_ people to do their own trees. Exactly 
   because I don't want people to think that there are any really official
   trees. My tree perhaps comes closest, but even I don't expect to be the 
   "final word on Linux".

   This keeps us all honest.

Second, and less fundamentally:

 - Even if we had "official maintainers" (and at any one time, certain 
   sub-areas certainly tend to have pretty strong maintainership), those 
   maintainers tend to have pretty fluid trees of their own, and they
   change pretty dynamically.

   Look at how trees are merged, and you'll notice that several 
   maintainers did a special "merge these things for 2.6.9" tree that
   contained the stuff that they wanted to push out quickly, and that I
   merged for just that release. It was basically a "throw-away" tree that
   got used once.

   This happens all the time, and again, I _like_ it. It means that people 
   can react a lot more dynamically to what is going on. Again, having a 
   documented "list of trees" would not make this kind of thing
   technically impossible, but it would foster the wrong kind of "mental
   landscape".

See what I'm saying? It all boils down to the fact that I really like 
having a dynamic development model, and that I want to try to avoid 
putting in mental road-blocks to that model. I want Linux development to 
be fluid, and I think the best way to reach that goal is to make people 
_think_ of it as being fluid.

It's the old "perception changes reality" thing. It's really true. How you 
think about something quite heavily influences what you do.

Wow. That was deep. Time to go watch TV again.

		Linus
