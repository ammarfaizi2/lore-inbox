Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932716AbWHJT71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932716AbWHJT71 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932688AbWHJT70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:59:26 -0400
Received: from ns2.suse.de ([195.135.220.15]:65259 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932655AbWHJTg7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:59 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [100/145] x86_64: Fix broken indentation in iommu_setup
Message-Id: <20060810193658.18E0613C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:58 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

No functional changes; only white space.

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/pci-dma.c |   86 ++++++++++++++++++++-----------------------
 1 files changed, 40 insertions(+), 46 deletions(-)

Index: linux/arch/x86_64/kernel/pci-dma.c
===================================================================
--- linux.orig/arch/x86_64/kernel/pci-dma.c
+++ linux/arch/x86_64/kernel/pci-dma.c
@@ -272,58 +272,52 @@ EXPORT_SYMBOL(dma_set_mask);
 */
 __init int iommu_setup(char *p)
 {
-    iommu_merge = 1;
-
+	iommu_merge = 1;
 	if (!p)
 		return -EINVAL;
-
-    while (*p) {
-	    if (!strncmp(p,"off",3))
-		    no_iommu = 1;
-	    /* gart_parse_options has more force support */
-	    if (!strncmp(p,"force",5))
-		    force_iommu = 1;
-	    if (!strncmp(p,"noforce",7)) {
-		    iommu_merge = 0;
-		    force_iommu = 0;
-	    }
-
-	    if (!strncmp(p, "biomerge",8)) {
-		    iommu_bio_merge = 4096;
-		    iommu_merge = 1;
-		    force_iommu = 1;
-	    }
-	    if (!strncmp(p, "panic",5))
-		    panic_on_overflow = 1;
-	    if (!strncmp(p, "nopanic",7))
-		    panic_on_overflow = 0;
-	    if (!strncmp(p, "merge",5)) {
-		    iommu_merge = 1;
-		    force_iommu = 1;
-	    }
-	    if (!strncmp(p, "nomerge",7))
-		    iommu_merge = 0;
-	    if (!strncmp(p, "forcesac",8))
-		    iommu_sac_force = 1;
-	    if (!strncmp(p, "allowdac", 8))
-		    allow_dac = 1;
-	    if (!strncmp(p, "nodac", 5))
-		    allow_dac = -1;
-
+	while (*p) {
+		if (!strncmp(p,"off",3))
+			no_iommu = 1;
+		/* gart_parse_options has more force support */
+		if (!strncmp(p,"force",5))
+			force_iommu = 1;
+		if (!strncmp(p,"noforce",7)) {
+			iommu_merge = 0;
+			force_iommu = 0;
+		}
+		if (!strncmp(p, "biomerge",8)) {
+			iommu_bio_merge = 4096;
+			iommu_merge = 1;
+			force_iommu = 1;
+		}
+		if (!strncmp(p, "panic",5))
+			panic_on_overflow = 1;
+		if (!strncmp(p, "nopanic",7))
+			panic_on_overflow = 0;
+		if (!strncmp(p, "merge",5)) {
+			iommu_merge = 1;
+			force_iommu = 1;
+		}
+		if (!strncmp(p, "nomerge",7))
+			iommu_merge = 0;
+		if (!strncmp(p, "forcesac",8))
+			iommu_sac_force = 1;
+		if (!strncmp(p, "allowdac", 8))
+			allow_dac = 1;
+		if (!strncmp(p, "nodac", 5))
+			allow_dac = -1;
 #ifdef CONFIG_SWIOTLB
-	    if (!strncmp(p, "soft",4))
-		    swiotlb = 1;
+		if (!strncmp(p, "soft",4))
+			swiotlb = 1;
 #endif
-
 #ifdef CONFIG_IOMMU
-	    gart_parse_options(p);
+		gart_parse_options(p);
 #endif
-
-	    p += strcspn(p, ",");
-	    if (*p == ',')
-		    ++p;
-    }
-    return 0;
+		p += strcspn(p, ",");
+		if (*p == ',')
+			++p;
+	}
+	return 0;
 }
 early_param("iommu", iommu_setup);
 
