Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270848AbTHQUeq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 16:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270855AbTHQUeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 16:34:46 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.92.226.49]:22947 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S270848AbTHQUep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 16:34:45 -0400
Message-ID: <3F3FE763.20503@maine.rr.com>
Date: Sun, 17 Aug 2003 16:36:51 -0400
From: "David B. Stevens" <dsteven3@maine.rr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030718
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: michaelc <michaelc@turbolinux.com.cn>, linux-kernel@vger.kernel.org
Subject: Re: about PENTIUM4 cache line
References: <865464921.20010309170338@turbolinux.com.cn> <20030817202534.GC3543@mail.jlokier.co.uk>
In-Reply-To: <20030817202534.GC3543@mail.jlokier.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What's even more interesting is the following:

tux:/usr/src/linux-2.6.0-test3 # grep -r "CONFIG_X86_L1_CACHE_SHIFT" *
arch/i386/defconfig:CONFIG_X86_L1_CACHE_SHIFT=7
arch/x86_64/defconfig:CONFIG_X86_L1_CACHE_SHIFT=6
include/asm-x86_64/cache.h:#define L1_CACHE_SHIFT 
(CONFIG_X86_L1_CACHE_SHIFT)
include/linux/autoconf.h:#define CONFIG_X86_L1_CACHE_SHIFT 5
include/asm-i386/cache.h:#define L1_CACHE_SHIFT (CONFIG_X86_L1_CACHE_SHIFT)
include/asm/cache.h:#define L1_CACHE_SHIFT      (CONFIG_X86_L1_CACHE_SHIFT)
include/config/x86/l1/cache/shift.h:#define CONFIG_X86_L1_CACHE_SHIFT 5
tux:/usr/src/linux-2.6.0-test3 #

Life sure is interesting.

Cheers,
   Dave


Jamie Lokier wrote:
> michaelc wrote:
> 
>>     I read the Intel IA-32 developer's manual recently, and I found
>> the cache lines for L1 and L2 caches in Pentium4 are 64 bytes
>> wide, but the thing make me confused is that the default value
>> CONFIG_X86_L1_CACHE_SHIFT option in 2.4.x kernel is 7, why it's
>> not 6?   Any expanation about this would be appreciated!
> 
> 
> I don't recall seeing an answer to this.
> Was there one?
> 
> Cheers,
> -- Jamie
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


