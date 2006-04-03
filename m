Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751677AbWDCJIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbWDCJIO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 05:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751679AbWDCJIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 05:08:14 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:9346 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S1751673AbWDCJIM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 05:08:12 -0400
Date: Mon, 3 Apr 2006 11:08:11 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.14.6 BUG: spinlock cpu recursion on CPU#1, kswapd0/185
Message-ID: <20060403090811.GA27736@janus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cannot reproduce but the stack trace might be useful:

kernel: BUG: spinlock cpu recursion on CPU#1, kswapd0/185
kernel:  lock: cedef1d0, .magic: dead4ead, .owner: lk166/2501, .owner_cpu: 1
kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
kernel:  [spin_bug+134/144] spin_bug+0x86/0x90
kernel:  [_raw_spin_lock+85/128] _raw_spin_lock+0x55/0x80
kernel:  [_spin_lock+9/16] _spin_lock+0x9/0x10
kernel:  [page_check_address+27/128] page_check_address+0x1b/0x80
kernel:  [page_referenced_one+71/208] page_referenced_one+0x47/0xd0
kernel:  [page_referenced_file+128/192] page_referenced_file+0x80/0xc0
kernel:  [page_referenced+125/144] page_referenced+0x7d/0x90
kernel:  [shrink_list+200/1024] shrink_list+0xc8/0x400
kernel:  [shrink_cache+262/672] shrink_cache+0x106/0x2a0
kernel:  [shrink_zone+197/256] shrink_zone+0xc5/0x100
kernel:  [balance_pgdat+598/832] balance_pgdat+0x256/0x340
kernel:  [kswapd+220/272] kswapd+0xdc/0x110
kernel:  [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc

gcc version 3.3.5 (Debian 1:3.3.5-13)

-- 
Frank
