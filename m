Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbVFZMNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVFZMNt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 08:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVFZMNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 08:13:49 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:28360 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261179AbVFZMNN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 08:13:13 -0400
Date: Sun, 26 Jun 2005 13:13:06 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [git patch] DRM fixes tree..
Message-ID: <Pine.LNX.4.58.0506261311490.3269@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,
	Please pull from the 'drm-fixes' branch of

rsync://rsync.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6.git

This contains some minor fixes and some missing license texts for the 2.6 DRM,

 Kconfig      |    2 +-
 i915_dma.c   |   24 ++++++++++++++++++++++--
 i915_drm.h   |   27 +++++++++++++++++++++++++++
 i915_drv.c   |   25 ++++++++++++++++++++++---
 i915_drv.h   |   24 ++++++++++++++++++++++--
 i915_irq.c   |   24 ++++++++++++++++++++++--
 i915_mem.c   |   24 ++++++++++++++++++++++--
 radeon_irq.c |   27 +++++++++++++--------------
 8 files changed, 151 insertions(+), 26 deletions(-)

commit 6921e3310486a6e5ac3f36efcc7351347503c71a
tree 1f8c95202f24a91f992ae70217f5d58d84399b75
parent bc54fd1ad3c5972be339a08528ab631326ed2b38
author Dave Airlie <airlied@starflyer.(none)> Sun, 26 Jun 2005 21:05:59 +1000
committer Dave Airlie <airlied@linux.ie> Sun, 26 Jun 2005 21:05:59 +1000

drm: fix radeon irq properly

After the previous fix in 2.6.12, this patch should properly fix the
radeon IRQ handling code.

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Dave Airlie <airlied@linux.ie>

--------------------------
commit bc54fd1ad3c5972be339a08528ab631326ed2b38
tree d36676353bacd0ea423a6d53f171eb7753ec23ab
parent cfd9e15f78fc6efe88ea8cb0722a731b331cfd80
author Dave Airlie <airlied@starflyer.(none)> Thu, 23 Jun 2005 22:46:46 +1000
committer Dave Airlie <airlied@linux.ie> Thu, 23 Jun 2005 22:46:46 +1000

Add missing license texts from Tungsten Graphics.

From: Alan Hourihane
Signed-off-by: David Airlie <airlied@linux.ie>

--------------------------
commit cfd9e15f78fc6efe88ea8cb0722a731b331cfd80
tree 7dacff76a35805c52a067305c4a535c2a27bffa1
parent ee98689be1b054897ff17655008c3048fe88be94
author Dave Airlie <airlied@starflyer.(none)> Thu, 23 Jun 2005 22:43:00 +1000
committer Dave Airlie <airlied@linux.ie> Thu, 23 Jun 2005 22:43:00 +1000

Currently DRM depends on PCI this will need to change for ffb on Sparc to
be fixed but at the moment it is true.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Dave Airlie <airlied@linux.ie>

--------------------------
diff --git a/drivers/char/drm/Kconfig b/drivers/char/drm/Kconfig
--- a/drivers/char/drm/Kconfig
+++ b/drivers/char/drm/Kconfig
@@ -6,7 +6,7 @@
 #
 config DRM
 	tristate "Direct Rendering Manager (XFree86 4.1.0 and higher DRI support)"
-	depends on AGP || AGP=n
+	depends on (AGP || AGP=n) && PCI
 	help
 	  Kernel-level support for the Direct Rendering Infrastructure (DRI)
 	  introduced in XFree86 4.0. If you say Y here, you need to select
diff --git a/drivers/char/drm/i915_dma.c b/drivers/char/drm/i915_dma.c
--- a/drivers/char/drm/i915_dma.c
+++ b/drivers/char/drm/i915_dma.c
@@ -1,10 +1,30 @@
 /* i915_dma.c -- DMA support for the I915 -*- linux-c -*-
  */
 /**************************************************************************
- *
+ *
  * Copyright 2003 Tungsten Graphics, Inc., Cedar Park, Texas.
  * All Rights Reserved.
- *
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the
+ * "Software"), to deal in the Software without restriction, including
+ * without limitation the rights to use, copy, modify, merge, publish,
+ * distribute, sub license, and/or sell copies of the Software, and to
+ * permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the
+ * next paragraph) shall be included in all copies or substantial portions
+ * of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT.
+ * IN NO EVENT SHALL TUNGSTEN GRAPHICS AND/OR ITS SUPPLIERS BE LIABLE FOR
+ * ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
+ * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
+ * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ *
  **************************************************************************/

 #include "drmP.h"
