Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030191AbWDNV6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030191AbWDNV6R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 17:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030194AbWDNV6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 17:58:17 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:27089 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1030191AbWDNV6Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 17:58:16 -0400
Date: Fri, 14 Apr 2006 23:57:56 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: Christian Heimanns <ch.heimanns@gmx.de>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, pavel@suse.cz
Subject: Re: Suspend to disk (some PATCH)
In-Reply-To: <200604141611.50740.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.61.0604142354390.4238@yvahk01.tjqt.qr>
References: <443C0C2D.1020207@gmx.de> <200604112238.07166.rjw@sisk.pl>
 <443F86EB.8060903@gmx.de> <200604141611.50740.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 
>> pnp: Device 00:08 does not supported activation.
>> pnp: Device 00:09 does not supported activation.

Signed-off-by: Jan Engelhardt <jengelh@gmx.de>

diff --fast -Ndpru linux-2.6.17-rc1~/drivers/pnp/manager.c linux-2.6.17-rc1-csc/drivers/pnp/manager.c
--- linux-2.6.17-rc1~/drivers/pnp/manager.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1-csc/drivers/pnp/manager.c	2006-04-14 23:56:12.592234000 +0200
@@ -479,7 +479,7 @@ int pnp_auto_config_dev(struct pnp_dev *
 int pnp_start_dev(struct pnp_dev *dev)
 {
 	if (!pnp_can_write(dev)) {
-		pnp_info("Device %s does not supported activation.", dev->dev.bus_id);
+		pnp_info("Device %s does not support activation.", dev->dev.bus_id);
 		return -EINVAL;
 	}
 
@@ -503,7 +503,7 @@ int pnp_start_dev(struct pnp_dev *dev)
 int pnp_stop_dev(struct pnp_dev *dev)
 {
 	if (!pnp_can_disable(dev)) {
-		pnp_info("Device %s does not supported disabling.", dev->dev.bus_id);
+		pnp_info("Device %s does not support disabling.", dev->dev.bus_id);
 		return -EINVAL;
 	}
 	if (dev->protocol->disable(dev)<0) {
#<<eof>>



Jan Engelhardt
-- 
