Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261304AbSJYHnc>; Fri, 25 Oct 2002 03:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261305AbSJYHnc>; Fri, 25 Oct 2002 03:43:32 -0400
Received: from [211.150.96.25] ([211.150.96.25]:28597 "EHLO smtp.x263.net")
	by vger.kernel.org with ESMTP id <S261304AbSJYHnb>;
	Fri, 25 Oct 2002 03:43:31 -0400
From: "kcn" <kcn@263.net>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.18 freeze on 4G memory.
Date: Fri, 25 Oct 2002 15:49:08 +0800
Message-ID: <000e01c27bfb$06d3d970$31036fa6@zhoulin>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  I have a 4*Xeon 700A+2G memory server running reiserfs+2.4.18+openwall
patch.
Our service is running with large processes(> 4000) and a little heavy
disk I/O, and 
the server's load is about 3.x to 4.x.
  But last month after I increased 2G memory to 4G, the server is always
froze every two 
or three hours. After 5-10 minutes, it can be alive again.
  I have changed to RedHat kernel 2.4.18-17, and it has the same problem
but a little well--
it is froze only several seconds. And the average load is above
20,higher than 2.4.18.
  Kernel build with 4G memory support + reiserfs + smp support + intel
e100 driver module.
  Any advice? Thank for help.
2G + linux 2.4.18
# uptime
  9:30pm  up 4 days,  9:22,  7 users,  load average: 3.48, 4.63, 4.63
# vmstat 2 2
   procs                      memory    swap          io     system
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us
sy  id
 2  5  1 294264  20832 321096 584276   7   6    25    15   28    23  10
7  27
 4  1  0 294196  13512 322424 585088 828   0  1476   540 7025  4090  18
31  51

4G + 2.4.18 freeze
# uptime
  3:30pm  up  3:09,  5 users,  load average: 534.48, 154.42, 69.21
# vmstat 2 2
   procs                      memory    swap          io     system
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us
sy  id
276 14  8      0  43788 191968 2047620   0   0    82   157  822   404
12  31  57
 6 30  2      0  14704 191156 2048776   0   0   760  3564 9212  3028  21
78   1# uptime

4G + redhat 2.4.18-17
#uptime
  1:25pm  up  1:04,  5 users,  load average: 27.79, 23.25, 20.59
# vmstat 2 2
   procs                      memory    swap          io     system
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us
sy  id
 1  1  1      0 664524 277408 1585192   0   0   113   140  740   398  11
22  68
 0  1  2      0 664928 277852 1585428   0   0   240  1382 4470  2194  17
43  40


