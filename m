Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318980AbSIJCSh>; Mon, 9 Sep 2002 22:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319003AbSIJCSh>; Mon, 9 Sep 2002 22:18:37 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:63698 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S318980AbSIJCSh>;
	Mon, 9 Sep 2002 22:18:37 -0400
Date: Tue, 10 Sep 2002 12:23:06 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus <torvalds@transmeta.com>,
       Trivial Kernel Patches <trivial@rustcorp.com.au>, axboe@suse.de
Subject: [PATCH][TRIVIAL] cdrom.c is the only file to include asm/fcntl.h
Message-Id: <20020910122306.0256cca1.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.2 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

drivers/cdrom/cdrom.c is the only file (apart from include/linux/fcntl.h)
that includes asm/fcntl.h.  This changes that and should have no affect.

I need to do this before I consolidate the asm/fcntl.h files into
linux/fcntl.h (coming next - again).

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.34/drivers/cdrom/cdrom.c 2.5.34-fcntl.1/drivers/cdrom/cdrom.c
--- 2.5.34/drivers/cdrom/cdrom.c	2002-09-10 11:52:23.000000000 +1000
+++ 2.5.34-fcntl.1/drivers/cdrom/cdrom.c	2002-09-10 12:15:59.000000000 +1000
@@ -266,8 +266,8 @@
 #include <linux/proc_fs.h>
 #include <linux/blkpg.h>
 #include <linux/init.h>
+#include <linux/fcntl.h>
 
-#include <asm/fcntl.h>
 #include <asm/uaccess.h>
 
 /* used to tell the module to turn on full debugging messages */
