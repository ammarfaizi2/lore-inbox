Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261835AbUKPVta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbUKPVta (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 16:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbUKPVs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 16:48:27 -0500
Received: from mail.gmx.de ([213.165.64.20]:19367 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261845AbUKPVqn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 16:46:43 -0500
X-Authenticated: #4399952
Date: Tue, 16 Nov 2004 22:47:36 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Ingo Molnar <mingo@elte.hu>, Mark_H_Johnson@raytheon.com,
       linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Stefan Schweizer <sschweizer@gmail.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.27-3
Message-ID: <20041116224736.0c647e42@mango.fruits.de>
In-Reply-To: <419A745C.4040101@cybsft.com>
References: <OFE5FC77BB.DA8F1FAE-ON86256F4E.0058C5CF-86256F4E.0058C604@raytheon.com>
	<20041116184315.GA5492@elte.hu>
	<419A5A53.6050100@cybsft.com>
	<20041116212401.GA16845@elte.hu>
	<20041116222039.662f41ac@mango.fruits.de>
	<419A745C.4040101@cybsft.com>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2004 15:42:52 -0600
"K.R. Foley" <kr@cybsft.com> wrote:

> Just a thought. What priority are you running rtc_wakup at? If you are 
> doing something like:
> 
> schp.sched_priority = sched_get_priority_max(SCHED_FIFO); // which 
> equates to a priority of 99
> 
> Then you it is actually running at a higher priority than the rtc, and 
> it won't work very well. I tend to run rtc (IRQ 8) at 99 and the 
> programs accessing it at 98 which seems to work reasonably well.

yah, the default for rtc_wakeup is 91 for the read() thread and 90 for the
reporting thread. So rtc's prio is above that.

flo
