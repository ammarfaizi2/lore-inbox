Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265801AbUFIMeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265801AbUFIMeK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 08:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265763AbUFIMc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 08:32:59 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:8849 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S265756AbUFIM3R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 08:29:17 -0400
Date: Wed, 9 Jun 2004 14:29:21 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [STACK] >3k call path in ide
Message-ID: <20040609122921.GG21168@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej, can you put ide_config on a diet?

stackframes for call path too long (3052):
    size  function
       0  client_reg_t->event_handler
    1168  ide_config
      12  ide_register_hw
      44  ide_unregister
      12  ide_unregister_subdriver
       0  pnpide_init
       0  pnp_register_driver
       0  driver_register
      20  bus_add_driver
      16  driver_attach
      72  tty_register_device
       0  class_simple_device_add
       0  class_device_register
      16  class_device_add
       0  kobject_add
       0  kobject_hotplug
     132  call_usermodehelper
      80  wait_for_completion
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
       0  preempt_schedule
      84  schedule

Jörn

-- 
When you close your hand, you own nothing. When you open it up, you
own the whole world.
-- Li Mu Bai in Tiger & Dragon
