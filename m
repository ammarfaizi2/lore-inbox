Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319077AbSHMTke>; Tue, 13 Aug 2002 15:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319102AbSHMTkd>; Tue, 13 Aug 2002 15:40:33 -0400
Received: from mx2.elte.hu ([157.181.151.9]:57313 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S319077AbSHMTkd>;
	Tue, 13 Aug 2002 15:40:33 -0400
Date: Tue, 13 Aug 2002 21:44:33 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] clone-detached-2.5.31-A1
In-Reply-To: <Pine.LNX.4.44.0208132052230.7425-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0208132143410.9087-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> i'm worried about one codepath though, in sys_wait4() we have this:
> 
>                                         p->parent = p->real_parent;
>                                         add_parent(p, p->parent);
>                                         do_notify_parent(p, SIGCHLD);
> 
> can this actually trigger for a detached process as well? In any case
> i've put an assert in to make sure.

as far as i can see this cannot trigger because reparent_to_init() sets
exit_signal to SIGCHLD so the above code is correct.

	Ingo

