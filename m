Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263641AbUDTRXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263641AbUDTRXu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 13:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263028AbUDTRXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 13:23:50 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:59295 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263641AbUDTRXs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 13:23:48 -0400
Message-ID: <40855C97.1090006@colorfullife.com>
Date: Tue, 20 Apr 2004 19:23:35 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Andrew Morton <akpm@osdl.org>, agruen@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: slab-alignment-rework.patch in -mc
References: <1082383751.6746.33.camel@f235.suse.de> <20040419162533.GR29954@dualathlon.random> <4084017C.5080706@colorfullife.com> <20040420002423.469cca01.akpm@osdl.org> <20040420144937.GG29954@dualathlon.random>
In-Reply-To: <20040420144937.GG29954@dualathlon.random>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

>On Tue, Apr 20, 2004 at 12:24:23AM -0700, Andrew Morton wrote:
>  
>
>>So I do think that we should either make "align=0" translate to "pack them
>>densely" or do the big sweep across all kmem_cache_create() callsites.
>>    
>>
>
>agreed.
>  
>
What about this proposal:
SLAB_HWCACHE_ALIGN clear: align to max(sizeof(void*), align).
SLAB_HWCACHE_ALIGN set: align to max(cpu_align(), align).

cpu_align is the cpu cache line size - either runtime or compile time.

Or are there users that want an alignment smaller than sizeof(void*)?
--
    Manfred

