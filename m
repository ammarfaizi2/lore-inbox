Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbWGZJeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWGZJeI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 05:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbWGZJeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 05:34:08 -0400
Received: from mail29.messagelabs.com ([216.82.249.147]:52167 "HELO
	mail29.messagelabs.com") by vger.kernel.org with SMTP
	id S1751014AbWGZJeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 05:34:07 -0400
X-VirusChecked: Checked
X-Env-Sender: Uwe_Zeisberger@digi.com
X-Msg-Ref: server-16.tower-29.messagelabs.com!1153906446!27796366!1
X-StarScan-Version: 5.5.10.7; banners=-,-,-
X-Originating-IP: [66.77.174.21]
Date: Wed, 26 Jul 2006 11:33:09 +0200
From: Uwe Zeisberger <Uwe_Zeisberger@digi.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Add parenthesis around arguments in the SH_DIV macro.
Message-ID: <20060726093308.GA23035@digi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
X-OriginalArrivalTime: 26 Jul 2006 09:34:04.0040 (UTC) FILETIME=[A2412880:01C6B096]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is currently no affected user in the tree, but
usage is less surprising that way.

Signed-off-by: Uwe Zeisberger <Uwe_Zeisberger@digi.com>
---

 include/linux/jiffies.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
index 0433769..329ebcf 100644
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -47,8 +47,8 @@ #define LATCH_HPET ((HPET_TICK_RATE + HZ
  *   - (NOM / DEN) fits in (32 - LSH) bits.
  *   - (NOM % DEN) fits in (32 - LSH) bits.
  */
-#define SH_DIV(NOM,DEN,LSH) (   ((NOM / DEN) << LSH)                    \
-                             + (((NOM % DEN) << LSH) + DEN / 2) / DEN)
+#define SH_DIV(NOM,DEN,LSH) (   (((NOM) / (DEN)) << (LSH))              \
+                             + ((((NOM) % (DEN)) << (LSH)) + (DEN) / 2) / (DEN))
 
 /* HZ is the requested value. ACTHZ is actual HZ ("<< 8" is for accuracy) */
 #define ACTHZ (SH_DIV (CLOCK_TICK_RATE, LATCH, 8))
-- 
1.4.2.rc1.g83e1


-- 
Uwe Zeisberger
FS Forth-Systeme GmbH, A Digi International Company
Kueferstrasse 8, D-79206 Breisach, Germany
Phone: +49 (7667) 908 0 Fax: +49 (7667) 908 200
Web: www.fsforth.de, www.digi.com
