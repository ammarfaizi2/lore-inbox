Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbRAEATy>; Thu, 4 Jan 2001 19:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129436AbRAEATo>; Thu, 4 Jan 2001 19:19:44 -0500
Received: from foobar.napster.com ([64.124.41.10]:41223 "EHLO
	foobar.napster.com") by vger.kernel.org with ESMTP
	id <S129387AbRAEATb>; Thu, 4 Jan 2001 19:19:31 -0500
Message-ID: <3A55130D.BF0A954@napster.com>
Date: Thu, 04 Jan 2001 16:19:25 -0800
From: Jordan Mendelson <jordy@napster.com>
Organization: Napster, Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-prerelease i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-pre: usbdevfs: USBDEVFS_BULK failed ...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been having some problems with the recent 2.4.x kernels with my
digital camera. The s10sh program accesses the Canon S20 digital camera
using libusb in conjunction with usbfs to download images. Apparently,
incorrect data about the size of images is being sent down the line
after the first image transfer.

Here are some messages printed to syslog:

hub.c: USB new device connect on bus1/1, assigned device number 4
usbserial.c: none matched
usb.c: USB device 4 (vend/prod 0x4a9/0x3043) is not claimed by any
active driver.
usb-uhci.c: interrupt, status 3, frame# 496
usbdevfs: USBDEVFS_BULK failed dev 4 ep 0x81 len 2872 ret -32
usbdevfs: USBDEVFS_BULK failed dev 4 ep 0x81 len 84 ret -32
usbdevfs: USBDEVFS_BULK failed dev 4 ep 0x81 len 64 ret -32
usb.c: USB disconnect on device 4

Now, the USB disconnect never actually happened physically. The camera
looks like it stopped responding to it's USB port.


Jordan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
