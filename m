Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbTKLCDK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 21:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbTKLCDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 21:03:10 -0500
Received: from bay8-f125.bay8.hotmail.com ([64.4.27.125]:12296 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261271AbTKLCDH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 21:03:07 -0500
X-Originating-IP: [24.170.190.81]
X-Originating-Email: [jim_jim33@hotmail.com]
From: "jim beam" <jim_jim33@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: USB mass storage device problem
Date: Wed, 12 Nov 2003 02:03:03 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY8-F125ED2QfgNy3T000559e2@hotmail.com>
X-OriginalArrivalTime: 12 Nov 2003 02:03:03.0766 (UTC) FILETIME=[1B5BC760:01C3A8C1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am attempting to get a CompactFlash reader to work (Soyo SB-K7VXBP).  The 
device sits in a 3.5" bay and plugs directly into a USB1 connector on my 
motherboard.  It also provides two USB ports, which work.

The CompactFlash reader almost works.  At bootup, I get this message:

hub 3-0:1.0: new USB device on port 1, assigned address 2
scsi0 : SCSI emulation for USB Mass Storage devices
  Vendor: SOYO      Model: USB Storage-SMC   Rev: 0214
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2

The device shows up in /sys/block/sda and in 
/sys/bus/usb/drivers/usb-storage.  Also, /dev/sda is created as a symlink to 
/dev/scsi/host0/bus0/target0/lun0/disc (I am using devfs).

However, when try to mount /dev/sda, I get an error saying "No medium 
found".  I have tried inserting the card after booting and also before 
booting, with the same result.  I am using the 2.6.0-test9 kernel, but I 
have had this device since early 2.4 and it has never worked.  It is not 
damaged hardware because Windows detects it as a drive.

Trying to run fdisk on /dev/sda gives the message "Unable to open /dev/sda". 
  Is there something else I need to do, or any more information I can 
provide to debug this problem?

Thanks,
Jim

_________________________________________________________________
Is your computer infected with a virus?  Find out with a FREE computer virus 
scan from McAfee.  Take the FreeScan now! 
http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963

