Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965036AbWFTIav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965036AbWFTIav (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 04:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965038AbWFTIav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 04:30:51 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:10439 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965036AbWFTIau (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 04:30:50 -0400
Message-ID: <4497B230.5000508@garzik.org>
Date: Tue, 20 Jun 2006 04:30:40 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Laurent Vivier <Laurent.Vivier@bull.net>
CC: Qi Yong <qiyong@fc-cn.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, "Stephen C. Tweedie" <sct@redhat.com>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mingming Cao <cmm@us.ibm.com>, linux-fsdevel@vger.kernel.org,
       alex@clusterfs.com, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>	<4488E1A4.20305@garzik.org>	<20060609083523.GQ5964@schatzie.adilger.int>	<44898EE3.6080903@garzik.org>	<1149885135.5776.100.camel@sisko.sctweedie.blueyonder.co.uk>	<Pine.LNX.4.64.0606091344290.5498@g5.osdl.org> <4497927F.4070307@fc-cn.com> <4497B126.4000408@bull.net>
In-Reply-To: <4497B126.4000408@bull.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Vivier wrote:
> Qi Yong wrote:
>> Linus Torvalds wrote:
>>
>>> On Fri, 9 Jun 2006, Stephen C. Tweedie wrote:
>>>  
>>>
>>>> When is the Linux syscall interface enough?  When should we just bump it
>>>> and cut out all the compatibility interfaces?
>>>>
>>>> No, we don't; we let people configure certain obsolete bits out (a.out
>>>> support etc), but we keep it in the tree despite the indirection cost to
>>>> maintain multiple interfaces etc.
>>>>    
>>>>
>>> Right. WE ADD NEW SYSTEM CALLS. WE DO NOT EXTEND THE OLD ONES IN WAYS THAT 
>>> MIGHT BREAK OLD USERS.
>>>
>>> Your point was exactly what?
>>>
>>> Btw, where did that 2TB limit number come from? Afaik, it should be 16TB 
>>> for a 4kB filesystem, no?
>>>  
>>>
>> Partition tables describe partitions in units of one sector.
>> 2^(32+9) = 2T
>>
>> To prevent integer overflow, we should use only 31 bits of a 32-bit integer.
>> 2^(31+12) = 8T
>>
>> There's _terrible_ hacks to really get to 16T.
>>
>> -- qiyong
>>
> 
> IMHO, a simple solution is to use "Logical Volume Manager" instead of partition
> manager: we create 64bit filesystem in a Logical Volume, not in a partition.

That doesn't solve anything, if you are not using a 64bit filesystem.


> "partitioning is obsolete" ;-)

LVM is nothing but a partition manager...

	Jeff



