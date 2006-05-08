Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbWEHUNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWEHUNV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 16:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWEHUNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 16:13:21 -0400
Received: from mga03.intel.com ([143.182.124.21]:13123 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751298AbWEHUNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 16:13:20 -0400
X-IronPort-AV: i="4.05,102,1146466800"; 
   d="scan'208"; a="33313249:sNHT6900234488"
Subject: Re: [patch] fix pciehp compile issue when CONFIG_ACPI is not
	enabled.
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: arjan@linux.intel.com, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org, len.brown@intel.com, greg@kroah.com
In-Reply-To: <20060508192431.GB7235@mipter.zuzino.mipt.ru>
References: <1147114470.3094.14.camel@whizzy>
	 <20060508192431.GB7235@mipter.zuzino.mipt.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 08 May 2006 13:22:52 -0700
Message-Id: <1147119772.3094.42.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 08 May 2006 20:12:37.0942 (UTC) FILETIME=[C07C6560:01C672DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build error when CONFIG_ACPI not defined

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

---
Here's an alternate way to solve this problem - also easy, that may look
nicer. (thanks arjan).

 include/linux/pci-acpi.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- 2.6-git.orig/include/linux/pci-acpi.h
+++ 2.6-git/include/linux/pci-acpi.h
@@ -50,7 +50,7 @@
 extern acpi_status pci_osc_control_set(acpi_handle handle, u32 flags);
 extern acpi_status pci_osc_support_set(u32 flags);
 #else
-#if !defined(acpi_status)
+#if !defined(AE_ERROR)
 typedef u32 		acpi_status;
 #define AE_ERROR      	(acpi_status) (0x0001)
 #endif    
