Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbTH3Ipv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 04:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262945AbTH3Ipu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 04:45:50 -0400
Received: from mail.szintezis.hu ([195.56.253.241]:49954 "HELO
	hold.szintezis.hu") by vger.kernel.org with SMTP id S261686AbTH3Ipq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 04:45:46 -0400
Subject: [FS Benchmark] reiser4 vs. reiserfs (3.6)
From: Gabor MICSKO <gmicsko@szintezis.hu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.5 
Date: 30 Aug 2003 10:45:53 +0200
Message-Id: <1062233153.499.15.camel@sunshine>
Mime-Version: 1.0
X-OriginalArrivalTime: 30 Aug 2003 08:45:44.0757 (UTC) FILETIME=[19DCEE50:01C36ED3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel: 2.6.0-test4 SMP

reiser4 snap:
http://thebsh.namesys.com/snapshots/2003.08.26/reiser4.diff

reiser4progs:
http://thebsh.namesys.com/snapshots/2003.08.26/reiser4progs-20030826.tar.gz

Benchmark tool:
http://h2np.net/tools/fs-bench.tar.gz

Harware:

CPU: Intel Pentium 4 at 3.06GHZ HT enabled
RAM: 512MB
Disk: Seagate ST320410A 

Test 1:
-------

Filesystem: 2GB reiser4 (/dev/hdd1), mounted to /mnt/reiser4

sunshine:/mnt/reiser4# ~/fs-bench/test.sh 2>&1 | tee ~/fs-bench/reiser4
## Start Test
2003. aug. 28., csütörtök, 20.37.11 CEST
1062095831

## Create files

Total create files: 18858
000049f3: No space left on device
Create files

real 1m7.309s
user 0m0.141s
sys 0m9.571s

## tar all

## Change owner

real 0m1.597s
user 0m0.021s
sys 0m0.209s

## random access
Success: 18858
Fail: 72

real 4m27.653s
user 0m0.292s
sys 0m6.247s

## Change mode

real 0m4.103s
user 0m0.033s
sys 0m0.436s

## Random delete and create
Total create files: 8271
Total delete files: 8393
Total error : 2266

real 2m7.920s
user 0m0.123s
sys 0m6.025s

## Change mode again

real 0m0.438s
user 0m0.026s
sys 0m0.243s

## Remove all files and directories

real 0m1.299s
user 0m0.029s
sys 0m1.178s

## Finish test
1062096367
2003. aug. 28., csütörtök, 20.46.07 CEST
sunshine:/mnt/reiser4#

Test 2:
-------

Filesystem: 2GB reiserfs (/dev/hdd1), mounted to /mnt/reiser3

sunshine:/mnt/reiser3# ~/fs-bench/test.sh 2>&1 | tee ~/fs-bench/reiser3
## Start Test
2003. aug. 28., csütörtök, 20.50.58 CEST
1062096658

## Create files

Total create files: 19491
00004c6f: No space left on device
Create files

real 1m11.586s
user 0m0.085s
sys 0m6.181s

## tar all

## Change owner

real 0m1.583s
user 0m0.010s
sys 0m0.145s

## random access
Success: 19477
Fail: 90

real 5m56.516s
user 0m0.230s
sys 0m4.311s

## Change mode

real 0m0.820s
user 0m0.019s
sys 0m0.227s

## Random delete and create
Total create files: 8612
Total delete files: 8700
Total error : 2255

real 1m33.936s
user 0m0.085s
sys 0m4.342s

## Change mode again

real 0m0.229s
user 0m0.010s
sys 0m0.136s

## Remove all files and directories

real 0m21.887s
user 0m0.014s
sys 0m1.251s

## Finish test
1062097334
2003. aug. 28., csütörtök, 21.02.14 CEST
sunshine:/mnt/reiser3#



-- 
Windows not found
(C)heers, (P)arty or (D)ance?
-----------------------------------
Micskó Gábor
Compaq Accredited Platform Specialist, System Engineer (APS, ASE)
Szintézis Computer Rendszerház Rt.      
H-9021 Gyõr, Tihanyi Árpád út 2.
Tel: +36-96-502-216
Fax: +36-96-318-658
E-mail: gmicsko@szintezis.hu
Web: http://www.hup.hu/

