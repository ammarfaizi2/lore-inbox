Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262373AbSI2CiI>; Sat, 28 Sep 2002 22:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262374AbSI2CiI>; Sat, 28 Sep 2002 22:38:08 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:2764 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S262373AbSI2CiH>;
	Sat, 28 Sep 2002 22:38:07 -0400
Message-ID: <1033267407.3d9668cf555f2@kolivas.net>
Date: Sun, 29 Sep 2002 12:43:27 +1000
From: Con Kolivas <conman@kolivas.net>
To: linux-kernel@vger.kernel.org
Subject: [BENCHMARK] Preempt effect on 2.5.39 with contest 0.41
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've performed some benchmarks with the latest contest v0.41
(http://contest.kolivas.net) to determine what effect preemptible has on these
benchmarks and whether contest has the ability to show any effect.

Here are the benchmarks:

noload:
Kernel                  Time            CPU             Ratio
2.5.39                  73.17           93%             1.08
2.5.39-pe               73.03           94%             1.08

process_load:
Kernel                  Time            CPU             Ratio
2.5.39                  91.0            76%             1.31*
2.5.39-pe               83.6            82%             1.23

io_load:
Kernel                  Time            CPU             Ratio
2.5.39                  226             37%             3.20
2.5.39-pe               234             34%             3.43

mem_load:
Kernel                  Time            CPU             Ratio
2.5.39                  103.72          72%             1.53
2.5.39-pe               103.95          73%             1.54

The only statistically significant difference was in process_load where enabling
preempt made it faster. Well duh, what else what you expect? At least we can see
it is having the desired effect and not detrimental to any other area, and that
contest is able to show this effect.

Average of 5 runs when difference was noted, simplified for clarity.

Con.
