Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264844AbRFUFfU>; Thu, 21 Jun 2001 01:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264846AbRFUFfL>; Thu, 21 Jun 2001 01:35:11 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:12783 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S264844AbRFUFex>; Thu, 21 Jun 2001 01:34:53 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200106210534.f5L5YdhF001060@webber.adilger.int>
Subject: Re: harddisk support
In-Reply-To: <CA256A72.001BA0E4.00@d73mta01.au.ibm.com> "from mdaljeet@in.ibm.com
 at Jun 21, 2001 10:22:13 am"
To: mdaljeet@in.ibm.com
Date: Wed, 20 Jun 2001 23:34:39 -0600 (MDT)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daljeet writes:
> In the '/dev' tree, the device file entries for SCSI harddisks ranges from
> '/dev/sda' to '/dev/sdp'. If I attach 17 scsi harddisks to a system, the
> 17th harddisk is shown  as '/dev/sdq' in '/proc/partitions' but there is no
> entry in the '/dev' tree. If I try to access '/dev/sdq' either through
> fdisk or through   any other simple C programs, it gives error saying, can
> not open device '/dev/sdq'.
> 
> How can I access more than 16 harddisks?

Use the MAKEDEV script to make the extra /dev/sd* entries.  Like:

cd /dev; MAKEDEV sdq sdr sds sdt sdu sdv sdw sdx sdy sdz sdaa ...

You can make up to 128 SCSI disks, all the way to /dev/sddx.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
