Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269602AbUICLEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269602AbUICLEN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 07:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269614AbUICLEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 07:04:13 -0400
Received: from relay.pair.com ([209.68.1.20]:13075 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S269602AbUICLEK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 07:04:10 -0400
X-pair-Authenticated: 66.188.111.210
Message-ID: <41384FA7.9040509@cybsft.com>
Date: Fri, 03 Sep 2004 06:04:07 -0500
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>,
       Mark_H_Johnson@raytheon.com,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R0
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com> <20040902063335.GA17657@elte.hu> <20040902065549.GA18860@elte.hu> <20040902111003.GA4256@elte.hu> <20040902215728.GA28571@elte.hu>
In-Reply-To: <20040902215728.GA28571@elte.hu>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i've released the -R0 patch:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk4-R0
>  
> ontop of:
> 
>   http://redhat.com/~mingo/voluntary-preempt/diff-bk-040828-2.6.8.1.bz2
> 
> i've given up on the netdev_backlog_granularity approach, and as a
> replacement i've modified specific network drivers to return at a safe
> point if softirq preemption is requested. This gives the same end result
> but is more robust. For the time being i've fixed 8193too.c and e100.c.
> (will fix up other drivers too as latencies get reported)
> 
> this should fix the crash reported by P.O. Gaillard, and it should solve
> the packet delay/loss issues reported by Mark H Johnson. I cannot see
> any problems on my rtl8193 testbox anymore.
> 
> 	Ingo
> 

Last night when rebooting on R0 for the first time, my system locked up. 
It appears to have happened the first time trying to send/recv any real 
data over the e100 interface when ntp was starting up. Will try to 
investigate further a little later.

kr

