Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbVAHGBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbVAHGBl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 01:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbVAHGAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 01:00:41 -0500
Received: from mail.kroah.org ([69.55.234.183]:19333 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261802AbVAHFr5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:47:57 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632684120@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:48 -0800
Message-Id: <11051632683808@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.446.39, 2004/12/20 10:37:42-08:00, greg@kroah.com

USB: change warning level in ftdi_sio driver of a debug message.

This keeps users happy as it really isn't an error.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/serial/ftdi_sio.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
--- a/drivers/usb/serial/ftdi_sio.c	2005-01-07 15:44:16 -08:00
+++ b/drivers/usb/serial/ftdi_sio.c	2005-01-07 15:44:16 -08:00
@@ -1651,7 +1651,7 @@
 	dbg("%s port %d, %d bytes", __FUNCTION__, port->number, count);
 
 	if (count == 0) {
-		err("write request of 0 bytes");
+		dbg("write request of 0 bytes");
 		return 0;
 	}
 	

