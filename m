Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290639AbSBGR2h>; Thu, 7 Feb 2002 12:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290615AbSBGR1Z>; Thu, 7 Feb 2002 12:27:25 -0500
Received: from zero.tech9.net ([209.61.188.187]:41230 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S290490AbSBGR1N>;
	Thu, 7 Feb 2002 12:27:13 -0500
Subject: [PATCH] 2.5: bluetooth compile fix
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: viro@math.psu.edu, greg@kroah.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 07 Feb 2002 12:27:09 -0500
Message-Id: <1013102830.9535.14.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The llseek cleanup contained a typo in bluetooth/hci_vhci.c that
prevents compile.  Thankfully it seems to be the only of this type.

Patch against 2.5.4-pre2.  Please, apply.

	Robert Love

diff -urN linux-2.5.4-pre2/drivers/bluetooth/hci_vhci.c linux/drivers/bluetooth/hci_vhci.c
--- linux-2.5.4-pre2/drivers/bluetooth/hci_vhci.c	Thu Feb  7 12:04:48 2002
+++ linux/drivers/bluetooth/hci_vhci.c	Thu Feb  7 12:24:00 2002
@@ -291,7 +291,7 @@
 
 static struct file_operations hci_vhci_fops = {
 	owner:	THIS_MODULE,	
-	llseek:	no_lseek,
+	llseek:	no_llseek,
 	read:	hci_vhci_chr_read,
 	write:	hci_vhci_chr_write,
 	poll:	hci_vhci_chr_poll,


