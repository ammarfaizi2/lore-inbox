Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262359AbTHUCdo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 22:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbTHUCdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 22:33:44 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:36882 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262359AbTHUCdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 22:33:42 -0400
Message-ID: <3F442FEC.1050605@yahoo.com>
Date: Wed, 20 Aug 2003 22:35:24 -0400
From: Brandon Stewart <rbrandonstewart@yahoo.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
CC: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       linux-kernel@vger.kernel.org
Subject: Re: usb-storage: how to ruin your hardware(?)
References: <200308210205.h7L25PI6012011@wildsau.idv.uni.linz.at>
In-Reply-To: <200308210205.h7L25PI6012011@wildsau.idv.uni.linz.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think what Matt is saying is that certain functionality of the USB 
device is soft-coded. So once this data is gone from the device, trying 
to write to or from it will fail, since the read and write commands are 
(partially) soft-coded. If this is true, then writing to this device is 
like trying to ping a computer that was booted up, but had no operating 
system loaded. It would seem weird to create a device in such a manner, 
but it is not outside the realm of possibility.

I had a printer (hp lj1000) that operated in exactly this fashion. To 
work, its firmware needed to be cat'ed to the device before any printing 
was done. I never got this working and instead just returned the printer 
and replaced it with a postscript compliant model. I recommend that you 
do similar. No sense eating the cost. It will be impetus for the 
manufacturers to make robust and compatible devices.

-Brandon

H.Rosmanith (Kernel Mailing List) wrote:

>-- Start of PGP signed section.
>  
>
>>For the vast majority of USB storage devices, it's not possible to kill the
>>device like you did.
>>
>>It looks like the device firmware needs certain data on the first sector to
>>operate.  The usb-storage communication is working just fine, but the
>>device is refusing commands.
>>    
>>
>
>aha. do you know why the device is refusing commands? it relys on sector0
>to contain some vital information and if this is not there, it refuses
>commands?
>
> 
>  
>
>>Likely, the unit is unrecoverable unless you can figure out the magic that
>>the manufacturer uses to write that beginning few sectors of data.
>>    
>>
>
>pfhew....I once sent an email to Prolific (manufacturer of this device), but
>never got an answer. so, one needs the layout of the first sectors and
>a method how to write that ... I wonder if Prolific has this info on their
>website ...
>
> 
>  
>
>>Matt
>>
>>P.S.  I commonly put ext2/3 filesystems on my CF cards without any
>>problems.
>>
>>P.P.S. The 'strange partition table' you saw probably wasn't a partition
>>table at all -- it was likely the start of a VFAT filesystem.  I'm guessing
>>that if you had just mounted /dev/sda (notice no partition number!), it
>>would have worked.
>>    
>>
>
>I see. the whole flash disk is a single filesystem without partitions
>(I used to format HDs this way in the old days :->
>
>do you think it is possible to "mke2fs /dev/sda" (once I return the
>USB BAR to the vendor and tell them it's "somehow damaged, no idea
>why") on a new  
>

