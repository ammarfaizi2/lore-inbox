Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbTJLOAy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 10:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263189AbTJLOAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 10:00:54 -0400
Received: from smtp0.adl1.internode.on.net ([203.16.214.194]:10502 "EHLO
	smtp0.adl1.internode.on.net") by vger.kernel.org with ESMTP
	id S262362AbTJLOAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 10:00:48 -0400
Date: Sun, 12 Oct 2003 23:30:48 +0930
From: "Mark Williams (MWP)" <mwp@internode.on.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS causing kernel panic?
Message-ID: <20031012140048.GA554@linux.comp>
References: <20031012121331.GA665@linux.comp> <yw1xhe2eiqru.fsf@zaphod.guide>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <yw1xhe2eiqru.fsf@zaphod.guide>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> "Mark Williams (MWP)" <mwp@internode.on.net> writes:
> 
> > I am having rather ugly problems with this card using the PDC20269 chip.
> > Almost as soon as either of the HDDs on the controller are used, the
> > kernel hangs solid with a dump of debugging info.
> 
> That dump could be useful.  Also full output of dmesg and "lspci -vv"
> can be helpful.

Ok, seems this is not a controller fault, but really a problem with
ReiserFS (!!).

It seems one of the HDDs on the controller i thought had a problem is
corrupted, and the corrupted ReiserFS on it is causing the kernel to
panic.

Attached is the dump of the kern log from where the problem begins to
where it rebooted itself.

The other HDD on the same controller (same HDD model, WD1200JB) is also
ReiserFS, but works fine.

BTW, sorry for the large attachment, but i didnt know if you would want
all of it.

--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dump.txt"

Oct 12 21:48:03 linux kernel: ide3(34,2):Using r5 hash to sort names
Oct 12 21:48:52 linux kernel: vs-500: unknown uniqueness 45644
Oct 12 21:48:52 linux last message repeated 5 times
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 5471028. Fsck?
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [45464 45630 0x0 SD]
Oct 12 21:48:52 linux kernel: vs-500: unknown uniqueness 45644
Oct 12 21:48:52 linux last message repeated 5 times
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 5471028. Fsck?
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [45464 45631 0x0 SD]
Oct 12 21:48:52 linux kernel: vs-500: unknown uniqueness 45644
Oct 12 21:48:52 linux last message repeated 5 times
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 5471028. Fsck?
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [45464 45632 0x0 SD]
Oct 12 21:48:52 linux kernel: vs-500: unknown uniqueness 45644
Oct 12 21:48:52 linux last message repeated 5 times
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 5471028. Fsck?
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [45464 45633 0x0 SD]
Oct 12 21:48:52 linux kernel: vs-500: unknown uniqueness 45644
Oct 12 21:48:52 linux last message repeated 5 times
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 5471028. Fsck?
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [45464 45634 0x0 SD]
Oct 12 21:48:52 linux kernel: vs-500: unknown uniqueness 45644
Oct 12 21:48:52 linux last message repeated 5 times
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 5471028. Fsck?
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [45464 45635 0x0 SD]
Oct 12 21:48:52 linux kernel: vs-500: unknown uniqueness 45644
Oct 12 21:48:52 linux last message repeated 5 times
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 5471028. Fsck?
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [45464 45636 0x0 SD]
Oct 12 21:48:52 linux kernel: vs-500: unknown uniqueness 45644
Oct 12 21:48:52 linux last message repeated 5 times
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 5471028. Fsck?
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [45464 45637 0x0 SD]
Oct 12 21:48:52 linux kernel: vs-500: unknown uniqueness 45644
Oct 12 21:48:52 linux last message repeated 5 times
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 5471028. Fsck?
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [45464 45638 0x0 SD]
Oct 12 21:48:52 linux kernel: vs-500: unknown uniqueness 45644
Oct 12 21:48:52 linux last message repeated 5 times
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 5471028. Fsck?
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [45464 45639 0x0 SD]
Oct 12 21:48:52 linux kernel: vs-500: unknown uniqueness 45644
Oct 12 21:48:52 linux last message repeated 5 times
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 5471028. Fsck?
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [45464 45640 0x0 SD]
Oct 12 21:48:52 linux kernel: vs-500: unknown uniqueness 45644
Oct 12 21:48:52 linux last message repeated 5 times
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 5471028. Fsck?
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [45464 45641 0x0 SD]
Oct 12 21:48:52 linux kernel: vs-500: unknown uniqueness 45644
Oct 12 21:48:52 linux last message repeated 5 times
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 5471028. Fsck?
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [45464 45642 0x0 SD]
Oct 12 21:48:52 linux kernel: vs-500: unknown uniqueness 45644
Oct 12 21:48:52 linux last message repeated 5 times
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 5471028. Fsck?
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [45464 45643 0x0 SD]
Oct 12 21:48:52 linux kernel: vs-500: unknown uniqueness 45644
Oct 12 21:48:52 linux last message repeated 5 times
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 5471028. Fsck?
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [45464 45644 0x0 SD]
Oct 12 21:48:52 linux kernel: vs-500: unknown uniqueness 45644
Oct 12 21:48:52 linux last message repeated 5 times
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 5471028. Fsck?
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [45464 45645 0x0 SD]
Oct 12 21:48:52 linux kernel: vs-500: unknown uniqueness 45644
Oct 12 21:48:52 linux last message repeated 5 times
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 5471028. Fsck?
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [45464 45646 0x0 SD]
Oct 12 21:48:52 linux kernel: vs-500: unknown uniqueness 45644
Oct 12 21:48:52 linux last message repeated 5 times
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 5471028. Fsck?
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [45464 45647 0x0 SD]
Oct 12 21:48:52 linux kernel: vs-500: unknown uniqueness 45644
Oct 12 21:48:52 linux last message repeated 5 times
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 5471028. Fsck?
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [45464 45648 0x0 SD]
Oct 12 21:48:52 linux kernel: vs-500: unknown uniqueness 45644
Oct 12 21:48:52 linux last message repeated 5 times
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 5471028. Fsck?
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [45464 45649 0x0 SD]
Oct 12 21:48:52 linux kernel: vs-500: unknown uniqueness 45644
Oct 12 21:48:52 linux last message repeated 5 times
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 5471028. Fsck?
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [45464 45650 0x0 SD]
Oct 12 21:48:52 linux kernel: vs-500: unknown uniqueness 45644
Oct 12 21:48:52 linux last message repeated 5 times
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 5471028. Fsck?
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [45464 45651 0x0 SD]
Oct 12 21:48:52 linux kernel: vs-500: unknown uniqueness 45644
Oct 12 21:48:52 linux last message repeated 5 times
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 5471028. Fsck?
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [45464 45652 0x0 SD]
Oct 12 21:48:52 linux kernel: vs-500: unknown uniqueness 45644
Oct 12 21:48:52 linux last message repeated 5 times
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 5471028. Fsck?
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [45464 45653 0x0 SD]
Oct 12 21:48:52 linux kernel: vs-500: unknown uniqueness 45644
Oct 12 21:48:52 linux last message repeated 5 times
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 5471028. Fsck?
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [45464 45654 0x0 SD]
Oct 12 21:48:52 linux kernel: vs-500: unknown uniqueness 45644
Oct 12 21:48:52 linux last message repeated 5 times
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 5471028. Fsck?
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [45464 45655 0x0 SD]
Oct 12 21:48:52 linux kernel: vs-500: unknown uniqueness 45644
Oct 12 21:48:52 linux last message repeated 5 times
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 5471028. Fsck?
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [45464 45656 0x0 SD]
Oct 12 21:48:52 linux kernel: vs-500: unknown uniqueness 45644
Oct 12 21:48:52 linux last message repeated 5 times
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 5471028. Fsck?
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [45464 45657 0x0 SD]
Oct 12 21:48:52 linux kernel: vs-500: unknown uniqueness 45644
Oct 12 21:48:52 linux last message repeated 5 times
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 5471028. Fsck?
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [45464 45658 0x0 SD]
Oct 12 21:48:52 linux kernel: vs-500: unknown uniqueness 45644
Oct 12 21:48:52 linux last message repeated 5 times
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 5471028. Fsck?
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [45464 45659 0x0 SD]
Oct 12 21:48:52 linux kernel: vs-500: unknown uniqueness 45644
Oct 12 21:48:52 linux last message repeated 5 times
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 5471028. Fsck?
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [45464 45660 0x0 SD]
Oct 12 21:48:52 linux kernel: vs-500: unknown uniqueness 45644
Oct 12 21:48:52 linux last message repeated 5 times
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 5471028. Fsck?
Oct 12 21:48:52 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [45464 45662 0x0 SD]
Oct 12 21:48:53 linux kernel: vs-500: unknown uniqueness 1319
Oct 12 21:48:53 linux last message repeated 6 times
Oct 12 21:48:53 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 305854. Fsck?
Oct 12 21:48:53 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [1626 1631 0x0 SD]
Oct 12 21:48:53 linux kernel: vs-500: unknown uniqueness 1319
Oct 12 21:48:53 linux last message repeated 6 times
Oct 12 21:48:53 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 305854. Fsck?
Oct 12 21:48:53 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [1626 1636 0x0 SD]
Oct 12 21:48:53 linux kernel: vs-500: unknown uniqueness 1319
Oct 12 21:48:53 linux last message repeated 6 times
Oct 12 21:48:53 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 305854. Fsck?
Oct 12 21:48:53 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [1626 1632 0x0 SD]
Oct 12 21:48:53 linux kernel: vs-500: unknown uniqueness 1319
Oct 12 21:48:53 linux last message repeated 6 times
Oct 12 21:48:53 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 305854. Fsck?
Oct 12 21:48:53 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [1626 1634 0x0 SD]
Oct 12 21:48:53 linux kernel: vs-500: unknown uniqueness 1319
Oct 12 21:48:53 linux last message repeated 6 times
Oct 12 21:48:53 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 305854. Fsck?
Oct 12 21:48:53 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [1637 1642 0x0 SD]
Oct 12 21:48:53 linux kernel: vs-500: unknown uniqueness 1319
Oct 12 21:48:53 linux last message repeated 6 times
Oct 12 21:48:53 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 305854. Fsck?
Oct 12 21:48:53 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [1637 1640 0x0 SD]
Oct 12 21:48:53 linux kernel: vs-500: unknown uniqueness 1319
Oct 12 21:48:53 linux last message repeated 6 times
Oct 12 21:48:53 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 305854. Fsck?
Oct 12 21:48:53 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [1236 1276 0x0 SD]
Oct 12 21:48:53 linux kernel: vs-500: unknown uniqueness 1319
Oct 12 21:48:53 linux last message repeated 6 times
Oct 12 21:48:53 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 305854. Fsck?
Oct 12 21:48:53 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [1312 1337 0x0 SD]
Oct 12 21:48:53 linux kernel: vs-500: unknown uniqueness 1319
Oct 12 21:48:53 linux last message repeated 6 times
Oct 12 21:48:53 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 305854. Fsck?
Oct 12 21:48:53 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [1312 1317 0x0 SD]
Oct 12 21:48:53 linux kernel: vs-500: unknown uniqueness 1319
Oct 12 21:48:53 linux last message repeated 6 times
Oct 12 21:48:53 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 305854. Fsck?
Oct 12 21:48:53 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [1312 1346 0x0 SD]
Oct 12 21:48:53 linux kernel: vs-500: unknown uniqueness 1319
Oct 12 21:48:53 linux last message repeated 6 times
Oct 12 21:48:53 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 305854. Fsck?
Oct 12 21:48:53 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [1312 1347 0x0 SD]
Oct 12 21:48:53 linux kernel: vs-500: unknown uniqueness 1319
Oct 12 21:48:53 linux last message repeated 6 times
Oct 12 21:48:53 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 305854. Fsck?
Oct 12 21:48:53 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [1312 1349 0x0 SD]
Oct 12 21:48:53 linux kernel: vs-500: unknown uniqueness 1319
Oct 12 21:48:53 linux last message repeated 6 times
Oct 12 21:48:53 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 305854. Fsck?
Oct 12 21:48:53 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [1312 1319 0x0 SD]
Oct 12 21:48:53 linux kernel: vs-500: unknown uniqueness 1319
Oct 12 21:48:53 linux last message repeated 6 times
Oct 12 21:48:53 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 305854. Fsck?
Oct 12 21:48:53 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [1312 1320 0x0 SD]
Oct 12 21:48:53 linux kernel: vs-500: unknown uniqueness 1319
Oct 12 21:48:53 linux last message repeated 6 times
Oct 12 21:48:53 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 305854. Fsck?
Oct 12 21:48:53 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [1312 1326 0x0 SD]
Oct 12 21:48:53 linux kernel: vs-500: unknown uniqueness 1319
Oct 12 21:48:53 linux last message repeated 6 times
Oct 12 21:48:53 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 305854. Fsck?
Oct 12 21:48:53 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [1312 1327 0x0 SD]
Oct 12 21:48:53 linux kernel: vs-500: unknown uniqueness 1319
Oct 12 21:48:53 linux last message repeated 6 times
Oct 12 21:48:53 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 305854. Fsck?
Oct 12 21:48:53 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [1312 1325 0x0 SD]
Oct 12 21:48:53 linux kernel: vs-500: unknown uniqueness 1319
Oct 12 21:48:53 linux last message repeated 6 times
Oct 12 21:48:53 linux kernel: ide3(34,2):vs-5150: search_by_key: invalid format found in block 305854. Fsck?
Oct 12 21:48:53 linux kernel: ide3(34,2):vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [1488 1496 0x0 SD]
O

--gKMricLos+KVdGMg--
