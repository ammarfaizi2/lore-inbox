Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbVJ3O7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbVJ3O7c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 09:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbVJ3O7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 09:59:32 -0500
Received: from mxsf13.cluster1.charter.net ([209.225.28.213]:2728 "EHLO
	mxsf13.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1750777AbVJ3O7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 09:59:31 -0500
X-IronPort-AV: i="3.97,266,1125892800"; 
   d="scan'208"; a="1750148939:sNHT18225544"
Message-ID: <4364DFA5.3000109@cybsft.com>
Date: Sun, 30 Oct 2005 08:58:45 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Thunderbird 1.4.1 (X11/20051006)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Mark Knecht <markknecht@gmail.com>, john stultz <johnstul@us.ibm.com>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: 2.6.14-rt1
References: <20051017160536.GA2107@elte.hu> <20051020195432.GA21903@elte.hu> <20051030133316.GA11225@elte.hu>
In-Reply-To: <20051030133316.GA11225@elte.hu>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i have released the 2.6.14-rt1 tree, which can be downloaded from the 
> usual place:
> 
>    http://redhat.com/~mingo/realtime-preempt/
> 
> this release is mainly about ktimer fixes: it updates to the latest 
> ktimer tree from Thomas Gleixner (which includes John Stultz's latest 
> GTOD tree), it fixes TSC synchronization problems on HT systems, and 
> updates the ktimers debugging code.
> 
> These together could fix most of the timer warnings and annoyances 
> reported for 2.6.14-rc5-rt kernels. In particular the new 
> TSC-synchronization code could fix SMP systems: the upstream TSC 
> synchronization method is fine for 1 usec resolution, but it was not 
> good enough for 1 nsec resolution and likely caused the SMP bugs 
> reported by Fernando Lopez-Lezcano and Rui Nuno Capela.
> 
> Please re-report any bugs that remain.
> 
> Changes since 2.6.14-rc5-rt1:
> 
>  - GTOD -B9 (John Stultz)
> 
>  - ktimer updates (Thomas Gleixner, me)
> 
>  - ktimer debugging check fixes (Steven Rostedt)
> 
>  - smarter TSC synchronization on SMP - we now rely on it for nsecs (me)
> 
>  - x64 build fix (reported by Mark Knecht)
> 
>  - tracing fix (reported by Florian Schmidt)
> 
>  - rtc histogram fixes (K.R. Foley)

Actually it doesn't look like these made it into the patch. :)

> 
>  - merge to 2.6.14
> 
> to build a 2.6.14-rt1 tree, the following patches should be applied:
> 
>   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.14.tar.bz2
>   http://redhat.com/~mingo/realtime-preempt/patch-2.6.14-rt1
> 
> 	Ingo
> 


-- 
   kr
