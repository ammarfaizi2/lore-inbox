Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932266AbWAJRJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbWAJRJH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 12:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbWAJRJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 12:09:07 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:43014 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932266AbWAJRJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 12:09:05 -0500
Date: Tue, 10 Jan 2006 18:09:03 +0100
From: Adrian Bunk <bunk@stusta.de>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jean-Luc Leger <reiga@dspnet.fr.eu.org>
Subject: [2.6 patch] drivers/net/irda/Kconfig: DONGLE_OLD: remove dependency on non-existing symbol
Message-ID: <20060110170903.GQ3911@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean-Luc Leger <reiga@dspnet.fr.eu.org> reported this alternative 
dependency on a non-existing symbol.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-mm2-full/drivers/net/irda/Kconfig.old	2006-01-10 17:48:41.000000000 +0100
+++ linux-2.6.15-mm2-full/drivers/net/irda/Kconfig	2006-01-10 17:48:59.000000000 +0100
@@ -1,4 +1,3 @@
-
 menu "Infrared-port device drivers"
 	depends on IRDA!=n
 
@@ -156,7 +155,7 @@
 
 config DONGLE_OLD
 	bool "Old Serial dongle support"
-	depends on (IRTTY_OLD || IRPORT_SIR) && BROKEN_ON_SMP
+	depends on IRPORT_SIR && BROKEN_ON_SMP
 	help
 	  Say Y here if you have an infrared device that connects to your
 	  computer's serial port. These devices are called dongles. Then say Y

