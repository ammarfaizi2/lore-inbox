Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbTDZOig (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 10:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbTDZOif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 10:38:35 -0400
Received: from srv01.glis.net ([216.234.108.75]:11227 "HELO srv01.glis.net")
	by vger.kernel.org with SMTP id S261296AbTDZOie convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 10:38:34 -0400
From: "Tom Dietz" <tom@glis.net>
To: <linux-kernel@vger.kernel.org>
Subject: 3ware 7500 RAID problems....
Date: Sat, 26 Apr 2003 09:50:39 -0500
Message-ID: <000001c30c03$38963870$6501a8c0@typhoon>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently upgraded to RedHat 9.0 only to find that my 600GB RAID system no
longer works.  It worked fine with RH 8.0, however once I upgraded, it no
longer came up cleanly and I got lots of error messages during boot.

I contacted RedHat and they said to try a fresh install, which I did-and got
the same thing.   Currently I am running RH 9.0 with the 2.4.20-9 kernel.
I read through the list archives regarding other's problems with 3ware, and
while at first it sounded like the same problems I am having, when I went to
the Western Digital site to download the firmware (as suggested in the
post), I found that it was only for 180GB and 200GB drives.  All my drives
in my RAID array are 120GB.

The western digital firmware upgrade page is here:
http://wdc.custhelp.com/cgi-bin/wdc.cfg/php/enduser/std_adp.php?p_admin=1&p_
faqid=913&p_created=1047068027

The kernel thread I am referring to is here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=104854143005751&w=2

Any ideas?  My system worked fine with RH8 and there have been no hardware
changes.  I checked the ARRAY's integrity with the 3ware tools and it
reported ok.

Here's a snipit of my boot log regarding the 3ware controller (there should
be only one big partition (sda1)

--cut-
VFS: Mounted root (ext2 filesystem).
SCSI subsystem driver Revision: 1.00
3ware Storage Controller device driver for Linux v1.02.00.031.
PCI: Found IRQ 15 for device 02:01.0
scsi0 : Found a 3ware Storage Controller at 0xa000, IRQ: 15, P-chip: 1.3
scsi0 : 3ware Storage Controller
blk: queue c366a614, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: 3ware     Model: 3w-xxxx           Rev: 1.0 
  Type:   Direct-Access                      ANSI SCSI revision: 00
blk: queue c366a814, I/O limit 4095Mb (mask 0xffffffff)
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 1172197760 512-byte hdwr sectors (600165 MB)
 sda: sda1 sda2 sda4
Journalled Block Device driver loaded
3w-xxxx: scsi0: Command failed: status = 0xc1, flags = 0x11, unit #0.
3w-xxxx: scsi0: AEN: ERROR: Drive error: Port #0.
3w-xxxx: scsi0: Reset succeeded.
3w-xxxx: scsi0: Command failed: status = 0xc1, flags = 0x11, unit #0.
scsi: device set offline - not ready or command retry failed after host
reset: host 0 channel 0 id 0 lun 0
3w-xxxx: scsi0: AEN: ERROR: Drive error: Port #0.
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 2
 I/O error: dev 08:01, sector 0
 I/O error: dev 08:01, sector 2
 I/O error: dev 08:01, sector 0
--cut-

I have A LOT of stuff on there I need to get to, if anyone has any advice on
how to get it working again, please let me know.  I did try to go back to
RH8, but it just sat there after I select "no I don't want to initialize
/sda1 and destroy all data).

Thanks.



