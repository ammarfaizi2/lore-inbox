Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266218AbUITK5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266218AbUITK5W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 06:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266195AbUITK5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 06:57:22 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:61319 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S266236AbUITK4D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 06:56:03 -0400
Date: Mon, 20 Sep 2004 11:55:58 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [bk tree] [drm] minor macro removal fix...
Message-ID: <Pine.LNX.4.58.0409201154370.9233@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

This is just another fix for a bug from the macro removal..

Please do a

	bk pull bk://drm.bkbits.net/drm-2.6

This will include the latest DRM changes and will update the following files:

 drivers/char/drm/drm_scatter.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

through these ChangeSets:

<airlied@starflyer.(none)> (04/09/20 1.1940)
   drm: complete fix for drm_scatter.h

   Another issue from the macro conversion.

   Signed-off-by: Dave Airlie <airlied@linux.ie>

diff -Nru a/drivers/char/drm/drm_scatter.h b/drivers/char/drm/drm_scatter.h
--- a/drivers/char/drm/drm_scatter.h	Mon Sep 20 20:52:05 2004
+++ b/drivers/char/drm/drm_scatter.h	Mon Sep 20 20:52:05 2004
@@ -209,7 +209,7 @@
 	drm_scatter_gather_t request;
 	drm_sg_mem_t *entry;

-	if (drm_core_check_feature(dev, DRIVER_SG))
+	if (!drm_core_check_feature(dev, DRIVER_SG))
 		return -EINVAL;

 	if ( copy_from_user( &request,
