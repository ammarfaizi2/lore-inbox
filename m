Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267182AbSLaHjb>; Tue, 31 Dec 2002 02:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267185AbSLaHjb>; Tue, 31 Dec 2002 02:39:31 -0500
Received: from dp.samba.org ([66.70.73.150]:25485 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267182AbSLaHja>;
	Tue, 31 Dec 2002 02:39:30 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>, `@samba.org
Subject: Re: 2.5.53 : modules_install warnings 
In-reply-to: Your message of "Mon, 30 Dec 2002 21:27:01 CDT."
             <Pine.LNX.3.96.1021230212600.8353B-100000@gatekeeper.tmr.com> 
Date: Tue, 31 Dec 2002 18:14:55 +1100
Message-Id: <20021231074756.2B9AC2C10B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.3.96.1021230212600.8353B-100000@gatekeeper.tmr.com> you wr
ite:
> On Sun, 29 Dec 2002, Rusty Russell wrote:
> 
> > In message <Pine.LNX.4.44.0212281758230.839-100000@linux-dev> you write:
> > > Hello all,
> > >   I received the following warnings while a 'make modules_install'. It 
> > > looks like there are a few more locking changes that need to be made. :)
> > 
> > This is SMP, right?  Those warnings are perfectly correct (yes, those
> > files need updating).
> 
> Any guess when you'll get them fixed?

I've discovered an interesting (but kinda obvious) phenomenon.  If you
destabilize some part of the kernel, it becomes the natural suspect
for problems.

The corollary is, I'm getting more reports on kernel "module" bugs
which are not actually my fault at all (and some, like erroneous
__init sections, which the new module code just shows up).

This is one: these drivers are actually broken.  They give warnings on
compile, they won't link when compiled in, and they won't insert as
modules.

Hope that clarifies,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
