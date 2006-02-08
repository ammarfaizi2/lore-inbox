Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161054AbWBHHTA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161054AbWBHHTA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 02:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161039AbWBHHTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 02:19:00 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:5265 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1161054AbWBHHS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 02:18:59 -0500
Message-ID: <43E99BB6.7040406@jp.fujitsu.com>
Date: Wed, 08 Feb 2006 16:20:22 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Kyle McMartin <kyle@mcmartin.ca>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] unify pfn_to_page take 2 [1/25] generic funcs
References: <43E98482.2090305@jp.fujitsu.com> <20060208070031.GA21184@quicksilver.road.mcmartin.ca>
In-Reply-To: <20060208070031.GA21184@quicksilver.road.mcmartin.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle McMartin wrote:
> On Wed, Feb 08, 2006 at 02:41:22PM +0900, KAMEZAWA Hiroyuki wrote:
>> +#ifndef CONFIG_ARCH_HAS_PFN_TO_PAGE
>> +/*
> 
> Since this file is entirely conditionalized on ARCH_HAS_PFN_TO_PAGE,
> might it be better to put this in asm-generic/ and include it from
> an asm- header instead of adding yet another ARCH_HAS_ define?
> 
> This way, m68k (iirc?) could just not include that header, and not
> worry about this define.
> 
> Then again, adding the include to every arches headers likely offsets
> some of the C code reduction. However, it's still a win on the unified
> definition and long term maintainability angle. Perhaps someone more
> authoritative than little old me, could cast judgement on this.
> 
I named the file as memory_model.h, so I placed it under linux/
But ,as you say, memory_model.h is entirely conditional on ARCH_HASH_PFN_TO_PAGE.
Can someone advise me ?

>> [...]
>> +#ifdef CONFIG_DONT_INLINE_PFN_TO_PAGE
>> +
>> +/* not-inlined version for some archs. funcs are defined in 
>> mm/page_alloc.c */
>> +extern unsigned long page_to_pfn(struct page *page);
>> +extern struct page *pfn_to_page(unsigned long pfn);
>> +
>> +#else
>> +
> 
> Commenting this #else might improve readability.
> 
Ah, okay. thanks.

Regards,
-- Kame

