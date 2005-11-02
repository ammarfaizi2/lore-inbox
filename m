Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751463AbVKBAH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbVKBAH3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 19:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbVKBAH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 19:07:28 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:34523 "EHLO
	pd2mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751463AbVKBAH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 19:07:28 -0500
Date: Tue, 01 Nov 2005 18:07:20 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: echo 0 > /proc/sys/vm/swappiness triggers OOM killer under 2.6.14.
In-reply-to: <5400l-3iY-37@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43680338.6040600@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <53VDs-5r1-5@gated-at.bofh.it> <53VDs-5r1-3@gated-at.bofh.it>
 <5400l-3iY-37@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:
>>>Under 2.6.14 (UML), I have a workload that runs with 64 megs ram and 256
>>>megs swap space.  It completes (albeit swapping like mad) with swappiness
>>>at the default 60, but if I set it to 0 the OOM killer kicks in and the
>>>script aborts.
>>
>>You should get some debugging output in dmesg when the OOM killer kicks
>>in, can you post this?

> oom-killer: gfp_mask=0x400d2, order=0

OK, nothing really special about this..

> Free pages:        1416kB (0kB HighMem)
> Active:14014 inactive:718 dirty:1 writeback:0 unstable:0 free:354 slab:468 
> mapped:14722 pagetables:58
> DMA free:1416kB min:1024kB low:1280kB high:1536kB active:56056kB 
> inactive:2872kB present:65536kB pages_scanned:26577 all_unreclaimable? no

It looks like some memory is available here, but likely some UML person 
would have to say for sure..

> Out of Memory: Killed process 30055 (cc1).
> Badness in handle_page_fault 
> at /home/landley/newbuild/firmware-build/tmpdir/linux-2.6.14/arch/um/kernel/trap_kern.c:98

You likely need a UML person for this part too :-)

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

