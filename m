Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261907AbTCYKsX>; Tue, 25 Mar 2003 05:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261908AbTCYKsX>; Tue, 25 Mar 2003 05:48:23 -0500
Received: from smtp2.wanadoo.fr ([193.252.22.26]:38025 "EHLO
	mwinf0503.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S261907AbTCYKsW>; Tue, 25 Mar 2003 05:48:22 -0500
From: Duncan Sands <baldrick@wanadoo.fr>
To: linux-kernel@vger.kernel.org
Subject: timer hang with current 2.5 BK
Date: Tue, 25 Mar 2003 11:59:26 +0100
User-Agent: KMail/1.5.1
Cc: Andrew Morton <akpm@digeo.com>,
       Linux USB <linux-usb-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303251159.26108.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I remove the uhci_hcd or ehci_hcd module, then I
systematically get the following:

(EIP) run_timer_softirq+0xe3/0x400
timer_interrupt+0x1a3/0x3f0
do_softirq+0xa1/0xb0
do_IRQ+0x23f/0x380
common_interrupt+0x18/0x20
code: 89 50 04 89 02 C7 41

kernel/timer.c:302: spin_lock (kernel/timer.c:c02f7b00) already
locked by kernel/timer.c/398.

killing interrupt handler etc

Presumably this is related to the stall_timer.
This has been happening for ?one week?, and
still occurs with current BK.  Occurs with and
without preempt (UP).

Any ideas?

Thanks,

Duncan.
