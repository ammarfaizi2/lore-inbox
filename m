Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267700AbTAMD0K>; Sun, 12 Jan 2003 22:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267729AbTAMD0K>; Sun, 12 Jan 2003 22:26:10 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:55189 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S267700AbTAMD0J>;
	Sun, 12 Jan 2003 22:26:09 -0500
Date: Sun, 12 Jan 2003 20:30:45 -0700
From: yodaiken@fsmlabs.com
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rob Wilkens <robw@optonline.net>, Christoph Hellwig <hch@infradead.org>,
       Greg KH <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
Message-ID: <20030112203045.A18178@hq.fsmlabs.com>
References: <1042401596.1209.51.camel@RobsPC.RobertWilkens.com> <Pine.LNX.4.44.0301121208020.14031-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0301121208020.14031-100000@home.transmeta.com>; from torvalds@transmeta.com on Sun, Jan 12, 2003 at 12:22:26PM -0800
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


See Brian Kernighan's explanation in 1981. Still good.

	http://bit.csc.lsu.edu/tutorial/ten-commandments/bwk-on-pascal.html


On Sun, Jan 12, 2003 at 12:22:26PM -0800, Linus Torvalds wrote:
> 
> On Sun, 12 Jan 2003, Rob Wilkens wrote:
> > 
> > However, I have always been taught, and have always believed that
> > "goto"s are inherently evil.  They are the creators of spaghetti code
> 
> No, you've been brainwashed by CS people who thought that Niklaus Wirth
> actually knew what he was talking about. He didn't. He doesn't have a
> frigging clue.
> 
> > (you start reading through the code to understand it (months or years
> > after its written), and suddenly you jump to somewhere totally
> > unrelated, and then jump somewhere else backwards, and it all gets ugly
> > quickly).  This makes later debugging of code total hell.  
> 
> Any if-statement is a goto. As are all structured loops.
> 
> Ans sometimes structure is good. When it's good, you should use it.
> 
> And sometimes structure is _bad_, and gets into the way, and using a 
> "goto" is just much clearer.
> 
> For example, it is quite common to have conditionals THAT DO NOT NEST.
> 
> In which case you have two possibilities
> 
>  - use goto, and be happy, since it doesn't enforce nesting
> 
> 	This makes the code _more_ readable, since the code just does what 
> 	the algorithm says it should do.
> 
>  - duplicate the code, and rewrite it in a nesting form so that you can 
>    use the structured jumps.
> 
> 	This often makes the code much LESS readable, harder to maintain, 
> 	and bigger.
> 
> The Pascal language is a prime example of the latter problem. Because it 
> doesn't have a "break" statement, loops in (traditional) Pascal end up 
> often looking like total shit, because you have to add totally arbitrary 
> logic to say "I'm done now".
> 
> 		Linus
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
www.fsmlabs.com  www.rtlinux.com
1+ 505 838 9109

