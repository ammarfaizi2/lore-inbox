Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266292AbUG0HRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266292AbUG0HRW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 03:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263626AbUG0HRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 03:17:01 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:4737 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266292AbUG0HQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 03:16:16 -0400
Message-ID: <4106013E.30408@namesys.com>
Date: Tue, 27 Jul 2004 00:16:14 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Benjamin Rutt <rutt.4+news@osu.edu>, linux-kernel@vger.kernel.org
Subject: Re: clearing filesystem cache for I/O benchmarks
References: <87vfgeuyf5.fsf@osu.edu>	<20040726002524.2ade65c3.akpm@osdl.org>	<87pt6iq5u2.fsf@osu.edu> <20040726234005.597a94db.akpm@osdl.org>
In-Reply-To: <20040726234005.597a94db.akpm@osdl.org>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>(Please don't remove people from the email recipient list when doing kernel
>work.)
>
>Benjamin Rutt <rutt.4+news@osu.edu> wrote:
>  
>
>>Andrew Morton <akpm@osdl.org> writes:
>>
>>    
>>
>>>Benjamin Rutt <rutt.4+news@osu.edu> wrote:
>>>      
>>>
>>>> How can I purge all of the kernel's filesystem caches, so I can trust
>>>> that my I/O (read) requests I'm trying to benchmark bypass the kernel
>>>> filesystem cache?
>>>>        
>>>>
>>>Either delete the benchmark test files or
>>>      
>>>
>>I'm not sure I follow.  If I delete the benchmark files, I'll only
>>need to create them again later in order to do a read test, and I'll
>>have the same problem then, of how to eliminate the just-written-data
>>from cache.
>>    
>>
when benchmarking, please be careful that you don't end up benchmarking 
umount/mount, or sync, or..... it can be remarkably hard to avoid such 
mistakes.....

I tend to try to use large enough filesets that small things like cache 
flush happenstance or bitmap loading overhead do not sway the benchmark.

Rebooting tends to work for resetting the OS thoroughly, though I would 
be curious to hear comments on whether one ought to power down the disk 
drive so that its cache flushes......;-)


