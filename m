Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbVCVO2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbVCVO2N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 09:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbVCVO2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 09:28:13 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:18950 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261274AbVCVO2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 09:28:04 -0500
Date: Tue, 22 Mar 2005 15:28:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/scsi/pas16.c: make code static
Message-ID: <20050322142801.GQ3982@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 28 Feb 2005

 drivers/scsi/pas16.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.11-rc4-mm1-full/drivers/scsi/pas16.c.old	2005-02-28 19:37:31.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/pas16.c	2005-02-28 20:38:07.000000000 +0100
@@ -137,7 +137,7 @@
 static int pas16_irq = 0;
  
 
-int scsi_irq_translate[] =
+static const int scsi_irq_translate[] =
 	{ 0,  0,  1,  2,  3,  4,  5,  6, 0,  0,  7,  8,  9,  0, 10, 11 };
 
 /* The default_irqs array contains values used to set the irq into the
@@ -145,7 +145,7 @@
  * irq jumpers on the board).  The first value in the array will be
  * assigned to logical board 0, the next to board 1, etc.
  */
-int default_irqs[] __initdata = 
+static int default_irqs[] __initdata = 
 	{  PAS16_DEFAULT_BOARD_1_IRQ,
 	   PAS16_DEFAULT_BOARD_2_IRQ,
 	   PAS16_DEFAULT_BOARD_3_IRQ,
@@ -177,7 +177,7 @@
 
 #define NO_BASES (sizeof (bases) / sizeof (struct base))
 
-unsigned short  pas16_offset[ 8 ] =
+static const unsigned short  pas16_offset[ 8 ] =
     {
 	0x1c00,    /* OUTPUT_DATA_REG */
 	0x1c01,    /* INITIATOR_COMMAND_REG */

