Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752789AbWKBX2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752789AbWKBX2G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 18:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752806AbWKBX2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 18:28:06 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:24075 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1752789AbWKBX2E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 18:28:04 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc4-mm2 [PATCH] acpi unsused variable cleanup
Date: Fri, 3 Nov 2006 00:27:03 +0100
User-Agent: KMail/1.9.5
References: <20061101235407.a92f94a5.akpm@osdl.org>
In-Reply-To: <20061101235407.a92f94a5.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200611030027.03443.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	So far 2.6.19-rc4-mm2 works fine for me. I attached trivial warning fix to 
address this:

drivers/acpi/events/evmisc.c: In function 'acpi_ev_global_lock_handler':
drivers/acpi/events/evmisc.c:334: warning: unused variable 'status'

The patch is against 2.6.19-rc4-mm2.

Regards,

	Mariusz Kozlowski


Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
---
--- linux-2.6.19-rc4-orig/drivers/acpi/events/evmisc.c  2006-11-02 
23:51:15.000000000 +0100
+++ linux-2.6.19-rc4/drivers/acpi/events/evmisc.c       2006-11-03 
00:02:40.000000000 +0100
@@ -331,7 +331,6 @@ static void ACPI_SYSTEM_XFACE acpi_ev_gl
 static u32 acpi_ev_global_lock_handler(void *context)
 {
        u8 acquired = FALSE;
-       acpi_status status;
 
        /*
         * Attempt to get the lock
