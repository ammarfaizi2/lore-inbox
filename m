Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283869AbRLABW7>; Fri, 30 Nov 2001 20:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283866AbRLABWn>; Fri, 30 Nov 2001 20:22:43 -0500
Received: from ns.ithnet.com ([217.64.64.10]:48392 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S283869AbRLABWX>;
	Fri, 30 Nov 2001 20:22:23 -0500
Date: Sat, 1 Dec 2001 02:21:57 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Larry McVoy <lm@bitmover.com>
Cc: akpm@zip.com.au, phillips@bonn-fries.net, hps@intermeta.de,
        jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
Message-Id: <20011201022157.38ed90b5.skraw@ithnet.com>
In-Reply-To: <20011130155740.I14710@work.bitmover.com>
In-Reply-To: <OF8451D8AC.A8591425-ON4A256B12.00806245@au.ibm.com>
	<E169scn-0000kt-00@starship.berlin>
	<20011130110546.V14710@work.bitmover.com>
	<E169vcF-0000lQ-00@starship.berlin>
	<E169vcF-0000lQ-00@starship.berlin>
	<20011130155740.I14710@work.bitmover.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2001 15:57:40 -0800
Larry McVoy <lm@bitmover.com> wrote:

> [...]
> Here's how you get both.  Fork the development efforts into the SMP part
> and the uniprocessor part.  The uniprocessor focus is on reliability,
> stability, performance.  The SMP part is a whole new development effort,
> which is architected in such a way as to avoid the complexity of a
> traditional SMP implementation.
> 
> The uniprocessor team owns the core architecture of the system.  The
> abstractions provided, the baseline code, etc., that's all uni.  The
> focus there is a small, fast, stable kernel.
> 
> The SMP team doesn't get to touch the core code, or at least there is 
> a very strong feedback loop against.  In private converstations, we've
> started talking about the "punch in the nose" feedback loop, which means
> while it may be necessary to touch generic code for the benefit of SMP,
> someone has to feel strongly enough about it that they well sacrifice
> their nose.

Hi Larry,

let me first tell you this: I am only stating my very personal opinion here and
am probably no guy of your experience or insight in high-tech delevopment
groups. But I saw the whole business for quite some years now, so my thinking:

Your proposal is the wrong way, because:
1) You split up "the crew". Whatever you may call "the crew" here, they all
have one thing in common: they are working on the _same_ project _and_ (very
important either) _one_ man has the final decision. If you look at _any_ other
OS developed by quite a number of completely different people you have to admit
one thing: everything was busted when they began to split up in different
"branches". That simply does not work out. I am only referring to simple human
interaction and communication here, nothing to do with the technical issues.
One of the basic reasons for the success of Linux so far is the collaborated
work of a damn lot of people on the _same_ project.

2) I cannot see the _need_ for such a "team-splitup". If you say one team (core
team) has the "last word" about the baseline code, what do you think will
happen if "necessary" code changes for the second team will be refused? Simple:
they will fork a completely new linux-tree. And this is _the_ end. If you were
to write a driver, what tree will you choose after that? I mean you are dealing
with the main reason why people like linux, here. And not: SCO Unix 3.x,
Unixware, Solaris, Minix, AT&T Unix, Xenix, HPUX, AIX, BSD, NetBSD, BSDi,
Solaris-for-Intel, make-my-day ... (all registered trademark of their
respective owners, which have all low interaction capabilities)
I don't want that, do we want that?

3) Your SMP team (you are talking of true high scaled SMP here) has a very big
problem: it has _very_ few users (compared to UP) and even less developers with
the _hardware_ you need for something like that. I mean you are not talking
about buying an Asus Board and 2 PIII here, you talk about serious, expensive
hardware here. How many people have this at home, or at work for free playing?
Well, see what I mean?

4) Warning, this is the hard stuff!
Ok, so you are fond of SUN. Well, me too. But I am not completely blind, not
yet :-) So I must tell you, if Solaris were the real big hit, then why its
Intel-Version is virtualy been eaten up on the market (the _buying_ market out
there) by linux? The last time I met a guy seriously talking about Solaris
(x86) being "better" than Linux was about three years ago. And btw, this was
_the_ last guy talking about it at all. So lets simply assume this: the Solaris
UP market is already gone, if you are talking about the _mass_ market. This
parrot is _deceased_! It is plain dead.
Now you are dealing with another problem: SUN (being kind of the last resort of
a widespread and really working commercial unix) will have a lot of work to do
in the future to keep up with the simple mass of software and application
coming in for linux, only because it is even _more_ widespread today than
Solaris has ever been. And it is _real_ cheap, and you get it _everywhere_. And
everybody owns a box on which you can use it.
This is going to get very hard for SUN, if they do not enter a stage of
complete rethinking what is going on out there.
To make that clear: _nobody_ here _fights_ against SUN or Solaris. Quite a few
of us like it very much. But this is a commercial product. It needs to be sold
to survive - and that is going to be a future problem. SUN will not survive
only building the high-power low-mass computer. CRAY did not either. So maybe
the real good choice would be this: let the good parts of Solaris (and maybe
its SMP features) migrate into linux. This does not mean they should lay off
the staff, just on contrary: these are brilliant people, let them do what they
can do best, but keep an eye on the market. We are in the state of: the market
_demands_ linux. It has already become a well-known trademark, I tend to
believe better-known than Solaris. Somehow one has the feeling they indeed know
whats coming (fs), but have not come to the final (and hard to take)
conclusion.
And to clarify: I am not taking any drugs. This is serious. I have the strong
feeling, that there is already a big player out there, that has learnt a hard
lesson: IBM - and the lesson named OS/2.
When OS/2 came out, I told the people: if they are not going to give it away
for free, they will not make it. And they didn't. Indeed I did not expect them
to learn at all (simply because big companies are mostly not quick-movers), but
they do really astonishing things nowadays. I have the strong feeling the
management is at least as brilliant as the Solaris developpers and worth every
buck, too.

But this is only my small voice, and quite possibly only few are listening, if
any ...

Regards,
Stephan

PS: Is this really a topic for a kernel-mailing-list?

