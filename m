Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265377AbRGXAEI>; Mon, 23 Jul 2001 20:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265385AbRGXAD7>; Mon, 23 Jul 2001 20:03:59 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:8720 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S265377AbRGXADu>; Mon, 23 Jul 2001 20:03:50 -0400
Date: Tue, 24 Jul 2001 02:04:13 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
        Linus Torvalds <torvalds@transmeta.com>, Jeff Dike <jdike@karaya.com>,
        user-mode-linux-user <user-mode-linux-user@lists.sourceforge.net>,
        linux-kernel <linux-kernel@vger.kernel.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: user-mode port 0.44-2.4.7
Message-ID: <20010724020413.A29561@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0107231259520.13272-100000@penguin.transmeta.com> <3B5C8C96.FE53F5BA@nortelnetworks.com> <20010723231136.E16919@athlon.random> <200107232150.f6NLosh13126@vindaloo.ras.ucalgary.ca> <20010724000933.I16919@athlon.random> <200107232347.f6NNl4u14416@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200107232347.f6NNl4u14416@vindaloo.ras.ucalgary.ca>; from rgooch@ras.ucalgary.ca on Mon, Jul 23, 2001 at 05:47:04PM -0600
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, Jul 23, 2001 at 05:47:04PM -0600, Richard Gooch wrote:
> I don't think it should be allowed to do that. That's a whipping

it is allowed to do that, period. This is not your choice or my choice.
You may ask gcc folks not to do that and I think they just do.

> So grab a local snapshot of the variable, as Linus suggested. In fact,
> the switch example is interesting, because one could argue the
> opposite way, that declaring the switch variable as "volatile" means
> that if GCC needs to internally re-"get" the variable, it should grab
> it from memory, and thus definately fail. Without "volatile", GCC is
> implicitely allowed to cache the variable (which is of course safe).

If gcc caches there's no problem indeed, the problem is when it doesn't
cache it which can happen, with volatile it will understand it must not
make assumption for the variable to not change under it. Anyways as just
said in another email in this thread I'm been told it wasn't just for
'case'. I think tomorrow Honza will comment this since he's the gcc
developer who asked those kernel bugs to be fixed for gcc.

Andrea
