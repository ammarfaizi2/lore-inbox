Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263095AbTI3C1Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 22:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263096AbTI3C1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 22:27:25 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:46866 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S263095AbTI3C1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 22:27:11 -0400
Date: Mon, 29 Sep 2003 23:32:57 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCHES] start ditching kernel/ksyms.c
Message-ID: <20030930023257.GD1679@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	Please consider pulling from:

bk://kernel.bkbits.net/acme/ksyms-2.6

	Tomorrow I'll continue the work.

Thanks,

- Arnaldo

===================================================================


ChangeSet@1.1451, 2003-09-29 22:54:16-03:00, acme@conectiva.com.br
  o kernel/ksyms.c: move relevant EXPORT_SYMBOLs to fs/libfs.c

ChangeSet@1.1450, 2003-09-29 22:50:07-03:00, acme@conectiva.com.br
  o kernel/ksyms.c: move relevant EXPORT_SYMBOLs to kernel/sched.c

ChangeSet@1.1449, 2003-09-29 22:32:27-03:00, acme@conectiva.com.br
  o kernel/ksyms.c: move relevant EXPORT_SYMBOLs to fs/dcache.c

ChangeSet@1.1448, 2003-09-29 22:12:32-03:00, acme@conectiva.com.br
  o kernel/ksyms.c: move relevant EXPORT_SYMBOLs to fs/buffer.c

ChangeSet@1.1447, 2003-09-29 21:58:57-03:00, acme@conectiva.com.br
  o kernel/ksyms.c: move relevant EXPORT_SYMBOLs to fs/namei.c

 fs/buffer.c    |   28 ++++++++++++
 fs/dcache.c    |   24 ++++++++++
 fs/libfs.c     |   23 ++++++++++
 fs/namei.c     |   31 +++++++++++++
 kernel/ksyms.c |  129 ---------------------------------------------------------
 kernel/sched.c |   31 +++++++++++++
 6 files changed, 137 insertions(+), 129 deletions(-)


diff -Nru a/fs/buffer.c b/fs/buffer.c
--- a/fs/buffer.c	Mon Sep 29 23:12:35 2003
+++ b/fs/buffer.c	Mon Sep 29 23:12:35 2003
@@ -3035,3 +3035,31 @@
 				(void *)(long)smp_processor_id());
 	register_cpu_notifier(&buffer_nb);
 }
+
+EXPORT_SYMBOL(__bforget);
+EXPORT_SYMBOL(__brelse);
+EXPORT_SYMBOL(__wait_on_buffer);
+EXPORT_SYMBOL(block_commit_write);
+EXPORT_SYMBOL(block_prepare_write);
+EXPORT_SYMBOL(block_read_full_page);
+EXPORT_SYMBOL(block_sync_page);
+EXPORT_SYMBOL(block_truncate_page);
+EXPORT_SYMBOL(block_write_full_page);
+EXPORT_SYMBOL(buffer_insert_list);
+EXPORT_SYMBOL(cont_prepare_write);
+EXPORT_SYMBOL(end_buffer_async_write);
+EXPORT_SYMBOL(end_buffer_read_sync);
+EXPORT_SYMBOL(end_buffer_write_sync);
+EXPORT_SYMBOL(file_fsync);
+EXPORT_SYMBOL(fsync_bdev);
+EXPORT_SYMBOL(fsync_buffers_list);
+EXPORT_SYMBOL(generic_block_bmap);
+EXPORT_SYMBOL(generic_commit_write);
+EXPORT_SYMBOL(generic_cont_expand);
+EXPORT_SYMBOL(init_buffer);
+EXPORT_SYMBOL(invalidate_bdev);
+EXPORT_SYMBOL(ll_rw_block);
+EXPORT_SYMBOL(mark_buffer_dirty);
+EXPORT_SYMBOL(submit_bh);
+EXPORT_SYMBOL(sync_dirty_buffer);
+EXPORT_SYMBOL(unlock_buffer);
diff -Nru a/fs/dcache.c b/fs/dcache.c
--- a/fs/dcache.c	Mon Sep 29 23:12:35 2003
+++ b/fs/dcache.c	Mon Sep 29 23:12:35 2003
@@ -1639,3 +1639,27 @@
 	bdev_cache_init();
 	chrdev_init();
 }
