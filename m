Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030373AbWGHUtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030373AbWGHUtx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 16:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030359AbWGHUtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 16:49:53 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:11952 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030373AbWGHUtw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 16:49:52 -0400
Date: Sat, 8 Jul 2006 22:49:25 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Krzysztof Halasa <khc@pm.waw.pl>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       Linux kernel <linux-kernel@vger.kernel.org>, arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile'
Message-ID: <20060708204925.GA5440@elf.ucw.cz>
References: <m34pxt8emn.fsf@defiant.localdomain> <Pine.LNX.4.61.0607071535020.13007@chaos.analogic.com> <Pine.LNX.4.64.0607071318570.3869@g5.osdl.org> <Pine.LNX.4.61.0607071657580.15580@chaos.analogic.com> <Pine.LNX.4.64.0607071456430.3869@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607071456430.3869@g5.osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This is a bait and switch argument. The code was displayed to show
> > the compiler output, not an example of good coding practice.
> 
> NO IT IS NOT.
> 
> The whole point of my argument is simple:
> 
> > > 	"'volatile' is useless. The things it did 30 years ago are much
> > > 	 more complex these days, and need to be tied to much more
> > > 	 detailed rules that depend on the actual particular problem,
> > > 	 rather than one keyword to the compiler that doesn't actually
> > > 	 give enough information for the compiler to do anything useful"
> 
> And dammit, if you cannot admit that, then you're not worth discussing 
> with.
> 
> "volatile" is useless. It's a big hammer in a world where the nails aren't 
> nails any more, they are screws, thumb-tacks, and spotwelding.

Actually, because volatile is big hammer, it can be used to work
around compiler bugs. If compiler dies at internal error in function
foo, just sprinkle few volatiles into it, and you can usually work
around that compiler problem.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
