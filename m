Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030354AbVLWCyB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030354AbVLWCyB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 21:54:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030386AbVLWCyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 21:54:00 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:57233 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030354AbVLWCyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 21:54:00 -0500
Subject: 2.6.15-rc5-rt4: BUG: swapper:0 task might have lost a preemption
	check!
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 22 Dec 2005 21:55:33 -0500
Message-Id: <1135306534.4473.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got this on boot.  Same .config as the last one I sent you.

VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide1...
BUG: swapper:0 task might have lost a preemption check!
 [<c010440c>] dump_stack+0x1c/0x20 (20)
 [<c01166aa>] preempt_enable_no_resched+0x5a/0x60 (20)
 [<c0100dd9>] cpu_idle+0x79/0xb0 (12)
 [<c0100280>] _stext+0x40/0x50 (28)
 [<c03078e6>] start_kernel+0x176/0x1d0 (20)
 [<c0100199>] 0xc0100199 (1086889999)
---------------------------
| preempt count: 00000000 ]
| 0-level deep critical section nesting:
----------------------------------------

Lee

