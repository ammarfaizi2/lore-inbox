Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbVCAAiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVCAAiM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 19:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbVCAAhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 19:37:16 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:19979 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261157AbVCAAeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 19:34:31 -0500
Date: Tue, 1 Mar 2005 01:34:28 +0100
From: Adrian Bunk <bunk@stusta.de>
To: gregkh@suse.de
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/usb/gadget/config.c: make a function static
Message-ID: <20050301003428.GZ4021@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global function static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/usb/gadget/config.c |    2 +-
 include/linux/usb_gadget.h  |    6 ------
 2 files changed, 1 insertion(+), 7 deletions(-)

--- linux-2.6.11-rc4-mm1-full/include/linux/usb_gadget.h.old	2005-02-28 23:15:09.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/include/linux/usb_gadget.h	2005-02-28 23:15:24.000000000 +0100
@@ -854,12 +854,6 @@
 
 /*-------------------------------------------------------------------------*/
 
-/* utility to simplify managing config descriptors */
-
-/* write vector of descriptors into buffer */
-int usb_descriptor_fillbuf(void *, unsigned,
-		const struct usb_descriptor_header **);
-
 /* build config descriptor from single descriptor vector */
 int usb_gadget_config_buf(const struct usb_config_descriptor *config,
 	void *buf, unsigned buflen, const struct usb_descriptor_header **desc);
--- linux-2.6.11-rc4-mm1-full/drivers/usb/gadget/config.c.old	2005-02-28 23:15:34.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/usb/gadget/config.c	2005-02-28 23:15:49.000000000 +0100
@@ -39,7 +39,7 @@
  * as part of configuring a composite device; or in other cases where
  * sets of descriptors need to be marshaled.
  */
-int
+static int
 usb_descriptor_fillbuf(void *buf, unsigned buflen,
 		const struct usb_descriptor_header **src)
 {

