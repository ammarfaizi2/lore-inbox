Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbVBDMQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVBDMQA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 07:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbVBDMQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 07:16:00 -0500
Received: from ozlabs.org ([203.10.76.45]:655 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261171AbVBDMPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 07:15:50 -0500
Subject: 2.6: USB disk unusable level of data corruption
From: Rusty Russell <rusty@rustcorp.com.au>
To: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>
Content-Type: text/plain
Date: Fri, 04 Feb 2005 23:16:22 +1100
Message-Id: <1107519382.1703.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I recently made the mistake of buying a USB case with a drive in it
and putting my home directory on it.  I have since then had multiple
ext3 and ext2 errors: 2.6.8, 2.6.9, 2.6.10 and 2.6.11-rc3 all exhibit
the problem within an hour of stress (untarring a fresh kernel tree, cp
-al'ing to apply patches repeatedly, my normal workload).  I haven't had
any similar problems on my internal IDE drive.  2.4 succeeded once, and
once had data corruption (although nowhere near as as bad as the 2.6
corruption, and it got much further).

I realize "ub" exists, but it doesn't seem to want to deal with a disk
device.

Is USB/SCSI just terminally broken under 2.6?  I'll be getting a power
supply to test the drive using firewire, which it also supports, to
ensure this isn't a disk issue (although the 2.4 goodness undermines
this theory).

hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
usb 2-1: USB disconnect, address 2
usb 4-3: new high speed USB device using address 2
scsi1 : SCSI emulation for USB Mass Storage devices
  Vendor: HTS72606  Model: 0M9AT00           Rev: MH4O
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
sda: assuming drive cache: write through
 /dev/scsi/host1/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 p9 >
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
USB Mass Storage device found at 2

-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

