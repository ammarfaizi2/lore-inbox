Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbVARJn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVARJn3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 04:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbVARJlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 04:41:50 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:31493 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261208AbVARJkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 04:40:01 -0500
Date: Tue, 18 Jan 2005 10:39:59 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/block/xd.c: make a variable static
Message-ID: <20050118093959.GB4274@stusta.de>
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
- 29 Nov 2004

--- linux-2.6.10-rc1-mm3-full/drivers/block/xd.c.old	2004-11-06 20:20:25.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/block/xd.c	2004-11-06 20:21:01.000000000 +0100
@@ -67,7 +67,7 @@
 /* Above may need to be increased if a problem with the 2nd drive detection
    (ST11M controller) or resetting a controller (WD) appears */
 
-XD_INFO xd_info[XD_MAXDRIVES];
+static XD_INFO xd_info[XD_MAXDRIVES];
 
 /* If you try this driver and find that your card is not detected by the driver at bootup, you need to add your BIOS
    signature and details to the following list of signatures. A BIOS signature is a string embedded into the first

