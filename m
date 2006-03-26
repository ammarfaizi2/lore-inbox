Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWCZRFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWCZRFt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 12:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWCZRFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 12:05:49 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:59142 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932096AbWCZRFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 12:05:48 -0500
Date: Sun, 26 Mar 2006 19:05:46 +0200
From: Adrian Bunk <bunk@stusta.de>
To: dwmw2@infradead.org
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
       "Petri T. Koistinen" <petri.koistinen@iki.fi>
Subject: [2.6 patch] drivers_mtd_maps_vmax301.c: fix off by one vmax_mtd
Message-ID: <20060326170546.GO4053@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Petri T. Koistinen" <petri.koistinen@iki.fi>

This patch fixes an obcious off-by-one error (vmax_mtd[] contains 
two elements).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.14-rc3-git3/drivers/mtd/maps/vmax301.c	2005-05-25 13:48:53.000000000 +1000
+++ .6877.trivial/drivers/mtd/maps/vmax301.c	2005-10-04 19:29:50.000000000 +1000
@@ -182,7 +182,7 @@ int __init init_vmax301(void)
 		}
 	}
 
-	if (!vmax_mtd[1] && !vmax_mtd[2]) {
+	if (!vmax_mtd[0] && !vmax_mtd[1]) {
 		iounmap((void *)iomapadr);
 		return -ENXIO;
 	}


