Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbVLOVZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbVLOVZQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 16:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbVLOVZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 16:25:15 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:41226 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751111AbVLOVYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 16:24:54 -0500
Date: Thu, 15 Dec 2005 22:24:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Neil Brown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [-mm patch] drivers/md/md.c: make md_new_event() static
Message-ID: <20051215212455.GT23349@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the needlessly global function md_new_event() static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-rc5-mm3-full/drivers/md/md.c.old	2005-12-15 15:51:16.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/drivers/md/md.c	2005-12-15 15:51:31.000000000 +0100
@@ -156,11 +156,11 @@
  *  start array, stop array, error, add device, remove device,
  *  start build, activate spare
  */
 static DECLARE_WAIT_QUEUE_HEAD(md_event_waiters);
 static atomic_t md_event_count;
-void md_new_event(mddev_t *mddev)
+static void md_new_event(mddev_t *mddev)
 {
 	atomic_inc(&md_event_count);
 	wake_up(&md_event_waiters);
 }
 

