Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936439AbWK3O53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936439AbWK3O53 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 09:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936438AbWK3O53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 09:57:29 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:20409 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S936439AbWK3O53
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 09:57:29 -0500
Date: Thu, 30 Nov 2006 15:04:06 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Yaroslav Halchenko <yoh@psychology.rutgers.edu>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: kswapd/tg3 issue
Message-ID: <20061130150406.3d0b6afd@localhost.localdomain>
In-Reply-To: <20061130144355.GK2021@washoe.onerussian.com>
References: <20061130144355.GK2021@washoe.onerussian.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2006 09:43:55 -0500
Yaroslav Halchenko <yoh@psychology.rutgers.edu> wrote:

> Dear Kernel People,
> 
> Just got a logwatch daily mail which revealed a problem:
> [2024412.788680] kswapd1: page allocation failure. order:2, mode:0x20
> and a lengthy backtrace with head
> 
> ,------------------------------------------------------------------------
> | [2024412.795212] Call Trace:
> | [2024412.799768]  <IRQ> [<ffffffff8020c852>] __alloc_pages+0x27a/0x291
> | [2024412.806452]  [<ffffffff802a08e3>] kmem_getpages+0x5e/0xd8
> | [2024412.812370]  [<ffffffff80212c68>] cache_grow+0xd0/0x185
> | [2024412.818064]  [<ffffffff80245c4f>] cache_alloc_refill+0x18c/0x1da
> | [2024412.824625]  [<ffffffff802a1979>] __kmalloc+0x93/0xa3
> | [2024412.830145]  [<ffffffff80222e9e>] __alloc_skb+0x54/0x117
> | [2024412.835958]  [<ffffffff803b8a55>] __netdev_alloc_skb+0x12/0x2d
> | [2024412.842347]  [<ffffffff80370292>] tg3_alloc_rx_skb+0xbb/0x146
> `---
> full dmesg is at
> http://www.onerussian.com/Linux/bugs/bug.kswapd/dmesg
> 
> is that critical? seems to behave ok but...

Its tell us that the machine got very very tight on memory, far tighter
than it probably ever should in normal situations. It is harmless of
itself and if you only get the odd one is not a worry.

