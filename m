Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265987AbUFUBos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265987AbUFUBos (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 21:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265985AbUFUBos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 21:44:48 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:62409 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265696AbUFUBnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 21:43:53 -0400
Date: Mon, 21 Jun 2004 03:43:51 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: [patch] 2.6.7-mm1: R8169_NAPI help text
Message-ID: <20040621014350.GI27822@fs.tum.de>
References: <20040620174632.74e08e09.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040620174632.74e08e09.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below adds the missing help text for R8169_NAPI.

Please apply
Adrian

--- linux-2.6.7-rc2-mm2-full/drivers/net/Kconfig.old	2004-06-04 17:10:43.000000000 +0200
+++ linux-2.6.7-rc2-mm2-full/drivers/net/Kconfig	2004-06-04 17:18:14.000000000 +0200
@@ -1983,8 +2027,20 @@
 
 config R8169_NAPI
 	bool "Use Rx and Tx Polling (NAPI) (EXPERIMENTAL)"
-	depends on R8169 && EXPERIMENTAL 
+	depends on R8169 && EXPERIMENTAL
+	help
+	  NAPI is a new driver API designed to reduce CPU and interrupt load
+	  when the driver is receiving lots of packets from the card. It is
+	  still somewhat experimental and thus not yet enabled by default.
 
+	  If your estimated Rx load is 10kpps or more, or if the card will be
+	  deployed on potentially unfriendly networks (e.g. in a firewall),
+	  then say Y here.
+
+	  See <file:Documentation/networking/NAPI_HOWTO.txt> for more
+	  information.
+
+	  If in doubt, say N.
 
 config SK98LIN
 	tristate "Marvell Yukon Chipset / SysKonnect SK-98xx Support"
