Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263178AbUDSGNE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 02:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263335AbUDSGNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 02:13:04 -0400
Received: from smtp103.mail.sc5.yahoo.com ([66.163.169.222]:15442 "HELO
	smtp103.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263178AbUDSGNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 02:13:00 -0400
Message-ID: <40836DE8.5080303@yahoo.com.au>
Date: Mon, 19 Apr 2004 16:12:56 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: piotr@larroy.com, linux-kernel@vger.kernel.org
Subject: Re: CFQ iosched praise: good perfomance and better latency
References: <20040419005651.GA7860@larroy.com>	<40835F4E.5000308@yahoo.com.au> <20040418225752.56d10695.akpm@osdl.org>
In-Reply-To: <20040418225752.56d10695.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>Pedro Larroy wrote:
>>
>>>Hi
>>>
>>>I've been trying CFQ ioscheduler in my software raid5 with nice results,
>>>I've observed that a latency pattern still exists, just as in the
>>>anticipatory ioscheduler, but those spikes are now much lower (from
>>>6ms with AS to 2ms with CFQ as seen in the bottom of
>>>http://pedro.larroy.com/devel/iolat/analisys/),
>>>plus apps seems to get a fair amount of io so they don't get starved.
>>>
>>>Seems a good choice for io loaded boxes. Thanks Jens Axboe.
>>>
>>
>>Although AS isn't at its best when behind raid devices (it should
>>probably be in front of them), you could be seeing some problem
>>with the raid code.
>>
>>I'd be interested to see what the graph looks like with elevator=noop
> 
> 
> This isn't a very surprising result, is it?  AS throws away latency to gain
> throughput.  Pedro is measuring latency...
> 

Well I think Pedro actually means *seconds*, not ms. The URL
shows AS peaks at nearly 10 seconds latency, and CFQ over 2s.

It really seems like a raid problem though, because latency
measured at the individual devices is under 250ms for AS.
