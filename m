Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261539AbSJYSpX>; Fri, 25 Oct 2002 14:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261540AbSJYSpX>; Fri, 25 Oct 2002 14:45:23 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:50583 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261539AbSJYSpW>;
	Fri, 25 Oct 2002 14:45:22 -0400
Date: Fri, 25 Oct 2002 19:53:16 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: jgarzik@pobox.com, linux.nics@intel.com
Cc: linux-kernel@vger.kernel.org
Subject: e100 doing bad things in 2.5.44.
Message-ID: <20021025185316.GA10278@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>, jgarzik@pobox.com,
	linux.nics@intel.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oct 25 18:38:12 tetrachloride kernel: Debug: sleeping function called from illegal context at mm/slab.c:1384
Oct 25 18:38:12 tetrachloride kernel: Call Trace:
Oct 25 18:38:12 tetrachloride kernel:  [<c011dd94>] __might_sleep+0x54/0x58
Oct 25 18:38:12 tetrachloride kernel:  [<c01403ae>] kmalloc+0x5a/0x314
Oct 25 18:38:12 tetrachloride kernel:  [<c017e2da>] proc_create+0x76/0xcc
Oct 25 18:38:12 tetrachloride kernel:  [<c017e3fb>] proc_mkdir+0x17/0x40
Oct 25 18:38:12 tetrachloride kernel:  [<c010a4c3>] register_irq_proc+0x6b/0xb0
Oct 25 18:38:12 tetrachloride kernel:  [<c010a2ba>] setup_irq+0x166/0x174
Oct 25 18:38:12 tetrachloride kernel:  [<c02b9424>] e100intr+0x0/0x308
Oct 25 18:38:12 tetrachloride kernel:  [<c0109b48>] request_irq+0x88/0xa4
Oct 25 18:38:12 tetrachloride kernel:  [<c02b84fa>] e100_open+0x106/0x188
Oct 25 18:38:12 tetrachloride kernel:  [<c02b9424>] e100intr+0x0/0x308
Oct 25 18:38:12 tetrachloride kernel:  [<c03a5080>] dev_open+0x50/0xb0
Oct 25 18:38:12 tetrachloride kernel:  [<c03a65e1>] dev_change_flags+0x51/0x104
Oct 25 18:38:12 tetrachloride kernel:  [<c03decc5>] devinet_ioctl+0x331/0x6d8
Oct 25 18:38:12 tetrachloride kernel:  [<c03e1bc7>] inet_ioctl+0xab/0xf0
Oct 25 18:38:12 tetrachloride kernel:  [<c039e6a1>] sock_ioctl+0xfd/0x160
Oct 25 18:38:12 tetrachloride kernel:  [<c0162cfb>] sys_ioctl+0x27f/0x2f5
Oct 25 18:38:12 tetrachloride kernel:  [<c0108029>] error_code+0x2d/0x38
Oct 25 18:38:12 tetrachloride kernel:  [<c01075c7>] syscall_call+0x7/0xb

Another weirdo.. Check out the Speed..

Oct 25 18:38:12 tetrachloride kernel: Intel(R) PRO/100 Network Driver - version 2.1.24-k1
Oct 25 18:38:12 tetrachloride kernel: Copyright (c) 2002 Intel Corporation
Oct 25 18:38:12 tetrachloride kernel: 
Oct 25 18:38:12 tetrachloride kernel: e100: selftest OK.
Oct 25 18:38:12 tetrachloride kernel: e100: eth0: Intel(R) PRO/100 VE Network Connection
Oct 25 18:38:12 tetrachloride kernel:   Mem:0xfeafc000  IRQ:20  Speed:0 Mbps  Dx:N/A
Oct 25 18:38:12 tetrachloride kernel:   Hardware receive checksums enabled


-- 
| Dave Jones.        http://www.codemonkey.org.uk
