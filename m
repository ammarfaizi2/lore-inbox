Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbTEEUlk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 16:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbTEEUlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 16:41:40 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:61057 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id S261311AbTEEUlh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 16:41:37 -0400
Subject: USB not working with 2.5.69, worked with .68
From: Stian Jordet <liste@jordet.nu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1052168060.826.8.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.2 (Preview Release)
Date: 05 May 2003 22:54:20 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have suddenly no working usb anymore. It worked perfect with 2.5.68
(And all earlier 2.5.x I have tried (which are most of them)). I get
this in the log:

drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface
driver v2.0
uhci-hcd 00:11.2: VIA Technologies, In USB
uhci-hcd 00:11.2: irq 19, io base 00009800
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is
deprecated.
uhci-hcd 00:11.2: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
uhci-hcd 00:11.3: VIA Technologies, In USB (#2)
uhci-hcd 00:11.3: irq 19, io base 00009400
uhci-hcd 00:11.3: new USB bus registered, assigned bus number 2
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
uhci-hcd 00:11.4: VIA Technologies, In USB (#3)
uhci-hcd 00:11.4: irq 19, io base 00009000
uhci-hcd 00:11.4: new USB bus registered, assigned bus number 3
hub 3-0:0: USB hub found
hub 3-0:0: 2 ports detected
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 1-0:0: new USB device on port 1, assigned address 2
drivers/usb/core/message.c: usb_control/bulk_msg: timeout
drivers/usb/core/message.c: usb_control/bulk_msg: timeout
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
drivers/usb/core/usb.c: registered new driver usbscanner
drivers/usb/image/scanner.c: 0.4.11:USB Scanner Driver
usb 1-1: USB device not accepting new address=2 (error=-110)
hub 1-0:0: new USB device on port 1, assigned address 3
drivers/usb/core/message.c: usb_control/bulk_msg: timeout
Bluetooth: HCI USB driver ver 2.4
drivers/usb/core/usb.c: registered new driver hci_usb
usb 1-1: USB device not accepting new address=3 (error=-110)
hub 3-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 3-0:0: new USB device on port 1, assigned address 2
drivers/usb/core/message.c: usb_control/bulk_msg: timeout
drivers/usb/core/message.c: usb_control/bulk_msg: timeout
usb 3-1: USB device not accepting new address=2 (error=-110)
hub 3-0:0: new USB device on port 1, assigned address 3
drivers/usb/core/message.c: usb_control/bulk_msg: timeout
drivers/usb/core/message.c: usb_control/bulk_msg: timeout
usb 3-1: USB device not accepting new address=3 (error=-110)
hub 3-0:0: debounce: port 2: delay 100ms stable 4 status 0x101
hub 3-0:0: new USB device on port 2, assigned address 4
drivers/usb/core/message.c: usb_control/bulk_msg: timeout
usb 3-2: USB device not accepting new address=4 (error=-110)
hub 3-0:0: new USB device on port 2, assigned address 5
drivers/usb/core/message.c: usb_control/bulk_msg: timeout
usb 3-2: USB device not accepting new address=5 (error=-110)

(Here I first load uhci-hcd, usblp (but the printer wasn't connected :P
), scanner and usb-hci. The thirs usb device connected is a pl2303
serial converter. Didn't load that driver.)

I have read somewhere that the USB device not accepting new address
means that the host-controller doesn't get an interrupt, and that this
often is because of ACPI. It's just the same with acpi disabled (and in
2.5.68 it did work with and without acpi).

Do you need any more info, or am I just doing something really, really
stupid?

Thanks.

Best regards,
Stian

