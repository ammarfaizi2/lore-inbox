Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265135AbTANUGu>; Tue, 14 Jan 2003 15:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265169AbTANUGu>; Tue, 14 Jan 2003 15:06:50 -0500
Received: from stroke.of.genius.brain.org ([206.80.113.1]:20407 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id <S265135AbTANUGs>; Tue, 14 Jan 2003 15:06:48 -0500
Date: Tue, 14 Jan 2003 15:15:33 -0500
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5.58 - USB-storage
Message-ID: <20030114201533.GA1172@Master.Wizards>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ASUS P4S533 (SiS645DX)
P4 2GHz
1G PC2700
SanDisk SDDR-77 ImageMate Dual Card Reader

In 2.5.56 I can read from CF cards, but can't write to them

In 2.5.58:
With scsi & usb-storage built in I get unknown errors in the syslog
and the card won't mount

with scsi & usb-storage as modules the process trying to mount the
CF card hangs until I pull the card out and put it back. syslog shows a
change event and the process trying to do the mount reports no medium found.
In the syslog are these messages:

Jan 14 14:47:35 Master kernel: usb-storage: Unit Attention: Not ready to ready change, medium may have changed
Jan 14 14:47:35 Master kernel: usb-storage: scsi cmd done, result=0x2
Jan 14 14:47:35 Master kernel: usb-storage: *** thread sleeping.
Jan 14 14:47:35 Master kernel: usb-storage: queuecommand() called
Jan 14 14:47:35 Master kernel: usb-storage: *** thread awakened.
Jan 14 14:47:35 Master kernel: usb-storage: Command READ_10 (10 bytes)
Jan 14 14:47:35 Master kernel: usb-storage:  28 00 00 00 00 00 00 00 08 00
Jan 14 14:47:35 Master kernel: usb-storage: Bulk command S 0x43425355 T 0x25 Trg 0 LUN 0 L 4096 F 128 CL 10
Jan 14 14:47:35 Master kernel: usb-storage: usb_stor_bulk_transfer_buf(): xfer 31 bytes
Jan 14 14:47:35 Master kernel: usb-storage: Status code 0; transferred 31/31
Jan 14 14:47:35 Master kernel: usb-storage: -- transfer complete
Jan 14 14:47:35 Master kernel: usb-storage: Bulk command transfer result=0
Jan 14 14:47:35 Master kernel: usb-storage: usb_stor_bulk_transfer_sglist(): xfer 4096 bytes, 1 entries
Jan 14 14:47:35 Master kernel: usb-storage: Status code 0; transferred 4096/4096
Jan 14 14:47:35 Master kernel: usb-storage: -- transfer complete
Jan 14 14:47:35 Master kernel: usb-storage: Bulk data transfer result 0x0
Jan 14 14:47:35 Master kernel: usb-storage: Attempting to get CSW...
Jan 14 14:47:35 Master kernel: usb-storage: usb_stor_bulk_transfer_buf(): xfer 13 bytes
Jan 14 14:47:35 Master kernel: usb-storage: Status code 0; transferred 13/13
Jan 14 14:47:35 Master kernel: usb-storage: -- transfer complete
Jan 14 14:47:35 Master kernel: usb-storage: Bulk status result = 0
Jan 14 14:47:35 Master kernel: usb-storage: Bulk status Sig 0x53425355 T 0x25 R 0 Stat 0x0
Jan 14 14:47:35 Master kernel: usb-storage: scsi cmd done, result=0x0
Jan 14 14:47:35 Master kernel: usb-storage: *** thread sleeping.
Jan 14 14:47:35 Master kernel: end_request: I/O error, dev sda, sector 0
Jan 14 14:47:35 Master kernel: Buffer I/O error on device sd(8,0), logical block 0
Jan 14 14:47:35 Master kernel: Buffer I/O error on device sd(8,0), logical block 0
Jan 14 14:47:35 Master kernel:  unable to read partition table

The same card was readable in 2.5.56 before and after the attempts with 2.5.58

-- 
Murray J. Root

