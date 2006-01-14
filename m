Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423275AbWANCK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423275AbWANCK1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 21:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423271AbWANCKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 21:10:10 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:19986 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1423270AbWANCJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 21:09:45 -0500
Date: Sat, 14 Jan 2006 03:09:45 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Matthew Wilcox <matthew@wil.cx>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] scsi_transport_spi.c: make print_nego() static
Message-ID: <20060114020945.GB29663@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global function static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>
Acked-by: Matthew Wilcox <matthew@wil.cx>

---

This patch was already sent on:
- 5 Jan 2006

--- linux-2.6.15-mm1-full/drivers/scsi/scsi_transport_spi.c.old	2006-01-05 22:52:19.000000000 +0100
+++ linux-2.6.15-mm1-full/drivers/scsi/scsi_transport_spi.c	2006-01-05 22:52:28.000000000 +0100
@@ -1075,7 +1075,7 @@
 /* 0x04 */ "Parallel Protocol Request"
 };
 
-void print_nego(const unsigned char *msg, int per, int off, int width)
+static void print_nego(const unsigned char *msg, int per, int off, int width)
 {
 	if (per) {
 		char buf[20];

