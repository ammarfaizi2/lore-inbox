Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbUKCSjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbUKCSjM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 13:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbUKCSjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 13:39:05 -0500
Received: from mail.timesys.com ([65.117.135.102]:55630 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261800AbUKCSjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 13:39:00 -0500
Message-ID: <4189329F.2020405@timesys.com>
Date: Wed, 03 Nov 2004 14:33:51 -0500
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       john cooper <john.cooper@timesys.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.1
References: <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <20041103105840.GA3992@elte.hu>
In-Reply-To: <20041103105840.GA3992@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Nov 2004 18:33:10.0500 (UTC) FILETIME=[9200C240:01C4C1D3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

>    The new PI code covers all synchronization objects in Linux (on
>    PREEMPT_REALTIME): spinlocks, rwlocks, semaphores and rwsems. 
>    Feedback on the design of this code would be welcome, and patches as
>    well, if you have a better scheme. The code is pretty modular so feel 
>    free to experiment with alternative schemes.

I didn't see closure being performed of a possible blocked-owner
dependency chain, but only promotion of the immediate owner.  It
is possible for a mutex owner to itself be blocked on another mutex
requiring promotion of the latter mutex owner(s).

-- 
john.cooper@timesys.com
