Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129162AbQKBUyF>; Thu, 2 Nov 2000 15:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129179AbQKBUxz>; Thu, 2 Nov 2000 15:53:55 -0500
Received: from smtpnotes.altec.com ([209.149.164.10]:3857 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S129162AbQKBUxt>; Thu, 2 Nov 2000 15:53:49 -0500
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: "J . A . Magallon" <jamagallon@able.es>, Cort Dougan <cort@fsmlabs.com>,
        gmack@innerfire.net, Jeff Garzik <jgarzik@mandrakesoft.com>,
        Andrew Morton <andrewm@uow.edu.au>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Gregory Maxwell <greg@linuxpower.cx>,
        Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
cc: linux-kernel@vger.kernel.org
Message-ID: <8625698B.0072B9BF.00@smtpnotes.altec.com>
Date: Thu, 2 Nov 2000 14:53:33 -0600
Subject: Re: Where did kgcc go in 2.4.0-test10 ?
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



A number of people have pointed out to me that egcs-1.1.2 is weak on C++
support.  Rather than clutter up the list by replying to all of them, I've
picked this one to say "Thank you" to everyone who responded.  I'm not a C++
programmer, so I tend to forget about it and think of gcc as just a C compiler.
Now this discussion makes more sense to me.

I agree that if there is going to be a separate compiler for the kernel, the
Makefiles should be flexible enough to allow the user to plug in whatever
compiler he or she prefers to use.

Wayne




"J . A . Magallon" <jamagallon@able.es> on 11/02/2000 06:40:58 AM

To:   Wayne Brown/Corporate/Altec@Altec
cc:   linux-kernel@vger.kernel.org

Subject:  Re: Where did kgcc go in 2.4.0-test10 ?




On Thu, 02 Nov 2000 06:46:04 Wayne.Brown@altec.com wrote:
>
>
> I've been following this kgcc discussion with interest for weeks now and
> there's
> one thing that still puzzles me.  Everyone on both sides of the issue seems to
> be saying that kgcc (AKA egcs 1.1.2) is used because the gcc versions shipped
                       ^^^^^^^^^^^^^^^
Wrong assumption. The idea is if I need a way to set a compiler for kernel
that is not the same compiler as the system wide one. Should kernel Makefiles
use gcc (hardcoded) (and people must have a 'gcc' that works for kernel), or
let kernel use something called 'kgcc', and let user decide if in his machine
kgcc is 2.7, egcs or 2.95.2.

> by
> several vendors don't compile the kernel correctly.  What I haven't seen yet
> is
> an explanation of why kgcc can't be used for compiling *everything* and why
> another compiler even needs to be installed.

Because gcc is not only the C compiler, is the full compiler system.
The support for C++ in 2.95 has nothing to do with egcs. And 2.95 supports
java, for example.
And the libraries. The C++ standard library is much better in 2.95 that in
egcs.


--
Juan Antonio Magallon Lacarta                          mailto:jamagallon@able.es

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
