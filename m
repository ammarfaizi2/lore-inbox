Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264717AbUGSGbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264717AbUGSGbX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 02:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264723AbUGSGbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 02:31:23 -0400
Received: from 24-193-79-141.nyc.rr.com ([24.193.79.141]:5893 "EHLO linux.site")
	by vger.kernel.org with ESMTP id S264717AbUGSGbT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 02:31:19 -0400
From: David Lazanja <lazanja@plasma.ap.columbia.edu>
Organization: Columbia University
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: firewire drive / sbp2 module
Date: Mon, 19 Jul 2004 02:31:19 -0400
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200407190231.19269.lazanja@plasma.ap.columbia.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there,

I've been trying to use a firewire external hard drive under kernel 2.6, but 
I'm not having much success.  I'm using a firewire pcmcia card by Belkin
which seems to be working properly.  The drive worked with this firewire card 
under kernel 2.4.twenty_something.

I compiled 2.6.7 using the configuration from suse's 2.6.5-7.95-default kernel 
but still have no success.  All of the correct modules are loading.

>From the kernel messages (below), it seems that sbp2 is failing.  I was 
looking around on the list and found some others are also having problems
with sbp2.  I'm trying to find out if this is a known general problem under 
2.6 or if it's specific to the drive that I'm using (Buslink 80GB usb2 / 
firewire combo).

I'm using SuSE 9.1 and found on the mailing list there that some claim to have 
success with firewire drives.  I don't know??

One other thing.  I noticed that it takes maybe 20 or 40 seconds sbp2 module
to load.  Once it loads the errors are reported but I can see the attached 
scsi device under /proc/scsi/scsi:

---
Attached devices:
Host: scsi4 Channel: 00 Id: 00 Lun: 00
  Vendor: SAMSUNG  Model: SP0802N          Rev:
  Type:   Direct-Access                    ANSI SCSI revision: 06
---

Below are the kernel messages.

Any information will be greatly appreciated.
Thanks in advance.

--------------------------------
Kernel Messages from syslog:
--------------------------------

Jul 18 23:08:50 linux kernel: sbp2: $Rev: 1219 $ Ben Collins 
<bcollins@debian.org>
Jul 18 23:08:50 linux kernel: scsi0 : SCSI emulation for IEEE-1394 SBP-2 
Devices
Jul 18 23:08:51 linux kernel: ieee1394: sbp2: Logged into SBP-2 device
Jul 18 23:08:51 linux kernel: ieee1394: Node 0-00:1023: Max speed [S400] - Max 
payload [2048]
Jul 18 23:08:51 linux kernel:   Vendor: SAMSUNG   Model: SP0802N           
Rev:
Jul 18 23:08:51 linux kernel:   Type:   Direct-Access                      
ANSI SCSI revision: 06
Jul 18 23:08:51 linux kernel: SCSI device sda: 156368016 512-byte hdwr sectors 
(80060 MB)
Jul 18 23:08:51 linux kernel: sda: asking for cache data failed
Jul 18 23:08:51 linux kernel: sda: assuming drive cache: write through
Jul 18 23:09:21 linux kernel:  sda:<3>ieee1394: sbp2: aborting sbp2 command
Jul 18 23:09:21 linux kernel: Read (10) 00 00 00 00 00 00 00 08 00
Jul 18 23:09:31 linux kernel: ieee1394: sbp2: aborting sbp2 command
Jul 18 23:09:31 linux kernel: Test Unit Ready 00 00 00 00 00
Jul 18 23:09:31 linux kernel: ieee1394: sbp2: reset requested
Jul 18 23:09:31 linux kernel: ieee1394: sbp2: Generating sbp2 fetch agent 
reset
Jul 18 23:09:41 linux kernel: ieee1394: sbp2: aborting sbp2 command
Jul 18 23:09:41 linux kernel: Test Unit Ready 00 00 00 00 00
Jul 18 23:09:41 linux kernel: ieee1394: sbp2: reset requested
Jul 18 23:09:41 linux kernel: ieee1394: sbp2: Generating sbp2 fetch agent 
reset
Jul 18 23:10:01 linux kernel: ieee1394: sbp2: aborting sbp2 command
Jul 18 23:10:01 linux kernel: Test Unit Ready 00 00 00 00 00
Jul 18 23:10:01 linux kernel: ieee1394: sbp2: reset requested
Jul 18 23:10:01 linux kernel: ieee1394: sbp2: Generating sbp2 fetch agent 
reset
Jul 18 23:10:21 linux kernel: ieee1394: sbp2: aborting sbp2 command
Jul 18 23:10:21 linux kernel: Test Unit Ready 00 00 00 00 00
Jul 18 23:10:21 linux kernel: scsi: Device offlined - not ready after error 
recovery: host 0 channel 0 id 0 lun 0
Jul 18 23:10:21 linux kernel: SCSI error : <0 0 0 0> return code = 0x50000
Jul 18 23:10:21 linux kernel: end_request: I/O error, dev sda, sector 0
Jul 18 23:10:21 linux kernel: Buffer I/O error on device sda, logical block 0
Jul 18 23:10:21 linux kernel: scsi0 (0:0): rejecting I/O to offline device
Jul 18 23:10:21 linux kernel: Buffer I/O error on device sda, logical block 0
Jul 18 23:10:21 linux kernel: scsi0 (0:0): rejecting I/O to offline device
Jul 18 23:10:21 linux kernel: Buffer I/O error on device sda, logical block 
19546001
Jul 18 23:10:21 linux kernel: scsi0 (0:0): rejecting I/O to offline device
Jul 18 23:10:21 linux kernel: Buffer I/O error on device sda, logical block 
19546001
Jul 18 23:10:21 linux kernel: scsi0 (0:0): rejecting I/O to offline device
Jul 18 23:10:21 linux kernel: Buffer I/O error on device sda, logical block 0
Jul 18 23:10:21 linux kernel: ldm_validate_partition_table(): Disk read 
failed.
Jul 18 23:10:21 linux kernel:  unsupported disk (sda)
Jul 18 23:10:21 linux kernel: scsi0 (0:0): rejecting I/O to offline device
Jul 18 23:10:21 linux kernel: Buffer I/O error on device sda, logical block 0
Jul 18 23:10:21 linux kernel:  unable to read partition table
Jul 18 23:10:21 linux kernel: Attached scsi disk sda at scsi0, channel 0, id 
0, lun 0
Jul 18 23:10:21 linux kernel: Attached scsi generic sg0 at scsi0, channel 0, 
id 0, lun 0,  type 0

-- 
# Department of Applied Physics and Applied Mathematics
# Columbia University
