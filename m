Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030396AbWHXRNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030396AbWHXRNF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 13:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030398AbWHXRNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 13:13:05 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:33239 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030396AbWHXRND
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 13:13:03 -0400
Message-ID: <44EDDE1A.1000408@us.ibm.com>
Date: Thu, 24 Aug 2006 10:12:58 -0700
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: Dave Kleikamp <shaggy@austin.ibm.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, akpm@osdl.org,
       ext2-devel <Ext2-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Ext2-devel] [RFC][PATCH] Manage jbd allocations from its own
 slabs
References: <1156374495.30517.5.camel@dyn9047017100.beaverton.ibm.com> <1156422573.7908.1.camel@kleikamp.austin.ibm.com>
In-Reply-To: <1156422573.7908.1.camel@kleikamp.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Kleikamp wrote:
> On Wed, 2006-08-23 at 16:08 -0700, Badari Pulavarty wrote:
>   
>> Hi,
>>
>> Here is the fix to "bh: Ensure bh fits within a page" problem
>> caused by JBD.
>>
>> BTW, I realized that this problem can happen only with 1k, 2k
>> filesystems - as 4k, 8k allocations disable slab debug 
>> automatically. But for completeness, I created slabs for those
>> also.
>>     
>
> With a larger base page size, you could run into the same problems for
> 4K and 8K allocations, so it's a good thing to do them all.
>
>   
Yes, with bigger base page size - this can happen for 4k, 8k also.

And also, I am re-doing the patch to address Andrew's comments - I will 
send out latest
in few hours (currently testing).

Thanks,
Badari


