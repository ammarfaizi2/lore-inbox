Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263478AbTDVUUy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 16:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263481AbTDVUUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 16:20:54 -0400
Received: from watch.techsource.com ([209.208.48.130]:1234 "EHLO
	techsource.com") by vger.kernel.org with ESMTP id S263478AbTDVUUv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 16:20:51 -0400
Message-ID: <3EA5AABF.4090303@techsource.com>
Date: Tue, 22 Apr 2003 16:49:03 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Can one build 2.5.68 with allyesconfig?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is anyone else able to build 2.5.68 with allyesconfig?

I'm using RH7.2, so the first thing I did was edit the main Makefile to 
replace gcc with "gcc3" (3.0.4).  Maybe the compiler is STILL my 
problem.  The problem doesn't stand out clearly to me, but I also 
haven't put much thought into it.  I'll try to use some more of my 
brain.  But if it's not going to be fixable by me, I humbly request help.

Before the compile terminates, there are a number of the same warning 
for other files, being the same as the ones below for 'flags'.

The compile dies thusly:

  gcc3 -Wp,-MD,drivers/char/.riscom8.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=i686 
-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=riscom8 -DKBUILD_MODNAME=riscom8 -c -o 
drivers/char/.tmp_riscom8.o drivers/char/riscom8.c
In file included from drivers/char/riscom8.c:51:
drivers/char/riscom8.h:88: field `tqueue' has incomplete type
drivers/char/riscom8.h:89: field `tqueue_hangup' has incomplete type
drivers/char/riscom8.c:84: warning: type defaults to `int' in 
declaration of `DECLARE_TASK_QUEUE'
drivers/char/riscom8.c:84: warning: parameter names (without types) in 
function declaration
drivers/char/riscom8.c: In function `rc_init_CD180':
drivers/char/riscom8.c:247: warning: implicit declaration of function 
`save_flags'
drivers/char/riscom8.c:247: warning: implicit declaration of function `cli'
drivers/char/riscom8.c:251: warning: implicit declaration of function `sti'
drivers/char/riscom8.c:264: warning: implicit declaration of function 
`restore_flags'
drivers/char/riscom8.c:245: warning: `flags' might be used uninitialized 
in this function
drivers/char/riscom8.c: In function `rc_mark_event':
drivers/char/riscom8.c:351: warning: implicit declaration of function 
`queue_task'
drivers/char/riscom8.c:351: `tq_riscom' undeclared (first use in this 
function)
drivers/char/riscom8.c:351: (Each undeclared identifier is reported only 
once
drivers/char/riscom8.c:351: for each function it appears in.)
drivers/char/riscom8.c:352: warning: implicit declaration of function 
`mark_bh'
drivers/char/riscom8.c:352: `RISCOM8_BH' undeclared (first use in this 
function)
drivers/char/riscom8.c: In function `rc_receive_exc':
drivers/char/riscom8.c:435: structure has no member named `tqueue'
drivers/char/riscom8.c:435: `tq_timer' undeclared (first use in this 
function)
drivers/char/riscom8.c: In function `rc_receive':
drivers/char/riscom8.c:466: structure has no member named `tqueue'
drivers/char/riscom8.c:466: `tq_timer' undeclared (first use in this 
function)
drivers/char/riscom8.c: In function `rc_check_modem':
drivers/char/riscom8.c:556: warning: implicit declaration of function 
`schedule_task'
drivers/char/riscom8.c: In function `rc_setup_port':
drivers/char/riscom8.c:870: warning: `flags' might be used uninitialized 
in this function
drivers/char/riscom8.c: In function `rc_open':
drivers/char/riscom8.c:1090: warning: `flags' might be used 
uninitialized in this function
drivers/char/riscom8.c: In function `rc_close':
drivers/char/riscom8.c:1134: warning: `flags' might be used 
uninitialized in this function
drivers/char/riscom8.c: In function `rc_write':
drivers/char/riscom8.c:1227: warning: `flags' might be used 
uninitialized in this function
drivers/char/riscom8.c: In function `rc_put_char':
drivers/char/riscom8.c:1303: warning: `flags' might be used 
uninitialized in this function
drivers/char/riscom8.c: In function `rc_flush_chars':
drivers/char/riscom8.c:1325: warning: `flags' might be used 
uninitialized in this function
drivers/char/riscom8.c: In function `rc_flush_buffer':
drivers/char/riscom8.c:1368: warning: `flags' might be used 
uninitialized in this function
drivers/char/riscom8.c: In function `rc_get_modem_info':
drivers/char/riscom8.c:1388: warning: `flags' might be used 
uninitialized in this function
drivers/char/riscom8.c: In function `rc_set_modem_info':
drivers/char/riscom8.c:1408: warning: `flags' might be used 
uninitialized in this function
drivers/char/riscom8.c: In function `rc_ioctl':
drivers/char/riscom8.c:1446: warning: `flags' might be used 
uninitialized in this function
drivers/char/riscom8.c:1446: warning: `flags' might be used 
uninitialized in this function
drivers/char/riscom8.c:1467: warning: `flags' might be used 
uninitialized in this function
drivers/char/riscom8.c: In function `rc_throttle':
drivers/char/riscom8.c:1582: warning: `flags' might be used 
uninitialized in this function
drivers/char/riscom8.c: In function `rc_unthrottle':
drivers/char/riscom8.c:1605: warning: `flags' might be used 
uninitialized in this function
drivers/char/riscom8.c: In function `rc_stop':
drivers/char/riscom8.c:1628: warning: `flags' might be used 
uninitialized in this function
drivers/char/riscom8.c: In function `rc_start':
drivers/char/riscom8.c:1646: warning: `flags' might be used 
uninitialized in this function
drivers/char/riscom8.c: In function `rc_set_termios':
drivers/char/riscom8.c:1703: warning: `flags' might be used 
uninitialized in this function
drivers/char/riscom8.c: In function `do_riscom_bh':
drivers/char/riscom8.c:1725: warning: implicit declaration of function 
`run_task_queue'
drivers/char/riscom8.c:1725: `tq_riscom' undeclared (first use in this 
function)
drivers/char/riscom8.c: In function `rc_init_drivers':
drivers/char/riscom8.c:1754: warning: implicit declaration of function 
`init_bh'
drivers/char/riscom8.c:1754: `RISCOM8_BH' undeclared (first use in this 
function)
drivers/char/riscom8.c: In function `rc_release_drivers':
drivers/char/riscom8.c:1833: warning: implicit declaration of function 
`remove_bh'
drivers/char/riscom8.c:1833: `RISCOM8_BH' undeclared (first use in this 
function)
drivers/char/riscom8.c:1829: warning: `flags' might be used 
uninitialized in this function
drivers/char/riscom8.c: At top level:
drivers/char/riscom8.c:84: warning: `DECLARE_TASK_QUEUE' declared 
`static' but never defined
make[2]: *** [drivers/char/riscom8.o] Error 1
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2


