Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287487AbSAFDgc>; Sat, 5 Jan 2002 22:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287667AbSAFDgX>; Sat, 5 Jan 2002 22:36:23 -0500
Received: from [66.189.64.253] ([66.189.64.253]:56192 "HELO majere.epithna.com")
	by vger.kernel.org with SMTP id <S287487AbSAFDgH>;
	Sat, 5 Jan 2002 22:36:07 -0500
Date: Sat, 5 Jan 2002 22:34:43 -0500 (EST)
From: <listmail@majere.epithna.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [patch] O(1) scheduler, 2.4.17-B0, 2.5.2-pre8-B0.
In-Reply-To: <Pine.LNX.4.33.0201060128250.1250-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0201052232170.13672-100000@majere.epithna.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How close are you and Robert Love on getting this patch and his pre-emt
patches to co-operate...seems like that might bring huge wins.  I know, I
know I could diff, and fix the rejects myself, but this seems to deep in
the kernel for a relative newbie like myself(plus I am more a file system
guy)

Bill

On Sun, 6 Jan 2002, Ingo Molnar wrote:

>
> this is the next, bugfix release of the O(1) scheduler:
>
> 	http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.5.2-B0.patch
> 	http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.4.17-B0.patch
>
> This release could fix the lockups and crashes reported by some people.
>
> Changes:
>
>  - remove the likely/unlikely define from sched.h and include compiler.h.
>    (Adrian Bunk)
>
>  - export sys_sched_yield, reported by Pawel Kot.
>
>  - turn off 'child runs first' temporarily, to see the effect.
>
>  - export nr_context_switches() as well, needed by ReiserFS.
>
>  - define resched_task() in the correct order to avoid compiler warnings
>    on UP.
>
>  - maximize the frequency of timer-tick driven load-balancing to 100 per
>    sec.
>
>  - clear ->need_resched in the RT scheduler path as well.
>
>  - simplify yield() support, remove TASK_YIELDED and __schedule_tail().
>
> Comments, bug reports, suggestions are welcome,
>
> 	Ingo
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

