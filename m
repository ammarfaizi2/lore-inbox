Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266754AbSIROle>; Wed, 18 Sep 2002 10:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266778AbSIROle>; Wed, 18 Sep 2002 10:41:34 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:55011 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S266754AbSIROlc>;
	Wed, 18 Sep 2002 10:41:32 -0400
Message-ID: <1032360386.3d8891c2bc3d3@kolivas.net>
Date: Thu, 19 Sep 2002 00:46:26 +1000
From: Con Kolivas <conman@kolivas.net>
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com, riel@conectiva.com.br
Subject: [BENCHMARK] contest results for 2.5.36
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are the latest results with 2.5.36 compared with 2.5.34

No Load:
Kernel			Time		CPU
2.4.19			68.14		99%
2.4.20-pre7		68.11		99%
2.5.34			69.88		99%
2.4.19-ck7		68.40		98%
2.4.19-ck7-rmap		68.73		99%
2.4.19-cc		68.37		99%
2.5.36			69.58		99%

Process Load:
Kernel			Time		CPU
2.4.19			81.10		80%
2.4.20-pre7		81.92		80%
2.5.34			71.39		94%
2.5.36			71.80		94%

Mem Load:
Kernel			Time		CPU
2.4.19			92.49		77%
2.4.20-pre7		92.25		77%
2.5.34			138.05		54%
2.5.36			132.45		56%

IO Halfmem Load:
Kernel			Time		CPU
2.4.19			99.41		70%
2.4.20-pre7		99.42		71%
2.5.34			74.31		93%
2.5.36			94.82		76%

IO Fullmem Load:
Kernel			Time		CPU
2.4.19			173.00		41%
2.4.20-pre7		146.38		48%
2.5.34			74.00		94%
2.5.36			87.57		81%


The full log for 2.5.34 is:

noload Time: 69.88  CPU: 99%  Major Faults: 247874  Minor Faults: 295941
process_load Time: 71.39  CPU: 94%  Major Faults: 204811  Minor Faults: 256001
io_halfmem Time: 74.31  CPU: 93%  Major Faults: 204019  Minor Faults: 255284
Was writing number 4 of a 112Mb sized io_load file after 76 seconds
io_fullmem Time: 74.00  CPU: 94%  Major Faults: 204019  Minor Faults: 255289
Was writing number 2 of a 224Mb sized io_load file after 98 seconds
mem_load Time: 138.05  CPU: 54%  Major Faults: 204107  Minor Faults: 255695


and for 2.5.36 is:

noload Time: 69.58  CPU: 99%  Major Faults: 242825  Minor Faults: 292307
process_load Time: 71.80  CPU: 94%  Major Faults: 205009  Minor Faults: 256150
io_halfmem Time: 94.82  CPU: 76%  Major Faults: 204019  Minor Faults: 255214
Was writing number 6 of a 112Mb sized io_load file after 104 seconds
io_fullmem Time: 87.57  CPU: 81%  Major Faults: 204019  Minor Faults: 255312
Was writing number 3 of a 224Mb sized io_load file after 119 seconds
mem_load Time: 132.45  CPU: 56%  Major Faults: 204115  Minor Faults: 255234


As you can see, going from 2.5.34 to 2.5.36 has had a minor improvement in
response under memory loading, but a drop in response under IO load. The log
shows more was written by the IO load during benchmarking in 2.5.36 The values
are different from the original 2.5.34 results I posted as there was a problem
with the potential for loads overlapping, and doing the memory load before
others made for heavy swapping afterwards.

contest has been upgraded to v0.34 with numerous small changes and a few fixes.
It can be downloaded here:

http://contest.kolivas.net

Comments?
Con.
