Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129845AbRCATzn>; Thu, 1 Mar 2001 14:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129848AbRCATzd>; Thu, 1 Mar 2001 14:55:33 -0500
Received: from colorfullife.com ([216.156.138.34]:55044 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129845AbRCATzS>;
	Thu, 1 Mar 2001 14:55:18 -0500
Message-ID: <3A9EA940.CB82665C@colorfullife.com>
Date: Thu, 01 Mar 2001 20:55:44 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-14 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Hemment <markhe@veritas.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Q: explicit alignment control for the slab allocator
In-Reply-To: <Pine.LNX.4.21.0103011800460.11260-100000@alloc>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hemment wrote:
> 
>   The original idea behind offset was for objects with a "hot" area
> greater than a single L1 cache line.  By using offset correctly (and to my
> knowledge it has never been used anywhere in the Linux kernel), a SLAB
> cache creator (caller of kmem_cache_create()) could ask the SLAB for more
> than one colour (space/L1 cache lines) offset between objects.
>

What's the difference between this definition of 'offset' and alignment?

alignment means that (addr%alignment==0)
offset means that (addr1-addr2 == n*offset)

Isn't the only difference the alignment of the first object in a slab?

>   As no one uses the feature it could well be broken, but is that a reason
> to change its meaning?
>

Some hardware drivers use HW_CACHEALIGN and assume certain byte
alignments, and arm needs 1024 byte aligned blocks.

--
	Manfred
