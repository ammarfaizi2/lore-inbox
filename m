Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbWEFTdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWEFTdH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 15:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932068AbWEFTdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 15:33:06 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:6928 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S932067AbWEFTdF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 15:33:05 -0400
Message-ID: <445CF9E4.3040202@argo.co.il>
Date: Sat, 06 May 2006 22:32:52 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Dave Pitts <dpitts@cozx.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: How can I boost block I/O performance
References: <445CE6ED.30703@cozx.com>
In-Reply-To: <445CE6ED.30703@cozx.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 May 2006 19:32:57.0703 (UTC) FILETIME=[E0ED3F70:01C67143]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Pitts wrote:
> Hello all:
>
> I've been trying some hacks to boost disk I/O performance mostly by 
> changing values
> in the /proc/sys/vm filesystem.  A vmstat display shows bursty block 
> out counts with
> fairly consistent interrupt counts:
>
> procs -----------memory---------- ---swap-- -----io---- --system-- 
> ----cpu----
> r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us 
> sy id wa
> 4  0    720  80252   1820 7077456    0    0     9   852    5    11  1 
> 14 84  0
[...]
> 5  0    720  90364   1860 7067080    0    0    40 66956 17995 95384  0 
> 17 82  0
>
> This test is running several NFS clients to a RAID disk storage array. 
> I also see the
> same behavior when running SFTP transfers. What I'd like is a more 
> even block
> out behavior (even at the expense of other apps as this is a file 
> server not an app
> server).  The values that I've been hacking are the 
> dirty_writeback_centisecs,
> dirty_background_ratio, etc. Am I barking up the wrong tree?
No  iowait time, plenty of idle time: looks like you are network bound. 
What time of network are you running?

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

