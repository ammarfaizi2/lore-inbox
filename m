Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbTJ3AwT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 19:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbTJ3AvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 19:51:25 -0500
Received: from mail.kroah.org ([65.200.24.183]:43956 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262076AbTJ3AvM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 19:51:12 -0500
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10674750383445@kroah.com>
Subject: Re: [PATCH] fixes for 2.6.0-test9
In-Reply-To: <10674750383605@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 29 Oct 2003 16:50:38 -0800
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1386, 2003/10/29 16:04:55-08:00, greg@kroah.com

[PATCH] USB: don't build the whiteheat driver if on SMP as the locking is all messed up.


 drivers/usb/serial/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/usb/serial/Kconfig b/drivers/usb/serial/Kconfig
--- a/drivers/usb/serial/Kconfig	Wed Oct 29 16:45:09 2003
+++ b/drivers/usb/serial/Kconfig	Wed Oct 29 16:45:09 2003
@@ -73,7 +73,7 @@
 
 config USB_SERIAL_WHITEHEAT
 	tristate "USB ConnectTech WhiteHEAT Serial Driver"
-	depends on USB_SERIAL
+	depends on USB_SERIAL && BROKEN_ON_SMP
 	help
 	  Say Y here if you want to use a ConnectTech WhiteHEAT 4 port
 	  USB to serial converter device.

