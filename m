Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751057AbVL2WEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbVL2WEI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 17:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbVL2WEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 17:04:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30413 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751057AbVL2WEG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 17:04:06 -0500
Date: Thu, 29 Dec 2005 14:03:24 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 12/13] mutex subsystem, VFS [experimental]: convert
 ->i_sem to ->i_mutex
In-Reply-To: <20051229213434.GA6106@elte.hu>
Message-ID: <Pine.LNX.4.64.0512291340000.3298@g5.osdl.org>
References: <20051229210521.GM665@elte.hu> <Pine.LNX.4.64.0512291326230.3298@g5.osdl.org>
 <20051229213434.GA6106@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Dec 2005, Ingo Molnar wrote:
> 
> > Ingo, 
> >  you missed attribution on this. Please don't. A 
> > 
> > 	From: Jes Sorensen <jes@sgi.com> 
> 
> hm, i thought Jes having the first S-o-b line makes it well-defined that 
> he is the author? 

No. How many times do I have to say this? Just do a google for "sign-off", 
"authorship" and "kernel", and the #1 hit (and a number of others in the 
top ten) will be relevant.

Sign-off has a _correlation_ with authorship, but it in no way implies it. 
Not the first one, not the middle one, and not the last one.

So the sign-off procedure has absolute no authorship meaning. It means one 
thing and one thing only: it means that the person is convinced he has the 
legal right to pass it on as a GPL'd piece of code. It means absolutely 
_nothing_ else.

[ Well, it has one _practical_ meaning: anybody who signs off or 
  acknowledges a patch will be bothered by email if that patch turns out 
  to be buggy, which is of course one of the biggest advantages of the 
  whole thing.  In many ways the legalistic part of sign-offs are much 
  less important from a development standpoint than that very _practical_ 
  side to it ]

Now, _if_ you are the author and your employer is ok with it being GPL'd, 
the author and the first sign-off should match. But that's just one case 
of sign-offs - it's the (a) case in the sign-off rules. But the (b) case 
for sign-off's means that the person who does the sign-off may just be 
signing off on somebody elses GPL'd work.

So the (a) case is why there's obviously a _correlation_ with the author 
and the first Signed-off-by: line. One common case is that they are the 
same thing. But it really is not a 1:1 relationship.

Any tool that believes that the first line of sign-off is special is a 
BUGGY tool. And my email patch-application tools are not buggy. I hope 
nobody else has such buggy tools either.

The way to specify authorship is with a "From:" at the top of the message 
(and, if no such line exists, it will be taken from the email headers). No 
ifs, buts, maybes or guesses.

This has been discussed before, but I'll continue to repeat it until I 
don't need to:

  Sign-offs go at the end, and stack up on top of each other (ie the list 
  of sign-offs grows as the patch is sent on-ward - everybody adds their 
  own sign-off last in the list).

  Authorship goes at the top, and never changes, and only ever lists one 
  single author (although we do end up having things like "modified by xyz 
  for reason-or-other" in the commentary, so there can be those kinds of 
  secondary authorship markers, of course).

I realize that having multiple authors might sometimes be the right thing 
to do, but git (nor any other SCM I know of) tracks only one author, so at 
least for now we have to have that "primary author" approach with 
secondary authors just mentioned in the text as such. And obviously, it's 
always best if _all_ authors have a signed-off line.

(That said, one-liners etc don't even need a sign-off. I'll sign off on 
other peoples trivial patches if they didn't do it themselves: I'd _much_ 
rather give them credit even without a sign-off, than to unnecessarily 
re-do the trivial patch myself just to have the author and first sign-off 
match)

			Linus
