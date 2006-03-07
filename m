Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbWCGW2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbWCGW2R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 17:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964792AbWCGW2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 17:28:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:10188 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964791AbWCGW2R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 17:28:17 -0500
Date: Tue, 7 Mar 2006 14:30:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org, "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Subject: Re: 2.6.16-rc5-mm3
Message-Id: <20060307143029.3149e6b6.akpm@osdl.org>
In-Reply-To: <200603072217.k27MH6IJ003533@turing-police.cc.vt.edu>
References: <20060307021929.754329c9.akpm@osdl.org>
	<200603072217.k27MH6IJ003533@turing-police.cc.vt.edu>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
>
> On Tue, 07 Mar 2006 02:19:29 PST, Andrew Morton said:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm3/
> 
> Seen during early boot from the initrd, while the initrd was firing up a
> 'lvm vgscan' to get the root filesystem accessible.. 2.6.15-rc5-mm2 didn't do this.
> Dell laptop, Pentium4, UP kernel...
> 
> [   16.959458] Freeing unused kernel memory: 176k freed
> [   16.984855] Write protecting the kernel read-only data: 998k
> [   17.044106] Time: tsc clocksource has been installed.
> [   17.600897] BUG: sleeping function called from invalid context at mm/slab.c:2751
> [   17.625891] in_atomic():1, irqs_disabled():0
> [   17.650461]  [<c0103aba>] show_trace+0xd/0xf
> [   17.674759]  [<c0103b5b>] dump_stack+0x17/0x19
> [   17.698533]  [<c010ff3c>] __might_sleep+0x86/0x90
> [   17.722149]  [<c015155a>] kmem_cache_alloc+0x27/0x82
> [   17.745520]  [<c015baf1>] bd_claim_by_kobject+0x77/0x1b1
> [   17.768657]  [<c02a55a4>] open_dev+0x54/0x72
> [   17.791983]  [<c02a5c8b>] dm_get_device+0x13f/0x336
> [   17.815254]  [<c02a656c>] linear_ctr+0x7f/0xbb
> [   17.838389]  [<c02a5996>] dm_table_add_target+0x10e/0x233
> [   17.861491]  [<c02a7c82>] table_load+0xc9/0x1a5
> [   17.884366]  [<c02a796b>] ctl_ioctl+0x208/0x246
> [   17.906866]  [<c01653f2>] do_ioctl+0x4e/0x67
> [   17.929035]  [<c0165657>] vfs_ioctl+0x24c/0x25f
> [   17.950782]  [<c01656b1>] sys_ioctl+0x47/0x62
> [   17.971931]  [<c0102707>] syscall_call+0x7/0xb
> [   18.426629] kjournald starting.  Commit interval 5 seconds
> 

Thanks.  Those patches are being redone.

Jun'ishi-san, please ensure that they're tested with CONFIG_PREEMPT and all
debug options turned on.

