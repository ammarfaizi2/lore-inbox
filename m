Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132206AbRCVWBt>; Thu, 22 Mar 2001 17:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132207AbRCVWBl>; Thu, 22 Mar 2001 17:01:41 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:49737 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S132206AbRCVWBY>;
	Thu, 22 Mar 2001 17:01:24 -0500
Message-ID: <20010322230041.A5598@win.tue.nl>
Date: Thu, 22 Mar 2001 23:00:41 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        stephenc@theiqgroup.com (Stephen Clouse)
Cc: riel@conectiva.com.br (Rik van Riel),
        orourke@missioncriticallinux.com (Patrick O'Rourke),
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <20010322142831.A929@owns.warpcore.org> <E14gCYn-0003K3-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <E14gCYn-0003K3-00@the-village.bc.nu>; from Alan Cox on Thu, Mar 22, 2001 at 09:23:54PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2001 at 09:23:54PM +0000, Alan Cox wrote:
> > Really the whole oom_kill process seems bass-ackwards to me.  I can't in my mind
> > logically justify annihilating large-VM processes that have been running for 
> > days or weeks instead of just returning ENOMEM to a process that just started 
> > up.
> 
> How do you return an out of memory error to a C program that is out of memory
> due to a stack growth fault. There is actually not a language construct for it

Alan, this is a fake argument.
Linux is bad, and you defend it by saying that it is impossible to be perfect.

I have used various Unix flavours for approximately thirty years.
Stack overflow has not been a real problem. Of course they occurred
every now and then, but roughly speaking only for unchecked recursion,
that is, in cases of a program bug.

Presently however, a flawless program can be killed.
That is what makes Linux unreliable.

> Eventually you have to kill something or the machine deadlocks.

Alan, this is a fake argument.
When I have a computer algebra system, and it computes millions of
function values for some expensive function, then it keeps a cache
of already computed values. Maybe a value is needed again and we
save ten seconds of computation.
But of course, when we run out of memory, nothing is easier than
just throwing this cache out.

You see, the bug is that malloc does not fail. This means that the
decisions about what to do are not taken by the program that knows
what it is doing, but by the kernel.

Andries
