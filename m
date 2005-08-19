Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932594AbVHSLp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932594AbVHSLp3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 07:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932639AbVHSLp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 07:45:29 -0400
Received: from [202.125.80.34] ([202.125.80.34]:29237 "EHLO mail.esn.co.in")
	by vger.kernel.org with ESMTP id S932594AbVHSLp3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 07:45:29 -0400
Content-class: urn:content-classes:message
Subject: RE: The Linux FAT issue on SD Cards.. maintainer support please
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Fri, 19 Aug 2005 17:09:06 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Message-ID: <3AEC1E10243A314391FE9C01CD65429B391B@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: The Linux FAT issue on SD Cards.. maintainer support please
Thread-Index: AcWkGTYhA/29mEB/RCiTQ1ztHJ88VQAlkgfw
From: "Mukund JB`." <mukundjb@esntechnologies.co.in>
To: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Cc: <hirofumi@mail.parknet.co.jp>,
       "linux-kernel-Mailing-list" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Lennart,

>> I found that both of then do NOT have the partition table.
>
>If you don't use fdisk to create a partition on the card, then you
won't
>have one.  

I am having the partition table on the cam formatted CARD 
i.e. the partition 0.

> If you mkdosfs on /dev/tfa0 then you loose the partition
>table and get a filesystem on just the whole disk.  If you do it with
>/dev/tfa0p1 then you do it on the first partition which would then have
>the FAT filesystem starting at the offset of the first partition (as it
>should).

Ok, I understood it. It looks like we have to verify the partition
support we have implemented in the driver.

>That is right.  Although I believe if windows sees one with a partition
>table it will just use the first valid partition table entry it finds
>and ignore the rest.

To handle it in a similarly in Linux we need to support this driver with
partitions. There looks a loop hole in the driver. 
I will verify and fix it today.

>> Please see the Images-All-MS-512.tar.gz.
>
>Well to mount anything without a partition table, you would mount the
>whole device (/dev/tfa0) and to mount one with a partition table on it,
>you would mount /dev/tfa0p1 or tfa0p4 or whichever partition it is.
>
>Zip drives used to be the same way.  Some were formated with 1
partition
>(usually 1 or 4) and some had no partition table at all and used the
>whole disk for the filesystem.  I always had a /zip and /zip4 mount
>point I used depending on the particular disk I was looking at.
Just out of inquisitive ness.

What r u the minor numbers of those zip devices.
ll /dev/zip 
ll /dev/zip4

Thanks for ur support.
I will check with partition support in the driver & update it.
Let me fix it there and come back.

Regards,
Mukund Jampala

