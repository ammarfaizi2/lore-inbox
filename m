Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289405AbSAJVZX>; Thu, 10 Jan 2002 16:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289687AbSAJVZO>; Thu, 10 Jan 2002 16:25:14 -0500
Received: from mx2.elte.hu ([157.181.151.9]:4813 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289405AbSAJVY5>;
	Thu, 10 Jan 2002 16:24:57 -0500
Date: Fri, 11 Jan 2002 00:22:18 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>, Mike Kravetz <kravetz@us.ibm.com>,
        Anton Blanchard <anton@samba.org>, george anzinger <george@mvista.com>,
        Davide Libenzi <davidel@xmailserver.org>,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch] O(1) scheduler, -G1, 2.5.2-pre10, 2.4.17 (fwd)
In-Reply-To: <Pine.LNX.4.33.0201101017380.2723-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0201110021080.10305-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 Jan 2002, Linus Torvalds wrote:

> > First it cleans up the load balancer's interaction with the timer tick.
> > There are now two functions called from the timer tick: busy_cpu_tick()
> > and idle_cpu_tick(). It's completely up to the scheduler to use them
> > appropriately.
>
> This is _wrong_. The timer doesn't even know whether something is an idle
> task or not.

yes - thought of this after writing the mail.

> Proof: kapmd (right now the scheduler doesn't know this either, but at
> least we could teach it to know).

yes - pid == 0 is not the right information. I've fixed this in my tree.

	Ingo

