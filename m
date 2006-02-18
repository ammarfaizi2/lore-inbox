Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751443AbWBRQwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbWBRQwa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 11:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbWBRQwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 11:52:30 -0500
Received: from mail.tmr.com ([64.65.253.246]:52637 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S1751443AbWBRQw3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 11:52:29 -0500
Message-ID: <43F751B0.1040101@tmr.com>
Date: Sat, 18 Feb 2006 11:56:16 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "D. Hazelton" <dhazelton@enter.net>
CC: Daniel Barkalow <barkalow@iabervon.org>, Greg KH <greg@kroah.com>,
       Nix <nix@esperi.org.uk>, Jens Axboe <axboe@suse.de>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <43D7AF56.nailDFJ882IWI@burner> <Pine.LNX.4.64.0602131339140.6773@iabervon.org> <43F641A2.50200@tmr.com> <200602171902.11631.dhazelton@enter.net>
In-Reply-To: <200602171902.11631.dhazelton@enter.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

D. Hazelton wrote:

>On Friday 17 February 2006 16:35, Bill Davidsen wrote:
>  
>
>>Daniel Barkalow wrote:
>>    
>>
>>>I don't think it needs to be a class, but I think that there should be a
>>>single place with a directory for each device that could be what you
>>>want, with a file that tells you if it is. That's why I was looking at
>>>block/; these things must be block devices, and there aren't an huge
>>>number of block devices.
>>>
>>>I suppose "grep 1 /sys/block/*/device/dvdwriter" is just as good; I
>>>hadn't dug far enough in to realize that the reason I wasn't seeing
>>>anything informative in /sys/block/*/device/ was that I didn't have any
>>>devices with informative drivers, not that it was actually supposed to
>>>only have links to other things.
>>>      
>>>
>>It would be nice to have one place to go to find burners, and to have
>>the model information in that place. I would logically think that place
>>is sysfs, and I know the kernel has the information because if I root
>>through /proc/bus/usb and /proc/scsi/scsi, and /proc/ide/hd?/model I can
>>eventually find out what the system has connected.
>>
>>I not entirely sure about having classes other than cdrom, just because
>>we already have CD, DVD, DVD-DL, and are about to add blue-ray and
>>HD-DVD, so if I can tell that it's a removable device which can read
>>CDs, the applications have a fighting chance to looking at the device to
>>see what it is. As a human I would like the model information because
>>the kernel has done the work, why should people have to chase it when it
>>could be in one place?
>>    
>>
>
>The problem is that drives don't always cleanly report what they are in a 
>simple to access format. All SCSI and ATAPI drives provide a model, 
>manufacturer and serial number but usually the type of drive is buried within 
>the Model field, and that has a lot of variations.
>
>(I have personally seen CD/CDRW, CD-ROM, CD-RW, CDR, CDRW and DVD/CDROM)
>
>Now what could be done is that said information could be exported to sysfs. 
>Given the time I could probably manage the patch myself, but I'm currently 
>overextended with the number of projects I have underway.
>
I would think that the model, manufacturer and serial would be useful, 
and just the indication that the device was CD capable would be a huge 
gain. There are at least two more type of drive coming soon in the 25GB 
media race, so identification could legitimately be left to the 
application as long as all CD-like devices can easily be identified for 
examination.

Does that fit with your level of available time (and interest in 
resolving this issue)?

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

