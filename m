Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263941AbTJFBlp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 21:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263940AbTJFBlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 21:41:45 -0400
Received: from [209.195.52.120] ([209.195.52.120]:63732 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S263941AbTJFBlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 21:41:42 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Larry McVoy <lm@bitmover.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Andre Hedrick <andre@linux-ide.org>,
       Rob Landley <rob@landley.net>,
       "Henning P. Schmiedehausen" <hps@intermeta.de>,
       linux-kernel@vger.kernel.org
Date: Sun, 5 Oct 2003 18:37:18 -0700 (PDT)
Subject: Re: freed_symbols [Re: People, not GPL [was: Re: Driver Model]]
In-Reply-To: <20031006012212.GA14646@work.bitmover.com>
Message-ID: <Pine.LNX.4.58.0310051833170.16540@dlang.diginsite.com>
References: <Pine.LNX.4.10.10310051303450.21746-100000@master.linux-ide.org>
 <1065386079.3157.162.camel@imladris.demon.co.uk> <20031006012212.GA14646@work.bitmover.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

not to disagree with Larry in what he posted below, but there is nothing
in what he says that at all means that if you paste in code from one side
of a barrier to the other side the result doesn't need to be GPL'd

so the barriers can be delibratly bridged, but if you are careful about
your code on one side of the barrier you don't have to worry about what's
on the other side.

David Lang

On Sun, 5 Oct 2003, Larry McVoy wrote:

> Date: Sun, 5 Oct 2003 18:22:12 -0700
> From: Larry McVoy <lm@bitmover.com>
> To: David Woodhouse <dwmw2@infradead.org>
> Cc: Andre Hedrick <andre@linux-ide.org>, Rob Landley <rob@landley.net>,
>      Henning P. Schmiedehausen <hps@intermeta.de>,
>      linux-kernel@vger.kernel.org
> Subject: Re: freed_symbols [Re: People, not GPL [was: Re: Driver Model]]
>
> On Sun, Oct 05, 2003 at 09:34:40PM +0100, David Woodhouse wrote:
> > The GPL says you may use the kernel _itself_ but only with certain
> > restrictions.
> >
> > My claim is that the GPL forbids you from loading a non-GPL'd module.
> > Not that if you do so, the non-GPL'd module becomes a derived work, but
> > that in doing do you are violating the licence under which you received
> > the _kernel_ and hence you must immediately cease using the _kernel_.
>
> Your claim is not, as far as I know, supported by the law or the GPL
> itself.
>
> GPL v2 section 2:
>     "These requirements apply to the modified work as a whole.
>     If identifiable sections of that work are not derived from the
>     Program, and can be reasonably considered independent and separate
>     works in themselves, then this License, and its terms, do not apply"
>
> That leaves the question of what "can be reasonably considered independent
> and separate works".  I've both heard about other companies researching
> this and I've done it myself.  The lawyers came to the same conclusion,
> independently.  In software, what constitutes an independent work is
> something which can be pulled out and have another implementation dropped
> in and the rest of the system can't tell the difference.
>
> A very obvious boundary is user vs kernel, nobody here thinks that because
> some application runs on a GPLed kernel that application is GPLed.
> Some people here may _pretend_ they think that so that they can argue
> that Linus made an "exception" for user land applications but that's
> just self serving posturing and I'm sure those people know that (just
> as I'm sure there will be 50 flaming replies saying that is not at all
> what they think.  Politicians are the same everywhere).
>
> Another boundary is a tarball.  If it weren't for the above clause of
> the GPL then anything combined in a tarball with a GPLed work would be
> considered GPLed.  Even RMS knew that wouldn't fly.
>
> A less obvious boundary, and the one that got me into this, is the storage
> of a GPLed source file in a source management system.  Does that mean that
> the metadata used to store that file is GPLed?  At one point I was worried
> about this (why?  Damn good question, in retrospect it is a "don't care",
> I didn't create the metadata so I don't own it anyway so why do I care if
> it is GPLed or not?  Whatever, at one point I cared).  I spent more than
> a lot of you make in a year in legal fees looking into it and that's where
> I learned about boundaries.  The law has pretty clear ideas about boundaries
> and it doesn't matter what you think or I think or the GPL thinks, the
> boundaries are there and the GPL can't cross them.  The conclusion of the
> lawyers was that no, putting a GPLed file into an SCM system in no way
> makes the SCM metadata GPLed.  BTW, I asked RMS about this and he of course
> refused to accept that, his position is that the metadata would be GPLed,
> nice to see he is consistent :)
>
> A much more obvious example than the SCM one is a device driver or a module.
> That's so cut and dried it isn't even open to debate in the eyes of the
> law.  It's a hard and fast boundary, the GPL can't cross it no matter what
> people think or want (on either side).
>
> That's why I think that your claim is not supported, by the GPL or
> (far more importantly) the law.  While I'm no lawyer I'm perhaps more
> qualified than some people on this list since I've actually spent a pile
> of money researching this.  I'm sure that someone with more money could
> buy^H^H^Hpay some lawyers try and make an opposing view stick but I'm
> equally sure that those of you without money don't have an iceballs'
> chance in hell of making an opposing view stick.  Talk is cheap, legal
> decisions are expensive.
>
> Once again, please note that I don't make money off the kernel or any other
> GPLed product (we ship diff & patch with BK but we also provide source for
> all our changes, they aren't substantial nor are they money makers).  So I
> have no vested interest in which way this works out.  I'm simply passing on
> what I've learned, I'm more or less one of you who has actually spent a lot
> of money getting legal opinions on the topic.
> --
> ---
> Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
