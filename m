Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbUJYVnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbUJYVnl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 17:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbUJYVnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 17:43:21 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:55531 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261286AbUJYVmn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 17:42:43 -0400
Date: Mon, 25 Oct 2004 23:41:56 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
In-Reply-To: <417D4B5E.4010509@cybsft.com>
Message-Id: <Pine.OSF.4.05.10410252340110.22414-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: -2.82 () ALL_TRUSTED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see the same problem. It courses no problems. I _think_ the enable_irq()
call have to be removed. I mailed the list about but nobody answered. I am
rather new to Linux kernel programming so I am not sure...

Esben


On Mon, 25 Oct 2004, K.R. Foley wrote:

> Ingo Molnar wrote:
> > i have released the -V0 Real-Time Preemption patch, which can be
> > downloaded from:
> > 
> >   http://redhat.com/~mingo/realtime-preempt/
> > 
> 
> Actually pertaining to V0.2. I just got my UP system booted up on V0.2 
> and got this in the log. I did notice that this is not new to this 
> release. It has been here at least since U10.3. Sorry I didn't catch it 
> sooner.
> 
> Oct 25 13:31:56 daffy kernel: IRQ#11 thread RT prio: 43.
> Oct 25 13:31:56 daffy kernel: ip/2432: BUG in enable_irq at 
> kernel/irq/manage.c:112
> Oct 25 13:31:56 daffy kernel:  [<c01396ab>] enable_irq+0xfb/0x100 (12)
> Oct 25 13:31:56 daffy kernel:  [<d0975614>] e100_up+0x114/0x200 [e100] (48)
> Oct 25 13:31:56 daffy kernel:  [<d0976a20>] e100_open+0x30/0x80 [e100] (48)
> Oct 25 13:31:56 daffy kernel:  [<c0113154>] mcount+0x14/0x18 (12)
> Oct 25 13:31:56 daffy kernel:  [<c0265d98>] dev_open+0x88/0xa0 (20)
> Oct 25 13:31:56 daffy kernel:  [<c02677cd>] dev_change_flags+0x5d/0x140 (28)
> Oct 25 13:31:56 daffy kernel:  [<c02653ee>] __dev_get_by_name+0xe/0xd0 (8)
> Oct 25 13:31:56 daffy kernel:  [<c02af3d7>] devinet_ioctl+0x277/0x6c0 (28)
> Oct 25 13:31:56 daffy kernel:  [<c02b1894>] inet_ioctl+0x64/0xb0 (108)
> Oct 25 13:31:56 daffy kernel:  [<c025c048>] sock_ioctl+0xc8/0x250 (28)
> Oct 25 13:31:56 daffy kernel:  [<c0171cf7>] sys_ioctl+0xf7/0x260 (32)
> Oct 25 13:31:56 daffy kernel:  [<c01064ed>] sysenter_past_esp+0x52/0x71 (48)
> Oct 25 13:31:56 daffy kernel: preempt count: 00000002
> Oct 25 13:31:56 daffy kernel: . 2-level deep critical section nesting:
> Oct 25 13:31:56 daffy kernel: .. entry 1: enable_irq+0x33/0x100 
> [<c01395e3>] / (e100_up+0x114/0x200 [e100] [<d0975614>])
> Oct 25 13:31:56 daffy kernel: .. entry 2: print_traces+0x1d/0x60 
> [<c0132ecd>] / (dump_stack+0x23/0x30 [<c0106b23>])
> Oct 25 13:31:56 daffy kernel:
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

