Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932553AbVHSElM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932553AbVHSElM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 00:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbVHSElM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 00:41:12 -0400
Received: from omta05sl.mx.bigpond.com ([144.140.93.195]:11098 "EHLO
	omta05sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932553AbVHSElM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 00:41:12 -0400
Message-ID: <430562E5.1070208@bigpond.net.au>
Date: Fri, 19 Aug 2005 14:41:09 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Lee Revell <rlrevell@joe-job.com>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Schedulers benchmark - Was: [ANNOUNCE][RFC] PlugSched-5.2.4 for
 2.6.12 and 2.6.13-rc6
References: <43001E18.8020707@bigpond.net.au> <6bffcb0e050818200936bad1d3@mail.gmail.com> <1124422128.25424.7.camel@mindpipe> <200508191341.24821.kernel@kolivas.org>
In-Reply-To: <200508191341.24821.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-6; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Fri, 19 Aug 2005 04:41:09 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Fri, 19 Aug 2005 01:28 pm, Lee Revell wrote:
> 
>>On Fri, 2005-08-19 at 05:09 +0200, Michal Piotrowski wrote:
>>
>>>Hi,
>>>here are interbench v0.29 resoults:
>>
>>The X test under simulated "Compile" load looks most interesting.
>>
>>Most of the schedulers do quite poorly on this test - only Zaphod with
>>default max_ia_bonus and max_tpt_bonus manages to deliver under 100ms
>>max latency.  As expected with interactivity bonus disabled it performs
>>horribly.
> 
> 
> The compile load is not a real compile load; it is an extreme exaggeration of 
> what happens during a compile and this is done to increase the sensitivity of 
> this test. It is _not_ worth trying to get a perfect score in this.
> 
> 
>>I'd like to see some results with X reniced to -10.  Despite what the
>>2.6 release notes say, this still seems to make a difference.
> 
> 
> Well of course it helps X - but then any X load totally fscks up audio on 
> mainline and staircase which is why it's recommended not to renice it.

Maybe we could use interbench to find a nice value for X that doesn't 
destroy Audio and Video?  The results that I just posted for 
spa_no_frills with X reniced to -10 suggest that the other schedulers 
could cope with something closer to zero.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
