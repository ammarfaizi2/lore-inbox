Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWCVD0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWCVD0I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 22:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbWCVD0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 22:26:08 -0500
Received: from rwcrmhc12.comcast.net ([204.127.192.82]:54165 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750707AbWCVD0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 22:26:05 -0500
Message-ID: <4420C3CA.6090206@comcast.net>
Date: Tue, 21 Mar 2006 22:26:02 -0500
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ed Sweetman <safemode@comcast.net>
CC: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: 2.6.16-rc6-ide1 irq trap, io hang problem solved?
References: <442089CB.1000008@comcast.net> <1142985995.4532.195.camel@mindpipe> <44209997.9010708@comcast.net>
In-Reply-To: <44209997.9010708@comcast.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Sweetman wrote:

> Lee Revell wrote:
>
>> On Tue, 2006-03-21 at 18:18 -0500, Ed Sweetman wrote:
>>  
>>
>>> I've seen some traffic here to suggest that the problem was tracked 
>>> down, but I saw nothing about it being solved completely.  Currently 
>>> my system hangs whenever an irq trap message appears, usually after 
>>> some sort of disk io on SATA drives. Is it fixed in the GIT patchset 
>>> recently posted or is this still open?    
>>
>>
>> Are you referring to the "Losing ticks" bug?  What is the exact error
>> message that you get?  Does the system hang momentarily or have to be
>> rebooted?
>>
>> Lee
>>
>>
>>  
>>
> No not the ticks bug.
>
> ata3: irq trap
> ata3: command 0x25 timeout, stat 0x50 host_stat 0x60
> ata4: irq trap
> ata4: command 0x25 timeout, stat 0x50 host_stat 0x20
> ata4: irq trap
> ata4: command 0x35 timeout, stat 0x50 host_stat 0x20
> ata3: irq trap
> ata3: command 0x35 timeout, stat 0x50 host_stat 0x60
>
>
> Over and over in random orientations.   System hangs on io 
> momentarily, usually a few seconds. No fs errors, no other errors 
> given.   System also seems to have been kicked out of DMA mode at 
> least for disks.




This has been fixed in the actual release of 2.6.16-ide1 which i've just 
booted into.  DMA seems active (as you'd expect since non-dma isn't 
supported) and no irq trap delays.   Everything is working good again,   
Now if there was a way to get the CF disk (doesn't do dma) working in 
pata, I'd be set.

ps.  Thanks for the help, I wasn't aware of the ide1 patch to 2.6.16 
before.
