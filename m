Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965028AbWDHRRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965028AbWDHRRi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 13:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965030AbWDHRRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 13:17:38 -0400
Received: from bsamwel.xs4all.nl ([82.92.179.183]:44734 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S965028AbWDHRRi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 13:17:38 -0400
Message-ID: <4437EFD7.2070401@samwel.tk>
Date: Sat, 08 Apr 2006 19:16:08 +0200
From: Bart Samwel <bart@samwel.tk>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Coywolf Qi Hunt <coywolf@gmail.com>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] represent-dirty__centisecs-as-jiffies-internally.patch
 comment fix
References: <2cd57c900604080310l454eec24m7298e01001f132af@mail.gmail.com>
In-Reply-To: <2cd57c900604080310l454eec24m7298e01001f132af@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: bart@samwel.tk
X-SA-Exim-Scanned: No (on samwel.tk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt wrote:
> 2006/3/25, akpm@osdl.org <akpm@osdl.org>:
> 
>> From: Bart Samwel <bart@samwel.tk>
>>
>> Make that the internal values for:
>>
>> /proc/sys/vm/dirty_writeback_centisecs
>> /proc/sys/vm/dirty_expire_centisecs
>>
>> are stored as jiffies instead of centiseconds.  Let the sysctl interface do
>> the conversions with full precision using clock_t_to_jiffies, instead of
>> doing overflow-sensitive on-the-fly conversions every time the values are
>> used.
> 
>> diff -puN mm/page-writeback.c~represent-dirty__centisecs-as-jiffies-internally mm/page-writeback.c
>> --- devel/mm/page-writeback.c~represent-dirty__centisecs-as-jiffies-internally  2006-03-24 03:00:41.000000000 -0800
>> +++ devel-akpm/mm/page-writeback.c      2006-03-24 03:00:41.000000000 -0800
>> @@ -75,12 +75,12 @@ int vm_dirty_ratio = 40;
>>   * The interval between `kupdate'-style writebacks, in centiseconds
>>   * (hundredths of a second)
> 
> Bart,
> 
> You forgot to fix the comments. The attached patch fixes them.

Thanks, well spotted. I think the other patch already went into Linus' 
tree, I guess this should go in there as well?

Cheers,
Bart
