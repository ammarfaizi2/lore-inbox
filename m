Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284652AbRLIXdA>; Sun, 9 Dec 2001 18:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284659AbRLIXcv>; Sun, 9 Dec 2001 18:32:51 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:19075 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S284652AbRLIXcf>; Sun, 9 Dec 2001 18:32:35 -0500
Date: Sun, 9 Dec 2001 14:31:52 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] 2.5.0 Multi-Queue Scheduler
Message-ID: <20011209143152.A1087@w-mikek2.sequent.com>
In-Reply-To: <20011207143415.B1127@w-mikek2.des.beaverton.ibm.com> <E16Cg7a-0001CR-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16Cg7a-0001CR-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Dec 08, 2001 at 11:58:22AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 08, 2001 at 11:58:22AM +0000, Alan Cox wrote:
> Which version of the scheduler do you behave like ?

The 'current'.  In this case 2.5.0.  This work was mostly
interested in changing data structure layout and algorithms
used to make scheduling decisions.  We still wanted to make
the same decision, just more efficiently when faced with
a high rate of scheduling decisions or large number of runnable
tasks.  Like I said earlier, this design constraint was
both good and bad.

> I have the core bits of a scheduler that behaves roughly like Linux 2.4 with
> the recent Ingo cache change [in fact that came from working out what the
> Linus scheduler does].
> 
> Uniprocessor scheduling is working fine (I've not tackled the RT stuff tho)
> SMP I'm pondering bits still.
> 
> Currently I do the following
> 
> Two sets of 8 queues per processor, and a bitmask of non empty queues.

I assume the queue a task is assigned to is based on its priority?
Or am I way off.  Are there 8 ranges of priorities for runnable tasks?
Just curious how you came up with 8.  We also dabbled with a scheduler
that had queues based on task priority.  One issue was that we couldn't
seem to come up with an optimal number of queues to represent all task
priorities.

-- 
Mike
