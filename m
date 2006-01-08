Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161121AbWAHBKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161121AbWAHBKg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 20:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161123AbWAHBKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 20:10:36 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:19841 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1161121AbWAHBKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 20:10:36 -0500
From: Grant Coady <gcoady@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH -mm2] usb_ip: fix allyesconfig compile error
Date: Sun, 08 Jan 2006 12:10:12 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <ajp0s156ig2to42tmqq8cssapb5ov71c43@4ax.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Grant Coady <gcoady@gmail.com>

Prevent 2.6.15-mm2 allyesconfig compile error by not allowing 
 USB_IP_STUB when USB_IP_VHCI is selected.

Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.15-mm2/drivers/usb/ip/Kconfig	2006-01-08 10:03:26.000000000 +1100
+++ linux-2.6.15-mm2d/drivers/usb/ip/Kconfig	2006-01-08 12:10:10.000000000 +1100
@@ -22,7 +22,7 @@
 
 config USB_IP_STUB
 	tristate "USB IP stub driver"
-	depends on USB_IP
+	depends on USB_IP && !USB_IP_VHCI
 	---help---
 	  This enables the USB IP device driver which will run on the
 	  host machine.
-- 
Thanks,
Grant.
http://bugsplatter.mine.nu/
