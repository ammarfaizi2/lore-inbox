Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265573AbUABSFR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 13:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265625AbUABSFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 13:05:17 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:57766 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S265573AbUABSFH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 13:05:07 -0500
Date: Fri, 2 Jan 2004 19:04:31 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Libor Vanek <libor@conet.cz>
Cc: Christoph Hellwig <hch@infradead.org>, Muli Ben-Yehuda <mulix@mulix.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Syscall table AKA hijacking syscalls
Message-ID: <20040102180431.GB6577@wohnheim.fh-wedel.de>
References: <3FF56B1C.1040308@conet.cz> <20040102151206.GJ1718@actcom.co.il> <3FF59073.3060305@conet.cz> <20040102160020.A24026@infradead.org> <20040102163552.GD31489@wohnheim.fh-wedel.de> <3FF5A36A.5070501@conet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3FF5A36A.5070501@conet.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 January 2004 17:59:22 +0100, Libor Vanek wrote:
> 
> >My guess is that the filesystem change notification would be a better
> >solution, either in userspace or in kernelspace, doesn't matter.  But
> >that is far from finished or even generally accepted.
> 
> This is also something (but just a bit) different - I don't need "change 
> notification" but "pre-change notification" ;)

"Vor dem Spiel ist nach dem Spiel" -- Sepp Herberger

Except for exactly two cases, pre-change and post-change and the same,
just off-by-one.  So you would need a bootup/mount/whenever special
case now, is that a big problem?

> >For the diploma thesis, feel free to use any hack you like, including
> >hijacking syscalls.  But remember that it is a hack and nothing else,
> >only helping you to remain on schedule and focus more on the real
> >subject.  And don't plan on kernel acceptance either, as you will fail
> >either that or the thesis and I'd choose the thesis.
> 
> You're absolutely right but when I'm going to spent several weeks on 
> something like this I'd like to do something usefull - not something 
> which will be trashed after exam. So I'm trying to find out some 
> "politically correct" way.

Then seperate the two problems.  One is to figure out, what has
changed and two is to act accordingly.  Two should be pretty
independent on this threads subject.  If that part is really useful,
people will help you on problem one.  Postpone. :)

Something I learned over time is that the first implementation is
almost always crappy, often even righout wrong.  It has to be, because
noone really knows all the problems yet and thus can design the Proper
Solution (tm) yet.  Look at the current devfs vs. udev discussion for
one example.

Many research people know this and won't give you any source code
beyond the official paper simply because it is horrible and the don't
want to wear brown paper-bags.  There is no shame in a horrible first
try, noone could have done that much better than Richard Gooch back
then.  Simply because noone could learn from his mistakes yet.

Ok, there is shame in a horrible first try, but there shouldn't be,
really.  The "standing on the shoulders of giants" thing applies, even
when standing on the shoulders of dwarves, people should be more
polite. :)

And even though he won't read this, thank you Richard!  He took the
unrewarding role and grew bitter, but he did a good thing.


Ok, back to your problem.  Seperation is the way to go.  Problem one
is a hard one and it takes a lot of time to do right.  But hacking it
up is quite simple, so you can save time with the hack and do it right
only if your solution to problem two proved good enough.

Jörn

-- 
He who knows others is wise.
He who knows himself is enlightened.
-- Lao Tsu