diff --git a/drivers/char/drm/i915_drm.h b/drivers/char/drm/i915_drm.h
--- a/drivers/char/drm/i915_drm.h
+++ b/drivers/char/drm/i915_drm.h
@@ -1,3 +1,30 @@
+/**************************************************************************
+ *
+ * Copyright 2003 Tungsten Graphics, Inc., Cedar Park, Texas.
+ * All Rights Reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the
+ * "Software"), to deal in the Software without restriction, including
+ * without limitation the rights to use, copy, modify, merge, publish,
+ * distribute, sub license, and/or sell copies of the Software, and to
+ * permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the
+ * next paragraph) shall be included in all copies or substantial portions
+ * of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT.
+ * IN NO EVENT SHALL TUNGSTEN GRAPHICS AND/OR ITS SUPPLIERS BE LIABLE FOR
+ * ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
+ * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
+ * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ *
+ **************************************************************************/
+
 #ifndef _I915_DRM_H_
 #define _I915_DRM_H_

diff --git a/drivers/char/drm/i915_drv.c b/drivers/char/drm/i915_drv.c
--- a/drivers/char/drm/i915_drv.c
+++ b/drivers/char/drm/i915_drv.c
@@ -1,11 +1,30 @@
 /* i915_drv.c -- i830,i845,i855,i865,i915 driver -*- linux-c -*-
  */
-
 /**************************************************************************
- *
+ *
  * Copyright 2003 Tungsten Graphics, Inc., Cedar Park, Texas.
  * All Rights Reserved.
- *
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the
+ * "Software"), to deal in the Software without restriction, including
+ * without limitation the rights to use, copy, modify, merge, publish,
+ * distribute, sub license, and/or sell copies of the Software, and to
+ * permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the
+ * next paragraph) shall be included in all copies or substantial portions
+ * of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT.
+ * IN NO EVENT SHALL TUNGSTEN GRAPHICS AND/OR ITS SUPPLIERS BE LIABLE FOR
+ * ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
+ * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
+ * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ *
  **************************************************************************/

 #include "drmP.h"
diff --git a/drivers/char/drm/i915_drv.h b/drivers/char/drm/i915_drv.h
--- a/drivers/char/drm/i915_drv.h
+++ b/drivers/char/drm/i915_drv.h
@@ -1,10 +1,30 @@
 /* i915_drv.h -- Private header for the I915 driver -*- linux-c -*-
  */
 /**************************************************************************
- *
+ *
  * Copyright 2003 Tungsten Graphics, Inc., Cedar Park, Texas.
  * All Rights Reserved.
- *
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the
+ * "Software"), to deal in the Software without restriction, including
+ * without limitation the rights to use, copy, modify, merge, publish,
+ * distribute, sub license, and/or sell copies of the Software, and to
+ * permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the
+ * next paragraph) shall be included in all copies or substantial portions
+ * of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT.
+ * IN NO EVENT SHALL TUNGSTEN GRAPHICS AND/OR ITS SUPPLIERS BE LIABLE FOR
+ * ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
+ * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
+ * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ *
  **************************************************************************/

 #ifndef _I915_DRV_H_
diff --git a/drivers/char/drm/i915_irq.c b/drivers/char/drm/i915_irq.c
--- a/drivers/char/drm/i915_irq.c
+++ b/drivers/char/drm/i915_irq.c
@@ -1,10 +1,30 @@
 /* i915_dma.c -- DMA support for the I915 -*- linux-c -*-
  */
 /**************************************************************************
- *
+ *
  * Copyright 2003 Tungsten Graphics, Inc., Cedar Park, Texas.
  * All Rights Reserved.
- *
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the
+ * "Software"), to deal in the Software without restriction, including
+ * without limitation the rights to use, copy, modify, merge, publish,
+ * distribute, sub license, and/or sell copies of the Software, and to
+ * permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the
+ * next paragraph) shall be included in all copies or substantial portions
+ * of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT.
+ * IN NO EVENT SHALL TUNGSTEN GRAPHICS AND/OR ITS SUPPLIERS BE LIABLE FOR
+ * ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
+ * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
+ * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ *
  **************************************************************************/

 #include "drmP.h"
