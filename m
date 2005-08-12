Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbVHLDTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbVHLDTY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 23:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbVHLDTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 23:19:24 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:7301 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751145AbVHLDTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 23:19:23 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.53-01, High
	Resolution Timers & RCU-tasklist features
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       george anzinger <george@mvista.com>
In-Reply-To: <1123816044.4453.7.camel@mindpipe>
References: <20050811110051.GA20872@elte.hu>
	 <1123816044.4453.7.camel@mindpipe>
Content-Type: text/plain
Date: Thu, 11 Aug 2005 23:19:19 -0400
Message-Id: <1123816760.4453.10.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.7 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-11 at 23:07 -0400, Lee Revell wrote:
> Very nice to see this going in (via) the RT patch.
> 

Also, does not compile for me with ACPI PM timer selected:

  CC      arch/i386/kernel/timers/hrtimer_pm.o
In file included from include/asm/hrtime.h:220,
                 from include/linux/hrtime.h:58,
                 from arch/i386/kernel/timers/hrtimer_pm.c:11:
include/asm/hrtime-Macpi.h: In function 'stake_cpuctr':
include/asm/hrtime-Macpi.h:110: warning: no return statement in function
returning non-void
arch/i386/kernel/timers/hrtimer_pm.c: In function 'high_res_init_pm':
arch/i386/kernel/timers/hrtimer_pm.c:141: warning: format '%lu' expects
type 'long unsigned int', but argument 2 has type 'unsigned int'
arch/i386/kernel/timers/hrtimer_pm.c:141: warning: format '%03lu'
expects type 'long unsigned int', but argument 3 has type 'unsigned int'
arch/i386/kernel/timers/hrtimer_pm.c:182: error: invalid lvalue in
assignment
make[2]: *** [arch/i386/kernel/timers/hrtimer_pm.o] Error 1
make[1]: *** [arch/i386/kernel/timers] Error 2
make: *** [arch/i386/kernel] Error 2

Lee

