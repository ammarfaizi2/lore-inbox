Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262481AbUDEVlr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 17:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263281AbUDEVjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 17:39:24 -0400
Received: from web40513.mail.yahoo.com ([66.218.78.130]:41893 "HELO
	web40513.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263324AbUDEVVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 17:21:55 -0400
Message-ID: <20040405212152.54101.qmail@web40513.mail.yahoo.com>
Date: Mon, 5 Apr 2004 14:21:52 -0700 (PDT)
From: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Subject: Re: kernel stack challenge 
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200404052026.i35KQh5g004342@eeyore.valparaiso.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> Sergiy Lozovsky <serge_lozovsky@yahoo.com> said:
> 
> [LISP inside the kernel?!]
> 
> > Basically there are two reasons.
> > 
> > 1. Give system administrator possibility to change
> > security policy easy enough
> 
> SELinux

To create a new 'security model' one should write a C
program within Selinux user space security server.
People like to use higher level languages.
 
> >                             without C programminig
> > inside the kernel (we should not expect system
> > administartor to be a kernel guru).
> 
> As 97.572% of the job has to be done in userland
> anyway, place your
> checks/high-level language/GUI frobnitzer in there
> at will. Compile to a
> compact, easy-to-handle, digitally signed, binary
> blob and stuff _that_
> into the kernel as needed.

I'm not ready to put a binary compiled with Common
Lisp or PERL (if it exists) compilers into the kernel.
At the same time I want people to benefit from using
high level langages (even kernel gurus don't use
Assembler all the time, higher level languages is
easier to use and less lines of code to write).

.....

> > 2. Protect system from bugs in security policy
> created
> > by system administrator (user).
> 
> Sounds like you are demanding a solution to Turing's
> test here... and also
> to the halting problem.

I didn't claim that I solve all problems on earth :-)
What I can claim:
1. Some kernel parts can be developed with language of
higher level than C.
2. Problems with such parts can be to some extent be
encapsulated within VM (no, it's not 100% fool prof
for sure), but it helps.
3. Code can be easily debugged in the user space
(running with user space VM) and used in the kernel
after that.
 
> >                                 LISP interpreter
> is a
> > LISP Virtual Machine (as Java VM).
> 
> So what? If the policy just leaves out everybody, or
> lets anybody fool
> around with the hardware, you are royally screwed in
> any case.

I didn't get the question.

> >                                    So all bugs are
> > incapsulated and don't affect kernel. Even severe
> bugs
> > in this LISP kernel module can cause termination
> of
> > user space application only (except of stack
> overflow
> > - which I can address). LISP error message will be
> > printed in the kernel log.
> 
> If it is running in userspace, why do you place the
> interpreter in the kernel?

LISP code is located in the kernel. Application issues
a system call LISP program checks arguments of this
call. If LISP program fails (crashes) - VM will return
default value which is EACCESS, so application will
get 'access denied'. (and will fail, probably).

Serge.

__________________________________
Do you Yahoo!?
Yahoo! Small Business $15K Web Design Giveaway 
http://promotions.yahoo.com/design_giveaway/
