Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267327AbTBFOwZ>; Thu, 6 Feb 2003 09:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267328AbTBFOwZ>; Thu, 6 Feb 2003 09:52:25 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:34229 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S267327AbTBFOwY>; Thu, 6 Feb 2003 09:52:24 -0500
Message-Id: <200302061500.h16F0pqD004143@eeyore.valparaiso.cl>
To: Pavel@Janik.cz (Pavel =?iso-8859-2?q?Jan=EDk?=)
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: gcc 2.95 vs 3.21 performance 
In-Reply-To: Your message of "Wed, 05 Feb 2003 11:04:24 +0100."
             <m3k7gfjb6f.fsf@Janik.cz> 
Date: Thu, 06 Feb 2003 16:00:51 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel@Janik.cz (Pavel =?iso-8859-2?q?Jan=EDk?=) said:
> Linus Torvalds <torvalds@transmeta.com> said:
>    > lcc isn't really something I want to use, since the license is so
>    > strange, and thus can't be improved upon if there are issues with it.

> what is the difference between compiler and source management system
> regarding licenses and improvements?

That bk was designed around Linus' and other head kernel hackers ideas of
how it should work, and they are still bending over backwards to keep this
biggest _*non*_customer of theirs happy.

OTOH, lcc as a project seems to be dead for all practical purposes (it
looks like 4.2 will be the endo of the line, no patches or updates have
shown up for quite some time). Its licence
<http://www.cs.princeton.edu/software/lcc/pkg/CPYRIGHT> is vaguely BSDish,
but with a "you can't make money off this or any modified versions/software
based on it" clause.

I've been inside lcc 4.1 (current version is 4.2, somewhat different, so
YMMV...) myself a bit, and while it is a marvelous showpiece for classroom
use, it is sorely lacking in what makes a _real_ C compiler (for kernel
use).  For one, it only knows about i486-ish ia32 CPUs, to get others
supported in its current incarnation would be a massive excercise in
duplication or macro-massaging the backend source; other than the (very
good) optimal instruction selection there is very little optimization (what
there is is a bit of strength reduction), the organization of the compiler
makes adding aditional higher-level optimization almost impossible, a
separate SSA or such intermediate form would have to retrofitted; the
register selection is very simplistic and doesn't work correctly (some
experimental patches we had for generating PIC code on ia32 kept it
crashing by running out of registers the code for fixing this case up just
doesn't work). No hint at scheduling instructions or such.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
