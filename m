Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbUCIURX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 15:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262172AbUCIURX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 15:17:23 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:62850 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262139AbUCIURP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 15:17:15 -0500
Message-ID: <404E2788.1060108@tmr.com>
Date: Tue, 09 Mar 2004 15:22:32 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: questions about io scheduler
References: <1wjF1-2yG-19@gated-at.bofh.it> <1wk7X-31w-1@gated-at.bofh.it> <1wwCd-Pi-5@gated-at.bofh.it> <1wx5r-1qI-9@gated-at.bofh.it> <1wxyd-1WX-1@gated-at.bofh.it>
In-Reply-To: <1wxyd-1WX-1@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> Timothy Miller wrote:
> 
>>
>>
>> Mike Fedyk wrote:
>>
>>> Nick Piggin wrote:
>>>
>>>>
>>>>
>>>> Kyle Wong wrote:
>>>>
>>>>> 2. Does io scheduler works with md RAID? Correct me if I'm wrong,
>>>>> io-schedular <-->  md driver <--> harddisks.
>>>>>
>>>>>
>>>>
>>>> It goes md driver -> io schedulers -> hard disks.
>>>
>>>
>>>
>>>
>>> There is an IO scheduler per disk.
>>>
>>> So MD submits the data to each disk through the IO scheduler.
>>>
>>> This allows you to have the heads on each disk in the array at 
>>> different locations, and helps keep response times lower for seeky 
>>> loads.
>>
>>
>>
>> Say you've got a RAID1.  In this case, MD could send the read request 
>> to either device.  How does it decide which one to use?
> 
> 
> The one with the drive head closest to the data.

Or hopefully the one not in use if one is busy...

