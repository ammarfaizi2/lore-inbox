Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267125AbSLKMB6>; Wed, 11 Dec 2002 07:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267126AbSLKMB5>; Wed, 11 Dec 2002 07:01:57 -0500
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:6155 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267125AbSLKMB4>; Wed, 11 Dec 2002 07:01:56 -0500
Subject: Re: "bio too big" error
From: Wil Reichert <wilreichert@yahoo.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3DF6CAA9.BC34612@digeo.com>
References: <3DF6A673.D406BC7F@digeo.com> <1039577938.388.9.camel@darwin>
	 <3DF6CAA9.BC34612@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1039608579.384.5.camel@darwin>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 11 Dec 2002 07:09:39 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could you please enable CONFIG_KALLSYMS and regenerate the backtrace?

darwin:~$ cp /a01/movies/metropolis.avi .
bio too big device ide2(33,0) (256 > 255)
Call Trace:
 [<c02035ee>] generic_make_request+0x1ce/0x210
 [<e093046d>] __clone_and_map+0xbd/0x120 [dm_mod]
 [<e0930558>] __split_bio+0x88/0xb0 [dm_mod]
 [<e09305f5>] dm_request+0x75/0xb0 [dm_mod]
 [<c020359a>] generic_make_request+0x17a/0x210
 [<c01dd314>] radix_tree_extend+0x64/0x90
 [<c0203684>] submit_bio+0x54/0xa0
 [<c017209e>] mpage_bio_submit+0x2e/0x40
 [<c0172689>] mpage_readpages+0xc9/0x160
 [<c0189780>] ext3_get_block+0x0/0xb0
 [<c013a526>] read_pages+0x116/0x120
 [<c0189780>] ext3_get_block+0x0/0xb0
 [<c013853d>] __alloc_pages+0x8d/0x290
 [<c013a624>] do_page_cache_readahead+0xf4/0x180
 [<c013a7fe>] page_cache_readahead+0x14e/0x190
 [<c0135168>] do_generic_mapping_read+0xb8/0x410
 [<c0154443>] __block_commit_write+0x93/0xa0
 [<c0135500>] file_read_actor+0x0/0xf0
 [<c01357c4>] __generic_file_aio_read+0x1d4/0x220
 [<c0135500>] file_read_actor+0x0/0xf0
 [<c013586a>] generic_file_aio_read+0x5a/0x80
 [<c015076b>] do_sync_read+0x8b/0xc0
 [<c0136e3c>] generic_file_write+0x5c/0x80
 [<c015085e>] vfs_read+0xbe/0x130
 [<c0150afe>] sys_read+0x3e/0x60
 [<c01096af>] syscall_call+0x7/0xb

Wil


