Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263737AbUDPUoV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 16:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263731AbUDPUoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 16:44:20 -0400
Received: from lindsey.linux-systeme.com ([62.241.33.80]:31236 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263780AbUDPUl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 16:41:27 -0400
From: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
Organization: Linux-Systeme GmbH
To: reiserfs-list@namesys.com
Subject: Re: [PATCH] reiserfs v3 fixes and features
Date: Fri, 16 Apr 2004 22:41:01 +0200
User-Agent: KMail/1.6.1
Cc: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org
References: <1081274618.30828.30.camel@watt.suse.com> <200404162206.50654@WOLK> <1082147216.27614.1459.camel@watt.suse.com>
In-Reply-To: <1082147216.27614.1459.camel@watt.suse.com>
X-Operating-System: Linux 2.6.4-wolk2.3 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200404162241.01764@WOLK>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_dTEgAYyol6GnOu/"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_dTEgAYyol6GnOu/
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 16 April 2004 22:26, Chris Mason wrote:

Hey Chris,

> I just downloaded things to double check and it still works for me.
> But, that ftp directory had an added bonus file in it 2.6.5-mm6.bz2,
> which was incomplete.  I've deleted it, make sure you aren't patching
> based on that.

yep, I saw that and deleted it. Maybe I have an incomplete^Wbroken or whatever 
2.6.5-mm6 from kernel.org? I'll download it again.

Okay, please see attached log. Either something on your end is overheated or 
my p4 is overheated ;)

ciao, Marc

--Boundary-00=_dTEgAYyol6GnOu/
Content-Type: text/x-log;
  charset="iso-8859-15";
  name="patching.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patching.log"

root@codeman:[/usr/src/patches/people/akpm] # wget http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5/2.6.5-mm6/2.6.5-mm6.bz2
--22:30:26--  http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5/2.6.5-mm6/2.6.5-mm6.bz2
           => `2.6.5-mm6.bz2'
Resolving www.kernel.org... 204.152.189.116
Connecting to www.kernel.org[204.152.189.116]:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 1,981,842 [application/x-bzip2]

100%[====================================================================================================================>] 1,981,842     63.35K/s    ETA 00:00

22:30:59 (61.10 KB/s) - `2.6.5-mm6.bz2' saved [1981842/1981842]

