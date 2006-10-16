Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWJPOL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWJPOL3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 10:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbWJPOL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 10:11:28 -0400
Received: from [195.171.73.133] ([195.171.73.133]:16613 "EHLO
	pelagius.h-e-r-e-s-y.com") by vger.kernel.org with ESMTP
	id S1750709AbWJPOL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 10:11:27 -0400
Date: Mon, 16 Oct 2006 14:11:27 +0000
From: andrew@walrond.org
To: linux-kernel@vger.kernel.org
Subject: Sparc64 kernel message: BUG: soft lockup detected on CPU#3!
Message-ID: <20061016141127.GB9350@pelagius.h-e-r-e-s-y.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a Sun T1000 (6 cores / 24 threads) running a vanilla 2.6.18
kernel. Everthing seems to be working OK, but this message appeared in
the kernel log:

BUG: soft lockup detected on CPU#3!
Call Trace:
 [000000000043143c] smp_percpu_timer_interrupt+0xd4/0x144
 [00000000004109d4] tl0_irq14+0x1c/0x20
 [00000000005262e0] p1275_cmd+0x34c/0x354
 [0000000000525990] prom_putchar+0x2c/0x34
 [0000000000526320] prom_write+0x38/0x4c
 [0000000000526378] prom_printf+0x44/0x4c
 [0000000000540e50] promcon_putcs+0x2fc/0x304
 [0000000000581198] do_con_write+0x1c34/0x1c6c
 [0000000000581220] con_write+0x18/0x2c
 [0000000000573198] write_chan+0x2e4/0x36c
 [000000000056ff08] tty_write+0x154/0x1e0
 [00000000004921e8] vfs_write+0x78/0x124
 [00000000004926d8] sys_write+0x34/0x60
 [0000000000406c14] linux_sparc_syscall+0x3c/0x44
 [0000000000101d74] 0x101d7c

Hope thats meaningful to someone :)
Anything I can do, let me know

Andrew Walrond

BTW Googling for "BUG: soft lockup detected on CPU" returns *lots* of
hits, but no resolutions that I could see...
