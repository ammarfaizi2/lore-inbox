Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271028AbUJUWSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271028AbUJUWSj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 18:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271026AbUJUWSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 18:18:12 -0400
Received: from hell.sks3.muni.cz ([147.251.210.30]:49030 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S271009AbUJUWQ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 18:16:27 -0400
Date: Fri, 22 Oct 2004 00:16:23 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.6.9 - e1000 - page allocation failed
Message-ID: <20041021221622.GA11607@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm getting this message in kernel log:

swapper: page allocation failure. order:0, mode:0x20
 [__alloc_pages+441/862] __alloc_pages+0x1b9/0x35e
 [__get_free_pages+37/63] __get_free_pages+0x25/0x3f
 [kmem_getpages+33/201] kmem_getpages+0x21/0xc9
 [cache_grow+171/333] cache_grow+0xab/0x14d
 [cache_alloc_refill+372/537] cache_alloc_refill+0x174/0x219
 [__kmalloc+133/140] __kmalloc+0x85/0x8c
 [alloc_skb+71/224] alloc_skb+0x47/0xe0
 [e1000_alloc_rx_buffers+68/227] e1000_alloc_rx_buffers+0x44/0xe3
 [e1000_clean_rx_irq+398/1095] e1000_clean_rx_irq+0x18e/0x447
 [__kfree_skb+131/253] __kfree_skb+0x83/0xfd
 [e1000_clean+81/202] e1000_clean+0x51/0xca
 [net_rx_action+119/246] net_rx_action+0x77/0xf6
 [__do_softirq+183/198] __do_softirq+0xb7/0xc6
 [do_softirq+45/47] do_softirq+0x2d/0x2f
 [do_IRQ+274/304] do_IRQ+0x112/0x130
 [common_interrupt+24/32] common_interrupt+0x18/0x20
 [default_idle+0/44] default_idle+0x0/0x2c
 [default_idle+41/44] default_idle+0x29/0x2c
 [cpu_idle+63/88] cpu_idle+0x3f/0x58
 [start_kernel+361/388] start_kernel+0x169/0x184
 [unknown_bootoption+0/348] unknown_bootoption+0x0/0x15c

That machine has 300MB of free memory of 1GB total and 4GB of free swap. So what
is wrong?

-- 
Luká¹ Hejtmánek
