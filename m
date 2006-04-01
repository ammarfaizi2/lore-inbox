Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751638AbWDAXBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbWDAXBI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 18:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751640AbWDAXBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 18:01:08 -0500
Received: from admingilde.org ([213.95.32.146]:63667 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S1751638AbWDAXBH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 18:01:07 -0500
Date: Sun, 2 Apr 2006 01:01:03 +0200
From: Martin Waitz <tali@admingilde.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: [PATCH] Documentation: fix minor kernel-doc warnings
Message-ID: <20060401230102.GG4663@admingilde.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, trivial@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the comments to match the actual code.

Signed-off-by: Martin Waitz <tali@admingilde.org>

---

 Documentation/DocBook/kernel-api.tmpl |    1 -
 block/ll_rw_blk.c                     |    2 +-
 fs/sysfs/dir.c                        |    2 +-
 include/linux/hrtimer.h               |    2 +-
 mm/page-writeback.c                   |    2 +-
 5 files changed, 4 insertions(+), 5 deletions(-)

ed039bdccca94c1e9c275dcf69c72459b1d54a27
diff --git a/Documentation/DocBook/kernel-api.tmpl b/Documentation/DocBook/kernel-api.tmpl
index 8c9c670..ca02e04 100644
--- a/Documentation/DocBook/kernel-api.tmpl
+++ b/Documentation/DocBook/kernel-api.tmpl
@@ -322,7 +322,6 @@ X!Earch/i386/kernel/mca.c
   <chapter id="sysfs">
      <title>The Filesystem for Exporting Kernel Objects</title>
 !Efs/sysfs/file.c
-!Efs/sysfs/dir.c
 !Efs/sysfs/symlink.c
 !Efs/sysfs/bin.c
   </chapter>
diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index 5b26af8..e112d1a 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -1740,7 +1740,7 @@ EXPORT_SYMBOL(blk_run_queue);
 
 /**
  * blk_cleanup_queue: - release a &request_queue_t when it is no longer needed
- * @q:    the request queue to be released
+ * @kobj:    the kobj belonging of the request queue to be released
  *
  * Description:
  *     blk_cleanup_queue is the pair to blk_init_queue() or
diff --git a/fs/sysfs/dir.c b/fs/sysfs/dir.c
index f26880a..6cfdc9a 100644
--- a/fs/sysfs/dir.c
+++ b/fs/sysfs/dir.c
@@ -50,7 +50,7 @@ static struct sysfs_dirent * sysfs_new_d
 	return sd;
 }
 
-/**
+/*
  *
  * Return -EEXIST if there is already a sysfs element with the same name for
  * the same parent.
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index b209392..306acf1 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -80,7 +80,7 @@ struct hrtimer_sleeper {
  * @first:		pointer to the timer node which expires first
  * @resolution:		the resolution of the clock, in nanoseconds
  * @get_time:		function to retrieve the current time of the clock
- * @get_sofirq_time:	function to retrieve the current time from the softirq
+ * @get_softirq_time:	function to retrieve the current time from the softirq
  * @curr_timer:		the timer which is executing a callback right now
  * @softirq_time:	the time when running the hrtimer queue in the softirq
  */
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 893d767..6dcce3a 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -258,7 +258,7 @@ static void balance_dirty_pages(struct a
 /**
  * balance_dirty_pages_ratelimited_nr - balance dirty memory state
  * @mapping: address_space which was dirtied
- * @nr_pages: number of pages which the caller has just dirtied
+ * @nr_pages_dirtied: number of pages which the caller has just dirtied
  *
  * Processes which are dirtying memory should call in here once for each page
  * which was newly dirtied.  The function will periodically check the system's
-- 
1.2.4.gb0a3d

-- 
Martin Waitz
