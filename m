Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263441AbUACONN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 09:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263448AbUACONM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 09:13:12 -0500
Received: from main.gmane.org ([80.91.224.249]:13768 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263441AbUACONI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 09:13:08 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andreas Schwarz <usenet@andreas-s.net>
Subject: Badness in local_bh_enable at kernel/softirq.c:121
Date: Sat, 3 Jan 2004 14:13:06 +0000 (UTC)
Message-ID: <slrnbvdjfj.6ip.usenet@213-203-244-47.kunde.vdserver.de>
X-Complaints-To: usenet@sea.gmane.org
X-TCPA-ist-scheisse: yes
User-Agent: slrn/0.9.7.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm not sure if this is a bug in the kernel (2.6.0-gentoo) or in hostap:

Jan  3 15:06:33 d700 kernel: Badness in local_bh_enable at kernel/softirq.c:121
Jan  3 15:06:33 d700 kernel: Call Trace:
Jan  3 15:06:33 d700 kernel:  [<c0120dec>] local_bh_enable+0x8c/0x90
Jan  3 15:06:33 d700 kernel:  [<e1b783a4>] prism2_transmit_cb+0xd4/0x120 [hostap_pci]
Jan  3 15:06:33 d700 kernel:  [<e1b787bf>] prism2_cmd_ev+0x30f/0x3b0 [hostap_pci]
Jan  3 15:06:33 d700 kernel:  [<e1b7b6d0>] prism2_interrupt+0x250/0x2a0 [hostap_pci]
Jan  3 15:06:33 d700 kernel:  [<e1938fa6>] usb_hcd_irq+0x36/0x60 [usbcore]
Jan  3 15:06:33 d700 kernel:  [<c010b65a>] handle_IRQ_event+0x3a/0x70
Jan  3 15:06:33 d700 kernel:  [<c010ba07>] do_IRQ+0x97/0x140
Jan  3 15:06:33 d700 kernel:  [<c0109c88>] common_interrupt+0x18/0x20
Jan  3 15:06:33 d700 kernel:  [<e1b7603a>] hfa384x_from_bap+0x3a/0x60 [hostap_pci]
Jan  3 15:06:33 d700 kernel:  [<e1b79cd2>] prism2_rx+0x382/0x530 [hostap_pci]
Jan  3 15:06:33 d700 kernel:  [<c027420e>] ip_rcv+0x40e/0x4d0
Jan  3 15:06:33 d700 kernel:  [<e1b7b318>] hostap_bap_tasklet+0xc8/0xe0 [hostap_pci]
Jan  3 15:06:33 d700 kernel:  [<c0120f36>] tasklet_action+0x46/0x70
Jan  3 15:06:33 d700 kernel:  [<c0120d55>] do_softirq+0x95/0xa0
Jan  3 15:06:33 d700 kernel:  [<c0120dc1>] local_bh_enable+0x61/0x90
Jan  3 15:06:33 d700 kernel:  [<c012548b>] schedule_timeout+0x6b/0xc0
Jan  3 15:06:33 d700 kernel:  [<c02b7ff2>] packet_poll+0x72/0x90
Jan  3 15:06:33 d700 kernel:  [<c02549e9>] sock_poll+0x29/0x40
Jan  3 15:06:33 d700 kernel:  [<c0164923>] do_select+0x2c3/0x2e0
Jan  3 15:06:33 d700 kernel:  [<c01644b0>] __pollwait+0x0/0xd0
Jan  3 15:06:33 d700 kernel:  [<c0164c4b>] sys_select+0x2db/0x500
Jan  3 15:06:33 d700 kernel:  [<c010931b>] syscall_call+0x7/0xb

