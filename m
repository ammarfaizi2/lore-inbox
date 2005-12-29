Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750966AbVL2UuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbVL2UuA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 15:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbVL2UuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 15:50:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39616 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750965AbVL2UuA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 15:50:00 -0500
Date: Thu, 29 Dec 2005 12:49:16 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Jones <davej@redhat.com>
cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       arjan@infradead.org, linux-kernel@vger.kernel.org, mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
In-Reply-To: <20051229202852.GE12056@redhat.com>
Message-ID: <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org>
References: <20051228114637.GA3003@elte.hu> <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org>
 <1135798495.2935.29.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org>
 <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu>
 <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu>
 <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org> <20051229202852.GE12056@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Dec 2005, Dave Jones wrote:
> 
> Seriously, we break things _every_ release. Sometimes in tiny
> 'doesn't really matter' ways, sometimes in "fuck, my system no
> longer works" ways, but the days where we I didn't have to tell
> our userspace packagers to rev a half dozen or so packages up to the
> latest upstream revisions when I've pushed a rebased kernel are
> a distant memory.

Umm.. Complain more. I upgrade kernels a lot more often than I upgrade 
distros, and things don't break. They're not allowed to break, because I 
refuse to upgrade my user programs just because I do kernel development. 
But I'd only notice a small part of user space, so if people don't 
complain, they break not because we don't care, but because we didn't even 
know.

So if you have a user program that breaks, _complain_. It's really not 
supposed to happen outside of perhaps kernel module loaders etc things 
that get really really chummy with kernel internals (and even that was 
fixed: the modern way of loading modules isn't that chummy any more, so 
hopefully we'll not need to break even module loaders again).

If we change some /proc file thing, breakage is often totally 
unintentional, and complaining is the right thing - people might not even 
have realized it broke.

At least _I_ take breakage reports seriously. If there are maintainers 
that don't, complain to them. I'll back you up. Breaking user space simply 
isn't acceptable without years of preparation and warning.

			Linus
