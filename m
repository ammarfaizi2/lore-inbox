Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129745AbQLZMAl>; Tue, 26 Dec 2000 07:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129849AbQLZMAb>; Tue, 26 Dec 2000 07:00:31 -0500
Received: from s340-modem1548.dial.xs4all.nl ([194.109.166.12]:65408 "EHLO
	sjoerd.sjoerdnet") by vger.kernel.org with ESMTP id <S129745AbQLZMAR>;
	Tue, 26 Dec 2000 07:00:17 -0500
Date: Tue, 26 Dec 2000 12:28:54 +0100 (CET)
From: Arjan Filius <iafilius@xs4all.nl>
Reply-To: Arjan Filius <iafilius@xs4all.nl>
To: <linux-lvm@sistina.com>, <linux-kernel@vger.kernel.org>
Subject: 2.4.0-13-4: raid on lvm: VFS: Unsupported blocksize on dev md(9,3)
Message-ID: <Pine.LNX.4.30.0012261217100.1895-100000@sjoerd.sjoerdnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I get messages like (2.4.0-13-4):
Dec 26 11:59:35 sjoerd kernel: VFS: Unsupported blocksize on dev md(9,3).
when trying to mount these /dev/md? .

It worked fine with the 2.4.0-12, and the ext2 on lvm seems to work
properly (after the LVM 0.9 utils update)

a 'cat /dev/md1 > /images/md1' and
'mount -oloop /images/md1 /mnt' works fine with test-13-4.

Just in case it matters:
# mount --version
mount: mount-2.10m

# cat /proc/mdstat
Personalities : [linear] [raid0] [raid1] [raid5]
read_ahead 1024 sectors
md3 : active linear lvmz[1] lvmy[0]
      155520 blocks 32k rounding

md2 : active raid1 lvmx[1] lvmw[0]
      102336 blocks [2/2] [UU]

md1 : active raid5 lks level 5, 32k chunk, algorithm 0 [4/4] [UUUU]

md0 : active raid0 lvmv[3] lvmu[2] lvmt[1] lvms[0]
      409344 blocks 4k chunks

unused devices: <none>


Greatings,


--
Arjan
Filius
mailto:iafilius@xs4all.nl

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
