Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280956AbRKCNtQ>; Sat, 3 Nov 2001 08:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280959AbRKCNtH>; Sat, 3 Nov 2001 08:49:07 -0500
Received: from mailrelay2.inwind.it ([212.141.54.102]:3051 "EHLO
	mailrelay2.inwind.it") by vger.kernel.org with ESMTP
	id <S280956AbRKCNs7>; Sat, 3 Nov 2001 08:48:59 -0500
Message-Id: <3.0.6.32.20011103145200.0201acd0@pop.tiscalinet.it>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Sat, 03 Nov 2001 14:52:00 +0100
To: linux-kernel@vger.kernel.org
From: Lorenzo Allegrucci <lenstra@tiscalinet.it>
Subject: VM: Linux-2.4.14-pre7 and qsbench
Cc: Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linux-2.4.14-pre7 kills early..

lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
Out of Memory: Killed process 224 (qsbench).
17.770u 3.160s 1:19.95 26.1%    0+0k 0+0io 13294pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
Out of Memory: Killed process 226 (qsbench).
26.030u 15.530s 1:39.39 41.8%   0+0k 0+0io 13283pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
Out of Memory: Killed process 228 (qsbench).
29.350u 41.360s 2:27.63 47.8%   0+0k 0+0io 15214pf+0w
0:12 kswapd

With more swap space is much better, but performance seem slightly
worse than 2.4.14-pre6:

lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
70.530u 2.920s 2:16.35 53.8%    0+0k 0+0io 17575pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
70.510u 3.160s 2:19.79 52.7%    0+0k 0+0io 17639pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
70.540u 3.270s 2:17.39 53.7%    0+0k 0+0io 17544pf+0w
0:01 kswapd



-- 
Lorenzo
