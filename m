Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264707AbSIQWsU>; Tue, 17 Sep 2002 18:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264689AbSIQWrj>; Tue, 17 Sep 2002 18:47:39 -0400
Received: from pcow057o.blueyonder.co.uk ([195.188.53.94]:47378 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S264675AbSIQWqY>;
	Tue, 17 Sep 2002 18:46:24 -0400
Subject: Re: Problems accessing USB Mass Storage
From: Mark C <gen-lists@blueyonder.co.uk>
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb-users <linux-usb-users@lists.sourceforge.net>
In-Reply-To: <20020917152102.A17561@eng2.beaverton.ibm.com>
References: <1032261937.1170.13.camel@stimpy.angelnet.internal>
	<20020917151816.GB2144@kroah.com> <3D876861.9000601@cypress.com>
	<20020917174631.GD2569@kroah.com> <20020917234302.A26741@bitwizard.nl>
	<3D87A6E3.5090407@cypress.com> 
	<20020917152102.A17561@eng2.beaverton.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-7) 
Date: 17 Sep 2002 23:51:15 +0100
Message-Id: <1032303080.1141.5.camel@stimpy.angelnet.internal>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-17 at 23:21, Patrick Mansfield wrote:

> You should be able to run the equivalent:
> 
> 	dd if=/dev/sda of=/dev/zero bs=512 count=8

I done that and please find the output below:

usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command START_STOP (6 bytes)
usb-storage: 1b 00 00 00 01 00 74 c1 00 00 00 00
usb-storage: Bulk command S 0x43425355 T 0x20 Trg 0 LUN 0 L 0 F 0 CL 6
usb-storage: Bulk command transfer result=0
usb-storage: Attempting to get CSW...
usb-storage: clearing endpoint halt for pipe 0xc0038280
usb-storage: usb_stor_clear_halt: result=0
usb-storage: Attempting to get CSW (2nd try)...
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x20 R 0 Stat 0x1
usb-storage: -- transport indicates command failure
usb-storage: Issuing auto-REQUEST_SENSE
usb-storage: Bulk command S 0x43425355 T 0x20 Trg 0 LUN 0 L 18 F 128 CL
6
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_transfer_partial(): xfer 18 bytes
usb-storage: usb_stor_bulk_msg() returned 0 xferred 18/18
usb-storage: usb_stor_transfer_partial(): transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x20 R 0 Stat 0x0
usb-storage: -- Result from auto-sense is 0
usb-storage: -- code: 0x70, key: 0x5, ASC: 0x24, ASCQ: 0x0
usb-storage: Illegal Request: invalid field in CDB
usb-storage: scsi cmd done, result=0x2
usb-storage: *** thread sleeping.
SCSI device (ioctl) reports ILLEGAL REQUEST.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command TEST_UNIT_READY (6 bytes)
usb-storage: 00 00 00 00 00 00 00 00 00 00 e9 df
usb-storage: Bulk command S 0x43425355 T 0x21 Trg 0 LUN 0 L 0 F 0 CL 6
usb-storage: Bulk command transfer result=0
usb-storage: Attempting to get CSW...
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x21 R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command READ_CAPACITY (10 bytes)
usb-storage: 25 00 00 00 00 00 00 00 00 00 e9 df
usb-storage: Bulk command S 0x43425355 T 0x22 Trg 0 LUN 0 L 8 F 128 CL
10
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_transfer_partial(): xfer 8 bytes
usb-storage: usb_stor_bulk_msg() returned 0 xferred 8/8
usb-storage: usb_stor_transfer_partial(): transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x22 R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
SCSI device sda: 16384 512-byte hdwr sectors (8 MB)
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command MODE_SENSE (6 bytes)
usb-storage: 1a 00 3f 00 ff 00 00 00 00 00 e9 df
usb-storage: Bulk command S 0x43425355 T 0x23 Trg 0 LUN 0 L 255 F 128 CL
6
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_transfer_partial(): xfer 255 bytes
usb-storage: usb_stor_bulk_msg() returned -32 xferred 0/255
usb-storage: clearing endpoint halt for pipe 0xc0038280
usb-storage: usb_stor_clear_halt: result=0
usb-storage: usb_stor_transfer_partial(): unknown error
usb-storage: Bulk data transfer result 0x2
usb-storage: Attempting to get CSW...
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x23 R 255 Stat 0x1
usb-storage: -- transport indicates command failure
usb-storage: Issuing auto-REQUEST_SENSE
usb-storage: Bulk command S 0x43425355 T 0x23 Trg 0 LUN 0 L 18 F 128 CL
6
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_transfer_partial(): xfer 18 bytes
usb-storage: usb_stor_bulk_msg() returned 0 xferred 18/18
usb-storage: usb_stor_transfer_partial(): transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x23 R 0 Stat 0x0
usb-storage: -- Result from auto-sense is 0
usb-storage: -- code: 0x70, key: 0x5, ASC: 0x24, ASCQ: 0x0
usb-storage: Illegal Request: invalid field in CDB
usb-storage: scsi cmd done, result=0x2
usb-storage: *** thread sleeping.
sda: test WP failed, assume Write Enabled
 sda: I/O error: dev 08:00, sector 0
 I/O error: dev 08:00, sector 0
 unable to read partition table
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command ALLOW_MEDIUM_REMOVAL (6 bytes)
usb-storage: 1e 00 00 00 01 00 d7 d4 b7 1e 14 c0
usb-storage: Bulk command S 0x43425355 T 0x24 Trg 0 LUN 0 L 0 F 0 CL 6
usb-storage: Bulk command transfer result=0
usb-storage: Attempting to get CSW...
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x24 R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
 I/O error: dev 08:00, sector 0
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command ALLOW_MEDIUM_REMOVAL (6 bytes)
usb-storage: 1e 00 00 00 00 00 12 c0 30 33 67 d5
usb-storage: Bulk command S 0x43425355 T 0x25 Trg 0 LUN 0 L 0 F 0 CL 6
usb-storage: Bulk command transfer result=0
usb-storage: Attempting to get CSW...
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x25 R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.

Thanks

Mark

-- 
---
To steal ideas from one person is plagiarism;
to steal from many is research.

