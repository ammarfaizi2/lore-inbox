Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316902AbSFVVKA>; Sat, 22 Jun 2002 17:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316903AbSFVVJ7>; Sat, 22 Jun 2002 17:09:59 -0400
Received: from hawk.mail.pas.earthlink.net ([207.217.120.22]:22948 "EHLO
	hawk.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S316902AbSFVVJ5>; Sat, 22 Jun 2002 17:09:57 -0400
Message-ID: <05ce01c21a31$1a2c3660$1125a8c0@wednesday>
From: "jdow" <jdow@earthlink.net>
To: "Rob Landley" <landley@trommello.org>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Jeff Garzik" <jgarzik@mandrakesoft.com>, "Larry McVoy" <lm@bitmover.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "Linus Torvalds" <torvalds@transmeta.com>,
       "Cort Dougan" <cort@fsmlabs.com>, "Benjamin LaHaise" <bcrl@redhat.com>,
       "Rusty Russell" <rusty@rustcorp.com.au>, "Robert Love" <rml@tech9.net>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <E17LmrQ-0002vp-00@the-village.bc.nu>
Subject: Re: Linux, the microkernel (was Re: latest linus-2.5 BK broken)
Date: Sat, 22 Jun 2002 14:09:30 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>

> > A microkernel design was actually made to work once, with good performance.
> > It was about fifteen years ago, in the amiga.  Know how they pulled it off?
> > Commodore used a mutant ultra-cheap 68030 that had -NO- memory management
> > unit.
>
> Vanilla 68000 actually. And it never worked well - the UI folks had
> to use a library not threads. The fs performance sucked

Some things just cannot be passed by..... The Amiga HAS worked well and
DOES work well - - - FINALLY. (It took several years and a VERY serious
debugging effort with Bill Hawes and Bryce Nesbitt finding and quashing
all manner of bad or missing pointer checks and the like. They made the
OS itself a remarkable work of art.)

You are right, Alan, in that it used a vanilla, slow, 68000 in its original
incarnation. A company named Metacomco generated the "DOS" part of the
system. IMAO they should have been sued for malpractice. The only good feature
the file system had was its resilience. Had it been coded correctly loss of
data would have been hard to achieve short of physical disk problems. Later
incarnations of the file system proved it could be remarkably fast accessing
specific files. Directory listings remain agonizingly slow.

The OS "exec" library is remarkably compact, quick, and resilient. It does
suffer from not using memory protection. However, in a testament to some
Amiga programmers AmigaDOS can survive months of up time with typical single
user loads with its latest incarnation. (My slightly hypertrophied A3000T
sits over there running some applications for me 24x7 quite nicely, thank
you.) This has had me musing about the relative quality of Linux applications
that blithely throw segfaults rather than check for overflows, null pointers,
and the like. I'd NEVER let the typical Linux application touch my Amigas for
two reasons, the crashes are annoying and they mean there are security holes
waiting for exploitation.

Having "everything" in the system a shared library has some advantages for
updating things on the fly without reboots, as is routinely exploited within
the Linux world. A side effect of the way this was implemented yields a
rather endearing Amiga trait, you cannot exceed array boundaries in most of
the OS and shared libraries. Arrays are eschewed in favor of linked lists.

'Tis a shame the idiots who owned and ran the company sucked it dry and
tossed the remains. The OS could wring remarkable performance out of rather
antiquated hardware, well in excess of what Apple could wring out of the
same hardware.

{^_-}   I am rather fond of the tool. And I note it has (and in some instances
        still) performed admirably in near real-time applications such as
        show control (EFX in Las Vegas for one) and telemetry reception and
        analysis (at NASA.) To be sure AmigaDOS 1.0 through 1.3 were rather
        dreadful. 2.04 was remarkable. No AmigaDOS was EVER even approximately
        as bad as an abortion I had to work on called GRiD-OS, however.

