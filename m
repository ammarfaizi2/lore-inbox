Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312337AbSCYTa7>; Mon, 25 Mar 2002 14:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312427AbSCYTau>; Mon, 25 Mar 2002 14:30:50 -0500
Received: from elin.scali.no ([62.70.89.10]:9483 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S312353AbSCYTam>;
	Mon, 25 Mar 2002 14:30:42 -0500
Date: Mon, 25 Mar 2002 20:30:41 +0100 (CET)
From: Steffen Persvold <sp@scali.com>
To: <linux-kernel@vger.kernel.org>
Subject: Network performance i 2.4.18 compared to 2.4.17
Message-ID: <Pine.LNX.4.30.0203252020410.29933-100000@elin.scali.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi folks,

I've developed a network driver ontop of SCI. Now I've detected something
wierd. Network performance, both UDP and TCP, measured with netperf is a
little lower i 2.4.18 than in 2.4.17. The machines I'm running my tests on
is Dual Athlon MP 1900 (1.6 GHz) in a Tyan Tiger MPX (S2566) board. Kernel
configs on both 2.4.17 and 2.4.18 is excactly the same and its configured
with cpu type K7.

Here are the numbers :

2.4.18 kernel :

TCP STREAM TEST to sci5
Recv   Send    Send
Socket Socket  Message  Elapsed
Size   Size    Size     Time     Throughput
bytes  bytes   bytes    secs.    MBytes/sec

524288 524288 524288    9.99      175.87

UDP UNIDIRECTIONAL SEND TEST to sci5
Socket  Message  Elapsed      Messages
Size    Size     Time         Okay Errors   Throughput
bytes   bytes    secs            #      #   MBytes/sec

262144   32768   9.99        63054      0     197.22
262144           9.99        63054            197.22


and on 2.4.17 kernel :

TCP STREAM TEST to sci5
Recv   Send    Send
Socket Socket  Message  Elapsed
Size   Size    Size     Time     Throughput
bytes  bytes   bytes    secs.    MBytes/sec

524288 524288 524288    10.00     182.92

UDP UNIDIRECTIONAL SEND TEST to sci5
Socket  Message  Elapsed      Messages
Size    Size     Time         Okay Errors   Throughput
bytes   bytes    secs            #      #   MBytes/sec

262144   32768   10.00       64359      0     201.20
262144           10.00       64359            201.20


Roughly 2% lower performance on UDP and 4% on TCP. Any explaination for
this ?

Thanks in advance.

Regards,
-- 
  Steffen Persvold   | Scalable Linux Systems |   Try out the world's best
 mailto:sp@scali.com |  http://www.scali.com  | performing MPI implementation:
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 1.13.8 -
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >320MBytes/s and <4uS latency

