Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266162AbUBBUS5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 15:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266157AbUBBUPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 15:15:40 -0500
Received: from web40909.mail.yahoo.com ([66.218.78.206]:44735 "HELO
	web40909.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265956AbUBBUMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 15:12:05 -0500
Message-ID: <20040202201203.9080.qmail@web40909.mail.yahoo.com>
Date: Mon, 2 Feb 2004 12:12:03 -0800 (PST)
From: Bradley Chapman <kakadu_croc@yahoo.com>
Subject: Fwd: Problems with my USB flash disk in 2.6.2-rc3 (appeared in 2.6.1)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I sent this to linux-usb-users@lists.sourceforge.net but have received no
reply, so here goes to the main list:

> Whenever I try to mount my USB flash disk in either 2.6.1 or 2.6.2-rc3, I get an
> error similar to the following:
> 
> hub 1-0:1.0: new USB device on port 2, assigned address 3
> SCSI subsystem initialized
> Initializing USB Mass Storage driver...
> scsi0 : SCSI emulation for USB Mass Storage devices
> Vendor: STF       Model: Flash Drive       Rev: 1.89
> Type:   Direct-Access                      ANSI SCSI revision: 02
> drivers/usb/core/usb.c: registered new driver usb-storage
> USB Mass Storage support registered.
> sda: Unit Not Ready, sense:
> Current : sense = 70  6
> ASC=28 ASCQ= 0
> Raw sense data:0x70 0x00 0x06 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x28
> 0x00
> 0x00 0x00 0x00 0x00
> SCSI device sda: 512000 512-byte hdwr sectors (262 MB)
> sda: assuming Write Enabled
> sda: assuming drive cache: write through
> sda: sda1
> Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
> SCSI error : <0 0 0 0> return code = 0x8000000
> Current sda: sense = 70  0
> Raw sense data:0x70 0x00 0x00 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x00
> 0x00
> 0x00 0x00 0x00 0x00
> end_request: I/O error, dev sda, sector 32
> FAT: unable to read boot sector
> 
> This is what I get in 2.6.2-rc3 with CONFIG_USB_STORAGE_DEBUG=y when I plug in the
> disk, as per Greg KH's suggestion:
> 
> hub 1-0:1.0: new USB device on port 2, assigned address 3
> SCSI subsystem initialized
> Initializing USB Mass Storage driver...
> drivers/usb/core/usb.c: registered new driver usb-storage
> USB Mass Storage support registered.
> usb-storage: USB Mass Storage device detected
> usb-storage: act_altsetting is 0, id_index is 88
> usb-storage: -- associate_dev
> usb-storage: Transport: Bulk
> usb-storage: Protocol: Transparent SCSI
> usb-storage: Endpoints: In: 0xd6d362cc Out: 0xd6d362e0 Int: 0xd6d362f4 (Period
> 255)
> usb-storage: usb_stor_control_msg: rq=fe rqtype=a1 value=0000 index=00 len=1
> usb-storage: GetMaxLUN command result is 1, data is 0
> usb-storage: *** thread sleeping.
> scsi0 : SCSI emulation for USB Mass Storage devices
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Command INQUIRY (6 bytes)
> usb-storage:  12 00 00 00 24 00
> usb-storage: Bulk Command S 0x43425355 T 0x1 L 36 F 128 Trg 0 LUN 0 CL 6
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=0
> usb-storage: usb_stor_bulk_transfer_buf: xfer 36 bytes
> usb-storage: Status code 0; transferred 36/36
> usb-storage: -- transfer complete
> usb-storage: Bulk data transfer result 0x0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> usb-storage: Status code 0; transferred 13/13
> usb-storage: -- transfer complete
> usb-storage: Bulk status result = 0
> usb-storage: Bulk Status S 0x53425355 T 0x1 R 0 Stat 0x0
> usb-storage: scsi cmd done, result=0x0
> usb-storage: *** thread sleeping.
>   Vendor: STF       Model: Flash Drive       Rev: 1.89
>   Type:   Direct-Access                      ANSI SCSI revision: 02
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Bad target number (1:0)
> usb-storage: scsi cmd done, result=0x40000
> usb-storage: *** thread sleeping.
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Bad target number (2:0)
> usb-storage: scsi cmd done, result=0x40000
> usb-storage: *** thread sleeping.
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Bad target number (3:0)
> usb-storage: scsi cmd done, result=0x40000
> usb-storage: *** thread sleeping.
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Bad target number (4:0)
> usb-storage: scsi cmd done, result=0x40000
> usb-storage: *** thread sleeping.
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Bad target number (5:0)
> usb-storage: scsi cmd done, result=0x40000
> usb-storage: *** thread sleeping.
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Bad target number (6:0)
> usb-storage: scsi cmd done, result=0x40000
> usb-storage: *** thread sleeping.
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Bad target number (7:0)
> usb-storage: scsi cmd done, result=0x40000
> usb-storage: *** thread sleeping.
> WARNING: USB Mass Storage data integrity not assured
> USB Mass Storage device found at 3
> updfstab: numerical sysctl 1 23 is obsolete.
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Command TEST_UNIT_READY (6 bytes)
> usb-storage:  00 00 00 00 00 00
> usb-storage: Bulk Command S 0x43425355 T 0x9 L 0 F 0 Trg 0 LUN 0 CL 6
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> request_module: failed /sbin/modprobe -- block-major-2-0. error = 256
> usb-storage: Status code 0; transferred 13/13
> usb-storage: -- transfer complete
> usb-storage: Bulk status result = 0
> usb-storage: Bulk Status S 0x53425355 T 0x9 R 0 Stat 0x1
> usb-storage: -- transport indicates command failure
> usb-storage: Issuing auto-REQUEST_SENSE
> usb-storage: Bulk Command S 0x43425355 T 0x80000009 L 18 F 128 Trg 0 LUN 0 CL 6
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=0
> usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
> usb-storage: Status code 0; transferred 18/18
> usb-storage: -- transfer complete
> usb-storage: Bulk data transfer result 0x0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> usb-storage: Status code 0; transferred 13/13
> usb-storage: -- transfer complete
> usb-storage: Bulk status result = 0
> usb-storage: Bulk Status S 0x53425355 T 0x80000009 R 0 Stat 0x0
> usb-storage: -- Result from auto-sense is 0
> usb-storage: -- code: 0x70, key: 0x6, ASC: 0x28, ASCQ: 0x0
> usb-storage: (Unknown Key): (unknown ASC/ASCQ)
> usb-storage: scsi cmd done, result=0x2
> usb-storage: *** thread sleeping.
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Command TEST_UNIT_READY (6 bytes)
> usb-storage:  00 00 00 00 00 00
> usb-storage: Bulk Command S 0x43425355 T 0xa L 0 F 0 Trg 0 LUN 0 CL 6
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> usb-storage: Status code 0; transferred 13/13
> usb-storage: -- transfer complete
> usb-storage: Bulk status result = 0
> usb-storage: Bulk Status S 0x53425355 T 0xa R 0 Stat 0x1
> usb-storage: -- transport indicates command failure
> usb-storage: Issuing auto-REQUEST_SENSE
> usb-storage: Bulk Command S 0x43425355 T 0x8000000a L 18 F 128 Trg 0 LUN 0 CL 6
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=0
> usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
> usb-storage: Status code 0; transferred 18/18
> usb-storage: -- transfer complete
> usb-storage: Bulk data transfer result 0x0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> usb-storage: Status code 0; transferred 13/13
> usb-storage: -- transfer complete
> usb-storage: Bulk status result = 0
> usb-storage: Bulk Status S 0x53425355 T 0x8000000a R 0 Stat 0x0
> usb-storage: -- Result from auto-sense is 0
> usb-storage: -- code: 0x70, key: 0x6, ASC: 0x28, ASCQ: 0x0
> usb-storage: (Unknown Key): (unknown ASC/ASCQ)
> usb-storage: scsi cmd done, result=0x2
> usb-storage: *** thread sleeping.
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Command TEST_UNIT_READY (6 bytes)
> usb-storage:  00 00 00 00 00 00
> usb-storage: Bulk Command S 0x43425355 T 0xb L 0 F 0 Trg 0 LUN 0 CL 6
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> usb-storage: Status code 0; transferred 13/13
> usb-storage: -- transfer complete
> usb-storage: Bulk status result = 0
> usb-storage: Bulk Status S 0x53425355 T 0xb R 0 Stat 0x0
> usb-storage: scsi cmd done, result=0x0
> usb-storage: *** thread sleeping.
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Command READ_CAPACITY (10 bytes)
> usb-storage:  25 00 00 00 00 00 00 00 00 00
> usb-storage: Bulk Command S 0x43425355 T 0xc L 8 F 128 Trg 0 LUN 0 CL 10
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=0
> usb-storage: usb_stor_bulk_transfer_buf: xfer 8 bytes
> usb-storage: Status code 0; transferred 8/8
> usb-storage: -- transfer complete
> usb-storage: Bulk data transfer result 0x0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> usb-storage: Status code 0; transferred 13/13
> usb-storage: -- transfer complete
> usb-storage: Bulk status result = 0
> usb-storage: Bulk Status S 0x53425355 T 0xc R 0 Stat 0x0
> usb-storage: scsi cmd done, result=0x0
> usb-storage: *** thread sleeping.
> SCSI device sda: 512000 512-byte hdwr sectors (262 MB)
> sda: assuming Write Enabled
> sda: assuming drive cache: write through
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Command TEST_UNIT_READY (6 bytes)
> usb-storage:  00 00 00 00 00 00
> usb-storage: Bulk Command S 0x43425355 T 0xd L 0 F 0 Trg 0 LUN 0 CL 6
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> usb-storage: Status code 0; transferred 13/13
> usb-storage: -- transfer complete
> usb-storage: Bulk status result = 0
> usb-storage: Bulk Status S 0x53425355 T 0xd R 0 Stat 0x0
> usb-storage: scsi cmd done, result=0x0
> usb-storage: *** thread sleeping.
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Command ALLOW_MEDIUM_REMOVAL (6 bytes)
> usb-storage:  1e 00 00 00 01 00
> usb-storage: Bulk Command S 0x43425355 T 0xe L 0 F 0 Trg 0 LUN 0 CL 6
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> usb-storage: Status code 0; transferred 13/13
> usb-storage: -- transfer complete
> usb-storage: Bulk status result = 0
> usb-storage: Bulk Status S 0x53425355 T 0xe R 0 Stat 0x1
> usb-storage: -- transport indicates command failure
> usb-storage: Issuing auto-REQUEST_SENSE
> usb-storage: Bulk Command S 0x43425355 T 0x8000000e L 18 F 128 Trg 0 LUN 0 CL 6
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=0
> usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
> usb-storage: Status code 0; transferred 18/18
> usb-storage: -- transfer complete
> usb-storage: Bulk data transfer result 0x0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> usb-storage: Status code 0; transferred 13/13
> usb-storage: -- transfer complete
> usb-storage: Bulk status result = 0
> usb-storage: Bulk Status S 0x53425355 T 0x8000000e R 0 Stat 0x0
> usb-storage: -- Result from auto-sense is 0
> usb-storage: -- code: 0x70, key: 0x5, ASC: 0x24, ASCQ: 0x0
> usb-storage: (Unknown Key): (unknown ASC/ASCQ)
> usb-storage: scsi cmd done, result=0x2
> usb-storage: *** thread sleeping.
>  sda:<7>usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Command READ_10 (10 bytes)
> usb-storage:  28 00 00 00 00 00 00 00 08 00
> usb-storage: Bulk Command S 0x43425355 T 0xf L 4096 F 128 Trg 0 LUN 0 CL 10
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=0
> usb-storage: usb_stor_bulk_transfer_sglist: xfer 4096 bytes, 1 entries
> usb-storage: Status code 0; transferred 4096/4096
> usb-storage: -- transfer complete
> usb-storage: Bulk data transfer result 0x0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> usb-storage: Status code 0; transferred 13/13
> usb-storage: -- transfer complete
> usb-storage: Bulk status result = 0
> usb-storage: Bulk Status S 0x53425355 T 0xf R 0 Stat 0x0
> usb-storage: scsi cmd done, result=0x0
> usb-storage: *** thread sleeping.
>  sda1
> Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
> 
> And this is what I get when I try to mount the flash disk:
> 
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Command TEST_UNIT_READY (6 bytes)
> usb-storage:  00 00 00 00 00 00
> usb-storage: Bulk Command S 0x43425355 T 0x10 L 0 F 0 Trg 0 LUN 0 CL 6
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> usb-storage: Status code 0; transferred 13/13
> usb-storage: -- transfer complete
> usb-storage: Bulk status result = 0
> usb-storage: Bulk Status S 0x53425355 T 0x10 R 0 Stat 0x0
> usb-storage: scsi cmd done, result=0x0
> usb-storage: *** thread sleeping.
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Command READ_10 (10 bytes)
> usb-storage:  28 00 00 00 00 20 00 00 01 00
> usb-storage: Bulk Command S 0x43425355 T 0x11 L 512 F 128 Trg 0 LUN 0 CL 10
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=0
> usb-storage: usb_stor_bulk_transfer_sglist: xfer 512 bytes, 1 entries
> usb-storage: Status code 0; transferred 512/512
> usb-storage: -- transfer complete
> usb-storage: Bulk data transfer result 0x0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> usb-storage: Status code 0; transferred 13/13
> usb-storage: -- transfer complete
> usb-storage: Bulk status result = 0
> usb-storage: Bulk Status S 0x53425355 T 0x11 R 512 Stat 0x0
> usb-storage: -- unexpectedly short transfer
> usb-storage: Issuing auto-REQUEST_SENSE
> usb-storage: Bulk Command S 0x43425355 T 0x80000011 L 18 F 128 Trg 0 LUN 0 CL 6
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=0
> usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
> usb-storage: Status code 0; transferred 18/18
> usb-storage: -- transfer complete
> usb-storage: Bulk data transfer result 0x0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> usb-storage: Status code 0; transferred 13/13
> usb-storage: -- transfer complete
> usb-storage: Bulk status result = 0
> usb-storage: Bulk Status S 0x53425355 T 0x80000011 R 0 Stat 0x0
> usb-storage: -- Result from auto-sense is 0
> usb-storage: -- code: 0x70, key: 0x0, ASC: 0x0, ASCQ: 0x0
> usb-storage: (Unknown Key): (unknown ASC/ASCQ)
> usb-storage: scsi cmd done, result=0x0
> usb-storage: *** thread sleeping.
> SCSI error : <0 0 0 0> return code = 0x8000000
> Current sda: sense = 70  0
> Raw sense data:0x70 0x00 0x00 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x00
> 0x00
> 0x00 0x00 0x00 0x00
> end_request: I/O error, dev sda, sector 32
> FAT: unable to read boot sector
> 
> I do not have these issues with the 2.6.0 kernel; I am able to mount the flash
> disk easily and without any error messages in dmesg. What changes between 2.6.0
> and 2.6.1 could have caused my flash disk to break?
> 
> TIA
> 
> Brad

=====


__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free web site building tool. Try it!
http://webhosting.yahoo.com/ps/sb/
