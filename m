Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267730AbUHYOfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267730AbUHYOfm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 10:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267594AbUHYOfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 10:35:42 -0400
Received: from mail3.utc.com ([192.249.46.192]:21986 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S266807AbUHYOfT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 10:35:19 -0400
Message-ID: <412CA37F.90507@cybsft.com>
Date: Wed, 25 Aug 2004 09:34:39 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Ingo Molnar <mingo@elte.hu>, Scott Wood <scott@timesys.com>,
       manas.saksena@timesys.com, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P9
References: <20040823221816.GA31671@yoda.timesys>	 <20040824061459.GA29630@elte.hu>  <412C04DB.9000508@cybsft.com> <1093404161.5678.12.camel@krustophenia.net>
In-Reply-To: <1093404161.5678.12.camel@krustophenia.net>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Tue, 2004-08-24 at 23:17, K.R. Foley wrote:
> 
>>Ingo Molnar wrote:
>>
>>>  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P9
>>>
> 
> 
>>latency trace of ~148 usec in scsi_request? I don't know if this is real 
>>or not. Note the 79 usec here:
>>
>>00000001 0.107ms (+0.079ms): sd_init_command (scsi_prep_fn)
>>
>>Entire trace is here:
>>
>>http://www.cybsft.com/testresults/2.6.8.1-P9/latency_trace7.txt
>>
>>
>>Is this possible? This is not the first time I have seen this. There is 
>>another one here:
>>
>>http://www.cybsft.com/testresults/2.6.8.1-P9/latency_trace5.txt
>>
> 
> 
> This looks like a real latency.  What is
> /sys/block/sdX/queue/max_sectors_kb set to?  Does lowering it help?
> 
> Lee
> 
> 
/sys/block/sda/queue/max_sectors_kb was set to 512, trying it at 256. 
Hard to say whether it is helping or not. Looking at dmesg I do see some 
traces for scsi_request in the range of 39 - 72 usec. However, anything 
higher (up to 115 usec) could be masked by one of the netif_skb 
latencies that I am still seeing. Not only that, but I have only caught 
a hand-full of these scsi traces in all of my testing.

kr
