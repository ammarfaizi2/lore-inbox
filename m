Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264420AbTCXVIQ>; Mon, 24 Mar 2003 16:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264421AbTCXVIQ>; Mon, 24 Mar 2003 16:08:16 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:31198 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S264420AbTCXVIP>; Mon, 24 Mar 2003 16:08:15 -0500
Date: Mon, 24 Mar 2003 13:09:21 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Larry McVoy <lm@bitmover.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: lmbench results for 2.4 and 2.5 -- updated results
Message-ID: <543480000.1048540161@flay>
In-Reply-To: <20030324200105.GA5522@work.bitmover.com>
References: <C8C38546F90ABF408A5961FC01FDBF19010485F1@fmsmsx405.fm.intel.com> <20030324200105.GA5522@work.bitmover.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> --- LMbench/src/lat_pagefault.c.org	Mon Mar 24 10:40:46 2003
>> +++ LMbench/src/lat_pagefault.c	Mon Mar 24 10:54:34 2003
>> @@ -67,5 +67,5 @@
>>  		n++;
>>  	}
>>  	use_int(sum);
>> -	fprintf(stderr, "Pagefaults on %s: %d usecs\n", file, usecs/n);
>> +	fprintf(stderr, "Pagefaults on %s: %f usecs\n", file, (1.0 *
>> usecs) / n);
>>  }
> 
> It's been a long time since I've looked at this benchmark, has anyone 
> stared at it and do you believe it measures anything useful?  If not,
> I'll drop it from a future release.  If I remember correctly what I
> was trying to do was to measure the cost of setting up the mapping
> but I might be crackin smoke.

On a slightly related note, I played with lmbench a bit over the weekend,
but the results were too unstable to be useful ... they're also too short
to profile ;-( 

I presume it does 100 iterations of a test (like fork latency?). Or does 
it just do one? Can I make it do 1,000,000 iterations or something
fairly easily ? ;-) I didn't really look closely, just apt-get install
lmbench ... 

Thanks,

M.

