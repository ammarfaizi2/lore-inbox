Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289103AbSAUJ3S>; Mon, 21 Jan 2002 04:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289119AbSAUJ3H>; Mon, 21 Jan 2002 04:29:07 -0500
Received: from mx2.elte.hu ([157.181.151.9]:53741 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289103AbSAUJ2y>;
	Mon, 21 Jan 2002 04:28:54 -0500
Date: Mon, 21 Jan 2002 12:26:10 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Erich Focht <efocht@ess.nec.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: O(1) scheduler: load_balance issues
In-Reply-To: <Pine.LNX.4.21.0201191826400.14284-100000@sx6.ess.nec.de>
Message-ID: <Pine.LNX.4.33.0201211221270.2872-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 19 Jan 2002, Erich Focht wrote:

> In the load_balance() function the initial value for max_load should
> better be set to 1 instead of 0 in order to avoid finding 'busiest'
> runqueues with only one task. This avoids taking the spin-locks
> unnecessarily for the case idle=1.

agreed.

> Another issue: I don't understand how prev_max_load works, I think
> that the comments in load_balance are not true any more and the
> comparison to prev_max_load can be dropped. [...]

you are right, and this changed recently. Since we do not search for
multiple queues anymore when balancing, this variable can be dropped.
I've added both of your suggestions to my tree.

	Ingo

