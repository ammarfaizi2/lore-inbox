Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbULHX05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbULHX05 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 18:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbULHX0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 18:26:53 -0500
Received: from motgate8.mot.com ([129.188.136.8]:31405 "EHLO motgate8.mot.com")
	by vger.kernel.org with ESMTP id S261408AbULHX0n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 18:26:43 -0500
Date: Wed, 8 Dec 2004 17:26:40 -0600 (CST)
From: Kumar Gala <galak@linen.sps.mot.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, rmk@arm.linux.org.uk, greg@kroah.com
Subject: [PATCH] Add prototypes for platform_get_resource_byname &
 platform_get_resource_byirq
In-Reply-To: <Pine.LNX.4.61.0412081703030.4040@linen.sps.mot.com>
Message-ID: <Pine.LNX.4.61.0412081723190.4069@linen.sps.mot.com>
References: <Pine.LNX.4.61.0412081703030.4040@linen.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the prototypes forgotten in the initial patch for 
platform_get_resource_byname & platform_get_resource_byirq.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

--

diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	2004-12-08 17:22:36 -06:00
+++ b/include/linux/device.h	2004-12-08 17:22:36 -06:00
@@ -382,6 +382,8 @@
 
 extern struct resource *platform_get_resource(struct platform_device *, unsigned int, unsigned int);
 extern int platform_get_irq(struct platform_device *, unsigned int);
+extern struct resource *platform_get_resource_byname(struct platform_device *, unsigned int, char *);
+extern int platform_get_irq_byname(struct platform_device *, char *);
 extern int platform_add_devices(struct platform_device **, int);
 
 extern struct platform_device *platform_device_register_simple(char *, unsigned int, struct resource *, unsigned int);

