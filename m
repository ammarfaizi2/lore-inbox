Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbUIDOf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbUIDOf7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 10:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbUIDOf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 10:35:56 -0400
Received: from relay.pair.com ([209.68.1.20]:4370 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S261711AbUIDOfr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 10:35:47 -0400
X-pair-Authenticated: 66.188.111.210
Message-ID: <4139D2C1.2020202@cybsft.com>
Date: Sat, 04 Sep 2004 09:35:45 -0500
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
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R3
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com> <20040902063335.GA17657@elte.hu> <20040902065549.GA18860@elte.hu> <20040902111003.GA4256@elte.hu> <20040902215728.GA28571@elte.hu> <4138A56B.4050006@cybsft.com> <20040903181710.GA10217@elte.hu> <20040903193052.GA16617@elte.hu> <413939F8.1030806@cybsft.com> <20040904085717.GA15744@elte.hu>
In-Reply-To: <20040904085717.GA15744@elte.hu>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * K.R. Foley <kr@cybsft.com> wrote:
> 
> 
>>After hammering the system for a little more than an hour it gave up.
>>I don't have the serial logging setup yet because I haven't had time
>>this evening. I will be glad to do whatever I can to try to help debug
>>this, but it will have to wait until tomorrow. The log is here:
>>
>>http://www.cybsft.com/testresults/crashes/2.6.9-rc1-vo-R3.txt
> 
> 
> fyi, i have now triggered a similar crash on a testbox too. It takes
> quite some time to trigger but it does.
> 
> since it happens with VP=0,KP=0,SP=0,HP=0 as well it should be one of
> the cond_resched_lock() (or cond_resched()) additions.
> 
> 	Ingo
> 

I am glad that it's reproducible for you as well. How did you trigger 
it? Because it seems to only crash under heavy load for me. The system 
has been up since I rebooted last night after the crash and I haven't 
seen any problems. Same thing goes for up until last night when I booted 
the new patch. Even building the new patch didn't seem to be enough to 
trigger it.

kr
