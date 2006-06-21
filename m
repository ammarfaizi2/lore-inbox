Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030331AbWFUV6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030331AbWFUV6E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 17:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030327AbWFUV5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 17:57:50 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:49930 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030325AbWFUV5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 17:57:41 -0400
Date: Wed, 21 Jun 2006 23:57:40 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, mingo@redhat.com, neilb@cse.unsw.edu.au
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: [-mm patch] drivers/md/md.c: make code static
Message-ID: <20060621215740.GM9111@stusta.de>
References: <20060621034857.35cfe36f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621034857.35cfe36f.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/md/md.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.17-mm1-full/drivers/md/md.c.old	2006-06-21 22:59:44.000000000 +0200
+++ linux-2.6.17-mm1-full/drivers/md/md.c	2006-06-21 23:00:02.000000000 +0200
@@ -175,7 +175,7 @@
 /* Alternate version that can be called from interrupts
  * when calling sysfs_notify isn't needed.
  */
-void md_new_event_inintr(mddev_t *mddev)
+static void md_new_event_inintr(mddev_t *mddev)
 {
 	atomic_inc(&md_event_count);
 	wake_up(&md_event_waiters);
@@ -2309,7 +2309,7 @@
  */
 enum array_state { clear, inactive, suspended, readonly, read_auto, clean, active,
 		   write_pending, active_idle, bad_word};
-char *array_states[] = {
+static char *array_states[] = {
 	"clear", "inactive", "suspended", "readonly", "read-auto", "clean", "active",
 	"write-pending", "active-idle", NULL };
 

