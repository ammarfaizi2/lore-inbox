Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129930AbQL2X3k>; Fri, 29 Dec 2000 18:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130061AbQL2X33>; Fri, 29 Dec 2000 18:29:29 -0500
Received: from hermes.mixx.net ([212.84.196.2]:63754 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129930AbQL2X3T>;
	Fri, 29 Dec 2000 18:29:19 -0500
Message-ID: <3A4D169E.B60B356F@innominate.de>
Date: Fri, 29 Dec 2000 23:56:30 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: File I/O benchmarks for various kernel
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been using dbench a lot lately for reality checks on various kernel
mods, and out of interest I decided to run benchmarks with it on a few
different kernel versions.  I noticed a major difference between 2.2 and
2.4 kernels - 2.4 is running the benchmarks about 3 times faster than
2.2, and it seems to be getting faster with each step towards 2.4.0.  On
the other hand, 2.2 seems to be getting slower.  Here are a few points
on the curve.

  Test machine: 64 meg, 500 Mhz K6, IDE, Ext2, Blocksize=4K
  Test: dbench 48

  Kernel                 Throughput      Elapsed Time
  ------                 ----------      ------------
  2.2.16                 3.1 MB/sec      33 min 53 secs
  2.2.18                 2.8 MB/sec      38 min 10 secs
  2.2.19-pre3            2.7 MB/sec      39 min 44 secs
  2.4.0-test12           7.3 MB/sec      14 min 32 secs
  2.4.0-test13-pre4      9.5 MB/sec      11 min 06 secs
  2.4.0-test13-pre5     10.8 MB/sec       9 min 48 secs

Dbench was written by Andrew Tridgell to measure disk performance under
simulated samba network traffic load.  The '48' means it's simulating
the file access patterns of 48 network clients, all doing heavy io at
the same time.

For anyone interested in checking these results on their own hardware,
dbench is available at:

  ftp://samba.org/pub/tridge/dbench/dbench-1.1.tar.gz

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
