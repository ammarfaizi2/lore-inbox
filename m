Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751060AbVLZKY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbVLZKY7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 05:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751066AbVLZKY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 05:24:59 -0500
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:59071 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751057AbVLZKY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 05:24:58 -0500
Date: Mon, 26 Dec 2005 11:25:59 +0100 (CET)
From: Bodo Eggert <7eggert@gmx.de>
To: Alan Stern <stern@rowland.harvard.edu>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: [PATCH] USB_BANDWIDTH documentation change
Message-ID: <Pine.LNX.4.58.0512261050100.4021@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Document the current status of CONFIG_USB_BANDWITH implementation.

Signed-Off-By: Bodo Eggert <7eggert@gmx.de>
---
As discussed in news:5nRQy-6OB-9@gated-at.bofh.it, USB_BANDWIDTH does not 
work correctly. I took the time to add this fact to the documentation.

--- 2.6.14/drivers/usb/core/Kconfig.ori	2005-12-26 10:44:49.000000000 +0100
+++ 2.6.14/drivers/usb/core/Kconfig	2005-12-26 10:49:05.000000000 +0100
@@ -49,6 +49,11 @@ config USB_BANDWIDTH
 	  about USB bandwidth usage to be logged and some devices or
 	  drivers may not work correctly.
 
+	  Currently this option does not work with uhci-hcd (never worked) or
+	  ehci-hcd (problems involved with scheduling periodic transfers to a
+	  full-speed device connected through a high-speed hub). Don't enable
+	  this option for these controlers.
+
 config USB_DYNAMIC_MINORS
 	bool "Dynamic USB minor allocation (EXPERIMENTAL)"
 	depends on USB && EXPERIMENTAL

-- 
            A. Top posters
            Q. What's the most annoying thing on Usenet?
