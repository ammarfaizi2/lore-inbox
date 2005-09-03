Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751474AbVICQNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbVICQNS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 12:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbVICQNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 12:13:18 -0400
Received: from poros.telenet-ops.be ([195.130.132.44]:26526 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S1751474AbVICQNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 12:13:17 -0400
From: Jan De Luyck <lkml@kcore.org>
Subject: Genesys USB 2.0 enclosures
Date: Sat, 3 Sep 2005 18:12:54 +0200
User-Agent: KMail/1.8.1
Cc: USB development list <linux-usb-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0412151627350.2419-100000@ida.rowland.org> <200503291344.42951.lkml@kcore.org> <42499406.7090406@ipom.com>
In-Reply-To: <42499406.7090406@ipom.com>
MIME-Version: 1.0
To: USB Storage list <usb-storage@lists.one-eyed-alien.net>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_GucGDAQ3L0xmOyg"
Message-Id: <200509031812.54753.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_GucGDAQ3L0xmOyg
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello lists,

(a mail for the archives)

I've posted in the past about problems with these enclosures - increasing the 
delay seems to fix it, albeit temporarily. The further you go in using the 
disk in such an enclosure, the higher the udelay() had to be - atleast that's 
what I'm seeing here (I've got two of these now :/ )

One permanent fix is adding a powered USB-hub in between the drive enclosures 
and the computer. Since I've done that, I've no longer seen any of the 
problems (i've attached the 'fault' log). Weird but true, since the drives 
come with their own powersupply.

Hope this helps anyone in the future running into the same problem.
-- 
"To vacillate or not to vacillate, that is the question ... or is it?"

--Boundary-00=_GucGDAQ3L0xmOyg
Content-Type: text/plain;
  charset="iso-8859-15";
  name="usblog.bad"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="usblog.bad"

usb 4-3: new high speed USB device using ehci_hcd and address 8
scsi5 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 8
usb-storage: waiting for device to settle before scanning
  Vendor: Maxtor 6  Model: Y080P0            Rev: 0811
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sda: 160086528 512-byte hdwr sectors (81964 MB)
sda: assuming drive cache: write through
SCSI device sda: 160086528 512-byte hdwr sectors (81964 MB)
sda: assuming drive cache: write through
 sda: sda1
Attached scsi disk sda at scsi5, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi5, channel 0, id 0, lun 0,  type 0
usb-storage: device scan complete
XFS mounting filesystem sda1
Ending clean XFS mount for filesystem: sda1
XFS mounting filesystem sda1
Ending clean XFS mount for filesystem: sda1
usb 4-3: USB disconnect, address 8
scsi: Device offlined - not ready after error recovery: host 5 channel 0 id 0 lun 0
SCSI error : <5 0 0 0> return code = 0x10000
end_request: I/O error, dev sda, sector 80067680
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
scsi5 (0:0): rejecting I/O to device being removed
SCSI error : <5 0 0 0> return code = 0x10000
end_request: I/O error, dev sda, sector 80067744
scsi5 (0:0): rejecting I/O to device being removed
I/O error in filesystem ("sda1") meta-data dev sda1 block 0x4c5bc21       ("xlog_iodone") error 5 buf count 32768
xfs_force_shutdown(sda1,0x2) called from line 952 of file fs/xfs/xfs_log.c.  Return address = 0xc020af08
Filesystem "sda1": Log I/O Error Detected.  Shutting down filesystem: sda1
Please umount the filesystem, and rectify the problem(s)
I/O error in filesystem ("sda1") meta-data dev sda1 block 0x4c5bca1       ("xlog_iodone") error 5 buf count 32768
xfs_force_shutdown(sda1,0x2) called from line 952 of file fs/xfs/xfs_log.c.  Return address = 0xc020af08
I/O error in filesystem ("sda1") meta-data dev sda1 block 0x4c5bce1       ("xlog_iodone") error 5 buf count 32768
xfs_force_shutdown(sda1,0x2) called from line 952 of file fs/xfs/xfs_log.c.  Return address = 0xc020af08
I/O error in filesystem ("sda1") meta-data dev sda1 block 0x4c5bd21       ("xlog_iodone") error 5 buf count 32768
xfs_force_shutdown(sda1,0x2) called from line 952 of file fs/xfs/xfs_log.c.  Return address = 0xc020af08
I/O error in filesystem ("sda1") meta-data dev sda1 block 0x4c5bd61       ("xlog_iodone") error 5 buf count 32768
xfs_force_shutdown(sda1,0x2) called from line 952 of file fs/xfs/xfs_log.c.  Return address = 0xc020af08
I/O error in filesystem ("sda1") meta-data dev sda1 block 0x4c5bda1       ("xlog_iodone") error 5 buf count 32768
xfs_force_shutdown(sda1,0x2) called from line 952 of file fs/xfs/xfs_log.c.  Return address = 0xc020af08
I/O error in filesystem ("sda1") meta-data dev sda1 block 0x4c5bde1       ("xlog_iodone") error 5 buf count 32768
xfs_force_shutdown(sda1,0x2) called from line 952 of file fs/xfs/xfs_log.c.  Return address = 0xc020af08
I/O error in filesystem ("sda1") meta-data dev sda1 block 0x4c5bc61       ("xlog_iodone") error 5 buf count 32768
xfs_force_shutdown(sda1,0x2) called from line 952 of file fs/xfs/xfs_log.c.  Return address = 0xc020af08
I/O error in filesystem ("sda1") meta-data dev sda1 block 0x68f3968       ("xfs_trans_read_buf") error 5 buf count 8192
xfs_force_shutdown(sda1,0x2) called from line 717 of file fs/xfs/xfs_log.c.  Return address = 0xc020aa34
xfs_force_shutdown(sda1,0x1) called from line 353 of file fs/xfs/xfs_rw.c.  Return address = 0xc02278bd
xfs_force_shutdown(sda1,0x1) called from line 353 of file fs/xfs/xfs_rw.c.  Return address = 0xc02278bd

--Boundary-00=_GucGDAQ3L0xmOyg--
