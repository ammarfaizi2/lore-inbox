Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbTHBMNO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 08:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbTHBMNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 08:13:14 -0400
Received: from port-212-202-27-44.reverse.qsc.de ([212.202.27.44]:15904 "EHLO
	camelot.fbunet.de") by vger.kernel.org with ESMTP id S261874AbTHBMNM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 08:13:12 -0400
From: Fridtjof Busse <fbusse@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.22-pre10
Date: Sat, 2 Aug 2003 14:13:11 +0200
Cc: marcelo@conectiva.com.br
X-OS: Linux on i686
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308021413.11130@fbunet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello,
> 
> Here goes -pre10, hopefully the last -pre of 2.4.22. 
> 
> It contains a bunch of important fixes, detailed below.
> 
> Please help testing.

Dumping to an USB-harddisk still doesn't work:

kernel: hub.c: new USB device 00:02.2-2, assigned address 4
kernel: scsi1 : SCSI emulation for USB Mass Storage devices
kernel:   Vendor: Maxtor 6  Model: Y120L0            Rev: 0811
kernel:   Type:   Direct-Access                   ANSI SCSI revision: 02
kernel: Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
kernel: SCSI device sda: 240121728 512-byte hdwr sectors (122942 MB)
kernel:  /dev/scsi/host1/bus0/target0/lun0: p1
kernel: WARNING: USB Mass Storage data integrity not assured
kernel: USB Mass Storage device found at 4
kernel: usb_control/bulk_msg: timeout

No start dump:

last message repeated 2 times
kernel: usb.c: USB disconnect on device 00:02.2-2 address 4
kernel: usb-storage: host_reset() requested but not implemented
kernel: scsi: device set offline - command error recover failed: host 1 
channel 0 id 0 lun 0
kernel: 192
kernel:  I/O error: dev 08:01, sector 81655440
lots of I/O errors following

I also reported this to usb-devel, but never got a reply.
Works fine with 2.4.21.
Please CC me, thanks

-- 
Fridtjof Busse
printk("Illegal format on cdrom.  Pester manufacturer.\n"); 
	2.2.16 /usr/src/linux/fs/isofs/inode.c

