Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262966AbUCRVPv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 16:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262951AbUCRVPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 16:15:51 -0500
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:58630 "EHLO
	rtr.ca") by vger.kernel.org with ESMTP id S262968AbUCRVM2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 16:12:28 -0500
Message-ID: <405A1098.8080409@pobox.com>
Date: Thu, 18 Mar 2004 16:11:52 -0500
From: Mark Lord <mlord@pobox.com>
Organization: Real-Time Remedies Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Sergey Vlasov <vsu@altlinux.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: vmalloc fix buggy again?
References: <20040318180744.GE16242@master.mivlgu.local>
In-Reply-To: <20040318180744.GE16242@master.mivlgu.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yup.

Thanks, Sergey.  I'm suffering severe brain-impairment on this one.
Please pass this on to Marcelo.

Cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com

Sergey Vlasov wrote:
> Hello!
> 
> 
>># ChangeSet
>>#   2004/03/14 13:16:58-03:00 mlord...
>>#   [PATCH] Yet another vmalloc() fixup
>># 
>>diff -Nru a/mm/vmalloc.c b/mm/vmalloc.c
>>--- a/mm/vmalloc.c	Thu Mar 18 09:44:53 2004
>>+++ b/mm/vmalloc.c	Thu Mar 18 09:44:53 2004
>>@@ -184,7 +184,7 @@
>> 	spin_unlock(&init_mm.page_table_lock);
>> 	flush_cache_all();
>> 	if (address > start)
>>-		vmfree_area_pages((address - start), address - start);
>>+		vmfree_area_pages(address, address - start);
>> 	return -ENOMEM;
>> }
>> 
> 
> 
> Looks like this should be
> 
> 		vmfree_area_pages(start, address - start);
> 


