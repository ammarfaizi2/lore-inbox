Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264232AbTFIGcG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 02:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264242AbTFIGcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 02:32:06 -0400
Received: from web10705.mail.yahoo.com ([216.136.130.213]:44098 "HELO
	web10705.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264232AbTFIGcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 02:32:03 -0400
Message-ID: <20030609064541.22729.qmail@web10705.mail.yahoo.com>
Date: Sun, 8 Jun 2003 23:45:41 -0700 (PDT)
From: BalaKrishna Mallipeddi <bkmallipeddi@yahoo.com>
Subject: Problem while adding a module to the kernel
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   while adding a module to Montavista Linux for PPC
architecture i am in trouble. 

   First i added a simple system call with a simple
print statement and it is working fine. 
    For easy development i am writing as module to
replace this existing system call.

   After that developed a simple module to replace
this system call and it also working. While developing
the actual module, i am getting problems.

  While compiling the module i got the following
warning:

rfs_fdisk_module.c:343: warning: implicit declaration
of function `ioctl'

While including the module in to kernel using 'insmod'
i am getting the following errors:
root@(none):/home/chois/rfs_modules/fdisk# insmod
rfs_fdisk_module.o
rfs_fdisk_module.o: unresolved symbol read
rfs_fdisk_module.o: unresolved symbol reboot
rfs_fdisk_module.o: unresolved symbol lseek
rfs_fdisk_module.o: unresolved symbol _exit
rfs_fdisk_module.o: unresolved symbol write
rfs_fdisk_module.o: unresolved symbol ioctl
rfs_fdisk_module.o:
Hint: You are trying to load a module without a GPL
compatible license
      and it has unresolved symbols.  Contact the
module supplier for
      assistance, only they can help you.

I included 'unistd.h' and 'sys/reboot.h' headers. To
resolve these errors if i include the headers
'sys/ioctl.h', 'string.h','sys/types.h', 'stdlib.h' it
is giving many errors of type 'redefinition of
'......' symbol. 

If anybody helps me i am greatful to you. Also let me
know any good documents for what precautions(what to
do and what not to do) to take for kernel programming.

Thanks & Regards



=====
BalaKrishna Mallipeddi
Member Technical Staff Software
Innomedia Technologies Pvt. Ltd.,
#3278, 12th Main, HAL 2nd stage,
Bangalore-560008,
INDIA
Phone : 5278389 + 123

__________________________________
Do you Yahoo!?
Yahoo! Calendar - Free online calendar with sync to Outlook(TM).
http://calendar.yahoo.com
