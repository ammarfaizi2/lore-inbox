Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965163AbWD0SDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965163AbWD0SDQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 14:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965165AbWD0SDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 14:03:16 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:5382 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965163AbWD0SDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 14:03:15 -0400
Date: Thu, 27 Apr 2006 20:03:14 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] mm/vmscan.c: make shrink_all_zones() static
Message-ID: <20060427180314.GJ3570@stusta.de>
References: <20060427014141.06b88072.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060427014141.06b88072.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2006 at 01:41:41AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.17-rc1-mm3:
>...
> +swsusp-rework-memory-shrinker-rev-2.patch
> 
>  Memory management updates
>...


This patch makes the needlessly global shrink_all_zones() static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-rc2-mm1-full/mm/vmscan.c.old	2006-04-27 18:09:55.000000000 +0200
+++ linux-2.6.17-rc2-mm1-full/mm/vmscan.c	2006-04-27 18:10:14.000000000 +0200
@@ -1291,8 +1291,8 @@
  *
  * For pass > 3 we also try to shrink the LRU lists that contain a few pages
  */
-unsigned long shrink_all_zones(unsigned long nr_pages, int pass, int prio,
-				struct scan_control *sc)
+static unsigned long shrink_all_zones(unsigned long nr_pages, int pass,
+				      int prio, struct scan_control *sc)
 {
 	struct zone *zone;
 	unsigned long nr_to_scan, ret = 0;

