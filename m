Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265053AbTLCQQI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 11:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265055AbTLCQQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 11:16:08 -0500
Received: from smtp.irisa.fr ([131.254.130.26]:50313 "EHLO smtp.irisa.fr")
	by vger.kernel.org with ESMTP id S265053AbTLCQP5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 11:15:57 -0500
Message-ID: <3FCE1A54.7020405@free.fr>
Date: Wed, 03 Dec 2003 17:16:04 +0000
From: shal <shal@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031029
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kswapd0: page allocation failure.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I run a 2.6.0-test10-mm1 kernel.

For information : today I have this mistake in my message:

kswapd0: page allocation failure. order:0, mode:0x20
Call Trace:
  [<c014c522>] __alloc_pages+0x302/0x390
  [<c014c5d2>] __get_free_pages+0x22/0x50
  [<c015167c>] cache_grow+0x13c/0x4a0
  [<c0260c89>] as_merged_request+0x49/0x1d0
  [<c0151d9f>] cache_alloc_refill+0x3bf/0x570
  [<c0256c1e>] elv_merged_request+0x1e/0x20
  [<c0152744>] kmem_cache_alloc+0x224/0x250
  [<c0201ca0>] radix_tree_node_alloc+0x20/0x60
  [<c0201e5d>] radix_tree_insert+0x8d/0xd0
  [<c0146b53>] add_to_page_cache+0x93/0x1c0
  [<c01694c4>] add_to_swap+0x64/0xe0
  [<c015730c>] shrink_list+0x81c/0x8d0
  [<c036fe50>] common_interrupt+0x18/0x20
  [<c0155949>] __pagevec_release+0x29/0x40
  [<c01575ae>] shrink_cache+0x1ee/0x5e0
  [<c01587fa>] balance_pgdat+0x17a/0x200
  [<c0158959>] kswapd+0xd9/0xf0
  [<c0122c20>] autoremove_wake_function+0x0/0x50
  [<c0122c20>] autoremove_wake_function+0x0/0x50
  [<c0158880>] kswapd+0x0/0xf0
  [<c01092a9>] kernel_thread_helper+0x5/0xc

kswapd0: page allocation failure. order:0, mode:0x20
Call Trace:
  [<c014c522>] __alloc_pages+0x302/0x390
  [<c014c5d2>] __get_free_pages+0x22/0x50
  [<c015167c>] cache_grow+0x13c/0x4a0
  [<c0177eca>] bio_hw_segments+0x2a/0x30
  [<c0151d9f>] cache_alloc_refill+0x3bf/0x570
  [<c025aaa7>] __make_request+0x557/0x6f0
  [<c0152744>] kmem_cache_alloc+0x224/0x250
  [<c0201d1c>] radix_tree_preload+0x3c/0x80
  [<c0146add>] add_to_page_cache+0x1d/0x1c0
  [<c01694c4>] add_to_swap+0x64/0xe0
  [<c015730c>] shrink_list+0x81c/0x8d0
  [<c036fe50>] common_interrupt+0x18/0x20
  [<c0155949>] __pagevec_release+0x29/0x40
  [<c01575ae>] shrink_cache+0x1ee/0x5e0
  [<c01587fa>] balance_pgdat+0x17a/0x200
  [<c0158959>] kswapd+0xd9/0xf0
  [<c0122c20>] autoremove_wake_function+0x0/0x50
  [<c0122c20>] autoremove_wake_function+0x0/0x50
  [<c0158880>] kswapd+0x0/0xf0
  [<c01092a9>] kernel_thread_helper+0x5/0xc

psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost synchronization, 
throwing 1 bytes away.
psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost synchronization, 
throwing 3 bytes away.
psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost synchronization, 
throwing 2 bytes away.
psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost synchronization, 
throwing 2 bytes away.
psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost synchronization, 
throwing 2 bytes away.
psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost synchronization, 
throwing 2 bytes away.


The system is under load when the problem appared.
# free
              total       used       free     shared    buffers     cached
Mem:        255396     246688       8708          0       1696      73548
-/+ buffers/cache:     171444      83952
Swap:       514040     201980     312060


I use normal mouse (microsoft PS/2).
Mother card : KT3 Ultra2
Athlon 1600+



