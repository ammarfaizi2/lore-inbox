Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263468AbTKFJdY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 04:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263472AbTKFJdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 04:33:24 -0500
Received: from bay4-f16.bay4.hotmail.com ([65.54.171.16]:3076 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S263468AbTKFJdV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 04:33:21 -0500
X-Originating-IP: [202.172.55.22]
X-Originating-Email: [slashboy84@msn.com]
From: "Wee Teck Neo" <slashboy84@msn.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Over used cache memory?
Date: Thu, 06 Nov 2003 17:33:19 +0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY4-F16sWUjGV8NtPH00022c46@hotmail.com>
X-OriginalArrivalTime: 06 Nov 2003 09:33:20.0184 (UTC) FILETIME=[03EB8380:01C3A449]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok...... Thanks got an idea how linux uses memory.

Thanks


----Original Message Follows----
From: Jerry Lundström <jerry.lundstrom@it.su.se>
To: Wee Teck Neo <slashboy84@msn.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Over used cache memory?
Date: Thu, 06 Nov 2003 10:16:19 +0100

Wee Teck Neo wrote:
>But seems like the swap space is begin used because of "insufficent" free 
>memory. I'm not sure if there is a performance slow down.
>

no no no, this is the way linux works. Memory from programs that are not 
accessed alot are put into the swap so that the not-so-offen-used memory can 
be used by other programs or the cache to speed up everything. When that 
program later access the swaped memory it will load it up and remove some of 
the cache and after a while it will put it back into the swap (dont have any 
numbers on how long till it will but trust linux, it does it very good).

I wouldnt worry at all about those numbers, they are very common in 1gig 
server systems and ive worked with alot of them, even 4gig mem systems use 
the swap, thats what its for...

If you are worried about preformance with memory and such after all 
configure you systems like this:

If you use IDE have the system disk on one IDE channel and a standalone swap 
disk on another IDE channel (not master or slave way but ide0 or ide1). For 
SCSI you can just put the swap on a seperate disk.
Doing this will speed up alot of stuff since linux have 100% access to the 
swap when it needs too, it doesnt have to share the IO to the disk with 
another partition.

Otherwise Id just say, dont worry about it... Linux knows what its doing...

hope it helps...

_________________________________________________________________
Keep track of Singapore & Malaysia stock prices. 
http://www.msn.com.sg/money/

