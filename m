Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318013AbSIOKzZ>; Sun, 15 Sep 2002 06:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318014AbSIOKzZ>; Sun, 15 Sep 2002 06:55:25 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:947 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S318013AbSIOKzY>;
	Sun, 15 Sep 2002 06:55:24 -0400
Message-ID: <1032087616.3d846840e6eb1@kolivas.net>
Date: Sun, 15 Sep 2002 21:00:16 +1000
From: Con Kolivas <conman@kolivas.net>
To: linux-kernel@vger.kernel.org
Cc: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
Subject: Revealing benchmarks and new version of contest.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



After my first incarnation of the responsiveness benchmark (contest), Rik helped
me get the memory load working for 2.5.x testing. Now Andrew Morton has helped
me improve the IO load. The previous IO load was "nice" to VM systems. Now for
IO load there are two separate tests. First it continually rewrites a file half
the size of the physical memory on the machine. Secondly it rewrites a file the
same size as the physical memory. Below are the new benchmarks with these loads:

Noload:
Kernel                  Time            CPU
2.4.19-ck7              1:07.74         99%
2.4.19                  1:14.00         99%
2.5.34(-mm4)            1:09.61         99%
2.4.19-ck7-rmap         1:08.50         99%
2.4.20-pre7             1:08.00         99%
2.5.34                  1:09.70         99%

CPU Load:
Kernel                  Time            CPU
2.4.19-ck7              1:10.39         93%
2.4.19                  1:27.94         80%
2.5.34(-mm4)            1:11.42         94%
2.4.19-ck7-rmap         1:11.32         92%
2.4.20-pre7             1:21.91         80%
2.5.34                  1:11.46         94%

Mem Load:
Kernel                  Time            CPU
2.4.19-ck7              1:11.10         93%
2.4.19                  1:33.69         77%
2.5.34(-mm4)            1:24.03         83%
2.4.19-ck7-rmap         1:35.30         71%
2.4.20-pre7             1:26.39         78%
2.5.34                  1:25.54         81%

IO Load Half:
Kernel                  Time            CPU
2.4.19-ck7              1:26.22         78%
2.4.19                  2:16.66         56%
2.5.34(-mm4)            4:30.70         28%
2.4.19-ck7-rmap         1:22.90         84%
2.4.20-pre7             2:25.78         48%
2.5.34                  1:23.67         82%

IO Load Full:
Kernel                  Time            CPU
2.4.19-ck7              2:34.04         43%
2.4.19                  3:14.52         40%
2.5.34(-mm4)            14:59.79        8%
2.4.19-ck7-rmap         1:32.34         74%
2.4.20-pre7             3:37.75         32%
2.5.34                  1:49.62         63%

A quick reminder. Faster times are better, and higher cpu% is also better.

As you can see there are stark differences in these kernels, particularly the
mm4 changes. This time the -rmap VM shows us significant improvement under very
heavy IO load. Repeat tests show similar results.

The updated version of contest (v0.20) can be downloaded from my site:
http://kernel.kolivas.net (look under the FAQ).

Comments (and please cc me)?
Con.

P.S. !
