Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261458AbULIGLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbULIGLV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 01:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbULIGLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 01:11:21 -0500
Received: from relay02.pair.com ([209.68.5.16]:6660 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S261458AbULIGLO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 01:11:14 -0500
X-pair-Authenticated: 24.241.238.70
Message-ID: <41B7BC60.1060407@cybsft.com>
Date: Wed, 08 Dec 2004 20:45:52 -0600
From: "K.R. Foley" <kr@cybsft.com>
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
References: <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu> <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu> <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu> <20041207141123.GA12025@elte.hu> <41B6839B.4090403@cybsft.com> <20041208083447.GB7720@elte.hu> <41B726D1.6030009@cybsft.com>
In-Reply-To: <41B726D1.6030009@cybsft.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

K.R. Foley wrote:
<snip>

> 
> I am still confused about one thing, unrelated to this. If RT tasks 
> never expire and thus are never moved to the expired array??? Does that 
> imply that we never switch the active and expired arrays? If so how do 
> tasks that do expire get moved back into the active array?
> 
OK dumb question. I am going out to get my own personal brown paper bag, 
since I seem to be wearing it so often. I forgot tasks get removed from 
the runqueue when they are sleeping, etc. so the active array should 
empty most of the time. However, with more RT tasks and interactive 
tasks being thrown back into the active queue I could see this POSSIBLY 
occasionally starving a few processes???

kr
<snip>
