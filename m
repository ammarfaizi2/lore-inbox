Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270993AbTHQU4U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 16:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271021AbTHQU4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 16:56:20 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.92.226.49]:40901 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S270993AbTHQU4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 16:56:18 -0400
Message-ID: <3F3FEC73.9010206@maine.rr.com>
Date: Sun, 17 Aug 2003 16:58:27 -0400
From: "David B. Stevens" <dsteven3@maine.rr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030718
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Jamie Lokier <jamie@shareable.org>, michaelc <michaelc@turbolinux.com.cn>,
       linux-kernel@vger.kernel.org
Subject: Re: about PENTIUM4 cache line
References: <865464921.20010309170338@turbolinux.com.cn> <20030817202534.GC3543@mail.jlokier.co.uk> <3F3FE763.20503@maine.rr.com> <20030817204514.GB2225@redhat.com>
In-Reply-To: <20030817204514.GB2225@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,

Thanks that explains it.

The layout as well as the size needs to be taken into account.

Cheers,
   Dave




Dave Jones wrote:
> On Sun, Aug 17, 2003 at 04:36:51PM -0400, David B. Stevens wrote:
>  > What's even more interesting is the following:
> 
> why ?
> 
>  > tux:/usr/src/linux-2.6.0-test3 # grep -r "CONFIG_X86_L1_CACHE_SHIFT" *
>  > arch/i386/defconfig:CONFIG_X86_L1_CACHE_SHIFT=7
>  > arch/x86_64/defconfig:CONFIG_X86_L1_CACHE_SHIFT=6
> 
> correct default values for P4 and Hammer respectively.
> 
>  > include/asm-x86_64/cache.h:#define L1_CACHE_SHIFT 
>  > (CONFIG_X86_L1_CACHE_SHIFT)
> 
> Looks sane.
> 
>  > include/linux/autoconf.h:#define CONFIG_X86_L1_CACHE_SHIFT 5
> 
> compile-time generated from .config
> 
>  > include/asm-i386/cache.h:#define L1_CACHE_SHIFT (CONFIG_X86_L1_CACHE_SHIFT)
>  > include/asm/cache.h:#define L1_CACHE_SHIFT      (CONFIG_X86_L1_CACHE_SHIFT)
> 
> looks sane
> 
>  > include/config/x86/l1/cache/shift.h:#define CONFIG_X86_L1_CACHE_SHIFT 5
> 
> compile time generated from .config.
> 
> 		Dave
> 


