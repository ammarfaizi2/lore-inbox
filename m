Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263987AbUDFUCb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 16:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263988AbUDFUBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 16:01:44 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:26300 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S263987AbUDFUBS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 16:01:18 -0400
Message-Id: <200404062001.i36K1DsD004198@eeyore.valparaiso.cl>
To: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel stack challenge 
In-Reply-To: Your message of "Mon, 05 Apr 2004 14:21:52 MST."
             <20040405212152.54101.qmail@web40513.mail.yahoo.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Tue, 06 Apr 2004 16:01:13 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergiy Lozovsky <serge_lozovsky@yahoo.com> said:
> --- Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> > Sergiy Lozovsky <serge_lozovsky@yahoo.com> said:
> > 
> > [LISP inside the kernel?!]
> > 
> > > Basically there are two reasons.
> > > 
> > > 1. Give system administrator possibility to change
> > > security policy easy enough
> > 
> > SELinux
> 
> To create a new 'security model' one should write a C
> program within Selinux user space security server.
> People like to use higher level languages.

C is a high level language. If you don't like it, use C++, Perl, Ruby, TCL,
Guile, Common LISP, PostScript, ... It's userspace, program in whatever you
like most.

> > >                             without C programminig
> > > inside the kernel (we should not expect system
> > > administartor to be a kernel guru).

> > As 97.572% of the job has to be done in userland anyway, place your
> > checks/high-level language/GUI frobnitzer in there at will. Compile to a
> > compact, easy-to-handle, digitally signed, binary blob and stuff _that_
> > into the kernel as needed.

> I'm not ready to put a binary compiled with Common
> Lisp or PERL (if it exists)

Yep.

>                             compilers into the kernel.

Again.... use something written in C, Perl, Common LISP, even COBOL to
parse the description and generate a binary blob from it that you then
stuff into the kernel. No in-kernel runtime for high-level general purpose
languages needed at all.

> At the same time I want people to benefit from using
> high level langages (even kernel gurus don't use
> Assembler all the time, higher level languages is
> easier to use and less lines of code to write).

Kernel gurus write C and think assembler. Wrong crowd selected ;-)

> .....
> 
> > > 2. Protect system from bugs in security policy
> > > created by system administrator (user).

> > Sounds like you are demanding a solution to Turing's test here... and
> > also to the halting problem.

> I didn't claim that I solve all problems on earth :-)

You certainly do. How do you protect the system from a mistaken policy that
takes away all rights from the user supposed to manage it, and gives them
to the local script kiddie instead?

> What I can claim:
> 1. Some kernel parts can be developed with language of
> higher level than C.

It efficiency doesn't matter, do it in userland. If efficiency matters, do
it in hand-tuned C + assembly, inside the kernel only if there is no other
way.

> 2. Problems with such parts can be to some extent be
> encapsulated within VM (no, it's not 100% fool prof
> for sure), but it helps.

Doing it in userland helps even more.

> 3. Code can be easily debugged in the user space
> (running with user space VM) and used in the kernel
> after that.

The environment isn't the same, so this doesn't help that much. Besides, if
the job _can_ be done in userland, it has no business being done in the
kernel. Stuff is being moved _out_ of the kernel (for example, finding
partitions and filesystems) as we speak...

[...]

> LISP code is located in the kernel. Application issues a system call LISP
> program checks arguments of this call. If LISP program fails (crashes) -
> VM will return default value which is EACCESS, so application will get
> 'access denied'. (and will fail, probably).

So the idea is _userland_ code stuffed into the _kernel_ to be checked and
executed there? And if it is broken, and denies all access, it is a nice
DoS.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
