Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbVIZVB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbVIZVB6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 17:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbVIZVB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 17:01:58 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:55560 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1750805AbVIZVB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 17:01:57 -0400
Date: Mon, 26 Sep 2005 17:01:20 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, discuss@x86-64.org,
       linux-ia64@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Cc: ak@suse.de, tony.luck@intel.com, Asit.K.Mallick@intel.com, gregkh@suse.de
Subject: [patch 2.6.14-rc2 5/5] swiotlb: file header comments
Message-ID: <09262005170120.15941@bilbo.tuxdriver.com>
In-Reply-To: <09262005170120.15877@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change comment at top of swiotlb.c to reflect that the code is shared
with EM64T (i.e. Intel x86_64). Also add an entry for myself so that
if I "broke it", everyone knows who "bought it"... :-)

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/pci/swiotlb.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/swiotlb.c b/drivers/pci/swiotlb.c
--- a/drivers/pci/swiotlb.c
+++ b/drivers/pci/swiotlb.c
@@ -1,7 +1,7 @@
 /*
  * Dynamic DMA mapping support.
  *
- * This implementation is for IA-64 platforms that do not support
+ * This implementation is for IA-64 and EM64T platforms that do not support
  * I/O TLBs (aka DMA address translation hardware).
  * Copyright (C) 2000 Asit Mallick <Asit.K.Mallick@intel.com>
  * Copyright (C) 2000 Goutham Rao <goutham.rao@intel.com>
@@ -11,7 +11,9 @@
  * 03/05/07 davidm	Switch from PCI-DMA to generic device DMA API.
  * 00/12/13 davidm	Rename to swiotlb.c and add mark_clean() to avoid
  *			unnecessary i-cache flushing.
- * 04/07/.. ak          Better overflow handling. Assorted fixes.
+ * 04/07/.. ak		Better overflow handling. Assorted fixes.
+ * 05/09/10 linville	Add support for syncing ranges, support syncing for
+ *			DMA_BIDIRECTIONAL mappings, miscellaneous cleanup.
  */
 
 #include <linux/cache.h>
