Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261999AbUCNWyx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 17:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbUCNWyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 17:54:52 -0500
Received: from colino.net ([62.212.100.143]:34543 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S261999AbUCNWyt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 17:54:49 -0500
Date: Sun, 14 Mar 2004 23:38:05 +0100
From: Colin Leroy <colin@colino.net>
To: benh@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] radeon_base.c typo fix
Message-Id: <20040314233805.5b461eff@jack.colino.net>
Organization: 
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 2.2.4; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Sun__14_Mar_2004_23_38_05_+0100_EdXM6LX_=NrG6J3m"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Sun__14_Mar_2004_23_38_05_+0100_EdXM6LX_=NrG6J3m
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

micro-patch to change "retreive" to "retrieve" in radeon_base.c

hth,
-- 
Colin

--Multipart=_Sun__14_Mar_2004_23_38_05_+0100_EdXM6LX_=NrG6J3m
Content-Type: text/plain;
 name="radeon.typo.diff"
Content-Disposition: attachment;
 filename="radeon.typo.diff"
Content-Transfer-Encoding: 7bit

--- drivers/video/aty/radeon_base.c.old	2004-03-14 23:31:11.782321232 +0100
+++ drivers/video/aty/radeon_base.c	2004-03-14 23:31:29.258664424 +0100
@@ -593,16 +593,16 @@
 }
 
 /*
- * Retreive PLL infos by different means (BIOS, Open Firmware, register probing...)
+ * Retrieve PLL infos by different means (BIOS, Open Firmware, register probing...)
  */
 static void __devinit radeon_get_pllinfo(struct radeonfb_info *rinfo)
 {
 #ifdef CONFIG_PPC_OF
 	/*
-	 * Retreive PLL infos from Open Firmware first
+	 * Retrieve PLL infos from Open Firmware first
 	 */
        	if (!force_measure_pll && radeon_read_xtal_OF(rinfo) == 0) {
-       		printk(KERN_INFO "radeonfb: Retreived PLL infos from Open Firmware\n");
+       		printk(KERN_INFO "radeonfb: Retrieved PLL infos from Open Firmware\n");
        		rinfo->pll.ref_div = INPLL(PPLL_REF_DIV) & 0x3ff;
 		/* FIXME: Max clock may be higher on newer chips */
        		rinfo->pll.ppll_min = 12000;
@@ -613,7 +613,7 @@
 
 	/*
 	 * Check out if we have an X86 which gave us some PLL informations
-	 * and if yes, retreive them
+	 * and if yes, retrieve them
 	 */
 	if (!force_measure_pll && rinfo->bios_seg) {
 		u16 pll_info_block = BIOS_IN16(rinfo->fp_bios_start + 0x30);
@@ -625,7 +625,7 @@
 		rinfo->pll.ppll_min	= BIOS_IN32(pll_info_block + 0x12);
 		rinfo->pll.ppll_max	= BIOS_IN32(pll_info_block + 0x16);
 
-		printk(KERN_INFO "radeonfb: Retreived PLL infos from BIOS\n");
+		printk(KERN_INFO "radeonfb: Retrieved PLL infos from BIOS\n");
 		goto found;
 	}
 
@@ -634,7 +634,7 @@
 	 * probe them
 	 */
 	if (radeon_probe_pll_params(rinfo) == 0) {
-		printk(KERN_INFO "radeonfb: Retreived PLL infos from registers\n");
+		printk(KERN_INFO "radeonfb: Retrieved PLL infos from registers\n");
 		/* FIXME: Max clock may be higher on newer chips */
        		rinfo->pll.ppll_min = 12000;
        		rinfo->pll.ppll_max = 35000;
@@ -703,7 +703,7 @@
 
 found:
 	/*
-	 * Some methods fail to retreive SCLK and MCLK values, we apply default
+	 * Some methods fail to retrieve SCLK and MCLK values, we apply default
 	 * settings in this case (200Mhz). If that really happne often, we could
 	 * fetch from registers instead...
 	 */
@@ -2228,7 +2228,7 @@
 				     == CFG_ATI_REV_A11);
 
 	/*
-	 * Map the BIOS ROM if any and retreive PLL parameters from
+	 * Map the BIOS ROM if any and retrieve PLL parameters from
 	 * either BIOS or Open Firmware
 	 */
 	radeon_map_ROM(rinfo, pdev);

--Multipart=_Sun__14_Mar_2004_23_38_05_+0100_EdXM6LX_=NrG6J3m--
