Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbUCFNIX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 08:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbUCFNIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 08:08:23 -0500
Received: from integer.pobox.com ([208.58.1.194]:15758 "EHLO integer.pobox.com")
	by vger.kernel.org with ESMTP id S261251AbUCFNIV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 08:08:21 -0500
Date: Sat, 6 Mar 2004 06:08:23 -0700
From: Jeff Lightfoot <jeffml@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.4-rc1 & rc2 Oops
Message-Id: <20040306060823.15bed9a3.jeffml@pobox.com>
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i386-pc-linux-gnu)
X-Face: $n=Rh`fC)-'~T?N4{k<m#PDTgj\,OYTK+D(!TTIdBm&(^y:ydlx9:~xe.1@_]/h!~a]D.Ja
 T)qLF2A(b!G{>=V~zorpO2&"J`qbq{|eiZ&k.#tAz{{7.3M_}Y?qY1sB}1,-F
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following Oops happened in 2.6.4-rc2 and one almost exactly
like it happened in 2.6.4-rc1.  It seemed random otherwise I'd try
to narrow it down.  My last kernel before those was 2.6.2-mm1
and I hadn't seen this.  This current one came at about one
day and 12 hours of uptime.

Let me know if tons of other info would be useful.

Basic:
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 6
model name	: AMD Athlon(tm) XP 2000+


Unable to handle kernel paging request at virtual address 20000004
 printing eip:
c0132626
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c0132626>]    Not tainted
EFLAGS: 00010297
EIP is at find_get_pages+0x36/0x50
eax: 20000000   ebx: c1bd9e04   ecx: 00000003   edx: 00000002
esi: 00000000   edi: 00000030   ebp: c1bd8000   esp: c1bd9db8
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 8, threadinfo=c1bd8000 task=c1bdebc0)
Stack: e92eecd0 c1bd9e04 00000000 00000010 c1bd9dfc c013a5ce e92eeccc 00000000 
       00000010 c1bd9e04 e92eec48 c013aa4d c1bd9dfc e92eeccc 00000000 00000010 
       00000000 00000000 00000000 c1674d50 c166f2d8 20000000 c166f170 c1678590 
Call Trace:
 [<c013a5ce>] pagevec_lookup+0x2e/0x60
 [<c013aa4d>] invalidate_mapping_pages+0x5d/0x100
 [<c013ab0f>] invalidate_inode_pages+0x1f/0x30
 [<c0162885>] prune_icache+0x1a5/0x1b0
 [<c01628b3>] shrink_icache_memory+0x23/0x30
 [<c013ae3e>] shrink_slab+0x11e/0x170
 [<c013bec2>] balance_pgdat+0x1d2/0x1f0
 [<c013bfdc>] kswapd+0xfc/0x100
 [<c011a440>] autoremove_wake_function+0x0/0x50
 [<c011a440>] autoremove_wake_function+0x0/0x50
 [<c013bee0>] kswapd+0x0/0x100
 [<c0106dc9>] kernel_thread_helper+0x5/0xc

Code: ff 40 04 42 39 ca 72 f5 83 c4 10 89 c8 5b c3 8d 74 26 00 8d 

-- 
Jeff Lightfoot    --    jeffml@pobox.com    --    http://thefoots.com/
    "How can I sing like a girl and not be stigmatized by the rest of
    the world?" -- TMBG
