Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbUKHWsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbUKHWsx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 17:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbUKHWsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 17:48:53 -0500
Received: from smtp.Lynuxworks.com ([207.21.185.24]:56594 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S261284AbUKHWsm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 17:48:42 -0500
Date: Mon, 8 Nov 2004 14:47:10 -0800
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Bill Huey <bhuey@lnxw.com>, Scott Wood <scott@timesys.com>,
       Ingo Molnar <mingo@elte.hu>, john cooper <john.cooper@timesys.com>,
       Mark_H_Johnson@raytheon.com, Karsten Wiese <annabellesgarden@yahoo.de>,
       Adam Heath <doogie@debian.org>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel@vger.kernel.org, Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.1
Message-ID: <20041108224710.GA7246@nietzsche.lynx.com>
References: <20041105223610.GA3756@nietzsche.lynx.com> <Pine.OSF.4.05.10411081410150.28010-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10411081410150.28010-100000@da410.ifa.au.dk>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2004 at 03:35:38PM +0100, Esben Nielsen wrote:
> Not quite. On a UP RT system you know that all lower priority tasks are
> not running when your task is running. This gives some nice
> properties. If you take care not to sleep your high priority task
> effectively blocks all preemption by the lower priority tasks.
... 
> In short: For SMB you have to think of parellization much more than on a
> UP RT system. Ofcourse to think of UP RT system as a SMB system doesn't
> make your system fail, but it might give you a suboptimal system. On the
> other hand a system running on a UP with full preemption might not be
> portable to a SMB system as you might be saved by "the nice properties". 
> So if you want to be portable, think of it as a SMB system :-)

Yeah, good points. I know, I'm being paranoid intentionally since much 
of the kernel is so SMP oriented. I'm thinking in terms of large scale
concurrency since the structures of the kernel are fundamentally SMP and
which is tightly related to RT performance. There's a lot of overlap
between both world as it concerns locking structures, fine grainedness.

The really appealing aspect of this project that the same things that
make Linux such a high performance SMP system out of the box is exactly
what will also give it outstanding RT performance in both UP and SMP
configurations. The fine grained locking issues seem to be largely done
and this work is going to push those boundaries even more.

I know what you're saying about thread run subsets with relation to
priority (again good points), but I'm looking at large picture issues
and how this system is going to behave as all parts work together. We
haven't done this just yet and it's too immature a system to do so
until it becomes more stable and popular. It's a different point of 
view than what you're talking about. :)

bill

