Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267115AbSLRCL5>; Tue, 17 Dec 2002 21:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267117AbSLRCL4>; Tue, 17 Dec 2002 21:11:56 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:47120
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S267115AbSLRCLy>; Tue, 17 Dec 2002 21:11:54 -0500
Date: Tue, 17 Dec 2002 18:17:51 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
cc: linux-ide@vger.kernel.org
Subject: Serial ATA: SiI3112 numbers, Linux-Raid 1
Message-ID: <Pine.LNX.4.10.10212171727400.31876-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just for kicks!

[root@athy tiobench-0.3.2]# ./tiobench.pl
No size specified, using 512 MB
Size is MB, BlkSz is Bytes, Read, Write, and Seeks are MB/sec

         File   Block  Num  Seq Read    Rand Read   Seq Write  Rand Write
  Dir    Size   Size   Thr Rate (CPU%) Rate (CPU%) Rate (CPU%) Rate (CPU%)
------- ------ ------- --- ----------- ----------- ----------- -----------
   .     512    4096    1  38.60 20.2% 0.844 0.97% 32.85 34.4% 1.090 0.90%
   .     512    4096    2  26.20 16.6% 0.973 1.05% 28.52 47.5% 1.099 0.98%
   .     512    4096    4  22.98 15.6% 1.070 1.07% 24.53 45.0% 1.098 1.26%
   .     512    4096    8  21.52 15.9% 1.168 1.06% 20.27 39.1% 1.097 1.52%

[root@athy /]# bonnie -s 512
File './Bonnie.19851', size: 536870912, volumes: 1
Writing with putc()...  done:  13038 kB/s  99.8 %CPU
Rewriting...            done:  15274 kB/s  12.9 %CPU
Writing intelligently...done:  44931 kB/s  43.8 %CPU
Reading with getc()...  done:  12038 kB/s  95.0 %CPU
Reading intelligently...done:  66362 kB/s  32.5 %CPU
Seeker 1...Seeker 2...Seeker 3...start 'em...done...done...done...
            ---Sequential Output (nosync)--- ---Sequential Input-- --Rnd Seek-
            -Per Char- --Block--- -Rewrite-- -Per Char- --Block--- --04k (03)-
Machine  MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU   /sec %CPU
     1* 512 13038 99.8 44931 43.8 15274 12.9 12038 95.0 66362 32.5  305.7  4.1

[root@athy /]# bonnie -s 1024
File './Bonnie.19858', size: 1073741824, volumes: 1
Writing with putc()...  done:  13023 kB/s 100.0 %CPU
Rewriting...            done:  15114 kB/s  13.9 %CPU
Writing intelligently...done:  39051 kB/s  40.2 %CPU
Reading with getc()...  done:  12158 kB/s  96.3 %CPU
Reading intelligently...done:  53235 kB/s  28.3 %CPU
Seeker 1...Seeker 2...Seeker 3...start 'em...done...done...done...
            ---Sequential Output (nosync)--- ---Sequential Input-- --Rnd Seek-
            -Per Char- --Block--- -Rewrite-- -Per Char- --Block--- --04k (03)-
Machine  MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU   /sec %CPU
     1*1024 13023 100.0 39051 40.2 15114 13.9 12158 96.3 53235 28.3  210.7  2.1

Cheers,

Andre Hedrick
LAD Storage Consulting Group

