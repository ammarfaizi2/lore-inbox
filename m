Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261270AbUJ3TnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbUJ3TnQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 15:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbUJ3TnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 15:43:16 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:62640 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261270AbUJ3TnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 15:43:14 -0400
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
In-Reply-To: <20041030191725.GA29747@elte.hu>
References: <20041029172243.GA19630@elte.hu>
	 <20041029203619.37b54cba@mango.fruits.de> <20041029204220.GA6727@elte.hu>
	 <20041029233117.6d29c383@mango.fruits.de> <20041029212545.GA13199@elte.hu>
	 <1099086166.1468.4.camel@krustophenia.net> <20041029214602.GA15605@elte.hu>
	 <1099091566.1461.8.camel@krustophenia.net> <20041030115808.GA29692@elte.hu>
	 <1099158570.1972.5.camel@krustophenia.net> <20041030191725.GA29747@elte.hu>
Content-Type: text/plain
Date: Sat, 30 Oct 2004 15:43:11 -0400
Message-Id: <1099165392.1972.13.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-30 at 21:17 +0200, Ingo Molnar wrote:
> i think you are right - there are too many independent indicators
> pointing towards some sort of kernel problem. I'll try Florian's testapp
> and see whether i can see the 'window wiggle' problem.


This is kind of weird:

Checking 'hlt' instruction... OK.
spawn_desched_task(00000000)
desched cpu_callback 3/00000000
ksoftirqd started up.
softirq RT prio: 24.
desched cpu_callback 2/00000000
desched thread 0 started up.

But:

rlrevell@mindpipe:~/cvs/wakeup$ chrt -p 2
pid 2's current scheduling policy: SCHED_OTHER
pid 2's current scheduling priority: 0

I do not think I changed ksoftirqd's priority.

Lee

