Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284243AbRLAUju>; Sat, 1 Dec 2001 15:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284244AbRLAUjn>; Sat, 1 Dec 2001 15:39:43 -0500
Received: from Ptrillia.EUnet.sk ([193.87.242.40]:16512 "EHLO meduna.org")
	by vger.kernel.org with ESMTP id <S284243AbRLAUja>;
	Sat, 1 Dec 2001 15:39:30 -0500
From: Stanislav Meduna <stano@meduna.org>
Message-Id: <200112012039.fB1KdGq03665@meduna.org>
Subject: Re: Coding style - a non-issue
To: linux-kernel@vger.kernel.org
Date: Sat, 1 Dec 2001 21:39:16 +0100 (CET)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

wow, what a nice discussion. I am reading the l-k through an
archive, so please forgive me if I am going to say something
that was already said, but I did not yet read it.


Linus wrote:
> Don't underestimate the power of survival of the fittest.

Well, your theory is really an interesting view on the
software development. However, I think that there are
some points that need some more discussion.

First, you are probably right in the long-term. The nature
did have enough time for excursions in one or another
direction - the "project" of life is several orders of magnitude
older than a single generation. You say that it is possible
to help the evolution. But you still need many generations
to be sure that a good result at some stage is not only some
statistical variance.
 
The technology does not IMHO work that way - Linux (Unix
in all its flavours, Windows, ...) is very young.
We are not in the stage where life exists for millions
of years. We are in the stage where the first cells
have formed and are still quite vulnerable. There is only
a thin line between survival as a kind and extinction (sp?).
I think that in this stage not ignoring the role of
the design is a good thing (and no, I don't believe in God :-)).

Besides that, are you talking about evolution in general,
or about evolution of a particular kind? The competition
is not the same in these cases.

> - massive undirected parallel development ("trial and error") 

This is not what is happening here. The parallelism does
exist but is not massive in any way. There are not thousands
of people writing the same stuff. There are not even thousands
of people able to write a good bug report on a particular bug.
There are maybe three (as in the VM recently) authors of some
subsystem and in the end effect there is a God (or two after
a brief disagreement :-)) that decides. No way is this analogous
to the natural selection where the decision happens statistically
on a whole population. This works between Linux and Windows,
but not between implementation ideas.


Al Viro wrote:
> Fact of life: we all suck at reviewing our own code. You, me,
> Ken Thompson, anybody - we tend to overlook bugs in the code
> we'd written. Depending on the skill we can compensate

Absolutely. But what I really miss is an early-warning system.
No matter how good Linus might be in reviewing the submissions,
he cannot catch it all - nobody is _that_ good.

What I feel hurts the Linux is that the testing standards
are very, very low. Heck, Linus does not probably even compile
the code he releases with the widely used configuration options
(otherwise a non-compiling loop.o would not be possible).

Throwing releases onto the public is not testing. Saying
"it works/does not work for me" is not testing. Testing
is _actively_ trying to break things, _very_ preferably
by another person that wrote the code and to do it
in documentable and reproducible way. I don't see many
people doing it.


Linus wrote:
> And I will go further and claim that  no  major software project
> that has been successful in a general marketplace (as opposed
> to niches) has ever gone through those nice lifecycles they
> tell you about in CompSci classes.

Well, I don't know what they tell in the classes now - I am 33
and in this area the theories change much faster than practice :-)

> Have you  ever  heard of a project that actually started off
> with trying to figure out what it should do, a rigorous design
> phase, and a implementation phase?

I have heard of projects that did succeeded doing well defined
revision cycles with each cycle figuring out what more or better
it should do, the design of it (more or less rigorous),
implementation, then something what you forgot :-) - testing
and deployment.

The project I am working on now (a process control system)
exists for 15 years and is quite successful. It is vertical
market, not horizontal, but hardly a niche. More control
_did_ help it at one stage, where we had a little quality
crisis.


Maybe it is just because people tend to forget the wrong
things, but I have a strong feeling that Linux starts
to have problems with quality that we did not see before,
at least not in this amount. We are nearly a year in
the stable series and we need to change fundamental things
that broadly affect other parts - VM, devfs, ...  This is
not evolution, this is surgery. USB support was one big
argument for 2.4, yet it is far from stable.

My opinion is, that you are _very_ good at maintaining general
overview of a big chunk of code together with being able
to maintain a general direction that makes sense. I don't
think I know someone other that is able to do this. But
I also think that the kernel is in the stage where this
won't be much longer possible even for you. I have seen
software projects going through some kind of crisis
and the symptoms tended be very similar. In the early
stages there are tools (version management, bug reporting
system) and policies (testing standards) that can help.
In the later stages the crisis is in the management.
I cannot say from the outside (I am not doing active kernel
development), in what stage (if in any) the kernel is.
But I have the gut feeling that something should be done.

Evolution does not have the option to vote with its feet.
The people do. While Linux is not much more stable than it
was and goes through a painful stabilization cycle on every
major release, Windows does go up with the general stability with
every release. W2k were better than NT, XP are better than W2k.
Windows (I mean the NT-branch) did never eat my filesystems.
Bad combination of USB and devfs was able to do this in half
an hour, and this was vendor kernel that did hopefully get
more testing than that what is released to the general public.
I surely cannot recommend using 2.4 to our customers.

And frankly, I see the Microsoft borrowing ideas from the open
community. They make things more open - slow, but they are.
They are going to give out compilers for free and charge
for the (quite good and IMHO worth the money) IDE. They are
building communities. Guess why?...

You might of course say that you don't care - the nature
also basically does not care where the evolution is going.
I would like to see more control in the kernel development,
especially regarding quality standards.

Regards
-- 
                                 Stano

