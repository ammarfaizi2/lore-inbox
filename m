Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261741AbSI2Tf0>; Sun, 29 Sep 2002 15:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261752AbSI2Tf0>; Sun, 29 Sep 2002 15:35:26 -0400
Received: from host187.south.iit.edu ([216.47.130.187]:896 "EHLO
	host187.south.iit.edu") by vger.kernel.org with ESMTP
	id <S261741AbSI2Tf0>; Sun, 29 Sep 2002 15:35:26 -0400
Date: Sun, 29 Sep 2002 14:39:43 -0500 (CDT)
From: Stephen Marz <smarz@host187.south.iit.edu>
To: linux-kernel@vger.kernel.org
Subject: USB Mass Storage Conflicts
Message-ID: <Pine.LNX.4.44.0209291434510.1544-100000@host187.south.iit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The same problem that I had from kernel 2.4.18-10 is also happening in 
kernel 2.5.39.  I have mostly narrowed this down to the ehci-hcd module as 
I can unload the module and everything works normally.

My problem occurs when I attach two USB 2.0 mass storage devices (a 120 GB 
hard drive and a 16x IOMEGA CD-RW) to my cardbus USB 2.0 controller.  My 
CD-RW acts very strange and cdrecord is unable to even determine the name 
of the device (through cdrecord -scanbus).

Anyway, after a while, the hard drive will stop responding and a few error 
messages will occur from scsi and ext3:


SCSI disk error : host 0 channel 0 lun 0 return code = 70000
end_request: I/O error, dev 08:00 sector 13638947
Buffer I/O error on device sd(8,2), logical block 1441804

I got the device to once again respond by unplugging the hard drive
and plugging it back in.


Thanks,

Stephen Marz

