Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312740AbSDBC0w>; Mon, 1 Apr 2002 21:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312745AbSDBC0m>; Mon, 1 Apr 2002 21:26:42 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:42479
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S312740AbSDBC01>; Mon, 1 Apr 2002 21:26:27 -0500
Date: Mon, 1 Apr 2002 18:28:22 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Raid5 resync slow with one linear array
Message-ID: <20020402022822.GA961@matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just setup a 4 (5 really) drive raid5 array.

It is syncing up right now and nothing else is running on the system.

I have three 18GB SCA scsi drives and 2x9GB linear array in a four "drive"
raid5 array.

Unfortunately, it is syncing up quite slowly.  Only about 2MB/sec on a
40MB/sec array.  The system is idle.

2.4.19-pre4-ac3

Is there something about this config that says "Don't do that!"?  I've
heard about RAID10, but not Linear+RAID5...

This way, I get more space, and one filesystem (except a 50mb raid1 for
booting).

Thanks

Mike

Personalities : [linear] [raid0] [raid1] [raid5] 
read_ahead 1024 sectors
md2 : active raid1 scsi/host0/bus0/target1/lun0/part1[1] scsi/host0/bus0/target0/lun0/part1[0]
      48064 blocks [2/2] [UU]
      
md1 : active linear scsi/host0/bus0/target0/lun0/part2[1] scsi/host0/bus0/target1/lun0/part2[0]
      17671296 blocks 32k rounding
      
md0 : active raid5 md/1[4] scsi/host0/bus0/target4/lun0/part2[2] scsi/host0/bus0/target3/lun0/part2[1] scsi/host0/bus0/target2/lun0/part2[0]
      52990080 blocks level 5, 32k chunk, algorithm 2 [4/3] [UUU_]
      [>....................]  recovery =  2.1% (373984/17663360) finish=143.2min speed=2010K/sec
unused devices: <none>
