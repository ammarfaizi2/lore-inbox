Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbUKOCL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbUKOCL4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 21:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbUKOCJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 21:09:59 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:57356 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261416AbUKOCJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 21:09:31 -0500
Date: Mon, 15 Nov 2004 02:56:09 +0100
From: Adrian Bunk <bunk@stusta.de>
To: oliver@neukum.name, aliakc@web.de, lenehan@twibble.org
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] SCSI dc395x.c: make a function static
Message-ID: <20041115015609.GG2249@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes the needlessly global function adapter_init_chip 
static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm5-full/drivers/scsi/dc395x.c.old	2004-11-13 20:58:56.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/dc395x.c	2004-11-13 20:59:09.000000000 +0100
@@ -4447,7 +4447,7 @@
  *
  * @acb: The adapter which we are to init.
  **/
-void __init adapter_init_chip(struct AdapterCtlBlk *acb)
+static void __init adapter_init_chip(struct AdapterCtlBlk *acb)
 {
         struct NvRamType *eeprom = &acb->eeprom;
         

