Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269676AbRHQEyX>; Fri, 17 Aug 2001 00:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269698AbRHQEyP>; Fri, 17 Aug 2001 00:54:15 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:29713 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S269676AbRHQEyJ>; Fri, 17 Aug 2001 00:54:09 -0400
Message-Id: <200108170454.f7H4sJI91243@aslan.scsiguy.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Patch: remove DB dependence of linux-2.4.9/drives/scsi/aic7xxx/aicasm 
In-Reply-To: Your message of "Thu, 16 Aug 2001 21:22:20 PDT."
             <20010816212220.A7151@baldur.yggdrasil.com> 
Date: Thu, 16 Aug 2001 22:54:19 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>A wise CS proff once said, "Smart programmers are lazy.  They
>>re-use stuff rather than write it over and over again."  In this
>>case, I was able to implement my symbol table in all of 5 mintues
>>without the need to debug the code that implements its core.  It
>>may seem like overkill, but it allowed me to focus on the important
>>things, like making the assembler useful.  The assember dates from
>>1995, which might explain why it uses the dbv1 interface.
>>
>>"If it ain't broke, don't fix it."
>
>	That was probably a good use of your time, and those are
>good reasons in the absense of arguments to the contrary.  However,
>in this case, there are arguments to the contrary, so it is a question
>of which arguments outweigh the others.  The arguments for accepting
>a trival DB implementation (I'm not asking you to write it) are:
>
>	1. It eliminates another dependence for doing a complete source build.

In the past, although firmware was available in source form, the tools
were not.  You always had to rely on the precompiled firmware to build
a kernel.  If you really insist on building the firmware, you're probably
an aic7xxx developer (okay, you're an exception, but I don't understand
why your so interested in building it...), and are willing to understand
what's involved in tweaking the firmware, its assembler, etc.  Prior to
the new driver coming into the tree, did you pull down the FreeBSD sources
to the aicasm utility and port it to Linux so you could build everything
from source? 8-)

>	2. It potentially eliminates a dependence on a GPL'ed library,
>	   a policy preference of at least one Linux distribution that I
>	   can think of (Debian), and probably a preference of some users.

DB v1.85 isn't GPLed.

>	3. (New) it's a handy fallback in case somone finds a buggy
>	   DB implementation.

There is always DB 1.85...

>	Anyhow, I've done it.

And unfortunately its GPLed.  The rest of the driver and assembler are
available, optionally, under the more lenient BSD style copyright.  As
the driver runs on multiple platforms, many of which dislike the GPL, I
cannot allow GPL only code into the core portions of the driver.

Additional code, is, well, additional code - to understand and/or
maintain.  Libraries were invented to avoid this problem.  So I used
a library, along with several other tools (yacc, lex), to make my life
easier.  These decisions don't make aicasm a good bootstraping utility, but
aicasm isn't needed to bootstrap the system.  It isn't needed to build
the kernel.  You seem to have a solution in search of a problem.

--
Justin
