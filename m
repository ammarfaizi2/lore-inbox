Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280183AbRJaMKG>; Wed, 31 Oct 2001 07:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280182AbRJaMJ5>; Wed, 31 Oct 2001 07:09:57 -0500
Received: from mailrelay3.inwind.it ([212.141.54.103]:58048 "EHLO
	mailrelay3.inwind.it") by vger.kernel.org with ESMTP
	id <S280181AbRJaMJj>; Wed, 31 Oct 2001 07:09:39 -0500
Message-Id: <3.0.6.32.20011031131253.01fb8e40@pop.tiscalinet.it>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Wed, 31 Oct 2001 13:12:53 +0100
To: linux-kernel@vger.kernel.org
From: Lorenzo Allegrucci <lenstra@tiscalinet.it>
Subject: VM: qsbench
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Three runs for each kernel, kswapd CPU time appended.

Linux-2.4.13-ac4:
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
70.800u 3.470s 3:04.15 40.3%    0+0k 0+0io 13916pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
71.530u 3.930s 3:13.90 38.9%    0+0k 0+0io 14101pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
71.260u 3.640s 3:03.54 40.8%    0+0k 0+0io 13047pf+0w
0:08 kswapd

Linux-2.4.13:
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
71.260u 2.150s 2:20.68 52.1%    0+0k 0+0io 20173pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
71.020u 2.050s 2:18.78 52.6%    0+0k 0+0io 20353pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
70.810u 2.080s 2:19.50 52.2%    0+0k 0+0io 20413pf+0w
0:06 kswapd

Linux-2.4.14-pre3:
N/A, this kernel cannot run qsbench. Livelock.

Linux-2.4.14-pre4:
Not tested.

Linux-2.4.14-pre5:
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
70.340u 3.450s 2:13.62 55.2%    0+0k 0+0io 16829pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
70.590u 2.940s 2:15.48 54.2%    0+0k 0+0io 17182pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
70.140u 3.480s 2:14.66 54.6%    0+0k 0+0io 17122pf+0w
0:01 kswapd

kswapd CPU time is a record ;)


Linux-2.4.14-pre6:
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
Out of Memory: Killed process 224 (qsbench).
69.890u 3.430s 2:12.48 55.3%    0+0k 0+0io 16374pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
Out of Memory: Killed process 226 (qsbench).
69.550u 2.990s 2:11.31 55.2%    0+0k 0+0io 15374pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
Out of Memory: Killed process 228 (qsbench).
69.480u 3.100s 2:13.33 54.4%    0+0k 0+0io 15950pf+0w
0:01 kswapd

This is interesting, -pre6 killed qsbench _just_ before qsbench exited.
Unreliable results.

Linux-2.4.14-pre3aa1:
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
72.180u 2.200s 2:19.59 53.2%    0+0k 0+0io 19568pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
71.510u 2.230s 2:18.74 53.1%    0+0k 0+0io 19585pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
71.500u 2.510s 2:19.29 53.1%    0+0k 0+0io 19606pf+0w
0:04 kswapd

Linux-2.4.14-pre3aa2:
Not tested.

Linux-2.4.14-pre3aa3:
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
71.790u 2.280s 2:17.57 53.8%    0+0k 0+0io 19138pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
71.190u 2.040s 2:16.95 53.4%    0+0k 0+0io 19306pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
72.000u 2.120s 2:16.80 54.1%    0+0k 0+0io 19231pf+0w
0:03 kswapd

Linux-2.4.14-pre3aa4:
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
71.270u 2.210s 2:16.43 53.8%    0+0k 0+0io 19067pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
71.110u 2.180s 2:16.52 53.6%    0+0k 0+0io 19095pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
71.320u 2.290s 2:16.32 53.9%    0+0k 0+0io 19162pf+0w
0:03 kswapd

Linux-2.4.14-pre5aa1:
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
70.580u 2.430s 2:16.36 53.5%    0+0k 0+0io 19024pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
71.070u 2.180s 2:15.97 53.8%    0+0k 0+0io 19110pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
71.280u 2.160s 2:16.61 53.7%    0+0k 0+0io 19185pf+0w
0:03 kswapd



-- 
Lorenzo
