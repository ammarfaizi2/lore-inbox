Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264035AbUDFVib (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 17:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264046AbUDFVia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 17:38:30 -0400
Received: from web40509.mail.yahoo.com ([66.218.78.126]:59141 "HELO
	web40509.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264035AbUDFVi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 17:38:28 -0400
Message-ID: <20040406213827.35076.qmail@web40509.mail.yahoo.com>
Date: Tue, 6 Apr 2004 14:38:27 -0700 (PDT)
From: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Subject: Re: kernel stack challenge 
To: Valdis.Kletnieks@vt.edu
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200404062001.i36K1429024400@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Valdis.Kletnieks@vt.edu wrote:
> On Tue, 06 Apr 2004 11:16:03 PDT, Sergiy Lozovsky
> said:
> 
> > My code works during system calls (before the real
> > one). Interrupts are enabled. If it enters the
> loop
> > scheduler still can switch tasks (using timer for
> > example). If it doesn't work in such way I can
> easily
> > call schedule(); implicitly after some time limit
> will
> > be reached - it's VM, so it's easy to do such
> things.
> 
> Yes, but your security manager is *still* in an
> infinite loop, and eventually
> you *will* come to a grinding halt, as each process
> gets queued up waiting for
> a decision from the security manager.

No. VXE has completely different architecture.
Separate logical copy of LISP program is for each
subsystem we protect. (sure they share the same code
of LISP interpreter). So, if there will be any
problems - it's for particular subsystem only. Other
subsystems (protected and not protected) will not be
affected.

It's like event driven model. There is no constantly
running servers.

> As an aside, the original posting said it was a
> restricted subset of Lisp that
> didn't include recursion.  Aside from the technical
> difficulties of detecting
> two or more routines that mutually recurse, it's
> unclear that Lisp without
> recursion is at all interesting or useful....

It's misunderstanding. There are no any recursion
restrictions. Author of particular security model
(LISP program) should avoid recursions; it's not very
hard actually. When we write program at language other
than LISP - we rarely use recursion. Yes, it's against
LISP style, but not a big problem.
 
> This is sounding more and more like the old adage:
> "When all you have
> is a hammer, everything starts looking like a
> thumb".

I know the better one.

"As all Real Programmers know, the only useful data
structure is the Array. Strings, Lists, Structures,
Sets-- these are all special cases of arrays and can
be treated that way just as easily without messing up
your programming language with all sorts of
complications."

http://www.pbm.com/~lindahl/real.programmers.html

Serge :-)

__________________________________
Do you Yahoo!?
Yahoo! Small Business $15K Web Design Giveaway 
http://promotions.yahoo.com/design_giveaway/
