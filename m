Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311872AbSCOHwo>; Fri, 15 Mar 2002 02:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311877AbSCOHwY>; Fri, 15 Mar 2002 02:52:24 -0500
Received: from idefix.linkvest.com ([194.209.53.99]:33033 "EHLO
	idefix.linkvest.com") by vger.kernel.org with ESMTP
	id <S311872AbSCOHwO>; Fri, 15 Mar 2002 02:52:14 -0500
Message-ID: <3C91A822.7030304@linkvest.com>
Date: Fri, 15 Mar 2002 08:52:02 +0100
From: Jean-Eric Cuendet <jean-eric.cuendet@linkvest.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: UNIX bench better on 2.2 than 2.4?
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Mar 2002 07:52:03.0229 (UTC) FILETIME=[4B8204D0:01C1CBF6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I forgot to give kernel versions...

Hi,
I ran UNIX bench on 4 of our machines. The results are below.
What is strange is that 2.2 makes better than 2.4! Is it a known fact?
And is the UNIX bench better with 2 CPU?
-jec

Results:
Host1: 2xPIII 550MHz / 1Gb RAM / RAID5 SCSI / 2.4.6smp + LVM
       Result: 164.7
Host2: 2xPIII 866MHz / 1Gb RAM / RAID1 soft IDE / 2.4.16smp + LVM
       Result: 195.7
Host3: 1xPIII 800MHz / 512Mb RAM / IDE / 2.2.19 RedHat 6.2
       Result: 208.6
Host4: 1xPIII 600MHz / 256Mb RAM / IDE / 2.4.19-pre2-ac4-preempt
       Result: 153.6


Host1:
Dhrystone 2 using register variables        116700.0  1139475.0       97.6
Double-Precision Whetstone                      55.0      295.2       53.7
Execl Throughput                                43.0      697.7      162.3
File Copy 1024 bufsize 2000 maxblocks         3960.0    83438.0      210.7
File Copy 256 bufsize 500 maxblocks           1655.0    38613.0      233.3
File Copy 4096 bufsize 8000 maxblocks         5800.0   121259.0      209.1
Pipe Throughput                              12440.0   254518.7      204.6
Process Creation                               126.0     1831.7      145.4
Shell Scripts (8 concurrent)                     6.0      201.7      336.2
System Call Overhead                         15000.0   251716.1      167.8
                                                                   =========
       FINAL SCORE                                                     164.7



Host2:
Dhrystone 2 using register variables        116700.0  1837005.3      157.4
Double-Precision Whetstone                      55.0      478.4       87.0
Execl Throughput                                43.0      923.8      214.8
File Copy 1024 bufsize 2000 maxblocks         3960.0    54663.0      138.0
File Copy 256 bufsize 500 maxblocks           1655.0    18601.0      112.4
File Copy 4096 bufsize 8000 maxblocks         5800.0    96807.0      166.9
Pipe Throughput                              12440.0   399294.5      321.0
Process Creation                               126.0     3503.8      278.1
Shell Scripts (8 concurrent)                     6.0      277.0      461.7
System Call Overhead                         15000.0   393738.7      262.5
                                                                   =========
       FINAL SCORE                                                     195.7



Host3:
Dhrystone 2 using register variables        116700.0  1506306.9      129.1
Double-Precision Whetstone                      55.0      364.4       66.3
Execl Throughput                                43.0     1103.3      256.6
File Copy 1024 bufsize 2000 maxblocks         3960.0   110403.0      278.8
File Copy 256 bufsize 500 maxblocks           1655.0    53065.0      320.6
File Copy 4096 bufsize 8000 maxblocks         5800.0   151107.0      260.5
Pipe Throughput                              12440.0   378679.6      304.4
Pipe-based Context Switching                  4000.0   161272.9      403.2
Process Creation                               126.0     7144.7      567.0
Shell Scripts (8 concurrent)                     6.0       20.0       33.3
System Call Overhead                         15000.0   412399.5      274.9
                                                                   =========
       FINAL SCORE                                                     208.6



Host4:
Dhrystone 2 using register variables        116700.0  1099714.7       94.2
Double-Precision Whetstone                      55.0      328.1       59.7
Execl Throughput                                43.0      692.1      161.0
File Copy 1024 bufsize 2000 maxblocks         3960.0    56029.0      141.5
File Copy 256 bufsize 500 maxblocks           1655.0    18783.0      113.5
File Copy 4096 bufsize 8000 maxblocks         5800.0    96243.0      165.9
Pipe Throughput                              12440.0   306228.7      246.2
Process Creation                               126.0     3937.3      312.5
Shell Scripts (8 concurrent)                     6.0      125.9      209.8
System Call Overhead                         15000.0   282470.2      188.3
                                                                   =========
       FINAL SCORE                                                     153.6


-- 
Jean-Eric Cuendet
Linkvest SA
Av des Baumettes 19, 1020 Renens Switzerland
Tel +41 21 632 9043  Fax +41 21 632 9090
E-mail: jean-eric.cuendet@linkvest.com
http://www.linkvest.com
--------------------------------------------------------




