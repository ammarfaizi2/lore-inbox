Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277528AbRJVDpx>; Sun, 21 Oct 2001 23:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277529AbRJVDpn>; Sun, 21 Oct 2001 23:45:43 -0400
Received: from hawk.mail.pas.earthlink.net ([207.217.120.22]:45198 "EHLO
	hawk.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S277528AbRJVDpk>; Sun, 21 Oct 2001 23:45:40 -0400
From: rwhron@earthlink.net
Date: Sun, 21 Oct 2001 23:48:05 -0400
To: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.nnet
Subject: Knob turning on mtest01 for 2.4.13-pre5aa1
Message-ID: <20011021234805.A2824@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel	2.4.13-pre5aa1

Goal:	Measure the affect of changing new vm parameters.

Test:	Run 2 iterations each of LTP tests mtest01 and mmap001.
	mtest01 files 80% of virtual memory and writes to each page.
	mmap001 mmaps and writes to 100000 pages.
	listen to long playing (50+ minutes) mp3 sampled at 128k.
	page-cluster=2 for all tests.  (best value so far for 
	non-skipping mp3).

There was only a second or two of mp3 skipping throughout the entire test.

Pleasantly, one set of values came up on top for both tests, but the
overall variance isn't that large.  There could be several good values 
for these parameters.

mtest01 (2 iterations) with various settings of 2.4.13-pre5aa1 knobs:

105 seconds on mtest01 vm_balance_ratio = 16   vm_mapped_ratio = 1   vm_scan_ratio = 16
106 seconds on mtest01 vm_balance_ratio = 16   vm_mapped_ratio = 8   vm_scan_ratio = 16
106 seconds on mtest01 vm_balance_ratio = 4    vm_mapped_ratio = 8   vm_scan_ratio = 16
107 seconds on mtest01 vm_balance_ratio = 16   vm_mapped_ratio = 2   vm_scan_ratio = 8 
107 seconds on mtest01 vm_balance_ratio = 4    vm_mapped_ratio = 2   vm_scan_ratio = 8 
108 seconds on mtest01 vm_balance_ratio = 16   vm_mapped_ratio = 8   vm_scan_ratio = 6 
108 seconds on mtest01 vm_balance_ratio = 3    vm_mapped_ratio = 8   vm_scan_ratio = 16
108 seconds on mtest01 vm_balance_ratio = 4    vm_mapped_ratio = 2   vm_scan_ratio = 16
109 seconds on mtest01 vm_balance_ratio = 16   vm_mapped_ratio = 1   vm_scan_ratio = 6 
109 seconds on mtest01 vm_balance_ratio = 16   vm_mapped_ratio = 1   vm_scan_ratio = 8 
109 seconds on mtest01 vm_balance_ratio = 16   vm_mapped_ratio = 8   vm_scan_ratio = 8 
109 seconds on mtest01 vm_balance_ratio = 3    vm_mapped_ratio = 1   vm_scan_ratio = 16
110 seconds on mtest01 vm_balance_ratio = 16   vm_mapped_ratio = 2   vm_scan_ratio = 16
110 seconds on mtest01 vm_balance_ratio = 3    vm_mapped_ratio = 8   vm_scan_ratio = 6 
112 seconds on mtest01 vm_balance_ratio = 3    vm_mapped_ratio = 1   vm_scan_ratio = 8 
112 seconds on mtest01 vm_balance_ratio = 3    vm_mapped_ratio = 2   vm_scan_ratio = 16
113 seconds on mtest01 vm_balance_ratio = 4    vm_mapped_ratio = 1   vm_scan_ratio = 16
113 seconds on mtest01 vm_balance_ratio = 4    vm_mapped_ratio = 1   vm_scan_ratio = 8 
113 seconds on mtest01 vm_balance_ratio = 4    vm_mapped_ratio = 8   vm_scan_ratio = 6 
113 seconds on mtest01 vm_balance_ratio = 4    vm_mapped_ratio = 8   vm_scan_ratio = 8 
114 seconds on mtest01 vm_balance_ratio = 3    vm_mapped_ratio = 8   vm_scan_ratio = 8 
114 seconds on mtest01 vm_balance_ratio = 4    vm_mapped_ratio = 2   vm_scan_ratio = 6 
115 seconds on mtest01 vm_balance_ratio = 4    vm_mapped_ratio = 1   vm_scan_ratio = 6 
116 seconds on mtest01 vm_balance_ratio = 16   vm_mapped_ratio = 2   vm_scan_ratio = 6 
116 seconds on mtest01 vm_balance_ratio = 3    vm_mapped_ratio = 2   vm_scan_ratio = 8 
118 seconds on mtest01 vm_balance_ratio = 3    vm_mapped_ratio = 1   vm_scan_ratio = 6 
119 seconds on mtest01 vm_balance_ratio = 3    vm_mapped_ratio = 2   vm_scan_ratio = 6 

mmap001 (2 iterations) with various knob settings

63 seconds on mmap001 vm_balance_ratio = 16   vm_mapped_ratio = 1   vm_scan_ratio = 16
63 seconds on mmap001 vm_balance_ratio = 16   vm_mapped_ratio = 1   vm_scan_ratio = 8 
63 seconds on mmap001 vm_balance_ratio = 16   vm_mapped_ratio = 8   vm_scan_ratio = 16
63 seconds on mmap001 vm_balance_ratio = 3    vm_mapped_ratio = 1   vm_scan_ratio = 8 
63 seconds on mmap001 vm_balance_ratio = 3    vm_mapped_ratio = 2   vm_scan_ratio = 16
63 seconds on mmap001 vm_balance_ratio = 3    vm_mapped_ratio = 2   vm_scan_ratio = 8 
63 seconds on mmap001 vm_balance_ratio = 3    vm_mapped_ratio = 8   vm_scan_ratio = 6 
64 seconds on mmap001 vm_balance_ratio = 16   vm_mapped_ratio = 2   vm_scan_ratio = 16
64 seconds on mmap001 vm_balance_ratio = 16   vm_mapped_ratio = 2   vm_scan_ratio = 6 
64 seconds on mmap001 vm_balance_ratio = 16   vm_mapped_ratio = 2   vm_scan_ratio = 8 
64 seconds on mmap001 vm_balance_ratio = 16   vm_mapped_ratio = 8   vm_scan_ratio = 6 
64 seconds on mmap001 vm_balance_ratio = 16   vm_mapped_ratio = 8   vm_scan_ratio = 8 
64 seconds on mmap001 vm_balance_ratio = 3    vm_mapped_ratio = 1   vm_scan_ratio = 16
64 seconds on mmap001 vm_balance_ratio = 3    vm_mapped_ratio = 1   vm_scan_ratio = 6 
64 seconds on mmap001 vm_balance_ratio = 3    vm_mapped_ratio = 8   vm_scan_ratio = 8 
64 seconds on mmap001 vm_balance_ratio = 4    vm_mapped_ratio = 1   vm_scan_ratio = 16
64 seconds on mmap001 vm_balance_ratio = 4    vm_mapped_ratio = 1   vm_scan_ratio = 6 
64 seconds on mmap001 vm_balance_ratio = 4    vm_mapped_ratio = 1   vm_scan_ratio = 8 
64 seconds on mmap001 vm_balance_ratio = 4    vm_mapped_ratio = 2   vm_scan_ratio = 16
64 seconds on mmap001 vm_balance_ratio = 4    vm_mapped_ratio = 2   vm_scan_ratio = 6 
64 seconds on mmap001 vm_balance_ratio = 4    vm_mapped_ratio = 2   vm_scan_ratio = 8 
64 seconds on mmap001 vm_balance_ratio = 4    vm_mapped_ratio = 8   vm_scan_ratio = 16
64 seconds on mmap001 vm_balance_ratio = 4    vm_mapped_ratio = 8   vm_scan_ratio = 6 
64 seconds on mmap001 vm_balance_ratio = 4    vm_mapped_ratio = 8   vm_scan_ratio = 8 
65 seconds on mmap001 vm_balance_ratio = 3    vm_mapped_ratio = 2   vm_scan_ratio = 6 
65 seconds on mmap001 vm_balance_ratio = 3    vm_mapped_ratio = 8   vm_scan_ratio = 16
66 seconds on mmap001 vm_balance_ratio = 16   vm_mapped_ratio = 1   vm_scan_ratio = 6 

I'll run another test without mp3blaster playing, and a larger variety of values and
more iterations to see what changes.


scripty:


#!/bin/bash

# script to test VM kernel tweakables
#
# Uses "mtest01" memory test from Linux Test Project
#
# see: http://ltp.sourceforge.net/
#

# allocate p percent of virtual memory and write to each page.
# (write implied by -w option in mtest01)

# default /proc/sys/vm values in 2.4.13-pre5aa1
# vm_balance_ratio   32
# vm_mapped_ratio   8
# vm_scan_ratio   16
# page-cluster=3

# empirical tests shows page-cluster=2 is best for mp3blaster 
echo 2 > /proc/sys/vm/page-cluster

mtest01=/usr/src/sources/l/cvs/ltp/testcases/bin/mtest01
mmap001=/usr/src/sources/l/cvs/ltp/testcases/bin/mmap001
timing_log=$PWD/timing_log

# percent of virtual memory to fill
p=80

# 4096000000 bytes
pages=100000

vmstat_interval=2

for vm_balance_ratio in 3 4 16
do	for vm_mapped_ratio in 1 2 8
	do	for vm_scan_ratio in 8 6 16
		do
			kern="`uname -r`-vm_balance_ratio=${vm_balance_ratio}-vm_mapped_ratio=${vm_mapped_ratio}-vm_scan_ratio=${vm_scan_ratio}"
			mtest_log=mtest01-${kern}.log
			mmap001_log=mmap001-${kern}.log
			vmstat_log=vmstat-${kern}.log

			echo $vm_balance_ratio > /proc/sys/vm/vm_balance_ratio
			echo $vm_mapped_ratio > /proc/sys/vm/vm_mapped_ratio
			echo $vm_scan_ratio > /proc/sys/vm/vm_scan_ratio

			# iterations
			typeset -i i=2
			
			# watch memory usage
			vmstat $vmstat_interval > $vmstat_log &
			
			echo running $i iterations of $mtest01
			echo "vmstat log:  $vmstat_log"
			echo "mtest01 log: $mtest_log"
			SECONDS=0
			
			# mtest01
			while	((i > 0))
			do	/usr/bin/time -v $mtest01 -p $p -w
				((i--))
			done > $mtest_log  2>&1
			echo -n "$SECONDS seconds on mtest01 "
			printf "vm_balance_ratio = %-3d  vm_mapped_ratio = %-2d  vm_scan_ratio = %-2d\n" $vm_balance_ratio $vm_mapped_ratio $vm_scan_ratio
			sleep 2

			# reset i
			typeset -i i=2
			echo running $i iterations of $mmap001
			echo "mmap001 log: $mmap001_log"
			SECONDS=0

			# mmap001
			while	((i > 0))
			do	/usr/bin/time -v $mmap001 -m $pages
				((i--))
			done > $mmap001_log  2>&1
			echo -n "$SECONDS seconds on mmap001 "
			printf "vm_balance_ratio = %-3d  vm_mapped_ratio = %-2d  vm_scan_ratio = %-2d\n" $vm_balance_ratio $vm_mapped_ratio $vm_scan_ratio

			
			# kill vmstat 
			kill $!
			sleep 2
		done
	done
done  > $timing_log

-- 
Randy Hron

