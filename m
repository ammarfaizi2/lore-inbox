Return-Path: <linux-kernel-owner+w=401wt.eu-S1030626AbWLPGEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030626AbWLPGEP (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 01:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030628AbWLPGEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 01:04:14 -0500
Received: from smtp-vbr10.xs4all.nl ([194.109.24.30]:3435 "EHLO
	smtp-vbr10.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030626AbWLPGEN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 01:04:13 -0500
Date: Sat, 16 Dec 2006 07:03:29 +0100
From: thunder7@xs4all.nl
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, Neil Brown <neilb@suse.de>,
       Jurriaan <thunder7@xs4all.nl>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org, Tejun Heo <htejun@gmail.com>
Subject: Re: sata badness in 2.6.20-rc1? [Was: Re: md patches in -mm]
Message-ID: <20061216060328.GA9694@amd64.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <17780.63770.228659.234534@cse.unsw.edu.au> <20061205061623.GA13749@amd64.of.nowhere> <20061205062142.GA14784@amd64.of.nowhere> <20061204224323.2e5d0494.akpm@osdl.org> <20061205105928.GA6482@amd64.of.nowhere> <17782.28505.303064.964551@cse.unsw.edu.au> <20061215192146.GA3616@amd64.of.nowhere> <17795.2681.523120.656367@cse.unsw.edu.au> <20061215130552.95860b72.akpm@osdl.org> <4583183C.7000107@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4583183C.7000107@garzik.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Garzik <jeff@garzik.org>
Date: Fri, Dec 15, 2006 at 04:48:44PM -0500
> The "Re: Linux 2.6.20-rc1" sub-thread that had Jens and Alistair John 
> Strachan replying seemed to implicate some core block layer badness.
> 
The original problem (not mounting my raid6 partition) is observable in
2.6.20-rc1-mm1, but not in 2.6.20-rc1; ie. 2.6.20-rc1 is good for me.

Linux version 2.6.20-rc1 (jurriaan@middle) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #3 SMP Fri Dec 15 21:19:54 CET 2006
<snip>
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdh1 ...
md:  adding sdh1 ...
md:  adding sdg1 ...
md:  adding sdf1 ...
md:  adding sde1 ...
md:  adding sdd1 ...
md:  adding sdc1 ...
md:  adding sdb1 ...
md:  adding sda1 ...
md: hdc9 has different UUID to sdh1
md: hdc8 has different UUID to sdh1
md: hdc7 has different UUID to sdh1
md: hdc6 has different UUID to sdh1
md: hdc5 has different UUID to sdh1
md: hda9 has different UUID to sdh1
md: hda8 has different UUID to sdh1
md: hda7 has different UUID to sdh1
md: hda6 has different UUID to sdh1
md: hda5 has different UUID to sdh1
md: created md0
md: bind<sda1>
md: bind<sdb1>
md: bind<sdc1>
md: bind<sdd1>
md: bind<sde1>
md: bind<sdf1>
md: bind<sdg1>
md: bind<sdh1>
md: running: <sdh1><sdg1><sdf1><sde1><sdd1><sdc1><sdb1><sda1>
raid5: device sdh1 operational as raid disk 1
raid5: device sdg1 operational as raid disk 0
raid5: device sdf1 operational as raid disk 5
raid5: device sde1 operational as raid disk 6
raid5: device sdd1 operational as raid disk 7
raid5: device sdc1 operational as raid disk 3
raid5: device sdb1 operational as raid disk 2
raid5: device sda1 operational as raid disk 4
raid5: allocated 8462kB for md0
raid5: raid level 6 set md0 active with 8 out of 8 devices, algorithm 2
RAID5 conf printout:
 --- rd:8 wd:8
 disk 0, o:1, dev:sdg1
 disk 1, o:1, dev:sdh1
 disk 2, o:1, dev:sdb1
 disk 3, o:1, dev:sdc1
 disk 4, o:1, dev:sda1
 disk 5, o:1, dev:sdf1
 disk 6, o:1, dev:sde1
 disk 7, o:1, dev:sdd1
md0: bitmap initialized from disk: read 15/15 pages, set 1 bits, status: 0
created bitmap (233 pages) for device md0
md: considering hdc9 ...
md:  adding hdc9 ...
md: hdc8 has different UUID to hdc9
md: hdc7 has different UUID to hdc9
md: hdc6 has different UUID to hdc9
md: hdc5 has different UUID to hdc9
md:  adding hda9 ...
md: hda8 has different UUID to hdc9
md: hda7 has different UUID to hdc9
md: hda6 has different UUID to hdc9
md: hda5 has different UUID to hdc9
md: created md4
md: bind<hda9>
md: bind<hdc9>
md: running: <hdc9><hda9>
raid1: raid set md4 active with 2 out of 2 mirrors
md4: bitmap initialized from disk: read 10/10 pages, set 45 bits, status: 0
<snip>
EXT3 FS on md0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.

Jurriaan
-- 
And I thought that the Borg were bad...
Debian (Unstable) GNU/Linux 2.6.20-rc1 2x4023 bogomips load 5.55
the Jack Vance Integral Edition: http://www.integralarchive.org
