Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263197AbREWSX1>; Wed, 23 May 2001 14:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263199AbREWSXS>; Wed, 23 May 2001 14:23:18 -0400
Received: from eunhasu.kjist.ac.kr ([203.237.32.200]:14818 "EHLO
	eunhasu.kjist.ac.kr") by vger.kernel.org with ESMTP
	id <S263197AbREWSXP>; Wed, 23 May 2001 14:23:15 -0400
Message-ID: <3B0BFE90.CE148B7@kjist.ac.kr>
Date: Thu, 24 May 2001 03:16:48 +0900
From: "G. Hugh Song" <ghsong@kjist.ac.kr>
Organization: KJIST, Dept of Info. & Commun.
X-Mailer: Mozilla 4.75 [ko] (X11; U; Linux 2.4.3-pre3 i586)
X-Accept-Language: en, ko
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Swap strangeness using 2.4.5pre2aa1
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My Alpha/LInux UP2000 SMP with 1GB memory is running kernel
2.4.5pre2aa1. 
I have been observing some strangeness with Swap usage quite recently 
(in fact since 2.4.4).  Unfortunately, the kernel was made using 
gcc-2.95.2-136.alpha.rpm provided by SuSE-7.0.

The following is the output from "free"
=========================================================================
             total       used       free     shared    buffers    
cached
Mem:       1023128    1015640       7488          0        544    
948976
-/+ buffers/cache:      66120     957008
Swap:      1021936    1021936          0
==========================================================================

And the following is the output from "top"
===========================================================================
  3:09am  up 3 days,  5:49,  7 users,  load average: 1.60, 2.02, 3.05
82 processes: 79 sleeping, 3 running, 0 zombie, 0 stopped
CPU states:  0.1% user,  4.0% system, 80.3% nice, 15.4% idle
Mem:  1023128K av, 1016128K used,    7000K free,       0K shrd,     736K
buff
Swap: 1021936K av, 1021936K used,       0K free                  948968K
cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT  LIB %CPU %MEM   TIME
COMMAND
 9555 sekim     20  10  437M 345M  345M R N  108M 90.4 17.2  1881m
full.ax
 9547 sekim     18  10 95624  24M   792 R N   13M 75.8  1.2  1424m
optcon.ax
21133 hugh      16   0  1976 1976  1648 R    1872  1.0  0.0   0:02 top
    5 root      12   0     0    0     0 SW      0  0.4  0.0 151:52
kswapd
    1 root      12   0   128  104   104 S      16  0.0  0.0   0:44 init
    2 root      12   0     0    0     0 SW      0  0.0  0.0   0:00
keventd
    3 root      20  19     0    0     0 SWN     0  0.0  0.0   0:01
ksoftirqd_CP
    4 root      20  19     0    0     0 SWN     0  0.0  0.0   0:00
ksoftirqd_CP
    6 root      12   0     0    0     0 SW      0  0.0  0.0   0:00
kreclaimd
    7 root      12   0     0    0     0 SW      0  0.0  0.0   0:00
bdflush
    8 root      12   0     0    0     0 SW      0  0.0  0.0   1:03
kupdated
  159 bin       12   0   216  136   136 S     128  0.0  0.0   2:31
portmap
  183 root      12   0   272  168   168 S     120  0.0  0.0   4:25
syslogd
  187 root      12   0   960    8     8 S       0  0.0  0.0   0:06 klogd
  227 root      12   0   136    8     8 S       0  0.0  0.0   0:00
rpc.rquotad

......

=============================================================================

At this point, the mouse movement crawls down at an unacceptable level. 
I 
cannot understand that the above showing of 0 free space of swap space 
although the sum of all memeory usages is far less than 1GB.

I understand that free swap space may become close to 0 and stay there
for 
a while once it ever reached down close to zero.  However, it should
back 
up some nonzero number if the situation is cleared.

Please tell me whether something is wrong or not with the kernel.  If
so, 
I think I should back down to Kernel 2.2.20pre2aa1.

Thank you very much.

-- 
G. Hugh Song

Assoc. Professor
Office: +82-62-970-2210 fax: -3156 handphone: +82-16-608-2210
Email:  ghsong@kjist.ac.kr
Department of Information and Communications
Kwangju Institute of Science and Technology
1 Oryong-dong, Buk-gu, Gwangju, 500-712 South KOREA
