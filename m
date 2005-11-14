Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbVKNTaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbVKNTaX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 14:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbVKNTaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 14:30:22 -0500
Received: from frankvm.xs4all.nl ([80.126.170.174]:24016 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S1751256AbVKNTaW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 14:30:22 -0500
Date: Mon, 14 Nov 2005 20:30:21 +0100
From: Frank van Maarseveen <frankvm@frankvm.com>
To: linux-kernel@vger.kernel.org
Subject: [2.6.14.2] Debug: sleeping function called from invalid context at mm/slab.c:2459
Message-ID: <20051114193021.GA15010@janus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.14.2 on a AMD Athlon X2 3800

Nov 14 20:17:30 iapetus kernel: in_atomic():1, irqs_disabled():0
Nov 14 20:17:30 iapetus kernel:  [<c010410e>] dump_stack+0x1e/0x20
Nov 14 20:17:30 iapetus kernel:  [<c01211c5>] __might_sleep+0xa5/0xb0
Nov 14 20:17:30 iapetus kernel:  [<c01512cd>] __kmalloc+0xdd/0x100
Nov 14 20:17:30 iapetus kernel:  [<c041d8bd>] pskb_expand_head+0x4d/0x150
Nov 14 20:17:30 iapetus kernel:  [<c043bbc7>] netlink_broadcast+0x387/0x3c0
Nov 14 20:17:30 iapetus kernel:  [<c04a4673>] nfnetlink_send+0x63/0xa0
Nov 14 20:17:30 iapetus kernel:  [<c0484d20>] ctnetlink_conntrack_event+0x3a0/0xac0
Nov 14 20:17:30 iapetus kernel:  [<c013239d>] notifier_call_chain+0x2d/0x50
Nov 14 20:17:30 iapetus kernel:  [<c047fadb>] destroy_conntrack+0x12b/0x190
Nov 14 20:17:30 iapetus kernel:  [<c0480b35>] ip_conntrack_in+0x1a5/0x360
Nov 14 20:17:30 iapetus kernel:  [<c047eda6>] ip_conntrack_local+0x66/0x70
Nov 14 20:17:30 iapetus kernel:  [<c04a2fd8>] nf_iterate+0x68/0xb0
Nov 14 20:17:30 iapetus kernel:  [<c04a308d>] nf_hook_slow+0x6d/0x140
Nov 14 20:17:30 iapetus kernel:  [<c04460ab>] ip_queue_xmit+0x47b/0x5f0
Nov 14 20:17:30 iapetus kernel:  [<c0457402>] tcp_transmit_skb+0x442/0x6e0
Nov 14 20:17:30 iapetus kernel:  [<c0459fb7>] tcp_connect+0x2f7/0x380
Nov 14 20:17:30 iapetus kernel:  [<c045c0c7>] tcp_v4_connect+0x627/0xb70
Nov 14 20:17:30 iapetus kernel:  [<c046bddd>] inet_stream_connect+0x7d/0x1a0
Nov 14 20:17:30 iapetus kernel:  [<c0419328>] sys_connect+0x78/0xa0
Nov 14 20:17:30 iapetus kernel:  [<c0419db3>] sys_socketcall+0xa3/0x240
Nov 14 20:17:30 iapetus kernel:  [<c01031fb>] sysenter_past_esp+0x54/0x75


-- 
Frank
