Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751468AbWAaUnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbWAaUnE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 15:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWAaUnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 15:43:03 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23688 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751468AbWAaUnB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 15:43:01 -0500
Date: Tue, 31 Jan 2006 12:38:12 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chase Venters <chase.venters@clientec.com>,
       "linux-os \\(Dick Johnson\\)" <linux-os@analogic.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, Marc Perkel <marc@perkel.com>,
       Patrick McLean <pmclean@cs.ubishops.ca>,
       Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
In-Reply-To: <43DFB0F2.4030901@wolfmountaingroup.com>
Message-ID: <Pine.LNX.4.64.0601311152070.7301@g5.osdl.org>
References: <43D114A8.4030900@wolfmountaingroup.com> 
 <20060120111103.2ee5b531@dxpl.pdx.osdl.net>  <43D13B2A.6020504@cs.ubishops.ca>
 <43D7C780.6080000@perkel.com>  <43D7B20D.7040203@wolfmountaingroup.com> 
 <43D7B5C4.5040601@wolfmountaingroup.com> <43D7D05D.7030101@perkel.com> 
 <D665B796-ACC2-4EA1-81E3-CB5A092861E3@mac.com> 
 <Pine.LNX.4.61.0601251537360.4677@chaos.analogic.com> 
 <Pine.LNX.4.64.0601251512480.8861@turbotaz.ourhouse> 
 <Pine.LNX.4.64.0601251728530.2644@evo.osdl.org>  <1138387136.26811.8.camel@localhost>
  <Pine.LNX.4.64.0601272101510.3192@evo.osdl.org> <1138620390.31089.43.camel@localhost.localdomain>
 <Pine.LNX.4.64.0601310931540.7301@g5.osdl.org> <43DF9D42.7050802@wolfmountaingroup.com>
 <Pine.LNX.4.64.0601311032180.7301@g5.osdl.org> <43DFB0F2.4030901@wolfmountaingroup.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 31 Jan 2006, Jeff V. Merkey wrote:
>
> > I did _not_ put that language in, which is the whole point.
> 
> If you can provide this beyond all doubt, then I agree you have a solid 
> basis to object.

It's really easy to prove.

Look at core kernel source code today, and look at it 10 years ago. Look 
at it 15 years ago. Nothing has changed.

