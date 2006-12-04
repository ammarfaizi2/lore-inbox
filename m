Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966312AbWLDUCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966312AbWLDUCF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 15:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966278AbWLDUCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 15:02:04 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3685 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S966312AbWLDUCC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 15:02:02 -0500
Date: Mon, 4 Dec 2006 21:02:06 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       Randy Dunlap <randy.dunlap@oracle.com>
Subject: [2.6 patch] USB_RTL8150 must select MII
Message-ID: <20061204200206.GA7027@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

USB_RTL8150 must select MII to avoid link errors.

Stolen from a patch by Randy Dunlap.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 4 Nov 2006

--- linux-2619-rc3-pv.orig/drivers/usb/net/Kconfig
+++ linux-2619-rc3-pv/drivers/usb/net/Kconfig
@@ -84,6 +84,7 @@ config USB_PEGASUS
 config USB_RTL8150
 	tristate "USB RTL8150 based ethernet device support (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
+	select MII
 	help
 	  Say Y here if you have RTL8150 based usb-ethernet adapter.
 	  Send me <petkan@users.sourceforge.net> any comments you may have.

