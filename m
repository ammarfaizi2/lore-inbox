Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261841AbVCCRzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbVCCRzi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 12:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262532AbVCCRyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 12:54:55 -0500
Received: from iabervon.org ([66.92.72.58]:11270 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261841AbVCCRva (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 12:51:30 -0500
Date: Thu, 3 Mar 2005 12:52:52 -0500 (EST)
From: Daniel Barkalow <barkalow@iabervon.org>
To: Linus Torvalds <torvalds@osdl.org>
cc: Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>,
       "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
In-Reply-To: <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.21.0503031226430.30848-100000@iabervon.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Mar 2005, Linus Torvalds wrote:

>  - some very _technical_ and objective rules on patches. And they should 
>    limit the patches severely, so that people can never blame the sucker 
>    who does the job. For example, I would suggest that "size" be one hard 
>    technical rule. If the patch is more than 100 lines (with context) in
>    size, it's not trivial any more. Really. Two big screenfuls (or four, 
>    for people who still use the ISO-ANSI standard 80x24 vt100)

One thing that's worth pointing out is that sometimes the 20-line patch is
sufficient to solve the problem, but is lousy code. That's fine for a tree
that will be frozen in a couple of months after only getting little fixes
to other files, but mainline should get a real fix, which wouldn't be
acceptable in the sucker tree. So 2.6.(x+1) shouldn't automatically get
2.6.x.y. Should reverting a 200-line patch which turned out to need
another 200 lines to work be acceptable?

>    Also, I'd suggest that a _hard_ rule (ie nobody can override it) would 
>    also be that the problem causes an oops, a hang, or a real security
>    problem that somebody can come up with an exploit for (ie no "there
>    could be a two-instruction race" crap. Only "there is a race, and
>    here's how you exploit it"). The exploit wouldn't need to be full code 
>    that gets root, but an explanation of it, at least.

Similar rule for driver patches: you can patch a driver if it makes the 
device not work (but you couldn't patch the core)?

> Does this mean that some patches would never go into this tree? Yes. It
> would mean that patches that some people might feel very _strongly_ are
> good patches would never ever show up in this tree, but on the other hand,
> I can see this tree being useful regardless, and I think the lack of
> flexibility in this case is actually the whole _point_ of the tree. The 
> lack of flexibility is the very thing that makes this be the kind of base 
> that anybody else can then hang their own patches on top of. There should 
> never be a situation where "I'd like that tree, but I think xxxx was done 
> wrong".

The good patches will show up in 2.6.(x+1).1, which should be
sufficient. It's not the same sucker tree, but it's a sucker tree.

	-Daniel
*This .sig left intentionally blank*

