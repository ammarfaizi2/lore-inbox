Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266610AbUGPVAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266610AbUGPVAX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 17:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266618AbUGPVAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 17:00:23 -0400
Received: from gate.crashing.org ([63.228.1.57]:17804 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266610AbUGPVAV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 17:00:21 -0400
Subject: Re: Prism54 Oops
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Margit Schubert-While <margitsw@t-online.de>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <5.1.0.14.2.20040715090455.00b06398@pop.t-online.de>
References: <5.1.0.14.2.20040715090455.00b06398@pop.t-online.de>
Content-Type: text/plain
Message-Id: <1090011615.1899.1.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 16 Jul 2004 17:00:16 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-15 at 03:09, Margit Schubert-While wrote:
> Benjamin scribeth:
>  > Got that today... (2.6.7 on ppc)
> 
> Should be fixed in 2.6.8-rc1.

got it today again:

Jul 14 18:27:27 gaston kernel: Linux version 2.6.8-rc1 (benh@gaston) (gcc version 3.3.4 (Debian 1:3.3.4-3)) #5 Wed Jul 14 18:24:28 EDT 2004

 .../...

Jul 14 18:27:27 gaston kernel: Loaded prism54 driver, version 1.2

 .../..

Jul 16 16:49:52 gaston kernel: eth1: timeout waiting for mgmt response
Jul 16 16:49:56 gaston last message repeated 3 times
Jul 16 16:49:56 gaston kernel: eth1: mgmt tx queue is still full
Jul 16 16:50:16 gaston last message repeated 60 times
Jul 16 16:50:17 gaston kernel: NETDEV WATCHDOG: eth1: transmit timed out
Jul 16 16:50:19 gaston kernel: eth1: timeout waiting for mgmt response
Jul 16 16:50:20 gaston kernel: NETDEV WATCHDOG: eth1: transmit timed out
Jul 16 16:50:20 gaston kernel: eth1: timeout waiting for mgmt response
Jul 16 16:50:21 gaston kernel: eth1: timeout waiting for mgmt response
Jul 16 16:50:21 gaston kernel: NETDEV WATCHDOG: eth1: transmit timed out
Jul 16 16:50:30 gaston kernel: eth1: timeout waiting for mgmt response
Jul 16 16:50:30 gaston kernel: eth1: mgmt tx queue is still full
Jul 16 16:50:30 gaston last message repeated 15 times
Jul 16 16:50:30 gaston kernel: Oops: kernel access of bad area, sig: 11 [#1]
Jul 16 16:50:30 gaston kernel: NIP: 800483AC LR: C24B2574 SP: 819F5E60 REGS: 819f5db0 TRAP: 0300    Not tainted
Jul 16 16:50:30 gaston kernel: MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
Jul 16 16:50:30 gaston kernel: DAR: 00100100, DSISR: 40000000
Jul 16 16:50:30 gaston kernel: TASK = bff90cc0[3] 'events/0' THREAD: 819f4000Last syscall: 120
Jul 16 16:50:30 gaston kernel: GPR00: 80665120 819F5E60 BFF90CC0 00100100 819F5E20 FFFFFFFF 80390000 802E0000
Jul 16 16:50:30 gaston kernel: GPR08: 819F5E2C 80698FC0 BF206610 80390000 82004024 00000000 00000000 00000000
Jul 16 16:50:30 gaston kernel: GPR16: 00000000 00000000 00000000 00000000 00000000 00220000 00230000 00000000
Jul 16 16:50:30 gaston kernel: GPR24: 00000000 BFF93EBC 819F5ED0 00000000 BF2065F8 00009032 819F5ED0 FFFFFFFB
Jul 16 16:50:30 gaston kernel: NIP [800483ac] kfree+0x40/0xa4
Jul 16 16:50:30 gaston kernel: LR [c24b2574] mgt_update_addr+0x9c/0xb0 [prism54]
Jul 16 16:50:30 gaston kernel: Call trace:
Jul 16 16:50:30 gaston kernel:  [c24b2574] mgt_update_addr+0x9c/0xb0 [prism54]
Jul 16 16:50:30 gaston kernel:  [c24b261c] mgt_commit+0x94/0xb0 [prism54]
Jul 16 16:50:30 gaston kernel:  [c24b07d0] islpci_reset_if+0x12c/0x170 [prism54]
Jul 16 16:50:30 gaston kernel:  [c24b094c] islpci_reset+0x138/0x180 [prism54]
Jul 16 16:50:30 gaston kernel:  [c24abbb4] islpci_do_reset_and_wake+0x1c/0xa8 [prism54]
Jul 16 16:50:30 gaston kernel:  [800336f8] worker_thread+0x17c/0x21c
Jul 16 16:50:30 gaston kernel:  [80037cc8] kthread+0xb8/0xc0
Jul 16 16:50:30 gaston kernel:  [8000b230] kernel_thread+0x44/0x60


