Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264794AbTFLG5h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 02:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264779AbTFLGzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 02:55:37 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:37094 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264782AbTFLGyW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 02:54:22 -0400
Date: Thu, 12 Jun 2003 12:44:21 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patchset] Fix mishandling of error/exit patchs in 2.5 -- 1/3 dpt_i2o
Message-ID: <20030612071419.GH1146@llm08.in.ibm.com>
References: <20030612071330.GG1146@llm08.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030612071330.GG1146@llm08.in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- linux-2.5.70-bk/drivers/scsi/dpt_i2o.c	2003-06-11 20:56:14.000000000 +0530
+++ bklatest/drivers/scsi/dpt_i2o.c	2003-06-11 21:37:28.000000000 +0530
@@ -2538,7 +2538,7 @@
 
 	if(pHba->initialized ) {
 		if (adpt_i2o_status_get(pHba) < 0) {
-			if((rcode = adpt_i2o_reset_hba(pHba) != 0)){
+			if((rcode = adpt_i2o_reset_hba(pHba)) != 0){
 				printk(KERN_WARNING"%s: Could NOT reset.\n", pHba->name);
 				return rcode;
 			}
@@ -2564,7 +2564,7 @@
 			}
 		}
 	} else {
-		if((rcode = adpt_i2o_reset_hba(pHba) != 0)){
+		if((rcode = adpt_i2o_reset_hba(pHba)) != 0){
 			printk(KERN_WARNING"%s: Could NOT reset.\n", pHba->name);
 			return rcode;
 		}