+
+EXPORT_SYMBOL(d_alloc);
+EXPORT_SYMBOL(d_alloc_anon);
+EXPORT_SYMBOL(d_alloc_root);
+EXPORT_SYMBOL(d_delete);
+EXPORT_SYMBOL(d_find_alias);
+EXPORT_SYMBOL(d_instantiate);
+EXPORT_SYMBOL(d_invalidate);
+EXPORT_SYMBOL(d_lookup);
+EXPORT_SYMBOL(d_move);
+EXPORT_SYMBOL(d_path);
+EXPORT_SYMBOL(d_prune_aliases);
+EXPORT_SYMBOL(d_rehash);
+EXPORT_SYMBOL(d_splice_alias);
+EXPORT_SYMBOL(d_validate);
+EXPORT_SYMBOL(dget_locked);
+EXPORT_SYMBOL(dput);
+EXPORT_SYMBOL(find_inode_number);
+EXPORT_SYMBOL(have_submounts);
+EXPORT_SYMBOL(is_subdir);
+EXPORT_SYMBOL(names_cachep);
+EXPORT_SYMBOL(shrink_dcache_anon);
+EXPORT_SYMBOL(shrink_dcache_parent);
+EXPORT_SYMBOL(shrink_dcache_sb);
diff -Nru a/fs/libfs.c b/fs/libfs.c
--- a/fs/libfs.c	Mon Sep 29 23:12:35 2003
+++ b/fs/libfs.c	Mon Sep 29 23:12:35 2003
@@ -429,3 +429,26 @@
 	spin_unlock(&pin_fs_lock);
 	mntput(mnt);
 }
+
+EXPORT_SYMBOL(dcache_dir_close);
+EXPORT_SYMBOL(dcache_dir_lseek);
+EXPORT_SYMBOL(dcache_dir_open);
+EXPORT_SYMBOL(dcache_readdir);
+EXPORT_SYMBOL(generic_read_dir);
+EXPORT_SYMBOL(simple_commit_write);
+EXPORT_SYMBOL(simple_dir_inode_operations);
+EXPORT_SYMBOL(simple_dir_operations);
+EXPORT_SYMBOL(simple_empty);
+EXPORT_SYMBOL(simple_fill_super);
+EXPORT_SYMBOL(simple_getattr);
+EXPORT_SYMBOL(simple_link);
+EXPORT_SYMBOL(simple_lookup);
+EXPORT_SYMBOL(simple_pin_fs);
+EXPORT_SYMBOL(simple_prepare_write);
+EXPORT_SYMBOL(simple_readpage);
+EXPORT_SYMBOL(simple_release_fs);
+EXPORT_SYMBOL(simple_rename);
+EXPORT_SYMBOL(simple_rmdir);
+EXPORT_SYMBOL(simple_statfs);
+EXPORT_SYMBOL(simple_sync_file);
+EXPORT_SYMBOL(simple_unlink);
diff -Nru a/fs/namei.c b/fs/namei.c
--- a/fs/namei.c	Mon Sep 29 23:12:35 2003
+++ b/fs/namei.c	Mon Sep 29 23:12:35 2003
@@ -15,6 +15,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/fs.h>
 #include <linux/namei.h>
@@ -2275,3 +2276,33 @@
 	.readlink	= page_readlink,
 	.follow_link	= page_follow_link,
 };
