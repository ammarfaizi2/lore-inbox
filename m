Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbUKODBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbUKODBi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 22:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbUKODBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 22:01:16 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:33036 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261505AbUKOCwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 21:52:37 -0500
Date: Mon, 15 Nov 2004 03:40:03 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] SCSI ultrastor.c: make a varialbe static
Message-ID: <20041115024003.GF2249@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes aneedlessly global variable static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm5-full/drivers/scsi/ultrastor.c.old	2004-11-14 01:31:07.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/ultrastor.c	2004-11-14 01:31:20.000000000 +0100
@@ -259,7 +259,7 @@
 } config = {0};
 
 /* Set this to 1 to reset the SCSI bus on error.  */
-int ultrastor_bus_reset;
+static int ultrastor_bus_reset;
 
 
 /* Allowed BIOS base addresses (NULL indicates reserved) */

