Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbWHPQQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWHPQQS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 12:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWHPQQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 12:16:18 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:26254 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S1751110AbWHPQQQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 12:16:16 -0400
Message-ID: <44E344A8.1040804@colorfullife.com>
Date: Wed, 16 Aug 2006 18:15:36 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.13) Gecko/20060501 Fedora/1.7.13-1.1.fc5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: mpm@selenic.com, Marcelo Tosatti <marcelo@kvack.org>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andi Kleen <ak@suse.de>, Dave Chinner <dgc@sgi.com>
Subject: Re: [MODSLAB 0/7] A modular slab allocator V1
References: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:

>5. Three different slab allocators.
>[snip]
>	   It is called the Slabifier because it can slabify any
>	   page allocator. VMALLOC is a valid page allocator so
>	   it can do slabs on vmalloc ranges. You can define your
>	   own page allocator (mempools??) and then slabify that
>	   one.
>  
>
Which .config settings are necessary? I tried to use it (uniprocessor, 
no debug options enabled), but the compilation failed. 2.6.18-rc4 
kernel. All 7 patches applied.
And: Are you sure that the slabifier works on vmalloc ranges? The code 
uses virt_to_page(). Does that function work for vmalloc on all archs?

The lack of virt_to_page() on vmalloc/mempool memory. always prevented 
the slab allocator from handling such memory.

--
    Manfred