+
+EXPORT_SYMBOL(__user_walk);
+EXPORT_SYMBOL(follow_down);
+EXPORT_SYMBOL(follow_up);
+EXPORT_SYMBOL(get_write_access); /* binfmt_aout */
+EXPORT_SYMBOL(getname);
+EXPORT_SYMBOL(lock_rename);
+EXPORT_SYMBOL(lookup_create);
+EXPORT_SYMBOL(lookup_hash);
+EXPORT_SYMBOL(lookup_one_len);
+EXPORT_SYMBOL(page_follow_link);
+EXPORT_SYMBOL(page_readlink);
+EXPORT_SYMBOL(page_symlink);
+EXPORT_SYMBOL(page_symlink_inode_operations);
+EXPORT_SYMBOL(path_lookup);
+EXPORT_SYMBOL(path_release);
+EXPORT_SYMBOL(path_walk);
+EXPORT_SYMBOL(permission);
+EXPORT_SYMBOL(unlock_rename);
+EXPORT_SYMBOL(vfs_create);
+EXPORT_SYMBOL(vfs_follow_link);
+EXPORT_SYMBOL(vfs_link);
+EXPORT_SYMBOL(vfs_mkdir);
+EXPORT_SYMBOL(vfs_mknod);
+EXPORT_SYMBOL(vfs_permission);
+EXPORT_SYMBOL(vfs_readlink);
+EXPORT_SYMBOL(vfs_rename);
+EXPORT_SYMBOL(vfs_rmdir);
+EXPORT_SYMBOL(vfs_symlink);
+EXPORT_SYMBOL(vfs_unlink);
diff -Nru a/kernel/ksyms.c b/kernel/ksyms.c
--- a/kernel/ksyms.c	Mon Sep 29 23:12:35 2003
+++ b/kernel/ksyms.c	Mon Sep 29 23:12:35 2003
@@ -45,7 +45,6 @@
 #include <linux/uio.h>
 #include <linux/tty.h>
 #include <linux/in6.h>
-#include <linux/completion.h>
 #include <linux/seq_file.h>
 #include <linux/binfmts.h>
 #include <linux/namei.h>
@@ -145,43 +144,15 @@
 EXPORT_SYMBOL(user_get_super);
 EXPORT_SYMBOL(get_super);
 EXPORT_SYMBOL(drop_super);
-EXPORT_SYMBOL(getname);
-EXPORT_SYMBOL(names_cachep);
 EXPORT_SYMBOL(fput);
 EXPORT_SYMBOL(fget);
 EXPORT_SYMBOL(igrab);
 EXPORT_SYMBOL(iunique);
 EXPORT_SYMBOL(iput);
 EXPORT_SYMBOL(inode_init_once);
-EXPORT_SYMBOL(follow_up);
-EXPORT_SYMBOL(follow_down);
 EXPORT_SYMBOL(lookup_mnt);
-EXPORT_SYMBOL(lookup_create);
-EXPORT_SYMBOL(path_lookup);
-EXPORT_SYMBOL(path_walk);
-EXPORT_SYMBOL(path_release);
-EXPORT_SYMBOL(__user_walk);
-EXPORT_SYMBOL(lookup_one_len);
-EXPORT_SYMBOL(lookup_hash);
 EXPORT_SYMBOL(sys_close);
 EXPORT_SYMBOL(dcache_lock);
-EXPORT_SYMBOL(d_alloc_root);
-EXPORT_SYMBOL(d_delete);
-EXPORT_SYMBOL(dget_locked);
-EXPORT_SYMBOL(d_validate);
-EXPORT_SYMBOL(d_rehash);
-EXPORT_SYMBOL(d_invalidate);	/* May be it will be better in dcache.h? */
-EXPORT_SYMBOL(d_move);
-EXPORT_SYMBOL(d_instantiate);
-EXPORT_SYMBOL(d_alloc);
-EXPORT_SYMBOL(d_alloc_anon);
-EXPORT_SYMBOL(d_splice_alias);
-EXPORT_SYMBOL(d_lookup);
-EXPORT_SYMBOL(d_path);
-EXPORT_SYMBOL(mark_buffer_dirty);
-EXPORT_SYMBOL(end_buffer_read_sync);
-EXPORT_SYMBOL(end_buffer_write_sync);
-EXPORT_SYMBOL(end_buffer_async_write);
 EXPORT_SYMBOL(__mark_inode_dirty);
 EXPORT_SYMBOL(get_empty_filp);
 EXPORT_SYMBOL(open_private_file);
@@ -191,15 +162,11 @@
 EXPORT_SYMBOL(put_filp);
 EXPORT_SYMBOL(files_lock);
 EXPORT_SYMBOL(check_disk_change);
