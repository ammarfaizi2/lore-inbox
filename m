Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266836AbUGVJDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266836AbUGVJDq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 05:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266845AbUGVJC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 05:02:29 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:43705 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S266837AbUGVJBc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 05:01:32 -0400
From: Bernd Schubert <bernd-schubert@web.de>
To: Christoph Hellwig <hch@infradead.org>
Subject: 2.6.7 oops, sk98lin related?
Date: Thu, 22 Jul 2004 11:01:14 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200407221101.16388.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christoph and all others,

is this an sk98lin oops, maybe related to your patches or is it a completely 
different problem?



dsmc: page allocation failure. order:2, mode:0x20
 [<c010706e>] dump_stack+0x1e/0x20
 [<c01419cb>] __alloc_pages+0x2bb/0x330
 [<c0141a67>] __get_free_pages+0x27/0x40
 [<c01453c0>] kmem_getpages+0x20/0xd0
 [<c0146123>] cache_grow+0xd3/0x290
 [<c0146480>] cache_alloc_refill+0x1a0/0x270
 [<c0146ac3>] __kmalloc+0x83/0x90
 [<c0342668>] alloc_skb+0x48/0xf0
 [<f8aa0acb>] FillRxDescriptor+0x2b/0xc0 [sk98lin]
 [<f8aa0a8c>] FillRxRing+0x6c/0x80 [sk98lin]
 [<f8aa4882>] SkDrvEvent+0xb12/0xb70 [sk98lin]
 [<f8ab42e5>] SkEventDispatcher+0xc5/0x160 [sk98lin]
 [<f8a9f918>] SkGeIsrOnePort+0x118/0x1f0 [sk98lin]
 [<c010835b>] handle_IRQ_event+0x3b/0x70
 [<c010873b>] do_IRQ+0xbb/0x1a0
 [<c0106b64>] common_interrupt+0x18/0x20
 [<c014a3e5>] shrink_zone+0xa5/0xe0
 [<c014a48c>] shrink_caches+0x6c/0x70
 [<c014a532>] try_to_free_pages+0xa2/0x170
 [<c01418c4>] __alloc_pages+0x1b4/0x330
 [<c0141a67>] __get_free_pages+0x27/0x40
 [<c0171526>] __pollwait+0x76/0xb0
 [<c0362946>] tcp_poll+0x36/0x180
 [<c033f209>] sock_poll+0x29/0x30
 [<c0171877>] do_select+0x237/0x2b0
 [<c0171bb0>] sys_select+0x290/0x480
 [<c010617f>] syscall_call+0x7/0xb


I have another 190KB of traces uploaded 
(http://www.pci.uni-heidelberg.de/tc/usr/bernd/downloads/oopses/minicom.log). 

All kernel bootup messages are at the end this file as well.


Yesterday Marvell Yukon announced a new sk98lin driver, should I try this 
version?


Thanks a lot in advance,
	Bernd


-- 
Bernd Schubert
Physikalisch Chemisches Institut / Theoretische Chemie
Universität Heidelberg
INF 229
69120 Heidelberg
e-mail: bernd.schubert@pci.uni-heidelberg.de
