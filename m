Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267932AbTAMOZu>; Mon, 13 Jan 2003 09:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267926AbTAMOZu>; Mon, 13 Jan 2003 09:25:50 -0500
Received: from elin.scali.no ([62.70.89.10]:59656 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S267932AbTAMOZl>;
	Mon, 13 Jan 2003 09:25:41 -0500
Subject: Re: any chance of 2.6.0-test*?
From: Terje Eggestad <terje.eggestad@scali.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Robert Love <rml@tech9.net>,
       Rob Wilkens <robw@optonline.net>, Christoph Hellwig <hch@infradead.org>,
       Greg KH <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m14r8dgvbe.fsf@frodo.biederman.org>
References: <Pine.LNX.4.44.0301121231010.14031-100000@home.transmeta.com>
	 <m14r8dgvbe.fsf@frodo.biederman.org>
Content-Type: text/plain
Organization: Scali AS
Message-Id: <1042468439.5404.24.camel@pc-16.office.scali.no>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 13 Jan 2003 15:34:00 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On man, 2003-01-13 at 12:09, Eric W. Biederman wrote:
> Linus Torvalds <torvalds@transmeta.com> writes:
> 
> > On 12 Jan 2003, Robert Love wrote:
> > > On Sun, 2003-01-12 at 15:22, Linus Torvalds wrote:
> > > 
> > > > No, you've been brainwashed by CS people who thought that Niklaus
> > > > Wirth actually knew what he was talking about. He didn't. He
> > > > doesn't have a frigging clue.
> > > 
> > > I thought Edsger Dijkstra coined the "gotos are evil" bit in his
> > > structured programming push?
> > 
> 
> Actually Edsger Dijkstra wrote a paper entitled "Goto considered Harmful"
> He never called them evil.  And the title was more for shock value to
> grab peoples attention.  For the beginners Dijkstra did not
> distinguish between goto, break, return, and continue.
> 
> You can find many of his papers at:
> http://www.cs.utexas.edu/users/EWD/
> 

http://www.cs.utexas.edu/users/EWD/ewd02xx/EWD215.PDF
to be exact. Reading it you can tell exactly how much of an
mathematician Dijkstra really was.  At these times It's best to keep in
mind a quote:

"I used to understand the Theory of Relativity, but then the
mathematicians got hold of it."
  -- Albert Einstein

> What he was after was simple and maintainable code, and from
> everything I have read, I think he would have no major problems with
> the Linux kernel code. 
> 

Well, in the formentioned paper he made the case that while - do, and
do-while are superfluous; we should all use recursion instead. 
Out of respect of the dead, I'm not going to say what I think of that.

Since C don't allow goto beyond it's function, most of what was
problematic of goto's aren't legal anyway. 
But I submit that those that think goto's are evil never had to deal
with smp locks.
 
Most goto's I've seen deal with error handling, and I guess much could
be "solved/hidden" with a "on_return { };" clause, but...
An on_return would be a simplified try/trow/catch that is limited to the
function. 
IMHO: a trow  that is catch'ed somewhere up the call stack, is just as
much an evil as goto. 

> >  So 
> > these days I can only rant about Niklaus Wirth, who took the "structured 
> > programming" thing and enforced it in his languages (Pascal and Modula-2), 
> > and thus forced his evil on untold generations of poor CS students who had 
> > to learn langauges that weren't actually useful for real work.
> 
> Now that is something worth criticizing! 
> 

Considering that students are bottled on Java these day, they're still
learning a language unusable for real work.

> > 
> > (Yeah, yeah, most _practical_ versions of Pascal ended up having all the 
> > stuff necessary to break structure, but as you may be able to tell, I was 
> > one of the unwashed masses who had to write in "standard Pascal" in my 
> > youth. I'm scarred for life).
> 
> 
> Well you seem to be coping well.  Just a little Pascal phobia there...
> 
> Eric
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
_________________________________________________________________________

Terje Eggestad                  mailto:terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 150, Oppsal                     +47 975 31 574  (MOBILE)
N-0619 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