-EXPORT_SYMBOL(invalidate_bdev);
 EXPORT_SYMBOL(invalidate_inodes);
 EXPORT_SYMBOL(__invalidate_device);
 EXPORT_SYMBOL(invalidate_inode_pages);
 EXPORT_SYMBOL_GPL(invalidate_inode_pages2);
 EXPORT_SYMBOL(truncate_inode_pages);
-EXPORT_SYMBOL(fsync_bdev);
-EXPORT_SYMBOL(permission);
-EXPORT_SYMBOL(vfs_permission);
 EXPORT_SYMBOL(inode_setattr);
 EXPORT_SYMBOL(inode_change_ok);
 EXPORT_SYMBOL(write_inode_now);
@@ -214,24 +181,7 @@
 EXPORT_SYMBOL(open_bdev_excl);
 EXPORT_SYMBOL(close_bdev_excl);
 EXPORT_SYMBOL(open_by_devnum);
-EXPORT_SYMBOL(__brelse);
-EXPORT_SYMBOL(__bforget);
-EXPORT_SYMBOL(ll_rw_block);
-EXPORT_SYMBOL(sync_dirty_buffer);
-EXPORT_SYMBOL(submit_bh);
-EXPORT_SYMBOL(unlock_buffer);
-EXPORT_SYMBOL(__wait_on_buffer);
 EXPORT_SYMBOL(blockdev_direct_IO);
-EXPORT_SYMBOL(block_write_full_page);
-EXPORT_SYMBOL(block_read_full_page);
-EXPORT_SYMBOL(block_prepare_write);
-EXPORT_SYMBOL(block_sync_page);
-EXPORT_SYMBOL(generic_cont_expand);
-EXPORT_SYMBOL(cont_prepare_write);
-EXPORT_SYMBOL(generic_commit_write);
-EXPORT_SYMBOL(block_commit_write);
-EXPORT_SYMBOL(block_truncate_page);
-EXPORT_SYMBOL(generic_block_bmap);
 EXPORT_SYMBOL(generic_file_read);
 EXPORT_SYMBOL(generic_file_sendfile);
 EXPORT_SYMBOL(do_generic_mapping_read);
@@ -241,28 +191,11 @@
 EXPORT_SYMBOL(generic_file_mmap);
 EXPORT_SYMBOL(generic_file_readonly_mmap);
 EXPORT_SYMBOL(generic_ro_fops);
-EXPORT_SYMBOL(dput);
-EXPORT_SYMBOL(have_submounts);
-EXPORT_SYMBOL(d_find_alias);
-EXPORT_SYMBOL(d_prune_aliases);
-EXPORT_SYMBOL(shrink_dcache_sb);
-EXPORT_SYMBOL(shrink_dcache_parent);
-EXPORT_SYMBOL(shrink_dcache_anon);
-EXPORT_SYMBOL(find_inode_number);
-EXPORT_SYMBOL(is_subdir);
 EXPORT_SYMBOL(get_unused_fd);
 EXPORT_SYMBOL(vfs_read);
 EXPORT_SYMBOL(vfs_readv);
 EXPORT_SYMBOL(vfs_write);
 EXPORT_SYMBOL(vfs_writev);
-EXPORT_SYMBOL(vfs_create);
-EXPORT_SYMBOL(vfs_mkdir);
-EXPORT_SYMBOL(vfs_mknod);
-EXPORT_SYMBOL(vfs_symlink);
-EXPORT_SYMBOL(vfs_link);
-EXPORT_SYMBOL(vfs_rmdir);
-EXPORT_SYMBOL(vfs_unlink);
-EXPORT_SYMBOL(vfs_rename);
 EXPORT_SYMBOL(vfs_statfs);
 EXPORT_SYMBOL(vfs_fstat);
 EXPORT_SYMBOL(vfs_stat);
@@ -272,9 +205,6 @@
 EXPORT_SYMBOL(inode_sub_bytes);
 EXPORT_SYMBOL(inode_get_bytes);
 EXPORT_SYMBOL(inode_set_bytes);
