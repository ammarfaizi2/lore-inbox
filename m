Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270413AbUJUG0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270413AbUJUG0R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 02:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270414AbUJTT2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 15:28:15 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:2316 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S270293AbUJTTVl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:21:41 -0400
Date: Wed, 20 Oct 2004 14:16:57 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       john.ronciak@intel.com, ganesh.venkatesan@intel.com
Subject: [patch 2.6.9 3/11] e1000: Add MODULE_VERSION
Message-ID: <20041020141657.F8775@tuxdriver.com>
Mail-Followup-To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
	jgarzik@pobox.com, john.ronciak@intel.com,
	ganesh.venkatesan@intel.com
References: <20041020141146.C8775@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041020141146.C8775@tuxdriver.com>; from linville@tuxdriver.com on Wed, Oct 20, 2004 at 02:11:46PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add MODULE_VERSION to e1000 driver.

 drivers/net/e1000/e1000_main.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.9/drivers/net/e1000/e1000_main.c.orig
+++ linux-2.6.9/drivers/net/e1000/e1000_main.c
@@ -48,7 +48,8 @@ char e1000_driver_string[] = "Intel(R) P
 #else
 #define DRIVERNAPI "-NAPI"
 #endif
-char e1000_driver_version[] = "5.3.19-k2"DRIVERNAPI;
+#define DRV_VERSION "5.3.19-k2"DRIVERNAPI
+char e1000_driver_version[] = DRV_VERSION;
 char e1000_copyright[] = "Copyright (c) 1999-2004 Intel Corporation.";
 
 /* e1000_pci_tbl - PCI Device ID Table
@@ -196,6 +197,7 @@ static struct pci_driver e1000_driver = 
 MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
 MODULE_DESCRIPTION("Intel(R) PRO/1000 Network Driver");
 MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
 
 static int debug = NETIF_MSG_DRV | NETIF_MSG_PROBE;
 module_param(debug, int, 0);
