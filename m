Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318297AbSIEWFz>; Thu, 5 Sep 2002 18:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318304AbSIEWFy>; Thu, 5 Sep 2002 18:05:54 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:34795 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S318297AbSIEWEt>; Thu, 5 Sep 2002 18:04:49 -0400
Message-ID: <20020905220919.14832.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Fri, 06 Sep 2002 06:09:18 +0800
Subject: BYTE UNIX Benchmarks (Version 4.1.0)
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I'm back with the results of BYTE UNIX Benchmarks (Version 4.1.0) against:
2.4.19
2.5.33
2.4.20-pre5aa1 

The baseline is _always_ 2.4.19.

Following the 2.5.33 results:

  BYTE UNIX Benchmarks (Version 4.1.0)
  System -- Linux localhost.localdomain 2.5.33 #32 Tue Sep 3 22:18:19 BST 2002 i686 unknown
  Start Benchmark Run: Thu Sep  5 21:19:59 BST 2002
   1 interactive users.
    9:19pm  up 0 min,  1 user,  load average: 0.23, 0.07, 0.02
  lrwxrwxrwx    1 root     root            4 Jul 11 21:33 /bin/sh -> bash
  /bin/sh: symbolic link to bash
  /dev/hda6              3817344   2593416   1030016  72% /
Dhrystone 2 using register variables     1652853.2 lps   (10.0 secs, 10 samples)
Double-Precision Whetstone                  434.6 MWIPS (10.0 secs, 10 samples)
System Call Overhead                     413117.8 lps   (10.0 secs, 10 samples)
Pipe Throughput                          441098.3 lps   (10.0 secs, 10 samples)
Pipe-based Context Switching             155010.2 lps   (10.0 secs, 10 samples)
Process Creation                           5950.9 lps   (30.0 secs, 3 samples)
Execl Throughput                            777.5 lps   (30.0 secs, 3 samples)
File Read 1024 bufsize 2000 maxblocks    195816.0 KBps  (30.0 secs, 3 samples)
File Write 1024 bufsize 2000 maxblocks   130311.0 KBps  (30.0 secs, 3 samples)
File Copy 1024 bufsize 2000 maxblocks     92450.0 KBps  (30.0 secs, 3 samples)
File Read 256 bufsize 500 maxblocks      137056.0 KBps  (30.0 secs, 3 samples)
File Write 256 bufsize 500 maxblocks      74688.0 KBps  (30.0 secs, 3 samples)
File Copy 256 bufsize 500 maxblocks       45020.0 KBps  (30.0 secs, 3 samples)
File Read 4096 bufsize 8000 maxblocks    197072.0 KBps  (30.0 secs, 3 samples)
File Write 4096 bufsize 8000 maxblocks   162400.0 KBps  (30.0 secs, 3 samples)
File Copy 4096 bufsize 8000 maxblocks    114654.0 KBps  (30.0 secs, 3 samples)
Shell Scripts (1 concurrent)                828.6 lpm   (60.0 secs, 3 samples)
Shell Scripts (8 concurrent)                119.0 lpm   (60.0 secs, 3 samples)
Shell Scripts (16 concurrent)                60.0 lpm   (60.0 secs, 3 samples)
Arithmetic Test (type = short)           201849.4 lps   (10.0 secs, 3 samples)
Arithmetic Test (type = int)             197399.3 lps   (10.0 secs, 3 samples)
Arithmetic Test (type = long)            198362.2 lps   (10.0 secs, 3 samples)
Arithmetic Test (type = float)           208790.7 lps   (10.0 secs, 3 samples)
Arithmetic Test (type = double)          208795.8 lps   (10.0 secs, 3 samples)
Arithoh                                  3634374.7 lps   (10.0 secs, 3 samples)
C Compiler Throughput                       452.3 lpm   (60.0 secs, 3 samples)
Dc: sqrt(2) to 99 decimal places          33276.4 lpm   (30.0 secs, 3 samples)
Recursion Test--Tower of Hanoi            28544.8 lps   (20.0 secs, 3 samples)


                     INDEX VALUES            
TEST                                        BASELINE     RESULT      INDEX

