Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268053AbUIKAVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268053AbUIKAVs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 20:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268056AbUIKAVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 20:21:48 -0400
Received: from relay.pair.com ([209.68.1.20]:14091 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S268053AbUIKAVg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 20:21:36 -0400
X-pair-Authenticated: 66.188.111.210
Message-ID: <4142450D.1050301@cybsft.com>
Date: Fri, 10 Sep 2004 19:21:33 -0500
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       felipe_alfaro@linuxmail.org, Florian Schmidt <mista.tapas@gmx.net>,
       Mark_H_Johnson@Raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R6
References: <20040903120957.00665413@mango.fruits.de>	 <20040904195141.GA6208@elte.hu> <20040905140249.GA23502@elte.hu>	 <20040906110626.GA32320@elte.hu>	 <1094626562.1362.99.camel@krustophenia.net> <20040909192924.GA1672@elte.hu>	 <20040909130526.2b015999.akpm@osdl.org>  <20040910132841.GA8552@elte.hu> <1094856888.2721.7.camel@krustophenia.net>
In-Reply-To: <1094856888.2721.7.camel@krustophenia.net>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Fri, 2004-09-10 at 09:28, Ingo Molnar wrote:
> 
>>* Andrew Morton <akpm@osdl.org> wrote:
>>
>>
>>>diff -puN mm/vmscan.c~swapspace-layout-improvements mm/vmscan.c
>>>--- 25/mm/vmscan.c~swapspace-layout-improvements	2004-06-03 21:32:51.087602712 -0700
>>>+++ 25-akpm/mm/vmscan.c	2004-06-03 21:32:51.102600432 -0700
>>
> 
> OK, Andrew's patch seems to be an improvement.  I can still cause
> unbounded latencies, but these only seem to happen when we fill all
> available RAM and swap space, at which point we start spending
> milliseconds at a time in scan_swap_map:
> 
> 

I see much improved performance so far. Been running for about 3 hours 
and the highest latency I've seen thus far is ~260 usec and that was 
mmap not swap. The highest latency I've seen from swapping is ~198 and 
we have been in and out of swap at least several times. The latency 
trace can be seen here:

http://www.cybsft.com/testresults/2.6.9-rc1-bk12-S0/latencytrace1.txt

kr
