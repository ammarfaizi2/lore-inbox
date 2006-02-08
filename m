Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030497AbWBHDT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030497AbWBHDT4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 22:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030498AbWBHDTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 22:19:55 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:3969 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030495AbWBHDTw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 22:19:52 -0500
To: torvalds@osdl.org
Subject: [PATCH 24/29] amd64 time.c __iomem annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1F6fs0-0006E4-5u@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 03:19:52 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1138797033 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/x86_64/kernel/time.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

dd42b1518666132c21e7348c4b599c501f0021a1
diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
index c0844bf..dba7237 100644
--- a/arch/x86_64/kernel/time.c
+++ b/arch/x86_64/kernel/time.c
@@ -748,7 +748,7 @@ static __init int late_hpet_init(void)
 	 * Timer0 and Timer1 is used by platform.
 	 */
 	hd.hd_phys_address = vxtime.hpet_address;
-	hd.hd_address = (void *)fix_to_virt(FIX_HPET_BASE);
+	hd.hd_address = (void __iomem *)fix_to_virt(FIX_HPET_BASE);
 	hd.hd_nirqs = ntimer;
 	hd.hd_flags = HPET_DATA_PLATFORM;
 	hpet_reserve_timer(&hd, 0);
-- 
0.99.9.GIT

