Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263039AbTCEUzV>; Wed, 5 Mar 2003 15:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbTCEUzV>; Wed, 5 Mar 2003 15:55:21 -0500
Received: from b101247.adsl.hansenet.de ([62.109.101.247]:41600 "EHLO
	coruscant.datenknoten.de") by vger.kernel.org with ESMTP
	id <S263039AbTCEUzT>; Wed, 5 Mar 2003 15:55:19 -0500
Subject: ieee1394: sbp2: sbp2util_allocate_request_packet
From: Sebastian Zimmermann <sebastian@expires1203.datenknoten.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046898487.3493.24.camel@coruscant.datenknoten.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 05 Mar 2003 22:08:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a problem using an external firewire harddrive. When writing to
the disk (badblocks -w) I get an error message about every minute:

kernel: ieee1394: sbp2: sbp2util_allocate_request_packet - no packets
available!
kernel: ieee1394: sbp2: sbp2util_allocate_write_request_packet failed
kernel: ieee1394: sbp2: aborting sbp2 command
kernel: Write (10) 00 09 51 b4 4a 00 00 fe 00

This by itself is - except for small pauses once and then - no problem.
But when writing much data (dd for 40 GB), it gets worse after some
time:

(log continued)
kernel: ieee1394: sbp2: aborting sbp2 command
kernel: Read (10) 00 08 b3 f2 5a 00 00 fe 00
kernel: ieee1394: sbp2: aborting sbp2 command
kernel: Test Unit Ready 00 00 00 00 00
kernel: ieee1394: sbp2: reset requested
kernel: ieee1394: sbp2: Generating sbp2 fetch agent reset
kernel: ieee1394: sbp2: aborting sbp2 command
kernel: Test Unit Ready 00 00 00 00 00
kernel: ieee1394: sbp2: reset requested
kernel: ieee1394: sbp2: Generating sbp2 fetch agent reset
kernel: ieee1394: sbp2: aborting sbp2 command
kernel: Test Unit Ready 00 00 00 00 00
kernel: scsi: device set offline - not ready or command retry failed
after bus reset: host 0 channel 0 id 0 lun 0
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 50000
kernel:  I/O error: dev 08:02, sector 67838424
kernel:  I/O error: dev 08:02, sector 67838426
[...]

I am using kernel.org's 2.4.20 kernel.

Thanks for your help!

Sebastian
