Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264796AbSKEGNr>; Tue, 5 Nov 2002 01:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264951AbSKEGNq>; Tue, 5 Nov 2002 01:13:46 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16135 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264796AbSKEGN1>; Tue, 5 Nov 2002 01:13:27 -0500
Message-ID: <3DC762FC.8070007@zytor.com>
Date: Mon, 04 Nov 2002 22:19:40 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Reconfiguring one SW-RAID when other RAIDs are running
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm trying to re-create a RAID while leaving the other RAIDs -- 
including the root filesystem -- running, but mkraid refuses to run:

hera 1 # mkraid /dev/md2
/dev/md0: array is active -- run raidstop first.
mkraid: aborted.
(In addition to the above messages, see the syslog and /proc/mdstat as well
  for potential clues.)

hera 2 # cat /proc/mdstat
Personalities : [linear] [raid0] [raid1] [raid5] [multipath]
read_ahead 1024 sectors
md1 : active raid5 sdf2[5] sdc2[4] sde2[2] sdd2[3] sdb2[1] sda2[0]
       50339328 blocks level 5, 64k chunk, algorithm 0 [4/4] [UUUU]

md0 : active raid5 sdf3[5] sdc3[4] sde3[2] sdd3[3] sdb3[1] sda3[0]
       298881024 blocks level 5, 64k chunk, algorithm 0 [4/4] [UUUU]

unused devices: <none>


(And no, there is no overlap between them.)

Anyone know how to work around this problem?  This is using 
raidtools-1.00.2-1.3 from RedHat, which seems to be just 
raidtools-1.00.2.tar.gz.

(Also note: the raid directory on kernel.org seems to be abandoned. 
Unless someone speaks up I'm going to remove it.)

	-hpa



