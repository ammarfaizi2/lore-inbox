Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318210AbSIOTb7>; Sun, 15 Sep 2002 15:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318211AbSIOTb7>; Sun, 15 Sep 2002 15:31:59 -0400
Received: from host.greatconnect.com ([209.239.40.135]:27909 "EHLO
	host.greatconnect.com") by vger.kernel.org with ESMTP
	id <S318210AbSIOTb6>; Sun, 15 Sep 2002 15:31:58 -0400
Message-ID: <3D84E1E8.1070408@rackable.com>
Date: Sun, 15 Sep 2002 12:39:20 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Stephen Lord <lord@sgi.com>, Andrea Arcangeli <andrea@suse.de>,
       Austin Gonyou <austin@coremetrics.com>,
       Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-xfs@oss.sgi.com
Subject: Re: 2.4.20pre5aa2
References: <20020911184111.GY17868@dualathlon.random> <3D81235B.6080809@rackable.com> <20020913002316.GG11605@dualathlon.random> <1031878070.1236.29.camel@snafu> <20020913005440.GJ11605@dualathlon.random> <3D8149F6.9060702@rackable.com> <20020913125345.GO11605@dualathlon.random> <3D825422.8000007@rackable.com> <20020913211844.GP11605@dualathlon.random> <1032014367.1050.2.camel@laptop.americas.sgi.com> <20020915131324.A13516@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andi Kleen wrote:

>On Sat, Sep 14, 2002 at 09:39:24AM -0500, Steve Lord wrote:
>  
>
>>On Fri, 2002-09-13 at 16:18, Andrea Arcangeli wrote:
>>
>>    
>>
>>>So, returning to xfs, it is possible dbench really generates lots of
>>>simultaneous vmaps because of its concurrency, so I would suggest to add
>>>an atomic counter increased at every vmap/vmalloc and decreased at every
>>>vfree and to check it after every increase storing the max value in a
>>>sysctl, to see what's the max concurrency you reach with the vmaps. (you
>>>can also export the counter via the sysctl, to verify for no memleaks
>>>after unmounting xfs)
>>>
>>>Andrea
>>>      
>>>
>>There are no vmaps during normal operation on xfs unless you are
>>setting extended attributes of more than 4K in size, or you
>>used some more obscure mkfs options. Only filesystem recovery will
>>use it otherwise. 
>>    
>>
>
>Perhaps the original poster used those obscure mkfs options? What option
>will trigger huge allocations ? 
>

  I did not use any special options on the filesystem that had the issue.



