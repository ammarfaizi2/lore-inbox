Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751909AbWFWSls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbWFWSls (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 14:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751906AbWFWSls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 14:41:48 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:15311 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751909AbWFWSlr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 14:41:47 -0400
Message-Id: <20060623183911.847605000@linux-m68k.org>
References: <20060623183056.479024000@linux-m68k.org>
User-Agent: quilt/0.44-1
Date: Fri, 23 Jun 2006 20:31:04 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 08/21] gcc 4 fix
Content-Disposition: inline; filename=0008-M68K-gcc-4-fix.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes a "static qualifier follows non-static qualifier" error from gcc 4.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 drivers/macintosh/via-pmu68k.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

35dfd8f879480cc93798d97ffcbff7eadf9e5f2e
diff --git a/drivers/macintosh/via-pmu68k.c b/drivers/macintosh/via-pmu68k.c
index 35b7032..50726d9 100644
--- a/drivers/macintosh/via-pmu68k.c
+++ b/drivers/macintosh/via-pmu68k.c
@@ -112,7 +112,6 @@ static int pmu_send_request(struct adb_r
 static int pmu_autopoll(int devs);
 void pmu_poll(void);
 static int pmu_reset_bus(void);
-static int pmu_queue_request(struct adb_request *req);
 
 static void pmu_start(void);
 static void send_byte(int x);
@@ -477,7 +476,7 @@ pmu_request(struct adb_request *req, voi
 	return pmu_queue_request(req);
 }
 
-static int 
+int
 pmu_queue_request(struct adb_request *req)
 {
 	unsigned long flags;
-- 
1.3.3

--

