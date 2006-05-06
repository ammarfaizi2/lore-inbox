Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWEFVOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWEFVOE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 17:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbWEFVOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 17:14:04 -0400
Received: from mail.crosswalkinc.com ([72.16.196.98]:60942 "EHLO
	coach.cozx.com") by vger.kernel.org with ESMTP id S932076AbWEFVOD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 17:14:03 -0400
Message-ID: <445D124E.2020404@cozx.com>
Date: Sat, 06 May 2006 15:17:02 -0600
From: Dave Pitts <dpitts@cozx.com>
Organization: Colorado Zephyrs
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Avi Kivity <avi@argo.co.il>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How can I boost block I/O performance
References: <445CE6ED.30703@cozx.com> <445CF9E4.3040202@argo.co.il>
In-Reply-To: <445CF9E4.3040202@argo.co.il>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity wrote:

> Dave Pitts wrote:
>
>> Hello all:
>>
>> I've been trying some hacks to boost disk I/O performance mostly by 
>> changing values
>> in the /proc/sys/vm filesystem.  A vmstat display shows bursty block 
>> out counts with
>> fairly consistent interrupt counts:
>>
>> procs -----------memory---------- ---swap-- -----io---- --system-- 
>> ----cpu----
>> r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us 
>> sy id wa
>> 4  0    720  80252   1820 7077456    0    0     9   852    5    11  1 
>> 14 84  0
>
> [...]
>
>> 5  0    720  90364   1860 7067080    0    0    40 66956 17995 95384  
>> 0 17 82  0
>>
>> This test is running several NFS clients to a RAID disk storage 
>> array. I also see the
>> same behavior when running SFTP transfers. What I'd like is a more 
>> even block
>> out behavior (even at the expense of other apps as this is a file 
>> server not an app
>> server).  The values that I've been hacking are the 
>> dirty_writeback_centisecs,
>> dirty_background_ratio, etc. Am I barking up the wrong tree?
>
> No  iowait time, plenty of idle time: looks like you are network 
> bound. What time of network are you running?
>
Well, it's an 8 cpu system. Does the idle time reflect the idle time of 
all cpu's?
The network is a Gigabit Ethernet.


-- 
Dave Pitts                   PULLMAN: Travel and sleep in safety and comfort.
dpitts@cozx.com              My other RV IS a Pullman (Colorado Pine).
http://www.cozx.com/~dpitts

