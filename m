Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751365AbWDKQ7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbWDKQ7v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 12:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbWDKQ7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 12:59:51 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:35719 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751365AbWDKQ7u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 12:59:50 -0400
Date: Tue, 11 Apr 2006 17:59:38 +0100 (IST)
From: Mel Gorman <mel@skynet.ie>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: davej@codemonkey.org.uk, linuxppc-dev@ozlabs.org, tony.luck@intel.com,
       ak@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/6] Break out memory initialisation code from page_alloc.c
 to mem_init.c
In-Reply-To: <443B8DE7.4000900@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0604111752140.19280@skynet.skynet.ie>
References: <20060411103946.18153.83059.sendpatchset@skynet>
 <20060411104147.18153.64342.sendpatchset@skynet> <443B8DE7.4000900@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2006, Nick Piggin wrote:

> Mel Gorman wrote:
>> page_alloc.c contains a large amount of memory initialisation code. This 
>> patch
>> breaks out the initialisation code to a separate file to make page_alloc.c
>> a bit easier to read.
>> 
>
> Seems like a very good idea to me.
>

If there is interest in treating this separetly, it can be broken out as a 
standalone patch. In this form, it depends on the first patch from the 
set.

>> +/*
>> + * mm/mem_init.c
>> + * Initialises the architecture independant view of memory. pgdats, zones, 
>> etc
>> + *
>> + *  Copyright (C) 1991, 1992, 1993, 1994  Linus Torvalds
>> + *  Swap reorganised 29.12.95, Stephen Tweedie
>> + *  Support of BIGMEM added by Gerhard Wichert, Siemens AG, July 1999
>> + *  Reshaped it to be a zoned allocator, Ingo Molnar, Red Hat, 1999
>> + *  Discontiguous memory support, Kanoj Sarcar, SGI, Nov 1999
>> + *  Zone balancing, Kanoj Sarcar, SGI, Jan 2000
>> + *  Per cpu hot/cold page lists, bulk allocation, Martin J. Bligh, Sept 
>> 2002
>> + *	(lots of bits borrowed from Ingo Molnar & Andrew Morton)
>> + *  Arch-independant zone size and hole calculation, Mel Gorman, IBM, Apr 
>> 2006
>> + *	(lots of bits taken from architecture code)
>> + */
>
> Maybe drop the duplicated changelog? (just retain copyrights I guess)
>

Makes sense.

+ *  Copyright (C) 1991, 1992, 1993, 1994  Linus Torvalds
+ *  Copyright (C) 1995, Stephen Tweedie
+ *  Copyright (C) July 1999, Gerhard Wichert, Siemens AG
+ *  Copyright (C) 1999, Ingo Molnar, Red Hat
+ *  Copyright (C) 1999, 2000, Kanoj Sarcar, SGI
+ *  Copyright (C) Sept 2000, Martin J. Bligh
+ *     (lots of bits borrowed from Ingo Molnar & Andrew Morton)
+ *  Copyright (C) Apr 2006, Mel Gorman, IBM
+ *     (lots of bits taken from architecture-specific code)


-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
