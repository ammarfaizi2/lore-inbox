Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbUDEX2O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 19:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263502AbUDEX2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 19:28:14 -0400
Received: from web40504.mail.yahoo.com ([66.218.78.121]:22377 "HELO
	web40504.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263370AbUDEX2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 19:28:01 -0400
Message-ID: <20040405232755.93075.qmail@web40504.mail.yahoo.com>
Date: Mon, 5 Apr 2004 16:27:55 -0700 (PDT)
From: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Subject: Re: kernel stack challenge
To: Timothy Miller <miller@techsource.com>
Cc: John Stoffel <stoffel@lucent.com>, Helge Hafting <helgehaf@aitel.hist.no>,
       linux-kernel@vger.kernel.org
In-Reply-To: <4071DBBB.4010704@techsource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wanted something higher level than C. Forth looks
like C to me. I wanted something with build in support
of complex structures and automatic memory management.

I see no reason to replace one C with another.

> Did you separate out the parser out into a
> user-space daemon?

I didn't. It's possible optimization, but it will not
give any good. The syntax of LISP is much simpler than
Forth (this another reason I chose LISP :-), so parser
is very small.

> >>Why do you choose LISP?  Don't you want to use a
> >>language that sysadmins 
> >>will actually KNOW?

At the start of the project I tried to design my own
small language (just for security system). At this
point I understood that I didn't want to settle with
anything less than universal language. The idea to
invent some language and write VM for it didn't appeal
to me. I wanted to make a security system, not a new
language. I wanted language to be as simple as
possible. LISP had the simpliest syntax from all
languages. So I found small lisp interpreter (kind of
real time - without garbage collector which stops
execution) added string and bit operations, modified
it to be placed in the kernel.

Ok, it was my marketing claim about sysadmins :-)
Sysadmins use web interface to configure polices and
don't deal with LISP at all.

LISP is for those who want to change security Models
only.

Serge.

--- Timothy Miller <miller@techsource.com> wrote:
> 
> 
> Sergiy Lozovsky wrote:
> > --- Timothy Miller <miller@techsource.com> wrote:
> > 
> >>
> >>Sergiy Lozovsky wrote:
> >>
> >>
> >>>
> >>>All LISP errors are incapsulated within LISP VM.
> >>> 
> >>
> >>
> >>A LISP VM is a big, giant, bloated.... *CHOKE*
> >>*COUGH* *SPUTTER* 
> >>*SUFFOCATE* ... thing which SHOULD NEVER be in the
> >>kernel.
> > 
> > 
> > It is a smallest interpreter (of all purpose
> language)
> > I was able to find. My guess is that you refer to
> the
> > Common Lisp. it is huge and I don't use it.
> 
> Did you separate out the parser out into a
> user-space daemon?
> 
> Also, if you want a regular programming language
> with an extremely small 
> interpreter, try Forth.
> 
> Learning Forth should be at LEAST as much fun as
> learning LISP.
> 
> > 
> > 
> >>If you want to use a more abstract language for
> >>describing kernel 
> >>security policies, fine.  Just don't use LISP.
> > 
> > 
> > Point me to ANy langage with VM around 100K.
> 
> I bet a Forth interpreter would be smaller.
> 
> And for something specialized like security policy,
> you could probably 
> develop your own language and interpreter for it,
> and it would be 
> smaller (and faster) still.
> 
> > 
> > 
> >>The right way to do it is this:
> >>
> >>- A user space interpreter reads text-based config
> >>files and converts 
> >>them into a compact, easy-to-interpret code used
> by
> >>the kernel.
> >>
> >>- A VERY TINY kernel component is fed the security
> >>policy and executes it.
> > 
> > 
> > it is exactly the way it is implemented. Not
> everyone
> > need to create their own security model (that VERY
> > TINY kernel component you refer to). But even for
> > those who want to modify or create their own VERY
> TINY
> > kernel component - they don't need to do that in C
> and
> > debug it in th kernel crashing it.
> 
> You misunderstand.  When I say "VERY TINY kernel
> component", I'm 
> referring to the interpreter.  Done properly, the
> pcode for the policy 
> itself would be microscopic.
> 
> > 
> > 
> >>Move as much of the processing as reasonable into
> >>user space.  It's 
> >>absolutely unnecessary to have the parser into the
> >>kernel, because 
> >>parsing of the config files is done only when the
> >>ASCII text version 
> >>changes.
> >>
> >>It's absolutely unnecessary to have something as
> >>complex as LISP to 
> >>interpret it, when something simple and compact
> >>could do just as well.
> >>
> >>Why do you choose LISP?  Don't you want to use a
> >>language that sysadmins 
> >>will actually KNOW?
> > 
> > 
> > It was is) the smallest VM I know of.
> 
> Forth.
> 
> 


__________________________________
Do you Yahoo!?
Yahoo! Small Business $15K Web Design Giveaway 
http://promotions.yahoo.com/design_giveaway/
