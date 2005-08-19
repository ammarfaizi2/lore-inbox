Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbVHSAF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbVHSAF3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 20:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbVHSAF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 20:05:29 -0400
Received: from smtp-2.llnl.gov ([128.115.250.82]:65154 "EHLO smtp-2.llnl.gov")
	by vger.kernel.org with ESMTP id S932447AbVHSAF3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 20:05:29 -0400
Date: Thu, 18 Aug 2005 17:05:12 -0700 (PDT)
From: Chuck Harding <charding@llnl.gov>
Subject: Re: 2.6.13-rc6-rt9
In-reply-to: <20050818060126.GA13152@elte.hu>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linux Kernel Discussion List <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
Message-id: <Pine.LNX.4.63.0508181353540.9409@ghostwheel.llnl.gov>
Organization: Lawrence Livermore National Laboratory
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-transfer-encoding: 7BIT
User-Agent: Pine/4.62 (X11; U; Linux i686; en-US; rv:2.6.11-rc2-mm1)
References: <20050818060126.GA13152@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2005, Ingo Molnar wrote:

>
> i have released the 2.6.13-rc6-rt9 tree, which can be downloaded from
> the usual place:
>
>  http://redhat.com/~mingo/realtime-preempt/
>
> it's a fixes-only release. Changes since 2.6.13-rc6-rt3:
>
> - USB irq flags use cleanups (Alan Stern)
>
> - RCU tasklist-lock fixes (Paul McKenney, Thomas Gleixner)
>
> - HR-timers waitqueue splitup, better HRT latencies (Thomas Gleixner)
>
> - latency tracer fixes, irq flags tracing cleanups (Steven Rostedt, me)
>
> - NFSd BKL unlock fix (Steven Rostedt)
>
> - stackfootprint-max-printer fix (Steven Rostedt)
>
> - stop_machine fix (Steven Rostedt)
>
> - lpptest fix (me)
>
> - turned off IOAPIC_POSTFLUSH when CONFIG_X86_IOAPIC_FAST. Now with
>   Karsten's VIA fixes my testbox does not show PCI-POST weirnesses
>   anymore. In case of IRQ problems please turn off IOAPIC_FAST. (me)

I'm still getting the same oops when rebooting. the same process (reboot)
similar call trace (some addresses are slightly different but the functions
are the same:
disable_IO_APIC+0x5a/0x90 (8)
machine_restart+0x5/0x9 (28)
sys_reboot+0x147/0x156 (4)
netdev_run_todo+0xa4/0x209 (4)
etc.

Another interesting data point is that I did a SysRq+B right after the
machine came up and got a different oops.

-- 
Charles D. (Chuck) Harding <charding@llnl.gov>  Voice: 925-423-8879
Senior Computer Associate         ICCD            Fax: 925-423-6961
Lawrence Livermore National Laboratory      Computation Directorate
Livermore, CA USA  http://www.llnl.gov  GPG Public Key ID: B9EB6601
