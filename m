Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263210AbUDEVHl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 17:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263209AbUDEVH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 17:07:28 -0400
Received: from web40504.mail.yahoo.com ([66.218.78.121]:39737 "HELO
	web40504.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263199AbUDEVGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 17:06:25 -0400
Message-ID: <20040405210619.62488.qmail@web40504.mail.yahoo.com>
Date: Mon, 5 Apr 2004 14:06:19 -0700 (PDT)
From: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Subject: Re: kernel stack challenge 
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200404052043.i35KhDvS020176@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Valdis.Kletnieks@vt.edu wrote:
> On Mon, 05 Apr 2004 13:33:10 PDT, you said:
> 
> > I don't know how it is possible (if it is - it's
> easy
> > to fix). All LISP print functions print
> information
> > into the buffer of limited size. (LISP program has
> no
> > access to the format or buffer length arguments of
> > snprintf). When buffer is full or string has an \n
> at
> > the end - VM calls printk.
> 
> That's how it's *supposed* to work when everything
> is working *correctly*.
> 
> Now re-do your example, and assume there's a *BUG*
> in the VM.  For instance,

Here is a main idea. I can put a lot of effort to
debug VM once. I (and others) are not destined to do
such kind of debugging (with C inside the kernel)
after that. It's like with JAVA VM - it's hard to
debug VM, but it should be done once - after that JAVA
program can't use a pointer to a nonallocated memory.
Those who continue to use C - should be careful with
pointersin each program.

> what happens if there's a fencepost error on "buffer
> is full"?  All that takes
> is one line that says 'if (ptr > bufsize)' rather
> than 'if (ptr >= bufsize)'.
> 
> Yes, proper encapsulation *helps*.  But it's

Exactly. :-) i'm not claiming that I solve all
problems. But this technology helps to make
development of some kernel parts easier. Encapsulation
helps and you can easily debug LISP program in the
userspace before loading it into the kernel.

No matter what particular LISP program does - it can't
crash the kernel - C code can do that easily.

Serge.

> certainly *NOT* any sort of
> guarantee that *all* bugs will be stopped.  For
> comparison, read up on the Java
> VM - although it does a very good job of sandboxing
> a Java program, there
> *have* been bugs and exploits found over the
> years....
> 
> 

> ATTACHMENT part 2 application/pgp-signature 



__________________________________
Do you Yahoo!?
Yahoo! Small Business $15K Web Design Giveaway 
http://promotions.yahoo.com/design_giveaway/
