Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274421AbRITK7l>; Thu, 20 Sep 2001 06:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274420AbRITK7b>; Thu, 20 Sep 2001 06:59:31 -0400
Received: from prfdec.natur.cuni.cz ([195.113.56.1]:48388 "EHLO
	prfdec.natur.cuni.cz") by vger.kernel.org with ESMTP
	id <S274421AbRITK7Z>; Thu, 20 Sep 2001 06:59:25 -0400
X-Envelope-From: mmokrejs
Posted-Date: Thu, 20 Sep 2001 12:59:43 +0200 (MET DST)
Date: Thu, 20 Sep 2001 12:59:42 +0200 (MET DST)
From: =?iso-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
To: "Magnus Naeslund(f)" <mag@fbab.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Perf improvements in 2.4.10pre12aa1
In-Reply-To: <05ab01c141bc$6c5a9f60$020a0a0a@totalmef>
Message-ID: <Pine.OSF.4.21.0109201243080.24552-100000@prfdec.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I've just started some tests to try to repeat the memory allocation
errors. I see the aa1 kernel is twice fast as -pre12!? Is this expected?
I have 2x intelPIII 933MHz, 1GB RAM, HIGMEM kernel, ReiserFS, aic7xxx,
eepro100.


linux-2.4.10-pre12
dbench 16: Throughput 67.8566 MB/sec (NB=84.8208 MB/sec  678.566 MBit/sec)  16 procs

Yesterday after havy tests and after memory alloc. errors already
appeared:
        total:    used:    free:  shared: buffers:  cached:
Mem:  1054490624 880287744 174202880        0  4653056 460627968
Swap: 2147467264 42909696 2104557568
MemTotal:      1029776 kB
MemFree:        170120 kB
MemShared:           0 kB
Buffers:          4544 kB
Cached:         448416 kB
SwapCached:       1416 kB
Active:         377868 kB
Inactive:        76508 kB
HighTotal:      131072 kB
HighFree:         2044 kB
LowTotal:       898704 kB
LowFree:        168076 kB
SwapTotal:     2097136 kB
SwapFree:      2055232 kB



linux-2.4.10-pre12aa1
dbench 16: Throughput 141.659 MB/sec (NB=177.074 MB/sec  1416.59 MBit/sec)  16 procs

Now after fresh bootup and just after I started first tests:
        total:    used:    free:  shared: buffers:  cached:
Mem:  1054412800 110338048 944074752        0  8560640 59211776
Swap: 2147467264        0 2147467264
MemTotal:      1029700 kB
MemFree:        921948 kB
MemShared:           0 kB
Buffers:          8360 kB
Cached:          57824 kB
SwapCached:          0 kB
Active:              0 kB
Inactive:        66184 kB
HighTotal:      131072 kB
HighFree:        58612 kB
LowTotal:       898628 kB
LowFree:        863336 kB
SwapTotal:     2097136 kB
SwapFree:      2097136 kB


The documentation to dbech is a bit sparse (README,INSTALL). It's a bit
offtopic, but would someone explain me where does the dbench write, into
which directory? I performed the tests above under same user and in same
tmp/ directory, to be sure. Maybe it was not necessary at all. ;)

Thanks
-- 
Martin Mokrejs - PGP5.0i key is at http://www.natur.cuni.cz/~mmokrejs
MIPS / Institute for Bioinformatics <http://mips.gsf.de>
GSF - National Research Center for Environment and Health
Ingolstaedter Landstrasse 1, D-85764 Neuherberg, Germany


