Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282707AbRLBDnw>; Sat, 1 Dec 2001 22:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282708AbRLBDnn>; Sat, 1 Dec 2001 22:43:43 -0500
Received: from fc.capaccess.org ([151.200.199.53]:20228 "EHLO fc.Capaccess.org")
	by vger.kernel.org with ESMTP id <S282703AbRLBDnh>;
	Sat, 1 Dec 2001 22:43:37 -0500
Message-id: <fc.00858412002088750085841200208875.208896@Capaccess.org>
Date: Sat, 01 Dec 2001 22:45:48 -0500
Subject: design help requested and offered
To: linux-kernel@vger.kernel.org
Cc: linux-assembly@vger.kernel.org
From: "Rick A. Hohensee" <rickh@Capaccess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have the display portions of a new design for a text editor working on
Linux, using the console vt102 emulation. It's written in osimpa, which is
my shasm assembler-in-Bash with some composites, i.e. "macros", i.e. sub-C
high-level stuff. Unlike Randy Hyde's HLA, I don't do DO/WHILE and so on.
For intra-routine flow control I have labels, "jump", "when", and
execution arrays. osimpa also has nifty copy-on-write-parameter-passing
( COWPP(TM) :o) procedures, but I haven't bothered with them for this
editor thing. I just call/return and push/pull or use a temp or whatever
when I run out of registers. The handiest thing for apps is the Linux
syscall wrapper, which is pretty simple and flexible.

This means osimpa is useable. As a little message to myself I gave away my
K&R2. I suspect osimpa is easier to learn than C. It codes a bit slower, I
suppose, but it's clearly very easy for an assembler. I also believe it's
very close to being portable across commodity one-stack CPUs, and can be
made entirely so with minimal performance loss. It's greatest strengths
probably lie in coding an OS. There is no high/low-level seam. (Well, not
like C/asm, but not self-extensible like Forth either.) It has one install
dependancy, a unix-sh-like command interpreter.  The osimpa script is
116k, including gobs of help text. It doesn't prevent anything. It's
trivial to extend the compembler itself. It's not bad for a one-stack
system.

When I get the editor comfy, I'll be about due to have a go at my kernel
design. I have a PC bootsector that can handle interrupts from pmode in
pmode or in real mode. I do mean sector, 512 bytes. I'm not really a
details
guy though. All my stuff is rough sketches, although I've been working on
some of these cartoons for ten years. The kernel sketch is in

 ftp://linux01.gwdg.de/pub/cLIeNUX/interim/
                                                and I think the filename
is "design". The ABOUT file in that ftp directory is like a readme.  The
idea that allowed it to stop swirling long enough to write it down was
"everything is a device". Any process can publish itself as a device-like
service. It resembles OOP and a microkernel, but both resemblances are
accidents. Those were not goals, and still aren't.  Modeling my 3-stack
machine at some level is still a goal. Some of it will be quite alien, but
some of it will be easier for a unix kernel hacker to mentally model than
it is for me. Comments cordially requested. Particularly comments of the
"if I understand what you mean, part BLA doesn't work" variety. Many
aspects of this design could be inflicted on e.g. a Linux 1.0.x, which I
kinda started to do persuant to my asm("") rant here, but I have had my
fill of pointers to void.

A (deeply knowledgeable) Lisp weenie on IRC with an OS project of his own
was kind enough to review my design and typed "Ok, looking at this as an
overview, I see a re-invention of UNIX, only worse."

*bow*

Peace, love, hard realtime with three stacks

Rick Hohensee
cLIeNUX user 0


