Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261322AbVBFXdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbVBFXdJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 18:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbVBFXdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 18:33:09 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:26386 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261322AbVBFXdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 18:33:04 -0500
Date: Mon, 7 Feb 2005 00:33:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] SCSI sym53c416.c: make a function static
Message-ID: <20050206233301.GF3129@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global function static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 15 Nov 2004

--- linux-2.6.10-rc1-mm5-full/drivers/scsi/sym53c416.c.old	2004-11-14 01:30:23.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/sym53c416.c	2004-11-14 01:30:32.000000000 +0100
@@ -616,7 +616,7 @@
 
 MODULE_DEVICE_TABLE(isapnp, id_table);
 
-void sym53c416_probe(void)
+static void sym53c416_probe(void)
 {
 	int *base = probeaddrs;
 	int ints[2];

