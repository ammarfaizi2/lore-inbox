Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265657AbRF1MkV>; Thu, 28 Jun 2001 08:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265661AbRF1MkM>; Thu, 28 Jun 2001 08:40:12 -0400
Received: from picard.csihq.com ([204.17.222.1]:60800 "EHLO picard.csihq.com")
	by vger.kernel.org with ESMTP id <S265657AbRF1MkC>;
	Thu, 28 Jun 2001 08:40:02 -0400
Message-ID: <02bd01c0ffcf$6a85f150$e1de11cc@csihq.com>
From: "Mike Black" <mblack@csihq.com>
To: "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>
Cc: "raid" <linux-raid@vger.kernel.org>
Subject: 2.2.6-pre6 ext3
Date: Thu, 28 Jun 2001 08:39:47 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.2.6-pre6 with ext3-2.4-0.0.8-246p5
System is a dual PIII/1Ghz 2G memory
Qlogic 2100 Fibre Channel

This is on a raid5 -- since both linux version and ext3 were changes not
sure which is the cause yet.  I'm waiting for resync to finish to try it on
ext2.
tiobench.pl --size 4000
Size is MB, BlkSz is Bytes, Read, Write, and Seeks are MB/secd . -T

         File   Block  Num  Seq Read    Rand Read   Seq Write  Rand Write
  Dir    Size   Size   Thr Rate (CPU%) Rate (CPU%) Rate (CPU%) Rate (CPU%)
------- ------ ------- --- ----------- ----------- ----------- -----------
   .     4000   4096    1  69.09 73.2% 0.909 1.74% 25.75 94.8% 1.247 0.63%
   .     4000   4096    2  23.53 24.4% 1.001 1.63% 25.83 103.% 1.241 0.71%
   .     4000   4096    4  20.07 21.1% 1.157 2.04% 27.32 98.7% 1.233 1.00%
Run #1: /usr/local/bin/tiotest -t 8 -f 500 -r 500 -b 4096 -d . -T
Message from syslogd@yeti at Thu Jun 28 08:11:08 2001 ...
yeti kernel: JBD: out of memory for journal_head

System locked up hard.

This same test was run multiple times on 2.2.5 without ext3 with much better
results too:
Done 6/7/01
Linux yeti 2.4.5 #2 SMP Sat May 26 07:13:52 EDT 2001 i686 unknown
root@yeti:/usr5# tiobench.pl --size 4000
Size is MB, BlkSz is Bytes, Read, Write, and Seeks are MB/secd . -T

         File   Block  Num  Seq Read    Rand Read   Seq Write  Rand Write
  Dir    Size   Size   Thr Rate (CPU%) Rate (CPU%) Rate (CPU%) Rate (CPU%)
------- ------ ------- --- ----------- ----------- ----------- -----------
   .     4000   4096    1  81.48 65.7% 0.499 0.54% 34.33 24.0% 1.481 1.51%
   .     4000   4096    2  77.10 77.2% 0.643 0.96% 33.04 23.6% 1.493 1.81%
   .     4000   4096    4  67.18 72.4% 0.797 1.39% 28.03 20.8% 1.494 1.94%
   .     4000   4096    8  58.29 66.2% 0.954 1.95% 24.89 19.8% 1.498 2.15%


________________________________________
Michael D. Black   Principal Engineer
mblack@csihq.com  321-676-2923,x203
http://www.csihq.com  Computer Science Innovations
http://www.csihq.com/~mike  My home page
FAX 321-676-2355

