Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbTJZJyg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 04:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262716AbTJZJyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 04:54:36 -0500
Received: from web13005.mail.yahoo.com ([216.136.174.15]:6408 "HELO
	web13005.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263019AbTJZJyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 04:54:33 -0500
Message-ID: <20031026095427.23976.qmail@web13005.mail.yahoo.com>
Date: Sun, 26 Oct 2003 01:54:27 -0800 (PST)
From: Mr Amit Patel <patelamitv@yahoo.com>
Subject: as_arq scheduler alloc with 2.6.0-test8-mm1
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 
I am using 2.6.0-test8-mm1 kernel. I am using qlogic
driver patch with 
this kernel. Every time I insert qlogic driver my
as_arq pool size 
increases by 2000 objects of each size 76 bytes. I
have kgdb setup and I 
tried to put break point in various function in
as_iosched.c to see if I 
can see where it is getting allocated, but It never
hit the breakpoint. 
Can anyone tell me whether its as-i/o scheduler
problem or something in 
qlogic driver? How do I debug is problem?
 
After doing just insmod/rmmod for 20/30 times my
machine runs out of 
free pages. If I dont try to insert qlogic driver my
system runs fine for 
days without any problem. Following is the output of
/proc/slabinfo for 
as_arq after doing insmod/rmmod.

Any help as to how to debug this problem is
appreciated. 
 
Thanks
Amit
 
[root@Host200-w2k root]# cat /proc/slabinfo |grep
as_arq
as_arq              6251   6300     76   50    1 :
tunables   32   16    
0 : slabdata    126    126      0 : globalstat  165249
  6300  1708 
1538    0    1   82 : cpustat 245396  11366 247012  
3502
[root@Host200-w2k root]# cat /proc/slabinfo |grep
as_arq
as_arq              8291   8300     76   50    1 :
tunables   32   16    
0 : slabdata    166    166      0 : globalstat  167299
  8298  1749 
1539    0    1   82 : cpustat 247381  11530 247121  
3502
[root@Host200-w2k root]# 

__________________________________
Do you Yahoo!?
Exclusive Video Premiere - Britney Spears
http://launch.yahoo.com/promos/britneyspears/
