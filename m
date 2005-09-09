Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965112AbVIIJPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965112AbVIIJPK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 05:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965113AbVIIJPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 05:15:10 -0400
Received: from 7.1.203.62.cust.bluewin.ch ([62.203.1.7]:26926 "EHLO
	kestrel.twibright.com") by vger.kernel.org with ESMTP
	id S965112AbVIIJPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 05:15:08 -0400
Date: Fri, 9 Sep 2005 11:15:02 +0200
From: Karel Kulhavy <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: USB digital camera erroneously says "no medium found"
Message-ID: <20050909091502.GB27699@kestrel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Orientation: Gay
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I have Nikon Coolpix 2000 digital camera which was working well on my
old Linux 2.6.? machine. After moving to a different one while the old
one is not accessible, where the new one has Linux version 2.6.13, I
found it doesn't work anymore. When compact flash is inside the camera,
camera turned on and connected, cat /dev/sda says no media found.  cat
/dev/sdb, /dev/sdc, /dev/sdd say no such file or directory.

If I take the compact flash card out and stick it into "roline 8in1 card
reader", it works perfectly. This reader puts the cards also as SCSI
disks on /dev/sda.../dev/sdd. Attaching the camera with CF inside to
Windows 2000 machine also works perfectly.

dmesg:

usb-storage: waiting for device to settle before scanning
  Vendor: NIKON     Model: DSC E2000         Rev: 1.00
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 507905 512-byte hdwr sectors (260 MB)
sda: Write Protect is off
sda: Mode Sense: 04 00 00 00
sda: assuming drive cache: write through
SCSI device sda: 507905 512-byte hdwr sectors (260 MB)
sda: Write Protect is off
sda: Mode Sense: 04 00 00 00
sda: assuming drive cache: write through
 sda: sda1
Attached scsi removable disk sda at scsi4, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi4, channel 0, id 0, lun 0,  type 0
usb-storage: device scan complete

clock@kestrel:~$ /sbin/lspci | grep USB
0000:00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 01)
0000:00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 01)
0000:00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 01)
0000:00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M)
USB2 EHCI Controller (rev 01)

What should I investigate and send to diagnose the problem?

CL<
