Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132400AbRDDHav>; Wed, 4 Apr 2001 03:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132418AbRDDHal>; Wed, 4 Apr 2001 03:30:41 -0400
Received: from chiara.elte.hu ([157.181.150.200]:23564 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S132400AbRDDHaZ>;
	Wed, 4 Apr 2001 03:30:25 -0400
Date: Wed, 4 Apr 2001 08:28:31 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Mike Kravetz <mkravetz@sequent.com>
Cc: <frankeh@us.ibm.com>, Fabio Riccardi <fabio@chromium.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: a quest for a better scheduler
In-Reply-To: <20010403154314.E1054@w-mikek2.sequent.com>
Message-ID: <Pine.LNX.4.30.0104040825460.1717-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 3 Apr 2001, Mike Kravetz wrote:

> Our 'priority queue' implementation uses almost the same goodness
> function as the current scheduler.  The main difference between our
> 'priority queue' scheduler and the current scheduler is the structure
> of the runqueue.  We break up the single runqueue into a set of
> priority based runqueues. The 'goodness' of a task determines what
> sub-queue a task is placed in.  Tasks with higher goodness values are
> placed in higher priority queues than tasks with lower goodness
> values. [...]

we are talking about the same thing, re-read my mail. this design assumes
that 'goodness' is constant in the sense that it does not depend on the
previous process.

and no, your are not using the same goodness() function, you omitted the
prev->mm == next->mm component to goodness(), due to this design
limitation.

	Ingo


