Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314735AbSEHQyj>; Wed, 8 May 2002 12:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314740AbSEHQyi>; Wed, 8 May 2002 12:54:38 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43021 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314735AbSEHQyg>; Wed, 8 May 2002 12:54:36 -0400
Date: Wed, 8 May 2002 09:54:03 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Juan Quintela <quintela@mandrakesoft.com>
cc: Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
In-Reply-To: <m2r8knkrkt.fsf@demo.mitica>
Message-ID: <Pine.LNX.4.44.0205080945450.4991-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 8 May 2002, Juan Quintela wrote:
> linus> (Side note: I'm afraid that don't think backwards compatibility weighs
> linus> very heavily on an embedded setup - I'm more thinking about things like "a
> linus> regular RedHat/SuSE/Debian/whatever install won't work any more".)
>
> here at Mandrake we have a patch for the install kernel to remove the
> /proc/ide, and  I think that we got it from redhat, that means that at
> least two distros preffer to save ~25kb in the boot kernels than the
> reporting that they do :p

Well, that's a good sign in that it implies that things certainyl work
fine without /proc/ide.

However, I think I phrased things badly: I'm not actually worried about
the RedHat or Mandrake "act of installation" itself - since that will
always use whatever kernel RH or Mandrake put on their CD's, and they can
always change their install scripts/programs to match the kernel they use.

I'm more worried about the issue of "I installed RH-x.x, and then I
upgraded the kernel, and now program xyz won't work any more", where "xyz"
is something perfectly reasonable and common.

For example, let's say that some strange version of "mount" _requires_
/proc/ide to work (don't ask me why), and that Mandrake happened to ship
that version in their 8.2 release, and if you use the new 2.5.15 kernel on
that installation, it simply won't work. THAT would be a problem where
some backwards compatibility crud is probably worth it.

But if /proc/ide removal breaks an embedded device (on which the kernel is
not normally upgraded by "normal" people that aren't willing to upgrade
other stuff at the same time), I won't worry too much. Or if the /proc/ide
changs mean that the actual installer has to be re-done, I won't worry.

And even breaking one or two applications might be quite acceptable: I
worry more about maintainability than _perfect_ backwards compatibility.

		Linus

