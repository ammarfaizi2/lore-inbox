Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbTH3Ld4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 07:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262624AbTH3Ld4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 07:33:56 -0400
Received: from cc78409-a.hnglo1.ov.home.nl ([212.120.97.185]:53972 "EHLO
	dexter.hensema.net") by vger.kernel.org with ESMTP id S261656AbTH3Ldy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 07:33:54 -0400
From: Erik Hensema <erik@hensema.net>
Subject: First impressions of reiserfs4
Date: Sat, 30 Aug 2003 11:33:52 +0000 (UTC)
Message-ID: <slrnbl12sv.i4g.erik@bender.home.hensema.net>
Reply-To: erik@hensema.net
User-Agent: slrn/0.9.7.4 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Currently I'm testing reiserfs4 on my otherwise vanilla 2.6.0-test4
machine.

At first I tried building reiser4 as a module. The kernel failed to link
due to an unresolved symbol: sys_reiser4
I tried commenting sys_reiser4 out from entry.S. Now the kernel linked
fine.

However, I can't insert the module due to unexported symbols:

reiser4: Unknown symbol balance_dirty_pages
reiser4: Unknown symbol max_sane_readahead
reiser4: Unknown symbol generic_sync_sb_inodes
reiser4: Unknown symbol truncate_mapping_pages_range
reiser4: Unknown symbol wakeup_kswapd
reiser4: Unknown symbol balance_dirty_pages_ratelimited
reiser4: Unknown symbol inodes_stat
reiser4: Unknown symbol nr_free_pagecache_pages
reiser4: Unknown symbol destroy_inode

So, I tried linking reiser4 directly into the kernel. No problems there.

As we speak I'm building Mozilla Firebird from source of a 20 GB reiser4
partition. If something interesting comes up, this list will be the first
to know :-)

I've currently got only one small problem: df can't handle the data from
the kernel it seems. I also got this problem on NFS mounted partitions:

df: `/reiser4': Value too large for defined data type
df: `/home': Value too large for defined data type

-- 
Erik Hensema <erik@hensema.net>
