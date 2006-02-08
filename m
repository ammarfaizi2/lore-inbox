Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161049AbWBHHL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161049AbWBHHL6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 02:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161050AbWBHHL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 02:11:26 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:40604 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161049AbWBHHK4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 02:10:56 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 10/17] fix iomem annotations in dart_iommu
Cc: linuxppc-dev@ozlabs.org
Message-Id: <E1F6jTc-0002bA-1c@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 07:10:56 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1138796882 -0500

it's int __iomem *, not int * __iomem...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/powerpc/sysdev/dart_iommu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

6fa2ffe901c77cdd8db9616db66894e96c12143d
diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_iommu.c
index 977de9d..6298264 100644
--- a/arch/powerpc/sysdev/dart_iommu.c
+++ b/arch/powerpc/sysdev/dart_iommu.c
@@ -59,7 +59,7 @@ static unsigned long dart_tablesize;
 static u32 *dart_vbase;
 
 /* Mapped base address for the dart */
-static unsigned int *__iomem dart;
+static unsigned int __iomem *dart;
 
 /* Dummy val that entries are set to when unused */
 static unsigned int dart_emptyval;
-- 
0.99.9.GIT

