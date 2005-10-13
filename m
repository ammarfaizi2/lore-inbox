Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbVJMWag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbVJMWag (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 18:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbVJMWag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 18:30:36 -0400
Received: from smtp1.Stanford.EDU ([171.67.16.123]:26799 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S1751116AbVJMWaf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 18:30:35 -0400
Subject: Re: 2.6.14-rc4-rt1
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: nando@ccrma.Stanford.EDU, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com,
       david singleton <dsingleton@mvista.com>
In-Reply-To: <20051012071037.GA19018@elte.hu>
References: <20051011111454.GA15504@elte.hu>
	 <1129064151.5324.6.camel@cmn3.stanford.edu>
	 <20051012061455.GA16586@elte.hu>  <20051012071037.GA19018@elte.hu>
Content-Type: text/plain
Date: Thu, 13 Oct 2005 15:29:55 -0700
Message-Id: <1129242595.4623.14.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-12 at 09:10 +0200, Ingo Molnar wrote:
> another thing: might be worth trying PREEMPT_RT too, maybe it makes a 
> difference.

On "depmod -a" I'm getting:
WARNING: /lib/modules/2.6.13-0.11.rdt.rhfc4.ccrmasmp/kernel/fs/jffs2/jffs2.ko needs unknown symbol __down_read
WARNING: /lib/modules/2.6.13-0.11.rdt.rhfc4.ccrmasmp/kernel/fs/jffs2/jffs2.ko needs unknown symbol __up_write
WARNING: /lib/modules/2.6.13-0.11.rdt.rhfc4.ccrmasmp/kernel/fs/jffs2/jffs2.ko needs unknown symbol __up_read
WARNING: /lib/modules/2.6.13-0.11.rdt.rhfc4.ccrmasmp/kernel/fs/jffs2/jffs2.ko needs unknown symbol __down_write
WARNING: /lib/modules/2.6.13-0.11.rdt.rhfc4.ccrmasmp/kernel/fs/jffs2/jffs2.ko needs unknown symbol compat_init_rwsem
WARNING: /lib/modules/2.6.13-0.11.rdt.rhfc4.ccrmasmp/kernel/fs/xfs/xfs.ko needs unknown symbol __down_read
WARNING: /lib/modules/2.6.13-0.11.rdt.rhfc4.ccrmasmp/kernel/fs/xfs/xfs.ko needs unknown symbol __down_write_trylock
WARNING: /lib/modules/2.6.13-0.11.rdt.rhfc4.ccrmasmp/kernel/fs/xfs/xfs.ko needs unknown symbol __up_write
WARNING: /lib/modules/2.6.13-0.11.rdt.rhfc4.ccrmasmp/kernel/fs/xfs/xfs.ko needs unknown symbol __up_read
WARNING: /lib/modules/2.6.13-0.11.rdt.rhfc4.ccrmasmp/kernel/fs/xfs/xfs.ko needs unknown symbol __downgrade_write
WARNING: /lib/modules/2.6.13-0.11.rdt.rhfc4.ccrmasmp/kernel/fs/xfs/xfs.ko needs unknown symbol __down_write
WARNING: /lib/modules/2.6.13-0.11.rdt.rhfc4.ccrmasmp/kernel/fs/xfs/xfs.ko needs unknown symbol compat_init_rwsem
WARNING: /lib/modules/2.6.13-0.11.rdt.rhfc4.ccrmasmp/kernel/fs/xfs/xfs.ko needs unknown symbol __down_read_trylock

I'll report after I try to boot into it. 

> Also, i noticed an unrelated .config thing: while you have 
> PREEMPT_DESKTOP, PREEMPT_BKL and irq/softirq threading turned on, you 
> dont have PREEMPT_RCU enabled. PREEMPT_RCU is pretty useful, it can get 
> rid of a number of latency sources. Might be worth a try for your 
> kernel.

I tried PREEMPT_RCU=y and then HIGH_RES_TIMERS=y with no effects. I also
turned off ntpd at Thomas's request (no change). 

I could not boot the up version of the kernel, it hangs early, I'll try
to see why (weird). 

-- Fernando


