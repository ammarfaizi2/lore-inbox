Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261757AbSIWOaL>; Mon, 23 Sep 2002 10:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261806AbSIWOaL>; Mon, 23 Sep 2002 10:30:11 -0400
Received: from momus.sc.intel.com ([143.183.152.8]:58857 "EHLO
	momus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S261757AbSIWOaI>; Mon, 23 Sep 2002 10:30:08 -0400
Message-ID: <A5974D8E5F98D511BB910002A50A66470580D1F1@hdsmsx103.hd.intel.com>
From: "Cress, Andrew R" <andrew.r.cress@intel.com>
To: "'Alex Davis'" <alex14641@yahoo.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: scsi error.
Date: Mon, 23 Sep 2002 07:35:35 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex,

There is a linux-scsi list that would be more appropriate for your question.
You apparently have a Data Parity Error on your SCSI bus.  Probably your
external SCSI drive has a cable or terminator problem.  You can confirm this
by disconnecting the external SCSI cable to see if the other drives come up
ok.  
You may be missing some termination, either via an external terminator or by
turning on the drive's TERMPWR jumper on the external drive (depending on
the type of disk cabinet you have).  Or, the external SCSI cable may be
faulty (usually bent pins).

Andy Cress

-----Original Message-----
From: Alex Davis [mailto:alex14641@yahoo.com] 
Sent: Sunday, September 22, 2002 6:01 PM
To: linux-kernel@vger.kernel.org
Subject: scsi error.

While booting my system I got the following error while my
IDE drive was being fsck'd:

Sep 22 17:48:52 test kernel: scsi0: PCI error Interrupt at seqaddr = 0x8
Sep 22 17:48:52 test kernel: scsi0: Data Parity Error Detected during
address or write data phase

None of my SCSI drives had been mounted.

I'm running 2.4.19ac4. My hardware: Adaptec 29160 with 3 Maxtor Atlas III
drives
(2 internal and one external). 

The error did not repeat, and I seem to be able to access my SCSI drives
with no problem.
Is this error anything to worry about?

__________________________________________________
Do You Yahoo!?
Yahoo! Finance - Get real-time stock quotes
http://finance.yahoo.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
