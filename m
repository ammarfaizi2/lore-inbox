Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbUCZC2r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 21:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbUCZC2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 21:28:47 -0500
Received: from gate.crashing.org ([63.228.1.57]:43144 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261988AbUCZC2p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 21:28:45 -0500
Subject: [BUG] keyspan USB broken in current 2.6.5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux-USB <linux-usb-devel@lists.sourceforge.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1080268100.3071.27.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 26 Mar 2004 13:28:20 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It detects the device, downloads the firmware, the device disconnects,
but never reconnects. Here's the dmesg log. Worked fine with 2.6.4, we
tried with different keyspan adapters.

usb 1-1: new full speed USB device using address 2
drivers/usb/core/usb.c: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
drivers/usb/serial/usb-serial.c: USB Serial support registered for
Keyspan - (without firmware)
drivers/usb/serial/usb-serial.c: USB Serial support registered for
Keyspan 1 port adapter
drivers/usb/serial/usb-serial.c: USB Serial support registered for
Keyspan 2 port adapter
drivers/usb/serial/usb-serial.c: USB Serial support registered for
Keyspan 4 port adapter
keyspan 1-1:1.0: Keyspan - (without firmware) converter detected
drivers/usb/core/usb.c: registered new driver keyspan
drivers/usb/serial/keyspan.c: v1.1.4:Keyspan USB to Serial Converter
Driver
usb 1-1: USB disconnect, address 2
keyspan 1-1:1.0: device disconnected

Ben.


