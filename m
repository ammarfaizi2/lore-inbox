Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265700AbTBKJ23>; Tue, 11 Feb 2003 04:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267334AbTBKJ23>; Tue, 11 Feb 2003 04:28:29 -0500
Received: from mail025.syd.optusnet.com.au ([210.49.20.147]:20422 "EHLO
	mail025.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S265700AbTBKJ22>; Tue, 11 Feb 2003 04:28:28 -0500
From: Con Kolivas <ckolivas@yahoo.com.au>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.5.60 with contest
Date: Tue, 11 Feb 2003 20:38:12 +1100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200302112036.38710.ckolivas@yahoo.com.au>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a set of contest benchmarks using the osdl hardware comparing 2.5.60 to 
59

no_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.59              3   79      93.7    0.0     0.0     1.00
2.5.60              2   79      94.9    0.0     0.0     1.00
cacherun:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.59              3   76      97.4    0.0     0.0     0.96
2.5.60              2   75      98.7    0.0     0.0     0.95
process_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.59              3   92      81.5    29.7    17.4    1.16
2.5.60              2   93      80.6    30.5    17.2    1.18
ctar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.59              3   98      80.6    2.0     5.1     1.24
2.5.60              2   99      78.8    1.0     4.0     1.25
xtar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.59              3   102     74.5    1.0     3.9     1.29
2.5.60              2   101     76.2    1.0     5.0     1.28
io_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.59              3   152     50.0    34.1    13.1    1.92
2.5.60              2   139     54.7    29.0    12.1    1.76
io_other:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.59              3   89      84.3    11.2    5.6     1.13
2.5.60              2   90      83.3    10.8    5.5     1.14
read_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.59              3   101     77.2    6.5     5.0     1.28
2.5.60              2   103     74.8    6.2     6.8     1.30
list_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.59              3   95      80.0    0.0     6.3     1.20
2.5.60              2   95      80.0    0.0     6.3     1.20
mem_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.59              3   95      82.1    52.7    2.1     1.20
2.5.60              2   98      79.6    53.0    2.0     1.24

well I don't see much difference. interestingly dbench_load wouldnt give me a 
number because dbench never quite started - a whole swag of processes visible 
but not doing anything (must be related to that oops I sent out with respect 
to dbench running on mm10). Previous runs of dbench_load may have been 
working because 0.6x releases of contest use dbench 4*num_cpus instead of 
16*num_cpus which I am using in the development version. 

Might give the cfq scheduler a go

Con
