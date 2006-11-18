Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755346AbWKRWzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755346AbWKRWzv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 17:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755352AbWKRWzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 17:55:49 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:14256 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1755347AbWKRWz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 17:55:27 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 4/4] swsusp: Fix labels
Date: Sat, 18 Nov 2006 23:51:01 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>
References: <200611182335.27453.rjw@sisk.pl>
In-Reply-To: <200611182335.27453.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611182351.01924.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move all labels in the swsusp code to the second column, so that they won't
fool diff -p.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/disk.c     |    6 +++---
 kernel/power/snapshot.c |    8 ++++----
 kernel/power/swap.c     |    4 ++--
 kernel/power/swsusp.c   |    2 +-
 kernel/power/user.c     |    2 +-
 5 files changed, 11 insertions(+), 11 deletions(-)

Index: linux-2.6.19-rc5-mm2/kernel/power/disk.c
===================================================================
--- linux-2.6.19-rc5-mm2.orig/kernel/power/disk.c
+++ linux-2.6.19-rc5-mm2/kernel/power/disk.c
@@ -119,9 +119,9 @@ static int prepare_processes(void)
 		return 0;
 
 	platform_finish();
-thaw:
+ thaw:
 	thaw_processes();
-enable_cpus:
+ enable_cpus:
 	enable_nonboot_cpus();
 	pm_restore_console();
 	return error;
@@ -394,7 +394,7 @@ static ssize_t resume_store(struct subsy
 	noresume = 0;
 	software_resume();
 	ret = n;
-out:
+ out:
 	return ret;
 }
 
Index: linux-2.6.19-rc5-mm2/kernel/power/snapshot.c
===================================================================
--- linux-2.6.19-rc5-mm2.orig/kernel/power/snapshot.c
+++ linux-2.6.19-rc5-mm2/kernel/power/snapshot.c
@@ -411,7 +411,7 @@ memory_bm_create(struct memory_bitmap *b
 	memory_bm_position_reset(bm);
 	return 0;
 
-Free:
+ Free:
 	bm->p_list = ca.chain;
 	memory_bm_free(bm, PG_UNSAFE_CLEAR);
 	return -ENOMEM;
@@ -557,7 +557,7 @@ static unsigned long memory_bm_next_pfn(
 	memory_bm_position_reset(bm);
 	return BM_END_OF_MAP;
 
-Return_pfn:
+ Return_pfn:
 	bm->cur.chunk = chunk;
 	bm->cur.bit = bit;
 	return bb->start_pfn + chunk * BM_BITS_PER_CHUNK + bit;
@@ -964,7 +964,7 @@ swsusp_alloc(struct memory_bitmap *orig_
 	}
 	return 0;
 
-Free:
+ Free:
 	swsusp_free();
 	return -ENOMEM;
 }
@@ -1540,7 +1540,7 @@ prepare_image(struct memory_bitmap *new_
 	}
 	return 0;
 
-Free:
+ Free:
 	swsusp_free();
 	return error;
 }
Index: linux-2.6.19-rc5-mm2/kernel/power/swsusp.c
===================================================================
--- linux-2.6.19-rc5-mm2.orig/kernel/power/swsusp.c
+++ linux-2.6.19-rc5-mm2/kernel/power/swsusp.c
@@ -288,7 +288,7 @@ int swsusp_suspend(void)
 	 * that suspended with irqs off ... no overall powerup.
 	 */
 	device_power_up();
-Enable_irqs:
+ Enable_irqs:
 	local_irq_enable();
 	return error;
 }
Index: linux-2.6.19-rc5-mm2/kernel/power/user.c
===================================================================
--- linux-2.6.19-rc5-mm2.orig/kernel/power/user.c
+++ linux-2.6.19-rc5-mm2/kernel/power/user.c
@@ -313,7 +313,7 @@ static int snapshot_ioctl(struct inode *
 		if (pm_ops->finish)
 			pm_ops->finish(PM_SUSPEND_MEM);
 
-OutS3:
+ OutS3:
 		up(&pm_sem);
 		break;
 
Index: linux-2.6.19-rc5-mm2/kernel/power/swap.c
===================================================================
--- linux-2.6.19-rc5-mm2.orig/kernel/power/swap.c
+++ linux-2.6.19-rc5-mm2/kernel/power/swap.c
@@ -301,7 +301,7 @@ static int swap_write_page(struct swap_m
 		handle->cur_swap = offset;
 		handle->k = 0;
 	}
-out:
+ out:
 	return error;
 }
 
@@ -429,7 +429,7 @@ int swsusp_write(void)
 	if (error)
 		free_all_swap_pages(root_swap, handle.bitmap);
 	release_swap_writer(&handle);
-out:
+ out:
 	swsusp_close();
 	return error;
 }
