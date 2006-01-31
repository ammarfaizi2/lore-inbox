Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751457AbWAaU0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbWAaU0X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 15:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbWAaU0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 15:26:23 -0500
Received: from mgw-ext04.nokia.com ([131.228.20.96]:23902 "EHLO
	mgw-ext04.nokia.com") by vger.kernel.org with ESMTP
	id S1751457AbWAaU0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 15:26:22 -0500
Message-Id: <20060131202549.458006000@localhost.localdomain>
References: <20060131201636.264543000@localhost.localdomain>
Date: Tue, 31 Jan 2006 16:16:42 -0400
From: Carlos Aguiar <carlos.aguiar@indt.org.br>
To: linux-kernel@vger.kernel.org,
       "Linux-omap-open-source@linux.omap.com" 
	<linux-omap-open-source@linux.omap.com>
Cc: linux@arm.linux.org.uk, David Brownell <david-b@pacbell.net>,
       Tony Lindgren <tony@atomide.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>,
       Anderson Briglia <anderson.briglia@indt.org.br>
Subject: [patch 6/6] Add MMC password protection (lock/unlock) support V4
Content-Disposition: inline; filename=mmc_omap_cap.diff
X-OriginalArrivalTime: 31 Jan 2006 20:25:53.0755 (UTC) FILETIME=[88C212B0:01C626A4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to add the host MMC lock/unlock capability support for OMAP platform.

Signed-off-by: Anderson Briglia <anderson.briglia@indt.org.br>
Signed-off-by: Anderson Lizardo <anderson.lizardo@indt.org.br>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

Index: linux-omap-2.6.git/drivers/mmc/omap.c
===================================================================
--- linux-omap-2.6.git.orig/drivers/mmc/omap.c	2006-01-31 15:22:33.000000000 -0400
+++ linux-omap-2.6.git/drivers/mmc/omap.c	2006-01-31 15:22:36.000000000 -0400
@@ -1235,6 +1235,9 @@ static int __init mmc_omap_probe(struct 
 
 	 if (minfo->wire4)
 		 mmc->caps |= MMC_CAP_4_BIT_DATA;
+	
+	/* Sets the lock/unlock capability */
+	host->mmc->caps |= MMC_CAP_LOCK_UNLOCK;
 
 	mmc->ops = &mmc_omap_ops;
 	mmc->f_min = 400000;

--
