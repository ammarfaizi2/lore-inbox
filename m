Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263056AbTJJQud (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 12:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263058AbTJJQud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 12:50:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:57773 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263056AbTJJQuT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 12:50:19 -0400
Date: Fri, 10 Oct 2003 09:50:02 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Joel Becker <Joel.Becker@oracle.com>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: statfs() / statvfs() syscall ballsup...
In-Reply-To: <20031010162606.GB28773@ca-server1.us.oracle.com>
Message-ID: <Pine.LNX.4.44.0310100939300.20420-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 10 Oct 2003, Joel Becker wrote:
> 
> 	Memory is continuously too small and too expensive.  Even if you
> can buy a machine with 10TB of RAM, the price is going to be
> prohibitive.  And when 10TB of RAM costs better, the database is going
> to be 100TB.

Hah. 

Look at the number of supercomputers and the number of desktops today.

The fact is, the high end is getting smaller and smaller. If Oracle wants 
to go after that high-end-only market, then be my guest. 

But don't be surprised if others end up taking the remaining 99%.

Have you guys learnt _nothing_ from the past? The reason MicroSoft and
Linux are kicking all the other vendors butts is that _small_ is
beautiful. Especially when small is "powerful enough".

Hint: why does Oracle care at all about the small business market? Why is
MySQL even a blip on your radar? Because it's those things that really
_drive_ stuff. The same way PC's have driven the tech market for the last 
15 years.

And believing that the load will keep up with "big iron hardware" is just 
not _true_. It's never been true. "Small iron" not only keeps up, but 
overtakes it - to the point where you have to start doing new things just 
to be able to take advantage of it.

Believe in history.

> 
> > O_DIRECT throws the cache part away, but it throws out the baby with the
> > bathwater, and breaks the other parts. Which is why O_DIRECT breaks things
> > like disk scheduling in really subtle ways - think about writing and
> > reading to the same area on the disk, and re-ordering at all different 
> > levels. 
> 
> 	Sure, but you don't do that.  The breakage in mixing O_DIRECT
> with pagecache I/O to the same areas of the disk isn't even all that
> subtle.  But you shouldn't be doing that, at least constantly.

Ok. Let's just hope all the crackers and virus writers believe you when 
you say "you shouldn't do that".

BIG FRIGGING HINT: a _real_ OS doesn't allow data corruption even for
cases where "you shouldn't do that". It shouldn't allow reading of data
that you haven't written. And "you shouldn't do that" is _not_ an excuse
for having bad interfaces that cause problems.

We're not NT.

		Linus

