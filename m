Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271105AbTGWGA2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 02:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271106AbTGWGA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 02:00:28 -0400
Received: from tmi.comex.ru ([217.10.33.92]:64728 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S271105AbTGWGA0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 02:00:26 -0400
X-Comment-To: Nicholas Miell
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 ext3 slab/fs corruption
From: Alex Tomas <bzzz@tmi.comex.ru>
To: Nicholas Miell <nmiell@attbi.com>
Organization: HOME
Date: Wed, 23 Jul 2003 10:14:41 +0000
In-Reply-To: <1058931916.1286.9.camel@entropy> (Nicholas Miell's message of
 "22 Jul 2003 20:45:20 -0700")
Message-ID: <87adb5lfce.fsf@gw.home.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.3 (gnu/linux)
References: <1058931916.1286.9.camel@entropy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



please, show your .config 

>>>>> Nicholas Miell (NM) writes:

 NM> I woke up this morning and discovered that a compile had died due to I/O
 NM> errors. I found the following in my logs (the rest of the relevant bits
 NM> from the log is attached -- 5k bz2, 146k uncompressed). Preempt is on,
 NM> htree is in use, e2fsck worked fine.

 NM> Jul 21 19:25:32 entropy kernel: EXT3-fs warning (device hda1):
 NM> ext3_unlink: Deleting nonexistent file (5632341), 0
 NM> Jul 21 19:28:31 entropy kernel: Slab corruption: start=c2a4ba30,
 NM> expend=c2a4bbff, problemat=c2a4baa8
 NM> Jul 21 19:28:31 entropy kernel: Last user:
 NM> [<c584f877>](ext3_destroy_inode+0x17/0x20 [ext3])
 NM> Jul 21 19:28:31 entropy kernel: Data:
 NM> ************************************************************************************************************************6C 13 EC C4 ***************************************************************************************************************************************************************************************************************************************************************************************************************************************************A5
 NM> Jul 21 19:28:31 entropy kernel: Next: 71 F0 2C .77 F8 84 C5 A5 C2 0F 17
 NM> 14 02 C8 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 NM> Jul 21 19:28:31 entropy kernel: slab error in check_poison_obj(): cache
 NM> `ext3_inode_cache': object was modified after freeing
 NM> Jul 21 19:28:31 entropy kernel: Call Trace:
 NM> Jul 21 19:28:31 entropy kernel:  [<c013b33f>]
 NM> check_poison_obj+0x13f/0x190
 NM> Jul 21 19:28:31 entropy kernel:  [<c013ca67>]
 NM> kmem_cache_alloc+0x117/0x160
 NM> Jul 21 19:28:31 entropy kernel:  [<c584f830>] ext3_alloc_inode+0x10/0x40
 NM> [ext3]
 NM> Jul 21 19:28:31 entropy kernel:  [<c584f830>] ext3_alloc_inode+0x10/0x40
 NM> [ext3]
 NM> Jul 21 19:28:31 entropy kernel:  [<c0168909>] alloc_inode+0x19/0x150
 NM> Jul 21 19:28:32 entropy kernel:  [<c0169336>] new_inode+0x16/0x90
 NM> Jul 21 19:28:32 entropy kernel:  [<c5847792>] ext3_new_inode+0x42/0x750
 NM> [ext3]
 NM> Jul 21 19:28:32 entropy kernel:  [<c013ca72>]
 NM> kmem_cache_alloc+0x122/0x160
 NM> Jul 21 19:28:32 entropy kernel:  [<c5814442>] new_handle+0x12/0x50 [jbd]
 NM> Jul 21 19:28:32 entropy kernel:  [<c5814509>] journal_start+0x89/0xb0
 NM> [jbd]
 NM> Jul 21 19:28:32 entropy kernel:  [<c584de0f>] ext3_create+0x3f/0x90
 NM> [ext3]
 NM> Jul 21 19:28:32 entropy kernel:  [<c015edec>] vfs_create+0x7c/0xe0
 NM> Jul 21 19:28:32 entropy kernel:  [<c015f43f>] open_namei+0x3ef/0x450
 NM> Jul 21 19:28:32 entropy kernel:  [<c014fc55>] filp_open+0x35/0x60
 NM> Jul 21 19:28:32 entropy kernel:  [<c015011f>] sys_open+0x3f/0x70
 NM> Jul 21 19:28:32 entropy kernel:  [<c010aec7>] syscall_call+0x7/0xb
 NM> Jul 21 19:28:32 entropy kernel:



