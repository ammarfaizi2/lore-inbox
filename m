Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263760AbSLQApY>; Mon, 16 Dec 2002 19:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263899AbSLQApY>; Mon, 16 Dec 2002 19:45:24 -0500
Received: from smtp.netcabo.pt ([212.113.174.9]:29943 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id <S263760AbSLQApQ>;
	Mon, 16 Dec 2002 19:45:16 -0500
Subject: USB troubles in 2.5 kernels
From: =?ISO-8859-1?Q?Andr=E9?= Cruz <afafc@rnl.ist.utl.pt>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1040086793.1083.4.camel@giga.netcabo.pt>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 (1.2.0-3) 
Date: 17 Dec 2002 00:59:54 +0000
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 17 Dec 2002 00:50:42.0003 (UTC) FILETIME=[5325D230:01C2A566]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

First of all if I do a make install in a 2.5 kernel without module support it still complains in the end about /lib/modules/2.5.52 not being a directory.
I have to mkdir it and then run make install.

The first problem is with kernel 2.5.50:
I think my CF/SM reader is detected at boot but when I issue a mount
/dev/sdc1 /mnt/ this appears and nothing happens after that:

SCSI device sdc: drive cache: write through
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command READ_CAPACITY (10 bytes)
usb-storage: 25 20 00 00 00 00 00 00 00 00 23 c0
usb-storage: Bulk command S 0x43425355 T 0x44 Trg 0 LUN 1 L 8 F 128 CL
10
usb-storage: usb_stor_bulk_transfer_buf(): xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_buf(): xfer 8 bytes
usb-storage: Status code 0; transferred 8/8
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf(): xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x44 R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
SCSI device sdc: 31361 512-byte hdwr sectors (16 MB)
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command MODE_SENSE (6 bytes)
usb-storage: 1a 20 3f 00 04 00 00 00 00 ee 50 c0
usb-storage: Bulk command S 0x43425355 T 0x45 Trg 0 LUN 1 L 4 F 128 CL 6
usb-storage: usb_stor_bulk_transfer_buf(): xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_buf(): xfer 4 bytes
drivers/usb/host/uhci-hcd.c: uhci_result_common() failed with status
500000
[ef324270] link (2f324212) element (2f325040)
  0: [ef325040] link (00000001) e3 IOC Stalled Babble Length=3 MaxLen=3
DT0 EndPt=2 Dev=3, PID=69(IN) (buf=0050ee00)

drivers/usb/core/hcd.c: giveback urb ef2c7660 status -75 len 4
usb-storage: Status code -75; transferred 4/4
usb-storage: -- unknown error
usb-storage: Bulk data transfer result 0x3
usb-storage: -- transport indicates error, resetting
usb-storage: Bulk reset requested
drivers/usb/core/message.c: usb_control/bulk_msg: timeout
usb 1-2: wait for giveback urb ee34a380
usb-storage: command_abort() called
usb-storage: usb_stor_abort_transport called




dmesg

usb-storage: act_altsetting is 0
usb-storage: id_index calculated to be: 94
usb-storage: Array length appears to be: 96
usb-storage: USB Mass Storage device detected
usb-storage: Endpoints: In: 0xef2c8e34 Out: 0xef2c8e20 Int: 0x00000000
(Period 0)
usb-storage: New GUID 0aec5010aec501000001a003
usb-storage: GetMaxLUN command result is 1, data is 1
usb-storage: Transport: Bulk
usb-storage: Protocol: Transparent SCSI
usb-storage: Allocating usb_ctrlrequest
usb-storage: Allocating URB
usb-storage: Allocating scatter-gather request block
usb-storage: *** thread sleeping.
scsi2 : SCSI emulation for USB Mass Storage devices
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command INQUIRY (6 bytes)
usb-storage: 12 00 00 00 24 00 00 00 87 e4 23 c0
usb-storage: Bulk command S 0x43425355 T 0x11 Trg 0 LUN 0 L 36 F 128 CL
6
usb-storage: usb_stor_bulk_transfer_buf(): xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_buf(): xfer 36 bytes
usb-storage: Status code 0; transferred 36/36
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf(): xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x11 R 0 Stat 0x0
usb-storage: Fixing INQUIRY data to show SCSI rev 2 - was 0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
  Vendor:           Model: USB Storage-SMC   Rev: 0212
  Type:   Direct-Access                      ANSI SCSI revision: 02
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Faking INQUIRY command for EVPD
usb-storage: scsi cmd done, result=0x2
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Faking INQUIRY command for EVPD
usb-storage: scsi cmd done, result=0x2
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command INQUIRY (6 bytes)
usb-storage: 12 20 00 00 24 00 00 00 87 e4 23 c0
usb-storage: Bulk command S 0x43425355 T 0x14 Trg 0 LUN 1 L 36 F 128 CL
6
usb-storage: usb_stor_bulk_transfer_buf(): xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_buf(): xfer 36 bytes
usb-storage: Status code 0; transferred 36/36
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf(): xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x14 R 0 Stat 0x0
usb-storage: Fixing INQUIRY data to show SCSI rev 2 - was 0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
  Vendor:           Model: USB Storage-CFC   Rev: 0212
  Type:   Direct-Access                      ANSI SCSI revision: 02
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Faking INQUIRY command for EVPD
usb-storage: scsi cmd done, result=0x2
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Faking INQUIRY command for EVPD
usb-storage: scsi cmd done, result=0x2
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Bad LUN (0/2)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Bad target number (1/0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Bad target number (2/0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Bad target number (3/0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Bad target number (4/0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Bad target number (5/0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Bad target number (6/0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Bad target number (7/0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command TEST_UNIT_READY (6 bytes)
usb-storage: 00 00 00 00 00 00 00 00 00 00 23 c0
usb-storage: Bulk command S 0x43425355 T 0x1f Trg 0 LUN 0 L 0 F 0 CL 6
usb-storage: usb_stor_bulk_transfer_buf(): xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf(): xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x1f R 0 Stat 0x1
usb-storage: -- transport indicates command failure
usb-storage: Issuing auto-REQUEST_SENSE
usb-storage: Bulk command S 0x43425355 T 0x1f Trg 0 LUN 0 L 18 F 128 CL
6
usb-storage: usb_stor_bulk_transfer_buf(): xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_buf(): xfer 18 bytes
usb-storage: Status code 0; transferred 18/18
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf(): xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x1f R 0 Stat 0x0
usb-storage: -- Result from auto-sense is 0
usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
usb-storage: Not Ready: Medium not present
usb-storage: scsi cmd done, result=0x2
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command MODE_SENSE (6 bytes)
usb-storage: 1a 08 08 00 80 00 00 00 00 00 23 c0
usb-storage: Bulk command S 0x43425355 T 0x20 Trg 0 LUN 0 L 128 F 128 CL
6
usb-storage: usb_stor_bulk_transfer_buf(): xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_buf(): xfer 128 bytes
usb-storage: Status code 0; transferred 8/128
usb-storage: -- transferred only 8 bytes
usb-storage: Bulk data transfer result 0x1
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf(): xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x20 R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
SCSI device sdb: drive cache: write through
Attached scsi removable disk sdb at scsi2, channel 0, id 0, lun 0
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command TEST_UNIT_READY (6 bytes)
usb-storage: 00 20 00 00 00 00 00 00 00 00 23 c0
usb-storage: Bulk command S 0x43425355 T 0x21 Trg 0 LUN 1 L 0 F 0 CL 6
usb-storage: usb_stor_bulk_transfer_buf(): xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf(): xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x21 R 0 Stat 0x1
usb-storage: -- transport indicates command failure
usb-storage: Issuing auto-REQUEST_SENSE
usb-storage: Bulk command S 0x43425355 T 0x21 Trg 0 LUN 1 L 18 F 128 CL
6
usb-storage: usb_stor_bulk_transfer_buf(): xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_buf(): xfer 18 bytes
usb-storage: Status code 0; transferred 18/18
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf(): xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x21 R 0 Stat 0x0
usb-storage: -- Result from auto-sense is 0
usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
usb-storage: Not Ready: Medium not present
usb-storage: scsi cmd done, result=0x2
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command MODE_SENSE (6 bytes)
usb-storage: 1a 28 08 00 80 00 00 00 00 00 23 c0
usb-storage: Bulk command S 0x43425355 T 0x22 Trg 0 LUN 1 L 128 F 128 CL
6
usb-storage: usb_stor_bulk_transfer_buf(): xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_buf(): xfer 128 bytes
usb-storage: Status code 0; transferred 8/128
usb-storage: -- transferred only 8 bytes
usb-storage: Bulk data transfer result 0x1
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf(): xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x22 R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
SCSI device sdc: drive cache: write through
Attached scsi removable disk sdc at scsi2, channel 0, id 0, lun 1
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 3



The second problem started with > 2.5.50
At boot this happens:

usb-storage: act_altsetting is 0
usb-storage: id_index calculated to be: 95
usb-storage: Array length appears to be: 97
usb-storage: USB Mass Storage device detected
usb-storage: Endpoints: In: 0xef283ef4 Out: 0xef283ee0 Int: 0x00000000
(Period 0)
usb-storage: New GUID 0aec5010aec501000001a003
Unable to handle kernel NULL pointer dereference at virtual address
00000002
 printing eip:
c02aaede
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c02aaede>]    Not tainted
EFLAGS: 00010202
eax: 00000001   ebx: 00000020   ecx: ef283ee0   edx: 00000000
esi: 00000000   edi: ef283ef4   ebp: ef280600   esp: efc5bd4c
ds: 0068   es: 0068   ss: 0068
Process khubd (pid: 4, threadinfo=efc5a000 task=c17af240)
Stack: ef280600 00000000 00000174 0001a003 00000000 efb2aa00 ef288560
ef280604
       c174b968 c03d624c c0137541 c174b968 00000000 c174b9b8 00000000
00000246
       c03d624c 000001ff effe83d0 00000000 eeb09ea0 eeb09098 c01623d0
eeb09ea0
Call Trace: [<c0137541>]  [<c01623d0>]  [<c013a38e>]  [<c028ff07>] 
[<c0200c65>]  [<c0200cff>]  [<c0200ed4>]  [<c01fff70>]  [<c029119c>] 
[<c0293546>]  [<c02939be>]  [<c0122265>]  [<c0293a65>]  [<c011e4c0>] 
[<c0293a30>]  [<c0109249>]
Code: 0f b6 46 02 24 0f 88 85 9e 00 00 00 0f b6 46 06 8d 75 30 88


Can anyone help with any of these problems? Also a backport of this
driver to 2.4 would be very good. I can't use 2.5 for production yet.
Can anyone at least tell me which driver has to be backported?

Thanks!

-- 
André Cruz <afafc@rnl.ist.utl.pt>

