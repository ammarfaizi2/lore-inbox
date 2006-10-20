Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946525AbWJTV0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946525AbWJTV0f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 17:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423236AbWJTV0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 17:26:35 -0400
Received: from homer.mvista.com ([63.81.120.158]:32890 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1422954AbWJTV0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 17:26:34 -0400
Subject: 2.6.18-rt6: scheduling while irqs disabled
From: Daniel Walker <dwalker@mvista.com>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 20 Oct 2006 14:27:06 -0700
Message-Id: <1161379626.7468.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Got this while rebooting.

BUG: scheduling with irqs disabled: md0_raid1/0x00000000/1125
caller is rt_spin_lock_slowlock+0x89/0x180
 [<c0104f2b>] show_trace+0x1b/0x20
 [<c0104f54>] dump_stack+0x24/0x30
 [<c0413b7e>] schedule+0x10e/0x120
 [<c0414b79>] rt_spin_lock_slowlock+0x89/0x180
 [<c0415112>] rt_spin_lock+0x22/0x30
 [<c02914b1>] serial8250_console_write+0x141/0x160
 [<c011fd3d>] __call_console_drivers+0x6d/0x80
 [<c011fd93>] _call_console_drivers+0x43/0x90
 [<c012046a>] release_console_sem+0xda/0x250
 [<c01208d2>] vprintk+0x2d2/0x3b0
 [<c012021b>] printk+0x1b/0x20
 [<c0348664>] md_check_recovery+0x4f4/0x530
 [<c033ee3b>] raid1d+0x2b/0x1120
 [<c0342f13>] md_thread+0x43/0x130
 [<c013523d>] kthread+0xfd/0x110
 [<c0100f25>] kernel_thread_helper+0x5/0x10
---------------------------
| preempt count: 00000000 ]
| 0-level deep critical section nesting:
----------------------------------------


