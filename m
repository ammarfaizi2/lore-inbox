Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbUBWUVY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 15:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbUBWUVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 15:21:24 -0500
Received: from mail.broadpark.no ([217.13.4.2]:27346 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S262027AbUBWUUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 15:20:55 -0500
Date: Mon, 23 Feb 2004 21:20:52 +0100
From: Joachim Berdal Haga <jbh@riget.hn.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.3-mm3: usb printer problem (works in stock 2.6.3)
Message-Id: <20040223212052.62fe3010.jbh@riget.hn.org>
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Printing on usb doesn't work for me in 2.6.3-mm3 (or -mm1). The printer
is recognized and a session is opened, but never finished (and nothing is printed). After a few minutes the printer prints out a page saying
"PCL6 ERROR - Incomplete session by time out".

This works on plain 2.6.3.

USB debugging messages appended below.

Regards,
Joachim B Haga (please CC)



Feb 23 20:48:46 handy kernel: uhci_hcd 0000:00:05.2: wakeup_hc
Feb 23 20:48:46 handy kernel: uhci_hcd 0000:00:05.2: port 1 portsc 0082
Feb 23 20:48:46 handy kernel: hub 1-0:1.0: port 1, status 100, change 1, 12 Mb/s
Feb 23 20:48:46 handy kernel: uhci_hcd 0000:00:05.2: port 1 portsc 0093
Feb 23 20:48:46 handy kernel: hub 1-0:1.0: port 1, status 101, change 1, 12 Mb/s
Feb 23 20:48:46 handy kernel: hub 1-0:1.0: debounce: port 1: delay 100ms stable 4 status 0x101
Feb 23 20:48:46 handy kernel: usb 1-1: new full speed USB device using address 2
Feb 23 20:48:46 handy kernel: uhci_hcd 0000:00:05.2: uhci_result_control: failed with status 440000
Feb 23 20:48:46 handy kernel: [cb37e240] link (0b37e1e2) element (0b387040)
Feb 23 20:48:46 handy kernel:   0: [cb387040] link (0b387080) e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=0, PID=2d(SETUP) (buf=0a8dfda0)
Feb 23 20:48:46 handy kernel:   1: [cb387080] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=0, PID=69(IN) (buf=00000000)
Feb 23 20:48:46 handy kernel: 
Feb 23 20:48:46 handy kernel: uhci_hcd 0000:00:05.2: uhci_result_control: failed with status 440000
Feb 23 20:48:46 handy kernel: [cb37e240] link (0b37e1e2) element (0b387040)
Feb 23 20:48:46 handy kernel:   0: [cb387040] link (0b387080) e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=0, PID=2d(SETUP) (buf=0a8dfda0)
Feb 23 20:48:46 handy kernel:   1: [cb387080] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=0, PID=69(IN) (buf=00000000)
Feb 23 20:48:46 handy kernel: 
Feb 23 20:48:47 handy kernel: usb 1-1: device not accepting address 2, error -110
Feb 23 20:48:47 handy kernel: usb 1-1: new full speed USB device using address 3
Feb 23 20:48:47 handy kernel: uhci_hcd 0000:00:05.2: uhci_result_control: failed with status 440000
Feb 23 20:48:47 handy kernel: [cb37e240] link (0b37e1e2) element (0b387040)
Feb 23 20:48:47 handy kernel:   0: [cb387040] link (0b387080) e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=0, PID=2d(SETUP) (buf=0a8dfda0)
Feb 23 20:48:47 handy kernel:   1: [cb387080] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=0, PID=69(IN) (buf=00000000)
Feb 23 20:48:47 handy kernel: 
Feb 23 20:48:47 handy kernel: uhci_hcd 0000:00:05.2: uhci_result_control: failed with status 440000
Feb 23 20:48:47 handy kernel: [cb37e240] link (0b37e1e2) element (0b387040)
Feb 23 20:48:47 handy kernel:   0: [cb387040] link (0b387080) e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=0, PID=2d(SETUP) (buf=0a8dfda0)
Feb 23 20:48:47 handy kernel:   1: [cb387080] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=0, PID=69(IN) (buf=00000000)
Feb 23 20:48:47 handy kernel: 
Feb 23 20:48:47 handy kernel: usb 1-1: device not accepting address 3, error -110
Feb 23 20:48:47 handy kernel: uhci_hcd 0000:00:05.2: port 1 portsc 009b
Feb 23 20:48:47 handy kernel: hub 1-0:1.0: port 1, status 101, change 3, 12 Mb/s
Feb 23 20:48:47 handy kernel: uhci_hcd 0000:00:05.2: port 1 portsc 0099
Feb 23 20:48:48 handy kernel: hub 1-0:1.0: debounce: port 1: delay 100ms stable 4 status 0x101
Feb 23 20:48:48 handy kernel: usb 1-1: new full speed USB device using address 4
Feb 23 20:48:48 handy kernel: usb 1-1: new device strings: Mfr=1, Product=2, SerialNumber=3
Feb 23 20:48:48 handy kernel: drivers/usb/core/message.c: USB device number 4 default language ID 0x409
Feb 23 20:48:48 handy kernel: usb 1-1: Product: Samsung ML-1710 Series
Feb 23 20:48:48 handy kernel: usb 1-1: Manufacturer: Samsung Electronics Co., Ltd.
Feb 23 20:48:48 handy kernel: usb 1-1: SerialNumber: 2221BAAW900597A0
Feb 23 20:48:48 handy kernel: drivers/usb/core/usb.c: usb_hotplug
Feb 23 20:48:48 handy kernel: usb 1-1: registering 1-1:1.0 (config #1, interface 0)
Feb 23 20:48:48 handy kernel: drivers/usb/core/usb.c: usb_hotplug
Feb 23 20:48:48 handy kernel: usblp 1-1:1.0: usb_probe_interface
Feb 23 20:48:48 handy kernel: usblp 1-1:1.0: usb_probe_interface - got id
Feb 23 20:48:48 handy kernel: drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 4 if 0 alt 0 proto 2 vid 0x04E8 pid 0x323A
Feb 23 20:48:48 handy kernel: drivers/usb/core/file.c: looking for a minor, starting at 0
Feb 23 20:48:48 handy kernel: drivers/usb/core/usb.c: registered new driver usblp
Feb 23 20:48:48 handy kernel: drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
