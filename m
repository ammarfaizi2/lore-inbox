Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <971863-26836>; Mon, 13 Jul 1998 11:21:21 -0400
Received: from miris.lcs.mit.edu ([18.111.0.89]:52983 "EHLO miris.lcs.mit.edu" ident: "cananian") by vger.rutgers.edu with ESMTP id <971859-26836>; Mon, 13 Jul 1998 11:19:15 -0400
Date: Mon, 13 Jul 1998 12:30:46 -0400 (EDT)
From: "C. Scott Ananian" <cananian@lesser-magoo.lcs.mit.edu>
Reply-To: "C. Scott Ananian" <cananian@lesser-magoo.lcs.mit.edu>
To: Andrew Derrick Balsa <andrebalsa@altern.org>
cc: Philip Gladstone <philip@raptor.com>, linux-kernel@vger.rutgers.edu
Subject: Re: new version of time.c
In-Reply-To: <98071317313602.00441@lw2l.bnc.interdrome.fr>
Message-ID: <Pine.GSO.3.96.980713122418.3514A-100000@miris.lcs.mit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

On Mon, 13 Jul 1998, Andrew Derrick Balsa wrote:

> On Mon, 13 Jul 1998, Philip Gladstone wrote:
> >This code suffers from the same problem that all the existing
> >do_fast code suffers from -- namely, the assumption that the timer
> >interrupt is processed exactly on the 100Hz tick.
[...]
> Excellent, and the cost is not high at all (2 I/O cycles every 10 ms).
> 
> Just one microscopic knitpicking, if you allow me: since reading the TSC is
> *much* faster than latching the 8253/82C54 CTC, it should come first.
> 
> And a question:
> What are and why did you do those changes in /kernel/time.c? (I mean, I
> understood those in /arch/i386/kernel/time.c)

I agree with Andre's assessment and questions.  Since we're banging on
*i386*-architecture time brokenness, we should be very careful to leave
the other architectures' stuff alone.  Also, I'm very queasy about messing
with the inherent time hard-limits which protect monotonicity.

I'd love to see the improvements in your patch merged with the
improvements in Andre's 2.0.x and my 2.1.x patches.
  --Scott
                                                         @ @
 =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-oOO-(_)-OOo-=-=-=-=-=
 C. Scott Ananian: cananian@lcs.mit.edu  /  Declare the Truth boldly and
 Laboratory for Computer Science/Crypto /       without hindrance.
 Massachusetts Institute of Technology /META-PARRESIAS AKOLUTOS:Acts 28:31
 -.-. .-.. .. ..-. ..-. --- .-. -..  ... -.-. --- - -  .- -. .- -. .. .- -.
 PGP key available via finger and from http://www.pdos.lcs.mit.edu/~cananian



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.altern.org/andrebalsa/doc/lkml-faq.html