-EXPORT_SYMBOL(lock_rename);
-EXPORT_SYMBOL(unlock_rename);
-EXPORT_SYMBOL(generic_read_dir);
 EXPORT_SYMBOL(generic_fillattr);
 EXPORT_SYMBOL(generic_file_llseek);
 EXPORT_SYMBOL(remote_llseek);
@@ -290,38 +220,11 @@
 EXPORT_SYMBOL(read_cache_page);
 EXPORT_SYMBOL(read_cache_pages);
 EXPORT_SYMBOL(mark_page_accessed);
-EXPORT_SYMBOL(vfs_readlink);
-EXPORT_SYMBOL(vfs_follow_link);
-EXPORT_SYMBOL(page_readlink);
-EXPORT_SYMBOL(page_follow_link);
-EXPORT_SYMBOL(page_symlink_inode_operations);
-EXPORT_SYMBOL(page_symlink);
 EXPORT_SYMBOL(vfs_readdir);
 EXPORT_SYMBOL(__break_lease);
 EXPORT_SYMBOL(lease_get_mtime);
 EXPORT_SYMBOL(lock_may_read);
 EXPORT_SYMBOL(lock_may_write);
-EXPORT_SYMBOL(dcache_dir_open);
-EXPORT_SYMBOL(dcache_dir_close);
-EXPORT_SYMBOL(dcache_dir_lseek);
-EXPORT_SYMBOL(dcache_readdir);
-EXPORT_SYMBOL(simple_getattr);
-EXPORT_SYMBOL(simple_statfs);
-EXPORT_SYMBOL(simple_lookup);
-EXPORT_SYMBOL(simple_dir_operations);
-EXPORT_SYMBOL(simple_dir_inode_operations);
-EXPORT_SYMBOL(simple_link);
-EXPORT_SYMBOL(simple_unlink);
-EXPORT_SYMBOL(simple_rmdir);
-EXPORT_SYMBOL(simple_rename);
-EXPORT_SYMBOL(simple_sync_file);
-EXPORT_SYMBOL(simple_readpage);
-EXPORT_SYMBOL(simple_prepare_write);
-EXPORT_SYMBOL(simple_commit_write);
-EXPORT_SYMBOL(simple_empty);
-EXPORT_SYMBOL(simple_fill_super);
-EXPORT_SYMBOL(simple_pin_fs);
-EXPORT_SYMBOL(simple_release_fs);
 EXPORT_SYMBOL(fd_install);
 EXPORT_SYMBOL(put_unused_fd);
 EXPORT_SYMBOL(get_sb_bdev);
@@ -361,7 +264,6 @@
 EXPORT_SYMBOL(blkdev_put);
 EXPORT_SYMBOL(ioctl_by_bdev);
 EXPORT_SYMBOL(read_dev_sector);
-EXPORT_SYMBOL(init_buffer);
 EXPORT_SYMBOL_GPL(generic_file_direct_IO);
 EXPORT_SYMBOL(generic_file_readv);
 EXPORT_SYMBOL(generic_file_writev);
@@ -414,10 +316,6 @@
 EXPORT_SYMBOL(finish_wait);
 EXPORT_SYMBOL(autoremove_wake_function);
 
-/* completion handling */
-EXPORT_SYMBOL(wait_for_completion);
-EXPORT_SYMBOL(complete);
-
 /* The notion of irq probe/assignment is foreign to S/390 */
 
 #if !defined(CONFIG_ARCH_S390)
@@ -449,26 +347,10 @@
 
 /* process management */
 EXPORT_SYMBOL(complete_and_exit);
-EXPORT_SYMBOL(default_wake_function);
-EXPORT_SYMBOL(__wake_up);
 #ifdef CONFIG_SMP
 EXPORT_SYMBOL_GPL(__wake_up_sync); /* internal use only */
 #endif
-EXPORT_SYMBOL(wake_up_process);
-EXPORT_SYMBOL(sleep_on);
-EXPORT_SYMBOL(sleep_on_timeout);
-EXPORT_SYMBOL(interruptible_sleep_on);
-EXPORT_SYMBOL(interruptible_sleep_on_timeout);
-EXPORT_SYMBOL(schedule);
-#ifdef CONFIG_PREEMPT
-EXPORT_SYMBOL(preempt_schedule);
-#endif
 EXPORT_SYMBOL(schedule_timeout);
