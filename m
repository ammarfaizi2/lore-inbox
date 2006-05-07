Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751074AbWEGFNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbWEGFNh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 01:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbWEGFNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 01:13:37 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:35855 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S1751070AbWEGFNg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 01:13:36 -0400
Message-ID: <445D81FB.5030808@argo.co.il>
Date: Sun, 07 May 2006 08:13:31 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Dave Pitts <dpitts@cozx.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: How can I boost block I/O performance
References: <445CE6ED.30703@cozx.com> <445CF9E4.3040202@argo.co.il> <445D124E.2020404@cozx.com>
In-Reply-To: <445D124E.2020404@cozx.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 May 2006 05:13:34.0970 (UTC) FILETIME=[FD8E55A0:01C67194]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Pitts wrote:
> Avi Kivity wrote:
>
>> Dave Pitts wrote:
>>>
>>> procs -----------memory---------- ---swap-- -----io---- --system-- 
>>> ----cpu----
>>> r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us 
>>> sy id wa
>>> 4  0    720  80252   1820 7077456    0    0     9   852    5    11  
>>> 1 14 84  0
>>
>> [...]
>>
>>> 5  0    720  90364   1860 7067080    0    0    40 66956 17995 95384  
>>> 0 17 82  0
>>>
>>> This test is running several NFS clients to a RAID disk storage 
>>> array. I also see the
>>> same behavior when running SFTP transfers. What I'd like is a more 
>>> even block
>>> out behavior (even at the expense of other apps as this is a file 
>>> server not an app
>>> server).  The values that I've been hacking are the 
>>> dirty_writeback_centisecs,
>>> dirty_background_ratio, etc. Am I barking up the wrong tree?
>>
>> No  iowait time, plenty of idle time: looks like you are network 
>> bound. What time of network are you running?
>>
> Well, it's an 8 cpu system. Does the idle time reflect the idle time 
> of all cpu's?

It's an average across all cpus. But the numbers are low even for a 
single cpu system.

> The network is a Gigabit Ethernet.
>

I'd make sure the nics know that by running ethtool (on the clients as 
well as on the server).



-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

