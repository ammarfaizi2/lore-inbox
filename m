Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261359AbTCGFVM>; Fri, 7 Mar 2003 00:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261358AbTCGFVM>; Fri, 7 Mar 2003 00:21:12 -0500
Received: from dp.samba.org ([66.70.73.150]:24811 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261359AbTCGFVF>;
	Fri, 7 Mar 2003 00:21:05 -0500
Date: Fri, 7 Mar 2003 16:30:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Linus Torvalds <torvalds@transmeta.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg Kroah-Hartman <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [TRIVIAL] Squash warning in ohci-pci.c on PowerBooks
Message-ID: <20030307053044.GC1161@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Greg Kroah-Hartman <greg@kroah.com>, linux-kernel@vger.kernel.org,
	trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply (patch is against 2.5.64):

Apple PowerBooks want <asm/prom.h> in ohci-pci.c for the prototype of
pci_device_to_OF_node().  This patch adds it to the already present
list of PowerBook specific #includes:

diff -urN pmac-2.5-pristine/drivers/usb/host/ohci-pci.c linux-2.5-zax/drivers/usb/host/ohci-pci.c
--- pmac-2.5-pristine/drivers/usb/host/ohci-pci.c	2003-03-03 13:43:41.000000000 +1100
+++ linux-2.5-zax/drivers/usb/host/ohci-pci.c	2003-03-07 15:32:12.000000000 +1100
@@ -18,6 +18,7 @@
 #include <asm/machdep.h>
 #include <asm/pmac_feature.h>
 #include <asm/pci-bridge.h>
+#include <asm/prom.h>
 #ifndef CONFIG_PM
 #	define CONFIG_PM
 #endif


-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
