Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267515AbUIGDR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267515AbUIGDR0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 23:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267519AbUIGDR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 23:17:26 -0400
Received: from relay.pair.com ([209.68.1.20]:39186 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S267515AbUIGDRY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 23:17:24 -0400
X-pair-Authenticated: 66.188.111.210
Message-ID: <413D2842.8030401@cybsft.com>
Date: Mon, 06 Sep 2004 22:17:22 -0500
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Ingo Molnar <mingo@elte.hu>, Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       felipe_alfaro@linuxmail.org
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R5
References: <20040903120957.00665413@mango.fruits.de>	 <20040904195141.GA6208@elte.hu> <20040905140249.GA23502@elte.hu>	 <1094408203.4445.5.camel@krustophenia.net> <20040905191227.GA29797@elte.hu>	 <1094418192.4445.58.camel@krustophenia.net>	 <20040906063040.GA11541@elte.hu> <1094456653.29921.45.camel@krustophenia.net>
In-Reply-To: <1094456653.29921.45.camel@krustophenia.net>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Mon, 2004-09-06 at 02:30, Ingo Molnar wrote:
> 
>>* Lee Revell <rlrevell@joe-job.com> wrote:
>>
>>
>>>http://krustophenia.net/testresults.php?dataset=2.6.9-rc1-R0#/var/www/2.6.9-rc1-R0/foo.hist
>>>
>>>I find the two smaller spikes to either side of the central spike
>>>really odd.  These showed up in my jackd tests too, I had attributed
>>>them to some measurement artifact, but they seem real.  Maybe a
>>>rounding bug, or some kind of weird cache effect?
>>
>>interesting - the histograms are pretty symmetric around the center.
>>E.g. the exponential foo.hist2 diagram is way too symmetric around 50
>>usecs! What precisely is being measured?
>>
> 
> 
> Here's the program.  It does mlockall(), acquires realtime scheduling,
> then sets up a 2048 Hz stream of interupts from the RTC and measures the
> delay.  It's quite possible there's a bug, the amlat program did not
> seem to work, something must have changed with the RTC from 2.4 to 2.6.
> 

Actually the amlat program works fine for applying real-time scheduling 
pressure. I believe it just doesn't do any real latency measuring 
without the hooks provided by Andrew's rtc-debug patch.

kr
