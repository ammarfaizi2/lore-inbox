Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbUCEXhX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 18:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbUCEXhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 18:37:23 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:63249 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S261472AbUCEXhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 18:37:21 -0500
Message-ID: <4049121D.1060405@techsource.com>
Date: Fri, 05 Mar 2004 18:49:49 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Nick Piggin <piggin@cyberone.com.au>, Kyle Wong <kylewong@southa.com>,
       linux-kernel@vger.kernel.org
Subject: Re: questions about io scheduler
References: <088201c40293$5b27ce80$9c02a8c0@southa.com> <40484643.7070104@cyberone.com.au> <404905E1.70709@matchmail.com>
In-Reply-To: <404905E1.70709@matchmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mike Fedyk wrote:
> Nick Piggin wrote:
> 
>>
>>
>> Kyle Wong wrote:
>>
>>> 2. Does io scheduler works with md RAID? Correct me if I'm wrong,
>>> io-schedular <-->  md driver <--> harddisks.
>>>
>>>
>>
>> It goes md driver -> io schedulers -> hard disks.
> 
> 
> There is an IO scheduler per disk.
> 
> So MD submits the data to each disk through the IO scheduler.
> 
> This allows you to have the heads on each disk in the array at different 
> locations, and helps keep response times lower for seeky loads.

Say you've got a RAID1.  In this case, MD could send the read request to 
either device.  How does it decide which one to use?


