Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129479AbRBAOW1>; Thu, 1 Feb 2001 09:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129648AbRBAOWH>; Thu, 1 Feb 2001 09:22:07 -0500
Received: from web6103.mail.yahoo.com ([128.11.22.97]:19978 "HELO
	web6103.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129479AbRBAOWE>; Thu, 1 Feb 2001 09:22:04 -0500
Message-ID: <20010201142203.3714.qmail@web6103.mail.yahoo.com>
Date: Thu, 1 Feb 2001 06:22:03 -0800 (PST)
From: Hunt Kent <kenthunt@yahoo.com>
Subject: [BUG] 2.4.[0-1] ide-scsi unrecoverable error
To: lk <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got an internal ide zip 250 driver using the
ide-scsi driver. The disk probably got worn out and
now when I read a particular sector of the disk or
do /sbin/e2fsck -c I get an infinite loop of with
console message

scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x03 00
00 00 40 00
Info fld=0x3af9e, Current sd08:05: sns = f0  3
ASC=11 ASCQ= 0
Raw sense data:0xf0 0x00 0x03 0x00 0x03 0xaf 0x9e 0x12
0x00 0x00 0x00 0x00
0x11 0x00 0x00 0x00 0x00 0x00 0x0a 0x99 0x01 0x01 0x14
0x64 0x30 0x5a
 I/O error: dev 08:05, sector 241418

The kernel keeps trying, e2fsck is not in the process
table and the driver does not eject the disk so the
only remedy is to reboot the box. I'll keep the
defected media if a patch is provided to test against
this problem.

__________________________________________________
Get personalized email addresses from Yahoo! Mail - only $35 
a year!  http://personal.mail.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
