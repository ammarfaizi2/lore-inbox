Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261795AbVBXEZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbVBXEZj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 23:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbVBXEZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 23:25:35 -0500
Received: from ozlabs.org ([203.10.76.45]:17846 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261795AbVBXENZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 23:13:25 -0500
Date: Thu, 24 Feb 2005 15:05:15 +1100
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Jeff Garzik <jgarzik@pobox.com>, Pavel Roskin <proski@gnu.org>,
       Orinoco Development List <orinoco-devel@lists.sourceforge.net>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [14/14] Orinoco driver updates - update version and changelog
Message-ID: <20050224040515.GP32001@localhost.localdomain>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Pavel Roskin <proski@gnu.org>,
	Orinoco Development List <orinoco-devel@lists.sourceforge.net>,
	netdev@oss.sgi.com, linux-kernel@vger.kernel.org
References: <20050224035718.GE32001@localhost.localdomain> <20050224035804.GF32001@localhost.localdomain> <20050224035957.GH32001@localhost.localdomain> <20050224040024.GI32001@localhost.localdomain> <20050224040052.GJ32001@localhost.localdomain> <20050224040153.GK32001@localhost.localdomain> <20050224040228.GL32001@localhost.localdomain> <20050224040258.GM32001@localhost.localdomain> <20050224040319.GN32001@localhost.localdomain> <20050224040409.GO32001@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050224040409.GO32001@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previous patches have brought the in-kernel orinoco driver roughly to
parity with version 0.14alpha2 from out-of-tree.  Update the version
number and changelog accordingly.

Signed-off-by: David Gibson <hermes@gibson.dropbear.id.au>

Index: working-2.6/drivers/net/wireless/orinoco.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco.c	2005-02-24 14:50:59.879047056 +1100
+++ working-2.6/drivers/net/wireless/orinoco.c	2005-02-24 14:51:02.388665536 +1100
@@ -393,6 +393,29 @@
  *	  in the rx_dropped statistics.
  *	o Provided a module parameter to suppress linkstatus messages.
  *
+ * v0.13e -> v0.14alpha1 - 30 Sep 2003 - David Gibson
+ *	o Replaced priv->connected logic with netif_carrier_on/off()
+ *	  calls.
+ *	o Remove has_ibss_any and never set the CREATEIBSS RID when
+ *	  the ESSID is empty.  Too many firmwares break if we do.
+ *	o 2.6 merges: Replace pdev->slot_name with pci_name(), remove
+ *	  __devinitdata from PCI ID tables, use free_netdev().
+ *	o Enabled shared-key authentication for Agere firmware (from
+ *	  Robert J. Moore <Robert.J.Moore AT allanbank.com>
+ *	o Move netif_wake_queue() (back) to the Tx completion from the
+ *	  ALLOC event.  This seems to prevent/mitigate the rolling
+ *	  error -110 problems at least on some Intersil firmwares.
+ *	  Theoretically reduces performance, but I can't measure it.
+ *	  Patch from Andrew Tridgell <tridge AT samba.org>
+ *
+ * v0.14alpha1 -> v0.14alpha2 - 20 Oct 2003 - David Gibson
+ *	o Correctly turn off shared-key authentication when requested
+ *	  (bugfix from Robert J. Moore).
+ *	o Correct airport sleep interfaces for current 2.6 kernels.
+ *	o Add code for key change without disabling/enabling the MAC
+ *	  port.  This is supposed to allow 802.1x to work sanely, but
+ *	  doesn't seem to yet.
+ *
  * TODO
  *	o New wireless extensions API (patch from Moustafa
  *	  Youssef, updated by Jim Carter and Pavel Roskin).
Index: working-2.6/drivers/net/wireless/orinoco.h
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco.h	2005-02-24 14:50:59.879047056 +1100
+++ working-2.6/drivers/net/wireless/orinoco.h	2005-02-24 14:51:02.389665384 +1100
@@ -7,7 +7,7 @@
 #ifndef _ORINOCO_H
 #define _ORINOCO_H
 
-#define DRIVER_VERSION "0.13e"
+#define DRIVER_VERSION "0.14alpha2"
 
 #include <linux/types.h>
 #include <linux/spinlock.h>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist.  NOT _the_ _other_ _way_
				| _around_!
http://www.ozlabs.org/people/dgibson
