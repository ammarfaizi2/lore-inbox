Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263599AbUJ3BRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263599AbUJ3BRu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 21:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263600AbUJ3BNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 21:13:50 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:32212 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263595AbUJ3BKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 21:10:14 -0400
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <20041029212545.GA13199@elte.hu>
References: <20041029163155.GA9005@elte.hu>
	 <20041029191652.1e480e2d@mango.fruits.de> <20041029170237.GA12374@elte.hu>
	 <20041029170948.GA13727@elte.hu> <20041029193303.7d3990b4@mango.fruits.de>
	 <20041029172151.GB16276@elte.hu> <20041029172243.GA19630@elte.hu>
	 <20041029203619.37b54cba@mango.fruits.de> <20041029204220.GA6727@elte.hu>
	 <20041029233117.6d29c383@mango.fruits.de>  <20041029212545.GA13199@elte.hu>
Content-Type: text/plain
Date: Fri, 29 Oct 2004 21:10:11 -0400
Message-Id: <1099098611.1482.2.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-29 at 23:25 +0200, Ingo Molnar wrote:
> this particular one (atomicity-checking) is always-enabled if you have
> the -RT patch applied (it's a really cheap check).

I tried this patch with all DEBUG options disabled, and this reduces the
xruns, but I still get a few.  This is what I get in the logs when
running jackd with your patch:

jackd:1590 userspace BUG: scheduling in user-atomic context!
 [<c02733eb>] schedule+0x6b/0xf0 (8)
 [<c0105d3b>] work_resched+0x6/0x17 (24)
jackd:1590 userspace BUG: scheduling in user-atomic context!
 [<c02733eb>] schedule+0x6b/0xf0 (8)
 [<c0105d3b>] work_resched+0x6/0x17 (24)
jackd:1590 userspace BUG: scheduling in user-atomic context!
 [<c02733eb>] schedule+0x6b/0xf0 (8)
 [<c0105d3b>] work_resched+0x6/0x17 (24)
jackd:1590 userspace BUG: scheduling in user-atomic context!
 [<c02733eb>] schedule+0x6b/0xf0 (8)
 [<c0105d3b>] work_resched+0x6/0x17 (24)
jackd:1590 userspace BUG: scheduling in user-atomic context!
 [<c02733eb>] schedule+0x6b/0xf0 (8)
 [<c0105d3b>] work_resched+0x6/0x17 (24)
jackd:1590 userspace BUG: scheduling in user-atomic context!
 [<c02733eb>] schedule+0x6b/0xf0 (8)
 [<c0105d3b>] work_resched+0x6/0x17 (24)
jackd:1590 userspace BUG: scheduling in user-atomic context!
 [<c02733eb>] schedule+0x6b/0xf0 (8)
 [<c0105d3b>] work_resched+0x6/0x17 (24)
jackd:1590 userspace BUG: scheduling in user-atomic context!
 [<c02733eb>] schedule+0x6b/0xf0 (8)
 [<c0105d3b>] work_resched+0x6/0x17 (24)

Lee

