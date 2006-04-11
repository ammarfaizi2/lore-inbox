Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbWDKNyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWDKNyj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 09:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbWDKNyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 09:54:39 -0400
Received: from 213-140-2-68.ip.fastwebnet.it ([213.140.2.68]:33721 "EHLO
	aa001msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1750812AbWDKNyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 09:54:39 -0400
Date: Tue, 11 Apr 2006 15:54:46 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Andi Kleen <ak@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix a typo in for loop
Message-ID: <20060411155446.0ef2f89c@localhost>
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.12; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a typo in a for loop, "i" should be "k".

Signed-off-by: Paolo Ornati <ornati@fastwebnet.it>

---

diff --git a/arch/x86_64/pci/mmconfig.c b/arch/x86_64/pci/mmconfig.c
index b493ed9..a1f88f0 100644
--- a/arch/x86_64/pci/mmconfig.c
+++ b/arch/x86_64/pci/mmconfig.c
@@ -142,7 +142,7 @@ static __init void unreachable_devices(v
 {
 	int i, k;
 	/* Use the max bus number from ACPI here? */
-	for (k = 0; i < MAX_CHECK_BUS; k++) {
+	for (k = 0; k < MAX_CHECK_BUS; k++) {
 		for (i = 0; i < 32; i++) {
 			u32 val1;
 			char __iomem *addr;


-- 
	Paolo Ornati
	Linux 2.6.16.2 on x86_64
