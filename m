Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273857AbRJKIoL>; Thu, 11 Oct 2001 04:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273912AbRJKIoC>; Thu, 11 Oct 2001 04:44:02 -0400
Received: from mailrelay2.inwind.it ([212.141.54.102]:27576 "EHLO
	mailrelay2.inwind.it") by vger.kernel.org with ESMTP
	id <S273857AbRJKIns>; Thu, 11 Oct 2001 04:43:48 -0400
Message-Id: <3.0.6.32.20011011104544.01e9bea0@pop.tiscalinet.it>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Thu, 11 Oct 2001 10:45:44 +0200
To: linux-kernel@vger.kernel.org
From: Lorenzo Allegrucci <lenstra@tiscalinet.it>
Subject: qsbench on old kernels
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some interesting results..

Linux-2.2.19:
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
seed = 140175100
70.940u 3.550s 2:58.18 41.8%    0+0k 0+0io 167775pf+155540w <-------
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
seed = 140175100
70.010u 3.280s 2:43.83 44.7%    0+0k 0+0io 147384pf+135855w <-------
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
seed = 140175100
70.160u 2.940s 2:43.73 44.6%    0+0k 0+0io 146437pf+135856w <-------
kswapd CPU time: 1:08


Linux-2.4.0:
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
seed = 140175100
73.120u 5.720s 3:00.83 43.5%    0+0k 0+0io 149pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
seed = 140175100
71.560u 5.530s 3:02.87 42.1%    0+0k 0+0io 171pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
seed = 140175100
71.090u 6.140s 3:04.98 41.7%    0+0k 0+0io 170pf+0w
kswapd CPU time: 0:06


Linux-2.4.6:
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
seed = 140175100
79.160u 3.320s 4:23.24 31.3%    0+0k 0+0io 2776pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
seed = 140175100
71.690u 1.950s 2:41.22 45.6%    0+0k 0+0io 176pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
seed = 140175100
70.570u 2.260s 2:40.78 45.2%    0+0k 0+0io 177pf+0w
kswapd CPU time: 2:36


Linux-2.4.7:
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
seed = 140175100
79.160u 3.480s 4:25.44 31.1%    0+0k 0+0io 2823pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
seed = 140175100
71.460u 2.210s 2:40.05 46.0%    0+0k 0+0io 174pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
seed = 140175100
70.380u 1.850s 2:42.52 44.4%    0+0k 0+0io 177pf+0w
kswapd CPU time: 2:39


Linux-2.4.8:
n/a, system deadlocked during third run.


Linux-2.4.9:
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
seed = 140175100
71.100u 2.160s 3:03.79 39.8%    0+0k 0+0io 147pf+0w

Lots of "__alloc_pages: 0-order allocation failed."
Runs 1 and 2 n/a.


Linux-2.4.10:
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
seed = 140175100
70.410u 1.870s 2:45.25 43.7%    0+0k 0+0io 16088pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
seed = 140175100
70.910u 1.840s 2:45.16 44.0%    0+0k 0+0io 16338pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
seed = 140175100
71.310u 1.910s 2:45.20 44.3%    0+0k 0+0io 16211pf+0w
kswapd CPU time: 0.03

Linux-2.4.11:
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
seed = 140175100
71.020u 1.650s 2:20.74 51.6%    0+0k 0+0io 10652pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
seed = 140175100
71.070u 1.650s 2:21.51 51.3%    0+0k 0+0io 10499pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
seed = 140175100
70.790u 1.670s 2:21.01 51.3%    0+0k 0+0io 10641pf+0w
kswapd CPU time: 0.04



-- 
Lorenzo

