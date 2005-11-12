Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbVKLLRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbVKLLRZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 06:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbVKLLRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 06:17:25 -0500
Received: from c-67-177-11-17.hsd1.ut.comcast.net ([67.177.11.17]:10880 "EHLO
	vger.utah-nac.org") by vger.kernel.org with ESMTP id S932318AbVKLLRY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 06:17:24 -0500
Message-ID: <4375C916.8020804@wolfmountaingroup.com>
Date: Sat, 12 Nov 2005 03:51:02 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: "Jeff V. Merkey" <jmerkey@soleranetworks.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9 reporting 1 Gigabyte/second throughput on bio's, timer
 skew possible?
References: <437521FB.6040000@soleranetworks.com> <20051112095157.GA3699@suse.de>
In-Reply-To: <20051112095157.GA3699@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>On Fri, Nov 11 2005, Jeff V. Merkey wrote:
>  
>
>>I have allocated 393,216 bio buffers I statically maintain in a chain 
>>and am running the dsfs file system with 3 x gigabit links fully 
>>saturated.  meta-data
>>increases the write sizes to 720 MB/Second on dual 9500 controllers with 
>>8 drives each (total of 16) 7200 RPM Drives.  I am seeing some 
>>congestion and bursting on the bio chains as they are submitted.  
>>


>16 disks on 2 controllers, I'm 100% sure they are lots of people
>pushing 2.6 much further than that! I wouldn't evne call that a big
>setup.
>  
>
Probably not for this type of application.

>  
>
>>DSFS dynamically generates html status files form within the file 
>>system.  When the system gets somewhat behind, I am seeing bursts > 1 
>>GB/Second which exceeds the theoretical limit of the bus.   I have a 
>>timer function that runs every second and profiles the I/O throughput 
>>created by DSFS with bio submissions and captured packets.  I am asking 
>>if there is clock skew at these data rates with use of the timer 
>>functions.  The system appears to be sustaining 1GB/Second throughput on 
>>dual controllers.  I have verified through data rates the system is 
>>sustaining 800 megabytes/second with these 1GB/S bursts.  I am curious 
>>if there is potentially timer skew at these higher rates since I am 
>>having a hard time accepting that I can push 1GB/S through a bus rated 
>>at only 850 MB/S for DMA based transfers.   The unit is accessible by 
>>    
>>
>
>Note that the linux io stats accounting in 2.6.9 accounts queued io, not
>io completions. So it's quite possible to have burst rates > bus speeds
>for async io. 2.6.15-rc1 change this.
>
>  
>
So you are willing to log into the unit and validate these numbers? I 
would like for an
someone other than me to validate I am seeing these rates.

Jeff


