Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265176AbUATAEy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 19:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265175AbUATADU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 19:03:20 -0500
Received: from mail.kroah.org ([65.200.24.183]:15532 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265060AbUASX76 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 18:59:58 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.1
In-Reply-To: <1074556763161@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 19 Jan 2004 15:59:23 -0800
Message-Id: <10745567633048@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1474.98.14, 2004/01/15 10:34:52-08:00, greg@kroah.com

[PATCH] I2C: move the Kconfig "source..." out of the drivers/char/ location


 drivers/Kconfig      |    2 ++
 drivers/char/Kconfig |    2 --
 2 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/Kconfig b/drivers/Kconfig
--- a/drivers/Kconfig	Mon Jan 19 15:30:43 2004
+++ b/drivers/Kconfig	Mon Jan 19 15:30:43 2004
@@ -38,6 +38,8 @@
 
 source "drivers/char/Kconfig"
 
+source "drivers/i2c/Kconfig"
+
 # source "drivers/misc/Kconfig"
 
 source "drivers/media/Kconfig"
diff -Nru a/drivers/char/Kconfig b/drivers/char/Kconfig
--- a/drivers/char/Kconfig	Mon Jan 19 15:30:43 2004
+++ b/drivers/char/Kconfig	Mon Jan 19 15:30:43 2004
@@ -588,8 +588,6 @@
 	bool "Support for console on line printer"
 	depends on PC9800_OLDLP
 
-source "drivers/i2c/Kconfig"
-
 
 menu "Mice"
 

