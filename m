Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265559AbSJSIjy>; Sat, 19 Oct 2002 04:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265560AbSJSIjy>; Sat, 19 Oct 2002 04:39:54 -0400
Received: from smtp.comcast.net ([24.153.64.2]:15221 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S265557AbSJSIjv>;
	Sat, 19 Oct 2002 04:39:51 -0400
Date: Sat, 19 Oct 2002 04:45:48 -0400
From: Will Dyson <will_dyson@pobox.com>
Subject: [PATCH] 2.5: Be Filesystem driver
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Message-id: <3DB11BBC.9030803@pobox.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913
 Debian/1.1-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm finaly getting off my ass and making available a forward port of the 
Be filesystem driver from 2.4. There is a combined bk/gnu patch (output of 
Documentation/BK-usage/bksend) here:
http://www.cs.earlham.edu/~will/befs-2.5

Those using bk might want to pull from:
bk://dysonwi.dyndns.org:5000/

ChangeSet@1.799, 2002-10-17 23:44:20-04:00, will@dysonwi.dyndns.org
Add a driver (read only for now) for the Be Filesystem, a 64-bit 
journaling filesystem with attributes which is the native fs of Be, Inc's 
BeOS (and the new OpenBeOS project as well).

Be always called their filesystem "BFS". However, that name is already in 
use. Thus, this driver is called BeFS.

The driver was developed under 2.4 (and merged into 2.4.20-pre3). Most of 
the credit for keeping up with the 2.5 VFS changes goes to Sergey S. 
Kostyliov <rathamahata@php4.ru>


  Documentation/filesystems/befs.txt |  111 ++++
  fs/Config.help                     |   22
  fs/Config.in                       |    3
  fs/Makefile                        |    1
  fs/befs/ChangeLog                  |  417 ++++++++++++++++
  fs/befs/Makefile                   |   15
  fs/befs/TODO                       |   14
  fs/befs/attribute.c                |  117 ++++
  fs/befs/befs.h                     |  158 ++++++
  fs/befs/befs_fs_types.h            |  213 ++++++++
  fs/befs/btree.c                    |  786 ++++++++++++++++++++++++++++++
  fs/befs/btree.h                    |   13
  fs/befs/datastream.c               |  528 ++++++++++++++++++++
  fs/befs/datastream.h               |   19
  fs/befs/debug.c                    |  262 ++++++++++
  fs/befs/endian.h                   |  126 ++++
  fs/befs/inode.c                    |   53 ++
  fs/befs/inode.h                    |    8
  fs/befs/io.c                       |   98 +++
  fs/befs/io.h                       |    9
  fs/befs/linuxvfs.c                 |  956 
+++++++++++++++++++++++++++++++++++++
  fs/befs/super.c                    |  112 ++++
  fs/befs/super.h                    |    8
  fs/nls/Config.in                   |    3
  24 files changed, 4051 insertions(+), 1 deletion(-)

-- 
Will Dyson
"Back off man, I'm a scientist!" -Dr. Peter Venkman

