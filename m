Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263143AbUJ2AHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263143AbUJ2AHo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 20:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263111AbUJ2AAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 20:00:06 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:33661 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263154AbUJ1Xsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 19:48:42 -0400
From: Blaisorblade <blaisorblade_spam@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: Why UML often does not build (was: Re: [PATCH] UML: Build fix for TT w/o SKAS)
Date: Fri, 29 Oct 2004 01:49:31 +0200
User-Agent: KMail/1.7.1
Cc: Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>
References: <20041027053602.GB30735@taniwha.stupidest.org> <200410282254.21944.blaisorblade_spam@yahoo.it> <20041028214242.GB2269@taniwha.stupidest.org>
In-Reply-To: <20041028214242.GB2269@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410290149.31665.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 October 2004 23:42, Chris Wedgwood wrote:
> On Thu, Oct 28, 2004 at 10:54:21PM +0200, Blaisorblade wrote:
> > I'm not absolutely able, for instance, to understand the update for
> > generic IRQs.

> > 1) the Linux Kernel often breaks when using certain GCC versions or
> > certain binutils, and has to be fixed.
>
> this almost never happens these days, especially for i386 and amd64
>
> i dont think i can recall it happenning in a big way for over a year
> now

Yes, it's true. That happens because with tons of developers, beta-gcc 
releases are pre-tested every time.

> > But UML is a binary doing the most unusual things on the world
> > around, so it must cope also with different versions of libc /
> > binutils / host kernel.

> UML also has to cope with ptrace changes and any semantics related to
> this.  there has been some flux in this area recently and it's not
> over yet sadly

> UML is the most complicated ptrace-using code i think ive ever seen :)
> and some of the code probably relies on semantics which are not well
> defined so keeping up with those changes is important
Yes, it was using SIGKILL instead of PTRACE_KILL; this gets broken by 2.6.9.

> part of that might be noticing when it breaks and screaming at roland,
> i dont know
"screaming at roland"? Ah, ok, I guess you mean Roland McGrath (roland (at) 
redhat (dot) com ), who seems to be ptrace maintainer. At least he was the 
author of all late ptrace changes I've seen until now.

> > 2) Uml is often not cared by mainline developers. It was merged in
> > 2.6.9 and remained unworking for ages just because Linus ignored UML
> > patches for ages.

> was it submitted?  i really don't this the merge barrier is that high
> from a maintainer for things like linux/arch/<foo> in most cases
Yes, it was. It's an old, old story. You can take a look here, starting from 
"24 Mar 2003".

http://user-mode-linux.sourceforge.net/diary.html

> the same is true for various drivers (it must be, so many of them are
> horribly broken in places)

> > And right now, if UML does not compile it's for the Ingo Molnar's
> > hardirq patch and for a missed silly prototype change for a TTY api
> > change (they fixed the UML user, ended up changing one UML function
> > prototype, forgot to do a trivial update to one user.

> UML has been described as 'abandonware' amongst other things, this
> isn't completely unjustified.
Well, I've seen Christoph Hellwig not particularly happy about us, see for 
instance:

http://linux.bkbits.net:8080/linux-2.5/cset@41752cc9xdFXib-03VDV5akqKJZ-yA?nav=index.html|
ChangeSet@-7d

(I must admit I read one of those two emails he talks about).

I've seen instead, for instance, Jeff Garzik giving a try to UML and reporting 
back.

> Any efforts I think to help keep it 
> more inline with the rest of the kernel to change this perception I
> think are great --- if we can get enough cleanups in, we might even be
> able to get more of the mainline people buildling and checking against
> UML so we get let breakage in the future.

> I think to do this we should first fix some of the bogons we have
> before adding new code and features.

Well, adding new features could also attract some developers. I want to fix 
bugs, but how much people will come to UML just to test CPU-hotplug on a 
normal PC? That's possible (after we cleanup the SMP code, which is suffering 
a lot, as for that spinlock deadlock in the UBD driver we've discussed time 
ago).

> > 4) We are too few. The currently active developers (and I mean only
> > the one which this month have being working on it) are:

> if we can get things more inline (fixes, track mainline, dont add new
> features just yet) i think we can get more people to help out

> right now it's too hard (too much effort) to most people to deal with

> anyhow, i think enough has been said as we are mostly in voilent
> agreement, if we can keep poking away at this i think we have a pretty
> good shot and making UML less of a second-class citizen

I agree on what you say. In fact, I'm not adding new features right now, 
mostly. There is a whole lot of things I would like to do (mostly bug fixes) 
but I'm mostly working on one-liners. Sending a patch requires at least 
proof-reading it and writing a meaningful changelog. Also, managing mails 
takes tons of time.

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
