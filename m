Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269135AbSIRWCS>; Wed, 18 Sep 2002 18:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269172AbSIRWCS>; Wed, 18 Sep 2002 18:02:18 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:61672 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S269135AbSIRWCR>;
	Wed, 18 Sep 2002 18:02:17 -0400
Message-ID: <1032386838.3d88f9165a323@kolivas.net>
Date: Thu, 19 Sep 2002 08:07:18 +1000
From: Con Kolivas <conman@kolivas.net>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@digeo.com>
Subject: [BENCHMARK] contest results for 2.5.36-mm1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are the results with contest 0.34

NoLoad:
Kernel			Time		CPU
2.4.19			68.14		99%
2.4.20-pre7		68.11		99%
2.5.34			69.88		99%
2.5.36			69.58		99%
2.5.36-mm1		69.93		99%

Process Load:
Kernel			Time		CPU
2.4.19			81.10		80%
2.4.20-pre7		81.92		80%
2.5.34			71.39		94%
2.5.36			71.80		94%
2.5.36-mm1		71.48		94%

Mem Load:
Kernel			Time		CPU
2.4.19			92.49		77%
2.4.20-pre7		92.25		77%
2.5.34			138.05		54%
2.5.36			132.45		56%
2.5.36-mm1		104.57		71%

IO Half Mem:
Kernel			Time		CPU
2.4.19			99.41		70%
2.4.20-pre7		99.42		71%
2.5.34			74.31		93%
2.5.36			94.82		76%
2.5.36-mm1		85.63		85%

IO Full Mem:
Kernel			Time		CPU
2.4.19			173.00		41%
2.4.20-pre7		146.38		48%
2.5.34			74.00		94%
2.5.36			87.57		81%
2.5.36-mm1		262.07		27%

Log of 2.5.36:
noload Time: 69.58  CPU: 99%  Major Faults: 242825  Minor Faults: 292307
process_load Time: 71.80  CPU: 94%  Major Faults: 205009  Minor Faults: 256150
io_halfmem Time: 94.82  CPU: 76%  Major Faults: 204019  Minor Faults: 255214
Was writing number 6 of a 112Mb sized io_load file after 104 seconds
io_fullmem Time: 87.57  CPU: 81%  Major Faults: 204019  Minor Faults: 255312
Was writing number 3 of a 224Mb sized io_load file after 119 seconds
mem_load Time: 132.45  CPU: 56%  Major Faults: 204115  Minor Faults: 255234

Log of 2.5.36-mm1:
noload Time: 69.93  CPU: 99%  Major Faults: 250349  Minor Faults: 299716
process_load Time: 71.48  CPU: 94%  Major Faults: 205306  Minor Faults: 256259
io_halfmem Time: 85.63  CPU: 85%  Major Faults: 204019  Minor Faults: 255206
Was writing number 6 of a 112Mb sized io_load file after 93 seconds
io_fullmem Time: 262.07  CPU: 27%  Major Faults: 204019  Minor Faults: 255213
Was writing number 11 of a 224Mb sized io_load file after 279 seconds
mem_load Time: 104.57  CPU: 71%  Major Faults: 204093  Minor Faults: 255564

Test Machine:
1133Mhz PIII with 224 Mb Ram, single hard disk 5400rpm ATA5.

Big difference in both mem_load and IO load. Note the much larger number of
writes from IO_fullmem load, compared with a smaller number for IO_halfmem ?

http://contest.kolivas.net

Comments?
Con.
