Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264238AbUAELFP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 06:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264241AbUAELFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 06:05:15 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:51847 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S264238AbUAELE7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 06:04:59 -0500
Message-ID: <3FF944DA.4070405@namesys.com>
Date: Mon, 05 Jan 2004 14:04:58 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: venom@sns.it
CC: Steve Glines <sglines@is-cs.com>, linux-kernel@vger.kernel.org
Subject: Re: file system technical comparisons
References: <Pine.LNX.4.43.0401051037310.32446-100000@cibs9.sns.it>
In-Reply-To: <Pine.LNX.4.43.0401051037310.32446-100000@cibs9.sns.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can read www.namesys.com for a description of reiser4, and 
www.namesys.com/benchmarks.html for some benchmarks.

There are no well done independent benchmarks unfortunately.

Of my competitors, and not considering ReiserFS (about which I am not 
objective), I would say that if you don't have really large files and 
don't have any large directories, ext3 offers the best performance.

If you have large streaming files, look at XFS.   Don't use XFS for 
files smaller than 100k, as the last time I tested against it its 
metadata updates tended to be slow, and that starts to matter at <100k 
file sizes.

JFS has never done very well in the benchmarks I run, which is why I 
tend to compare us mostly to ext3.

If you are willing to consider ReiserFS, V3 is the journaling filesystem 
that has been out for the longest, and receives the least updates (we 
are all working on V4), so it is the most stable.  I'll let others 
comment on its performance.

V4 is far higher performance than V3, but not quite fully stable yet.  
Some brave people are using it though.  Hopefully we will ship something 
stable this month.

Hans

venom@sns.it wrote:

>http://www.linux-mag.com/2002-10/jfs_01.html
>
>On some point it could be discussed, but it is a good starting point.
>
>if you know italian, I will send you another article published in three part
>on Linux&C (http://www.oltrelinux.com) about journaled filesystems available in
>Linux kernel.
>
>bests
>
>Luigi
>
>On Fri, 2 Jan 2004, Steve Glines wrote:
>
>  
>
>>Date: Fri, 02 Jan 2004 16:38:22 -0500
>>From: Steve Glines <sglines@is-cs.com>
>>To: linux-kernel@vger.kernel.org
>>Subject: file system technical comparisons
>>
>>I'm looking for a technical comparison between the major file systems.
>>At a minimum I'd like to see a comparison between ext3, reiserfs, xfs
>>and jfs. In the oh so perfect world I'd like to see detailed info on all
>>supported file systems.
>>
>>Please CC or mail me directly as I am not a subscriber to this list.
>>
>>Thanks
>>--
>>Steve Glines
>>
>>In theory, there's no difference between theory and practice, but in
>>practice there is.
>>
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>
>>    
>>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>


-- 
Hans


