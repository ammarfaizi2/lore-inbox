Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132865AbQL3RfG>; Sat, 30 Dec 2000 12:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135177AbQL3Re4>; Sat, 30 Dec 2000 12:34:56 -0500
Received: from tomts7.bellnexxia.net ([209.226.175.40]:52415 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S132865AbQL3Rei>; Sat, 30 Dec 2000 12:34:38 -0500
From: Ed Tomlinson <tomlins@cam.org>
Subject: Re: File I/O benchmarks for various kernel
To: linux-kernel@vger.kernel.org
Date: Sat, 30 Dec 2000 12:03:52 -0500
Organization: me
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: KNode/0.3.3
Message-Id: <20001230170352.AFC5D620CA@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Some more numbers to consider:

7.3 MB/s  54.7s user  159.6s system  25% cpu  elaspsed 14:21.9m 
        reiserfs on hda whick gets 16.1 MB/s from hdparm -t

9.7 MB/s  51.6s user   78.3s system  19% cpu  elaspsed 10:50.8m
        ext2 on hdb which gets 10.6 MB/s from hdparm -t

both drives are udma33.  The sytem is a K6-III 400 with 128m running:
        2.4.0test13pre6 + reil #2 + drm fix + reiserfs 3.6.23

Think ext2 is doing pretty good.  I have seen comments that imply dbench 
does not show reiserfs at its best - they favor the bonnie suite.

Luck
Ed Tomlinson

Daniel Phillips wrote:

> I've been using dbench a lot lately for reality checks on various kernel
> mods, and out of interest I decided to run benchmarks with it on a few
> different kernel versions.  I noticed a major difference between 2.2 and
> 2.4 kernels - 2.4 is running the benchmarks about 3 times faster than
> 2.2, and it seems to be getting faster with each step towards 2.4.0.  On
> the other hand, 2.2 seems to be getting slower.  Here are a few points
> on the curve.
> 
>   Test machine: 64 meg, 500 Mhz K6, IDE, Ext2, Blocksize=4K
>   Test: dbench 48
> 
>   Kernel                 Throughput      Elapsed Time
>   ------                 ----------      ------------
>   2.2.16                 3.1 MB/sec      33 min 53 secs
>   2.2.18                 2.8 MB/sec      38 min 10 secs
>   2.2.19-pre3            2.7 MB/sec      39 min 44 secs
>   2.4.0-test12           7.3 MB/sec      14 min 32 secs
>   2.4.0-test13-pre4      9.5 MB/sec      11 min 06 secs
>   2.4.0-test13-pre5     10.8 MB/sec       9 min 48 secs
> 
> Dbench was written by Andrew Tridgell to measure disk performance under
> simulated samba network traffic load.  The '48' means it's simulating
> the file access patterns of 48 network clients, all doing heavy io at
> the same time.
> 
> For anyone interested in checking these results on their own hardware,
> dbench is available at:
> 
>   ftp://samba.org/pub/tridge/dbench/dbench-1.1.tar.gz
> 
> --
> Daniel
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
