Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424864AbWKQBUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424864AbWKQBUE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 20:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424876AbWKQBUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 20:20:03 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:60424 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1424864AbWKQBTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 20:19:55 -0500
Date: Fri, 17 Nov 2006 02:19:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: dm-devel@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] make drivers/md/dm-snap.c:ksnapd static
Message-ID: <20061117011954.GU31879@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the needlessly global "ksnapd" static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc5-mm2/drivers/md/dm-snap.c.old	2006-11-16 23:22:56.000000000 +0100
+++ linux-2.6.19-rc5-mm2/drivers/md/dm-snap.c	2006-11-16 23:23:06.000000000 +0100
@@ -39,7 +39,7 @@
  */
 #define SNAPSHOT_PAGES 256
 
-struct workqueue_struct *ksnapd;
+static struct workqueue_struct *ksnapd;
 static void flush_queued_bios(void *data);
 
 struct pending_exception {

