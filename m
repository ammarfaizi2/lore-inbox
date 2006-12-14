Return-Path: <linux-kernel-owner+w=401wt.eu-S1751788AbWLNIVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbWLNIVk (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 03:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751808AbWLNIVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 03:21:39 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:38594 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbWLNIVj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 03:21:39 -0500
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
	for 2.6.19]
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <gregkh@suse.de>, Jonathan Corbet <corbet@lwn.net>,
       Andrew Morton <akpm@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0612131954530.5718@woody.osdl.org>
References: <20061214003246.GA12162@suse.de> <22299.1166057009@lwn.net>
	 <20061214005532.GA12790@suse.de>
	 <Pine.LNX.4.64.0612131954530.5718@woody.osdl.org>
Content-Type: text/plain
Date: Thu, 14 Dec 2006 08:21:20 +0000
Message-Id: <1166084480.5253.849.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-13 at 20:15 -0800, Linus Torvalds wrote:
> If a module arguably isn't a derived work, we simply shouldn't try to say 
> that its authors have to conform to our worldview.

I wouldn't argue that _anyone_ else should be exposed to my worldview; I
think the Geneva Convention has something to say about cruel and unusual
punishments.

But I would ask that they honour the licence on the code I release, and
perhaps more importantly on the code I import from other GPL sources.

If they fail to do that under the 'honour system' then I'm not averse to
'enforcing' it by technical measures. (For some value of 'enforcement'
which is easy for them to patch out if their lawyers are _really_ sure
they'll win when I sue them, that is.)

That's the big difference I see between this and the RIAA case you
mention -- in the case of Linux refusing to load non-GPL modules, if the
user _really_ thinks they'll win in court they can just hack it to load
the offending modules again. We are giving a _very_ strong indication of
our intent, but we aren't actually _forcing_ it on them in quite the
same way. With DRM-crippled players and hardware it's not so easy to get
around.

I'm very much in favour of Greg's approach. Give 12 months warning and
then just prevent loading of non-GPL modules.

That way, we get back from the current "binary modules are the status
quo even though some people are currently psyching themselves up to sue
for it" to "binary modules are possible if you're _very_ sure of your
legal position and willing to defend it". I think that's a very good
thing to do.

> We should make decisions on TECHNICAL MERIT. And this one is clearly being 
> pushed on anything but.

Not on my part. The thing that makes me _particularly_ vehement about
binary-only crap this week is a very much a technical issue -- in
particular, the fact that we had to do post-production board
modifications to shoot our wireless chip in the head when it goes AWOL,
because the code for it wasn't available to us.

It's come back time and time again -- closed code is undebuggable,
unportable, unimprovable, unworkable. It's a detriment to the whole
system. That's very much a _technical_ issue, to me.

For non-kernel code I'm happy enough to release what I write under a BSD
licence. I'll default to GPL but usually respond favourably to requests
to do otherwise. It _isn't_ a religious issue.

> Same goes for code. Copyright is about _distribution_, not about use.
> We shouldn't limit how people use the code.

And we don't need to. Aside from the fact that they can patch out the
check if they have a genuine need to, they can also mark their module as
GPL without consequences as long as they don't _distribute_ it. We still
don't limit their _use_ of it.

> Oh, well. I realize nobody is likely going to listen to me, and everybody 
> has their opinion set in stone. 

My opinion is fairly much set from all the times I've come up against
_technical_ issues, I'll admit. But I did listen, and I agree with what
you say about the RIAA 'enforcement'. But I do see that as _very_
different to our 'enforcement', because ours is so easy to patch out
it's more of a 'hint' than a lockdown.

> That said, I'm going to suggest that you people talk to your COMPANY 
> LAWYERS on this, and I'm personally not going to merge that particular 
> code unless you can convince the people you work for to merge it first.

We've already merged EXPORT_SYMBOL_GPL. Is there a difference other than
one of extent? What about just marking kmalloc as EXPORT_SYMBOL_GPL for
a start? :)

> In other words, you guys know my stance. I'll not fight the combined 
> opinion of other kernel developers, but I sure as hell won't be the first 
> to merge this, and I sure as hell won't have _my_ tree be the one that 
> causes this to happen.
> 
> So go get it merged in the Ubuntu, (Open)SuSE and RHEL and Fedora trees 
> first. This is not something where we use my tree as a way to get it to 
> other trees. This is something where the push had better come from the 
> other direction.

It's better to have a coherent approach, and for all of us to do it on
roughly the same timescale. Getting the distributions do so this is
going to be like herding cats -- having it upstream and letting it
trickle down is a much better approach, I think.

-- 
dwmw2

