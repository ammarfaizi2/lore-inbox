Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268272AbUHXU1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268272AbUHXU1W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 16:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268274AbUHXU1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 16:27:22 -0400
Received: from dauntless.milewski.org ([64.142.38.232]:56241 "EHLO
	dauntless.milewski.org") by vger.kernel.org with ESMTP
	id S268272AbUHXU1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 16:27:09 -0400
Message-ID: <412BA4FC.2070505@asperasoft.com>
Date: Tue, 24 Aug 2004 13:28:44 -0700
From: Serban Simu <serban@asperasoft.com>
Organization: Aspera
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: page allocation failure & sk98lin
References: <412AE018.8000207@asperasoft.com> <412AF360.60005@yahoo.com.au>
In-Reply-To: <412AF360.60005@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you, Nick. Just wanted to mention that while I understand that we 
recover from this allocation failure (and also I don't mind the stack 
printouts), about 20% of my incoming network traffic (600-700 Mbps) 
seems to be dropped in the process. Does the memory manager have to 
spend a considerable amount of time to recover?

I will have a look at the -mm fixes, thanks for the idea.

-Serban

Nick Piggin wrote:

> Serban Simu wrote:
> 
>> Hello all,
>>
>> I found a few references to similar problems in the list but no 
>> indications of whether this has been fixed or can be avoided.
>>
>> I'm using 2.6.8.1 and the patch: sk98lin_v7.04_2.6.8_patch. This 
>> happens  when receiving data fast on the GigE card (about 600Mbps) and 
>> writing on disk. It seems to happen after writing 1 GB to disk (1024 
>> MB) but I can't correlate that very reliably.
>>
>> I would appreciate any information pointing me to a fix or explanation.
>>
>> Thank you!
>>
>> -Serban
>>
>> swapper: page allocation failure. order:0, mode:0x20
> 
> 
> 
> The messages should be basically harmless and can't be completely avoided.
> 
> That said, -mm kernels have patches to fix up numerous problems with the 
> page
> allocator which have a good chance of fixing your problems.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