The really core files have copyright notices like this:

	/*
	 *  kernel/sched.c
	 *
	 *  Kernel scheduler and related syscalls
	 *
	 *  Copyright (C) 1991-2002  Linus Torvalds
	...

with absolutely no mention of any license rights at all. Not "this is 
under the GPL", not "GPLv2 or later". The _only_ license rights anybody 
ever had to those files come from the COPYING file, which very clearly 
states that it's "version 2, 1991"

(And yes, I'm a lazy bastard. I don't update the years. Some of the files 
I wrote still say "1991, 1992" even though they've obviously been edited 
since by me. If they fall into the public domain a couple of years 
earlier, I really don't see myself caring, since I will have been dead for 
a long while by that time _anyway_, judging by the current copyright 
nonsense).

[ Side note: the _core_ kernel files are more universally GPL v2-only than 
  the rest of the kernel. So for example, while almost a third of all C 
  files have the "any later version" notice in them, when you look at just 
  the core files in kernel/ mm/ fs/, it's a _lot_ less rare. For example, 
  in fs/*.c, it's only two files out of 57, and those aren't even the most 
  core files.

  So _qualitatively_, a lot more than "just" two thirds of the kernel are 
  based on my core files, and are GPLv2 _only_. The "..any later version" 
  stuff tends to exist mostly in drivers (and some filesystems: 9pfs, 
  afs, autofs, cifs, jfs, ntfs, ocfs2 have the "any later version" in 
  them, but the most common ones do not, and are often derived 
  (admittedly very indirectly, by now) from my original code. ]

> However, it being there does make the whole arguments 
> nebulous. I would suggest removing any such language from kernel.org and 
> state GPLv2 ONLY.

The COPYING file was edited (over _five_ years ago) to clarify the issue, 
exactly because some people were confused. So the COPYING file now 
explicitly says:

 Also note that the only valid version of the GPL as far as the kernel
 is concerned is _this_ particular version of the license (ie v2, not
 v2.2 or v3.x or whatever), unless explicitly otherwise stated.

and that has been the case for the last 5+ years.

(Another clarification is even older: the clarification that using "normal 
system calls" is _not_ considered linking, and thus the GPL doesn't infect 
any normal user-level programs. That one is over ten years old, since some 
people seriously worried about it. Again, it was really pretty obvious 
from the license itself, but the clarification made the question stop and 
made some people stop worrying unnecessarily).

Alan argues that that extra notice "changed" the license (and that any 
code that is older than 5 years would somehow not be GPLv2). I argue 
otherwise. I argue that for the whole history, Linux has been v2-only 
unless otherwise explicitly specified.

And I don't think even Alan will argue that the "v2 only" thing hasn't 
been true for the last five years.

> I was also under the impression based on the language "any later license"
> and I am a very bright chap. So if I got it wrong, then imagine how many other
> folks are likely to be confused.

Exactly. That's why I added the clarification on top of the COPYING file: 
people _have_ been confused.

That confusion doesn't stem from Linux, btw, but from the FSF distribution 
of the GPLv2 license itself. The license is distributed as one single 
file, which actually contains three parts: (1) the "preamble", (2) the 
actual license itself and (3) the "How to Apply These Terms to Your New 
Programs" mini-FAQ.

And that third part actually contains the wording "(at your option) any 
later version.", but a lot of people seemed to not realize that this was 
just part of a FSF-suggested boiler-plate on what to put in your source 
files.  In other words, that was never actually part of the license 
itself, but just a "btw, here's how you should use it" post-script.

A lot of people seemed to be confused by that, and this is exactly why the 
Linux COPYING file got the additional explanation.

(Side note: from a legal standpoint, "intent" does actually matter in the 
US legal system. So the FSF can actually argue that their pre-amble and 
their post-script to the license carry legal weight, because it shows 
their _intent_. However, they can only argue that for programs that they 
own copyright to, or when the license itself might be unclear - they can't 
argue that it shows _my_ intent. I've made my intent very clear over the 
years, and I've been consistent on this matter, so nobody can claim that 
I've "changed the rules").

> Alan is trying to help you. I have never seen him do anything other than 
> support you to the hilt. Sure, disagreements happen, but he is there for 
> you and Linux and has been from day one.

Absolutely. And I actually try to be very open to changing my mind if 
somebody has a valid point. Open source is absolutely not about just the 
source code - it's very much about the process, and about (mostly the lack 
of) control.

And hey, Alan tends to be mostly right in his concerns. Which is why he's 
so respected in the community. I just think that he is off the deep end on 
this one, and I have yet to see any actual convincing arguments for his 
standpoint. 

> Linus, remove all nebulous language and post a notice on kernel.org 
> clarifying your position on this code, and I think the issue becomes 
> closed.

The thing is, even the _clarification_ HAS BEEN THERE FOR 5 YEARS. At the 
very top of the COPYING file.

This really is nothing new. How much more prominent can it be than be in 
the top-level COPYING file that gets distributed with every single kernel 
version?

> > Because let's face it, the burden on proof on changing the kernel license is
> > on _Alan_, not me. Alan is the one arguing for change.  
> 
> A change to GPLv3 would be a good thing for you.

A lot of people like the GPLv3. I personally don't _dislike_ the current 
draft, but I don't think it's appropriate for the kernel. Part of why I 
liked the GPL in the first place (v2 at that point, obviously - v3 hadn't 
even been thought about) was that it put no restrictions at all on the 
_use_ of binaries. 

So I actually prefer the GPLv2. I don't think the current GPLv3 draft is 
"evil" or "bad", or anything like that, but it's not the license I would 
have selected when I started, and I don't see any reason to change to it 
for the kernel.

			Linus
