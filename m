Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263460AbTKFIb3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 03:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263463AbTKFIb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 03:31:29 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:8864 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id S263460AbTKFIax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 03:30:53 -0500
Message-ID: <3FAA04A6.60503@t-online.de>
Date: Thu, 06 Nov 2003 09:21:58 +0100
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031011
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: usb-storage broken for 2.6.0-test*
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Seen: false
X-ID: VgAoyBZawePmDx1qLnGToXkTCIgK8DQzPPLDOGHjwET+Zx6Ke5tHQS@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

Somewhere usb-storage is broken for all kernels of the 2.6.0-test* 
series --- I tried test1, test2, and test9.
I really believe that this should be fixed for 2.6.0-final.

Hardware: Epia 5000, Sharkoon 128MB USB drive.

The SuSE 2.4.20 kernel works perfectly fine, I´m able to partition, 
mount, read and write the drive with 2.4.20. Also
write protect is recognized correctly.

An USB Scanner works fine with both 2.4.20 and 2.6.0-test* kernels.

=======================================================
All kernel modules are loaded at boot time. Now I connect the usb drive:
=======================================================
Nov  6 08:23:46 linux kernel: hub 1-0:1.0: port 2, status 101, change 1, 
12 Mb/s
Nov  6 08:23:46 linux kernel: hub 1-0:1.0: debounce: port 2: delay 100ms 
stable 4 status 0x101
Nov  6 08:23:46 linux kernel: hub 1-0:1.0: new USB device on port 2, 
assigned address 3
Nov  6 08:23:46 linux kernel: usb 1-2: new device strings: Mfr=0, 
Product=1, SerialNumber=0
Nov  6 08:23:46 linux kernel: drivers/usb/core/message.c: USB device 
number 3 default language ID 0x409
Nov  6 08:23:46 linux kernel: usb 1-2: Product: USB Mass Storage Device
Nov  6 08:23:46 linux kernel: drivers/usb/core/usb.c: usb_hotplug
Nov  6 08:23:46 linux kernel: usb 1-2: registering 1-2:1.0 (config #1, 
interface 0)
Nov  6 08:23:46 linux kernel: drivers/usb/core/usb.c: usb_hotplug
Nov  6 08:23:46 linux kernel: usb-storage 1-2:1.0: usb_probe_interface
Nov  6 08:23:46 linux kernel: usb-storage 1-2:1.0: usb_probe_interface - 
got id
Nov  6 08:23:46 linux kernel: usb-storage: USB Mass Storage device detected
Nov  6 08:23:46 linux kernel: usb-storage: act_altsetting is 0, id_index 
is 78
Nov  6 08:23:46 linux kernel: usb-storage: -- associate_dev
Nov  6 08:23:46 linux kernel: usb-storage: Transport: Bulk
Nov  6 08:23:46 linux kernel: usb-storage: Protocol: Transparent SCSI
Nov  6 08:23:46 linux kernel: usb-storage: Endpoints: In: 0xe89b0220 
Out: 0xe89b0234 Int: 0x00000000 (Period 0)
Nov  6 08:23:46 linux kernel: usb-storage: usb_stor_control_msg: rq=fe 
rqtype=a1 value=0000 index=00 len=1
Nov  6 08:23:46 linux /sbin/hotplug[1632]: no runnable 
/etc/hotplug/scsi_host.agent is installed
Nov  6 08:23:46 linux kernel: usb-storage: GetMaxLUN command result is 
1, data is 0
Nov  6 08:23:46 linux kernel: usb-storage: *** thread sleeping.
Nov  6 08:23:46 linux kernel: scsi0 : SCSI emulation for USB Mass 
Storage devices
Nov  6 08:23:46 linux kernel: usb-storage: queuecommand called
Nov  6 08:23:46 linux kernel: usb-storage: *** thread awakened.
Nov  6 08:23:46 linux kernel: usb-storage: Command INQUIRY (6 bytes)
Nov  6 08:23:46 linux kernel: usb-storage:  12 00 00 00 24 00
Nov  6 08:23:46 linux kernel: usb-storage: Bulk Command S 0x43425355 T 
0x1 L 36 F 128 Trg 0 LUN 0 CL 6
Nov  6 08:23:46 linux kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Nov  6 08:23:46 linux kernel: usb-storage: Status code 0; transferred 31/31
Nov  6 08:23:46 linux kernel: usb-storage: -- transfer complete
Nov  6 08:23:46 linux kernel: usb-storage: Bulk command transfer result=0
Nov  6 08:23:46 linux kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 36 bytes
Nov  6 08:23:46 linux kernel: usb-storage: Status code 0; transferred 36/36
Nov  6 08:23:46 linux kernel: usb-storage: -- transfer complete
Nov  6 08:23:46 linux kernel: usb-storage: Bulk data transfer result 0x0
Nov  6 08:23:46 linux kernel: usb-storage: Attempting to get CSW...
Nov  6 08:23:46 linux kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Nov  6 08:23:46 linux kernel: usb-storage: Status code 0; transferred 13/13
Nov  6 08:23:46 linux kernel: usb-storage: -- transfer complete
Nov  6 08:23:46 linux /sbin/hotplug[1640]: no runnable 
/etc/hotplug/scsi.agent is installed
Nov  6 08:23:46 linux kernel: usb-storage: Bulk status result = 0
Nov  6 08:23:46 linux kernel: usb-storage: Bulk Status S 0x53425355 T 
0x1 R 0 Stat 0x0
Nov  6 08:23:46 linux kernel: usb-storage: scsi cmd done, result=0x0
Nov  6 08:23:46 linux kernel: usb-storage: *** thread sleeping.
Nov  6 08:23:46 linux kernel:   Vendor: SHARKOON  Model: USB 
DRIVE         Rev: 1.1
Nov  6 08:23:46 linux kernel:   Type:   
Direct-Access                      ANSI SCSI revision: 02
Nov  6 08:23:46 linux kernel: usb-storage: queuecommand called
Nov  6 08:23:46 linux kernel: usb-storage: *** thread awakened.
Nov  6 08:23:46 linux kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Nov  6 08:23:46 linux kernel: usb-storage:  00 00 00 00 00 00
Nov  6 08:23:46 linux kernel: usb-storage: Bulk Command S 0x43425355 T 
0x2 L 0 F 0 Trg 0 LUN 0 CL 6
Nov  6 08:23:46 linux kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Nov  6 08:23:46 linux kernel: usb-storage: Status code 0; transferred 31/31
Nov  6 08:23:46 linux kernel: usb-storage: -- transfer complete
Nov  6 08:23:46 linux kernel: usb-storage: Bulk command transfer result=0
Nov  6 08:23:46 linux kernel: usb-storage: Attempting to get CSW...
Nov  6 08:23:46 linux kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Nov  6 08:23:46 linux kernel: usb-storage: Status code 0; transferred 13/13
Nov  6 08:23:46 linux kernel: usb-storage: -- transfer complete
Nov  6 08:23:46 linux kernel: usb-storage: Bulk status result = 0
Nov  6 08:23:46 linux kernel: usb-storage: Bulk Status S 0x53425355 T 
0x2 R 0 Stat 0x0
Nov  6 08:23:46 linux kernel: usb-storage: scsi cmd done, result=0x0
Nov  6 08:23:46 linux kernel: usb-storage: *** thread sleeping.
Nov  6 08:23:46 linux kernel: usb-storage: queuecommand called
Nov  6 08:23:46 linux kernel: usb-storage: *** thread awakened.
Nov  6 08:23:46 linux kernel: usb-storage: Command READ_CAPACITY (10 bytes)
Nov  6 08:23:46 linux kernel: usb-storage:  25 00 00 00 00 00 00 00 00 00
Nov  6 08:23:46 linux kernel: usb-storage: Bulk Command S 0x43425355 T 
0x3 L 8 F 128 Trg 0 LUN 0 CL 10
Nov  6 08:23:46 linux kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Nov  6 08:23:46 linux kernel: usb-storage: Status code 0; transferred 31/31
Nov  6 08:23:46 linux kernel: usb-storage: -- transfer complete
Nov  6 08:23:46 linux kernel: usb-storage: Bulk command transfer result=0
Nov  6 08:23:46 linux kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 8 bytes
Nov  6 08:23:47 linux kernel: usb-storage: Status code 0; transferred 8/8
Nov  6 08:23:47 linux kernel: usb-storage: -- transfer complete
Nov  6 08:23:47 linux kernel: usb-storage: Bulk data transfer result 0x0
Nov  6 08:23:47 linux kernel: usb-storage: Attempting to get CSW...
Nov  6 08:23:47 linux kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Nov  6 08:23:47 linux kernel: usb-storage: Status code 0; transferred 13/13
Nov  6 08:23:47 linux kernel: usb-storage: -- transfer complete
Nov  6 08:23:47 linux kernel: usb-storage: Bulk status result = 0
Nov  6 08:23:47 linux kernel: usb-storage: Bulk Status S 0x53425355 T 
0x3 R 0 Stat 0x0
Nov  6 08:23:47 linux kernel: usb-storage: scsi cmd done, result=0x0
Nov  6 08:23:47 linux kernel: usb-storage: *** thread sleeping.
Nov  6 08:23:47 linux kernel: SCSI device sda: 256000 512-byte hdwr 
sectors (131 MB)
Nov  6 08:23:47 linux kernel: usb-storage: queuecommand called
Nov  6 08:23:47 linux kernel: usb-storage: *** thread awakened.
Nov  6 08:23:47 linux kernel: usb-storage: Command MODE_SENSE_10 (10 bytes)
Nov  6 08:23:47 linux kernel: usb-storage:  5a 00 3f 00 00 00 00 00 08 00
Nov  6 08:23:47 linux kernel: usb-storage: Bulk Command S 0x43425355 T 
0x4 L 8 F 128 Trg 0 LUN 0 CL 10
Nov  6 08:23:47 linux kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Nov  6 08:23:47 linux kernel: usb-storage: Status code 0; transferred 31/31
Nov  6 08:23:47 linux kernel: usb-storage: -- transfer complete
Nov  6 08:23:47 linux kernel: usb-storage: Bulk command transfer result=0
Nov  6 08:23:47 linux kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 8 bytes
Nov  6 08:23:47 linux kernel: usb-storage: Status code 0; transferred 8/8
Nov  6 08:23:47 linux kernel: usb-storage: -- transfer complete
Nov  6 08:23:47 linux kernel: usb-storage: Bulk data transfer result 0x0
Nov  6 08:23:47 linux kernel: usb-storage: Attempting to get CSW...
Nov  6 08:23:47 linux kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Nov  6 08:23:47 linux kernel: usb-storage: Status code 0; transferred 13/13
Nov  6 08:23:47 linux kernel: usb-storage: -- transfer complete
Nov  6 08:23:47 linux kernel: usb-storage: Bulk status result = 0
Nov  6 08:23:47 linux kernel: usb-storage: Bulk Status S 0x53425355 T 
0x4 R 8 Stat 0x1
Nov  6 08:23:47 linux kernel: usb-storage: -- transport indicates 
command failure
Nov  6 08:23:47 linux kernel: usb-storage: Issuing auto-REQUEST_SENSE
Nov  6 08:23:47 linux kernel: usb-storage: Bulk Command S 0x43425355 T 
0x80000004 L 18 F 128 Trg 0 LUN 0 CL 6
Nov  6 08:23:47 linux kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Nov  6 08:23:47 linux kernel: usb-storage: Status code 0; transferred 31/31
Nov  6 08:23:47 linux kernel: usb-storage: -- transfer complete
Nov  6 08:23:47 linux kernel: usb-storage: Bulk command transfer result=0
Nov  6 08:23:47 linux kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 18 bytes
Nov  6 08:23:47 linux kernel: usb-storage: Status code 0; transferred 18/18
Nov  6 08:23:47 linux kernel: usb-storage: -- transfer complete
Nov  6 08:23:47 linux kernel: usb-storage: Bulk data transfer result 0x0
Nov  6 08:23:47 linux kernel: usb-storage: Attempting to get CSW...
Nov  6 08:23:47 linux kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Nov  6 08:23:47 linux kernel: usb-storage: Status code 0; transferred 13/13
Nov  6 08:23:47 linux kernel: usb-storage: -- transfer complete
Nov  6 08:23:47 linux kernel: usb-storage: Bulk status result = 0
Nov  6 08:23:47 linux kernel: usb-storage: Bulk Status S 0x53425355 T 
0x80000004 R 0 Stat 0x0
Nov  6 08:23:47 linux kernel: usb-storage: -- Result from auto-sense is 0
Nov  6 08:23:47 linux kernel: usb-storage: -- code: 0x70, key: 0x5, ASC: 
0x20, ASCQ: 0x0
Nov  6 08:23:47 linux kernel: usb-storage: Illegal Request: Invalid 
command operation code
Nov  6 08:23:47 linux kernel: usb-storage: scsi cmd done, result=0x2
Nov  6 08:23:47 linux kernel: usb-storage: *** thread sleeping.
Nov  6 08:23:47 linux kernel: usb-storage: queuecommand called
Nov  6 08:23:47 linux kernel: usb-storage: *** thread awakened.
Nov  6 08:23:47 linux kernel: usb-storage: Command MODE_SENSE_10 (10 bytes)
Nov  6 08:23:47 linux kernel: usb-storage:  5a 00 00 00 00 00 00 00 08 00
Nov  6 08:23:47 linux kernel: usb-storage: Bulk Command S 0x43425355 T 
0x5 L 8 F 128 Trg 0 LUN 0 CL 10
Nov  6 08:23:47 linux kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Nov  6 08:23:47 linux kernel: usb-storage: Status code 0; transferred 31/31
Nov  6 08:23:47 linux kernel: usb-storage: -- transfer complete
Nov  6 08:23:47 linux kernel: usb-storage: Bulk command transfer result=0
Nov  6 08:23:47 linux kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 8 bytes
Nov  6 08:23:47 linux kernel: usb-storage: Status code 0; transferred 8/8
Nov  6 08:23:47 linux kernel: usb-storage: -- transfer complete
Nov  6 08:23:47 linux kernel: usb-storage: Bulk data transfer result 0x0
Nov  6 08:23:47 linux kernel: usb-storage: Attempting to get CSW...
Nov  6 08:23:47 linux kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Nov  6 08:23:47 linux kernel: usb-storage: Status code 0; transferred 13/13
Nov  6 08:23:47 linux kernel: usb-storage: -- transfer complete
Nov  6 08:23:47 linux kernel: usb-storage: Bulk status result = 0
Nov  6 08:23:47 linux kernel: usb-storage: Bulk Status S 0x53425355 T 
0x5 R 8 Stat 0x1
Nov  6 08:23:47 linux kernel: usb-storage: -- transport indicates 
command failure
Nov  6 08:23:47 linux kernel: usb-storage: Issuing auto-REQUEST_SENSE
Nov  6 08:23:47 linux kernel: usb-storage: Bulk Command S 0x43425355 T 
0x80000005 L 18 F 128 Trg 0 LUN 0 CL 6
Nov  6 08:23:47 linux kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Nov  6 08:23:47 linux kernel: usb-storage: Status code 0; transferred 31/31
Nov  6 08:23:47 linux kernel: usb-storage: -- transfer complete
Nov  6 08:23:47 linux kernel: usb-storage: Bulk command transfer result=0
Nov  6 08:23:47 linux kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 18 bytes
Nov  6 08:23:47 linux kernel: usb-storage: Status code 0; transferred 18/18
Nov  6 08:23:47 linux kernel: usb-storage: -- transfer complete
Nov  6 08:23:47 linux kernel: usb-storage: Bulk data transfer result 0x0
Nov  6 08:23:47 linux kernel: usb-storage: Attempting to get CSW...
Nov  6 08:23:47 linux kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Nov  6 08:23:47 linux kernel: usb-storage: Status code 0; transferred 13/13
Nov  6 08:23:47 linux kernel: usb-storage: -- transfer complete
Nov  6 08:23:47 linux kernel: usb-storage: Bulk status result = 0
Nov  6 08:23:47 linux kernel: usb-storage: Bulk Status S 0x53425355 T 
0x80000005 R 0 Stat 0x0
Nov  6 08:23:47 linux kernel: usb-storage: -- Result from auto-sense is 0
Nov  6 08:23:47 linux kernel: usb-storage: -- code: 0x70, key: 0x5, ASC: 
0x20, ASCQ: 0x0
Nov  6 08:23:47 linux kernel: usb-storage: Illegal Request: Invalid 
command operation code
Nov  6 08:23:47 linux kernel: usb-storage: scsi cmd done, result=0x2
Nov  6 08:23:47 linux kernel: usb-storage: *** thread sleeping.
Nov  6 08:23:47 linux kernel: usb-storage: queuecommand called
Nov  6 08:23:47 linux kernel: usb-storage: *** thread awakened.
Nov  6 08:23:47 linux kernel: usb-storage: Command MODE_SENSE_10 (10 bytes)
Nov  6 08:23:47 linux kernel: usb-storage:  5a 00 3f 00 00 00 00 00 ff 00
Nov  6 08:23:47 linux kernel: usb-storage: Bulk Command S 0x43425355 T 
0x6 L 255 F 128 Trg 0 LUN 0 CL 10
Nov  6 08:23:47 linux kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Nov  6 08:23:47 linux kernel: usb-storage: Status code 0; transferred 31/31
Nov  6 08:23:47 linux kernel: usb-storage: -- transfer complete
Nov  6 08:23:47 linux kernel: usb-storage: Bulk command transfer result=0
Nov  6 08:23:47 linux kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 255 bytes
Nov  6 08:23:47 linux kernel: usb-storage: Status code 0; transferred 39/255
Nov  6 08:23:47 linux kernel: usb-storage: -- short transfer
Nov  6 08:23:47 linux kernel: usb-storage: Bulk data transfer result 0x1
Nov  6 08:23:47 linux kernel: usb-storage: Attempting to get CSW...
Nov  6 08:23:47 linux kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Nov  6 08:23:47 linux kernel: usb-storage: Status code 0; transferred 13/13
Nov  6 08:23:47 linux kernel: usb-storage: -- transfer complete
Nov  6 08:23:47 linux kernel: usb-storage: Bulk status result = 0
Nov  6 08:23:47 linux kernel: usb-storage: Bulk Status S 0x53425355 T 
0x6 R 255 Stat 0x1
Nov  6 08:23:47 linux kernel: usb-storage: -- transport indicates 
command failure
Nov  6 08:23:47 linux kernel: usb-storage: Issuing auto-REQUEST_SENSE
Nov  6 08:23:47 linux kernel: usb-storage: Bulk Command S 0x43425355 T 
0x80000006 L 18 F 128 Trg 0 LUN 0 CL 6
Nov  6 08:23:47 linux kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Nov  6 08:23:47 linux kernel: usb-storage: Status code 0; transferred 31/31
Nov  6 08:23:47 linux kernel: usb-storage: -- transfer complete
Nov  6 08:23:47 linux kernel: usb-storage: Bulk command transfer result=0
Nov  6 08:23:47 linux kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 18 bytes
Nov  6 08:23:47 linux kernel: usb-storage: Status code 0; transferred 18/18
Nov  6 08:23:47 linux kernel: usb-storage: -- transfer complete
Nov  6 08:23:47 linux /sbin/hotplug[1654]: no runnable 
/etc/hotplug/block.agent is installed
Nov  6 08:23:47 linux kernel: usb-storage: Bulk data transfer result 0x0
Nov  6 08:23:47 linux kernel: usb-storage: Attempting to get CSW...
Nov  6 08:23:47 linux kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Nov  6 08:23:47 linux kernel: usb-storage: Status code 0; transferred 13/13
Nov  6 08:23:47 linux kernel: usb-storage: -- transfer complete
Nov  6 08:23:47 linux kernel: usb-storage: Bulk status result = 0
Nov  6 08:23:47 linux kernel: usb-storage: Bulk Status S 0x53425355 T 
0x80000006 R 0 Stat 0x0
Nov  6 08:23:47 linux kernel: usb-storage: -- Result from auto-sense is 0
Nov  6 08:23:47 linux kernel: usb-storage: -- code: 0x70, key: 0x5, ASC: 
0x20, ASCQ: 0x0
Nov  6 08:23:47 linux kernel: usb-storage: Illegal Request: Invalid 
command operation code
Nov  6 08:23:47 linux kernel: usb-storage: scsi cmd done, result=0x2
Nov  6 08:23:47 linux kernel: usb-storage: *** thread sleeping.


