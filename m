Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262783AbSLIERo>; Sun, 8 Dec 2002 23:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262796AbSLIERo>; Sun, 8 Dec 2002 23:17:44 -0500
Received: from dp.samba.org ([66.70.73.150]:4049 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262783AbSLIERn>;
	Sun, 8 Dec 2002 23:17:43 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>, "" <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>
Subject: Re: [TRIVIAL] Re: setrlimit incorrectly allows hard limits to exceed soft limits 
In-reply-to: Your message of "Fri, 06 Dec 2002 11:07:00 -0200."
             <Pine.LNX.4.50L.0212061106050.22252-100000@duckman.distro.conectiva> 
Date: Mon, 09 Dec 2002 10:34:34 +1100
Message-Id: <20021209042525.1CF2E2C383@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.50L.0212061106050.22252-100000@duckman.distro.conectiva>
 you write:
> On Fri, 6 Dec 2002, Rusty Trivial Russell wrote:
> 
> > > Just try "ulimit -H -m 10000" for memory limits that were not
> > > previously set.  You end up with (hard limit = 10000) < (soft limit =
> > > unlimited).
> 
> > +       if (new_rlim.rlim_cur > new_rlim.rlim_max)
> > +               return -EINVAL;
> 
> Wouldn't it be better to simply take the soft limit down
> to min(new_rlim.rlim_cur, new_rlim.rlim_max) ?

POSIX says -EINVAL, and since it's a programmer fuckup, I'd agree.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
