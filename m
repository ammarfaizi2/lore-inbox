Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319268AbSHNTQP>; Wed, 14 Aug 2002 15:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319269AbSHNTQP>; Wed, 14 Aug 2002 15:16:15 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:16320 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP
	id <S319268AbSHNTQN>; Wed, 14 Aug 2002 15:16:13 -0400
Subject: Performance differences for recent kernels running forky test.
From: Steven Cole <elenstev@mesatop.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 14 Aug 2002 13:17:10 -0600
Message-Id: <1029352630.14756.140.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I ran the following lots_of_forks.sh script for several kernels.

http://people.nl.linux.org/~phillips/patches/lots_of_forks.sh

using time -v sh lots_of_forks.sh

The results for 2.4.20-pre2 and 2.4.20-pre2-ac1 are very different.

2.4.20-pre2:
Command being timed: "sh lots_of_forks.sh"
User time (seconds): 18.15
System time (seconds): 24.96
Percent of CPU this job got: 181%
Elapsed (wall clock) time (h:mm:ss or m:ss): 0:23.71

2.4.20-pre2-ac1:
Command being timed: "sh lots_of_forks.sh"
User time (seconds): 28.04
System time (seconds): 53.18
Percent of CPU this job got: 187%
Elapsed (wall clock) time (h:mm:ss or m:ss): 0:43.32

I ran this test 8 times in a row with no pause in between
runs. The numbers are System time as reported by time -v.
The test machine is 2-way p3, SMP kernels, configured the
same, no tweaks to /proc/sys/vm.

	2.4.20-pre2	2.4.20-pre2-ac1	2.5.28		2.5.31

1	24.96		53.18		39.91		37.04
2	24.92		52.42		44.91		45.88
3	24.69		50.69		48.63		44.89
4	24.39		51.9		58.12		55.8
5	24.72		46.14		49.81		43.18
6	24.34		47.99		57.62		40.93
7	24.64		52.33		50.42		47.27
8	24.53		52.84		45		36.49

This may be a very unfair benchmark. Or it may show something
worth investigating further.

Steven





