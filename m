Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbVALN2D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbVALN2D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 08:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVALN2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 08:28:03 -0500
Received: from gprs214-158.eurotel.cz ([160.218.214.158]:7060 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261180AbVALNYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 08:24:10 -0500
Date: Wed, 12 Jan 2005 14:23:39 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, john.ronciak@intel.com,
       ganesh.venkatesan@intel.com, jesse.brandeburg@intel.com
Cc: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>
Subject: eepro100 kill obsolete ifdefs
Message-ID: <20050112132339.GA1572@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

pci layer should provide enough dummy functions for such ugly hacks to
be unneccessary these days. Please apply,

Signed-off-by: Pavel Machek <pavel@ucw.cz>
								Pavel


--- clean/drivers/net/eepro100.c	2005-01-12 11:07:39.000000000 +0100
+++ linux/drivers/net/eepro100.c	2005-01-12 11:22:37.000000000 +0100
@@ -152,16 +152,6 @@
 
 #define RUN_AT(x) (jiffies + (x))
 
-/* ACPI power states don't universally work (yet) */
-#ifndef CONFIG_PM
-#undef pci_set_power_state
-#define pci_set_power_state null_set_power_state
-static inline int null_set_power_state(struct pci_dev *dev, int state)
-{
-	return 0;
-}
-#endif /* CONFIG_PM */
-
 #define netdevice_start(dev)
 #define netdevice_stop(dev)
 #define netif_set_tx_timeout(dev, tf, tm) \

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
