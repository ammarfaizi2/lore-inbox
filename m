Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbVKSMZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbVKSMZl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 07:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbVKSMZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 07:25:41 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:57220 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S1751096AbVKSMZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 07:25:41 -0500
Message-ID: <437F199C.9040505@colorfullife.com>
Date: Sat, 19 Nov 2005 13:25:00 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, colpatch@us.ibm.com
Subject: Re: [PATCH 4/5] slab: extract slab order calculation to separate
 function
References: <iq5uuh.o9kcui.7v9w5djupiovhrqo6are97fi6.beaver@cs.helsinki.fi>
In-Reply-To: <iq5uuh.o9kcui.7v9w5djupiovhrqo6are97fi6.beaver@cs.helsinki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:

>This patch moves the ugly loop that determines the 'optimal' size (page
>order) of cache slabs from kmem_cache_create() to a separate function
>and cleans it up a bit.
>
>Thanks to Matthew Wilcox for the help with this patch.
>
>Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>
>Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
>  
>
Looks good, just two minor points:

>+static inline size_t calculate_slab_order(kmem_cache_t *cachep, size_t size,
>+					  size_t align, gfp_t flags)
>  
>
Unnecessary inline, see my previous mail for the explanation.

>+	} else
>+		left_over = calculate_slab_order(cachep, size, align, flags);
>  
>

I usually add braces in this case: If braces are necessary for either 
the if or the else-clause, then I add braces to both parts.

Could be applied as is, or I could write a patch with both changes.
Andrew - what do you prefer?

--
    Manfred
