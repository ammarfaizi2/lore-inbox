Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262792AbTDVBoT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 21:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262810AbTDVBoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 21:44:19 -0400
Received: from uida4-8.inav.uiowa.net ([64.6.83.152]:9856 "EHLO digitasaru.net")
	by vger.kernel.org with ESMTP id S262792AbTDVBoQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 21:44:16 -0400
Date: Mon, 21 Apr 2003 20:56:16 -0500
From: Joseph Pingenot <trelane@digitasaru.net>
To: linux-kernel@vger.kernel.org
Subject: 2.5.68 oopses
Message-ID: <20030422015612.GB599@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the following when booting 2.5.68:

Apr 21 00:41:37 paulus kernel: airo: Doing fast bap_reads
Apr 21 00:41:37 paulus kernel: airo: MAC enabled eth1 0:7:e:b8:d6:7d
Apr 21 00:41:37 paulus kernel: eth1: index 0x05: Vcc 5.0, Vpp 5.0, irq 4, io 0x0100-0x013f
Apr 21 00:41:37 paulus kernel: bad: scheduling while atomic!
Apr 21 00:41:37 paulus kernel: Call Trace:
Apr 21 00:41:37 paulus kernel: [<c0117087>] schedule+0x387/0x3a0
Apr 21 00:41:37 paulus kernel: [<c021c9b3>] issuecommand+0x53/0x80
Apr 21 00:41:37 paulus kernel: [<c021ce98>] PC4500_accessrid+0x38/0x80
Apr 21 00:41:37 paulus kernel: [<c021cf40>] PC4500_readrid+0x60/0x120
Apr 21 00:41:37 paulus kernel: [<c021a85a>] readStatsRid+0x1a/0x40
Apr 21 00:41:37 paulus kernel: [<c021ae22>] airo_get_stats+0x22/0xc0
Apr 21 00:41:37 paulus kernel: [<c0132d9e>] find_get_page+0x1e/0x60
Apr 21 00:41:37 paulus kernel: [<c01732a0>] proc_alloc_inode+0x0/0x80
Apr 21 00:41:37 paulus kernel: [<c0139771>] kmem_cache_alloc+0x51/0x60
Apr 21 00:41:37 paulus kernel: [<c01732a0>] proc_alloc_inode+0x0/0x80
Apr 21 00:41:37 paulus kernel: [<c0139771>] kmem_cache_alloc+0x51/0x60
Apr 21 00:41:37 paulus kernel: [<c01732e8>] proc_alloc_inode+0x48/0x80
Apr 21 00:41:37 paulus kernel: [<c0162739>] alloc_inode+0x19/0x140
Apr 21 00:41:37 paulus kernel: [<c0163230>] get_new_inode+0xf0/0x100
Apr 21 00:41:37 paulus kernel: [<c0173272>] proc_read_inode+0x12/0x40
Apr 21 00:41:37 paulus kernel: [<c0132d9e>] find_get_page+0x1e/0x60
Apr 21 00:41:37 paulus kernel: [<c01c750d>] vsnprintf+0x1ed/0x420
Apr 21 00:41:37 paulus kernel: [<c0167fd2>] seq_printf+0x32/0x60
Apr 21 00:41:37 paulus kernel: [<c029b40e>] dev_seq_printf_stats+0x6e/0xa0
Apr 21 00:41:37 paulus kernel: [<c029b42c>] dev_seq_printf_stats+0x8c/0xa0
Apr 21 00:41:37 paulus kernel: [<c029b455>] dev_seq_show+0x15/0x40
Apr 21 00:41:37 paulus kernel: [<c0167a97>] seq_read+0x1b7/0x2e0
Apr 21 00:41:37 paulus kernel: [<c014bcd8>] vfs_read+0x98/0xe0
Apr 21 00:41:37 paulus kernel: [<c014bee8>] sys_read+0x28/0x40
Apr 21 00:41:37 paulus kernel: [<c0109297>] syscall_call+0x7/0xb
Apr 21 00:41:37 paulus kernel: 
Apr 21 00:41:37 paulus kernel: bad: scheduling while atomic!
Apr 21 00:41:37 paulus kernel: Call Trace:
Apr 21 00:41:37 paulus kernel: [<c0117087>] schedule+0x387/0x3a0
Apr 21 00:41:37 paulus kernel: [<c021c9b3>] issuecommand+0x53/0x80
Apr 21 00:41:37 paulus kernel: [<c021ce98>] PC4500_accessrid+0x38/0x80
Apr 21 00:41:37 paulus kernel: [<c021cf40>] PC4500_readrid+0x60/0x120
Apr 21 00:41:37 paulus kernel: [<c021a85a>] readStatsRid+0x1a/0x40
Apr 21 00:41:37 paulus kernel: [<c021ae22>] airo_get_stats+0x22/0xc0
Apr 21 00:41:37 paulus kernel: [<c01c750d>] vsnprintf+0x1ed/0x420
Apr 21 00:41:37 paulus kernel: [<c0167fd2>] seq_printf+0x32/0x60
Apr 21 00:41:37 paulus kernel: [<c029b40e>] dev_seq_printf_stats+0x6e/0xa0
Apr 21 00:41:37 paulus kernel: [<c029b42c>] dev_seq_printf_stats+0x8c/0xa0
Apr 21 00:41:37 paulus kernel: [<c029b455>] dev_seq_show+0x15/0x40
Apr 21 00:41:37 paulus kernel: [<c0167a97>] seq_read+0x1b7/0x2e0
Apr 21 00:41:37 paulus kernel: [<c014bcd8>] vfs_read+0x98/0xe0
Apr 21 00:41:37 paulus kernel: [<c014bee8>] sys_read+0x28/0x40
Apr 21 00:41:37 paulus kernel: [<c0109297>] syscall_call+0x7/0xb
Apr 21 00:41:37 paulus kernel: 

