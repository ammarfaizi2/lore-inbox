Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262394AbVC3Sqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262394AbVC3Sqq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 13:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262393AbVC3SpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 13:45:07 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:27655 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S262388AbVC3Sn2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 13:43:28 -0500
Date: Wed, 30 Mar 2005 13:43:23 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org
Cc: netdev@oss.sgi.com, jgarzik@pobox.com, cramerj@intel.com,
       john.ronciak@intel.com, ganesh.venkatesan@intel.com
Subject: [patch netdev-2.6] ixgb: Add MODULE_VERSION
Message-ID: <20050330184321.GC10049@tuxdriver.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
	jgarzik@pobox.com, cramerj@intel.com, john.ronciak@intel.com,
	ganesh.venkatesan@intel.com
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

 drivers/net/ixgb/ixgb_main.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

--- netdev-2.6/drivers/net/ixgb/ixgb_main.c.orig	2005-03-30 13:34:37.803202027 -0500
+++ netdev-2.6/drivers/net/ixgb/ixgb_main.c	2005-03-30 13:34:12.038683827 -0500
@@ -47,7 +47,8 @@ char ixgb_driver_string[] = "Intel(R) PR
 #else
 #define DRIVERNAPI "-NAPI"
 #endif
-char ixgb_driver_version[] = "1.0.90-k2"DRIVERNAPI;
+#define DRV_VERSION "1.0.90-k2"DRIVERNAPI
+char ixgb_driver_version[] = DRV_VERSION;
 char ixgb_copyright[] = "Copyright (c) 1999-2005 Intel Corporation.";
 
 /* ixgb_pci_tbl - PCI Device ID Table
@@ -152,6 +153,7 @@ static struct pci_driver ixgb_driver = {
 MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
 MODULE_DESCRIPTION("Intel(R) PRO/10GbE Network Driver");
 MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
 
 /* some defines for controlling descriptor fetches in h/w */
 #define RXDCTL_PTHRESH_DEFAULT 128	/* chip considers prefech below this */
-- 
John W. Linville
linville@tuxdriver.com
