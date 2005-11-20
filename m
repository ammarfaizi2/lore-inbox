Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbVKTXWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbVKTXWl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 18:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbVKTXWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 18:22:41 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:41232 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932116AbVKTXWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 18:22:40 -0500
Date: Mon, 21 Nov 2005 00:22:39 +0100
From: Adrian Bunk <bunk@stusta.de>
To: gregkh@suse.de, Thomas Winischhofer <thomas@winischhofer.net>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/usb/misc/sisusbvga/sisusb.c: remove dead code
Message-ID: <20051120232239.GI16060@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker found this obviously dead code.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/usb/misc/sisusbvga/sisusb.c |    6 ------
 1 file changed, 6 deletions(-)

--- linux-2.6.15-rc1-mm2-full/drivers/usb/misc/sisusbvga/sisusb.c.old	2005-11-20 22:56:41.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/drivers/usb/misc/sisusbvga/sisusb.c	2005-11-20 22:58:22.000000000 +0100
@@ -861,13 +861,10 @@
 
 	while (length) {
 
 	    switch (length) {
 
-		case 0:
-			return ret;
-
 		case 1:
 			if (userbuffer) {
 				if (get_user(swap8, (u8 __user *)userbuffer))
 					return -EFAULT;
 			} else
@@ -1219,13 +1216,10 @@
 
 	while (length) {
 
 	    switch (length) {
 
-		case 0:
-			return ret;
-
 		case 1:
 
 			ret |= sisusb_read_memio_byte(sisusb, SISUSB_TYPE_MEM,
 								addr, &buf[0]);
 			if (!ret) {

