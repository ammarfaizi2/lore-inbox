Return-Path: <linux-kernel-owner+w=401wt.eu-S1750772AbXAIAVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbXAIAVu (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 19:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbXAIAVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 19:21:48 -0500
Received: from mga09.intel.com ([134.134.136.24]:28825 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750772AbXAIAVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 19:21:32 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.13,161,1167638400"; 
   d="scan'208"; a="34185909:sNHT25860609"
Date: Mon, 8 Jan 2007 16:21:16 -0800
From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, jikos@jikos.cz,
       akpm@osdl.org, Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [patch 2/2] ACPI: Make bay depend on dock
Message-Id: <20070108162116.6736afc2.kristen.c.accardi@intel.com>
In-Reply-To: <20070108233740.155026806@localhost.localdomain>
References: <20070108233740.155026806@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since the bay driver depends on the dock driver for proper notification,
make this driver depend on the dock driver. 

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
---
 drivers/acpi/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- 2.6-mm.orig/drivers/acpi/Kconfig
+++ 2.6-mm/drivers/acpi/Kconfig
@@ -133,6 +133,7 @@ config ACPI_DOCK
 config ACPI_BAY
 	tristate "Removable Drive Bay"
 	depends on EXPERIMENTAL
+	depends on ACPI_DOCK
 	help
 	  This driver adds support for ACPI controlled removable drive
 	  bays such as the IBM ultrabay or the Dell Module Bay.

--
