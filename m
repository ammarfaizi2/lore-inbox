Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276803AbRJKT5k>; Thu, 11 Oct 2001 15:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276813AbRJKT5V>; Thu, 11 Oct 2001 15:57:21 -0400
Received: from mailrelay2.inwind.it ([212.141.54.102]:36820 "EHLO
	mailrelay2.inwind.it") by vger.kernel.org with ESMTP
	id <S276802AbRJKT5M>; Thu, 11 Oct 2001 15:57:12 -0400
Message-Id: <3.0.6.32.20011011215917.01e78210@pop.tiscalinet.it>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Thu, 11 Oct 2001 21:59:17 +0200
To: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
From: Lorenzo Allegrucci <lenstra@tiscalinet.it>
Subject: Re: 2.4.12aa1 [was Re: 2.4.11aa1 [was Re: 2.4.11pre6aa1]]
In-Reply-To: <20011011123231.C714@athlon.random>
In-Reply-To: <20011010051104.F726@athlon.random>
 <20011009205516.F724@athlon.random>
 <20011010051104.F726@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12.32 11/10/01 +0200, Andrea Arcangeli wrote:
>This update has further VM work (actually fixes compared to 2.4.11aa1),
>I also changed my mind about a few bits, and I suggest to test it since
>this one seems to run very well for me.
>
>Lorenzo and Jeffrey, I'd be interested if you could check with your
>tests how it behaves compared to 2.4.12 vanilla.

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

lenstra:~/src/qsort> time ./qsbench -n 9000000 -p 10 -s 140175100
63.500u 1.800s 1:34.06 69.4%    0+0k 0+0io 8836pf+0w
lenstra:~/src/qsort> time ./qsbench -n 9000000 -p 10 -s 140175100
63.020u 1.470s 1:20.22 80.3%    0+0k 0+0io 6394pf+0w
lenstra:~/src/qsort> time ./qsbench -n 9000000 -p 10 -s 140175100
63.130u 1.520s 1:12.21 89.5%    0+0k 0+0io 5676pf+0w
lenstra:~/src/qsort> time ./qsbench -n 9000000 -p 10 -s 140175100
62.820u 1.560s 1:12.61 88.6%    0+0k 0+0io 5433pf+0w
lenstra:~/src/qsort> time ./qsbench -n 9000000 -p 10 -s 140175100
63.070u 1.560s 1:14.83 86.3%    0+0k 0+0io 5811pf+0w
lenstra:~/src/qsort> time ./qsbench -n 9000000 -p 10 -s 140175100
63.160u 1.650s 1:17.84 83.2%    0+0k 0+0io 6036pf+0w

lenstra:~/src/qsort> time ./qsbench -n 45000000 -p 2 -s 140175100
71.290u 2.010s 1:50.11 66.5%    0+0k 0+0io 10462pf+0w
lenstra:~/src/qsort> time ./qsbench -n 45000000 -p 2 -s 140175100
71.490u 2.220s 1:49.62 67.2%    0+0k 0+0io 11413pf+0w
lenstra:~/src/qsort> time ./qsbench -n 45000000 -p 2 -s 140175100
71.280u 2.360s 1:54.79 64.1%    0+0k 0+0io 11110pf+0w



Linux-2.4.12-aa1:

lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
seed = 140175100
71.420u 2.110s 2:49.01 43.5%    0+0k 0+0io 16110pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
seed = 140175100
70.960u 1.850s 2:45.05 44.1%    0+0k 0+0io 15463pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
seed = 140175100
70.760u 1.980s 2:45.61 43.9%    0+0k 0+0io 15595pf+0w

lenstra:~/src/qsort> time ./qsbench -n 9000000 -p 10 -s 140175100
64.020u 1.940s 1:38.76 66.7%    0+0k 0+0io 10206pf+0w
lenstra:~/src/qsort> time ./qsbench -n 9000000 -p 10 -s 140175100
64.190u 1.410s 1:16.98 85.2%    0+0k 0+0io 6796pf+0w
lenstra:~/src/qsort> time ./qsbench -n 9000000 -p 10 -s 140175100
63.530u 1.520s 1:13.51 88.4%    0+0k 0+0io 5274pf+0w
lenstra:~/src/qsort> time ./qsbench -n 9000000 -p 10 -s 140175100
63.980u 1.370s 1:16.53 85.3%    0+0k 0+0io 6456pf+0w
lenstra:~/src/qsort> time ./qsbench -n 9000000 -p 10 -s 140175100
63.640u 1.680s 1:16.38 85.5%    0+0k 0+0io 6189pf+0w
lenstra:~/src/qsort> time ./qsbench -n 9000000 -p 10 -s 140175100
63.720u 1.500s 1:15.33 86.5%    0+0k 0+0io 5777pf+0w

lenstra:~/src/qsort> time ./qsbench -n 45000000 -p 2 -s 140175100
72.810u 2.010s 1:58.16 63.3%    0+0k 0+0io 14220pf+0w
lenstra:~/src/qsort> time ./qsbench -n 45000000 -p 2 -s 140175100
71.700u 2.290s 1:58.68 62.3%    0+0k 0+0io 13803pf+0w
lenstra:~/src/qsort> time ./qsbench -n 45000000 -p 2 -s 140175100
72.440u 2.220s 1:56.13 64.2%    0+0k 0+0io 12911pf+0w




-- 
Lorenzo
