Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280402AbRJaSec>; Wed, 31 Oct 2001 13:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280400AbRJaSeO>; Wed, 31 Oct 2001 13:34:14 -0500
Received: from bitmover.com ([192.132.92.2]:14282 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S280399AbRJaSeF>;
	Wed, 31 Oct 2001 13:34:05 -0500
Date: Wed, 31 Oct 2001 10:34:43 -0800
From: Larry McVoy <lm@bitmover.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Larry McVoy <lm@bitmover.com>, Timur Tabi <ttabi@interactivesi.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Module Licensing?
Message-ID: <20011031103443.K1506@work.bitmover.com>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	Larry McVoy <lm@bitmover.com>, Timur Tabi <ttabi@interactivesi.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20011031092228.J1506@work.bitmover.com> <Pine.LNX.4.33L.0110311525460.2963-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.33L.0110311525460.2963-100000@imladris.surriel.com>; from riel@conectiva.com.br on Wed, Oct 31, 2001 at 03:27:31PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2001 at 03:27:31PM -0200, Rik van Riel wrote:
> You're right, just including <sys/types.h> won't do that,
> but either of:
> 
> 1) using inline functions from a .h file  or
> 2) linking to the library/kernel later on
> 
> might mean your stuff is GPLed.
> 
> Be careful which definitions you get from the
> header file, inline functions are a very grey
> area ;)

[Please: read the whole message before flaming, OK?  Thanks]

The reason they are not gray areas is this:

virus licenses such as the GPL can't cross over well defined boundaries.
If they could, then the fact that the kernel is GPLed would make any
application that is run on top of the kernel also GPLed.  The commonly
held belief that userland is somehow different than the kernel is just
that, a belief.  In the eyes of the law it's all a big pile of code
running together.  We draw the distinction between running and linking
but that is arbitrary, and while it makes sense to us, I challenge 
someone to prove that it makes sense to the courts.


Noone believes that just running an application makes it GPLed, not
even Stallman.  In fact, he acknowledges the boundary issue when he says:

    "These requirements apply to the modified work as a whole.  If
    identifiable sections of that work are not derived from the Program,
    and can be reasonably considered independent and separate works in
    themselves, then this License, and its terms, do not apply to those
    sections..."

While some people might like you to believe that the FSF gets to
interpret what "can be reasonably considered independent", they don't.
Remember, just because you write something in a contract doesn't mean it
is enforceable.  For example, you could sign a contract that says that
you belong to me and I can do whatever I want with you, but that's never
going to be enforceable, for the obvious reasons.  There are all sorts
of laws, in pretty much all societies, which override anything too wacky
put into a contract.  A good example of how much this is ignored is the
typical employment agreement that everyone makes you sign in California.
It's not worth the paper it is written on, California has laws on the
books which make that clear, yet companies use the fact that people
are ignorant to get away with it.  But if those same companies are
challenged in court, as they frequently are, they will lose.  And they
know it, they are just playing the odds.

Getting back to the GPL, the point is that neither the FSF nor the
copyright holders get to arbitrarily decide what is and is not separable.
One could certainly try, for example, to say that running a program on
GPLed kernel makes the program GPLed.  It's not going to work though.
Keep that in mind when thinking about what is or is not GPLed.  

I think another way to look at it might be: if you extend a GPLed program
using well defined interfaces, you can probably get away with not GPLing
your code.  You may have to fight for it and it generally isn't worth
the fight, but you could win and it is likely that you'd win.

On the other hand, if you're in there changing how an existing GPLed
program works, and there isn't any way to pull your stuff out cleanly,
then you are definitely stuck with the GPL.  And that's as it should be,
you are in GPLed code.  And even if you could get away with winning a
court battle, you have to ask yourself if it is worth it.  In my opinion,
it's relatively rare that changes to the kernel are really worth the fuss.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
