Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262650AbUKXNtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262650AbUKXNtr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 08:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262656AbUKXNsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 08:48:45 -0500
Received: from lucidpixels.com ([66.45.37.187]:14737 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S262684AbUKXNTs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:19:48 -0500
Date: Wed, 24 Nov 2004 08:13:06 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.9 SCSI driver compile error w/gcc-3.4.2.
Message-ID: <Pine.LNX.4.61.0411240812220.19627@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Under slackware-current, gcc-3.4.2.

root@p500b:/usr/src/linux# make modules
   CHK     include/linux/version.h
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
   CC [M]  drivers/scsi/cpqfcTScontrol.o
drivers/scsi/cpqfcTScontrol.c:609:2: #error This is too much stack
drivers/scsi/cpqfcTScontrol.c:721:2: #error This is too much stack
make[2]: *** [drivers/scsi/cpqfcTScontrol.o] Error 1
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2
root@p500b:/usr/src/linux# gcc -v
Reading specs from /usr/lib/gcc/i486-slackware-linux/3.4.2/specs
Configured with: ../gcc-3.4.2/configure --prefix=/usr --enable-shared 
--enable-threads=posix --enable-__cxa_atexit --disable-checking 
--with-gnu-ld --verbose --target=i486-slackware-linux 
--host=i486-slackware-linux
Thread model: posix
gcc version 3.4.2
root@p500b:/usr/src/linux#

