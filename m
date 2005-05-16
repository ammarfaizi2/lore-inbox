Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbVEPMwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbVEPMwh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 08:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVEPMwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 08:52:33 -0400
Received: from dynamic.62-99-255-84.adsl-line.inode.at ([62.99.255.84]:7155
	"EHLO mercury.foo") by vger.kernel.org with ESMTP id S261591AbVEPMwV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 08:52:21 -0400
Date: Mon, 16 May 2005 14:52:38 +0200 (CEST)
From: Dominik Hackl <dominik@hackl.dhs.org>
X-X-Sender: dominik@mercury.foo
To: torvalds@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix Philips SAA7130/7134 TV dependency problem
Message-ID: <Pine.LNX.4.61.0505161423390.6518@mercury.foo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This patch solves a dependency-problem related to the SAA7130/7134 TV-card
driver. The driver won't compile with CRC32 disabled, so I added it to the 
select list.


	Signed-off-by: Dominik Hackl <dominik@hackl.dhs.org>


diff -pruN linux-2.6.12-rc4.orig/drivers/media/video/Kconfig linux-2.6.12-rc4/drivers/media/video/Kconfig
--- linux-2.6.12-rc4.orig/drivers/media/video/Kconfig	2005-05-15 09:43:44.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/video/Kconfig	2005-05-15 15:50:49.000000000 +0200
@@ -240,6 +240,7 @@ config VIDEO_SAA7134
 	select VIDEO_BUF
 	select VIDEO_IR
 	select VIDEO_TUNER
+	select CRC32
 	---help---
 	  This is a video4linux driver for Philips SAA7130/7134 based
 	  TV cards.
