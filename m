Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261987AbSIYOhI>; Wed, 25 Sep 2002 10:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261988AbSIYOhI>; Wed, 25 Sep 2002 10:37:08 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:12972 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S261987AbSIYOhH>;
	Wed, 25 Sep 2002 10:37:07 -0400
Message-ID: <1032964936.3d91cb48b1cca@kolivas.net>
Date: Thu, 26 Sep 2002 00:42:16 +1000
From: Con Kolivas <conman@kolivas.net>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@digeo.com>
Subject: [BENCHMARK] fork_load module tested for contest
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I've been trialling a new load module for the contest benchmark
(http://contest.kolivas.net) which simply forks a process that does nothing,
waits for it to die, then repeats. Here are the results I have obtained so far:

noload:
Kernel                  Time            CPU             Ratio
2.4.19                  72.90           99%             1.00
2.4.19-ck7              71.55           100%            0.98
2.5.38                  73.86           99%             1.01
2.5.38-mm2              73.93           99%             1.01

fork_load:
Kernel                  Time            CPU             Ratio
2.4.19                  100.05          69%             1.37
2.4.19-ck7              74.65           95%             1.02
2.5.38                  77.35           95%             1.06
2.5.38-mm2              76.99           95%             1.06

ck7 uses O1, preempt, low latency
Preempt=N for all other kernels

Clearly you can see the 2.5 kernels have a substantial lead over the current
stable kernel.

This load module is not part of the contest package yet. I could certainly
change it to fork n processes but I'm not really sure just how many n should be.

Comments?

Con Kolivas

P.S. Results have negligible differences on repeat testing.
