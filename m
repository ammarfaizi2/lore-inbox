Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269978AbRHJTHB>; Fri, 10 Aug 2001 15:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269975AbRHJTGv>; Fri, 10 Aug 2001 15:06:51 -0400
Received: from mailsorter.ma.tmpw.net ([63.112.169.25]:17440 "EHLO
	mailsorter1.ma.tmpw.net") by vger.kernel.org with ESMTP
	id <S269971AbRHJTGs>; Fri, 10 Aug 2001 15:06:48 -0400
Message-ID: <3AB544CBBBE7BF428DA7DBEA1B85C79C9B7006@nocmail.ma.tmpw.net>
From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
To: "'sparc-linux@vger.kernel.org'" <sparc-linux@vger.kernel.org>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: 2.4.7ac9,10,11 compile error on Sparc (revisited)
Date: Fri, 10 Aug 2001 15:06:53 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Just want to let you know I am running into an error trying to compile the
ac kernels on Sparc Ultra5.  The plain 2.4.7 compiles fine, and I have also
compiled 2.4.8pre8 fine.  ac9,10 and 11, after applying the patch and during
the make vmlinux, it errors out with the error below.  It looks like an
include header file is being looked for, hw_irq.h which is not in the asm
tree.  I thought originally that the symlink for asm was not getting
created, but it is correctly created.  I was trying to track down where the
include file may be getting called from, but have not found it yet.

Error:
In file included from sched.c:26:

/usr/src/linux-2.4.7/include/linux/irq.h:61: asm/hw_irq.h: No such file or
directory

make[2]: *** [sched.o] Error 1

make[1]: *** [first_rule] Error 2

make: *** [_dir_kernel] Error 2    
                                           
Bruce Holzrichter 
Systems Administrator 
Monster.com 
Phone:  978-461-8869 
Cell:      978-375-9558 
bruce.holzrichter@monster.com 
