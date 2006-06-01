Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030228AbWFATm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030228AbWFATm4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 15:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030232AbWFATm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 15:42:56 -0400
Received: from mail.tmr.com ([64.65.253.246]:3000 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S1030228AbWFATm4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 15:42:56 -0400
Message-ID: <447EF7BE.1020005@tmr.com>
Date: Thu, 01 Jun 2006 10:20:46 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [git patch] libata resume fix
References: <6hAdo-5CV-5@gated-at.bofh.it> <6hXD0-6Y9-1@gated-at.bofh.it> <6icsx-4vp-33@gated-at.bofh.it> <6ih8Y-3ba-15@gated-at.bofh.it> <6iH3h-2xw-59@gated-at.bofh.it> <447E5EAD.5070808@shaw.ca> <20060601134802.GK4400@suse.de>
In-Reply-To: <20060601134802.GK4400@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>On Wed, May 31 2006, Robert Hancock wrote:
>  
>
>>Bill Davidsen wrote:
>>    
>>
>>>The trade-off is that if I have a 15k rpm SCSI drive, it would take a 
>>>lot of design changes to make it spin up quickly, and improve a function 
>>>which is usually done on a server once every MTBF when replacing the 
>>>failed unit.
>>>
>>>I think the majority of very large or very fast drives are in systems 
>>>which don't (deliberately) power cycles often, in rooms where heat is an 
>>>issue. And to spin up quickly take a larger power supply... 30 sec is 
>>>fine with most users.
>>>
>>>Couldn't find a spin-up time for the new Seagate 750GB drive, but the 
>>>seek sure is fast!
>>>      
>>>
>>I wouldn't guess that even a 15K drive would take nearly that long. For 
>>boot time on servers it doesn't matter much though, disk spinup time is 
>>    
>>
>
>I do use a 15K rpm drive in my workstation (hello git!), and the spin up
>really isn't that bad. Less than 10 seconds for the actual spin up, I
>would say.
>  
>
Sounds about right, but clearly longer than the 2 sec mentioned early in 
this thread. I think a long delay is okay as long as it gets stopped 
when the drive does come ready.

>  
>
>>in the noise compared to the insane BIOS delays on most of them during 
>>bootup. Like on some servers (ahem.. IBM) which have about a 15 second 
>>delay on the main BIOS screen, 10 second delays on every network boot 
>>ROM, a 1 minute delay on the SCSI controller before it even starts 
>>scanning the bus, then another good 10 seconds before it starts booting. 
>>Gets annoying after a few reboots..
>>    
>>
>
>Indeed, the BIOS bootup time on servers is typically anywhere from
>really bad to truly awful.
>
>  
>
I try *very* hard not to do bootup on servers, the paperwork involved 
with an outage takes longer than the boot time ;-)

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

