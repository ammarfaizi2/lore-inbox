Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129458AbQLXAIX>; Sat, 23 Dec 2000 19:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129595AbQLXAIM>; Sat, 23 Dec 2000 19:08:12 -0500
Received: from devnull.owl.de ([193.174.11.4]:32526 "EHLO devnull.owl.de")
	by vger.kernel.org with ESMTP id <S129458AbQLXAIA>;
	Sat, 23 Dec 2000 19:08:00 -0500
Date: Sun, 24 Dec 2000 00:36:48 +0100
From: Matthias Schniedermeyer <ms@citd.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Michael Chen <michaelc@turbolinux.com.cn>, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: About Celeron processor memory barrier problem
Message-ID: <20001224003648.A4642@citd.de>
In-Reply-To: <4015029078.19991223172443@turbolinux.com.cn> <Pine.LNX.4.10.10012230920330.2066-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.10.10012230920330.2066-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Dec 23, 2000 at 09:21:51AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >         I found that when I compiled the 2.4 kernel with the option
> >     of Pentium III or Pentium 4 on a Celeron's PC, it could cause  the
> >     system hang at very beginning boot stage, and I found the problem
> >     is cause by the fact that Intel Celeron doesn't have a real memory
> >     barrier,but when you choose the Pentium III option, the kernel
> >     assume the processor has a real memory barrier.
> >     Here is a patch to fix it:
> 
> No.
> 
> The fix is to not lie to the configurator.
> 
> A Celeron isn't a PIII, and you shouldn't tell the configure that it is.
> 
> The whole point of being able to choose the CPU to optimize for is that we
> can optimize things at compile-time.

This is what 2.2.17 thinks about my Celeron 600MHz

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 601.374
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
pat pse36 mmx fxsr xmm
bogomips        : 1199.31






Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
