Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965155AbVKGUt1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965155AbVKGUt1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 15:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbVKGUt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 15:49:26 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:18698 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932349AbVKGUtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 15:49:25 -0500
Date: Mon, 7 Nov 2005 21:34:50 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christopher Friesen <cfriesen@nortel.com>,
       Krzysztof Halasa <khc@pm.waw.pl>, Eric Sandall <eric@sandall.us>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Tony Luck <tony.luck@gmail.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: New (now current development process)
Message-ID: <20051107203450.GA8660@alpha.home.local>
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com> <12c511ca0510291157u5557b6b1x85a47311f0e16436@mail.gmail.com> <20051029195115.GD14039@flint.arm.linux.org.uk> <Pine.LNX.4.64.0510291314100.3348@g5.osdl.org> <20051031064109.GO22601@alpha.home.local> <Pine.LNX.4.63.0511062052590.24477@cerberus> <m3k6fkxwqe.fsf@defiant.localdomain> <436F8ABE.9020605@nortel.com> <Pine.LNX.4.64.0511070915350.3193@g5.osdl.org> <Pine.LNX.4.64.0511070922370.3193@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511070922370.3193@g5.osdl.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

you made valid points, you know your public very well :-)
However, I have an objection on one point below.

On Mon, Nov 07, 2005 at 09:28:35AM -0800, Linus Torvalds wrote:
> On Mon, 7 Nov 2005, Linus Torvalds wrote:
> > 
> > So repeat after me: "Most people never test -rc kernels". 
> 
> Btw, the ones that _do_ test -rc kernels usually don't test all of them. 

That's true at least for me, except that I *try* to test *ALL* versions which
are announced as the most likely future -final. When Marcelo tells us that
-rc2 will be -final if nobody complains, I really test it. I build it on
several archs and try to catch stupid bugs because I hate stupid bugs in
final releases, they pollute bug reports (worst ones being build errors).

However, when he announces -preX (X>1) or when you annonce any -rc which
is not likely to become -final, I just check the changelog, and build it
if I both see something which applies to my setup, and I have nothing else
to do.

When I ask you to turn -rc into -final, it's not just to avoid adding
new bugs (eventhough the most quickly fixed bugs may be the most dangerous),
but it's mainly to add credibility to the call so that many people who would
be hesitant will try it.

> The current model is set up in a way where there is _one_ special -rc 
> kernel that we should try to get people to test: the first one.
>
> That hopefully encourages people to try an -rc kernel who might otherwise 
> decide that there's too many -rc kernels to bother with. If they know that 
> all of the real development happened before -rc1, they also are thus aware 
> that it doesn't really matter which -rc kernel they test, so just testing 
> _one_ is very good indeed.

Agreed too. That's the same reason I asked Marcelo if he would agree to
merge all the uncertain recent mcast fixes early in 2.4.33-pre1.

> The first -rc kernel is also special in another way: it's the one we 
> "wait" for. It's the one that happens after two weeks, and has a deadline. 
> The others happen more frequently, and are really objectively less 
> important than the first one.
> 
> (In contrast, some other projects try to make the _last_ -rc be the 
> important one. That's totally the wrong way around, because if there are 
> more people testing the last one, the testing happens at _exactly_ the 
> wrong point in time from a "let's fix the problems" standpoint)

Are there really projects managed like this ? I hope I don't use anything
from them !!!

> So the call to people who can be bothered to test at all: if you 
> only test one -rc kernel, please test the first one. That way we get a 
> heads-up on problems earlier.

Agreed here too from the developper standpoint. However, your final release
are references for all trees. It's better if the common ancestor between
many trees at least builds and does not propagate one horrible bug discovered
10 minutes after release. The least differences there are in code base between
tree, the most relevant the bug reports are. And yes, I know that there is
-stable for this, but most people don't know about it and will simply build
the 2.6.15 announced on slashdot then be the 100th to complain that 2.6.15
does not build because of this or that. (I hope it will not happen :-))

> (And if you like testing -rc kernels, please test all of them. Or even the 
> nightly snapshots. Or track the git tree several times a day. The more, 
> the merrier, but if you only want to boot one kernel a month, make it be 
> the -rc1 kernel).

I consider two rcs as important :
  - the first one, to test bugs in features
  - the last one to increase the signal/noise ration in bug reports.

Then it makes sense to test them both. However, I agree that if only one can
be tested, the first one is most interesting to us.

> 			Linus

Regards,
Willy

