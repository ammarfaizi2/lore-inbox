Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263989AbUDFUQi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 16:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263988AbUDFUQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 16:16:38 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:2757 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S263989AbUDFUQd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 16:16:33 -0400
Message-Id: <200404062016.i36KGV6d004291@eeyore.valparaiso.cl>
To: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel stack challenge 
In-Reply-To: Your message of "Mon, 05 Apr 2004 14:30:26 MST."
             <20040405213026.37258.qmail@web40512.mail.yahoo.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Tue, 06 Apr 2004 16:16:31 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergiy Lozovsky <serge_lozovsky@yahoo.com> said:
> --- Timothy Miller <miller@techsource.com> wrote:
> > 
> > 
> > Sergiy Lozovsky wrote:
> > 
> > > 
> > > 
> > > All LISP errors are incapsulated within LISP VM.
> > >  
> > 
> > 
> > A LISP VM is a big, giant, bloated.... *CHOKE*
> > *COUGH* *SPUTTER* 
> > *SUFFOCATE* ... thing which SHOULD NEVER be in the
> > kernel.
> 
> It is a smallest interpreter (of all purpose language)
> I was able to find. My guess is that you refer to the
> Common Lisp. it is huge and I don't use it.

Nope. Timothy was talking exactly of the same one as you. And I agree with
him.

> > If you want to use a more abstract language for
> > describing kernel 
> > security policies, fine.  Just don't use LISP.
> 
> Point me to ANy langage with VM around 100K.

Assembler. VM is exactly _zero_ overhead. Or C, for a tiny bit more. That
one was already paid for, so you essentially get it for free. Might also
hack FORTH, for a few KiB (dunno how much this days, but should be less
than 10 for a stripped to the bone package).

> > The right way to do it is this:
> > 
> > - A user space interpreter reads text-based config
> > files and converts 
> > them into a compact, easy-to-interpret code used by
> > the kernel.
> > 
> > - A VERY TINY kernel component is fed the security
> > policy and executes it.

Nodz!

> it is exactly the way it is implemented.

And how does an _in kernel_ LISP interpreter fit into this picture? Lost me
there...

>                                          Not everyone
> need to create their own security model (that VERY
> TINY kernel component you refer to).

Now we have common ground...

>                                      But even for
> those who want to modify or create their own VERY TINY
> kernel component - they don't need to do that in C and
> debug it in th kernel crashing it.

... of sorts.

Right, I don't want the security kernel inside the kernel crashing. But
then again, I don't want the driver for the hard disk, or the mouse, or
even the graphic card, scribbling over memory either. Guess you'd (re)write
the whole kernel in some LISP dialect then? Good luck! But this is
_certainly_ the worst list to discuss such a design.


[...]

> > Why do you choose LISP?  Don't you want to use a
> > language that sysadmins 
> > will actually KNOW?
> 
> It was is) the smallest VM I know of.

You know little...

> 99% of sysadmins don't need to create their own
> security models. Security polices are created with web
> interface very close to the way you described. So
> sysadmin don't need to know anything about LISP (to
> use predefined security models).

OK, so you need the policy to be interpreted in-kernel (dunno why a
largeish high-level general purpose language is needed for that, when a
tiny interpreter for a specialized language will do very well, and has been
shown to work fine), and written in a "high level language" so that your
garden variety sysadmin _can_ write her own policy, but it really doesn't
matter because she'll never have to do so...

Completely lost me.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
