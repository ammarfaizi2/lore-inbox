Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276545AbRJUSlk>; Sun, 21 Oct 2001 14:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276538AbRJUSlb>; Sun, 21 Oct 2001 14:41:31 -0400
Received: from mtiwmhc26.worldnet.att.net ([204.127.131.51]:49063 "EHLO
	mtiwmhc26.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S276535AbRJUSlV>; Sun, 21 Oct 2001 14:41:21 -0400
Date: Sun, 21 Oct 2001 14:41:44 -0400
From: khromy <khromy@lnuxlab.ath.cx>
To: linux-kernel@vger.kernel.org
Subject: 2.4.13pre5aa1
Message-ID: <20011021144144.A29415@lnuxlab.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some numbers on the VM, pre5aa1 was swapping a lot when using it with
my normal load(which is gaim, xchat, gkrellm, opera, mozilla, mysql) but the
following made it better.

echo 6 > /proc/sys/vm/vm_scan_ratio
echo 2 > /proc/sys/vm/vm_mapped_ratio
echo 4 > /proc/sys/vm/vm_balance_ratio

========================================

2.4.13-pre5aa1

./fillmem
0.860u 1.040s 0:01.91 99.4%     0+0k 0+0io 96pf+0w
0.780u 1.200s 0:01.92 103.1%    0+0k 0+0io 96pf+0w
0.890u 1.090s 0:01.92 103.1%    0+0k 0+0io 96pf+0w


./dbench 5
5 clients started
.........................................................................................................
................................................................................+++++*****
Throughput 31.2004 MB/sec (NB=39.0005 MB/sec  312.004 MBit/sec)  5 procs

./dbench 10
..........10 clients started
.........................................................................................................
.........................................................................................................
.............................................................................................+...........
..............................................+++++++++**********
Throughput 21.6991 MB/sec (NB=27.1239 MB/sec  216.991 MBit/sec)  10 procs

========================================

2.4.12-ac3-vmpatch-freeswap

./fillmem
0.850u 0.930s 0:02.09 85.1%     0+0k 0+0io 94pf+0w
0.800u 0.940s 0:02.08 83.6%     0+0k 0+0io 94pf+0w
0.810u 1.060s 0:02.12 88.2%     0+0k 0+0io 94pf+0w

./dbench 5
5 clients started
...............................................................................................................................................................................+......+...++.+*****
Throughput 13.2336 MB/sec (NB=16.542 MB/sec  132.336 MBit/sec)  5 procs

./dbench 10
..........10 clients started
....................................................................................................................................................................................................................................................................................................................................................++..+....+.+.........+..+..+++**********
Throughput 11.5991 MB/sec (NB=14.4989 MB/sec  115.991 MBit/sec)  10 procs


-- 
L1:	khromy		;khromy at lnuxlab.ath.cx
