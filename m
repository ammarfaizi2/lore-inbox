Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264919AbTLFEjY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 23:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264941AbTLFEjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 23:39:24 -0500
Received: from fw.osdl.org ([65.172.181.6]:5057 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264919AbTLFEjN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 23:39:13 -0500
Date: Fri, 5 Dec 2003 20:39:03 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Larry McVoy <lm@bitmover.com>
cc: Erik Andersen <andersen@codepoet.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Paul Adams <padamsdev@yahoo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux GPL and binary module exception clause?
In-Reply-To: <20031206030037.GB28765@work.bitmover.com>
Message-ID: <Pine.LNX.4.58.0312051949210.2092@home.osdl.org>
References: <20031204235055.62846.qmail@web21503.mail.yahoo.com>
 <20031205004653.GA7385@codepoet.org> <Pine.LNX.4.58.0312041956530.27578@montezuma.fsmlabs.com>
 <20031205010349.GA9745@codepoet.org> <20031205012124.GB15799@work.bitmover.com>
 <Pine.LNX.4.58.0312041750270.6638@home.osdl.org> <20031206030037.GB28765@work.bitmover.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


IANAL.

On Fri, 5 Dec 2003, Larry McVoy wrote:
>
> However, if someone did take derived code (which is now covered by the
> viral license) and add it illegally to Linux, it is entirely reasonable
> for the license holder to say that all of Linux now has the virus.

You are making a classic mistake, which is to confuse "license" and
"copyright", and mixing them together.

[ Caveat: I'm obviously not a lawyer, but I've talked to a number of them
  over the years, and this is my understanding. Make of it what you will. ]

Copyright (aka "ownership" of the code) and licenses are entirely
different animals, and they have very little to do with each other
legally. Except for the fact that the license can only be set by the
owner.  But even when you set the license, the license _remains_ a
separate issue from the ownership itself.

So a license is _independent_ of the copyright on a work. You can have
multiple licenses for a work that is copyrighted by one person, and you
can have a single license for a work that is copyrighted by multiple
people. Or you can have no license at all (or no copyright, but at that
point the license loses its meaning, for other reasons - if the code is in
the public domain, anybody can pick it up and claim ownership, and so
everybody can set their own licenses. "No ownership" is a special case
because of that).

So the only thing that ties the two together is that only the copyright
holder can set the license. Other than that they are totally separate
things.

For example, I set the license on the kernel because I weas originally the
only copyright holder, which meant that I could use any license I pleased.
That ends up constraining later people, since they now have to follow the
rules - unlike me, they can't just make up the license for the original
code.

But if somebody else writes a piece of code for Linux, we now have a
situation where Linux is comprised of two pieces (a) the original work
(for simplicity, let's say it's copyright by person A) and (b) the new
work (copyright person B).

Now, (a+b) is the new work (joint copyrighted by A+B), and if the original
code (a) required the GPL, then (a+b) requires the GPL too due to the
"viral" nature of the GPL. You are right so far.

BUT THAT DOES NOT MEAN THAT PERSON B LOST _ANY_ RIGTHS WRT WORK (b).

In particular, person B can still license work (b) under any other
license. He cannot license (a+b) under any other license, since that is
required by the GPL to continue to be GPL, but he _can_ license the code
he retains full copyright to.

In particular, he can take his contribution (b), and combine it with
somebody elses contribution (c), and HE IS NOT BOUND BY THE GPL!

See?

The "viral" nature of the GPL does not actually "infect" the code itself.
Because ownership always overrides _any_ license. The owner is not bound
by the license, and can license it anew. See how "ownership" and "license"
are totally different things? One is subject to the other.

The code remains copyright to person B, and as long as it so remains
(which it does forever, unless B actively gives it away or the US congress
finally stops playing its silly games and lets copyrights expire
eventually), person B can re-license his code any which way he pleases.

Ask a lawyer. Any good lawyer.

It is only "(a+b)" that is a derived work. The code (b) that B wrote is
(as long as he didn't incorporate anybody elses work) remains his, and is
_not_ derived on its own.

(See the definition of derived that I quoted earlier: "derivation" really
requires actual combination).

But my claim is that if (b) is compiled into a Linux kernel module, then
it _is_ part of (a+b) whether (a) is physically present or not. So if
company B compiles their code (owned 100% by them) into a binary linux
kernel module, that _does_ make it a part of (a+b). "Physical location"
has nothing to do with derived works - and the fact that compaby B
compiled code (b) for Linux and then only distributes the (broken up) part
of (a+b) doesn't mean that (a+b) didn't exist.

See what I'm aiming at? I'm saying that B still owns the code (b), but if
he uses it "as part of (a+b)", he has to license the result under the GPL.
And that "compiles into a kernel module" _is_ using (b) as part of (a+b).

But he could _also_ compile the module into some other project (c). And
when used _that_ way, he can license that derivation of (b) any way that
makes sense from a standpoint of a derived work (b+c).

And if he uses code (b) stand-alone (ie does not combine it with anything
at all that anybody else owned), he can use the result any way he wants
to.

I'll bet you a dollar that a copyright lawyer will tell you that my
argument is not incorrect. He probably won't agree with me (since no
lawyers ever agree on _anything_ as far as I can tell) but I really think
he'll say "yeah, seeing it that way is not incompatible with copyright
law".

>								  Just
> as reasonable as someone saying "hey, that's the Linux XYZ driver in
> Solaris, Solaris is now GPLed".

No. That's not what anybody sane is claiming. Let's have this following
schenario:

    (a) is the Linux kernel and is licensed entirely under the GPL
	(and can have hundreds of copyright owners)

    (b) is a driver written and thus owned by party B

    (c) is Solaris, copyright Sun and others.

And the rule is: only an OWNER can accept a license.

So (a+b) is possible only licensed under the GPL, and only if B accepts
the GPL.

And (b+c) is possible only if there is some license that B and Sun can
agree on. If the only license that B agrees to is the GPL, then the only
way (b+c) is possible is if Sun agrees to license (c) under a
GPL-compatible license.

In other words, if (b) is GPL-only, then you can't use (b) with (c), _or_
C has to accept the GPL. "Forcing" a (b+c) doesn't make (c) be under the
GPL. But forcing (b+c) is illegal, since you can't force a license without
the agreement of the owner.

IANAL.

			Linus
