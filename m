Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbWCYOx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWCYOx5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 09:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbWCYOx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 09:53:57 -0500
Received: from baikonur.stro.at ([213.239.196.228]:10982 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S1751185AbWCYOx4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 09:53:56 -0500
Date: Sat, 25 Mar 2006 15:48:54 +0100
From: maximilian attems <maks@sternwelten.at>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] isicom: select FW_LOADER
Message-ID: <20060325144854.GE883@nancy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The isicom driver uses request_firmware()                                  
and thus needs to select FW_LOADER.                                             

Signed-off-by: maximilian attems <maks@sternwelten.at>

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 5980f3e..facc3f1 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -187,6 +187,7 @@ config MOXA_SMARTIO
 config ISI
 	tristate "Multi-Tech multiport card support (EXPERIMENTAL)"
 	depends on SERIAL_NONSTANDARD
+	select FW_LOADER
 	help
 	  This is a driver for the Multi-Tech cards which provide several
 	  serial ports.  The driver is experimental and can currently only be
