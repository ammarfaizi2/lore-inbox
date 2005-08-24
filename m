Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751052AbVHXPnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbVHXPnN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 11:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbVHXPnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 11:43:13 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:21253 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751052AbVHXPnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 11:43:13 -0400
Date: Wed, 24 Aug 2005 17:43:11 +0200
From: Adrian Bunk <bunk@stusta.de>
To: airlied@linux.ie
Cc: dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/drm/: small cleanups
Message-ID: <20050824154311.GD4851@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following small cleanups:
- make two needlessly global functions static
- drm_sysfs.c: every file should #include the header with the prototypes 
               of the global functions it is offering


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/char/drm/drm_bufs.c    |    2 +-
 drivers/char/drm/drm_context.c |    2 +-
 drivers/char/drm/drm_sysfs.c   |    1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

--- linux-2.6.13-rc6-mm2-full/drivers/char/drm/drm_bufs.c.old	2005-08-24 16:55:50.000000000 +0200
+++ linux-2.6.13-rc6-mm2-full/drivers/char/drm/drm_bufs.c	2005-08-24 16:56:06.000000000 +0200
@@ -1041,7 +1041,7 @@
 	return 0;
 }
 
-int drm_addbufs_fb(drm_device_t *dev, drm_buf_desc_t *request)
+static int drm_addbufs_fb(drm_device_t *dev, drm_buf_desc_t *request)
 {
 	drm_device_dma_t *dma = dev->dma;
 	drm_buf_entry_t *entry;
--- linux-2.6.13-rc6-mm2-full/drivers/char/drm/drm_context.c.old	2005-08-24 16:56:29.000000000 +0200
+++ linux-2.6.13-rc6-mm2-full/drivers/char/drm/drm_context.c	2005-08-24 16:56:42.000000000 +0200
@@ -308,7 +308,7 @@
  *
  * Attempt to set drm_device::context_flag.
  */
-int drm_context_switch( drm_device_t *dev, int old, int new )
+static int drm_context_switch( drm_device_t *dev, int old, int new )
 {
         if ( test_and_set_bit( 0, &dev->context_flag ) ) {
                 DRM_ERROR( "Reentering -- FIXME\n" );
--- linux-2.6.13-rc6-mm2-full/drivers/char/drm/drm_sysfs.c.old	2005-08-24 16:57:02.000000000 +0200
+++ linux-2.6.13-rc6-mm2-full/drivers/char/drm/drm_sysfs.c	2005-08-24 16:57:20.000000000 +0200
@@ -17,6 +17,7 @@
 #include <linux/err.h>
 
 #include "drm_core.h"
+#include "drmP.h"
 
 struct drm_sysfs_class {
 	struct class_device_attribute attr;

