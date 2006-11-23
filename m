Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757284AbWKWRHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757284AbWKWRHX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 12:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757434AbWKWRHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 12:07:23 -0500
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:22217
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1757284AbWKWRHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 12:07:23 -0500
Date: Thu, 23 Nov 2006 17:06:43 +0000
To: Andrew Morton <akpm@osdl.org>
Cc: Andy Whitcroft <apw@shadowen.org>,
       Christoph Lameter <christoph@lameter.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] mm cleanup indentation on switch for CPU operations
Message-ID: <d3834f4738558732cf0c495e42352955@pinky>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mm: cleanup indentation on switch for CPU operations

These patches introduced new switch statements which are indented
contrary to the concensus in mm/*.c.  Fix them up to match that
concensus.

    [PATCH] node local per-cpu-pages
    [PATCH] ZVC: Scale thresholds depending on the size of the system
    commit e7c8d5c9955a4d2e88e36b640563f5d6d5aba48a
    commit df9ecaba3f152d1ea79f2a5e0b87505e03f47590

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 19ab611..21b0bfb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2220,16 +2220,16 @@ static int __cpuinit pageset_cpuup_callb
 	int ret = NOTIFY_OK;
 
 	switch (action) {
-		case CPU_UP_PREPARE:
-			if (process_zones(cpu))
-				ret = NOTIFY_BAD;
-			break;
-		case CPU_UP_CANCELED:
-		case CPU_DEAD:
-			free_zone_pagesets(cpu);
-			break;
-		default:
-			break;
+	case CPU_UP_PREPARE:
+		if (process_zones(cpu))
+			ret = NOTIFY_BAD;
+		break;
+	case CPU_UP_CANCELED:
+	case CPU_DEAD:
+		free_zone_pagesets(cpu);
+		break;
+	default:
+		break;
 	}
 	return ret;
 }
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 60dd793..696bc5c 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -685,13 +685,13 @@ static int __cpuinit vmstat_cpuup_callba
 		void *hcpu)
 {
 	switch (action) {
-		case CPU_UP_PREPARE:
-		case CPU_UP_CANCELED:
-		case CPU_DEAD:
-			refresh_zone_stat_thresholds();
-			break;
-		default:
-			break;
+	case CPU_UP_PREPARE:
+	case CPU_UP_CANCELED:
+	case CPU_DEAD:
+		refresh_zone_stat_thresholds();
+		break;
+	default:
+		break;
 	}
 	return NOTIFY_OK;
 }
