Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264183AbUGNUnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264183AbUGNUnl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 16:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264229AbUGNUnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 16:43:41 -0400
Received: from gate.crashing.org ([63.228.1.57]:3817 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264183AbUGNUn1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 16:43:27 -0400
Subject: Prism54 Oops
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1089837799.2129.0.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 14 Jul 2004 16:43:20 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got that today... (2.6.7 on ppc)

Ben.

Jul 14 15:29:38 gaston kernel: eth2: timeout waiting for mgmt response
Jul 14 15:29:41 gaston last message repeated 3 times
Jul 14 15:29:41 gaston kernel: eth2: mgmt tx queue is still full
Jul 14 15:29:45 gaston last message repeated 20 times
Jul 14 15:29:46 gaston kernel: NETDEV WATCHDOG: eth2: transmit timed out
Jul 14 15:29:47 gaston kernel: eth2: timeout waiting for mgmt response
Jul 14 15:29:49 gaston kernel: NETDEV WATCHDOG: eth2: transmit timed out
Jul 14 15:29:49 gaston kernel: eth2: timeout waiting for mgmt response
Jul 14 15:29:50 gaston kernel: eth2: timeout waiting for mgmt response
Jul 14 15:29:50 gaston kernel: NETDEV WATCHDOG: eth2: transmit timed out
Jul 14 15:29:55 gaston kernel: eth2: timeout waiting for mgmt response
Jul 14 15:29:55 gaston kernel: eth2: mgmt tx queue is still full
Jul 14 15:29:55 gaston last message repeated 15 times
Jul 14 15:29:55 gaston kernel: Oops: kernel access of bad area, sig: 11 [#1]
Jul 14 15:29:55 gaston kernel: NIP: 80047C94 LR: C20487EC SP: 819E5E60 REGS: 819e5db0 TRAP: 0300    Not tainted
Jul 14 15:29:55 gaston kernel: MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
Jul 14 15:29:55 gaston kernel: DAR: 00100100, DSISR: 40000000
Jul 14 15:29:55 gaston kernel: TASK = bff80cc0[3] 'events/0' THREAD: 819e4000Last syscall: 120
Jul 14 15:29:55 gaston kernel: GPR00: 80661120 819E5E60 BFF80CC0 00100100 819E5E20 FFFFFFFF 80390000 802E0000
Jul 14 15:29:55 gaston kernel: GPR08: 819E5E2C 80694DC0 B4583610 80390000 82004024 00000000 00000000 00000000
Jul 14 15:29:55 gaston kernel: GPR16: 00000000 00000000 00000000 00000000 00000000 00220000 00230000 00000000
Jul 14 15:29:55 gaston kernel: GPR24: 00000000 BFF83EBC 819E5ED0 00000000 B45835F8 00009032 819E5ED0 FFFFFFFB
Jul 14 15:29:55 gaston kernel: NIP [80047c94] kfree+0x40/0xa4
Jul 14 15:29:55 gaston kernel: LR [c20487ec] mgt_update_addr+0x9c/0xb0 [prism54]
Jul 14 15:29:55 gaston kernel: Call trace:
Jul 14 15:29:55 gaston kernel:  [c20487ec] mgt_update_addr+0x9c/0xb0 [prism54]
Jul 14 15:29:55 gaston kernel:  [c2048894] mgt_commit+0x94/0xb0 [prism54]
Jul 14 15:29:55 gaston kernel:  [c2046a78] islpci_reset_if+0x12c/0x170 [prism54]
Jul 14 15:29:55 gaston kernel:  [c2046bf4] islpci_reset+0x138/0x180 [prism54]
Jul 14 15:29:55 gaston kernel:  [c2041bac] islpci_do_reset_and_wake+0x1c/0xa8 [prism54]
Jul 14 15:29:55 gaston kernel:  [80033510] worker_thread+0x17c/0x21c
Jul 14 15:29:55 gaston kernel:  [8003754c] kthread+0xb8/0xc0
Jul 14 15:29:55 gaston kernel:  [8000b230] kernel_thread+0x44/0x60
Jul 14 15:29:55 gaston kernel: NETDEV WATCHDOG: eth2: transmit timed out
Jul 14 15:30:25 gaston last message repeated 15 times

-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

