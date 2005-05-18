Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262318AbVERQrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262318AbVERQrZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 12:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262312AbVERQrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 12:47:06 -0400
Received: from fmr18.intel.com ([134.134.136.17]:45036 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S262318AbVERQqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 12:46:15 -0400
Date: Wed, 18 May 2005 09:51:01 -0700
From: Matt Tolentino <metolent@snoqualmie.dp.intel.com>
Message-Id: <200505181651.j4IGp1VB026987@snoqualmie.dp.intel.com>
To: ak@muc.de, metolent@snoqualmie.dp.intel.com
Subject: Re: [patch 4/4] add x86-64 specific support for sparsemem
Cc: akpm@osdl.org, apw@shadowen.org, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From ak@muc.de  Wed May 18 09:33:00 2005
>
>> @@ -400,9 +401,12 @@ static __init void parse_cmdline_early (
>>  }
>>  
>>  #ifndef CONFIG_NUMA
>> -static void __init contig_initmem_init(void)
>> +static void __init
>> +contig_initmem_init(unsigned long start_pfn, unsigned long end_pfn)
>>  {
>>          unsigned long bootmap_size, bootmap; 
>> +
>> +	memory_present(0, start_pfn, end_pfn);
>
>Watch indentation.

Weird.  I just looked again and this is tabbed properly, although
the rest of the lines in this function are indented with individual
spaces.  

>Rest looks good.

Thanks!

matt
