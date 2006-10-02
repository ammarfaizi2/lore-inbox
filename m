Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965487AbWJBWeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965487AbWJBWeO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 18:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965486AbWJBWeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 18:34:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16341 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965484AbWJBWeN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 18:34:13 -0400
Date: Mon, 2 Oct 2006 15:33:38 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       David Howells <dhowells@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>,
       Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than
 passing to IRQ handlers
In-Reply-To: <200610022359.00951.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0610021529260.3952@g5.osdl.org>
References: <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com>
 <200610022319.59029.ak@suse.de> <Pine.LNX.4.64.0610021445570.3952@g5.osdl.org>
 <200610022359.00951.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 2 Oct 2006, Andi Kleen wrote:
> 
> I remember trying to compile a lot of architectures when I did 4level,
> but I quickly gave up because of many of them just didn't without
> me changing anything.

I think that if we cover x86-64 and plain old x86 with something like 
"allmodconfig", and just doing a best effort on the other architectures, 
we're already in pretty damn good shape. It's not like fixing any stupid 
left-overs that got missed because some "grep" pattern didn't notice an 
odd user is going to really cause problems.

I don't think the architecture maintainers will have any trouble 
converting their own architecture. It's literally a question of getting 
clear compiler warnings or errors, and just fixing them up. I'll do at 
least the parts of ppc64 that I'd notice myself, unless somebody else just 
gets to it first.

So I really wouldn't worry about any small short-term problems. The reason 
I mentioned out-of-tree drivers is exactly the fact that they can't just 
fix it up trivially for a single flag-day, so they have to have a longer- 
term solution.

		Linus
