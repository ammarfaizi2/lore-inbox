Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315300AbSGINnd>; Tue, 9 Jul 2002 09:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315334AbSGINnc>; Tue, 9 Jul 2002 09:43:32 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:15123 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S315300AbSGINnc>; Tue, 9 Jul 2002 09:43:32 -0400
Date: Tue, 9 Jul 2002 09:41:02 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Ville Herva <vherva@niksula.hut.fi>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: prevent breaking a chroot() jail?
In-Reply-To: <20020705161750.GO1548@niksula.cs.hut.fi>
Message-ID: <Pine.LNX.3.96.1020709093325.27294B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jul 2002, Ville Herva wrote:

> In general, I wonder if it would make sense to aim for something like
> jail(2). Chroot has its shortcomings, and I take it that many of them have
> to be preserved to maintain standard compliance. Jail isolates processes
> more completely than chroot is ever ment to.
> 
> FreeBSD implements jail by adding a jail pointer to struct proc - I'm not
> sure how much of that should/could be done with mere capabilities in linux,
> and how much of the "fortificated chroot" implementation jail has overlaps
> with Al Viro's namespaces.
> 
> All in all, I've seen suprisingly little conversation about jail on
> lkml. What do people think of it?

Not having had the problem of jailing things for almost a decade, I
haven't been following this field, but certainly after looking at POSIX
and chroot, I don't think we can both be secure and compliant. Adding
jail() would be a better approach, preferably with a BSD-compatible API so
people could move programs here.

I have been doing some reading on UML, and it sounds as if that could be
at least as secure as jail, but it is almost certainly higher overhead. I
want to try running multiple machines in UML and see how well it works. If
disk is the only issue it's cheap enough to to have enough per
application, but I doubt if it's practical per-user in most cases.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

