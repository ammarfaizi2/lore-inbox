Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbVBSIvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbVBSIvj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 03:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbVBSItW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 03:49:22 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:54286 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261662AbVBSIps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 03:45:48 -0500
Date: Sat, 19 Feb 2005 09:45:44 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/via-velocity.c: make a function static
Message-ID: <20050219084544.GV4337@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global function static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc3-mm2-full/drivers/net/via-velocity.c.old	2005-02-16 18:57:31.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/via-velocity.c	2005-02-16 18:57:49.000000000 +0100
@@ -3096,7 +3096,7 @@
  *	we are interested in.
  */
 
-u16 wol_calc_crc(int size, u8 * pattern, u8 *mask_pattern)
+static u16 wol_calc_crc(int size, u8 * pattern, u8 *mask_pattern)
 {
 	u16 crc = 0xFFFF;
 	u8 mask;

