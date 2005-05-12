Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262136AbVELViV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbVELViV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 17:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbVELViV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 17:38:21 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:14345 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262136AbVELViL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 17:38:11 -0400
Date: Thu, 12 May 2005 23:38:07 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Pascoe <c.pascoe@itee.uq.edu.au>,
       Johannes Stezenbach <js@linuxtv.org>, linux-kernel@vger.kernel.org
Subject: [2.6 patch] VIDEO_CX88_DVB must select DVB_CX22702
Message-ID: <20050512213806.GB3603@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

VIDEO_CX88_DVB must select DVB_CX22702 (due to it's
cx22702_attach usage).

This patch fixes kernel Bugzilla #4594
(http://bugzilla.kernel.org/show_bug.cgi?id=4594).

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Acked-by: Johannes Stezenbach <js@linuxtv.org>

---

This patch was already sent on:
- 9 May 2005

--- linux-2.6.12-rc4/drivers/media/video/Kconfig.old	2005-05-09 05:02:59.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/video/Kconfig	2005-05-09 05:04:18.000000000 +0200
@@ -326,12 +326,13 @@
 config VIDEO_CX88_DVB
 	tristate "DVB Support for cx2388x based TV cards"
 	depends on VIDEO_CX88 && DVB_CORE
 	select VIDEO_BUF_DVB
 	select DVB_MT352
 	select DVB_OR51132
+	select DVB_CX22702
 	---help---
 	  This adds support for DVB/ATSC cards based on the
 	  Connexant 2388x chip.
 
 config VIDEO_OVCAMCHIP
 	tristate "OmniVision Camera Chip support"

