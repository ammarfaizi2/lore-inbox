Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262281AbTD3SDS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 14:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbTD3SDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 14:03:18 -0400
Received: from [65.244.37.61] ([65.244.37.61]:3911 "EHLO
	WSPNYCON1IPC.corp.root.ipc.com") by vger.kernel.org with ESMTP
	id S262281AbTD3SDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 14:03:17 -0400
Message-ID: <170EBA504C3AD511A3FE00508BB89A9202032A98@exnanycmbx4.ipc.com>
From: "Downing, Thomas" <Thomas.Downing@ipc.com>
To: "Downing, Thomas" <Thomas.Downing@ipc.com>, linux-kernel@vger.kernel.org
Subject: RE: CPIA unknown symbol - ?bug?
Date: Wed, 30 Apr 2003 14:15:26 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Let me repair some cardinal sins of omision:

kernel 2.5.67-bk2
module-init-tools 0.9.9

usbcore, uhci_hcd, videodev, usbvideo, cpia, cpia_usb
all built as modules, without complaint, installed
without complaint.

Doesn' matter whether I do:

modprobe cpia
modprobe cpia_usb

or modprobe cpia_usb


-----Original Message-----
From: Downing, Thomas 
Sent: Wednesday, April 30, 2003 2:09 PM
To: linux-kernel@vger.kernel.org
Subject: CPIA unknown symbol - ?bug?


When I load the module cpia_usb dmesg shows:

cpia_usb: Unknown symbol cpia_register_camera
cpia_usb: Unknown symbol cpia_unregister_camera

Normally this would be no problem, I could fix that; BUT

1. cpia.c does export both these methods, in fact they are
the only two exported.

2. more peculiar still - cpia_usb then successfully calls
cpia_register_camera, the camera is registered according
to dmesg, /proc/bus/usb/devices, /proc/cpia /proc/video/dev.

And the camera works just fine!  So why the error?

Am I missing something here?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
