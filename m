Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263084AbTEGLU6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 07:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263086AbTEGLU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 07:20:58 -0400
Received: from [205.167.22.118] ([205.167.22.118]:61959 "EHLO
	mks-smtp-1.mksinst.com") by vger.kernel.org with ESMTP
	id S263084AbTEGLU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 07:20:56 -0400
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
From: Nicolae_Popovici@mksinst.com
Subject: WAFER-5823
Date: Wed, 7 May 2003 13:24:25 +0200
Message-ID: <OFD0C7E943.B3B4C6DA-ONC1256D1F.003EA905-C1256D1F.003EA91C@mksinternal.com>
X-MIMETrack: Serialize by Router on MKS-ANDOVER-2/NA/MKS(Release 5.0.11  |July 24, 2002) at
 05/07/2003 07:30:36 AM,
	Itemize by SMTP Server on MKS-SMTP-1/NA/MKS(Release 5.0.11  |July 24, 2002) at
 05/07/2003 07:34:09 AM,
	Serialize by Router on MKS-SMTP-1/NA/MKS(Release 5.0.11  |July 24, 2002) at
 05/07/2003 07:34:15 AM,
	Serialize complete at 05/07/2003 07:34:15 AM
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

   I have a mainboard called WAFER-5823 and I did not manage to get it
running well
with 2.4.20 kernel. In fact the board was running well with an older kernel
2.4.10-4GB
at least the messages from /var/log/messages said so.
Now I have this message inside /var/log/messages
      IRQ routing conflict for 00:13.0, have irq 15, want irq 11
With the old kernel I did not have this problem.
I will output the messages that I get with 2.4.10-4GB and also the messages
that I
get with 2.4.20. I do not know what am I doing wrong.
In fact I followed a discution on this list regarding this kind of board
and I understood that there are problems with the routing mechanism but I
did
not understood how to solve it.
Here are the messages
----- 2.4.10-4GB -------
 usb.c: registered new driver usbdevfs
May  6 16:51:28 hardwaretest1 kernel: usb.c: registered new driver hub
May  6 16:51:28 hardwaretest1 kernel: usb-uhci.c: $Revision: 1.268 $ time
12:53:37 Sep 25 2001
May  6 16:51:28 hardwaretest1 kernel: usb-uhci.c: High bandwidth mode
enabled
May  6 16:51:28 hardwaretest1 kernel: usb-uhci.c: v1.268:USB Universal Host
Controller Interface driver
May  6 16:51:28 hardwaretest1 kernel: PCI: Found IRQ 11 for device 00:13.0
May  6 16:51:28 hardwaretest1 kernel: PCI: Sharing IRQ 11 with 00:0e.0
May  6 16:51:28 hardwaretest1 kernel: usb-ohci.c: USB OHCI at membase
0xc8810000, IRQ 11
May  6 16:51:28 hardwaretest1 kernel: usb-ohci.c: usb-00:13.0, PCI device
0e11:a0f8
May  6 16:51:28 hardwaretest1 kernel: usb.c: new USB bus registered,
assigned bus number 1
May  6 16:51:28 hardwaretest1 kernel: hub.c: USB hub found
May  6 16:51:28 hardwaretest1 kernel: hub.c: 2 ports detected



----- 2.4.20 ------
 usb.c: registered new driver usbdevfs
May  7 20:10:23 scmbox kernel: usb.c: registered new driver hub
May  7 20:10:23 scmbox kernel: usb-uhci.c: $Revision: 1.275 $ time 15:49:14
May  6 2003
May  7 20:10:23 scmbox kernel: usb-uhci.c: High bandwidth mode enabled
May  7 20:10:23 scmbox kernel: usb-uhci.c: v1.275:USB Universal Host
Controller Interface driver
May  7 20:10:23 scmbox kernel: PCI: Found IRQ 11 for device 00:13.0
May  7 20:10:23 scmbox kernel: IRQ routing conflict for 00:13.0, have irq
15, want irq 11
May  7 20:10:23 scmbox kernel: usb-ohci.c: USB OHCI at membase 0xc8823000,
IRQ 15
May  7 20:10:23 scmbox kernel: usb-ohci.c: usb-00:13.0, Compaq Computer
Corporation ZFMicro Chipset USB
May  7 20:10:23 scmbox kernel: usb.c: new USB bus registered, assigned bus
number 1
May  7 20:10:23 scmbox kernel: hub.c: USB hub found
May  7 20:10:23 scmbox kernel: hub.c: 2 ports detected


Thanks,
Nicu



