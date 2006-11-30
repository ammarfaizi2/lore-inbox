Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967405AbWK3On5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967405AbWK3On5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 09:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936434AbWK3On5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 09:43:57 -0500
Received: from washoe.rutgers.edu ([165.230.95.67]:62095 "EHLO
	washoe.rutgers.edu") by vger.kernel.org with ESMTP id S936432AbWK3On4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 09:43:56 -0500
Date: Thu, 30 Nov 2006 09:43:55 -0500
From: Yaroslav Halchenko <yoh@psychology.rutgers.edu>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: kswapd/tg3 issue
Message-ID: <20061130144355.GK2021@washoe.onerussian.com>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-URL: http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: 3BB6 E124 0643 A615 6F00  6854 8D11 4563 75C0 24C8
User-Agent: mutt-ng/devel-r804 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Kernel People,

Just got a logwatch daily mail which revealed a problem:
[2024412.788680] kswapd1: page allocation failure. order:2, mode:0x20
and a lengthy backtrace with head

,------------------------------------------------------------------------
| [2024412.795212] Call Trace:
| [2024412.799768]  <IRQ> [<ffffffff8020c852>] __alloc_pages+0x27a/0x291
| [2024412.806452]  [<ffffffff802a08e3>] kmem_getpages+0x5e/0xd8
| [2024412.812370]  [<ffffffff80212c68>] cache_grow+0xd0/0x185
| [2024412.818064]  [<ffffffff80245c4f>] cache_alloc_refill+0x18c/0x1da
| [2024412.824625]  [<ffffffff802a1979>] __kmalloc+0x93/0xa3
| [2024412.830145]  [<ffffffff80222e9e>] __alloc_skb+0x54/0x117
| [2024412.835958]  [<ffffffff803b8a55>] __netdev_alloc_skb+0x12/0x2d
| [2024412.842347]  [<ffffffff80370292>] tg3_alloc_rx_skb+0xbb/0x146
`---
full dmesg is at
http://www.onerussian.com/Linux/bugs/bug.kswapd/dmesg

is that critical? seems to behave ok but...

More details on the system and error in particular can be
http://www.onerussian.com/Linux/bugs/bug.kswapd/

-- 
Yaroslav Halchenko
Research Assistant, Psychology Department, Rutgers-Newark
Student  Ph.D. @ CS Dept. NJIT
Office: (973) 353-5440x263 | FWD: 82823 | Fax: (973) 353-1171
        101 Warren Str, Smith Hall, Rm 4-105, Newark NJ 07102
WWW:     http://www.linkedin.com/in/yarik        
