Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290753AbSAYRvs>; Fri, 25 Jan 2002 12:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290754AbSAYRvi>; Fri, 25 Jan 2002 12:51:38 -0500
Received: from bdsl.66.13.29.10.gte.net ([66.13.29.10]:36487 "EHLO
	Bluesong.NET") by vger.kernel.org with ESMTP id <S290753AbSAYRv1>;
	Fri, 25 Jan 2002 12:51:27 -0500
Message-Id: <200201251755.g0PHtnU16814@Bluesong.NET>
Content-Type: text/plain; charset=US-ASCII
From: "Jack F. Vogel" <jfv@trane.bluesong.net>
Reply-To: jfv@Bluesong.NET
To: <mingo@elte.hu>, <jfv@Bluesong.NET>
Subject: Re: [PATCH]: O(1) 2.4.17-J6 tuneable parameters
Date: Fri, 25 Jan 2002 09:55:49 -0800
X-Mailer: KMail [version 1.3.1]
Cc: jfv <jfv@us.ibm.com>, linux-kernel <linux-kernel@vger.kernel.org>,
        jstultz <jstultz@us.ibm.com>
In-Reply-To: <Pine.LNX.4.33.0201251336130.3371-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0201251336130.3371-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 January 2002 04:46 am, Ingo Molnar wrote:
> Jack,
>
>
> i think we could use your patch for development purposes as well, lets
> merge the two efforts?

Sound good to me Ingo, thanks.

> i'd suggest to name the /proc/sys/sched/ values the same way the constants
> are called. Eg. /proc/sys/sched/CHILD_FORK_PENALTY. This makes it easier
> to communicate suggested parameter changes.

No problem. I can make those changes.

> i have a script that dumps the current sched-parameters state:
>
>  [root@mars root]# ./getsched
>  echo 95 > /proc/sys/kernel/CHILD_FORK_PENALTY
>  echo 3 > /proc/sys/kernel/EXIT_WEIGHT
>  echo 3 > /proc/sys/kernel/INTERACTIVE_DELTA
>  echo 200 > /proc/sys/kernel/MAX_SLEEP_AVG
>  echo 30 > /proc/sys/kernel/MAX_TIMESLICE
>  echo 100 > /proc/sys/kernel/PARENT_FORK_PENALTY
>  echo 70 > /proc/sys/kernel/PRIO_BONUS_RATIO
>  echo 60 > /proc/sys/kernel/PRIO_CPU_HOG_RATIO
>  echo 20 > /proc/sys/kernel/PRIO_INTERACTIVE_RATIO
>  echo 200 > /proc/sys/kernel/STARVATION_LIMIT
>
> the script is very simple:
>
>  cd /proc/sys/kernel
>
>  for N in *[A-Z]*; do echo "echo "`cat $N`" > /proc/sys/kernel/$N"; done
>
> otherwise our approach is identical. This patch would always stay
> separate, but could be readily applied by people who want more control
> over the scheduler for development or whatever other reasons.
>
> 	Ingo

Great, so how and where do we maintain it?

Cheers,

-- 
Jack F. Vogel
IBM  Linux Solutions
jfv@us.ibm.com  (work)
jfv@Bluesong.NET (home)
