Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbVBFXda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbVBFXda (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 18:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbVBFXdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 18:33:16 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:27922 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261327AbVBFXdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 18:33:07 -0500
Date: Mon, 7 Feb 2005 00:33:04 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] SCSI ultrastor.c: make a variable static
Message-ID: <20050206233304.GG3129@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global variable static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 15 Nov 2004

--- linux-2.6.10-rc1-mm5-full/drivers/scsi/ultrastor.c.old	2004-11-14 01:31:07.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/ultrastor.c	2004-11-14 01:31:20.000000000 +0100
@@ -259,7 +259,7 @@
 } config = {0};
 
 /* Set this to 1 to reset the SCSI bus on error.  */
-int ultrastor_bus_reset;
+static int ultrastor_bus_reset;
 
 
 /* Allowed BIOS base addresses (NULL indicates reserved) */

