Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262675AbUBZDWn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 22:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262661AbUBZDWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 22:22:41 -0500
Received: from palrel11.hp.com ([156.153.255.246]:22431 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S262666AbUBZDVu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 22:21:50 -0500
Date: Wed, 25 Feb 2004 19:21:50 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] broken_smp
Message-ID: <20040226032150.GQ32263@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

irXXX_broken_smp.diff :
~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [FEATURE] mark irport driver has having locking issues


diff -Nru a/drivers/net/irda/Kconfig b/drivers/net/irda/Kconfig
--- a/drivers/net/irda/Kconfig	Wed Feb 18 09:56:50 2004
+++ b/drivers/net/irda/Kconfig	Wed Feb 18 09:56:50 2004
@@ -138,7 +138,7 @@
 
 config IRPORT_SIR
 	tristate "IrPORT (IrDA serial driver)"
-	depends on IRDA
+	depends on IRDA && BROKEN_ON_SMP
 	---help---
 	  Say Y here if you want to build support for the IrPORT IrDA device
 	  driver.  To compile it as a module, choose M here: the module will be
@@ -156,7 +156,7 @@
 
 config DONGLE_OLD
 	bool "Old Serial dongle support"
-	depends on IRTTY_OLD || IRPORT_SIR
+	depends on (IRTTY_OLD || IRPORT_SIR) && BROKEN_ON_SMP
 	help
 	  Say Y here if you have an infrared device that connects to your
 	  computer's serial port. These devices are called dongles. Then say Y
