Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263444AbUDGCZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 22:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263450AbUDGCZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 22:25:27 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:55732 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S263444AbUDGCZU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 22:25:20 -0400
Message-Id: <200404070225.i372PIn9003521@eeyore.valparaiso.cl>
To: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel stack challenge 
In-Reply-To: Your message of "Tue, 06 Apr 2004 14:15:50 MST."
             <20040406211550.30263.qmail@web40514.mail.yahoo.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Tue, 06 Apr 2004 22:25:18 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergiy Lozovsky <serge_lozovsky@yahoo.com> said:

[...]

> I didn't just pick up LISP - I EXPLAINED my reasons.
> if you missed my explanation here is a short summary.
> 
> 1. I needed solution to implement some procedural
> functionality within the kernel. 

Fair enough, if really needed.

>                                  This functionality
> should be expressed with some high level language
> (shorter development time and more compact source
> code).

That it is _expressed_ in a sky-high-level-language has nothing at all to
do with _implementing_ said language (fully?) inside the kernel. Heck, the
kernel has no built-in C compiler + development environment + runtime
either!

>        This functionality should be
> loadable/unloadable to the kernel.

A compact, easy to interpret blob pushed into the kernel, a module hooking
into the "right places", ...

> 2. Size of the interpreter should be minimal.

Zero is just about right for me.

> 3. Kind of real time - no ordinary garbage collector.
> And automatic memory management at the same time.

Oxymoron.

> 4. Easiest syntax possible - so interpreter would be
> compact. Simpler - the better :-) I don't like
> complicated things :-)

Why do you need the interpreter in kernel? If you do need it, why does it
have to be a general-purpose language, and not an "interpreter" for a
stylized data structure, carefully designed for the task?

> 5. Well known. So there would be people around who
> already know this language and expectations are clear.
> And there are books around about this language.

C is fine in that sense. Even much better than LISP. Specially among the
sysadmin/kernel hacker/general Unix geek crowd...

> 6. Ability to handle/represent complex data
> structures.

C qualifies.

> 7. Errors/bugs in loadable functions should not cause
> trouble for other tasks and kernel itself. (To the
> extent possible for sure).

Hard to do in any case. Just be careful...

> 8. It should be universal (general purpose) language
> which gives ability to make any manipulations with
> numbers, strings, bits and data structures. So I would
> be sure that functionality I want to express is not
> limited by the language.

But _why_? 
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
