Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267202AbRGKFEP>; Wed, 11 Jul 2001 01:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267204AbRGKFEE>; Wed, 11 Jul 2001 01:04:04 -0400
Received: from wren.rentec.com ([192.5.35.106]:55477 "EHLO ram.rentec.com")
	by vger.kernel.org with ESMTP id <S267202AbRGKFDw>;
	Wed, 11 Jul 2001 01:03:52 -0400
Message-ID: <3B4BEC57.7000509@rentec.com>
Date: Wed, 11 Jul 2001 01:04:07 -0500
From: Dirk Wetter <dirkw@rentec.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.2+) Gecko/20010707
X-Accept-Language: en-us
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Wayne Whitney <whitney@math.berkeley.edu>, linux-kernel@vger.kernel.org
Subject: Re: dead mem pages
In-Reply-To: <Pine.LNX.4.33L.0107102013560.2836-100000@imladris.rielhome.conectiva>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Filter-Version: 1.3 (wren)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rik,

thx for your answer. :)

Rik van Riel wrote:

>On Tue, 10 Jul 2001, Dirk Wetter wrote:
>
>>>It would be good to know what these 2.8GB of cached pages are.
>>>
>>believe me, i would like to know too where all the $$$ memory
>>went to. ;-)
>>
>
>Most likely swap cache, that means it is the memory from your
>simulations, just removed from the page tables and put in the
>swap cache.
>
but why was the machine actually swapping then? sar definetely showed swap
and disk activity as the applications started.

>>>Again on a general note, the 2.4 kernel's VM is new and hence not fully
>>>mature.  So the short and unhelpful answer to your query is probably that
>>>the current VM system is not well tuned for your workload (4.3GB of memory
>>>hungry simulations on a 4GB machine).
>>>
>>concerning the maturity that's also the answer i got from the kernel
>>guru's at last USENIX in boston. but ihmo it *should* become soon
>>better for the future if Linux intends to become bigger in the server
>>business. (my $0.02)
>>
>
>It'll get better as soon as we have the time, for 2.4.7
>the VM statistics have already improved a bit so people
>are no longer fooled by large "cached" figures ;)
>
Rik (and Wayne): it's *not only* the statistics. they were swapping like 
crazy.
the only thing the machines were responding immediately to were icmp 
packets.
no tcp/udp. keystrokes on the console were echoed 2 minutes after i 
typed the command
in. with some patience i managed to execute "top" i caught pictures were 
kswapd
was in the first line having 99% or so of one CPU and the load was between
20 and 30.

>
>Actual improvements to the code, if needed at all, will
>come with time ... more than $0.02 will get you ;)
>
not that i don't appreciate very much your work, but i had to learn that 
improvements are
needed:  we could swap our 4GB machines to death just by submitting jobs 
in the size
of the ~physical memory to them. but i don't have any doubts that you 
guys will manage
to do neccessary changes:-)

i do the profile tests Marcelo suggested (thx) and come back with some 
numbers.

tschuess :-)

        ~dirkw




