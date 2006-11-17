Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933585AbWKQNK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933585AbWKQNK1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 08:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933586AbWKQNK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 08:10:27 -0500
Received: from mgw-ext13.nokia.com ([131.228.20.172]:47968 "EHLO
	mgw-ext13.nokia.com") by vger.kernel.org with ESMTP id S933585AbWKQNK0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 08:10:26 -0500
Message-ID: <455DB50C.3020209@indt.org.br>
Date: Fri, 17 Nov 2006 09:11:40 -0400
From: Anderson Briglia <anderson.briglia@indt.org.br>
User-Agent: Icedove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: "Linux-omap-open-source@linux.omap.com" 
	<linux-omap-open-source@linux.omap.com>
CC: linux-kernel@vger.kernel.org, Pierre Ossman <drzeus-list@drzeus.cx>,
       ext David Brownell <david-b@pacbell.net>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       "Biris Ilias (EXT-INdT/Manaus)" <Ilias.Biris@indt.org.br>
Subject: [patch 4/6] [RFC] Add MMC Password Protection (lock/unlock) support
 V6
Content-Type: multipart/mixed;
 boundary="------------060409040509020606070903"
X-OriginalArrivalTime: 17 Nov 2006 13:07:52.0611 (UTC) FILETIME=[63C53F30:01C70A49]
X-Nokia-AV: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060409040509020606070903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

OMAP platform specific patch.
- Add the host MMC lock/unlock capability support.

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar <at> indt.org.br>
Signed-off-by: Anderson Lizardo <anderson.lizardo <at> indt.org.br>
Signed-off-by: Anderson Briglia <anderson.briglia <at> indt.org.br>

Index: linux-omap-2.6.git/drivers/mmc/omap.c
===================================================================
--- linux-omap-2.6.git.orig/drivers/mmc/omap.c	2006-11-16 15:35:19.000000000 -0400
+++ linux-omap-2.6.git/drivers/mmc/omap.c	2006-11-17 09:05:47.000000000 -0400
@@ -1094,6 +1094,9 @@ static int __init mmc_omap_probe(struct
  	if (minfo->wire4)
  		 mmc->caps |= MMC_CAP_4_BIT_DATA;

+	/* Sets the lock/unlock capability */
+	host->mmc->caps |= MMC_CAP_LOCK_UNLOCK;
+
  	/* Use scatterlist DMA to reduce per-transfer costs.
  	 * NOTE max_seg_size assumption that small blocks aren't
  	 * normally used (except e.g. for reading SD registers).


--------------060409040509020606070903
Content-Type: text/x-patch;
 name="mmc_omap_cap.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc_omap_cap.diff"

OMAP platform specific patch.
- Add the host MMC lock/unlock capability support.

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar <at> indt.org.br>
Signed-off-by: Anderson Lizardo <anderson.lizardo <at> indt.org.br>
Signed-off-by: Anderson Briglia <anderson.briglia <at> indt.org.br>

Index: linux-omap-2.6.git/drivers/mmc/omap.c
===================================================================
--- linux-omap-2.6.git.orig/drivers/mmc/omap.c	2006-11-16 15:35:19.000000000 -0400
+++ linux-omap-2.6.git/drivers/mmc/omap.c	2006-11-17 09:05:47.000000000 -0400
@@ -1094,6 +1094,9 @@ static int __init mmc_omap_probe(struct 
 	if (minfo->wire4)
 		 mmc->caps |= MMC_CAP_4_BIT_DATA;
 
+	/* Sets the lock/unlock capability */
+	host->mmc->caps |= MMC_CAP_LOCK_UNLOCK;
+
 	/* Use scatterlist DMA to reduce per-transfer costs.
 	 * NOTE max_seg_size assumption that small blocks aren't
 	 * normally used (except e.g. for reading SD registers).

--------------060409040509020606070903--
