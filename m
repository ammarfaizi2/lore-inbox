Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262424AbVC3Sop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbVC3Sop (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 13:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262393AbVC3Sop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 13:44:45 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:28935 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S262418AbVC3SoE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 13:44:04 -0500
Date: Wed, 30 Mar 2005 13:44:03 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org
Cc: netdev@oss.sgi.com, jgarzik@pobox.com, ayyappan.veeraiyan@intel.com,
       john.ronciak@intel.com, ganesh.venkatesan@intel.com
Subject: [patch netdev-2.6] e1000: add MODULE_VERSION
Message-ID: <20050330184403.GD10049@tuxdriver.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
	jgarzik@pobox.com, ayyappan.veeraiyan@intel.com,
	john.ronciak@intel.com, ganesh.venkatesan@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add MODULE_VERSION entry.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---
I posted one like this before, but it seems to have been lost or
overwritten...

 drivers/net/e1000/e1000_main.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

--- netdev-2.6/drivers/net/e1000/e1000_main.c.orig	2005-03-30 13:30:02.355409590 -0500
+++ netdev-2.6/drivers/net/e1000/e1000_main.c	2005-03-30 13:31:13.174846755 -0500
@@ -65,7 +65,8 @@ char e1000_driver_string[] = "Intel(R) P
 #else
 #define DRIVERNAPI "-NAPI"
 #endif
-char e1000_driver_version[] = "5.7.6-k2"DRIVERNAPI;
+#define DRV_VERSION "5.7.6-k2"DRIVERNAPI
+char e1000_driver_version[] = DRV_VERSION;
 char e1000_copyright[] = "Copyright (c) 1999-2004 Intel Corporation.";
 
 /* e1000_pci_tbl - PCI Device ID Table
@@ -210,6 +211,7 @@ static struct pci_driver e1000_driver = 
 MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
 MODULE_DESCRIPTION("Intel(R) PRO/1000 Network Driver");
 MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
 
 static int debug = NETIF_MSG_DRV | NETIF_MSG_PROBE;
 module_param(debug, int, 0);
-- 
John W. Linville
linville@tuxdriver.com
