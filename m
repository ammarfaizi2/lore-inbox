Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263227AbUDEVOL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 17:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263240AbUDEVOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 17:14:10 -0400
Received: from gprs214-195.eurotel.cz ([160.218.214.195]:37248 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263227AbUDEVMe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 17:12:34 -0400
Date: Mon, 5 Apr 2004 23:12:24 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: 1394: warn if machine is going to crash
Message-ID: <20040405211224.GA3597@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

...and it *is* going to crash if unregistering ioctl32 handler
fails. Please apply,
							Pavel

Index: linux/drivers/ieee1394/video1394.c
===================================================================
--- linux.orig/drivers/ieee1394/video1394.c	2004-04-05 22:47:34.000000000 +0200
+++ linux/drivers/ieee1394/video1394.c	2004-04-05 16:50:21.000000000 +0200
@@ -1438,7 +1438,7 @@
 	ret |= unregister_ioctl32_conversion(VIDEO1394_IOC32_TALK_WAIT_BUFFER);
 	ret |= unregister_ioctl32_conversion(VIDEO1394_IOC32_LISTEN_POLL_BUFFER);
 	if (ret)
-		PRINT_G(KERN_INFO, "Error unregistering ioctl32 translations");
+		PRINT_G(KERN_CRIT, "Error unregistering ioctl32 translations");
 #endif
 
 	hpsb_unregister_protocol(&video1394_driver);

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
