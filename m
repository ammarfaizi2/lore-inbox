Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965107AbVIOGaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965107AbVIOGaX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 02:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbVIOGaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 02:30:23 -0400
Received: from mail.rentalia.com ([213.192.209.14]:47850 "EHLO
	mail.rentalia.net") by vger.kernel.org with ESMTP id S932527AbVIOGaW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 02:30:22 -0400
X-Antivirus-MYDOMAIN-Mail-From: ruben@rentalia.com via txori
X-Antivirus-MYDOMAIN: 1.25-st-qms (Clear:RC:0(62.37.217.64):SA:0(-2.2/5.0):. Processed in 4.602969 secs Process 17783)
Message-ID: <432914F1.4090001@rentalia.com>
Date: Thu, 15 Sep 2005 08:30:09 +0200
From: Ruben Rubio Rey <ruben@rentalia.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050912)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Question about page allocation failure
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Im getting an error: "perl5.8.5: page allocation failure. order:4, 
mode:0x50".

What does it means?
Is it dangerous?
What may I do to fix it?

Im using kernel 2.6.9-1.667smp and XFS filesystem.

Thanks in advance.

Complete error:

Sep 13 08:39:34 txori kernel: perl5.8.5: page allocation failure. 
order:4, mode:0x50
Sep 13 08:39:34 txori kernel:  [<0213d396>] __alloc_pages+0x28b/0x298
Sep 13 08:39:34 txori kernel:  [<0213d3bb>] __get_free_pages+0x18/0x24
Sep 13 08:39:34 txori kernel:  [<0213fc88>] kmem_getpages+0x1c/0xbb
Sep 13 08:39:34 txori kernel:  [<021407d9>] cache_grow+0xae/0x136
Sep 13 08:39:34 txori kernel:  [<021409c6>] cache_alloc_refill+0x165/0x19d
Sep 13 08:39:34 txori kernel:  [<02140d9d>] __kmalloc+0x76/0x88
Sep 13 08:39:34 txori kernel:  [<8293ee20>] kmem_alloc+0x50/0x9e [xfs]
Sep 13 08:39:34 txori kernel:  [<8293eef0>] kmem_realloc+0x17/0x52 [xfs]
Sep 13 08:39:34 txori kernel:  [<82924188>] xfs_iext_realloc+0xc9/0xdc [xfs]
Sep 13 08:39:34 txori kernel:  [<82901912>] 
xfs_bmap_insert_exlist+0x22/0x77 [xfs]
Sep 13 08:39:34 txori kernel:  [<828fed42>] 
xfs_bmap_add_extent_hole_delay+0x438/0x48e [xfs]
Sep 13 08:39:34 txori kernel:  [<828fc7b4>] 
xfs_bmap_add_extent+0x146/0x399 [xfs]
Sep 13 08:39:34 txori kernel:  [<829039bc>] xfs_bmapi+0xb00/0x12bf [xfs]
Sep 13 08:39:34 txori kernel:  [<829031e2>] xfs_bmapi+0x326/0x12bf [xfs]
Sep 13 08:39:34 txori kernel:  [<021398ef>] wake_up_page+0x9/0x29
Sep 13 08:39:34 txori kernel:  [<82926bdf>] 
xfs_iomap_write_delay+0x628/0x702 [xfs]
Sep 13 08:39:34 txori kernel:  [<8292ad03>] 
xlog_state_get_iclog_space+0x163/0x172 [xfs]
Sep 13 08:39:34 txori kernel:  [<82925b32>] xfs_imap_to_bmap+0x2a/0x28a 
[xfs]
Sep 13 08:39:34 txori kernel:  [<82925fcc>] xfs_iomap+0x23a/0x3ec [xfs]
Sep 13 08:39:34 txori kernel:  [<82926076>] xfs_iomap+0x2e4/0x3ec [xfs]
Sep 13 08:39:34 txori kernel:  [<82945e39>] xfs_bmap+0x1a/0x1e [xfs]
Sep 13 08:39:34 txori kernel:  [<8294005f>] 
linvfs_get_block_core+0x6b/0x257 [xfs]
Sep 13 08:39:34 txori kernel:  [<02139c3f>] find_or_create_page+0x18/0x72
Sep 13 08:39:34 txori kernel:  [<022b7b17>] __cond_resched+0x14/0x39
Sep 13 08:39:34 txori kernel:  [<02156002>] set_bh_page+0x2c/0x34
Sep 13 08:39:34 txori kernel:  [<8294025e>] linvfs_get_block+0x13/0x17 [xfs]
Sep 13 08:39:34 txori kernel:  [<0215664f>] 
__block_prepare_write+0x15d/0x3e4
Sep 13 08:39:35 txori kernel:  [<02156f61>] block_prepare_write+0x16/0x23
Sep 13 08:39:35 txori kernel:  [<8294024b>] linvfs_get_block+0x0/0x17 [xfs]
Sep 13 08:39:35 txori kernel:  [<82940578>] 
linvfs_prepare_write+0x12/0x16 [xfs]
Sep 13 08:39:35 txori kernel:  [<8294024b>] linvfs_get_block+0x0/0x17 [xfs]
Sep 13 08:39:35 txori kernel:  [<0213b3c8>] 
generic_file_buffered_write+0x1b5/0x4ae
Sep 13 08:39:35 txori kernel:  [<8290e4ed>] xfs_da_brelse+0x73/0x92 [xfs]
Sep 13 08:39:35 txori kernel:  [<828f7400>] xfs_attr_leaf_get+0x4b/0x82 
[xfs]
Sep 13 08:39:35 txori kernel:  [<82945a87>] xfs_write+0x622/0x982 [xfs]
Sep 13 08:39:35 txori kernel:  [<8294230d>] linvfs_write+0x6f/0x77 [xfs]
Sep 13 08:39:35 txori kernel:  [<02153d7b>] do_sync_write+0x97/0xc9
Sep 13 08:39:35 txori kernel:  [<8293a4d9>] 
xfs_inactive_free_eofblocks+0xd2/0x210 [xfs]
Sep 13 08:39:35 txori kernel:  [<0211deca>] 
autoremove_wake_function+0x0/0x2d
Sep 13 08:39:35 txori kernel:  [<02153e63>] vfs_write+0xb6/0xe2
Sep 13 08:39:35 txori kernel:  [<02153f2d>] sys_write+0x3c/0x62
Sep 13 08:39:35 txori kernel: perl5.8.5: page allocation failure. 
order:4, mode:0x50
Sep 13 08:39:35 txori kernel:  [<0213d396>] __alloc_pages+0x28b/0x298
Sep 13 08:39:35 txori kernel:  [<0213d3bb>] __get_free_pages+0x18/0x24
Sep 13 08:39:35 txori kernel:  [<0213fc88>] kmem_getpages+0x1c/0xbb
Sep 13 08:39:35 txori kernel:  [<021407d9>] cache_grow+0xae/0x136
Sep 13 08:39:35 txori kernel:  [<021409c6>] cache_alloc_refill+0x165/0x19d
Sep 13 08:39:35 txori kernel:  [<02140d9d>] __kmalloc+0x76/0x88
Sep 13 08:39:35 txori kernel:  [<8293ee20>] kmem_alloc+0x50/0x9e [xfs]
Sep 13 08:39:35 txori kernel:  [<8293eef0>] kmem_realloc+0x17/0x52 [xfs]
Sep 13 08:39:35 txori kernel:  [<82924188>] xfs_iext_realloc+0xc9/0xdc [xfs]
Sep 13 08:39:35 txori kernel:  [<82901912>] 
xfs_bmap_insert_exlist+0x22/0x77 [xfs]
Sep 13 08:39:35 txori kernel:  [<828fed42>] 
xfs_bmap_add_extent_hole_delay+0x438/0x48e [xfs]
Sep 13 08:39:35 txori kernel:  [<828fc7b4>] 
xfs_bmap_add_extent+0x146/0x399 [xfs]
Sep 13 08:39:35 txori kernel:  [<829039bc>] xfs_bmapi+0xb00/0x12bf [xfs]
Sep 13 08:39:35 txori kernel:  [<829031e2>] xfs_bmapi+0x326/0x12bf [xfs]
Sep 13 08:39:35 txori kernel:  [<021398ef>] wake_up_page+0x9/0x29
Sep 13 08:39:35 txori kernel:  [<82926bdf>] 
xfs_iomap_write_delay+0x628/0x702 [xfs]
Sep 13 08:39:35 txori kernel:  [<8292ad03>] 
xlog_state_get_iclog_space+0x163/0x172 [xfs]
Sep 13 08:39:35 txori kernel:  [<82925b32>] xfs_imap_to_bmap+0x2a/0x28a 
[xfs]
Sep 13 08:39:35 txori kernel:  [<82925fcc>] xfs_iomap+0x23a/0x3ec [xfs]
Sep 13 08:39:35 txori kernel:  [<82926076>] xfs_iomap+0x2e4/0x3ec [xfs]
Sep 13 08:39:35 txori kernel:  [<82945e39>] xfs_bmap+0x1a/0x1e [xfs]
Sep 13 08:39:35 txori kernel:  [<8294005f>] 
linvfs_get_block_core+0x6b/0x257 [xfs]
Sep 13 08:39:35 txori kernel:  [<02139c3f>] find_or_create_page+0x18/0x72
Sep 13 08:39:35 txori kernel:  [<022b7b17>] __cond_resched+0x14/0x39
Sep 13 08:39:35 txori kernel:  [<02156002>] set_bh_page+0x2c/0x34
Sep 13 08:39:35 txori kernel:  [<8294025e>] linvfs_get_block+0x13/0x17 [xfs]
Sep 13 08:39:35 txori kernel:  [<0215664f>] 
__block_prepare_write+0x15d/0x3e4
Sep 13 08:39:35 txori kernel:  [<02156f61>] block_prepare_write+0x16/0x23
Sep 13 08:39:35 txori kernel:  [<8294024b>] linvfs_get_block+0x0/0x17 [xfs]
Sep 13 08:39:35 txori kernel:  [<82940578>] 
linvfs_prepare_write+0x12/0x16 [xfs]
Sep 13 08:39:35 txori kernel:  [<8294024b>] linvfs_get_block+0x0/0x17 [xfs]
Sep 13 08:39:35 txori kernel:  [<0213b3c8>] 
generic_file_buffered_write+0x1b5/0x4ae
Sep 13 08:39:36 txori kernel:  [<8290e4ed>] xfs_da_brelse+0x73/0x92 [xfs]
Sep 13 08:39:36 txori kernel:  [<828f7400>] xfs_attr_leaf_get+0x4b/0x82 
[xfs]
Sep 13 08:39:36 txori kernel:  [<82945a87>] xfs_write+0x622/0x982 [xfs]
Sep 13 08:39:36 txori kernel:  [<8294230d>] linvfs_write+0x6f/0x77 [xfs]
Sep 13 08:39:36 txori kernel:  [<02153d7b>] do_sync_write+0x97/0xc9
Sep 13 08:39:36 txori kernel:  [<8293a4d9>] 
xfs_inactive_free_eofblocks+0xd2/0x210 [xfs]
Sep 13 08:39:36 txori kernel:  [<0211deca>] 
autoremove_wake_function+0x0/0x2d
Sep 13 08:39:36 txori kernel:  [<02153e63>] vfs_write+0xb6/0xe2
Sep 13 08:39:36 txori kernel:  [<02153f2d>] sys_write+0x3c/0x62
Sep 13 08:39:36 txori kernel: perl5.8.5: page allocation failure. 
order:4, mode:0x50
Sep 13 08:39:36 txori kernel:  [<0213d396>] __alloc_pages+0x28b/0x298
Sep 13 08:39:36 txori kernel:  [<0213d3bb>] __get_free_pages+0x18/0x24
Sep 13 08:39:36 txori kernel:  [<0213fc88>] kmem_getpages+0x1c/0xbb
Sep 13 08:39:36 txori kernel:  [<021407d9>] cache_grow+0xae/0x136
Sep 13 08:39:36 txori kernel:  [<021409c6>] cache_alloc_refill+0x165/0x19d
Sep 13 08:39:36 txori kernel:  [<02140d9d>] __kmalloc+0x76/0x88
Sep 13 08:39:36 txori kernel:  [<8293ee20>] kmem_alloc+0x50/0x9e [xfs]
Sep 13 08:39:36 txori kernel:  [<8293eef0>] kmem_realloc+0x17/0x52 [xfs]
Sep 13 08:39:36 txori kernel:  [<82924188>] xfs_iext_realloc+0xc9/0xdc [xfs]
Sep 13 08:39:36 txori kernel:  [<82901912>] 
xfs_bmap_insert_exlist+0x22/0x77 [xfs]
Sep 13 08:39:36 txori kernel:  [<828fed42>] 
xfs_bmap_add_extent_hole_delay+0x438/0x48e [xfs]
Sep 13 08:39:36 txori kernel:  [<828fc7b4>] 
xfs_bmap_add_extent+0x146/0x399 [xfs]
Sep 13 08:39:36 txori kernel:  [<829039bc>] xfs_bmapi+0xb00/0x12bf [xfs]
Sep 13 08:39:36 txori kernel:  [<829031e2>] xfs_bmapi+0x326/0x12bf [xfs]
Sep 13 08:39:36 txori kernel:  [<021398ef>] wake_up_page+0x9/0x29
Sep 13 08:39:36 txori kernel:  [<82926bdf>] 
xfs_iomap_write_delay+0x628/0x702 [xfs]
Sep 13 08:39:36 txori kernel:  [<8292ad03>] 
xlog_state_get_iclog_space+0x163/0x172 [xfs]
Sep 13 08:39:36 txori kernel:  [<82925b32>] xfs_imap_to_bmap+0x2a/0x28a 
[xfs]
Sep 13 08:39:36 txori kernel:  [<82925fcc>] xfs_iomap+0x23a/0x3ec [xfs]
Sep 13 08:39:36 txori kernel:  [<82926076>] xfs_iomap+0x2e4/0x3ec [xfs]
Sep 13 08:39:36 txori kernel:  [<82945e39>] xfs_bmap+0x1a/0x1e [xfs]
Sep 13 08:39:36 txori kernel:  [<8294005f>] 
linvfs_get_block_core+0x6b/0x257 [xfs]
Sep 13 08:39:36 txori kernel:  [<02139c3f>] find_or_create_page+0x18/0x72
Sep 13 08:39:36 txori kernel:  [<022b7b17>] __cond_resched+0x14/0x39
Sep 13 08:39:36 txori kernel:  [<02156002>] set_bh_page+0x2c/0x34
Sep 13 08:39:36 txori kernel:  [<8294025e>] linvfs_get_block+0x13/0x17 [xfs]
Sep 13 08:39:36 txori kernel:  [<0215664f>] 
__block_prepare_write+0x15d/0x3e4
Sep 13 08:39:36 txori kernel:  [<02156f61>] block_prepare_write+0x16/0x23
Sep 13 08:39:36 txori kernel:  [<8294024b>] linvfs_get_block+0x0/0x17 [xfs]
Sep 13 08:39:36 txori kernel:  [<82940578>] 
linvfs_prepare_write+0x12/0x16 [xfs]
Sep 13 08:39:36 txori kernel:  [<8294024b>] linvfs_get_block+0x0/0x17 [xfs]
Sep 13 08:39:36 txori kernel:  [<0213b3c8>] 
generic_file_buffered_write+0x1b5/0x4ae
Sep 13 08:39:36 txori kernel:  [<8290e4ed>] xfs_da_brelse+0x73/0x92 [xfs]
Sep 13 08:39:36 txori kernel:  [<828f7400>] xfs_attr_leaf_get+0x4b/0x82 
[xfs]
Sep 13 08:39:36 txori kernel:  [<82945a87>] xfs_write+0x622/0x982 [xfs]
Sep 13 08:39:36 txori kernel:  [<8294230d>] linvfs_write+0x6f/0x77 [xfs]
Sep 13 08:39:36 txori kernel:  [<02153d7b>] do_sync_write+0x97/0xc9
Sep 13 08:39:36 txori kernel:  [<8293a4d9>] 
xfs_inactive_free_eofblocks+0xd2/0x210 [xfs]
Sep 13 08:39:36 txori kernel:  [<0211deca>] 
autoremove_wake_function+0x0/0x2d
Sep 13 08:39:36 txori kernel:  [<02153e63>] vfs_write+0xb6/0xe2
Sep 13 08:39:36 txori kernel:  [<02153f2d>] sys_write+0x3c/0x62
Sep 13 08:39:36 txori kernel: perl5.8.5: page allocation failure. 
order:4, mode:0x50
Sep 13 08:39:36 txori kernel:  [<0213d396>] __alloc_pages+0x28b/0x298
Sep 13 08:39:36 txori kernel:  [<0213d3bb>] __get_free_pages+0x18/0x24
Sep 13 08:39:36 txori kernel:  [<0213fc88>] kmem_getpages+0x1c/0xbb
Sep 13 08:39:36 txori kernel:  [<021407d9>] cache_grow+0xae/0x136
Sep 13 08:39:36 txori kernel:  [<021409c6>] cache_alloc_refill+0x165/0x19d
Sep 13 08:39:36 txori kernel:  [<02140d9d>] __kmalloc+0x76/0x88
Sep 13 08:39:36 txori kernel:  [<8293ee20>] kmem_alloc+0x50/0x9e [xfs]
Sep 13 08:39:37 txori kernel:  [<8293eef0>] kmem_realloc+0x17/0x52 [xfs]
Sep 13 08:39:37 txori kernel:  [<82924188>] xfs_iext_realloc+0xc9/0xdc [xfs]
Sep 13 08:39:37 txori kernel:  [<82901912>] 
xfs_bmap_insert_exlist+0x22/0x77 [xfs]
Sep 13 08:39:37 txori kernel:  [<828fed42>] 
xfs_bmap_add_extent_hole_delay+0x438/0x48e [xfs]
Sep 13 08:39:37 txori kernel:  [<828fc7b4>] 
xfs_bmap_add_extent+0x146/0x399 [xfs]
Sep 13 08:39:37 txori kernel:  [<829039bc>] xfs_bmapi+0xb00/0x12bf [xfs]
Sep 13 08:39:37 txori kernel:  [<829031e2>] xfs_bmapi+0x326/0x12bf [xfs]
Sep 13 08:39:37 txori kernel:  [<021398ef>] wake_up_page+0x9/0x29
Sep 13 08:39:37 txori kernel:  [<82926bdf>] 
xfs_iomap_write_delay+0x628/0x702 [xfs]
Sep 13 08:39:37 txori kernel:  [<8292ad03>] 
xlog_state_get_iclog_space+0x163/0x172 [xfs]
Sep 13 08:39:37 txori kernel:  [<82925b32>] xfs_imap_to_bmap+0x2a/0x28a 
[xfs]
Sep 13 08:39:37 txori kernel:  [<82925fcc>] xfs_iomap+0x23a/0x3ec [xfs]
Sep 13 08:39:37 txori kernel:  [<82926076>] xfs_iomap+0x2e4/0x3ec [xfs]
Sep 13 08:39:37 txori kernel:  [<82945e39>] xfs_bmap+0x1a/0x1e [xfs]
Sep 13 08:39:37 txori kernel:  [<8294005f>] 
linvfs_get_block_core+0x6b/0x257 [xfs]
Sep 13 08:39:37 txori kernel:  [<02139c3f>] find_or_create_page+0x18/0x72
Sep 13 08:39:37 txori kernel:  [<022b7b17>] __cond_resched+0x14/0x39
Sep 13 08:39:37 txori kernel:  [<02156002>] set_bh_page+0x2c/0x34
Sep 13 08:39:37 txori kernel:  [<8294025e>] linvfs_get_block+0x13/0x17 [xfs]
Sep 13 08:39:37 txori kernel:  [<0215664f>] 
__block_prepare_write+0x15d/0x3e4
Sep 13 08:39:37 txori kernel:  [<02156f61>] block_prepare_write+0x16/0x23
Sep 13 08:39:37 txori kernel:  [<8294024b>] linvfs_get_block+0x0/0x17 [xfs]
Sep 13 08:39:37 txori kernel:  [<82940578>] 
linvfs_prepare_write+0x12/0x16 [xfs]
Sep 13 08:39:37 txori kernel:  [<8294024b>] linvfs_get_block+0x0/0x17 [xfs]
Sep 13 08:39:37 txori kernel:  [<0213b3c8>] 
generic_file_buffered_write+0x1b5/0x4ae
Sep 13 08:39:37 txori kernel:  [<8290e4ed>] xfs_da_brelse+0x73/0x92 [xfs]
Sep 13 08:39:37 txori kernel:  [<828f7400>] xfs_attr_leaf_get+0x4b/0x82 
[xfs]
Sep 13 08:39:37 txori kernel:  [<82945a87>] xfs_write+0x622/0x982 [xfs]
Sep 13 08:39:37 txori kernel:  [<8294230d>] linvfs_write+0x6f/0x77 [xfs]
Sep 13 08:39:37 txori kernel:  [<02153d7b>] do_sync_write+0x97/0xc9
Sep 13 08:39:37 txori kernel:  [<8293a4d9>] 
xfs_inactive_free_eofblocks+0xd2/0x210 [xfs]
Sep 13 08:39:37 txori kernel:  [<0211deca>] 
autoremove_wake_function+0x0/0x2d
Sep 13 08:39:37 txori kernel:  [<02153e63>] vfs_write+0xb6/0xe2
Sep 13 08:39:37 txori kernel:  [<02153f2d>] sys_write+0x3c/0x62
Sep 13 08:39:37 txori kernel: perl5.8.5: page allocation failure. 
order:4, mode:0x50
Sep 13 08:39:37 txori kernel:  [<0213d396>] __alloc_pages+0x28b/0x298
Sep 13 08:39:37 txori kernel:  [<0213d3bb>] __get_free_pages+0x18/0x24
Sep 13 08:39:37 txori kernel:  [<0213fc88>] kmem_getpages+0x1c/0xbb
Sep 13 08:39:37 txori kernel:  [<021407d9>] cache_grow+0xae/0x136
Sep 13 08:39:37 txori kernel:  [<021409c6>] cache_alloc_refill+0x165/0x19d
Sep 13 08:39:37 txori kernel:  [<02140d9d>] __kmalloc+0x76/0x88
Sep 13 08:39:37 txori kernel:  [<8293ee20>] kmem_alloc+0x50/0x9e [xfs]
Sep 13 08:39:37 txori kernel:  [<8293eef0>] kmem_realloc+0x17/0x52 [xfs]
Sep 13 08:39:37 txori kernel:  [<82924188>] xfs_iext_realloc+0xc9/0xdc [xfs]
Sep 13 08:39:37 txori kernel:  [<82901912>] 
xfs_bmap_insert_exlist+0x22/0x77 [xfs]
Sep 13 08:39:37 txori kernel:  [<828fed42>] 
xfs_bmap_add_extent_hole_delay+0x438/0x48e [xfs]
Sep 13 08:39:37 txori kernel:  [<828fc7b4>] 
xfs_bmap_add_extent+0x146/0x399 [xfs]
Sep 13 08:39:37 txori kernel:  [<829039bc>] xfs_bmapi+0xb00/0x12bf [xfs]
Sep 13 08:39:37 txori kernel:  [<829031e2>] xfs_bmapi+0x326/0x12bf [xfs]
Sep 13 08:39:37 txori kernel:  [<021398ef>] wake_up_page+0x9/0x29
Sep 13 08:39:37 txori kernel:  [<82926bdf>] 
xfs_iomap_write_delay+0x628/0x702 [xfs]
Sep 13 08:39:37 txori kernel:  [<8292ad03>] 
xlog_state_get_iclog_space+0x163/0x172 [xfs]
Sep 13 08:39:37 txori kernel:  [<82925b32>] xfs_imap_to_bmap+0x2a/0x28a 
[xfs]
Sep 13 08:39:37 txori kernel:  [<82925fcc>] xfs_iomap+0x23a/0x3ec [xfs]
Sep 13 08:39:37 txori kernel:  [<82926076>] xfs_iomap+0x2e4/0x3ec [xfs]
Sep 13 08:39:37 txori kernel:  [<82945e39>] xfs_bmap+0x1a/0x1e [xfs]
Sep 13 08:39:37 txori kernel:  [<8294005f>] 
linvfs_get_block_core+0x6b/0x257 [xfs]
Sep 13 08:39:37 txori kernel:  [<02139c3f>] find_or_create_page+0x18/0x72
Sep 13 08:39:37 txori kernel:  [<022b7b17>] __cond_resched+0x14/0x39
Sep 13 08:39:37 txori kernel:  [<02156002>] set_bh_page+0x2c/0x34
Sep 13 08:39:37 txori kernel:  [<8294025e>] linvfs_get_block+0x13/0x17 [xfs]
Sep 13 08:39:37 txori kernel:  [<0215664f>] 
__block_prepare_write+0x15d/0x3e4
Sep 13 08:39:37 txori kernel:  [<02156f61>] block_prepare_write+0x16/0x23
Sep 13 08:39:38 txori kernel:  [<8294024b>] linvfs_get_block+0x0/0x17 [xfs]
Sep 13 08:39:38 txori kernel:  [<82940578>] 
linvfs_prepare_write+0x12/0x16 [xfs]
Sep 13 08:39:38 txori kernel:  [<8294024b>] linvfs_get_block+0x0/0x17 [xfs]
Sep 13 08:39:38 txori kernel:  [<0213b3c8>] 
generic_file_buffered_write+0x1b5/0x4ae
Sep 13 08:39:38 txori kernel:  [<8290e4ed>] xfs_da_brelse+0x73/0x92 [xfs]
Sep 13 08:39:38 txori kernel:  [<828f7400>] xfs_attr_leaf_get+0x4b/0x82 
[xfs]
Sep 13 08:39:38 txori kernel:  [<82945a87>] xfs_write+0x622/0x982 [xfs]
Sep 13 08:39:38 txori kernel:  [<8294230d>] linvfs_write+0x6f/0x77 [xfs]
Sep 13 08:39:38 txori kernel:  [<02153d7b>] do_sync_write+0x97/0xc9
Sep 13 08:39:38 txori kernel:  [<8293a4d9>] 
xfs_inactive_free_eofblocks+0xd2/0x210 [xfs]
Sep 13 08:39:38 txori kernel:  [<0211deca>] 
autoremove_wake_function+0x0/0x2d
Sep 13 08:39:38 txori kernel:  [<02153e63>] vfs_write+0xb6/0xe2
Sep 13 08:39:38 txori kernel:  [<02153f2d>] sys_write+0x3c/0x62
Sep 13 08:39:38 txori kernel: perl5.8.5: page allocation failure. 
order:4, mode:0x50
Sep 13 08:39:38 txori kernel:  [<0213d396>] __alloc_pages+0x28b/0x298
Sep 13 08:39:38 txori kernel:  [<0213d3bb>] __get_free_pages+0x18/0x24
Sep 13 08:39:38 txori kernel:  [<0213fc88>] kmem_getpages+0x1c/0xbb
Sep 13 08:39:38 txori kernel:  [<021407d9>] cache_grow+0xae/0x136
Sep 13 08:39:38 txori kernel:  [<021409c6>] cache_alloc_refill+0x165/0x19d
Sep 13 08:39:38 txori kernel:  [<02140d9d>] __kmalloc+0x76/0x88
Sep 13 08:39:38 txori kernel:  [<8293ee20>] kmem_alloc+0x50/0x9e [xfs]
Sep 13 08:39:38 txori kernel:  [<8293eef0>] kmem_realloc+0x17/0x52 [xfs]
Sep 13 08:39:38 txori kernel:  [<82924188>] xfs_iext_realloc+0xc9/0xdc [xfs]
Sep 13 08:39:38 txori kernel:  [<82901912>] 
xfs_bmap_insert_exlist+0x22/0x77 [xfs]
Sep 13 08:39:38 txori kernel:  [<828fed42>] 
xfs_bmap_add_extent_hole_delay+0x438/0x48e [xfs]
Sep 13 08:39:38 txori kernel:  [<828fc7b4>] 
xfs_bmap_add_extent+0x146/0x399 [xfs]
Sep 13 08:39:38 txori kernel:  [<829039bc>] xfs_bmapi+0xb00/0x12bf [xfs]
Sep 13 08:39:38 txori kernel:  [<829031e2>] xfs_bmapi+0x326/0x12bf [xfs]
Sep 13 08:39:38 txori kernel:  [<021398ef>] wake_up_page+0x9/0x29
Sep 13 08:39:38 txori kernel:  [<82926bdf>] 
xfs_iomap_write_delay+0x628/0x702 [xfs]
Sep 13 08:39:38 txori kernel:  [<8292ad03>] 
xlog_state_get_iclog_space+0x163/0x172 [xfs]
Sep 13 08:39:38 txori kernel:  [<82925b32>] xfs_imap_to_bmap+0x2a/0x28a 
[xfs]
Sep 13 08:39:38 txori kernel:  [<82925fcc>] xfs_iomap+0x23a/0x3ec [xfs]
Sep 13 08:39:38 txori kernel:  [<82926076>] xfs_iomap+0x2e4/0x3ec [xfs]
Sep 13 08:39:38 txori kernel:  [<82945e39>] xfs_bmap+0x1a/0x1e [xfs]
Sep 13 08:39:38 txori kernel:  [<8294005f>] 
linvfs_get_block_core+0x6b/0x257 [xfs]
Sep 13 08:39:38 txori kernel:  [<02139c3f>] find_or_create_page+0x18/0x72
Sep 13 08:39:38 txori kernel:  [<022b7b17>] __cond_resched+0x14/0x39
Sep 13 08:39:38 txori kernel:  [<02156002>] set_bh_page+0x2c/0x34
Sep 13 08:39:38 txori kernel:  [<8294025e>] linvfs_get_block+0x13/0x17 [xfs]
Sep 13 08:39:38 txori kernel:  [<0215664f>] 
__block_prepare_write+0x15d/0x3e4
Sep 13 08:39:38 txori kernel:  [<02156f61>] block_prepare_write+0x16/0x23
Sep 13 08:39:38 txori kernel:  [<8294024b>] linvfs_get_block+0x0/0x17 [xfs]
Sep 13 08:39:38 txori kernel:  [<82940578>] 
linvfs_prepare_write+0x12/0x16 [xfs]
Sep 13 08:39:38 txori kernel:  [<8294024b>] linvfs_get_block+0x0/0x17 [xfs]
Sep 13 08:39:38 txori kernel:  [<0213b3c8>] 
generic_file_buffered_write+0x1b5/0x4ae
Sep 13 08:39:38 txori kernel:  [<8290e4ed>] xfs_da_brelse+0x73/0x92 [xfs]
Sep 13 08:39:38 txori kernel:  [<828f7400>] xfs_attr_leaf_get+0x4b/0x82 
[xfs]
Sep 13 08:39:38 txori kernel:  [<82945a87>] xfs_write+0x622/0x982 [xfs]
Sep 13 08:39:38 txori kernel:  [<8294230d>] linvfs_write+0x6f/0x77 [xfs]
Sep 13 08:39:38 txori kernel:  [<02153d7b>] do_sync_write+0x97/0xc9
Sep 13 08:39:38 txori kernel:  [<8293a4d9>] 
xfs_inactive_free_eofblocks+0xd2/0x210 [xfs]
Sep 13 08:39:38 txori kernel:  [<0211deca>] 
autoremove_wake_function+0x0/0x2d
Sep 13 08:39:38 txori kernel:  [<02153e63>] vfs_write+0xb6/0xe2
Sep 13 08:39:38 txori kernel:  [<02153f2d>] sys_write+0x3c/0x62
Sep 13 08:39:38 txori kernel: perl5.8.5: page allocation failure. 
order:4, mode:0x50
Sep 13 08:39:38 txori kernel:  [<0213d396>] __alloc_pages+0x28b/0x298
Sep 13 08:39:38 txori kernel:  [<0213d3bb>] __get_free_pages+0x18/0x24
Sep 13 08:39:38 txori kernel:  [<0213fc88>] kmem_getpages+0x1c/0xbb
Sep 13 08:39:38 txori kernel:  [<021407d9>] cache_grow+0xae/0x136
Sep 13 08:39:38 txori kernel:  [<021409c6>] cache_alloc_refill+0x165/0x19d
Sep 13 08:39:38 txori kernel:  [<02140d9d>] __kmalloc+0x76/0x88
Sep 13 08:39:39 txori kernel:  [<8293ee20>] kmem_alloc+0x50/0x9e [xfs]
Sep 13 08:39:39 txori kernel:  [<8293eef0>] kmem_realloc+0x17/0x52 [xfs]
Sep 13 08:39:39 txori kernel:  [<82924188>] xfs_iext_realloc+0xc9/0xdc [xfs]
Sep 13 08:39:39 txori kernel:  [<82901912>] 
xfs_bmap_insert_exlist+0x22/0x77 [xfs]
Sep 13 08:39:39 txori kernel:  [<828fed42>] 
xfs_bmap_add_extent_hole_delay+0x438/0x48e [xfs]
Sep 13 08:39:39 txori kernel:  [<828fc7b4>] 
xfs_bmap_add_extent+0x146/0x399 [xfs]
Sep 13 08:39:39 txori kernel:  [<829039bc>] xfs_bmapi+0xb00/0x12bf [xfs]
Sep 13 08:39:39 txori kernel:  [<829031e2>] xfs_bmapi+0x326/0x12bf [xfs]
Sep 13 08:39:39 txori kernel:  [<021398ef>] wake_up_page+0x9/0x29
Sep 13 08:39:39 txori kernel:  [<82926bdf>] 
xfs_iomap_write_delay+0x628/0x702 [xfs]
Sep 13 08:39:39 txori kernel:  [<8292ad03>] 
xlog_state_get_iclog_space+0x163/0x172 [xfs]
Sep 13 08:39:39 txori kernel:  [<82925b32>] xfs_imap_to_bmap+0x2a/0x28a 
[xfs]
Sep 13 08:39:39 txori kernel:  [<82925fcc>] xfs_iomap+0x23a/0x3ec [xfs]
Sep 13 08:39:39 txori kernel:  [<82926076>] xfs_iomap+0x2e4/0x3ec [xfs]
Sep 13 08:39:39 txori kernel:  [<82945e39>] xfs_bmap+0x1a/0x1e [xfs]
Sep 13 08:39:39 txori kernel:  [<8294005f>] 
linvfs_get_block_core+0x6b/0x257 [xfs]
Sep 13 08:39:39 txori kernel:  [<02139c3f>] find_or_create_page+0x18/0x72
Sep 13 08:39:39 txori kernel:  [<022b7b17>] __cond_resched+0x14/0x39
Sep 13 08:39:39 txori kernel:  [<02156002>] set_bh_page+0x2c/0x34
Sep 13 08:39:39 txori kernel:  [<8294025e>] linvfs_get_block+0x13/0x17 [xfs]
Sep 13 08:39:39 txori kernel:  [<0215664f>] 
__block_prepare_write+0x15d/0x3e4
Sep 13 08:39:39 txori kernel:  [<02156f61>] block_prepare_write+0x16/0x23
Sep 13 08:39:39 txori kernel:  [<8294024b>] linvfs_get_block+0x0/0x17 [xfs]
Sep 13 08:39:39 txori kernel:  [<82940578>] 
linvfs_prepare_write+0x12/0x16 [xfs]
Sep 13 08:39:39 txori kernel:  [<8294024b>] linvfs_get_block+0x0/0x17 [xfs]
Sep 13 08:39:39 txori kernel:  [<0213b3c8>] 
generic_file_buffered_write+0x1b5/0x4ae
Sep 13 08:39:39 txori kernel:  [<8290e4ed>] xfs_da_brelse+0x73/0x92 [xfs]
Sep 13 08:39:39 txori kernel:  [<828f7400>] xfs_attr_leaf_get+0x4b/0x82 
[xfs]
Sep 13 08:39:39 txori kernel:  [<82945a87>] xfs_write+0x622/0x982 [xfs]
Sep 13 08:39:39 txori kernel:  [<8294230d>] linvfs_write+0x6f/0x77 [xfs]
Sep 13 08:39:39 txori kernel:  [<02153d7b>] do_sync_write+0x97/0xc9
Sep 13 08:39:39 txori kernel:  [<8293a4d9>] 
xfs_inactive_free_eofblocks+0xd2/0x210 [xfs]
Sep 13 08:39:39 txori kernel:  [<0211deca>] 
autoremove_wake_function+0x0/0x2d
Sep 13 08:39:39 txori kernel:  [<02153e63>] vfs_write+0xb6/0xe2
Sep 13 08:39:39 txori kernel:  [<02153f2d>] sys_write+0x3c/0x62
Sep 13 08:39:39 txori kernel: perl5.8.5: page allocation failure. 
order:4, mode:0x50
Sep 13 08:39:39 txori kernel:  [<0213d396>] __alloc_pages+0x28b/0x298
Sep 13 08:39:39 txori kernel:  [<0213d3bb>] __get_free_pages+0x18/0x24
Sep 13 08:39:39 txori kernel:  [<0213fc88>] kmem_getpages+0x1c/0xbb
Sep 13 08:39:39 txori kernel:  [<021407d9>] cache_grow+0xae/0x136
Sep 13 08:39:39 txori kernel:  [<021409c6>] cache_alloc_refill+0x165/0x19d
Sep 13 08:39:39 txori kernel:  [<02140d9d>] __kmalloc+0x76/0x88
Sep 13 08:39:39 txori kernel:  [<8293ee20>] kmem_alloc+0x50/0x9e [xfs]
Sep 13 08:39:39 txori kernel:  [<8293eef0>] kmem_realloc+0x17/0x52 [xfs]
Sep 13 08:39:39 txori kernel:  [<82924188>] xfs_iext_realloc+0xc9/0xdc [xfs]
Sep 13 08:39:39 txori kernel:  [<82901912>] 
xfs_bmap_insert_exlist+0x22/0x77 [xfs]
Sep 13 08:39:39 txori kernel:  [<828fed42>] 
xfs_bmap_add_extent_hole_delay+0x438/0x48e [xfs]
Sep 13 08:39:39 txori kernel:  [<828fc7b4>] 
xfs_bmap_add_extent+0x146/0x399 [xfs]
Sep 13 08:39:39 txori kernel:  [<829039bc>] xfs_bmapi+0xb00/0x12bf [xfs]
Sep 13 08:39:39 txori kernel:  [<829031e2>] xfs_bmapi+0x326/0x12bf [xfs]
Sep 13 08:39:39 txori kernel:  [<021398ef>] wake_up_page+0x9/0x29
Sep 13 08:39:39 txori kernel:  [<82926bdf>] 
xfs_iomap_write_delay+0x628/0x702 [xfs]
Sep 13 08:39:39 txori kernel:  [<8292ad03>] 
xlog_state_get_iclog_space+0x163/0x172 [xfs]
Sep 13 08:39:39 txori kernel:  [<82925b32>] xfs_imap_to_bmap+0x2a/0x28a 
[xfs]
Sep 13 08:39:39 txori kernel:  [<82925fcc>] xfs_iomap+0x23a/0x3ec [xfs]
Sep 13 08:39:39 txori kernel:  [<82926076>] xfs_iomap+0x2e4/0x3ec [xfs]
Sep 13 08:39:39 txori kernel:  [<82945e39>] xfs_bmap+0x1a/0x1e [xfs]
Sep 13 08:39:39 txori kernel:  [<8294005f>] 
linvfs_get_block_core+0x6b/0x257 [xfs]
Sep 13 08:39:40 txori kernel:  [<02139c3f>] find_or_create_page+0x18/0x72
Sep 13 08:39:40 txori kernel:  [<022b7b17>] __cond_resched+0x14/0x39
Sep 13 08:39:40 txori kernel:  [<02156002>] set_bh_page+0x2c/0x34
Sep 13 08:39:40 txori kernel:  [<8294025e>] linvfs_get_block+0x13/0x17 [xfs]
Sep 13 08:39:40 txori kernel:  [<0215664f>] 
__block_prepare_write+0x15d/0x3e4
Sep 13 08:39:40 txori kernel:  [<02156f61>] block_prepare_write+0x16/0x23
Sep 13 08:39:40 txori kernel:  [<8294024b>] linvfs_get_block+0x0/0x17 [xfs]
Sep 13 08:39:40 txori kernel:  [<82940578>] 
linvfs_prepare_write+0x12/0x16 [xfs]
Sep 13 08:39:40 txori kernel:  [<8294024b>] linvfs_get_block+0x0/0x17 [xfs]
Sep 13 08:39:40 txori kernel:  [<0213b3c8>] 
generic_file_buffered_write+0x1b5/0x4ae
Sep 13 08:39:40 txori kernel:  [<8290e4ed>] xfs_da_brelse+0x73/0x92 [xfs]
Sep 13 08:39:40 txori kernel:  [<828f7400>] xfs_attr_leaf_get+0x4b/0x82 
[xfs]
Sep 13 08:39:40 txori kernel:  [<82945a87>] xfs_write+0x622/0x982 [xfs]
Sep 13 08:39:40 txori kernel:  [<8294230d>] linvfs_write+0x6f/0x77 [xfs]
Sep 13 08:39:40 txori kernel:  [<02153d7b>] do_sync_write+0x97/0xc9
Sep 13 08:39:40 txori kernel:  [<8293a4d9>] 
xfs_inactive_free_eofblocks+0xd2/0x210 [xfs]
Sep 13 08:39:40 txori kernel:  [<0211deca>] 
autoremove_wake_function+0x0/0x2d
Sep 13 08:39:40 txori kernel:  [<02153e63>] vfs_write+0xb6/0xe2
Sep 13 08:39:40 txori kernel:  [<02153f2d>] sys_write+0x3c/0x62
Sep 13 08:39:40 txori kernel: perl5.8.5: page allocation failure. 
order:4, mode:0x50
Sep 13 08:39:40 txori kernel:  [<0213d396>] __alloc_pages+0x28b/0x298
Sep 13 08:39:40 txori kernel:  [<0213d3bb>] __get_free_pages+0x18/0x24
Sep 13 08:39:40 txori kernel:  [<0213fc88>] kmem_getpages+0x1c/0xbb
Sep 13 08:39:40 txori kernel:  [<021407d9>] cache_grow+0xae/0x136
Sep 13 08:39:40 txori kernel:  [<021409c6>] cache_alloc_refill+0x165/0x19d
Sep 13 08:39:40 txori kernel:  [<02140d9d>] __kmalloc+0x76/0x88
Sep 13 08:39:40 txori kernel:  [<8293ee20>] kmem_alloc+0x50/0x9e [xfs]
Sep 13 08:39:40 txori kernel:  [<8293eef0>] kmem_realloc+0x17/0x52 [xfs]
Sep 13 08:39:40 txori kernel:  [<82924188>] xfs_iext_realloc+0xc9/0xdc [xfs]
Sep 13 08:39:40 txori kernel:  [<82901912>] 
xfs_bmap_insert_exlist+0x22/0x77 [xfs]
Sep 13 08:39:40 txori kernel:  [<828fed42>] 
xfs_bmap_add_extent_hole_delay+0x438/0x48e [xfs]
Sep 13 08:39:40 txori kernel:  [<828fc7b4>] 
xfs_bmap_add_extent+0x146/0x399 [xfs]
Sep 13 08:39:40 txori kernel:  [<829039bc>] xfs_bmapi+0xb00/0x12bf [xfs]
Sep 13 08:39:40 txori kernel:  [<829031e2>] xfs_bmapi+0x326/0x12bf [xfs]
Sep 13 08:39:40 txori kernel:  [<021398ef>] wake_up_page+0x9/0x29
Sep 13 08:39:40 txori kernel:  [<82926bdf>] 
xfs_iomap_write_delay+0x628/0x702 [xfs]
Sep 13 08:39:40 txori kernel:  [<8292ad03>] 
xlog_state_get_iclog_space+0x163/0x172 [xfs]
Sep 13 08:39:40 txori kernel:  [<82925b32>] xfs_imap_to_bmap+0x2a/0x28a 
[xfs]
Sep 13 08:39:40 txori kernel:  [<82925fcc>] xfs_iomap+0x23a/0x3ec [xfs]
Sep 13 08:39:40 txori kernel:  [<82926076>] xfs_iomap+0x2e4/0x3ec [xfs]
Sep 13 08:39:40 txori kernel:  [<82945e39>] xfs_bmap+0x1a/0x1e [xfs]
Sep 13 08:39:40 txori kernel:  [<8294005f>] 
linvfs_get_block_core+0x6b/0x257 [xfs]
Sep 13 08:39:40 txori kernel:  [<02139c3f>] find_or_create_page+0x18/0x72
Sep 13 08:39:40 txori kernel:  [<022b7b17>] __cond_resched+0x14/0x39
Sep 13 08:39:40 txori kernel:  [<02156002>] set_bh_page+0x2c/0x34
Sep 13 08:39:40 txori kernel:  [<8294025e>] linvfs_get_block+0x13/0x17 [xfs]
Sep 13 08:39:40 txori kernel:  [<0215664f>] 
__block_prepare_write+0x15d/0x3e4
Sep 13 08:39:40 txori kernel:  [<02156f61>] block_prepare_write+0x16/0x23
Sep 13 08:39:40 txori kernel:  [<8294024b>] linvfs_get_block+0x0/0x17 [xfs]
Sep 13 08:39:40 txori kernel:  [<82940578>] 
linvfs_prepare_write+0x12/0x16 [xfs]
Sep 13 08:39:40 txori kernel:  [<8294024b>] linvfs_get_block+0x0/0x17 [xfs]
Sep 13 08:39:40 txori kernel:  [<0213b3c8>] 
generic_file_buffered_write+0x1b5/0x4ae
Sep 13 08:39:40 txori kernel:  [<8290e4ed>] xfs_da_brelse+0x73/0x92 [xfs]
Sep 13 08:39:40 txori kernel:  [<828f7400>] xfs_attr_leaf_get+0x4b/0x82 
[xfs]
Sep 13 08:39:40 txori kernel:  [<82945a87>] xfs_write+0x622/0x982 [xfs]
Sep 13 08:39:40 txori kernel:  [<8294230d>] linvfs_write+0x6f/0x77 [xfs]
Sep 13 08:39:40 txori kernel:  [<02153d7b>] do_sync_write+0x97/0xc9
Sep 13 08:39:40 txori kernel:  [<8293a4d9>] 
xfs_inactive_free_eofblocks+0xd2/0x210 [xfs]
Sep 13 08:39:40 txori kernel:  [<0211deca>] 
autoremove_wake_function+0x0/0x2d
Sep 13 08:39:40 txori kernel:  [<02153e63>] vfs_write+0xb6/0xe2
Sep 13 08:39:40 txori kernel:  [<02153f2d>] sys_write+0x3c/0x62
Sep 13 08:39:40 txori kernel: perl5.8.5: page allocation failure. 
order:4, mode:0x50
Sep 13 08:39:40 txori kernel:  [<0213d396>] __alloc_pages+0x28b/0x298
Sep 13 08:39:40 txori kernel:  [<0213d3bb>] __get_free_pages+0x18/0x24
Sep 13 08:39:40 txori kernel:  [<0213fc88>] kmem_getpages+0x1c/0xbb
Sep 13 08:39:40 txori kernel:  [<021407d9>] cache_grow+0xae/0x136
Sep 13 08:39:41 txori kernel:  [<021409c6>] cache_alloc_refill+0x165/0x19d
Sep 13 08:39:41 txori kernel:  [<02140d9d>] __kmalloc+0x76/0x88
Sep 13 08:39:41 txori kernel:  [<8293ee20>] kmem_alloc+0x50/0x9e [xfs]
Sep 13 08:39:41 txori kernel:  [<8293eef0>] kmem_realloc+0x17/0x52 [xfs]
Sep 13 08:39:41 txori kernel:  [<82924188>] xfs_iext_realloc+0xc9/0xdc [xfs]
Sep 13 08:39:41 txori kernel:  [<82901912>] 
xfs_bmap_insert_exlist+0x22/0x77 [xfs]
Sep 13 08:39:41 txori kernel:  [<828fed42>] 
xfs_bmap_add_extent_hole_delay+0x438/0x48e [xfs]
Sep 13 08:39:41 txori kernel:  [<828fc7b4>] 
xfs_bmap_add_extent+0x146/0x399 [xfs]
Sep 13 08:39:41 txori kernel:  [<829039bc>] xfs_bmapi+0xb00/0x12bf [xfs]
Sep 13 08:39:41 txori kernel:  [<829031e2>] xfs_bmapi+0x326/0x12bf [xfs]
Sep 13 08:39:41 txori kernel:  [<021398ef>] wake_up_page+0x9/0x29
Sep 13 08:39:41 txori kernel:  [<82926bdf>] 
xfs_iomap_write_delay+0x628/0x702 [xfs]
Sep 13 08:39:41 txori kernel:  [<8292ad03>] 
xlog_state_get_iclog_space+0x163/0x172 [xfs]
Sep 13 08:39:41 txori kernel:  [<82925b32>] xfs_imap_to_bmap+0x2a/0x28a 
[xfs]
Sep 13 08:39:41 txori kernel:  [<82925fcc>] xfs_iomap+0x23a/0x3ec [xfs]
Sep 13 08:39:41 txori kernel:  [<82926076>] xfs_iomap+0x2e4/0x3ec [xfs]
Sep 13 08:39:41 txori kernel:  [<82945e39>] xfs_bmap+0x1a/0x1e [xfs]
Sep 13 08:39:41 txori kernel:  [<8294005f>] 
linvfs_get_block_core+0x6b/0x257 [xfs]
Sep 13 08:39:41 txori kernel:  [<02139c3f>] find_or_create_page+0x18/0x72
Sep 13 08:39:41 txori kernel:  [<022b7b17>] __cond_resched+0x14/0x39
Sep 13 08:39:41 txori kernel:  [<02156002>] set_bh_page+0x2c/0x34
Sep 13 08:39:41 txori kernel:  [<8294025e>] linvfs_get_block+0x13/0x17 [xfs]
Sep 13 08:39:41 txori kernel:  [<0215664f>] 
__block_prepare_write+0x15d/0x3e4
Sep 13 08:39:41 txori kernel:  [<02156f61>] block_prepare_write+0x16/0x23
Sep 13 08:39:41 txori kernel:  [<8294024b>] linvfs_get_block+0x0/0x17 [xfs]
Sep 13 08:39:41 txori kernel:  [<82940578>] 
linvfs_prepare_write+0x12/0x16 [xfs]
Sep 13 08:39:41 txori kernel:  [<8294024b>] linvfs_get_block+0x0/0x17 [xfs]
Sep 13 08:39:41 txori kernel:  [<0213b3c8>] 
generic_file_buffered_write+0x1b5/0x4ae
Sep 13 08:39:41 txori kernel:  [<8290e4ed>] xfs_da_brelse+0x73/0x92 [xfs]
Sep 13 08:39:41 txori kernel:  [<828f7400>] xfs_attr_leaf_get+0x4b/0x82 
[xfs]
Sep 13 08:39:41 txori kernel:  [<82945a87>] xfs_write+0x622/0x982 [xfs]
Sep 13 08:39:41 txori kernel:  [<8294230d>] linvfs_write+0x6f/0x77 [xfs]
Sep 13 08:39:41 txori kernel:  [<02153d7b>] do_sync_write+0x97/0xc9
Sep 13 08:39:41 txori kernel:  [<8293a4d9>] 
xfs_inactive_free_eofblocks+0xd2/0x210 [xfs]
Sep 13 08:39:41 txori kernel:  [<0211deca>] 
autoremove_wake_function+0x0/0x2d
Sep 13 08:39:41 txori kernel:  [<02153e63>] vfs_write+0xb6/0xe2
Sep 13 08:39:41 txori kernel:  [<02153f2d>] sys_write+0x3c/0x62
Sep 13 08:39:41 txori kernel: possible deadlock in kmem_alloc (mode:0x50)

