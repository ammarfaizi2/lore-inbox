Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262326AbVAUKgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262326AbVAUKgz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 05:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262332AbVAUKgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 05:36:55 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:60433 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262326AbVAUKgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 05:36:45 -0500
Date: Fri, 21 Jan 2005 11:36:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: dri-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drm_memory.h doesn't need to #include tlbflush.h
Message-ID: <20050121103642.GI3209@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The flush_tlb_kernel_range call in drm_memory.h was removed in 2003, so 
there's no more reason for this #include.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc1-mm2-full/drivers/char/drm/drm_memory.h.old	2005-01-21 11:21:15.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/drivers/char/drm/drm_memory.h	2005-01-21 11:21:20.000000000 +0100
@@ -57,8 +57,6 @@
 # endif
 #endif
 
-#include <asm/tlbflush.h>
-
 /*
  * Find the drm_map that covers the range [offset, offset+size).
  */

