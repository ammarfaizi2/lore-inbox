Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261480AbTCORlG>; Sat, 15 Mar 2003 12:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261481AbTCORlG>; Sat, 15 Mar 2003 12:41:06 -0500
Received: from f52.law8.hotmail.com ([216.33.241.52]:27146 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S261480AbTCORlF>;
	Sat, 15 Mar 2003 12:41:05 -0500
X-Originating-IP: [67.86.246.131]
From: "sean darcy" <seandarcy@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.64-bk9 --  vfat32  fails
Date: Sat, 15 Mar 2003 12:51:50 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F52RDT6Z3LstPGtPrPr000001a9@hotmail.com>
X-OriginalArrivalTime: 15 Mar 2003 17:51:50.0984 (UTC) FILETIME=[8EA86480:01C2EB1B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting this error on a large vfat partition:

lsattr /win/photo/scanner.test
lsattr: Inappropriate ioctl for device While reading flags on 
/win/photo/scanner.test/frame4-atTableSep02.psd
lsattr: Inappropriate ioctl for device While reading flags on 
/win/photo/scanner.test/frame2-atTableSep02.psd

I found this because I couldn't create a soft link (ln -s ) on the 
partition. FWIW, ls -l does not show a problem.

vfat is compiled in 2.5.64-bk9. The fstab is

/dev/hdb8               /win/photo              vfat    defaults        0 0


df shows:

/dev/hdb8             32748528   3617488  29131040  12% /win/photo

sfdisk shows:

/dev/hdb8       1769+   5847    4079-  32764536    c  Win95 FAT32 (LBA)

There's nothing in /var/log/messages.

No problem with my other partitions - ext2 and ext3.

sean

_________________________________________________________________
STOP MORE SPAM with the new MSN 8 and get 2 months FREE*  
http://join.msn.com/?page=features/junkmail

