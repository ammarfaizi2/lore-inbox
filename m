Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284305AbSA2WMe>; Tue, 29 Jan 2002 17:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284180AbSA2WMZ>; Tue, 29 Jan 2002 17:12:25 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:39125 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S284970AbSA2WLr>; Tue, 29 Jan 2002 17:11:47 -0500
Message-ID: <3C571DB2.4E0C0436@us.ibm.com>
Date: Tue, 29 Jan 2002 14:09:54 -0800
From: Mingming cao <cmm@us.ibm.com>
Organization: Linux Technology Center
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Could not compile md/raid5.c and md/multipath.c in 2.5.3-pre3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

While compiling the clean 2.5.3-pre3 kernel I found the
drivers/md/raid5.c and drivers/md/multipatch.c could not get compiled.
Here is the compiling error for raid5.c: 

......
-D__KERNEL__ -I/home/ming/views/253-pre3/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686    -c -o raid5.o raid5.c
In file included from raid5.c:23:
/home/ming/views/253-pre3/include/linux/raid/raid5.h:218: parse error
before `md_wait_queue_head_t'
/home/ming/views/253-pre3/include/linux/raid/raid5.h:218: warning: no
semicolon
at end of struct or union
/home/ming/views/253-pre3/include/linux/raid/raid5.h:222: parse error
before `device_lock'
......


This failure also happened for 2.5.2 kernel.  Both of raid5.c and
multipatch.c use some data structures defined in md_compatible.h, which
was included in md.h before but does not exist under include/linux/raid
for now.  Could someone fix this?



-- 
Mingming Cao
