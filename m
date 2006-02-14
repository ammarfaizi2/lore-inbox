Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030256AbWBNAOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030256AbWBNAOM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 19:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030330AbWBNAOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 19:14:12 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:61962 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030256AbWBNAOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 19:14:11 -0500
Date: Tue, 14 Feb 2006 01:14:09 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Badari Pulavarty <pbadari@gmail.com>
Cc: Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Subject: [2.6 patch] schedule the SCSI qlogicfc driver for removal
Message-ID: <20060214001409.GA17604@stusta.de>
References: <20051024014838.0dd491bb.akpm@osdl.org> <1130186927.6831.23.camel@localhost.localdomain> <20051024141646.6265c0da.akpm@osdl.org> <20051027152637.GC7889@plap.qlogic.org> <20051027190227.GA16211@infradead.org> <20051027215313.GB7889@plap.qlogic.org> <20051028225155.GA13958@infradead.org> <20051028230303.GI15018@plap.qlogic.org> <1130542543.23729.160.camel@localhost.localdomain> <20060204225801.GD4528@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060204225801.GD4528@stusta.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As usual, there isn't much feedback regarding problems with one driver 
from people using an obsolete driver for the same hardware.

So schedule the SCSI qlogicfc driver for removal and let the 
flames^Wfeedback begin...


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 Documentation/feature-removal-schedule.txt |    7 +++++++
 drivers/scsi/qlogicfc.c                    |    1 +
 2 files changed, 8 insertions(+)

--- linux-2.6.16-rc2-mm1-full/Documentation/feature-removal-schedule.txt.old	2006-02-14 00:26:21.000000000 +0100
+++ linux-2.6.16-rc2-mm1-full/Documentation/feature-removal-schedule.txt	2006-02-14 00:28:12.000000000 +0100
@@ -153,0 +154,7 @@
+What:   SCSI qlogicfc driver
+When:   August 2006
+Why:    replaced by the qla2xxx driver
+Who:    Adrian Bunk <bunk@stusta.de>
+
+---------------------------
+
--- linux-2.6.16-rc2-mm1-full/drivers/scsi/qlogicfc.c.old	2006-02-14 00:29:41.000000000 +0100
+++ linux-2.6.16-rc2-mm1-full/drivers/scsi/qlogicfc.c	2006-02-14 00:34:43.000000000 +0100
@@ -724,6 +724,7 @@
 	dma_addr_t busaddr;
 	int i;
 
+	printk(KERN_WARNING "qlogicfc will be removed soon, please use the qla2xxx driver\n");
 
 	ENTER("isp2x00_detect");
 

