Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262097AbSJJSl4>; Thu, 10 Oct 2002 14:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262099AbSJJSl4>; Thu, 10 Oct 2002 14:41:56 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:48537 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262097AbSJJSlz>;
	Thu, 10 Oct 2002 14:41:55 -0400
Message-ID: <3DA5CA56.6070402@us.ibm.com>
Date: Thu, 10 Oct 2002 11:43:34 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       LSE <lse-tech@lists.sourceforge.net>, Andrew Morton <akpm@zip.com.au>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [rfc][patch] Memory Binding API v0.3 2.5.41
References: <3DA4D3E4.6080401@us.ibm.com> <1586204621.1034197575@[10.10.2.3]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
>>+#define for_each_valid_zone(zone, zonelist) 		\
>>+	for (zone = *zonelist->zones; zone; zone++)	\
>>+		if (current->memblk_binding.bitmask & (1 << zone->zone_pgdat->memblk_id))
> 
> Does the compiler optimise the last bit away on non-NUMA?
Nope.

> Want to wrap it in #ifdef CONFIG_NUMA_MEMBIND or something?
Not a problem...  I've got some free time this afternoon...  Should only 
take me a few hours to retool the patch to include this change.  ;)

> Not sure what the speed impact of this would be, but I'd
> rather it was optional, even on NUMA boxen.
Sounds reasonable...  It'll be in the next itteration.

> Other than that, looks pretty good.
Glad to hear!

> M.

