Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946247AbWBDBKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946247AbWBDBKv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 20:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946250AbWBDBKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 20:10:45 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:45071 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1946249AbWBDBKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 20:10:15 -0500
Date: Sat, 4 Feb 2006 02:10:13 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: [2.6 patch] schedule eepro100.c for removal
Message-ID: <20060204011013.GB4408@stusta.de>
References: <20060203213234.GS4408@stusta.de> <20060203221858.GA3670@kvack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060203221858.GA3670@kvack.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 05:18:58PM -0500, Benjamin LaHaise wrote:

> Where's the hunk to make the eepro100 driver spew messages about being 
> obsolete out upon loading?

Updated patch below.

> 		-ben

cu
Adrian


<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 Documentation/feature-removal-schedule.txt |    6 ++++++
 drivers/net/eepro100.c                     |    1 +
 2 files changed, 7 insertions(+)

--- linux-2.6.15-mm4-full/Documentation/feature-removal-schedule.txt.old	2006-01-18 08:38:57.000000000 +0100
+++ linux-2.6.15-mm4-full/Documentation/feature-removal-schedule.txt	2006-01-18 08:39:59.000000000 +0100
@@ -164,0 +165,6 @@
+---------------------------
+
+What:   eepro100 network driver
+When:   April 2006
+Why:    replaced by the e100 driver
+Who:    Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc1-mm5-full/drivers/net/eepro100.c.old	2006-02-03 23:37:55.000000000 +0100
+++ linux-2.6.16-rc1-mm5-full/drivers/net/eepro100.c	2006-02-03 23:39:10.000000000 +0100
@@ -2391,6 +2391,7 @@ static int __init eepro100_init_module(v
 #ifdef MODULE
 	printk(version);
 #endif
+	printk(KERN_WARNING "eepro100 will be removed soon, please use the e100 driver\n");
 	return pci_module_init(&eepro100_driver);
 }
 

