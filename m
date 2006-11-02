Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752699AbWKBVtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752699AbWKBVtp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 16:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752685AbWKBVtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 16:49:45 -0500
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:60858 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1752650AbWKBVto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 16:49:44 -0500
From: muli@il.ibm.com
To: ak@suse.de
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org, muli@il.ibm.com,
       jdmason@kudzu.us
Subject: [PATCH 1/4] Calgary: phb_shift can be int
Reply-To: muli@il.ibm.com
Date: Thu, 02 Nov 2006 23:49:37 +0200
Message-Id: <11625041802816-git-send-email-muli@il.ibm.com>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <11625041803066-git-send-email-muli@il.ibm.com>
References: <11625041803066-git-send-email-muli@il.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Muli Ben-Yehuda <muli@il.ibm.com>

Signed-off-by: Muli Ben-Yehuda <muli@il.ibm.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
---
 arch/x86_64/kernel/pci-calgary.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/x86_64/kernel/pci-calgary.c b/arch/x86_64/kernel/pci-calgary.c
index 37a7708..31d5758 100644
--- a/arch/x86_64/kernel/pci-calgary.c
+++ b/arch/x86_64/kernel/pci-calgary.c
@@ -740,7 +740,7 @@ static void __init calgary_increase_spli
 {
 	u64 val64;
 	void __iomem *target;
-	unsigned long phb_shift = -1;
+	unsigned int phb_shift = ~0; /* silence gcc */
 	u64 mask;
 
 	switch (busno_to_phbid(busnum)) {
-- 
1.4.1

