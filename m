Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbWIVQY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWIVQY4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 12:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbWIVQY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 12:24:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46033 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751153AbWIVQY4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 12:24:56 -0400
Date: Fri, 22 Sep 2006 09:21:32 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Jones <davej@redhat.com>
cc: David Miller <davem@davemloft.net>, jeff@garzik.org, davidsen@tmr.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 -mm merge plans
In-Reply-To: <20060922154816.GA15032@redhat.com>
Message-ID: <Pine.LNX.4.64.0609220901040.4388@g5.osdl.org>
References: <Pine.LNX.4.64.0609211106391.4388@g5.osdl.org> <45130533.2010209@tmr.com>
 <45130527.1000302@garzik.org> <20060921.145208.26283973.davem@davemloft.net>
 <20060921220539.GL26683@redhat.com> <20060922083542.GA4246@flint.arm.linux.org.uk>
 <20060922154816.GA15032@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 22 Sep 2006, Dave Jones wrote:
> 
> Hmm. Some trees do seem to get pulled more often than others.
> Linus, is there a upper limit on the number of times you want
> to see pull requests? It strikes me as odd, so I'm wondering
> if there are some crossed wires here.

I personally prefer to not see _too_ many pull requests, since that to me 
indicates that people don't take advantage of the distributed nature of 
git, and don't let things "simmer" in their own tree for a while.

[ Side note, just to explain how I personally work: getting too many 
  requests about the same tree confuses and sometimes irritates me, since 
  I tend to "batch up" my work. For example, for the last couple of days, 
  I've been mostly in "discussion mode", and have been talking about 
  licenses and workflow issues etc.

  And then at some point (probably later today) I decide to go into "merge 
  mode" and go back to old mails I ignored and start applying them and 
  pulling from other peoples git trees. And so if my "mode switching" has 
  a longer latency than the "please pull" frequency, I end up seeing two 
  requests for the same tree during the same "merge mode" thing, which 
  just means that when I look at the older one, it no longer matches what 
  is in the tree I'm pulling from.

  I've long done this "batching" thing - it's something I eventually 
  worked out with my patch-flow with Alan, and that I think we've 
  perfected with Andrew (probably largely _because_ we worked it out with 
  Alan after a certain amount of friction ;).

  I personally at least _feel_ like I'm more efficient when I can just 
  completely switch gears, rather than having a constant trickle of 
  different things happening.

  Hopefully that explains the other side of why I prefer to not get two 
  pull requests for the same tree within days of each other - I may simply 
  not even have gotten _around_ to the first one yet, and then the second 
  one just irritates me. ]

For example, I think that project maintainers should to some degree just 
talk about their _own_ trees, rather than try to get their changes into my 
tree, and then point to that. One of the big ideas in distribution (at 
least to me) is that I'm _not_ supposed to be the "one and only", and I 
think we should aim for a situation where people who develop in certain 
specific areas can interact directly with the people who are testing the 
results, so that by the time I get a "please pull" request, most of the 
bulk of the work should hopefully already have gone through a cycle.

And all this is not even really git-centric. It's obviously what Andrew 
does with the -mm tree too - havign a certain amount of "latency" is good.

That said, the "release early, release often" thing still holds, and 
letting things wait _too_ long just means that the _only_ people who test 
it is some very specific group, and you may not see the problems that a 
bigger environment would see.

So it's a balance between "by the time you send it on, it should hopefully 
have had a day or two of testing" _and_ a "by the time you send it on you 
shouldn't have forgotten the issues and think it's old and all done".

I would _personally_ judge that if you need to push me the same tree more 
than once a week (not counting mistakes and brown-paper bugs that 
obviously happen - I'm saying "in general" here), there's likely something 
strange going on.

But at the same time, please do keep in mind thatr it's partly just a 
matter of taste, and it's also very much a matter of work habits (and 
about how active the tree is). Some people tend to work in certain ways.

I think rmk keeps his git trees in a private location (and I think it's 
because the kernel.org maintainers asked us to not mirror things out 
publicly if we didn't need to), so I think part of the reason the ARM 
trees get pushed out more actively is simply because Russell has used my 
tree as a "distribution point".

I don't think that's necessarily great, and there's been some friction 
over it ("people are waiting for this"), but it's not been a _huge_ 
problem either, so I just lump it in the "different people, different ways 
to work" pile..

			Linus