-EXPORT_SYMBOL(yield);
-EXPORT_SYMBOL(io_schedule);
-EXPORT_SYMBOL(__cond_resched);
-EXPORT_SYMBOL(set_user_nice);
-EXPORT_SYMBOL(task_nice);
 EXPORT_SYMBOL_GPL(idle_cpu);
 #ifdef CONFIG_SMP
 EXPORT_SYMBOL_GPL(set_cpus_allowed);
@@ -485,13 +367,6 @@
 #if (BITS_PER_LONG < 64)
 EXPORT_SYMBOL(get_jiffies_64);
 #endif
-#ifdef CONFIG_DEBUG_SPINLOCK_SLEEP
-EXPORT_SYMBOL(__might_sleep);
-#endif
-#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
-EXPORT_SYMBOL(__preempt_spin_lock);
-EXPORT_SYMBOL(__preempt_write_lock);
-#endif
 #if !defined(__ia64__)
 EXPORT_SYMBOL(loops_per_jiffy);
 #endif
@@ -550,14 +425,11 @@
 
 /* Added to make file system as module */
 EXPORT_SYMBOL(sys_tz);
-EXPORT_SYMBOL(file_fsync);
-EXPORT_SYMBOL(fsync_buffers_list);
 EXPORT_SYMBOL(clear_inode);
 EXPORT_SYMBOL(init_special_inode);
 EXPORT_SYMBOL(new_inode);
 EXPORT_SYMBOL(__insert_inode_hash);
 EXPORT_SYMBOL(remove_inode_hash);
-EXPORT_SYMBOL(buffer_insert_list);
 EXPORT_SYMBOL(make_bad_inode);
 EXPORT_SYMBOL(is_bad_inode);
 EXPORT_SYMBOL(__inode_dir_notify);
@@ -576,7 +448,6 @@
 EXPORT_SYMBOL(kill_fasync);
 
 /* binfmt_aout */
-EXPORT_SYMBOL(get_write_access);
 
 /* library functions */
 EXPORT_SYMBOL(strnicmp);
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Mon Sep 29 23:12:35 2003
+++ b/kernel/sched.c	Mon Sep 29 23:12:35 2003
@@ -18,6 +18,7 @@
  */
 
 #include <linux/mm.h>
+#include <linux/module.h>
 #include <linux/nmi.h>
 #include <linux/init.h>
 #include <asm/uaccess.h>
@@ -2861,4 +2862,34 @@
 		preempt_disable();
 	} while (!_raw_write_trylock(lock));
 }
+#endif
+
+EXPORT_SYMBOL(__cond_resched);
+EXPORT_SYMBOL(__wake_up);
+EXPORT_SYMBOL(__wake_up_sync);
+EXPORT_SYMBOL(complete);
+EXPORT_SYMBOL(default_wake_function);
+EXPORT_SYMBOL(idle_cpu);
+EXPORT_SYMBOL(interruptible_sleep_on);
+EXPORT_SYMBOL(interruptible_sleep_on_timeout);
+EXPORT_SYMBOL(io_schedule);
+EXPORT_SYMBOL(schedule);
+EXPORT_SYMBOL(set_cpus_allowed);
+EXPORT_SYMBOL(set_user_nice);
+EXPORT_SYMBOL(sleep_on);
+EXPORT_SYMBOL(sleep_on_timeout);
+EXPORT_SYMBOL(task_nice);
+EXPORT_SYMBOL(wait_for_completion);
+EXPORT_SYMBOL(wake_up_process);
+EXPORT_SYMBOL(yield);
+
+#ifdef CONFIG_DEBUG_SPINLOCK_SLEEP
+EXPORT_SYMBOL(__might_sleep);
+#endif
+#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_SMP
+EXPORT_SYMBOL(__preempt_spin_lock);
+EXPORT_SYMBOL(__preempt_write_lock);
+#endif
+EXPORT_SYMBOL(preempt_schedule);
 #endif

