Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270827AbTG2ECY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 00:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271106AbTG2ECY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 00:02:24 -0400
Received: from uni00du.unity.ncsu.edu ([152.1.13.100]:63627 "EHLO
	uni00du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id S270827AbTG2ECX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 00:02:23 -0400
From: jlnance@unity.ncsu.edu
Date: Tue, 29 Jul 2003 00:02:21 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.6 code size
Message-ID: <20030729040221.GA14242@ncsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,
    I know there were some discussions the other day regarding the size
of the 2.6 kernel vs the 2.4 kernel.  I decided to see if this was due
to gcc-3.2 being used rather than gcc 2.9*, and I do not think it is.
I configured the kernel and build it under RH9 which uses gcc 3.2.2.
Then I booted into RH7.3 did a make clean and a make (RH's gcc 2.96).
The object file size actually seems to be a little better with 3.2.2:

tricia> grep ext3 /misc/8.0/tmp/base
   5622       0       0    5622    15f6 ./fs/ext3/balloc.o
     67      64       0     131      83 ./fs/ext3/bitmap.o
   2995     120       0    3115     c2b ./fs/ext3/dir.o
    489     172       0     661     295 ./fs/ext3/file.o
    395       0       0     395     18b ./fs/ext3/fsync.o
   1391       0       0    1391     56f ./fs/ext3/hash.o
   5037       0       0    5037    13ad ./fs/ext3/ialloc.o
  15935     176       0   16111    3eef ./fs/ext3/inode.o
   1413       0       0    1413     585 ./fs/ext3/ioctl.o
  15673     204       0   15877    3e05 ./fs/ext3/namei.o
  18968     136    1120   20224    4f00 ./fs/ext3/super.o
     57     172       0     229      e5 ./fs/ext3/symlink.o
   7553       0      72    7625    1dc9 ./fs/ext3/xattr.o
    546      16       0     562     232 ./fs/ext3/xattr_trusted.o
    577      16       0     593     251 ./fs/ext3/xattr_user.o
tricia> grep ext3 /misc/8.0/tmp/base.7.3
   5559       0       0    5559    15b7 ./fs/ext3/balloc.o
    151      64       0     215      d7 ./fs/ext3/bitmap.o
   3111     128       0    3239     ca7 ./fs/ext3/dir.o
    523     192       0     715     2cb ./fs/ext3/file.o
    458       0       0     458     1ca ./fs/ext3/fsync.o
   1463       0       0    1463     5b7 ./fs/ext3/hash.o
   5150       0       0    5150    141e ./fs/ext3/ialloc.o
  15903     192       0   16095    3edf ./fs/ext3/inode.o
   1434       0       0    1434     59a ./fs/ext3/ioctl.o
  15666     224       0   15890    3e12 ./fs/ext3/namei.o
  19077     136    1120   20333    4f6d ./fs/ext3/super.o
     87     192       0     279     117 ./fs/ext3/symlink.o
   7446       4      96    7546    1d7a ./fs/ext3/xattr.o
    652      16       0     668     29c ./fs/ext3/xattr_trusted.o
    649      16       0     665     299 ./fs/ext3/xattr_user.o

I used whatever compiler options the 2.6-test1 Makefile chose to pass
the compiler.  I did nothing to change them.

Hope this is useful.

Thanks,

Jim
