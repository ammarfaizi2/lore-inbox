Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262335AbUCCN6A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 08:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262346AbUCCN6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 08:58:00 -0500
Received: from gruby.cs.net.pl ([62.233.142.99]:48141 "EHLO gruby.cs.net.pl")
	by vger.kernel.org with ESMTP id S262335AbUCCN56 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 08:57:58 -0500
Date: Wed, 3 Mar 2004 14:57:56 +0100
From: Jakub Bogusz <qboosh@pld-linux.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6] USB_GADGET depends on USB
Message-ID: <20040303135756.GH7223@gruby.cs.net.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Up to current cset it's possible to select USB_GADGET even if USB is
disabled (causing only compilation errors). This patch adds depends
rules to disallow USB_GADGET if USB is not enabled (similar to those
found in other drivers/usb/*/Kconfig files).


-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/
PLD Team        http://www.pld-linux.org/

--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-usb-gadget-requires-usb.patch"

--- linux-2.6.4-rc1/drivers/usb/gadget/Kconfig.orig	2004-02-27 22:21:00.000000000 +0000
+++ linux-2.6.4-rc1/drivers/usb/gadget/Kconfig	2004-03-03 13:50:01.000000000 +0000
@@ -4,9 +4,11 @@
 #    (b) the gadget driver using it.
 #
 menu "USB Gadget Support"
+	depends on USB
 
 config USB_GADGET
 	tristate "Support for USB Gadgets"
+	depends on USB
 	help
 	   USB is a master/slave protocol, organized with one master
 	   host (such as a PC) controlling up to 127 peripheral devices.

--huq684BweRXVnRxX--
