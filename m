Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751054AbWEHSow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbWEHSow (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 14:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbWEHSov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 14:44:51 -0400
Received: from mga02.intel.com ([134.134.136.20]:50951 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750706AbWEHSov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 14:44:51 -0400
X-IronPort-AV: i="4.05,102,1146466800"; 
   d="scan'208"; a="33244942:sNHT73291519"
Subject: [patch] fix pciehp compile issue when CONFIG_ACPI is not enabled.
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com, greg@kroah.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 08 May 2006 11:54:30 -0700
Message-Id: <1147114470.3094.14.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 08 May 2006 18:44:16.0695 (UTC) FILETIME=[68B24C70:01C672CF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix compile error when CONFIG_ACPI is not defined.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

---
 include/acpi/actypes.h |    1 +
 1 files changed, 1 insertion(+)

--- 2.6-git.orig/include/acpi/actypes.h
+++ 2.6-git/include/acpi/actypes.h
@@ -348,6 +348,7 @@ struct acpi_pointer {
  * Mescellaneous types
  */
 typedef u32 acpi_status;	/* All ACPI Exceptions */
+#define acpi_status acpi_status
 typedef u32 acpi_name;		/* 4-byte ACPI name */
 typedef char *acpi_string;	/* Null terminated ASCII string */
 typedef void *acpi_handle;	/* Actually a ptr to a NS Node */
