Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264251AbUELGyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264251AbUELGyq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 02:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264815AbUELGyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 02:54:46 -0400
Received: from mail.genesys.ro ([193.230.224.5]:46565 "EHLO mail.genesys.ro")
	by vger.kernel.org with ESMTP id S264251AbUELGyn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 02:54:43 -0400
Message-ID: <40A1CA8E.6020406@genesys.ro>
Date: Wed, 12 May 2004 09:56:14 +0300
From: Silviu Marin-Caea <silviu@genesys.ro>
Organization: Genesys Software Romania [ http://www.genesys.ro ]
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a) Gecko/20040511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
Cc: Ray Bryant <raybry@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: dynamic allocation of swap disk space
References: <fa.n6pggn5.84en31@ifi.uio.no> <40A0EFC0.1040609@sgi.com> <200405111552.i4BFqFMN000112@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200405111552.i4BFqFMN000112@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:
> Quote from Ray Bryant <raybry@sgi.com>:
> 
>>
>>Silviu Marin-Caea wrote:
>>
>>>
>>>My desktop has been thrashing the disk for a couple of hours because
>>>the swap space was exhausted.  And I have the ambition to leave it alone
>>>to see if it ever comes out of the thrashing.  Of course, it's not usable
>>>at all during this time, I'm writing this on the laptop.
>>>
>>>
>>
>>You've got a couple problems mixed together here.
>>
>>(1)  Swap space fills up because you have overcommitted memory.  In principle, 
>>filling up swap space has nothing to do with "thrashing".
>>(2)  "thrashing" is a characteristic of a poorly performing program in a
>>demand paging virtual memory system typically caused by trying to run a 
>>program with a resident size that is smaller than required.  Systems can 
>>thrash without filling up swap space.  It is true that systems can thrash AND 
>>fill up swap space, but it is not always so.
>>
>>You either need (1)  more main memory, (2) reduce the number of programs you 
>>are running simultaneously, or (3) better behaving programs, or all three. 
>>Increasing the amount of swap space will just use more disk.  It won't cause 
>>your system to stop thrashing since that is driven by what is going on in 
>>memory, not what is going on on the disk.
> 
> 
> Not necessarily.  Increasing swap can allow more physical RAM to be used for
> caching data from disk.
> 
> Imagine a system with limited physical RAM, and limited swap space, running a
> process which causes a lot of filesystem activity on the same physical disk
> as is being used for swap.  If the total RAM, both physical and swap is almost
> completely full, increasing the swap space may allow some data from physical
> RAM to be swapped out, in favour of caching filesystem data from the disk.
> 
> Without knowing more details of the original poster's machine, it's difficult
> to give specific advice about how to solve the problem.

1 GB RAM desktop machine, with 32 MB swap, kernel 2.6.3.  In normal 
operation, the swap is 80% free.  It started the thrashing when I loaded 
a HUGE page (generated from a database) in konqueror.

The issue is not to solve _my_ problem, I really don't care about it 
that much, the issue would be to solve this sort of problem for 
everyone.  I've had disk thrashing with filled up swap on a server 
(kernel 2.4) and that was much worse.  Anyway, I'll start using swapd 
and see what happens.  Some time in the future, I'll post here the 
conclusion.
