Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317788AbSGRB5f>; Wed, 17 Jul 2002 21:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317831AbSGRB5f>; Wed, 17 Jul 2002 21:57:35 -0400
Received: from [210.199.222.3] ([210.199.222.3]:65258 "EHLO mailgw2.atr.co.jp")
	by vger.kernel.org with ESMTP id <S317788AbSGRB5f>;
	Wed, 17 Jul 2002 21:57:35 -0400
Message-ID: <3D362125.3A324489@atr.co.jp>
Date: Thu, 18 Jul 2002 11:00:05 +0900
From: "J. Hart" <jhart@atr.co.jp>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: File Corruption in Kernel 2.4.18
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


     A large directory tree (70652 files, 7.6G) is copied recursively to an
empty destination directory using the following commands :

     mkdir aminet1/
     cp -a aminet aminet1/

     The source and destination directories are then compared using
the following commands:

     diff -r aminet aminet1/aminet > difflist

     A few of the files at the copy destination, typically three or four, will
usually be corrupt while the source files will be correct.  Occasionally the
copy will be done without any corrupt files at the destination.  The
mem=nopentium option appears to have no effect on this.  An overnight test using
the memtest86 utility shows no memory errors.  The corruption in each file
occurs in precise 4096 byte blocks.  An overnight test using the memtest86
utility shows no memory errors.  The corruption in each file occurs in precise
4096 byte blocks.  System logs show no evidence of any trouble, and no kernel
panics, warning messages or crashes are observed.  If there is any other user
activity while the copy is running, the system will frequently lock up requiring
a hard reset and reboot.  This forces a file system check due to the lack of a
clean unmount.  System logs also show no evidence of any trouble after the
lockup, and no kernel panics or other messages have been observed.

     If a tar file is made of the source directory and then extracted, and the
resultant extracted directory compared with the original, similar effects are
observed.

     Are there any kernel boot or build parameters which could be used
to give additional diagnostics ?

motherboard   : ASYS-A7V
Linux version : Slackware 8
Kernel        : 2.4.18
hard disk     : ATA100 IBM-DTLA-307045 45gb
hd controller : Promise Technology, Inc. 20265
cpu           : 900mhz AMD Athlon