diff --git a/drivers/char/drm/i915_mem.c b/drivers/char/drm/i915_mem.c
--- a/drivers/char/drm/i915_mem.c
+++ b/drivers/char/drm/i915_mem.c
@@ -1,10 +1,30 @@
 /* i915_mem.c -- Simple agp/fb memory manager for i915 -*- linux-c -*-
  */
 /**************************************************************************
- *
+ *
  * Copyright 2003 Tungsten Graphics, Inc., Cedar Park, Texas.
  * All Rights Reserved.
- *
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the
+ * "Software"), to deal in the Software without restriction, including
+ * without limitation the rights to use, copy, modify, merge, publish,
+ * distribute, sub license, and/or sell copies of the Software, and to
+ * permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the
+ * next paragraph) shall be included in all copies or substantial portions
+ * of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT.
+ * IN NO EVENT SHALL TUNGSTEN GRAPHICS AND/OR ITS SUPPLIERS BE LIABLE FOR
+ * ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
+ * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
+ * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ *
  **************************************************************************/

 #include "drmP.h"
diff --git a/drivers/char/drm/radeon_irq.c b/drivers/char/drm/radeon_irq.c
--- a/drivers/char/drm/radeon_irq.c
+++ b/drivers/char/drm/radeon_irq.c
@@ -35,6 +35,14 @@
 #include "radeon_drm.h"
 #include "radeon_drv.h"

+static __inline__ u32 radeon_acknowledge_irqs(drm_radeon_private_t *dev_priv, u32 mask)
+{
+	u32 irqs = RADEON_READ(RADEON_GEN_INT_STATUS) & mask;
+	if (irqs)
+		RADEON_WRITE(RADEON_GEN_INT_STATUS, irqs);
+	return irqs;
+}
+
 /* Interrupts - Used for device synchronization and flushing in the
  * following circumstances:
  *
@@ -63,8 +71,8 @@ irqreturn_t radeon_driver_irq_handler( D
 	/* Only consider the bits we're interested in - others could be used
 	 * outside the DRM
 	 */
-	stat = RADEON_READ(RADEON_GEN_INT_STATUS)
-	     & (RADEON_SW_INT_TEST | RADEON_CRTC_VBLANK_STAT);
+	stat = radeon_acknowledge_irqs(dev_priv, (RADEON_SW_INT_TEST_ACK |
+						  RADEON_CRTC_VBLANK_STAT));
 	if (!stat)
 		return IRQ_NONE;

@@ -80,19 +88,9 @@ irqreturn_t radeon_driver_irq_handler( D
 		drm_vbl_send_signals( dev );
 	}

-	/* Acknowledge interrupts we handle */
-	RADEON_WRITE(RADEON_GEN_INT_STATUS, stat);
 	return IRQ_HANDLED;
 }

-static __inline__ void radeon_acknowledge_irqs(drm_radeon_private_t *dev_priv)
-{
-	u32 tmp = RADEON_READ( RADEON_GEN_INT_STATUS )
-		& (RADEON_SW_INT_TEST_ACK | RADEON_CRTC_VBLANK_STAT);
-	if (tmp)
-		RADEON_WRITE( RADEON_GEN_INT_STATUS, tmp );
-}
-
 static int radeon_emit_irq(drm_device_t *dev)
 {
 	drm_radeon_private_t *dev_priv = dev->dev_private;
@@ -141,7 +139,7 @@ int radeon_driver_vblank_wait(drm_device
 		return DRM_ERR(EINVAL);
 	}

-	radeon_acknowledge_irqs( dev_priv );
+	radeon_acknowledge_irqs(dev_priv, RADEON_CRTC_VBLANK_STAT);

 	dev_priv->stats.boxes |= RADEON_BOX_WAIT_IDLE;

@@ -219,7 +217,8 @@ void radeon_driver_irq_preinstall( drm_d
       	RADEON_WRITE( RADEON_GEN_INT_CNTL, 0 );

 	/* Clear bits if they're already high */
-	radeon_acknowledge_irqs( dev_priv );
+	radeon_acknowledge_irqs(dev_priv, (RADEON_SW_INT_TEST_ACK |
+					   RADEON_CRTC_VBLANK_STAT));
 }

 void radeon_driver_irq_postinstall( drm_device_t *dev ) {
