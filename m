Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262046AbUDYBUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262046AbUDYBUe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 21:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbUDYBUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 21:20:34 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:53196 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262046AbUDYBUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 21:20:31 -0400
Date: Sun, 25 Apr 2004 03:20:27 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, faith@valinux.com, gareth@valinux.com
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
Subject: [patch] 2.6.6-rc2-mm1: drm_irq.h has useless __NO_VERSION__
Message-ID: <20040425012027.GD895@fs.tum.de>
References: <20040421014544.37942eb4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040421014544.37942eb4.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2004 at 01:45:44AM -0700, Andrew Morton wrote:
>...
> All 222 patches:
>...
> bk-drm.patch
>...

The drivers/char/drm/drm_irq.h in this patch contains a
  #define __NO_VERSION__
which is useless since ages.

The patch below removes it.

Please apply
Adrian


--- linux-2.6.6-rc2-mm1-full/drivers/char/drm/drm_irq.h.old	2004-04-25 03:14:24.000000000 +0200
+++ linux-2.6.6-rc2-mm1-full/drivers/char/drm/drm_irq.h	2004-04-25 03:14:35.000000000 +0200
@@ -33,7 +33,6 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#define __NO_VERSION__
 #include "drmP.h"
 
 #include <linux/interrupt.h>	/* For task queue support */

