Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268753AbUJTRW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268753AbUJTRW0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 13:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268726AbUJTRO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 13:14:57 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:61590 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268719AbUJTRLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 13:11:22 -0400
Subject: Re: gradual timeofday overhaul
From: Lee Revell <rlrevell@joe-job.com>
To: Len Brown <len.brown@intel.com>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
       john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>
In-Reply-To: <1098258460.26595.4320.camel@d845pe>
References: <Pine.LNX.4.53.0410200441210.11067@gockel.physik3.uni-rostock.de>
	 <1098258460.26595.4320.camel@d845pe>
Content-Type: text/plain
Message-Id: <1098292168.1429.96.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 20 Oct 2004 13:09:29 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 03:47, Len Brown wrote:
> The current design with HZ=1000 gives us 1ms = 1000usec between clock
> ticks.  But some platforms take nearly that long just to enter/exit low
> power states; which means that on Linux the hardware pays a long idle
> state exit latency (performance hit) but gets little or no power savings
> from the time it resides in that idle state.

My testing shows that the timer interrupt runs for about 21 usec. 
That's 2.1% of its time just running the timer ISR!  No wonder this
causes PM issues, 2.1% cpu load is not exactly an idle machine.  This is
a 600Mhz C3, so on a slower embedded system this might be 5%.

So, any solution that would allow high res timers with Hz = 100 would be
welcome.

Lee

