Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265474AbTFMSHG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 14:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265475AbTFMSHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 14:07:06 -0400
Received: from fmr02.intel.com ([192.55.52.25]:64213 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S265474AbTFMSHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 14:07:03 -0400
Message-ID: <A5974D8E5F98D511BB910002A50A66470B54CBA3@hdsmsx103.hd.intel.com>
From: "Cress, Andrew R" <andrew.r.cress@intel.com>
To: "'Matthias Andree'" <matthias.andree@gmx.de>,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: RE: SCSI Write Cache Enable in 2.4.20?
Date: Fri, 13 Jun 2003 11:25:43 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


IMO, it isn't "necessary", but it is very desirable, and should be the
default, to disable write cache on SCSI disks for any system that is
concerned about reliability.

If reliability is less important than performance, and you have more
sequential writes than random writes, then you would get a performance
boost, and those (limited) cases might want to turn write cache on.  Disk
benchmark apps are one example.

However, most environments have a lot more small random writes than
sequential writes, and so don't even see a performance improvement from
turning disk write cache on.  

The OS type or version shouldn't affect this, in principle.

Andy

-----Original Message-----
From: Matthias Andree [mailto:matthias.andree@gmx.de] 
Sent: Thursday, June 12, 2003 5:25 AM
To: Linux-Kernel mailing list
Subject: SCSI Write Cache Enable in 2.4.20?


Hi,

I haven't followed the status of write barrier patches recently, I am
wondering if it's still "necessary" (to avoid file system corruption) to
disable the write cache of a SCSI disk drive when the machine doesn't
have an uninterruptible power supply or if instead the file systems and
driver know how to use ordered tags.  (Fujitsu MAP drive: 8 MB cache,
AIC7880 adapter, SuSE Linux 8.2 patched 2.4.20 kernel with ext3 and xfs)

TIA,

-- 
Matthias Andree
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
