Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314088AbSEAW4v>; Wed, 1 May 2002 18:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314087AbSEAW4u>; Wed, 1 May 2002 18:56:50 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:59526 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S314083AbSEAW4s>; Wed, 1 May 2002 18:56:48 -0400
Message-ID: <3CD07209.5060301@didntduck.org>
Date: Wed, 01 May 2002 18:54:01 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] percpu updates
In-Reply-To: <3CD06ACE.1090402@didntduck.org> <3CD06FD1.2E75F5F2@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Brian Gerst wrote:
> 
>>These patches convert some of the existing arrays based on NR_CPUS to
>>use the new per cpu code.
>>
>>...
>>-extern struct page_state {
>>+struct page_state {
>>        unsigned long nr_dirty;
>>        unsigned long nr_locked;
>>        unsigned long nr_pagecache;
>>-} ____cacheline_aligned_in_smp page_states[NR_CPUS];
>>+};
>>+
>>+extern struct page_state __per_cpu_data page_states;
> 
> 
> When I did this a couple of weeks back it failed in
> mysterious ways and I ended up parking it.  Failure
> symptoms included negative numbers being reported in
> /proc/meminfo for "Locked" and "Dirty".
> 
> How well has this been tested?  (If the answer
> is "not very" then please wait until I've tested
> it out...)
> 
> -
> 

Well, the answer is not very.  I don't have an SMP machine to do 
thorough testing on.  The best I can do is boot an SMP kernel on a UP 
machine.  I did check the disassembly of vmlinux, and it looked like it 
would work as advertised.

-- 

						Brian Gerst

