Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132785AbRDDLEy>; Wed, 4 Apr 2001 07:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132789AbRDDLEo>; Wed, 4 Apr 2001 07:04:44 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:8973 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132785AbRDDLEd>; Wed, 4 Apr 2001 07:04:33 -0400
Subject: Re: a question about block device driver
To: alexjoy@sis.com.tw (Alex Huang)
Date: Wed, 4 Apr 2001 12:06:16 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <004701c0bcd2$e2f90ae0$d9d113ac@sis.com.tw> from "Alex Huang" at Apr 04, 2001 02:45:49 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14kl7C-0001iI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  Thank you very much for your help.
>  In the linux kernel version 2.4.X,
>  Does anybody mount a hard drive with MSDOS type file system ??

yes

> 
> When I mount this hard drive using the command :
>     mount -t msdos /dev/hda1 /mnt/hd -o blocksize=1024
>  After mounting a hard disk, I read a file , and the system occours errors.
>  After I check the msdos file system in "usr/src/linux/fs/fat/cvf.c"

Block sizes != media block size are broken for FAT in all 2.4 kernels. Use
2.2.19 if you want to get any work done. 

