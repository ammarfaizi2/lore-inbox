Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263569AbSJGWaT>; Mon, 7 Oct 2002 18:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263570AbSJGWaT>; Mon, 7 Oct 2002 18:30:19 -0400
Received: from tomts15-srv.bellnexxia.net ([209.226.175.3]:60088 "EHLO
	tomts15-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S263569AbSJGWaS>; Mon, 7 Oct 2002 18:30:18 -0400
Subject: [BENCHMARK] 2.5.40-mm2 contest with 1/2 disk(s), swap and noswap
From: Shane Shrybman <shrybman@sympatico.ca>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 07 Oct 2002 18:35:55 -0400
Message-Id: <1034030156.7265.45.camel@mars.goatskin.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since there is no LVM in 2.5 yet I built another 2.5 testing box and ran
contest v0.42 on it. I changed a few things in contest so it would
finish in my lifetime ( make -j 1 for kernel builds and only half the
size of memory for io_load).

This was on a 2 disk scsi(2940UW) K6, 48MB system with no ide. The OS,
swap and kernel build was on the slower scsi disk, and a fresh ext3 on
the faster scsi disk.

The runs that have '2d' in the label were done with the io_load on the
faster disk while the kernel compile was done on the slower disk, with
OS and swap.

The '1d' runs were with everything on the OS disk.
The 's' indicates that 128MB swap partition was used on that run,
otherwise the swap device wasn't used.

Preempt was not used in the making of these benchmarks. These are the
averages of 3 runs.

noload:
Kernel                  Time            CPU%            Ratio
2.5.40-mm2-1d_500.1     394.1           96              1.00
2.5.40-mm2-1d_500.1s    393.1           96              1.00
2.5.40-mm2-2d_500.1     394.4           96              1.00
io_load:
Kernel                  Time            CPU%            Ratio
2.5.40-mm2-1d_500.1     1556.9          25              3.95
2.5.40-mm2-1d_500.1s    1536.1          26              3.90
2.5.40-mm2-2d_500.1     880.4           47              2.23
2.5.40-mm2-2d_500.1s    873.9           48              2.22

mem_load:
Kernel                  Time            CPU%            Ratio
2.5.40-mm2-1d_500.1s    3801.3          11              9.65
2.5.40-mm2-2d_500.1s    3639.7          11              9.24

I would have expected using swap to have a bigger impact.

Hope these are of value.

Shane

