Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269134AbTBZXVj>; Wed, 26 Feb 2003 18:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269137AbTBZXVj>; Wed, 26 Feb 2003 18:21:39 -0500
Received: from franka.aracnet.com ([216.99.193.44]:62118 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S269134AbTBZXVi>; Wed, 26 Feb 2003 18:21:38 -0500
Date: Wed, 26 Feb 2003 15:31:52 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 413] New: usb-storage gets lots of "transport error" and "bulk
 reset requested" when mounting CF card 
Message-ID: <7670000.1046302312@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=413

           Summary: usb-storage gets lots of "transport error" and "bulk
                    reset requested" when mounting CF card
    Kernel Version: 2.5.63
            Status: NEW
          Severity: normal
             Owner: greg@kroah.com
         Submitter: MurrayR@brain.org


Distribution: Mandrake Cooker
Hardware Environment: ASUS P4S533 (SiS645DX chipset), SanDisk SDDR-77
Software Environment:
Problem Description:

When mounting a CF card I get this in /var/log/syslog:

Feb 26 18:08:58 Master kernel: usb-storage: *** thread awakened.
Feb 26 18:08:58 Master kernel: usb-storage: Command MODE_SENSE (6 bytes)
Feb 26 18:08:58 Master kernel: usb-storage:  1a 08 08 00 04 00
Feb 26 18:08:58 Master kernel: usb-storage: Bulk command S 0x43425355 T
0x14 Trg 0 LUN 0 L 4 F 128 C       
L 6
Feb 26 18:08:58 Master kernel: usb-storage: usb_stor_bulk_transfer_buf():
xfer 31 bytes
Feb 26 18:08:58 Master kernel: usb-storage: Status code 0; transferred 31/31
Feb 26 18:08:58 Master kernel: usb-storage: -- transfer complete
Feb 26 18:08:58 Master kernel: usb-storage: Bulk command transfer result=0
Feb 26 18:08:58 Master kernel: usb-storage: usb_stor_bulk_transfer_buf():
xfer 4 bytes
Feb 26 18:08:58 Master kernel: usb 1-3: urb f6445600 usb-00:02.2-3 ep-1-IN
cc 8 --> status -75
Feb 26 18:08:58 Master kernel: usb-storage: Status code -75; transferred 4/4
Feb 26 18:08:58 Master kernel: usb-storage: -- unknown error
Feb 26 18:08:58 Master kernel: usb-storage: Bulk data transfer result 0x3
Feb 26 18:08:58 Master kernel: usb-storage: -- transport indicates error,
resetting Feb 26 18:08:58 Master kernel: usb-storage: Bulk reset requested
Feb 26 18:09:04 Master kernel: usb-storage: Soft reset: clearing bulk-in
endpoint halt
Feb 26 18:09:04 Master kernel: usb-storage: Soft reset: clearing bulk-out
endpoint halt
Feb 26 18:09:04 Master kernel: usb-storage: Soft reset done
Feb 26 18:09:04 Master kernel: usb-storage: scsi cmd done, result=0x70000
Feb 26 18:09:04 Master kernel: usb-storage: *** thread sleeping.
Feb 26 18:09:04 Master kernel: usb-storage: queuecommand() called

It repeats several (as in 20 or more) times. Eventually the card mounts
after about 2 minutes. Once the card is mounted no more errors appear.
unmounting the card and reinserting it does the same thing. unmounting and
mounting again WITHOUT reinserting does not.
I rebuilt kernels all the way back to 2.5.56 - in 2.5.56 it did NOT do it,
all from .58 onwards do.

Steps to reproduce:
Insert a card into cardreader. Mount.


