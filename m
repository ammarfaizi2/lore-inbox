Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289251AbSANOIm>; Mon, 14 Jan 2002 09:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289246AbSANOIe>; Mon, 14 Jan 2002 09:08:34 -0500
Received: from web14902.mail.yahoo.com ([216.136.225.54]:58763 "HELO
	web14902.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S289244AbSANOIO>; Mon, 14 Jan 2002 09:08:14 -0500
Message-ID: <20020114140754.36133.qmail@web14902.mail.yahoo.com>
Date: Mon, 14 Jan 2002 09:07:53 -0500 (EST)
From: Michael Zhu <mylinuxk@yahoo.ca>
Subject: Recompile the loop device
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, has anyone recompiled the loop device? I had a
problem when trying to load the recompiled loop.o into
the kernel. When I use the insmod to load the loop.o,
the system always return "loop.o: unresolved external
__put_user_bad". What is wrong? I found that the
__put_user_bad() was defined in the <asm/uaccess.h> as
"extern void __put_user_bad(void);". But I couldn't
found the source code of this function. I don't know
why. Can I define my own __put_user_bad() function in
my recompiled loop.c? 
 
Another question. My recompiled loop.o is about 25K.
But I found that the loop.o in the
"linux/drivers/block" directory is only 15K. What is
the reason of this difference? I use the following
command line to compile the loop.c file.
 
gcc -D__KERNEL__ -I/home/mzhu/linux/include -Wall
-DMODULE -DMODVERSIONS -include
/home/mzhu/linux/include/linux/modversions.h -c loop.c
 
Am I right? I can compile the loop.c and create the
loop.o successfully. But I couldn't load it. 
 
Thanks
 
Best regards,
 
Michael

______________________________________________________________________ 
Web-hosting solutions for home and business! http://website.yahoo.ca
