Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbWIUSW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWIUSW5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 14:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbWIUSW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 14:22:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23783 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751328AbWIUSW4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 14:22:56 -0400
Date: Thu, 21 Sep 2006 11:22:20 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19 -mm merge plans
In-Reply-To: <20060921105959.a55efb5f.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0609211106391.4388@g5.osdl.org>
References: <20060920135438.d7dd362b.akpm@osdl.org> <45121382.1090403@garzik.org>
 <20060920220744.0427539d.akpm@osdl.org> <1158830206.11109.84.camel@localhost.localdomain>
 <Pine.LNX.4.64.0609210819170.4388@g5.osdl.org> <20060921105959.a55efb5f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 21 Sep 2006, Andrew Morton wrote:
> 
> Again, before we can implement anything we should describe what problem we are
> actually trying to solve here.
> 
> Jeff: "I want faster release cycles because <no reason given>"
> 
> Me: "I want less bugs"
> 
> Anyone else?

Me: "I want peoples expectations to line up".

(That, btw, is totally independent of this particulay issue - I just like 
people to know what to expect..)

One of the things that I think the current model has excelled at is how it 
really changed peoples behaviour, simply because they knew and understood 
the rules.

I think the "big merges in the first two weeks, and a -rc1 after, and no 
new code after that" rule has been working because it brought everybody in 
on the same page. 

I actually expected people to dislike arbitrary rules more than they do, 
but I've come to believe that people _like_ having rules that they have to 
obey, as long as it's not a big pain for them. In other words, arbitrary 
rules are not actually disliked at all, people actually _like_ them, 
because suddenly there's less need for making unnecessary judgement 
decisions.

As an example: I thought I'd get a lot of back-lash on the whole sign-off 
procedure. Instead, we're basically signing off everything, and having a 
few simple rules ended up making it just easier to forward stuff, and we 
haven't had any of the discussions about who gets to be attributed as an 
author since the sign-off was introduced. That was a totally unexpected 
bonus, as far as I was concerned.

The same goes for my anal efforts at trying to make people use a specific 
format for sending patches, and sending the "please pull" messages. I'm 
not hearing any grumbling about it at all, and in fact I'm getting the 
distinct feeling that people like knowing exactly what format to use, 
because they didn't really care themselves, and it turns out that having 
any rule - even if it's fairly arbitrary - seems to be better than not 
having a rule at all.

So I think that a "odd release"/"even release" rule that clarifies what a 
certain mid-point in the release cycle actually _means_, even if it 
doesn't necessarily add anything else, might be a good thing. It just 
solidifies peoples expectations about where we are in a release cycle.

If we make an arbitrary rule to go with the release cycle ("leading up to 
the even cycle, you need to get an ack from somebody that actually tested 
the fix") that could actually be a good thing, for this reason. 

I dunno. Maybe the only arbitrary rule ends up being that an "odd release" 
would become a good place for people to try, knowing that we expect bug 
reports from them. Right now -rc1 might be _too_ scary, even if it ends up 
being exactly that: the only difference is really not about technology, 
but about what peoples expectations are.

If we could instill a culture of "if you aren't a developer, but you just 
want to help out, try the odd releases", that in itself might be worth the 
naming change. If it would allow a group of people who might not feel 
comfortable about reporting problems with a "-rc" to feel like they are 
_expected_ to report a problem with an odd release, then that would be a 
good thing, no?

I'm just throwing this out as an idea. I'm not going to really argue very 
strongly for it. It might have horrible downsides too, for all I know, and 
we might get people who didn't get the memo on "even vs odd releases" 
being really unhappy about somethign they perceive to be a buggy release.

			Linus
