Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266343AbUBFDiz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 22:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266409AbUBFDiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 22:38:54 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:21478 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S266343AbUBFDix
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 22:38:53 -0500
Message-ID: <40230C49.4010803@cyberone.com.au>
Date: Fri, 06 Feb 2004 14:38:49 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: lord@xfs.org, ak@suse.de, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
Subject: Re: Limit hash table size
References: <B05667366EE6204181EABE9C1B1C0EB5802441@scsmsx401.sc.intel.com.suse.lists.linux.kernel>	<20040205155813.726041bd.akpm@osdl.org.suse.lists.linux.kernel>	<p73isilkm4x.fsf@verdi.suse.de>	<4021AC9F.4090408@xfs.org>	<20040205191240.13638135.akpm@osdl.org>	<402308B6.3060802@cyberone.com.au> <20040205193449.5a8b8c0b.akpm@osdl.org>
In-Reply-To: <20040205193449.5a8b8c0b.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>Nick Piggin <piggin@cyberone.com.au> wrote:
>
>>>Was it a highmem box?  If so, was the filesystem in question placing
>>>
>> >directory pagecache in highmem?  If so, that was really bad on older 2.4:
>> >the directory pagecache in highmem pins down all directory inodes.
>> >
>> >
>>
>> 2.6.2-mm1 should fix this I think.
>>
>
>2.6.anything should fix it.  It used to, anyway.
>
>
>> In particular, this hunk in vm-shrink-zone.patch
>>
>
>That's on the direct reclaim path - for sane workloads most of the freeing
>activity is via kswapd.
>
>
>

OK - he said the try to free pages path was being called but
maybe he didn't actually mean try_to_free_pages.

