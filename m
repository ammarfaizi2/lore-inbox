Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbVAMCJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVAMCJv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 21:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVAMCJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 21:09:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:17592 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261276AbVAMCJp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 21:09:45 -0500
Date: Wed, 12 Jan 2005 18:09:31 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Jones <davej@redhat.com>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, Greg KH <greg@kroah.com>,
       Chris Wright <chrisw@osdl.org>, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: thoughts on kernel security issues
In-Reply-To: <20050112205350.GM24518@redhat.com>
Message-ID: <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org>
References: <20050112094807.K24171@build.pdx.osdl.net>
 <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> <20050112185133.GA10687@kroah.com>
 <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <20050112161227.GF32024@logos.cnet>
 <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <20050112205350.GM24518@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 12 Jan 2005, Dave Jones wrote:
> 
> Who would be on the kernel security list if it's to be invite only ?
> Is this just going to be a handful of folks, or do you foresee it
> being the same kernel folks that are currently on vendor-sec ?

I'd assume that it's as many as possible. The current vendor-sec kernel
people _plus_ anybody else who wants to.

> My first thought was 'Chris will forward the output of security@kernel.org
> to vendor-sec, and we'll get a chance to get updates built'. But you
> seem dead-set against any form of delayed disclosure, which has the
> effect of catching us all with our pants down when you push out
> a new kernel fixing a hole and we don't have updates ready.

Yes, I think delayed disclosure is broken. I think the whole notion of 
"vendor update available when disclosure happens" is nothing but vendor 
politics, and doesn't help _users_ one whit.  The only thing it does is 
allow the vendor to point fingers and say "hey, we have an update, now 
it's your problem".

In reality, the user usually needs to have the update available _before_
the disclosure anyway. Preferably by _months_, not minutes.

So I think the whole vendor-sec thing is not helping users at all, it's 
purely a "vendor embarassment" thing. 

> If you turned the current model upsidedown and vendor-sec learned
> about issues from security@kernel.org a few days before it'd at
> least give us *some* time, as opposed to just springing stuff
> on us without warning.

I think kernel bugs should be fixed as soon as humanly possible, and _any_
delay is basically just about making excuses. And that means that as many
people as possible should know about the problem as early as possible,
because any closed list (or even just anybody sending a message to me
personally) just increases the risk of the thing getting lost and delayed
for the wrong reasons.

So I'd not personally mind some _totally_ open list. No embargo at all, no 
limits on who reads it. The more, the merrier. However, I think my 
personal preference is pretty extreme in one end, and I also think that 
vendor-sec is extreme in the other. So there is probably some middle 
ground.

Will it make everybody happy? Hell no. Nothing like that exists. Which is 
why I'm willing to live with an embargo as long as I don't feel like I'm 
being toyed with.

And hey, vendor-sec works. I feel like vendor-sec just toys with me, which
is why I refuse to have anything to do with it, but it's entirely possible
that the best solution is to just ignore my wishes. That's OK. I'm ok with
it, vendor-sec is ok with it, nobody is _happy_ with it, but it's another
compromise. Agreeing to disagree is fine too, after all.

So it's embarrassing to everybody if the kernel.org kernel has a security
hole for longer than vendor kernels, but at the same time, most _users_
run vendor kernels anyway, so maybe the current setup is the proper one,
and the kernel.org kernel _should_ be the last one to get the fix.  
Whatever. I happen to believe in openness, and vendor-sec does not. It's
that simple.

But if we're seriously looking for a middle ground between my "it should 
be open" and vendor-sec "it should be totally closed", that's where my 
suggestions come in. Whether people _want_ to look for a middle ground is 
the thing to ask first..

For example, having an arbitrarily long embargo on actual known exploit
code is fine with me. I don't care. If I have to promise to never ever
disclose an exploit code in order to see it, I'm fine with that - but I
refuse to delay the _fix_ by more than a few days, and even that "few
days" goes out the window if somebody else has knowingly delayed giving
the fix or problem to me in the first place.

This is not just about sw security, btw. I refuse to sign NDA's on hw 
errata too. Same deal - it may mean that I get to know about the problem 
later, but it also means that I don't have to feel guilty about knowing of 
a problem and being unable to fix it. And it means that people can trust 
_me_ personally.

		Linus
