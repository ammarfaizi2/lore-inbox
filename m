Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268509AbUHLLGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268509AbUHLLGX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 07:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268511AbUHLLGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 07:06:23 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:65530 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268509AbUHLLGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 07:06:20 -0400
Date: Thu, 12 Aug 2004 13:06:15 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: geert@linux-m68k.org, jgarzik@pobox.com
Cc: linux-net@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] small Kconfig corrections for two ATARI net drivers
Message-ID: <20040812110615.GB13377@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch below corrects a small problem in the dependencies of 
ATARI_BIONET and ATARI_PAMSNET (e.g. ATARI_ACSI=m shouldn't allow 
ATARI_BIONET=y).



Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.8-rc4-mm1-full-3.4/drivers/net/Kconfig.old	2004-08-12 13:02:11.000000000 +0200
+++ linux-2.6.8-rc4-mm1-full-3.4/drivers/net/Kconfig	2004-08-12 13:02:21.000000000 +0200
@@ -391,7 +391,7 @@
 
 config ATARI_BIONET
 	tristate "BioNet-100 support"
-	depends on NETDEVICES && ATARI && ATARI_ACSI!=n && BROKEN
+	depends on NETDEVICES && ATARI && ATARI_ACSI && BROKEN
 	help
 	  Say Y to include support for BioData's BioNet-100 Ethernet adapter
 	  for the ACSI port. The driver works (has to work...) with a polled
@@ -399,7 +399,7 @@
 
 config ATARI_PAMSNET
 	tristate "PAMsNet support"
-	depends on NETDEVICES && ATARI && ATARI_ACSI!=n && BROKEN
+	depends on NETDEVICES && ATARI && ATARI_ACSI && BROKEN
 	help
 	  Say Y to include support for the PAMsNet Ethernet adapter for the
 	  ACSI port ("ACSI node"). The driver works (has to work...) with a
