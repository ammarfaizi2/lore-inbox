Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbVAAM07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbVAAM07 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 07:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbVAAM07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 07:26:59 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:49581 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261482AbVAAM0u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 07:26:50 -0500
Date: Sat, 1 Jan 2005 12:26:48 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [bk tree] drm minor fix for i810/i830
Message-ID: <Pine.LNX.4.58.0501011226090.31145@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please do a

	bk pull bk://drm.bkbits.net/drm-linus

This will include the latest DRM changes and will update the following files:

 drivers/char/drm/i810_drv.c |    2 +-
 drivers/char/drm/i830_drv.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

through these ChangeSets:

<airlied@starflyer.(none)> (05/01/01 1.2090)
   drm: core changes broke i810/830

   Reported by Joseph Fannin during -mm, revert incorrect change.

   Signed-off-by: Dave Airlie <airlied@linux.ie>

diff -Nru a/drivers/char/drm/i810_drv.c b/drivers/char/drm/i810_drv.c
--- a/drivers/char/drm/i810_drv.c	2005-01-01 23:25:09 +11:00
+++ b/drivers/char/drm/i810_drv.c	2005-01-01 23:25:09 +11:00
@@ -112,7 +112,7 @@
 		.open = drm_open,
 		.release = drm_release,
 		.ioctl = drm_ioctl,
-		.mmap = i810_mmap_buffers,
+		.mmap = drm_mmap,
 		.poll = drm_poll,
 		.fasync = drm_fasync,
 	},
diff -Nru a/drivers/char/drm/i830_drv.c b/drivers/char/drm/i830_drv.c
--- a/drivers/char/drm/i830_drv.c	2005-01-01 23:25:09 +11:00
+++ b/drivers/char/drm/i830_drv.c	2005-01-01 23:25:09 +11:00
@@ -121,7 +121,7 @@
 		.open = drm_open,
 		.release = drm_release,
 		.ioctl = drm_ioctl,
-		.mmap = i830_mmap_buffers,
+		.mmap = drm_mmap,
 		.poll = drm_poll,
 		.fasync = drm_fasync,
 	},
