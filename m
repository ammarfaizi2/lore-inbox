Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261830AbUKPVeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbUKPVeW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 16:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbUKPVdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 16:33:03 -0500
Received: from pop.gmx.net ([213.165.64.20]:64453 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261830AbUKPVcU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 16:32:20 -0500
X-Authenticated: #4399952
Date: Tue, 16 Nov 2004 22:33:12 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: "K.R. Foley" <kr@cybsft.com>, Mark_H_Johnson@raytheon.com,
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
Message-ID: <20041116223312.4e289e62@mango.fruits.de>
In-Reply-To: <20041116223135.GA27250@elte.hu>
References: <OFE5FC77BB.DA8F1FAE-ON86256F4E.0058C5CF-86256F4E.0058C604@raytheon.com>
	<20041116184315.GA5492@elte.hu>
	<419A5A53.6050100@cybsft.com>
	<20041116212401.GA16845@elte.hu>
	<20041116222039.662f41ac@mango.fruits.de>
	<20041116223135.GA27250@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2004 23:31:35 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> and i'd suggest to chrt irq 1 back to below prio 90, maybe this explains
> the console-switching latency? If you do a console-switch via the
> keyboard then its priority 99 can get inherited by events/0 which then
> does the quite expensive VGA console clearing/copying with priority 99,
> possibly delaying rtc_wakeup quite significantly, easily for a
> millisecond or so. So what you are seeing might be priority inheritance
> handling at work!
> 

ah, will try this right away..

flo
