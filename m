Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbULBRtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbULBRtL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 12:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbULBRtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 12:49:09 -0500
Received: from adsl.a2000.nu ([80.126.253.168]:16775 "EHLO adsl.a2000.nu")
	by vger.kernel.org with ESMTP id S261634AbULBRr6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 12:47:58 -0500
Date: Thu, 2 Dec 2004 18:47:52 +0100 (CET)
From: Stephan van Hienen <kernel@a2000.nu>
To: linux-kernel@vger.kernel.org
Subject: swapper: page allocation failure (2.6.10-rc2)
Message-ID: <Pine.LNX.4.61.0412021846220.16787@adsl.a2000.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Today got this error :
(system didn't crash it's still running) :

swapper: page allocation failure. order:0, mode:0x20
  [<c0136b22>] __alloc_pages+0x1b9/0x356
  [<c0136ce4>] __get_free_pages+0x25/0x3f
  [<c013a032>] kmem_getpages+0x21/0xcd
  [<c013ab51>] alloc_slabmgmt+0x55/0x60
  [<c013acf3>] cache_grow+0xca/0x16f
  [<c013ae7a>] cache_alloc_refill+0xe2/0x21b
  [<c013b23c>] __kmalloc+0x73/0x7a
  [<c03594ed>] alloc_skb+0x47/0xe0
  [<c02dc1f0>] e1000_alloc_rx_buffers+0x44/0xe2
  [<c02dbef2>] e1000_clean_rx_irq+0x19c/0x456
  [<c02dbabc>] e1000_clean+0x51/0xcc
  [<c035f92c>] net_rx_action+0x7a/0x103
  [<c011b8d2>] __do_softirq+0xba/0xc9
  [<c010066e>] default_idle+0x0/0x2d
  [<c011b90e>] do_softirq+0x2d/0x2f
  [<c0104b22>] do_IRQ+0x1e/0x24
  [<c0102fea>] common_interrupt+0x1a/0x20
  [<c010066e>] default_idle+0x0/0x2d
  [<c0100698>] default_idle+0x2a/0x2d
  [<c010070c>] cpu_idle+0x37/0x40
  [<c04c28d3>] start_kernel+0x14c/0x165
  [<c04c2337>] unknown_bootoption+0x0/0x1e0


Linux storage.a2000.nu 2.6.10-rc2 #2 SMP Tue Nov 30 21:59:49 CET 2004 i686 
i686 i386 GNU/Linux

]# free
              total       used       free     shared    buffers     cached
Mem:       1034156     979592      54564          0        712     925404
-/+ buffers/cache:      53476     980680
Swap:      2096472        836    2095636
