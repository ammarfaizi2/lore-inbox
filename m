Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750946AbWHQL7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbWHQL7z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 07:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWHQL7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 07:59:55 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:17056 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751035AbWHQL7y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 07:59:54 -0400
Message-ID: <44E45AC6.3040903@sw.ru>
Date: Thu, 17 Aug 2006 16:02:14 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
Subject: Re: [RFC][PATCH 4/7] UBC: syscalls (user interface)
References: <44E33893.6020700@sw.ru> <44E33C3F.3010509@sw.ru> <20060816171747.GC27898@kroah.com>
In-Reply-To: <20060816171747.GC27898@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Wed, Aug 16, 2006 at 07:39:43PM +0400, Kirill Korotaev wrote:
> 
>>--- ./include/asm-sparc/unistd.h.arsys	2006-07-10 12:39:19.000000000 +0400
>>+++ ./include/asm-sparc/unistd.h	2006-08-10 17:08:19.000000000 +0400
>>@@ -318,6 +318,9 @@
>>#define __NR_unshare		299
>>#define __NR_set_robust_list	300
>>#define __NR_get_robust_list	301
>>+#define __NR_getluid		302
>>+#define __NR_setluid		303
>>+#define __NR_setublimit		304
> 
> 
> Hm, you seem to be ignoring this:
> 
> 
>>#ifdef __KERNEL__
>>/* WARNING: You MAY NOT add syscall numbers larger than 301, since
> 
> 
> Same thing for sparc64:
[...skipped...]

Oh, will fix NR_SYSCALLS in entry.S and the comment in unistd.h. Thanks for catching this!

Thanks,
Kirill

