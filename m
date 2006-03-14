Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751493AbWCNBJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbWCNBJX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 20:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751739AbWCNBJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 20:09:23 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:8403 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751493AbWCNBJW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 20:09:22 -0500
Date: Mon, 13 Mar 2006 19:08:57 -0600
From: Jon Mason <jdmason@us.ibm.com>
To: airlied@linux.ie
Cc: dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] sis: Fix compile warning (trivial)
Message-ID: <20060314010857.GF1805@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial patch to prevent a gcc warning in the SIS DRM driver.  offset is
a unsigned int and the printk wants a long.

Thanks,
Jon

Signed-off-by: Jon Mason <jdmason@us.ibm.com>

diff -r 96b636489b54 drivers/char/drm/sis_mm.c
--- a/drivers/char/drm/sis_mm.c	Sat Mar 11 18:29:09 2006
+++ b/drivers/char/drm/sis_mm.c	Sun Mar 12 11:03:57 2006
@@ -110,7 +110,7 @@
 
 	DRM_COPY_TO_USER_IOCTL(argp, fb, sizeof(fb));
 
-	DRM_DEBUG("alloc fb, size = %d, offset = %ld\n", fb.size, req.offset);
+	DRM_DEBUG("alloc fb, size = %d, offset = %d\n", fb.size, req.offset);
 
 	return retval;
 }
