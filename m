Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267595AbTBEAJ7>; Tue, 4 Feb 2003 19:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267602AbTBEAJ7>; Tue, 4 Feb 2003 19:09:59 -0500
Received: from dp.samba.org ([66.70.73.150]:63189 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267595AbTBEAJ6>;
	Tue, 4 Feb 2003 19:09:58 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Module alias and device table support. 
In-reply-to: Your message of "Tue, 04 Feb 2003 09:45:48 -0800."
             <200302041745.JAA16796@adam.yggdrasil.com> 
Date: Wed, 05 Feb 2003 11:17:05 +1100
Message-Id: <20030205001933.E3C282C5E1@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200302041745.JAA16796@adam.yggdrasil.com> you write:
> Rusty Russell responded to someone else (whom Rusty didn't name, and
> whom I didn't immediately find in the archives):
> >"insmod foo" will *always* get foo.  The only exception is when "foo"
> >doesn't exist, in which case modprobe looks for another module which
> >explicitly says it can serve in the place of foo.
> 
> 	I think perhaps we should separate the name spaces so that the
> kernel never modprobes for an actual module file name.  In other
> words, there would only be three ways in which a module would
> "automatically" be loaded:

This sounds like a good idea to me: the current approach is very
ad-hoc.  I think we're headed in the right direction, for example the
alias patch introduces "pci:" and "usb:" prefixes for hotplug (and if
you look very hard, there's already a "symbol:" prefix, unused, in the
tree).

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
