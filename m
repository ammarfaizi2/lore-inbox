Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132751AbRDDGpZ>; Wed, 4 Apr 2001 02:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132746AbRDDGpO>; Wed, 4 Apr 2001 02:45:14 -0400
Received: from 61-218-105-170.HINET-IP.hinet.net ([61.218.105.170]:29285 "EHLO
	maillog.sis.com.tw") by vger.kernel.org with ESMTP
	id <S132752AbRDDGpD>; Wed, 4 Apr 2001 02:45:03 -0400
Message-ID: <004701c0bcd2$e2f90ae0$d9d113ac@sis.com.tw>
From: "Alex Huang" <alexjoy@sis.com.tw>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: a question about block device driver
Date: Wed, 4 Apr 2001 14:45:49 +0800
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MIMEOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



 Hi
 Thank you very much for your help.
 In the linux kernel version 2.4.X,
 Does anybody mount a hard drive with MSDOS type file system ??

When I mount this hard drive using the command :
    mount -t msdos /dev/hda1 /mnt/hd -o blocksize=1024
 After mounting a hard disk, I read a file , and the system occours errors.
 After I check the msdos file system in "usr/src/linux/fs/fat/cvf.c"

 Iin the codes,
 struct cvf_format bigblock_cvf={
     :
     :
     :
    default_fat_bmap,
    NULL,
    default_fat_file_write,
     :
     :
 }


 I check the data struct , the NULL field is defined a file_read callback
 function. So , when I read a file , will cause the system error.

 In the kernel version 2.2.17, I can mount a MSDOS filesystem with the
option
 "-o blocksize=1024", and the driver can read/write two pages at the same
 time. But in the kernel version 2.4.X, it doesn't work.

  how two read/write two or more pages(blocks) at the same time in
 the kernel version 2.4.X ??

 Thanks



