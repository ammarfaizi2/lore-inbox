Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265747AbUFIM2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265747AbUFIM2d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 08:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265701AbUFIM2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 08:28:01 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:16272 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S265766AbUFIMYC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 08:24:02 -0400
Date: Wed, 9 Jun 2004 14:22:26 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: reiserfs-dev@namesys.com
Cc: linux-kernel@vger.kernel.org
Subject: [STACK] >3k call path in reiserfs
Message-ID: <20040609122226.GE21168@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

reiserfs has some stack-hungry functions as well.  Could you put them
on a diet?

stackframes for call path too long (3024):
    size  function
      32  reiserfs_delete_inode
       0  reiserfs_delete_object
     132  reiserfs_do_truncate
     468  reiserfs_cut_from_item
     492  reiserfs_delete_item
     104  search_for_position_by_key
      16  search_by_entry_key
     208  search_by_key
       0  __bread
       0  __getblk
       0  __getblk_slow
       0  find_or_create_page
       0  add_to_page_cache_lru
       0  lru_cache_add
       0  preempt_schedule
      84  schedule
      16  __put_task_struct
      20  audit_free
      36  audit_log_start
      16  __kmalloc
       0  __get_free_pages
      28  __alloc_pages
     284  try_to_free_pages
       0  out_of_memory
       0  mmput
      16  exit_aio
       0  __put_ioctx
      16  do_munmap
       0  split_vma
      36  vma_adjust
       0  fput
       0  __fput
       0  locks_remove_flock
      12  panic
       0  sys_sync
       0  sync_inodes
     308  sync_inodes_sb
       0  do_writepages
     128  mpage_writepages
       4  write_boundary_block
       0  ll_rw_block
      28  submit_bh
       0  bio_alloc
      88  mempool_alloc
     256  wakeup_bdflush
      20  pdflush_operation
       0  printk
      16  release_console_sem
      16  __wake_up
       0  printk
       0  vscnprintf
      32  vsnprintf
     112  number

Jörn

-- 
A quarrel is quickly settled when deserted by one party; there is
no battle unless there be two.
-- Seneca
