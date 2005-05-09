Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263036AbVEID5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263036AbVEID5L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 23:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263037AbVEID5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 23:57:11 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:6406 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263036AbVEID5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 23:57:05 -0400
Date: Mon, 9 May 2005 05:56:59 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Chris Pascoe <c.pascoe@itee.uq.edu.au>
Cc: linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] VIDEO_CX88_DVB must select DVB_CX22702
Message-ID: <20050509035659.GT3590@stusta.de>
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

