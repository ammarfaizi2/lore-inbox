Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbWHUXUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbWHUXUZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 19:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWHUXUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 19:20:25 -0400
Received: from hera.kernel.org ([140.211.167.34]:9913 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751300AbWHUXUY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 19:20:24 -0400
From: Len Brown <len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Maciej Rutecki <maciej.rutecki@gmail.com>
Subject: Re: 2.6.18-rc4-mm2
Date: Mon, 21 Aug 2006 19:22:09 -0400
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
References: <20060819220008.843d2f64.akpm@osdl.org> <20060821064411.20e61aa0.akpm@osdl.org> <44EA1585.8020303@gmail.com>
In-Reply-To: <44EA1585.8020303@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608211922.10182.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please dump the stack so we can find the secretive caller to 
acpi_format_exception().

thanks,
-Len

diff --git a/drivers/acpi/utilities/utglobal.c b/drivers/acpi/utilities/utglobal.c
index 014030a..561ea5e 100644
--- a/drivers/acpi/utilities/utglobal.c
+++ b/drivers/acpi/utilities/utglobal.c
@@ -125,6 +125,7 @@ const char *acpi_format_exception(acpi_s
 			    "Unknown exception code: 0x%8.8X", status));
 
 		exception = "UNKNOWN_STATUS_CODE";
+dump_stack();
 	}
 
 	return (ACPI_CAST_PTR(const char, exception));

