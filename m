Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265102AbRFUSrV>; Thu, 21 Jun 2001 14:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265103AbRFUSrL>; Thu, 21 Jun 2001 14:47:11 -0400
Received: from isimail.interactivesi.com ([207.8.4.3]:64008 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S265102AbRFUSq5>; Thu, 21 Jun 2001 14:46:57 -0400
Date: Thu, 21 Jun 2001 13:46:48 -0500
From: Timur Tabi <ttabi@interactivesi.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <200106211814.f5LIEgK04880@snark.thyrsus.com>
Subject: Re: Controversy over dynamic linking -- how to end the panic
X-Mailer: The Polarbar Mailer; version=1.19a; build=73
Message-ID: <qi1bhC.A.lfF.ZEkM7@dinero.interactivesi.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** Reply to message from "Eric S. Raymond" <esr@snark.thyrsus.com> on Thu, 21
Jun 2001 14:14:42 -0400


> To calm down the lawyers, I as the principal kernel maintainer and
> anthology copyright holder on the code am therefore adding the
> following interpretations to the kernel license:
> 
> 1. Userland programs which request kernel services via normal system
>    calls *are not* to be considered derivative works of the kernel.
> 
> 2. A driver or other kernel component which is statically linked to
>    the kernel *is* to be considered a derivative work.
> 
> 3. A kernel module loaded at runtime, after kernel build, *is not*
>    to be considered a derivative work.

Although these are good things to add, I don't think they're compatible with
the GPL.  That is, Linus can't just state these "interpretations" and add them
to the GPL, because it will weaken the GPL as a whole.  I say that because you
do not include any language that clarifies that from a legal sense.

I heard recently that kernel modules are technically, from the GPL
point-of-view, a derivative work, because they include kernel header files.
However, since Linus understands that this precludes binary-only modules, he has
"made an exception" to the Linux kernel license.

The problem with that is that I have never seen any written evidence of this.

IANAL, but IMO, there are only two solutions:

1. License the Linux kernel under a different license that is effectively the
GPL but with additional text that clarifies the binary module issue.
Unfortunately, this license cannot be called the GPL.  Politically, this would
probably be a bad idea.

2. License the Linux kernel under TWO licenses, one the GPL, and another which
talks about the binary module issue.  Unfortunately, this would probably not
work either, as technically these two licenses are incompatible.

I guess what I'm trying to say is that this issue won't be resolve simply by
some "interpretations" by Linus as to what is and is not a derived work.  I
think the FSF needs to be involved in this.

To be honest, I disagree that #include'ing a GPL header file should force your
app to be GPL as well.  That may be how the license reads, but I think it's a
very bad idea.  I could write 1 million lines of original code, but if someone
told me that but simply adding #include <stdio.h> my code is now a derivative of
the stdio.h, I'd tell him to go screw himself.


-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

