Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbWHJUEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWHJUEz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWHJUEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:04:36 -0400
Received: from mail.suse.de ([195.135.220.2]:55184 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932634AbWHJTgi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:38 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [80/145] x86_64: Calgary IOMMU: save a bit of space in bus_info
Message-Id: <20060810193636.E146C13C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:36 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Muli Ben-Yehuda <muli@il.ibm.com>

Make translation_disabled a uchar rather than an int

Signed-off-by: Muli Ben-Yehuda <muli@il.ibm.com>
Signed-off-by: Jon Mason <jdmason@us.ibm.com>
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/pci-calgary.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux/arch/x86_64/kernel/pci-calgary.c
===================================================================
--- linux.orig/arch/x86_64/kernel/pci-calgary.c
+++ linux/arch/x86_64/kernel/pci-calgary.c
@@ -117,7 +117,7 @@ static int calgary_detected __read_mostl
 
 struct calgary_bus_info {
 	void *tce_space;
-	int translation_disabled;
+	unsigned char translation_disabled;
 	signed char phbid;
 };
 
