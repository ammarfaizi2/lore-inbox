Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261978AbSLJPIB>; Tue, 10 Dec 2002 10:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261996AbSLJPIB>; Tue, 10 Dec 2002 10:08:01 -0500
Received: from users.ccur.com ([208.248.32.211]:42249 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id <S261978AbSLJPIA>;
	Tue, 10 Dec 2002 10:08:00 -0500
From: jak@rudolph.ccur.com (Joe Korty)
Message-Id: <200212101514.PAA15602@rudolph.ccur.com>
Subject: Re: [PATCH 3/3] High-res-timers part 3 (posix to hrposix) take 20
To: george@mvista.com (george anzinger)
Date: Tue, 10 Dec 2002 10:14:35 -0500 (EST)
Cc: akpm@digeo.com (Andrew Morton), torvalds@transmeta.com (Linus Torvalds),
       linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
Reply-To: joe.korty@ccur.com (Joe Korty)
In-Reply-To: <3DF5A62C.242E171@mvista.com> from "george anzinger" at Dec 10, 2002 12:30:36 AM
X-Mailer: ELM [version 2.5 PL0b1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ repost - first attempt failed to get out ]

> > Is the "don't reuse an ID for some time" requirement still there?
>
> I don't see the need for the "don't reuse an ID for some
> time" thing and it looked like what Jim had messed up the
> book keeping AND it also looked like it failed to actually
> work.  All of this convinced me that the added complexity
> was just not worth it.

A thought: any algorithm that fails to "reuse an ID for some time"
can be converted into one that does by tweaking the algorithn to
return an ID with fewer bits and putting a counter (bumped on each
fresh allocation of that ID) in the remaining bits.  Or, one can go
stateless and achieve an "almost never reuse an ID for some time" by
instead inserting a freshly generated pseudo-random number in the
unused ID bits.

Joe - Concurrent Computer Corporation
