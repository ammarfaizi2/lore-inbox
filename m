Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264795AbTFLHG3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 03:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264796AbTFLHG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 03:06:29 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:15579 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264795AbTFLHG2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 03:06:28 -0400
Date: Thu, 12 Jun 2003 12:56:29 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patchset] Fix mishandling of error/exit patchs in 2.5 --2/3; jffs
Message-ID: <20030612072627.GI1146@llm08.in.ibm.com>
References: <20030612071330.GG1146@llm08.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030612071330.GG1146@llm08.in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- linux-2.5.70-bk/fs/jffs/intrep.c	2003-06-11 20:49:03.000000000 +0530
+++ bklatest/fs/jffs/intrep.c	2003-06-11 22:21:16.000000000 +0530
@@ -1908,7 +1908,7 @@
 	}
 
 	if ((err = flash_safe_writev(fmc->mtd, node_iovec, iovec_cnt,
-				    pos) < 0)) {
+				    pos)) < 0) {
 		jffs_fmfree_partly(fmc, fm, 0);
 		jffs_fm_write_unlock(fmc);
 		printk(KERN_ERR "JFFS: jffs_write_node: Failed to write, "
