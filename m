Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267500AbTALUSf>; Sun, 12 Jan 2003 15:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267502AbTALUSe>; Sun, 12 Jan 2003 15:18:34 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47111 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267500AbTALUSR>; Sun, 12 Jan 2003 15:18:17 -0500
Date: Sun, 12 Jan 2003 12:22:26 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rob Wilkens <robw@optonline.net>
cc: Christoph Hellwig <hch@infradead.org>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
In-Reply-To: <1042401596.1209.51.camel@RobsPC.RobertWilkens.com>
Message-ID: <Pine.LNX.4.44.0301121208020.14031-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 12 Jan 2003, Rob Wilkens wrote:
> 
> However, I have always been taught, and have always believed that
> "goto"s are inherently evil.  They are the creators of spaghetti code

No, you've been brainwashed by CS people who thought that Niklaus Wirth
actually knew what he was talking about. He didn't. He doesn't have a
frigging clue.

> (you start reading through the code to understand it (months or years
> after its written), and suddenly you jump to somewhere totally
> unrelated, and then jump somewhere else backwards, and it all gets ugly
> quickly).  This makes later debugging of code total hell.  

Any if-statement is a goto. As are all structured loops.

Ans sometimes structure is good. When it's good, you should use it.

And sometimes structure is _bad_, and gets into the way, and using a 
"goto" is just much clearer.

For example, it is quite common to have conditionals THAT DO NOT NEST.

In which case you have two possibilities

 - use goto, and be happy, since it doesn't enforce nesting

	This makes the code _more_ readable, since the code just does what 
	the algorithm says it should do.

 - duplicate the code, and rewrite it in a nesting form so that you can 
   use the structured jumps.

	This often makes the code much LESS readable, harder to maintain, 
	and bigger.

The Pascal language is a prime example of the latter problem. Because it 
doesn't have a "break" statement, loops in (traditional) Pascal end up 
often looking like total shit, because you have to add totally arbitrary 
logic to say "I'm done now".

		Linus

