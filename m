Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132981AbRAVSiW>; Mon, 22 Jan 2001 13:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133022AbRAVSiM>; Mon, 22 Jan 2001 13:38:12 -0500
Received: from dns-229.dhcp-248.nai.com ([161.69.248.229]:991 "HELO
	localdomain") by vger.kernel.org with SMTP id <S132981AbRAVSiD>;
	Mon, 22 Jan 2001 13:38:03 -0500
From: Davide Libenzi <davidel@xmail.virusscreen.com>
Organization: myCIO.com
Date: Mon, 22 Jan 2001 10:37:34 -0800
X-Mailer: KMail [version 1.1.95.5]
Content-Type: text/plain;
  charset="us-ascii"
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
To: Mike Kravetz <mkravetz@sequent.com>, lse-tech@lists.sourceforge.net
In-Reply-To: <20010122101738.B7427@w-mikek.des.sequent.com>
In-Reply-To: <20010122101738.B7427@w-mikek.des.sequent.com>
Subject: Re: more on scheduler benchmarks
MIME-Version: 1.0
Message-Id: <01012210373402.17926@ewok.dev.mycio.com>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 January 2001 10:30, Mike Kravetz wrote:
> Last week while discussing scheduler benchmarks, Bill Hartner
> made a comment something like the following "the benchmark may
> not even be invoking the scheduler as you expect".  This comment
> did not fully sink in until this weekend when I started thinking
> about changes made to sched_yield() in 2.4.0.  (I'm cc'ing Ingo
> Molnar because I think he was involved in the changes).  If you
> haven't taken a look at sys_sched_yield() in 2.4.0, I suggest
> that you do that now.
>
> A result of new optimizations made to sys_sched_yield() is that
> calling sched_yield() does not result in a 'reschedule' if there
> are no tasks waiting for CPU resources.  Therefore, I would claim
> that running 'scheduler benchmarks' which loop doing sched_yield()
> seem to have little meaning/value for runs where the number of
> looping tasks is less than then number of CPUs in the system.  Is
> that an accurate statement?

With this kind of test tasks are always running.
If You print the nr_running You'll find that this is exactly ( at least ) the 
number of tasks You've spawned so the scheduler is always called.



- Davide
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