I can use pump to get an ipaddress on eth1 (the card) without
  complaint.  Then, I get, when running ifconfig:

Apr 21 00:43:30 paulus kernel: bad: scheduling while atomic!
Apr 21 00:43:30 paulus kernel: Call Trace:
Apr 21 00:43:30 paulus kernel: [<c0117087>] schedule+0x387/0x3a0
Apr 21 00:43:30 paulus kernel: [<c021c23e>] IN4500+0x1e/0x40
Apr 21 00:43:30 paulus kernel: [<c021c9b3>] issuecommand+0x53/0x80
Apr 21 00:43:30 paulus kernel: [<c021ce98>] PC4500_accessrid+0x38/0x80
Apr 21 00:43:30 paulus kernel: [<c021cf40>] PC4500_readrid+0x60/0x120
Apr 21 00:43:30 paulus kernel: [<c021a85a>] readStatsRid+0x1a/0x40
Apr 21 00:43:30 paulus kernel: [<c021ae22>] airo_get_stats+0x22/0xc0
Apr 21 00:43:30 paulus kernel: [<c0132d9e>] find_get_page+0x1e/0x60
Apr 21 00:43:30 paulus kernel: [<c01732a0>] proc_alloc_inode+0x0/0x80
Apr 21 00:43:30 paulus kernel: [<c0139771>] kmem_cache_alloc+0x51/0x60
Apr 21 00:43:30 paulus kernel: [<c01732a0>] proc_alloc_inode+0x0/0x80
Apr 21 00:43:30 paulus kernel: [<c0139771>] kmem_cache_alloc+0x51/0x60
Apr 21 00:43:30 paulus kernel: [<c01732e8>] proc_alloc_inode+0x48/0x80
Apr 21 00:43:30 paulus kernel: [<c0163930>] generic_forget_inode+0x70/0x140
Apr 21 00:43:30 paulus kernel: [<c0173272>] proc_read_inode+0x12/0x40
Apr 21 00:43:30 paulus kernel: [<c0132d9e>] find_get_page+0x1e/0x60
Apr 21 00:43:30 paulus kernel: [<c01c750d>] vsnprintf+0x1ed/0x420
Apr 21 00:43:30 paulus kernel: [<c0167fd2>] seq_printf+0x32/0x60
Apr 21 00:43:30 paulus kernel: [<c029b40e>] dev_seq_printf_stats+0x6e/0xa0
Apr 21 00:43:30 paulus kernel: [<c029b42c>] dev_seq_printf_stats+0x8c/0xa0
Apr 21 00:43:30 paulus kernel: [<c029b455>] dev_seq_show+0x15/0x40
Apr 21 00:43:30 paulus kernel: [<c0167a97>] seq_read+0x1b7/0x2e0
Apr 21 00:43:30 paulus kernel: [<c014bcd8>] vfs_read+0x98/0xe0
Apr 21 00:43:30 paulus kernel: [<c014bee8>] sys_read+0x28/0x40
Apr 21 00:43:30 paulus kernel: [<c0109297>] syscall_call+0x7/0xb
Apr 21 00:43:30 paulus kernel: 
Apr 21 00:43:31 paulus kernel: bad: scheduling while atomic!
Apr 21 00:43:31 paulus kernel: Call Trace:
Apr 21 00:43:31 paulus kernel: [<c0117087>] schedule+0x387/0x3a0
Apr 21 00:43:31 paulus kernel: [<c021c9b3>] issuecommand+0x53/0x80
Apr 21 00:43:31 paulus kernel: [<c021ce98>] PC4500_accessrid+0x38/0x80
Apr 21 00:43:31 paulus kernel: [<c021cf40>] PC4500_readrid+0x60/0x120
Apr 21 00:43:31 paulus kernel: [<c021a85a>] readStatsRid+0x1a/0x40
Apr 21 00:43:31 paulus kernel: [<c021ae22>] airo_get_stats+0x22/0xc0
Apr 21 00:43:31 paulus kernel: [<c01c750d>] vsnprintf+0x1ed/0x420
Apr 21 00:43:31 paulus kernel: [<c0167fd2>] seq_printf+0x32/0x60
Apr 21 00:43:31 paulus kernel: [<c029b40e>] dev_seq_printf_stats+0x6e/0xa0
Apr 21 00:43:31 paulus kernel: [<c029b42c>] dev_seq_printf_stats+0x8c/0xa0
Apr 21 00:43:31 paulus kernel: [<c029b455>] dev_seq_show+0x15/0x40
Apr 21 00:43:31 paulus kernel: [<c0167a97>] seq_read+0x1b7/0x2e0
Apr 21 00:43:31 paulus kernel: [<c014bcd8>] vfs_read+0x98/0xe0
Apr 21 00:43:31 paulus kernel: [<c014bee8>] sys_read+0x28/0x40
Apr 21 00:43:31 paulus kernel: [<c0109297>] syscall_call+0x7/0xb
Apr 21 00:43:31 paulus kernel: 

Finally, on shutdown, I get some more oopses, but they go by fast, and
  they didn't make it into my log.

-Joseph
-- 
Joseph===============================================trelane@digitasaru.net
"Isn't it illegal for Microsoft to tie any of its software products to its
  OS?"  --Rob Riggs on slashdot (www.slashdot.org) about Microsoft's order
  to cease and decist using Visual Fox Pro on Linux, a non-Microsoft OS.
"Yes. The penalty is dinner with no dessert." --Alien Being, response
