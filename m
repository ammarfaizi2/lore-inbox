Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbVDUCcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVDUCcA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 22:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVDUCb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 22:31:59 -0400
Received: from gate.crashing.org ([63.228.1.57]:7311 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261185AbVDUCbi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 22:31:38 -0400
Subject: [BUG] prism54 oops on cardbus card removal
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 21 Apr 2005 12:31:40 +1000
Message-Id: <1114050700.5995.1.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apr 21 11:13:33 gaston kernel: [233990.968209] PCI: Enabling device 0001:11:00.0 (0000 -> 0002)
Apr 21 11:13:37 gaston kernel: [233995.162668] eth3: resetting device...
Apr 21 11:13:37 gaston kernel: [233995.162699] eth3: uploading firmware...
Apr 21 11:13:37 gaston kernel: [233995.331330] eth3: firmware version: 1.0.4.3
Apr 21 11:13:37 gaston kernel: [233995.331420] eth3: firmware upload complete
Apr 21 11:13:38 gaston kernel: [233995.566992] eth3: interface reset complete
Apr 21 12:16:53 gaston kernel: [237791.796994] eth3: hot unplug detected
Apr 21 12:16:53 gaston kernel: [237791.797007] eth3: removing device
Apr 21 12:16:53 gaston kernel: [237791.797023] eth3: islpci_close ()
Apr 21 12:16:53 gaston kernel: [237791.876915] eth3: timeout waiting for mgmt response 1000, triggering device
Apr 21 12:17:48 gaston kernel: [237791.976919] remove@/devices/pci0001:10/0001:10:1a.0/0001:11:00.0: timeout waiting for mgmt response 900, triggering device
Apr 21 12:17:48 gaston kernel: [237846.858624] Oops: kernel access of bad area, sig: 11 [#1]
Apr 21 12:17:48 gaston kernel: [237846.858644] NIP: C29AE8A0 LR: C29AE548 SP: BFFCDE00 REGS: bffcdd50 TRAP: 0300
 Not tainted
Apr 21 12:17:49 gaston kernel: [237846.858656] MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
Apr 21 12:17:49 gaston kernel: [237846.858664] DAR: 00000000, DSISR: 42000000
Apr 21 12:17:49 gaston kernel: [237846.858673] TASK = bffc0b70[3] 'events/0' THREAD: bffcc000
Apr 21 12:17:49 gaston kernel: [237846.858680] Last syscall: 120
Apr 21 12:17:49 gaston kernel: [237846.858685] GPR00: C29AE548 BFFCDE00 BFFC0B70 00000000 00000000 00000000 BF499D60 803E0FD0
Apr 21 12:17:49 gaston kernel: [237846.858706] GPR08: 803E137C 00000002 BEE29E7C BFFCDD00 432E7FAE 00000000 00000000 00000000
Apr 21 12:17:49 gaston kernel: [237846.858725] GPR16: 00000000 00000000 00000000 00000000 00000000 17000013 BFFCDE40 BFFCDE98
Apr 21 12:17:49 gaston kernel: [237846.858744] GPR24: FFFFFF92 17000013 00000000 00000000 00000000 86818DCC 86818A20 00000000
Apr 21 12:17:49 gaston kernel: [237846.858765] NIP [c29ae8a0] isl38xx_trigger_device+0x190/0x1c4 [prism54]
Apr 21 12:17:49 gaston kernel: [237846.858813] LR [c29ae548] islpci_mgt_transaction+0x1b8/0x1d4 [prism54]
Apr 21 12:17:49 gaston kernel: [237846.858837] Call trace:
Apr 21 12:17:49 gaston kernel: [237846.858843]  [c29ae548] islpci_mgt_transaction+0x1b8/0x1d4 [prism54]
Apr 21 12:17:49 gaston kernel: [237846.858867]  [c29b4ce8] mgt_get_request+0x274/0x2ec [prism54]
Apr 21 12:17:49 gaston kernel: [237846.858894]  [c29aed30] prism54_update_stats+0x74/0x164 [prism54]
Apr 21 12:17:49 gaston kernel: [237846.858918]  [80031018] worker_thread+0x17c/0x21c
Apr 21 12:17:49 gaston kernel: [237846.858936]  [80035f40] kthread+0xb8/0xc0
Apr 21 12:17:49 gaston kernel: [237846.858947]  [8000738c] kernel_thread+0x44/0x60

-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

