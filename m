Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261722AbVCGJXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbVCGJXv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 04:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbVCGJWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 04:22:45 -0500
Received: from ns1.lanforge.com ([66.165.47.210]:50083 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S261709AbVCGJWe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 04:22:34 -0500
Message-ID: <422C1D57.9040708@candelatech.com>
Date: Mon, 07 Mar 2005 01:22:31 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Christian Schmid <webmaster@rapidforum.com>, linux-kernel@vger.kernel.org
Subject: Re: BUG: Slowdown on 3000 socket-machines tracked down
References: <4229E805.3050105@rapidforum.com> <422BAAC6.6040705@candelatech.com> <422BB548.1020906@rapidforum.com> <422BC303.9060907@candelatech.com> <422BE33D.5080904@yahoo.com.au>
In-Reply-To: <422BE33D.5080904@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Ben Greear wrote:
> 
>> Christian Schmid wrote:
>>
>>> Ben Greear wrote:
> 
> 
>>>> How many bytes are you sending with each call to write()/sendto() 
>>>> whatever?
>>>
>>>
>>>  
>>> I am using sendfile-call every 100 ms per socket with the poll-api. 
>>> So basically around 40 kb per round.
>>
>>
>>
>> My application is single-threaded, uses non-blocking IO, and 
>> sends/rcvs from/to memory.
>> It will be a good test of the TCP stack, but will not use the sendfile 
>> logic,
>> nor will it touch the HD.
>>
> 
> I think you would have better luck in reproducing this problem if you
> did the full sendfile thing.
> 
> I think it is becoming disk bound due to page reclaim problems, which
> is causing the slowdown.
> 
> In that case, writing the network only test would help to confirm the
> problem is not a networking one - so not useless by any means.

It's not trivial to write something like this :)

I'll be using something I already have.  If I can't reproduce the problem,
then perhaps it is due to sendfile and someone can write a customized
test.  The main reason I offered is because people are ignoring the
bug report for the most part and asking for a test case.  I may be able
to offer an independent verification of the problem which might convince
someone to write up a dedicated test case...

Ben


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

