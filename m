Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422692AbWA1Bdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422692AbWA1Bdl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 20:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422780AbWA1Bdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 20:33:41 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20641 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422692AbWA1Bdl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 20:33:41 -0500
Date: Fri, 27 Jan 2006 20:33:04 -0500 (EST)
From: Linus Torvalds <torvalds@osdl.org>
To: Marc Perkel <marc@perkel.com>
cc: Chase Venters <chase.venters@clientec.com>,
       "linux-os \\(Dick Johnson\\)" <linux-os@analogic.com>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Patrick McLean <pmclean@cs.ubishops.ca>,
       Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
In-Reply-To: <43D94A4B.8060902@perkel.com>
Message-ID: <Pine.LNX.4.64.0601271948340.3192@evo.osdl.org>
References: <43D114A8.4030900@wolfmountaingroup.com> <20060120111103.2ee5b531@dxpl.pdx.osdl.net>
 <43D13B2A.6020504@cs.ubishops.ca> <43D7C780.6080000@perkel.com>
 <43D7B20D.7040203@wolfmountaingroup.com> <43D7B5C4.5040601@wolfmountaingroup.com>
 <43D7D05D.7030101@perkel.com> <D665B796-ACC2-4EA1-81E3-CB5A092861E3@mac.com>
 <Pine.LNX.4.61.0601251537360.4677@chaos.analogic.com>
 <Pine.LNX.4.64.0601251512480.8861@turbotaz.ourhouse>
 <Pine.LNX.4.64.0601251728530.2644@evo.osdl.org> <43D94A4B.8060902@perkel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Jan 2006, Marc Perkel wrote:
>
> Just for clarification. What you are saying is that anyone who insists on
> contributing to the kernel under GPLv3 - that code would be prohibited from
> being included in the kernel? That to contribute to the kernel you must
> contribute under the terms presently in place?

No. We actually have a lot of code that is more widely licensed than just 
GPLv2. There's the GPL/BSD code, and there's a lot of files that have the 
".. or any later version" addendum which means that they are GPLv3 
compatible.

The only thing that the kernel requires is that since the majority of the 
code is actually GPLv2-only, that in order for you to be able to link with 
the code, your license has to be GPLv2-compatible.

A "GPLv3 _only_" license is not compatible with GPLv2, since v3 adds new 
limitations to re-distribution. But what you can do is to dual-license the 
code - the same way we've had GPL/BSD dual licenses. Of course, that 
effectively becomes the same as "GPLv2" with the "any later version" 
clause, but if you like the v3 in _particular_, you can actually mention 
it specifically (ie you can dual-license under "v2 _or_ v3", but without 
the "any later version" wording if you want).

Note that the Linux kernel has had the clarification that the "by default, 
we're version-2 _only_" for a long time, and that limitation is not a new 
thing.

You can argue that I should have made that clear on "Day 1" (back in 1992, 
when the original switch to the GPL happened), but the fact is, all of the 
development for the last five or more years has been done with that "v2 
only, unless otherwise stated" (I forget exactly when it happened, but it 
was before we even started using BK, so it's a loong time ago).

Also, this has been discussed before, and anybody who felt that they 
didn't want to have the "v2 only" limitation has been told to add the "or 
any later version" thing to their own code, so nobody can claim that I 
restricted their licensing. 

So to recap:

 - Linux has been v2-only for a _loong_ time, long before there was even 
   any choice of licenses. That explicit "v2 only" thing was there at 
   least for 2.4.0, which is more than five years ago. So this is not some 
   sudden reaction to the current release of GPLv3. This has been there 
   quite _independently_ of the current GPLv3 discussion.

 - if you disagree with code you write, you can (and always have been 
   able) to say so, and dual-license in many different ways, including 
   using the "or later version" language. But that doesn't change the fact 
   that others (a _lot_ of others) have been very much aware of the "v2 
   only" rule for the kernel, and that most of the Linux kernel sources 
   are under that rule.

 - People argue that Linux hasn't specified a version, and that by virtue 
   of paragraph 9, you'd be able to choose any version you like. I 
   disagree. Linux has always specified the version: I don't put the 
   license in the source code, the source code just says

	Copyright (C) 1991-2002 Linux Torvalds

   and the license is in the COPYING file, which has ALWAYS been v2. Even 
   before (for clarification reasons) it explicitly said so.

   In other words, that "if no version is mentioned" simply isn't even an 
   argument. That's like arguing that "if no license is mentioned, it's 
   under any license you want", which is crap. If no license is mentioned, 
   you don't have any license at all to use it. The license AND VERSION 
   has always been very much explicit: linux/COPYING has been there since 
   1992, and it's been the _version_2_ of the license since day 1.

   People can argue against that any way they like. In the end, the only 
   way you can _really_ argue against it is in court. Last I saw, 
   intentions mattered more than any legalistic sophistry. The fact that 
   Linux has been distributed with a specific version of the GPL is a big 
   damn clue, and the fact that I have made my intentions very clear over 
   several years is another HUGE clue.

 - I don't see any real upsides to GPLv3, and I do see potential 
   downsides. Things that have been valid under v2 are no longer valid 
   under v3, so changing the license has real downsides.

Quite frankly, _if_ we ever change to GPLv3, it's going to be because 
somebody convinces me and other copyright holders to add the "or any later 
license" to all files, just because v3 really is so much better. It 
doesn't seem likely, but hey, if somebody shows that the GPLv2 is 
unconsitutional (hah!), maybe something like that happens. 

So I'm not _entirely_ dismissing an upgrade, but quite frankly, to upgrade 
would be a huge issue. Not just I, but others that have worked on Linux 
over the last five to ten years would have to agree on it. In contrast, 
staying with GPLv2 is a no-brainer: we've used it for almost 15 years, and 
it's worked fine, and nobody needs any convincing.

And that really is a big issue: GPLv2 is a perfectly fine license. It has 
worked well for us for fourteen years, nothing really changed with the 
introduction of GPLv3. The fact that there is a newer license to choose 
from doesn't detract from the older ones.

			Linus
