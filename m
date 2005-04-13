Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262873AbVDMBGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262873AbVDMBGQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 21:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262866AbVDMBFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 21:05:41 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:4462 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262852AbVDMBDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 21:03:52 -0400
Message-ID: <425C6FF0.6010808@yahoo.com.au>
Date: Wed, 13 Apr 2005 11:03:44 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: axboe@suse.de, linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
Subject: Re: [patch 2/9] mempool gfp flag
References: <425BC262.1070500@yahoo.com.au>	<425BC3B0.7020707@yahoo.com.au> <20050412125025.6890b2d7.akpm@osdl.org>
In-Reply-To: <20050412125025.6890b2d7.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>> Index: linux-2.6/include/linux/gfp.h
>> ===================================================================
>> --- linux-2.6.orig/include/linux/gfp.h	2005-04-12 22:26:10.000000000 +1000
>> +++ linux-2.6/include/linux/gfp.h	2005-04-12 22:26:11.000000000 +1000
>> @@ -38,14 +38,16 @@ struct vm_area_struct;
>>  #define __GFP_NO_GROW	0x2000u	/* Slab internal usage */
>>  #define __GFP_COMP	0x4000u	/* Add compound page metadata */
>>  #define __GFP_ZERO	0x8000u	/* Return zeroed page on success */
>> +#define __GFP_MEMPOOL	0x10000u/* Mempool allocation */
> 
> 
> I think I'll rename this to "__GFP_NOMEMALLOC".  Things other then mempool
> might want to use this.
> 

Sure, I wasn't set on GFP_MEMPOOL.


-- 
SUSE Labs, Novell Inc.

