Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbUC0JjU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 04:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbUC0JjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 04:39:20 -0500
Received: from p3EE060C4.dip0.t-ipconnect.de ([62.224.96.196]:1921 "EHLO
	susi.maya.org") by vger.kernel.org with ESMTP id S261685AbUC0JjR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 04:39:17 -0500
Message-ID: <40654BC0.3090902@p3EE060C4.dip0.t-ipconnect.de>
Date: Sat, 27 Mar 2004 10:39:12 +0100
From: Andreas Hartmann <andihartmann@freenet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040212
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernels 2.6.4 and 2.6.5rc don't handle HAMA USB device correctly
X-Enigmail-Version: 0.82.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I have a USB device from hama, "8 in 1 card reader", USB 2.0. Kernel 
2.4.25 recognizes this device correctly and I can use it:

Mar 27 10:23:54 athlon kernel: hub.c: new USB device 00:10.1-1, assigned 
address 2
Mar 27 10:23:55 athlon kernel: scsi0 : SCSI emulation for USB Mass Storage 
devices
Mar 27 10:23:55 athlon kernel:   Vendor: SMSC      Model: 223 U HS-CF 
   Rev: 1.95
Mar 27 10:23:55 athlon kernel:   Type:   Direct-Access 
   ANSI SCSI revision: 02
Mar 27 10:23:55 athlon kernel:   Vendor: SMSC      Model: 223 U HS-MS 
   Rev: 1.95
Mar 27 10:23:55 athlon kernel:   Type:   Direct-Access 
   ANSI SCSI revision: 02
Mar 27 10:23:55 athlon kernel:   Vendor: SMSC      Model: 223 U HS-SM 
   Rev: 1.95
Mar 27 10:23:55 athlon kernel:   Type:   Direct-Access 
   ANSI SCSI revision: 02
Mar 27 10:23:55 athlon kernel:   Vendor: SMSC      Model: 223 U HS-SD/MMC 
   Rev: 1.95
Mar 27 10:23:55 athlon kernel:   Type:   Direct-Access 
   ANSI SCSI revision: 02
Mar 27 10:23:55 athlon kernel: WARNING: USB Mass Storage data integrity 
not assured
Mar 27 10:23:55 athlon kernel: USB Mass Storage device found at 2

These are the modules, I'm using in 2.4.25:
usb-storage            26384   0
scsi_mod               87328   2  [sd_mod usb-storage]
uhci                   25436   0  (unused)
usbcore                62252   0  [usb-storage uhci]



Kernel 2.6.4 or 5rc2 doesn't handle the device correctly:

Mar 27 09:52:02 athlon kernel: usb 2-1: new full speed USB device using 
address 8
Mar 27 09:52:02 athlon kernel: scsi6 : SCSI emulation for USB Mass Storage 
devices
Mar 27 09:52:02 athlon kernel:   Vendor: SMSC      Model: 223 U HS-CF 
   Rev: 1.95
Mar 27 09:52:02 athlon kernel:   Type:   Direct-Access 
   ANSI SCSI revision: 02
Mar 27 09:52:02 athlon kernel: Attached scsi removable disk sda at scsi6, 
channel 0, id 0, lun 0
Mar 27 09:52:02 athlon kernel: WARNING: USB Mass Storage data integrity 
not assured
Mar 27 09:52:02 athlon kernel: USB Mass Storage device found at 8

I tried to mount it with /dev/sda[1-8], but I always got the answer, that 
there would be no media - but this is definitely wrong. Kernel 2.4.25 
finds the media and handles it correctly.



Kind regards,
Andreas Hartmann
