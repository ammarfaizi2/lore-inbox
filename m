Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262754AbUKRMjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262754AbUKRMjc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 07:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262755AbUKRMjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 07:39:32 -0500
Received: from host62-24-231-113.dsl.vispa.com ([62.24.231.113]:42700 "EHLO
	cenedra.walrond.org") by vger.kernel.org with ESMTP id S262754AbUKRMja
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 07:39:30 -0500
From: Andrew Walrond <andrew@walrond.org>
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH: 2.6.10-rc2] fbdev: Fix rivafb breakage (typo introduced by cset 1.2563)
Date: Thu, 18 Nov 2004 12:39:18 +0000
User-Agent: KMail/1.7
Cc: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411181239.18093.andrew@walrond.org>
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo introduced during changes to use NV_ macros,
which caused screen corruption when using rivafb

signed-off-by: Andrew Walrond <andrew@walrond.org>


diff -Nru a/drivers/video/riva/riva_hw.c b/drivers/video/riva/riva_hw.c
--- a/drivers/video/riva/riva_hw.c      2004-11-18 12:32:15 +00:00
+++ b/drivers/video/riva/riva_hw.c      2004-11-18 12:32:15 +00:00
@@ -1556,7 +1556,7 @@
         NV_WR32(chip->PGRAPH, 0x0000085C, state->pitch3);
         NV_WR32(chip->PGRAPH, 0x00000860, state->pitch3);
         NV_WR32(chip->PGRAPH, 0x00000864, state->pitch3);
-        NV_WR32(chip->PGRAPH, 0x000009A, NV_RD32(chip->PFB, 0x00000200));
+        NV_WR32(chip->PGRAPH, 0x000009A4, NV_RD32(chip->PFB, 0x00000200));
         NV_WR32(chip->PGRAPH, 0x000009A8, NV_RD32(chip->PFB, 0x00000204));
         }
             if(chip->twoHeads) {