root@codeman:[/usr/src/patches/people/akpm] # md5sum 2.6.5-mm6.bz2 
5a9a6b6840ff1c6dc0cb8e06f1683cda  2.6.5-mm6.bz2
root@codeman:[/usr/src/patches/people/akpm] # bunzip2 2.6.5-mm6.bz2
root@codeman:[/usr/src/patches/people/akpm] # mv 2.6.5-mm6 2.6.5-mm6.patch
root@codeman:[/usr/src/patches/people/akpm] # cp 2.6.5-mm6.patch /usr/src/linux-2.6.5-vanilla/
root@codeman:[/usr/src/patches/people/akpm] # cd /usr/src/linux-2.6.5-vanilla/
root@codeman:[/usr/src/linux-2.6.5-vanilla] # patch -p1 < 2.6.5-mm6.patch 1>/dev/null 2>tmp
root@codeman:[/usr/src/linux-2.6.5-vanilla] # cat tmp
root@codeman:[/usr/src/linux-2.6.5-vanilla] # cp /usr/src/patches/people/mason/* .
root@codeman:[/usr/src/linux-2.6.5-vanilla] # cat series.mm | while read line; do patch -p1 < $line; done
patching file fs/reiserfs/journal.c
Hunk #2 succeeded at 2478 (offset -7 lines).
Hunk #3 succeeded at 2913 (offset -10 lines).
Hunk #4 succeeded at 3010 (offset -10 lines).
Hunk #5 succeeded at 3533 (offset -10 lines).
patching file fs/reiserfs/journal.c
Hunk #1 succeeded at 2464 (offset -7 lines).
patching file fs/reiserfs/namei.c
patching file fs/Kconfig
patching file fs/reiserfs/Makefile
patching file fs/reiserfs/dir.c
patching file fs/reiserfs/file.c
patching file fs/reiserfs/inode.c
Hunk #5 succeeded at 2514 (offset -5 lines).
patching file fs/reiserfs/namei.c
patching file fs/reiserfs/super.c
Hunk #4 succeeded at 826 (offset -2 lines).
Hunk #5 succeeded at 850 (offset 4 lines).
Hunk #6 succeeded at 867 (offset 4 lines).
Hunk #7 succeeded at 891 (offset 4 lines).
Hunk #8 succeeded at 1324 (offset 4 lines).
Hunk #9 succeeded at 1470 (offset 4 lines).
Hunk #10 succeeded at 1556 (offset 4 lines).
Hunk #11 succeeded at 1568 (offset 4 lines).
Hunk #12 succeeded at 1581 (offset 4 lines).
patching file fs/reiserfs/xattr.c
patching file fs/reiserfs/xattr_user.c
patching file include/linux/reiserfs_fs.h
patching file include/linux/reiserfs_fs_i.h
patching file include/linux/reiserfs_fs_sb.h
Hunk #2 succeeded at 252 (offset 1 line).
Hunk #3 succeeded at 395 (offset 1 line).
Hunk #4 succeeded at 441 (offset 1 line).
Hunk #5 succeeded at 468 (offset 1 line).
patching file include/linux/reiserfs_xattr.h
patching file fs/Kconfig
patching file fs/reiserfs/Makefile
patching file fs/reiserfs/file.c
patching file fs/reiserfs/inode.c
Hunk #5 succeeded at 2583 (offset -5 lines).
patching file fs/reiserfs/namei.c
patching file fs/reiserfs/super.c
Hunk #6 succeeded at 851 (offset -2 lines).
patching file fs/reiserfs/xattr.c
patching file fs/reiserfs/xattr_acl.c
patching file fs/reiserfs/xattr_user.c
patching file include/linux/reiserfs_acl.h
patching file include/linux/reiserfs_fs_i.h
patching file include/linux/reiserfs_fs_sb.h
Hunk #1 succeeded at 443 (offset 1 line).
Hunk #2 succeeded at 471 (offset 1 line).
patching file include/linux/reiserfs_xattr.h
patching file fs/reiserfs/Makefile
patching file fs/reiserfs/xattr.c
patching file fs/reiserfs/xattr_trusted.c
patching file include/linux/reiserfs_xattr.h
patching file fs/Kconfig
patching file fs/reiserfs/Makefile
patching file fs/reiserfs/xattr.c
patching file fs/reiserfs/xattr_security.c
patching file include/linux/reiserfs_xattr.h
patching file fs/reiserfs/inode.c
patching file fs/reiserfs/xattr.c
patching file fs/reiserfs/xattr_acl.c
patching file include/linux/reiserfs_fs_i.h
patching file include/linux/reiserfs_xattr.h
patching file fs/reiserfs/bitmap.c
patching file fs/reiserfs/do_balan.c
patching file fs/reiserfs/file.c
patching file fs/reiserfs/fix_node.c
patching file fs/reiserfs/inode.c
Hunk #31 succeeded at 2359 (offset -5 lines).
Hunk #32 succeeded at 2386 (offset -5 lines).
Hunk #33 succeeded at 2602 (offset -5 lines).
patching file fs/reiserfs/namei.c
patching file fs/reiserfs/stree.c
patching file fs/reiserfs/super.c
patching file fs/reiserfs/tail_conversion.c
patching file include/linux/reiserfs_fs.h
patching file fs/reiserfs/xattr.c
patching file fs/reiserfs/bitmap.c
patching file fs/reiserfs/dir.c
patching file fs/reiserfs/do_balan.c
patching file fs/reiserfs/file.c
patching file fs/reiserfs/fix_node.c
patching file fs/reiserfs/inode.c
Hunk #14 succeeded at 2044 (offset -1 lines).
Hunk #15 succeeded at 2093 (offset -1 lines).
patching file fs/reiserfs/item_ops.c
patching file fs/reiserfs/journal.c
Hunk #1 succeeded at 271 (offset 1 line).
Hunk #2 succeeded at 345 (offset 1 line).
Hunk #3 succeeded at 369 (offset 1 line).
Hunk #4 succeeded at 422 (offset 1 line).
Hunk #5 succeeded at 558 (offset 1 line).
Hunk #6 succeeded at 599 (offset 1 line).
Hunk #7 succeeded at 910 (offset 1 line).
Hunk #8 succeeded at 1005 (offset 1 line).
Hunk #9 succeeded at 1064 (offset 1 line).
Hunk #10 succeeded at 1102 (offset 1 line).
Hunk #11 succeeded at 1176 (offset 1 line).
Hunk #12 succeeded at 1275 (offset 1 line).
Hunk #13 succeeded at 1293 (offset 1 line).
Hunk #14 succeeded at 1303 (offset 1 line).
Hunk #15 succeeded at 1363 (offset 1 line).
Hunk #16 succeeded at 1711 (offset 1 line).
Hunk #17 succeeded at 1737 (offset 1 line).
Hunk #18 succeeded at 1745 (offset 1 line).
Hunk #19 succeeded at 1792 (offset 1 line).
Hunk #20 succeeded at 1805 (offset 1 line).
Hunk #21 succeeded at 1820 (offset 1 line).
Hunk #22 succeeded at 1836 (offset 1 line).
Hunk #23 succeeded at 1849 (offset 1 line).
Hunk #24 succeeded at 1870 (offset 1 line).
Hunk #25 succeeded at 1891 (offset 1 line).
Hunk #26 succeeded at 1903 (offset 1 line).
Hunk #27 succeeded at 1985 (offset 1 line).
Hunk #28 succeeded at 2009 (offset 1 line).
Hunk #29 succeeded at 2027 (offset 1 line).
Hunk #30 succeeded at 2048 (offset 1 line).
Hunk #31 succeeded at 2056 (offset 1 line).
Hunk #32 succeeded at 2076 (offset 1 line).
Hunk #33 succeeded at 2097 (offset 1 line).
Hunk #34 succeeded at 2112 (offset 1 line).
Hunk #35 succeeded at 2171 (offset 1 line).
Hunk #36 succeeded at 2201 (offset 1 line).
Hunk #37 succeeded at 2214 (offset 1 line).
Hunk #38 succeeded at 2225 (offset 1 line).
Hunk #39 succeeded at 2251 (offset 1 line).
Hunk #40 succeeded at 2273 (offset 1 line).
Hunk #41 succeeded at 2292 (offset 1 line).
Hunk #42 succeeded at 2336 (offset 1 line).
Hunk #43 succeeded at 2357 (offset 1 line).
Hunk #44 succeeded at 2405 (offset 1 line).
Hunk #45 succeeded at 2526 (offset 15 lines).
Hunk #46 succeeded at 2668 (offset 15 lines).
Hunk #47 succeeded at 2722 (offset 15 lines).
Hunk #48 succeeded at 2791 (offset 15 lines).
Hunk #49 succeeded at 2851 (offset 15 lines).
Hunk #50 succeeded at 3149 (offset 22 lines).
Hunk #51 succeeded at 3165 (offset 22 lines).
Hunk #52 succeeded at 3325 (offset 22 lines).
Hunk #53 succeeded at 3487 (offset 22 lines).
Hunk #54 succeeded at 3619 (offset 22 lines).
patching file fs/reiserfs/lbalance.c
patching file fs/reiserfs/namei.c
patching file fs/reiserfs/objectid.c
patching file fs/reiserfs/prints.c
patching file fs/reiserfs/procfs.c
patching file fs/reiserfs/stree.c
patching file fs/reiserfs/super.c
patching file fs/reiserfs/tail_conversion.c
patching file fs/reiserfs/xattr.c
patching file include/linux/reiserfs_fs.h
patching file fs/reiserfs/bitmap.c
Hunk #6 succeeded at 358 with fuzz 1.
Hunk #17 FAILED at 943.
1 out of 17 hunks FAILED -- saving rejects to file fs/reiserfs/bitmap.c.rej
patching file fs/reiserfs/file.c
Hunk #1 FAILED at 176.
Hunk #2 succeeded at 467 (offset -1 lines).
Hunk #3 succeeded at 1253 (offset -1 lines).
1 out of 3 hunks FAILED -- saving rejects to file fs/reiserfs/file.c.rej
patching file fs/reiserfs/inode.c
Hunk #1 succeeded at 1660 (offset 1 line).
Hunk #2 succeeded at 1729 (offset 1 line).
patching file fs/reiserfs/super.c
Hunk #2 succeeded at 650 (offset -4 lines).
Hunk #3 succeeded at 1345 (offset -21 lines).
patching file include/linux/reiserfs_fs.h
Hunk #2 succeeded at 2149 (offset 9 lines).
patching file fs/reiserfs/dir.c
patching file fs/reiserfs/stree.c
patching file include/linux/reiserfs_fs.h
root@codeman:[/usr/src/linux-2.6.5-vanilla] #

--Boundary-00=_dTEgAYyol6GnOu/--
