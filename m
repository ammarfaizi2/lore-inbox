Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261478AbULIOut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbULIOut (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 09:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261480AbULIOut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 09:50:49 -0500
Received: from mail3.utc.com ([192.249.46.192]:15357 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S261478AbULIOul (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 09:50:41 -0500
Message-ID: <41B86630.7030404@cybsft.com>
Date: Thu, 09 Dec 2004 08:50:24 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
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
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
References: <20041122005411.GA19363@elte.hu> <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu> <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu> <20041207141123.GA12025@elte.hu> <41B6839B.4090403@cybsft.com> <20041208083447.GB7720@elte.hu> <41B726D1.6030009@cybsft.com> <41B7BC60.1060407@cybsft.com> <20041209121133.GB23077@elte.hu>
In-Reply-To: <20041209121133.GB23077@elte.hu>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * K.R. Foley <kr@cybsft.com> wrote:
> 
> 
>>OK dumb question. I am going out to get my own personal brown paper
>>bag, since I seem to be wearing it so often. I forgot tasks get
>>removed from the runqueue when they are sleeping, etc. so the active
>>array should empty most of the time. However, with more RT tasks and
>>interactive tasks being thrown back into the active queue I could see
>>this POSSIBLY occasionally starving a few processes???
> 
> 
> interactive tasks do get thrown back, but they wont ever preempt RT
> tasks. RT tasks themselves can starve any lower-prio process
> indefinitely. Interactive tasks can starve other tasks up to a certain
> limit, which is defined via STARVATION_LIMIT, at which point we empty
> the active array and perform an array switch. (also see
> EXPIRED_STARVING())
> 
> 	Ingo
> 
Understood. BTW, I wouldn't consider some possible starvation of lower 
priority, non-realtime tasks to be incorrect behavior for a realtime 
system. The comments in the above email as well as previous emails were 
not intended as complaints or questions of correctness. They were more 
just thoughts generated while thinking about some of the reports of 
non-realtime tasks being starved.

kr
