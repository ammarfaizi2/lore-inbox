Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbWFHTlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbWFHTlA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 15:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWFHTlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 15:41:00 -0400
Received: from aa003msr.fastwebnet.it ([85.18.95.66]:64201 "EHLO
	aa003msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1751194AbWFHTlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 15:41:00 -0400
Date: Thu, 8 Jun 2006 21:38:09 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>
Subject: BUG: warning at kernel/lockdep.c:2427/check_flags()
Message-ID: <20060608213809.101161b0@localhost>
X-Mailer: Sylpheed-Claws 2.3.0-rc3 (GTK+ 2.8.17; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After some hours running 2.6.17-rc6-mm1 + combo-patch I've got this:

[12138.880686] BUG: warning at kernel/lockdep.c:2427/check_flags()
[12138.880692]
[12138.880693] Call Trace:
[12138.880702]  [<ffffffff80240374>] check_flags+0x86/0x201
[12138.880707]  [<ffffffff80240873>] lock_acquire+0x2f/0xa3
[12138.880713]  [<ffffffff8025fcae>] sys_munmap+0x5e/0xa7
[12138.880719]  [<ffffffff8020944e>] system_call+0x7e/0x83
[12138.880723]
[12138.880725] irq event stamp: 18146
[12138.880728] hardirqs last  enabled at (18145): [<ffffffff8049dffc>] _spin_unlock_irq+0x28/0x50
[12138.880734] hardirqs last disabled at (18146): [<ffffffff8049d61e>] trace_hardirqs_off_thunk+0x35/0x67
[12138.880742] softirqs last  enabled at (18112): [<ffffffff8022c1ae>] __do_softirq+0xb2/0xba
[12138.880748] softirqs last disabled at (18105): [<ffffffff8020a2c2>] call_softirq+0x1e/0x28


I don't know if/how it is reproducible.

-- 
	Paolo Ornati
	Linux 2.6.17-rc6-mm1-lockdep on x86_64