Arithmetic Test (type = double)             210515.1   208795.8        9.9
Arithmetic Test (type = float)              210516.4   208790.7        9.9
Arithmetic Test (type = int)                200121.7   197399.3        9.9
Arithmetic Test (type = long)               200131.7   198362.2        9.9
Arithmetic Test (type = short)              203544.0   201849.4        9.9
Arithoh                                    3664143.2  3634374.7        9.9
C Compiler Throughput                          469.7      452.3        9.6
Dc: sqrt(2) to 99 decimal places             42687.3    33276.4        7.8
Double-Precision Whetstone                     417.4      434.6       10.4
Execl Throughput                               975.8      777.5        8.0
File Copy 1024 bufsize 2000 maxblocks        80966.0    92450.0       11.4
File Copy 256 bufsize 500 maxblocks          35210.0    45020.0       12.8
File Copy 4096 bufsize 8000 maxblocks       105054.0   114654.0       10.9
File Read 1024 bufsize 2000 maxblocks       196639.0   195816.0       10.0
File Read 256 bufsize 500 maxblocks         140609.0   137056.0        9.7
File Read 4096 bufsize 8000 maxblocks       197578.0   197072.0       10.0
File Write 1024 bufsize 2000 maxblocks      106733.0   130311.0       12.2
File Write 256 bufsize 500 maxblocks         48994.0    74688.0       15.2
File Write 4096 bufsize 8000 maxblocks      130220.0   162400.0       12.5
Pipe-based Context Switching                223573.7   155010.2        6.9
Pipe Throughput                             477471.4   441098.3        9.2
Process Creation                              9119.5     5950.9        6.5
Shell Scripts (16 concurrent)                   69.0       60.0        8.7
System Call Overhead                        409831.4   413117.8       10.1
                                                                 =========
     FINAL SCORE                                                       9.9

And following the 2.4.20-pre5aa1 results:

  BYTE UNIX Benchmarks (Version 4.1.0)
  System -- Linux localhost.localdomain 2.4.20-pre5aa1 #21 Thu Sep 5 22:44:13 BST 2002 i686 unknown
  Start Benchmark Run: Thu Sep  5 22:52:20 BST 2002
   1 interactive users.
   10:52pm  up 0 min,  1 user,  load average: 0.19, 0.06, 0.02
  lrwxrwxrwx    1 root     root            4 Jul 11 21:33 /bin/sh -> bash
  /bin/sh: symbolic link to bash
  /dev/hda6              3817344   2624280    999152  73% /
Dhrystone 2 using register variables     1682300.5 lps   (10.0 secs, 10 samples)
Double-Precision Whetstone                  417.8 MWIPS (10.1 secs, 10 samples)
System Call Overhead                     411749.2 lps   (10.0 secs, 10 samples)
Pipe Throughput                          480723.5 lps   (10.0 secs, 10 samples)
Pipe-based Context Switching             227789.1 lps   (10.0 secs, 10 samples)
Process Creation                           9281.9 lps   (30.0 secs, 3 samples)
Execl Throughput                            933.3 lps   (29.7 secs, 3 samples)
File Read 1024 bufsize 2000 maxblocks    196276.0 KBps  (30.0 secs, 3 samples)
File Write 1024 bufsize 2000 maxblocks   137821.0 KBps  (30.0 secs, 3 samples)
File Copy 1024 bufsize 2000 maxblocks     98855.0 KBps  (30.0 secs, 3 samples)
File Read 256 bufsize 500 maxblocks      140402.0 KBps  (30.0 secs, 3 samples)
File Write 256 bufsize 500 maxblocks      84355.0 KBps  (30.0 secs, 3 samples)
File Copy 256 bufsize 500 maxblocks       51581.0 KBps  (30.0 secs, 3 samples)
File Read 4096 bufsize 8000 maxblocks    197291.0 KBps  (30.0 secs, 3 samples)
File Write 4096 bufsize 8000 maxblocks   139374.0 KBps  (30.0 secs, 3 samples)
File Copy 4096 bufsize 8000 maxblocks    107897.0 KBps  (30.0 secs, 3 samples)
Shell Scripts (1 concurrent)                915.3 lpm   (60.0 secs, 3 samples)
Shell Scripts (8 concurrent)                136.0 lpm   (60.0 secs, 3 samples)
Shell Scripts (16 concurrent)                69.0 lpm   (60.0 secs, 3 samples)
Arithmetic Test (type = short)           203506.7 lps   (10.0 secs, 3 samples)
Arithmetic Test (type = int)             200129.4 lps   (10.0 secs, 3 samples)
Arithmetic Test (type = long)            200123.6 lps   (10.0 secs, 3 samples)
Arithmetic Test (type = float)           210471.8 lps   (10.0 secs, 3 samples)
Arithmetic Test (type = double)          210513.7 lps   (10.0 secs, 3 samples)
Arithoh                                  3664144.7 lps   (10.0 secs, 3 samples)
C Compiler Throughput                       468.7 lpm   (60.0 secs, 3 samples)
Dc: sqrt(2) to 99 decimal places          42615.1 lpm   (30.0 secs, 3 samples)
Recursion Test--Tower of Hanoi            28605.8 lps   (20.0 secs, 3 samples)


                     INDE
