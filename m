Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbUCEX6d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 18:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbUCEX6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 18:58:33 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:26506 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S261477AbUCEX6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 18:58:31 -0500
Message-ID: <40491414.2060404@matchmail.com>
Date: Fri, 05 Mar 2004 15:58:12 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
CC: Nick Piggin <piggin@cyberone.com.au>, Kyle Wong <kylewong@southa.com>,
       linux-kernel@vger.kernel.org
Subject: Re: questions about io scheduler
References: <088201c40293$5b27ce80$9c02a8c0@southa.com> <40484643.7070104@cyberone.com.au> <404905E1.70709@matchmail.com> <4049121D.1060405@techsource.com>
In-Reply-To: <4049121D.1060405@techsource.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller wrote:
> 
> 
> Mike Fedyk wrote:
> 
>> Nick Piggin wrote:
>>
>>>
>>>
>>> Kyle Wong wrote:
>>>
>>>> 2. Does io scheduler works with md RAID? Correct me if I'm wrong,
>>>> io-schedular <-->  md driver <--> harddisks.
>>>>
>>>>
>>>
>>> It goes md driver -> io schedulers -> hard disks.
>>
>>
>>
>> There is an IO scheduler per disk.
>>
>> So MD submits the data to each disk through the IO scheduler.
>>
>> This allows you to have the heads on each disk in the array at 
>> different locations, and helps keep response times lower for seeky loads.
> 
> 
> Say you've got a RAID1.  In this case, MD could send the read request to 
> either device.  How does it decide which one to use?

The one with the drive head closest to the data.
