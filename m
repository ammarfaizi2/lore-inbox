Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264450AbTLBXlv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 18:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264449AbTLBXls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 18:41:48 -0500
Received: from relay-2m.club-internet.fr ([194.158.104.41]:31442 "EHLO
	relay-2m.club-internet.fr") by vger.kernel.org with ESMTP
	id S264446AbTLBXln convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 18:41:43 -0500
From: pinotj@club-internet.fr
To: torvalds@osdl.org
Cc: manfred@colorfullife.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Re: Re: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
Date: Wed,  3 Dec 2003 00:41:39 CET
Mime-Version: 1.0
X-Mailer: Medianet/v2.0
Message-Id: <mnet1.1070408499.1371.pinotj@club-internet.fr>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>De: Linus Torvalds <torvalds@osdl.org>
>On Thu, 27 Nov 2003 pinotj@club-internet.fr wrote:
>>
>> Here is the result of test of 2.6.0-test10 with the printk patch in
>> slab.c and this new patch for fork.c from Linus :
>
>The fork.c change can really only affect threaded programs using the new
>threading, and even then is likely to hit only in very unlikely
>circumstances. Certainly not a kernel compile.
>
>I'm wondering if the slab debugging code is just broken somehow. If you
>have lots of memory, it should even work for you.
>
>NOTE! For this patch to make sense, you have to enable the page allocator
>debugging thing (CONFIG_DEBUG_PAGEALLOC), and you have to live with the
>fact that it wastes a _lot_ of memory.
>
>There's another problem with this patch: if the bug is actually in the
>slab code itself, this will obviously not find it, since it disables that
>code entirely.
>
>		Linus
[patch]

Thanks. I will try this.
I have 256MB RAM and I always test with very few process running so I think it will not be a problem.

Jerome

