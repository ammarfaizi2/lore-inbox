Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130148AbRBCRly>; Sat, 3 Feb 2001 12:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130320AbRBCRlo>; Sat, 3 Feb 2001 12:41:44 -0500
Received: from femail3.rdc1.on.home.com ([24.2.9.90]:49860 "EHLO
	femail3.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S130148AbRBCRld>; Sat, 3 Feb 2001 12:41:33 -0500
Message-ID: <3A7C4291.6029AB7@home.com>
Date: Sat, 03 Feb 2001 12:40:33 -0500
From: John Cavan <johncavan@home.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Odd behaviour on / filesystem and SCSI removable media
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I noticed an odd thing about my / file system:

du -hx reports 74mb used
df -h . reports 236mb used

The same behaviour does not show on other mounted filesystems... I'm not
sure which to believe...

I've seen this with 2.4.1 and 2.4.1-ac1, the filesystem is ReiserFS and
the kernel was compiled with egcs-1.1.2 (egcs-2.91.66).

Also, I've seen some interesting behaviour with an Iomega Jaz drive.
Basically, if I boot without a disk in the drive, the device is listed
as 1gb assumed so that when I insert a 2gb disk in the drive, it gets
messed up, unable to read the partition table. Same behaviour with the
Zip drive, picked up as a default 1gb (no Zip disk I'm aware of is this
large!) and can't deal with a 100 mb disk. Makes disk swapping with
removable media rather clunky since modules need to be removed and
reloaded to detect properly.

John
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
