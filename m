Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbULHQwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbULHQwy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 11:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbULHQwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 11:52:54 -0500
Received: from mail4.utc.com ([192.249.46.193]:50406 "EHLO mail4.utc.com")
	by vger.kernel.org with ESMTP id S261249AbULHQwv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 11:52:51 -0500
Message-ID: <41B7314E.1050904@cybsft.com>
Date: Wed, 08 Dec 2004 10:52:30 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
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
References: <20041117124234.GA25956@elte.hu>	 <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu>	 <20041122005411.GA19363@elte.hu> <20041123175823.GA8803@elte.hu>	 <20041124101626.GA31788@elte.hu> <20041203205807.GA25578@elte.hu>	 <20041207132927.GA4846@elte.hu> <20041207141123.GA12025@elte.hu>	 <41B6839B.4090403@cybsft.com> <20041208083447.GB7720@elte.hu>	 <41B726D1.6030009@cybsft.com> <1102522720.30593.3.camel@krustophenia.net>
In-Reply-To: <1102522720.30593.3.camel@krustophenia.net>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Wed, 2004-12-08 at 10:07 -0600, K.R. Foley wrote:
> 
>>I am still confused about one thing, unrelated to this. If RT tasks 
>>never expire and thus are never moved to the expired array??? Does that 
>>imply that we never switch the active and expired arrays? If so how do 
>>tasks that do expire get moved back into the active array?
> 
> 
> I think that RT tasks use a completely different scheduling mechanism
> that bypasses the active/expired array.
> 
> Lee
> 
> 
Please don't misunderstand. I am not arguing with you because obviously 
I am not really intimate with this code, but if the above statement is 
true then I am even more confused than I thought. I don't see any such 
distinctions in the scheduler code. In fact it looks to me like the 
whole scheduler is built on the premise of allowing RT tasks to be just 
like other tasks with a few exceptions, one of which is that RT tasks 
never hit the expired task array.

kr
