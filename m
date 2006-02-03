Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422951AbWBCU7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422951AbWBCU7c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 15:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422953AbWBCU7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 15:59:31 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:54541 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422951AbWBCU7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 15:59:31 -0500
Date: Fri, 3 Feb 2006 21:59:29 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] kernel/timer.c: make some variables static
Message-ID: <20060203205929.GJ4408@stusta.de>
References: <20060203000704.3964a39f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060203000704.3964a39f.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 12:07:04AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.15-mm4:
>...
> +time-reduced-ntp-rework-part-2.patch
>...
>  Bring back John's time-reqork patches.  New, improved, fixed.
>...


This patch makes some needlessly global variables static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 kernel/timer.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- linux-2.6.16-rc1-mm5-full/kernel/timer.c.old	2006-02-03 20:05:54.000000000 +0100
+++ linux-2.6.16-rc1-mm5-full/kernel/timer.c	2006-02-03 20:07:35.000000000 +0100
@@ -590,12 +590,12 @@
 long time_reftime;			/* time at last adjustment (s)	*/
 long time_adjust;
 long time_next_adjust;
-long time_adjust_step;			/* per tick time_adjust step */
+static long time_adjust_step;		/* per tick time_adjust step */
 
-long total_sppm;			/* shifted ppm sum of all adjustments */
-long offset_adj_ppm;
-long tick_adj_ppm;
-long singleshot_adj_ppm;
+static long total_sppm;			/* shifted ppm sum of all adjustments */
+static long offset_adj_ppm;
+static long tick_adj_ppm;
+static long singleshot_adj_ppm;
 
 #define MAX_SINGLESHOT_ADJ	500	/* (ppm) */
 #define SEC_PER_DAY		86400
