Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261372AbUL2Qd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbUL2Qd5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 11:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbUL2Qd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 11:33:57 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:14981 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261372AbUL2Qdx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 11:33:53 -0500
Message-ID: <41D2DC68.5080805@colorfullife.com>
Date: Wed, 29 Dec 2004 17:33:44 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Reimplementation of linux dynamic percpu memory allocator
References: <41C35DD6.1050804@colorfullife.com> <20041220182057.GA16859@in.ibm.com> <41C718C7.1020908@colorfullife.com> <20041220192558.GA17194@in.ibm.com>
In-Reply-To: <20041220192558.GA17194@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai wrote:

>On Mon, Dec 20, 2004 at 07:24:07PM +0100, Manfred Spraul wrote:
>  
>
>>No, not fast path. But it can happen a few thousand times. The slab 
>>implementation failed due to heavy internal fragmentation. If your code 
>>runs fine with a few thousand users, then there shouldn't be a problem.
>>    
>>
>
>  
>
Could you ask Badari Pulavarty (pbadari@us.ibm.com)?
He noticed the fragmentation problem with the original 
kmem_cache_alloc_node implementation. Perhaps he could just run your 
version with his test setup:
The thread with the fix is at:

http://marc.theaimsgroup.com/?t=109735434400002&r=1&w=2

--
    Manfred
