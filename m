Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263864AbTI2RVI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 13:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263873AbTI2RUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:20:21 -0400
Received: from adicia.telenet-ops.be ([195.130.132.56]:64193 "EHLO
	adicia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S263864AbTI2RTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:19:31 -0400
Date: Mon, 29 Sep 2003 19:18:50 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: tom@qwws.net, Brandon Low <lostlogic@gentoo.org>, jbinpg@shaw.ca
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: USB-problem with uhci-hcd in versions 2.6.0-test5 and 2.6.0-test6
Message-ID: <20030929191850.A21072@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I saw that you also reported problems with USB/uhci-hcd on your systems. Can you test
the following patch and see if it works now?

Greetings,
Wim.

--- linux-2.6.0-test6/drivers/usb/host/uhci-hcd.c	2003-09-28 02:50:56.000000000 +0200
+++ linux-2.6.0-test6/drivers/usb/host/uhci-hcd.c	2003-09-28 23:21:30.000000000 +0200
@@ -2185,8 +2185,8 @@
 	/* Maybe kick BIOS off this hardware.  Then reset, so we won't get
 	 * interrupts from any previous setup.
 	 */
-	pci_write_config_word(hcd->pdev, USBLEGSUP, USBLEGSUP_DEFAULT);
 	reset_hc(uhci);
+	pci_write_config_word(hcd->pdev, USBLEGSUP, USBLEGSUP_DEFAULT);
 	return 0;
 }
 
