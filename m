Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131622AbRAIVcY>; Tue, 9 Jan 2001 16:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131545AbRAIVcF>; Tue, 9 Jan 2001 16:32:05 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:34311 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129764AbRAIVb7>; Tue, 9 Jan 2001 16:31:59 -0500
Date: Tue, 9 Jan 2001 13:31:35 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: acahalanrth@twiddle.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] More compile warning fixes for 2.4.0
In-Reply-To: <200101092124.f09LOcB326931@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.4.10.10101091327230.2331-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Jan 2001, Albert D. Cahalan wrote:
> 
> > Let the gcc people fix the bugs they find without complaining about them.
> > After all, gcc would have been perfectly correct in signalling this as a
> > syntax error, and aborted compilation. The fact that gcc only warns about
> > it is a sign of grace - it's not as if it is a _useful_ extension that
> > gives the programmer anything new and should be left in for that reason.
> 
> It is slightly useful: appearance, ease-of-use, etc.

I do agree that the gcc extension is more readable, and I have to admit
that I was a bit surprised that it wasn't legal - I guess I've just been
using gcc for too  long.

But at the same time, I do agree with the gcc maintainers that maintaining
extensions is only worth it if those extensions really buy you something,
and if not, you're better off trying to force people to follow documented
standards. The discussion about 'rmdir(".")' that has been going on on
linux-kernel is very much the same thing - even if 'rmdir(".")' might be
slightly useful for some case, it's not useful enough to warrant extra
code and complexity.

You may argue that right now the new gcc warning _is_ extra code and
complexity, and that it would actually have been easier for gcc
maintainers to just continue with the old parser. You'd be right on a
small scale. You'd be wrong in the long run - if gcc ever wants to rewrite
the parser in the future, it's going to be much easier for them if they
don't have to worry about undocumented extensions etc.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
