Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264266AbTLERUd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 12:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264260AbTLERUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 12:20:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:51411 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264245AbTLERUC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 12:20:02 -0500
Date: Fri, 5 Dec 2003 09:19:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Peter Chubb <peter@chubb.wattle.id.au>
cc: Nick Piggin <piggin@cyberone.com.au>, Paul Adams <padamsdev@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
In-Reply-To: <16336.16523.259812.642087@wombat.chubb.wattle.id.au>
Message-ID: <Pine.LNX.4.58.0312050853200.9125@home.osdl.org>
References: <20031204235055.62846.qmail@web21503.mail.yahoo.com>
 <3FCFCC3E.8050008@cyberone.com.au> <16336.2094.950232.375620@wombat.chubb.wattle.id.au>
 <3FD00CD2.2020900@cyberone.com.au> <16336.16523.259812.642087@wombat.chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 5 Dec 2003, Peter Chubb wrote:
>
> As I understand it, SCO is/was claiming that JFS and XFS are derived
> works of the UNIX source base, because they were developed to match
> the internal interfaces of UNIX, and with knowledge of the internals
> of UNIX -- and they hold the copyrights of and are the licensor of UNIX.

Yes, and I'm not claiming anything like that.

I claim that a "binary linux kernel module" is a derived work of the
kernel, and thus has to come with sources.

But if you use those same sources (and _you_ wrote them) they do not
contain any Linux code, they are _clearly_ not derived from Linux, and you
can license and use your own code any way you want.

You just can't make a binary module for Linux, and claim that that module
isn't derived from the kernel. Because it generally is - the binary
module not only included header files, but more importantly it clearly is
_not_ a standalone work any more. So even if you made your own prototypes
and tried hard to avoid kernel headers, it would _still_ be connected and
dependent on the kernel.

And note that I'm very much talking about just the _binary_. Your source
code is still very much yours, and you have the right to distribute it
separately any which way you want. You wrote it, you own the copyrights to
it, and it is an independent work.

But when you distribute it in a way that is CLEARLY tied to the GPL'd
kernel (and a binary module is just one such clear tie - a "patch" to
build it or otherwise tie it to the kernel is also such a tie, even if you
distribute it as source under some other license), you're BY DEFINITION
not an independent work any more.

(But exactly because I'm not a black-and-white person, I reserve the right
to make a balanced decision on any particular case. I have several times
felt that the module author had a perfectly valid argument for why the
"default assumption" of being derived wasn't the case. That's why things
like the AFS module were accepted - but not liked - in the first place).

This is why SCO's arguments are specious. IBM wrote their code, retained
their copyrights to their code AND THEY SEVERED THE CONNECTION TO SCO'S
CODE (and, arguably the connections didn't even exist in the first place,
since apparently things like JFS were written for OS/2 as well, and the
Linux port was based on that one - but that's a separate argument and
independent of my point).

See the definition of "derivative" in USC 17.1.101:

	A "derivative work" is a work based upon one or more preexisting
	works, such as a translation, musical arrangement, dramatization,
	fictionalization, motion picture version, sound recording, art
	reproduction, abridgment, condensation, or any other form in which
	a work may be recast, transformed, or adapted. A work consisting
	of editorial revisions, annotations, elaborations, or other
	modifications which, as a whole, represent an original work of
	authorship, is a "derivative work".

And a binary module is an "elaboration" on the kernel. Sorry, but that is
how it IS.

In short: your code is yours. The code you write is automatically
copyrighted by YOU, and as such you have the right to license and use it
any way you want (well, modulo _other_ laws, of course - in the US your
license can't be racist, for example, but that has nothing to do with
copyright laws, and would fall under a totally different legal framework).

But when you use that code to create an "elaboration" to the kernel, that
makes it a derived work, and you cannot distribute it except as laid out
by the GPL. A binary module is one such case, but even just a source patch
is _also_ one such case. The lines you added are yours, but when you
distribute it as an elaboration, you are bound by the restriction on
derivative works.

Or you had better have some other strong argument why it isn't. Which has
been my point all along.

			Linus
