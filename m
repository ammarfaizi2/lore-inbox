Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbUCLUPT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 15:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262493AbUCLUOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 15:14:14 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:27388 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S262490AbUCLUCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 15:02:36 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Andrew Morton <akpm@osdl.org>
Subject: [TRIVIAL] fix modular fb drivers
Date: Fri, 12 Mar 2004 20:48:41 +0100
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org, James Simmons <jsimmons@infradead.org>,
       Kronos <kronos@kronoz.cjb.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403122048.41373.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The recent "fbdev: monitor detection fixes" patch broke modular
frame buffer drivers, so this patch is now needed for 2.6.4-bk.

===== drivers/video/modedb.c 1.11 vs edited =====
--- 1.11/drivers/video/modedb.c	Fri Mar 12 10:33:04 2004
+++ edited/drivers/video/modedb.c	Fri Mar 12 20:44:19 2004
@@ -554,5 +554,5 @@
     return 0;
 }
 
-EXPORT_SYMBOL(__fb_try_mode);
 EXPORT_SYMBOL(vesa_modes);
+EXPORT_SYMBOL(fb_find_mode);
