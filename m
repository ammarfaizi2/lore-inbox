Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267658AbTALXy6>; Sun, 12 Jan 2003 18:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267659AbTALXy6>; Sun, 12 Jan 2003 18:54:58 -0500
Received: from smtp-server3.tampabay.rr.com ([65.32.1.41]:64442 "EHLO
	smtp-server3.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S267658AbTALXy4>; Sun, 12 Jan 2003 18:54:56 -0500
From: "Scott Robert Ladd" <scott@coyotegulch.com>
To: <robw@optonline.net>, "Linus Torvalds" <torvalds@transmeta.com>
Cc: "Christoph Hellwig" <hch@infradead.org>, "Greg KH" <greg@kroah.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "William Lee Irwin III" <wli@holomorphy.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: any chance of 2.6.0-test*?
Date: Sun, 12 Jan 2003 19:03:10 -0500
Message-ID: <FKEAJLBKJCGBDJJIPJLJEELGECAA.scott@coyotegulch.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <1042401596.1209.51.camel@RobsPC.RobertWilkens.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Wilken wrote:
> Would it be so terrible for you to change the code you had there to
> _not_ use a goto and instead use something similar to what I suggested?
> Never mind the philosophical arguments, I'm just talking good coding
> style for a relatively small piece of code.
>
> If you want, but comments in your code to meaningfully describe what's
> happening instead of goto labels.
>
> In general, if you can structure your code properly, you should never
> need a goto, and if you don't need a goto you shouldn't use it.  It's
> just "common sense" as I've always been taught.  Unless you're
> intentionally trying to write code that's harder for others to read.

I've spent some time looking through the kernel source code, getting a feel
for the style and process before attempting to contribute something of my
own. In most ways, the quality of Linux code equals or exceeds that of
commercial products I've worked on. It may not be perfect, but I'd prefer
that the maintainers focus on features and bug fixes, not religious issues.

Your attitude against "goto" is perhaps based upon an excellent but dated
article, "Goto Considered Harmful", written by Edsger W. Dijkstra, and
published by the ACM in 1968. (A recent reprint can be found at
http://www.acm.org/classics/oct95/.) As you can tell from the date, this
article predates modern programming languages and idioms; it comes from a
time when Fortran ruled, and before Fortran 77 provided significant tools
for avoiding spaghetti code.

A "goto" is not, in and of itself, dangerous -- it is a language feature,
one that directly translates to the jump instructions implemented in machine
code. Like pointers, operator overloading, and a host of other "perceived"
evils in programming, "goto" is widely hated by those who've been bitten by
poor programming. Bad code is the product of bad programmers; in my
experience, a poor programmer will write a poor program, regardless of the
availability of "goto."

If you think people can't write spaghetti code in a "goto-less" language, I
can send you some *lovely* examples to disabuse you of that notion. ;)

Used over short distances with well-documented labels, a "goto" can be more
effective, faster, and cleaner than a series of complex flags or other
constructs. The "goto" may also be safer and more intuitive than the
alternative. A "break" is a goto; a "continue" is a "goto" -- these are
statements that move the point of execution explicitly.

That said, I have used exactly two "goto" statements in all the lines of C,
C++, Fortran 95, and (yes) COBOL I've written since leaving BASIC and
Fortran IV behind. In one case, a single "goto" doubled the speed of a
time-critical application; in the other case, "goto" shortens a segment of
code by half and makes the algorithm much clearer. I would not use a goto
willy-nilly for the fun of it -- unless I was entering an obfuscated code
contest ;)

We keep lowering the bar for technical prowess, it seems; if something has
the potential to be used "wrong", high-minded designers remove the offending
syntax rather than find or train competent programmers. This is why Java
removes pointers (among other things) -- it's not that pointers aren't
useful or efficient, it's that they require discipline from programmers.

Just because something is dogma doesn't mean it is absolute truth. If
anything, dogma should be sniffed quite carefully, since it tends to be
rather rank if you get close enough. Removing goto is a religious choice,
not a technical one.

I could draw parallels with idiotic laws in general society, but this
message is already marginal for this list.

..Scott

--
Scott Robert Ladd
Coyote Gulch Productions (http://www.coyotegulch.com)
Professional programming for science and engineering;
Interesting and unusual bits of very free code.

