Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262130AbSKYAXz>; Sun, 24 Nov 2002 19:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262190AbSKYAWy>; Sun, 24 Nov 2002 19:22:54 -0500
Received: from dp.samba.org ([66.70.73.150]:2234 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262089AbSKYAWu>;
	Sun, 24 Nov 2002 19:22:50 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: John Levon <levon@movementarian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Module Refcount & Stuff mini-FAQ 
In-reply-to: Your message of "Tue, 19 Nov 2002 02:40:32 -0000."
             <20021119024032.GA99837@compsoc.man.ac.uk> 
Date: Mon, 25 Nov 2002 10:02:00 +1100
Message-Id: <20021125003005.451342C0E9@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021119024032.GA99837@compsoc.man.ac.uk> you write:
> On Tue, Nov 19, 2002 at 09:58:56AM +1100, Rusty Russell wrote:
> 
> >    The previous code required to implement the two module loading
> >    system call, the module querying system call, and the /proc/ksyms
> >    output, required a little more code than the current x86 linker.
> 
> This makes it sound like you're not bringing /proc/ksyms back (or an
> equivalent to let userspace know where modules are loaded). I hope this
> isn't the case...

I implemented the minimal subset: it's trivial to put back.  The
important question is why do you want it?  Do you only want it when
CONFIG_MODULES=y?  Do you only want the exported symbols, or all
symbols?

If this is for oprofile to figure out where modules are, then an entry
in /proc/modules seems more appropriate, yes?

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