BTW: test WP works for 2.4.20!

Nov  6 08:23:47 linux kernel: sda: test WP failed, assume Write Enabled
Nov  6 08:23:47 linux kernel: sda: assuming drive cache: write through
Nov  6 08:23:47 linux kernel: usb-storage: queuecommand called
Nov  6 08:23:47 linux kernel: usb-storage: *** thread awakened.
Nov  6 08:23:47 linux kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Nov  6 08:23:47 linux kernel: usb-storage:  00 00 00 00 00 00
Nov  6 08:23:47 linux kernel: usb-storage: Bulk Command S 0x43425355 T 
0x7 L 0 F 0 Trg 0 LUN 0 CL 6
Nov  6 08:23:47 linux kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Nov  6 08:23:47 linux kernel: usb-storage: Status code 0; transferred 31/31
Nov  6 08:23:47 linux kernel: usb-storage: -- transfer complete
Nov  6 08:23:47 linux kernel: usb-storage: Bulk command transfer result=0
Nov  6 08:23:47 linux kernel: usb-storage: Attempting to get CSW...
Nov  6 08:23:47 linux /sbin/hotplug[1661]: no runnable 
/etc/hotplug/scsi_device.agent is installed
Nov  6 08:23:47 linux kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Nov  6 08:23:47 linux kernel: usb-storage: Status code 0; transferred 13/13
Nov  6 08:23:47 linux kernel: usb-storage: -- transfer complete
Nov  6 08:23:47 linux kernel: usb-storage: Bulk status result = 0
Nov  6 08:23:47 linux kernel: usb-storage: Bulk Status S 0x53425355 T 
0x7 R 0 Stat 0x0
Nov  6 08:23:47 linux kernel: usb-storage: scsi cmd done, result=0x0
Nov  6 08:23:47 linux kernel: usb-storage: *** thread sleeping.
Nov  6 08:23:47 linux kernel: usb-storage: queuecommand called
Nov  6 08:23:47 linux kernel: usb-storage: *** thread awakened.
Nov  6 08:23:47 linux kernel: usb-storage: Command ALLOW_MEDIUM_REMOVAL 
(6 bytes)
Nov  6 08:23:47 linux kernel: usb-storage:  1e 00 00 00 01 00
Nov  6 08:23:47 linux kernel: usb-storage: Bulk Command S 0x43425355 T 
0x8 L 0 F 0 Trg 0 LUN 0 CL 6
Nov  6 08:23:47 linux kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Nov  6 08:23:47 linux kernel: usb-storage: Status code 0; transferred 31/31
Nov  6 08:23:47 linux kernel: usb-storage: -- transfer complete
Nov  6 08:23:47 linux kernel: usb-storage: Bulk command transfer result=0
Nov  6 08:23:47 linux kernel: usb-storage: Attempting to get CSW...
Nov  6 08:23:47 linux kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Nov  6 08:23:47 linux kernel: usb-storage: Status code 0; transferred 13/13
Nov  6 08:23:47 linux kernel: usb-storage: -- transfer complete
Nov  6 08:23:47 linux kernel: usb-storage: Bulk status result = 0
Nov  6 08:23:47 linux kernel: usb-storage: Bulk Status S 0x53425355 T 
0x8 R 0 Stat 0x1
Nov  6 08:23:47 linux kernel: usb-storage: -- transport indicates 
command failure
Nov  6 08:23:47 linux kernel: usb-storage: Issuing auto-REQUEST_SENSE
Nov  6 08:23:47 linux kernel: usb-storage: Bulk Command S 0x43425355 T 
0x80000008 L 18 F 128 Trg 0 LUN 0 CL 6
Nov  6 08:23:47 linux kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Nov  6 08:23:47 linux kernel: usb-storage: Status code 0; transferred 31/31
Nov  6 08:23:47 linux kernel: usb-storage: -- transfer complete
Nov  6 08:23:47 linux kernel: usb-storage: Bulk command transfer result=0
Nov  6 08:23:47 linux kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 18 bytes
Nov  6 08:23:47 linux kernel: usb-storage: Status code 0; transferred 18/18
Nov  6 08:23:47 linux kernel: usb-storage: -- transfer complete
Nov  6 08:23:47 linux kernel: usb-storage: Bulk data transfer result 0x0
Nov  6 08:23:47 linux kernel: usb-storage: Attempting to get CSW...
Nov  6 08:23:47 linux kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Nov  6 08:23:47 linux kernel: usb-storage: Status code 0; transferred 13/13
Nov  6 08:23:47 linux kernel: usb-storage: -- transfer complete
Nov  6 08:23:47 linux kernel: usb-storage: Bulk status result = 0
Nov  6 08:23:47 linux kernel: usb-storage: Bulk Status S 0x53425355 T 
0x80000008 R 0 Stat 0x0
Nov  6 08:23:47 linux kernel: usb-storage: -- Result from auto-sense is 0
Nov  6 08:23:47 linux kernel: usb-storage: -- code: 0x70, key: 0x5, ASC: 
0x24, ASCQ: 0x0
Nov  6 08:23:47 linux kernel: usb-storage: Illegal Request: Invalid 
field in cdb
Nov  6 08:23:47 linux kernel: usb-storage: scsi cmd done, result=0x2
Nov  6 08:23:47 linux kernel: usb-storage: *** thread sleeping.
Nov  6 08:23:47 linux kernel:  sda:<7>usb-storage: queuecommand called
Nov  6 08:23:47 linux kernel: usb-storage: *** thread awakened.
Nov  6 08:23:47 linux kernel: usb-storage: Command READ_10 (10 bytes)
Nov  6 08:23:47 linux kernel: usb-storage:  28 00 00 00 00 00 00 00 08 00
Nov  6 08:23:47 linux kernel: usb-storage: Bulk Command S 0x43425355 T 
0x9 L 4096 F 128 Trg 0 LUN 0 CL 10
Nov  6 08:23:47 linux kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Nov  6 08:23:47 linux kernel: usb-storage: Status code 0; transferred 31/31
Nov  6 08:23:47 linux kernel: usb-storage: -- transfer complete
Nov  6 08:23:47 linux kernel: usb-storage: Bulk command transfer result=0
Nov  6 08:23:47 linux kernel: usb-storage: 
usb_stor_bulk_transfer_sglist: xfer 4096 bytes, 1 entries
Nov  6 08:23:47 linux kernel: usb-storage: Status code 0; transferred 
4096/4096
Nov  6 08:23:47 linux kernel: usb-storage: -- transfer complete
Nov  6 08:23:47 linux kernel: usb-storage: Bulk data transfer result 0x0
Nov  6 08:23:47 linux kernel: usb-storage: Attempting to get CSW...
Nov  6 08:23:47 linux kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Nov  6 08:23:47 linux kernel: usb-storage: Status code 0; transferred 13/13
Nov  6 08:23:47 linux kernel: usb-storage: -- transfer complete
Nov  6 08:23:47 linux kernel: usb-storage: Bulk status result = 0
Nov  6 08:23:47 linux kernel: usb-storage: Bulk Status S 0x53425355 T 
0x9 R 0 Stat 0x0
Nov  6 08:23:47 linux kernel: usb-storage: scsi cmd done, result=0x0
Nov  6 08:23:47 linux kernel: usb-storage: *** thread sleeping.
Nov  6 08:23:47 linux kernel:  sda1
Nov  6 08:23:47 linux kernel: Attached scsi removable disk sda at scsi0, 
channel 0, id 0, lun 0
Nov  6 08:23:47 linux kernel: usb-storage: queuecommand called
Nov  6 08:23:47 linux kernel: usb-storage: *** thread awakened.
Nov  6 08:23:47 linux kernel: usb-storage: Bad target number (1:0)
Nov  6 08:23:47 linux kernel: usb-storage: scsi cmd done, result=0x40000
Nov  6 08:23:47 linux kernel: usb-storage: *** thread sleeping.
Nov  6 08:23:47 linux kernel: usb-storage: queuecommand called
Nov  6 08:23:47 linux kernel: usb-storage: *** thread awakened.
Nov  6 08:23:47 linux kernel: usb-storage: Bad target number (2:0)
Nov  6 08:23:47 linux kernel: usb-storage: scsi cmd done, result=0x40000
Nov  6 08:23:47 linux kernel: usb-storage: *** thread sleeping.
Nov  6 08:23:47 linux kernel: usb-storage: queuecommand called
Nov  6 08:23:47 linux kernel: usb-storage: *** thread awakened.
Nov  6 08:23:47 linux kernel: usb-storage: Bad target number (3:0)
Nov  6 08:23:47 linux kernel: usb-storage: scsi cmd done, result=0x40000
Nov  6 08:23:47 linux kernel: usb-storage: *** thread sleeping.
Nov  6 08:23:47 linux kernel: usb-storage: queuecommand called
Nov  6 08:23:47 linux kernel: usb-storage: *** thread awakened.
Nov  6 08:23:47 linux kernel: usb-storage: Bad target number (4:0)
Nov  6 08:23:47 linux kernel: usb-storage: scsi cmd done, result=0x40000
Nov  6 08:23:47 linux kernel: usb-storage: *** thread sleeping.
Nov  6 08:23:47 linux kernel: usb-storage: queuecommand called
Nov  6 08:23:47 linux kernel: usb-storage: *** thread awakened.
Nov  6 08:23:47 linux kernel: usb-storage: Bad target number (5:0)
Nov  6 08:23:47 linux kernel: usb-storage: scsi cmd done, result=0x40000
Nov  6 08:23:47 linux kernel: usb-storage: *** thread sleeping.
Nov  6 08:23:47 linux kernel: usb-storage: queuecommand called
Nov  6 08:23:47 linux kernel: usb-storage: *** thread awakened.
Nov  6 08:23:47 linux kernel: usb-storage: Bad target number (6:0)
Nov  6 08:23:47 linux kernel: usb-storage: scsi cmd done, result=0x40000
Nov  6 08:23:47 linux kernel: usb-storage: *** thread sleeping.
Nov  6 08:23:47 linux kernel: usb-storage: queuecommand called
Nov  6 08:23:47 linux kernel: usb-storage: *** thread awakened.
Nov  6 08:23:47 linux kernel: usb-storage: Bad target number (7:0)
Nov  6 08:23:47 linux kernel: usb-storage: scsi cmd done, result=0x40000
Nov  6 08:23:47 linux kernel: usb-storage: *** thread sleeping.
Nov  6 08:23:47 linux kernel: WARNING: USB Mass Storage data integrity 
not assured
Nov  6 08:23:47 linux kernel: USB Mass Storage device found at 3
Nov  6 08:23:47 linux /sbin/hotplug[1647]: no runnable 
/etc/hotplug/block.agent is installed
Nov  6 08:23:49 linux /etc/hotplug/usb.agent[1668]: Setting up USB 
devices switched of. Exiting usb.agent ...
Nov  6 08:23:52 linux /etc/hotplug/usb.agent[1676]: Setting up USB 
devices switched of. Exiting usb.agent ...

