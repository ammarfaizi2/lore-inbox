Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265038AbUGQLEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265038AbUGQLEM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 07:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266682AbUGQLEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 07:04:12 -0400
Received: from mail.gmx.de ([213.165.64.20]:7107 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265038AbUGQLEK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 07:04:10 -0400
Date: Sat, 17 Jul 2004 13:04:09 +0200 (MEST)
From: "Daniel Blueman" <daniel.blueman@gmx.net>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: [2.6.7, e1000] large MTU allocation failure...
X-Priority: 3 (Normal)
X-Authenticated: #8973862
Message-ID: <25348.1090062249@www11.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I try to enable jumbo frames, and increase the MTU size to 9000 octets
[1], I see allocation failures in the kernel logs [2].

Is there another way of enabling jumbo frames and use a large MTU?

Kernel is stock 2.6.7, IA32.

--- [1]

# ifconfig eth0 mtu 9000

--- [2]

Intel(R) PRO/1000 Network Driver - version 5.2.52-k4
Copyright (c) 1999-2004 Intel Corporation.
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network
Connection
e1000: eth0: e1000_watchdog: NIC Link is Up 1000 Mbps
Full Duplex
ifconfig: page allocation failure. order:3, mode:0x20
[<c012ac54>] __alloc_pages+0x2b4/0x300
[<c012acbf>] __get_free_pages+0x1f/0x40
[<c012dc37>] kmem_getpages+0x17/0xb0
[<c012e6f6>] cache_grow+0x96/0x1f0
[<c012e9ae>] cache_alloc_refill+0x15e/0x230
[<c012ef07>] __kmalloc+0x67/0x70
[<c021d552>] alloc_skb+0x32/0xd0
[<c01fa035>] e1000_alloc_rx_buffers+0x55/0xf0
[<c01f75fd>] e1000_up+0x3d/0x90
[<c01f92c6>] e1000_change_mtu+0x76/0x100
[<c02228e5>] dev_set_mtu+0x65/0x70
[<c0222ebf>] dev_ioctl+0x1df/0x250
[<c02602e0>] udp_ioctl+0x0/0xc0
[<c02676f9>] inet_ioctl+0x89/0xa0
[<c021a722>] sock_ioctl+0xd2/0x220
[<c01514a9>] sys_ioctl+0xe9/0x240
[<c0103bf7>] syscall_call+0x7/0xb

-- 
Daniel J Blueman

