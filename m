Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267393AbTALUls>; Sun, 12 Jan 2003 15:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267407AbTALUls>; Sun, 12 Jan 2003 15:41:48 -0500
Received: from mta5.srv.hcvlny.cv.net ([167.206.5.31]:23727 "EHLO
	mta5.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S267393AbTALUlq>; Sun, 12 Jan 2003 15:41:46 -0500
Date: Sun, 12 Jan 2003 15:48:24 -0500
From: Rob Wilkens <robw@optonline.net>
Subject: Re: any chance of 2.6.0-test*?
In-reply-to: <Pine.LNX.4.44.0301121208020.14031-100000@home.transmeta.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Hellwig <hch@infradead.org>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: robw@optonline.net
Message-id: <1042404503.1208.95.camel@RobsPC.RobertWilkens.com>
Organization: Robert Wilkens
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.44.0301121208020.14031-100000@home.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-12 at 15:22, Linus Torvalds wrote:
> No, you've been brainwashed by CS people who thought that Niklaus Wirth
> actually knew what he was talking about. He didn't. He doesn't have a
> frigging clue.

Ok, so you disagree with his style is what you're saying.  You are free
to disagree, that's your right.  We're just from different schools.

> Any if-statement is a goto. As are all structured loops.

"structured" being a key word.  I like structure in code.  Let's face
it, everyone likes code to be well structured, that's why there's the
"CodingStyle" document -- people like the code to look a certain way so
they can read it later.  Without structure, you don't have that

> Ans sometimes structure is good. When it's good, you should use it.

Ok, we agree there.

> And sometimes structure is _bad_, and gets into the way, and using a 
> "goto" is just much clearer.

I can't foresee many scenarios where this would be the case.  Someone
spoke, for example, about being indented too far and needing to jump out
because there isn't a good "break" mechanism... Well, as it says in the
coding style document -- if you're indented more then 3 levels in,
"you're screwed anyway, and should fix your program".  

In the code snippet you put up, I don't see structure as having been bad
and a goto as having been clearer.

> For example, it is quite common to have conditionals THAT DO NOT NEST.

Could someone (Linus, I know your busy, so I won't ask you -- in fact,
I'm amazed you'd bother to write to _me_ at all) please point me to
sample code that illustrates this.  I'm trying to envision "conditionals
that do not nest that need goto".  As near as I can tell, there must be
some condition that the goto nests all the conditions in otherwise the
goto wouldn't be needed.  In some cases, Maybe what's between the goto
and whats gone to should be broken up into a new function (modularized)
and called independently of function that the goto was in.

As someone else pointed out, it's provable that goto isn't needed, and
given that C is a minimalist language, I'm not sure why it was included.

> The Pascal language is a prime example of the latter problem. Because it 
> doesn't have a "break" statement, loops in (traditional) Pascal end up 
> often looking like total shit, because you have to add totally arbitrary 
> logic to say "I'm done now".

But at least the code is "readable" when you do that.  Sure it's a
little more work on the part of the programmer.  But anyone reading the
code can say "oh, so the loop exits when condition x is met", rather
than digging through the code looking for any place their might be a
goto.

Of course, I'm not about to argue that the kernel should be rewritten 
in PASCAL, nor am I interested in reinventing the wheel.  We've got a
good system here, let's just keep it good and make it better.  (Notice I
say "we" as if I've contributed something to it, whereas really I mean
we including myself as an end-user.)

-Rob