========================
Now I try to mount /dev/sda1:
========================

Nov  6 08:25:00 linux kernel: usb-storage: queuecommand called
Nov  6 08:25:00 linux kernel: usb-storage: *** thread awakened.
Nov  6 08:25:00 linux kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Nov  6 08:25:00 linux kernel: usb-storage:  00 00 00 00 00 00
Nov  6 08:25:00 linux kernel: usb-storage: Bulk Command S 0x43425355 T 
0x11 L 0 F 0 Trg 0 LUN 0 CL 6
Nov  6 08:25:00 linux kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Nov  6 08:25:00 linux kernel: usb-storage: Status code 0; transferred 31/31
Nov  6 08:25:00 linux kernel: usb-storage: -- transfer complete
Nov  6 08:25:00 linux kernel: usb-storage: Bulk command transfer result=0
Nov  6 08:25:00 linux kernel: usb-storage: Attempting to get CSW...
Nov  6 08:25:00 linux kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Nov  6 08:25:00 linux kernel: usb-storage: Status code 0; transferred 13/13
Nov  6 08:25:00 linux kernel: usb-storage: -- transfer complete
Nov  6 08:25:00 linux kernel: usb-storage: Bulk status result = 0
Nov  6 08:25:00 linux kernel: usb-storage: Bulk Status S 0x53425355 T 
0x11 R 0 Stat 0x0
Nov  6 08:25:00 linux kernel: usb-storage: scsi cmd done, result=0x0
Nov  6 08:25:00 linux kernel: usb-storage: *** thread sleeping.
Nov  6 08:25:00 linux kernel: usb-storage: queuecommand called
Nov  6 08:25:00 linux kernel: usb-storage: *** thread awakened.
Nov  6 08:25:00 linux kernel: usb-storage: Command READ_10 (10 bytes)
Nov  6 08:25:00 linux kernel: usb-storage:  28 00 00 00 00 20 00 04 00 00
Nov  6 08:25:00 linux kernel: usb-storage: Bulk Command S 0x43425355 T 
0x12 L 524288 F 128 Trg 0 LUN 0 CL 10
Nov  6 08:25:00 linux kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 31 bytes
Nov  6 08:25:00 linux kernel: usb-storage: Status code 0; transferred 31/31
Nov  6 08:25:00 linux kernel: usb-storage: -- transfer complete
Nov  6 08:25:00 linux kernel: usb-storage: Bulk command transfer result=0
Nov  6 08:25:00 linux kernel: usb-storage: 
usb_stor_bulk_transfer_sglist: xfer 524288 bytes, 128 entries
Nov  6 08:25:00 linux kernel: usb-storage: Status code -121; transferred 
114688/524288
Nov  6 08:25:00 linux kernel: usb-storage: -- short read transfer
Nov  6 08:25:00 linux kernel: usb-storage: Bulk data transfer result 0x1
Nov  6 08:25:00 linux kernel: usb-storage: Attempting to get CSW...
Nov  6 08:25:00 linux kernel: usb-storage: usb_stor_bulk_transfer_buf: 
xfer 13 bytes
Nov  6 08:25:30 linux kernel: usb-storage: command_abort called
Nov  6 08:25:30 linux kernel: usb-storage: usb_stor_stop_transport called
Nov  6 08:25:30 linux kernel: usb-storage: -- cancelling URB
Nov  6 08:25:30 linux kernel: usb-storage: Status code -104; transferred 
0/13
Nov  6 08:25:30 linux kernel: usb-storage: -- transfer cancelled
Nov  6 08:25:30 linux kernel: usb-storage: Bulk status result = 4
Nov  6 08:25:30 linux kernel: usb-storage: -- command was aborted
Nov  6 08:25:30 linux kernel: usb-storage: usb_stor_Bulk_reset called
Nov  6 08:25:30 linux kernel: usb-storage: usb_stor_control_msg: rq=ff 
rqtype=21 value=0000 index=00 len=0
Nov  6 08:25:36 linux kernel: usb-storage: Soft reset: clearing bulk-in 
endpoint halt
Nov  6 08:25:36 linux kernel: usb-storage: usb_stor_control_msg: rq=01 
rqtype=02 value=0000 index=81 len=0
Nov  6 08:25:36 linux kernel: usb-storage: usb_stor_clear_halt: result = 0
Nov  6 08:25:36 linux kernel: usb-storage: Soft reset: clearing bulk-out 
endpoint halt
Nov  6 08:25:36 linux kernel: usb-storage: usb_stor_control_msg: rq=01 
rqtype=02 value=0000 index=02 len=0
Nov  6 08:25:36 linux kernel: usb-storage: usb_stor_clear_halt: result = 0
Nov  6 08:25:36 linux kernel: usb-storage: Soft reset done
Nov  6 08:25:36 linux kernel: usb-storage: scsi command aborted
Nov  6 08:25:36 linux kernel: usb-storage: *** thread sleeping.
Nov  6 08:25:36 linux kernel: usb-storage: queuecommand called
.....

This could go one for hours ... top shows 0% idle and 99.x % iowait.


cu,
 Knut


