Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266134AbUGJElI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266134AbUGJElI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 00:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266136AbUGJElI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 00:41:08 -0400
Received: from main.gmane.org ([80.91.224.249]:58242 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266134AbUGJElF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 00:41:05 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joshua Kwan <joshk@triplehelix.org>
Subject: Re: 2.6.7-mm7
Date: Fri, 09 Jul 2004 21:40:59 -0700
Message-ID: <pan.2004.07.10.04.40.59.262610@triplehelix.org>
References: <20040708235025.5f8436b7.akpm@osdl.org> <pan.2004.07.10.04.34.31.166265@triplehelix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-68-126-234-108.dsl.pltn13.pacbell.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Jul 2004 21:34:31 -0700, Joshua Kwan wrote:
> I get metric tons of these in my logs:

This, too:

Debug: sleeping function called from invalid context at fs/inode.c:246
in_atomic():1, irqs_disabled():0
 [<c0105437>] dump_stack+0x17/0x20
 [<c0115744>] __might_sleep+0xb4/0xe0
 [<c0161ee5>] clear_inode+0x15/0xc0
 [<c0162da6>] generic_delete_inode+0x76/0x100
 [<c0162fd6>] iput+0x56/0x70
 [<c01604d8>] prune_dcache+0x168/0x1e0
 [<c01608f6>] shrink_dcache_parent+0x16/0x20
 [<c017405f>] proc_pid_flush+0xf/0x20
 [<c0118add>] release_task+0x13d/0x1d0
 [<c011986a>] exit_notify+0x34a/0x7b0
 [<c0119ef0>] do_exit+0x220/0x420
 [<c011a193>] do_group_exit+0x33/0xa0
 [<c0104edf>] syscall_call+0x7/0xb

FYI, in this case, I removed the might_sleep call from proc_pid_flush so
I could save on hard disk usage.

-- 
Joshua Kwan


