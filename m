Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269651AbRHIE5M>; Thu, 9 Aug 2001 00:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269672AbRHIE5D>; Thu, 9 Aug 2001 00:57:03 -0400
Received: from Huntington-Beach.blue-labs.org ([208.179.59.198]:1140 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S269651AbRHIE4x>; Thu, 9 Aug 2001 00:56:53 -0400
Message-ID: <3B7217FF.3060104@blue-labs.org>
Date: Thu, 09 Aug 2001 00:56:31 -0400
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: Marty Poulin <mpoulin@playnet.com>
CC: David Lang <david.lang@digitalinsight.com>, Ben Ford <ben@kalifornia.com>,
        David Wagner <daw@mozart.cs.berkeley.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: summary Re: encrypted swap
In-Reply-To: <Pine.LNX.4.33.0108071957170.3450-100000@dlang.diginsite.com> <3B70E4C8.2020400@blue-labs.org> <041d01c1205a$5afd9c00$0b32a8c0@playnet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Encrypted swap isn't a complete solution either.  As systems continue to 
evolve and processes begin to share space across machines or migrate to 
other machines, the data becomes visible in one medium or another.  Due 
to the penalty incurred with encrypting swap or a like solution, the 
cost is prohibitive as a general solution.

Two means to minimize this cost are (a) in userspace encrypt the data 
before leaving it stored in memory or (b) have a flag that marks a given 
page as _PAGE_ENCRYPTION so that only that page is encrypted while the 
rest of the pages are left alone.

The first solution is userspace only and portable across all other 
mediums.  The second solution minimizes cost at the granular level of a 
page boundary.

In any given case, physical access renders most solutions void or 
significantly paled.  I am not however of the opinion that the concept 
should be dropped.  I firmly believe in layered security, not a 
one-stop-solution.  That is to say that I will layer thin or weak 
security just as I would add heavy security.  Simply making your data 
look uninviting is sufficient to drive away most would-be's.

David

Marty Poulin wrote:

>>You can't guarantee much if the machine is physically compromised.  In
>>the situation of wiping, you probably won't need swap immediately after
>>boot so you can afford to execute a script that wipes the file/partition
>>then mounts it.
>>
>>It's all easily accomplished in userspace.
>>
>>David
>>
>This all depends on what the circumstances are.  If you are talking about
>someone being able to walk up to the machine while on and pull the memory
>cards, nope we cant stop that with the OS.
>
>That is not what we are trying to do, one of the specific scenarios was the
>example of a notebook computer that either was shut off quickly or freezes.
>If this notebook is stolen before the system is rebooted presto the crook
>has access to everything in the swap.  All he has to do is take out the
>drive and put it in another system.
>
>The solution to that is encrypted swap.
>

