Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbUJYS5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbUJYS5I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 14:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbUJYS4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 14:56:07 -0400
Received: from mail3.utc.com ([192.249.46.192]:10197 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S261216AbUJYSwe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 14:52:34 -0400
Message-ID: <417D4B5E.4010509@cybsft.com>
Date: Mon, 25 Oct 2004 13:52:14 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
References: <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu>
In-Reply-To: <20041025104023.GA1960@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i have released the -V0 Real-Time Preemption patch, which can be
> downloaded from:
> 
>   http://redhat.com/~mingo/realtime-preempt/
> 

Actually pertaining to V0.2. I just got my UP system booted up on V0.2 
and got this in the log. I did notice that this is not new to this 
release. It has been here at least since U10.3. Sorry I didn't catch it 
sooner.

Oct 25 13:31:56 daffy kernel: IRQ#11 thread RT prio: 43.
Oct 25 13:31:56 daffy kernel: ip/2432: BUG in enable_irq at 
kernel/irq/manage.c:112
Oct 25 13:31:56 daffy kernel:  [<c01396ab>] enable_irq+0xfb/0x100 (12)
Oct 25 13:31:56 daffy kernel:  [<d0975614>] e100_up+0x114/0x200 [e100] (48)
Oct 25 13:31:56 daffy kernel:  [<d0976a20>] e100_open+0x30/0x80 [e100] (48)
Oct 25 13:31:56 daffy kernel:  [<c0113154>] mcount+0x14/0x18 (12)
Oct 25 13:31:56 daffy kernel:  [<c0265d98>] dev_open+0x88/0xa0 (20)
Oct 25 13:31:56 daffy kernel:  [<c02677cd>] dev_change_flags+0x5d/0x140 (28)
Oct 25 13:31:56 daffy kernel:  [<c02653ee>] __dev_get_by_name+0xe/0xd0 (8)
Oct 25 13:31:56 daffy kernel:  [<c02af3d7>] devinet_ioctl+0x277/0x6c0 (28)
Oct 25 13:31:56 daffy kernel:  [<c02b1894>] inet_ioctl+0x64/0xb0 (108)
Oct 25 13:31:56 daffy kernel:  [<c025c048>] sock_ioctl+0xc8/0x250 (28)
Oct 25 13:31:56 daffy kernel:  [<c0171cf7>] sys_ioctl+0xf7/0x260 (32)
Oct 25 13:31:56 daffy kernel:  [<c01064ed>] sysenter_past_esp+0x52/0x71 (48)
Oct 25 13:31:56 daffy kernel: preempt count: 00000002
Oct 25 13:31:56 daffy kernel: . 2-level deep critical section nesting:
Oct 25 13:31:56 daffy kernel: .. entry 1: enable_irq+0x33/0x100 
[<c01395e3>] / (e100_up+0x114/0x200 [e100] [<d0975614>])
Oct 25 13:31:56 daffy kernel: .. entry 2: print_traces+0x1d/0x60 
[<c0132ecd>] / (dump_stack+0x23/0x30 [<c0106b23>])
Oct 25 13:31:56 daffy kernel:
