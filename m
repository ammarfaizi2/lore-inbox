Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290261AbSAOT0T>; Tue, 15 Jan 2002 14:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290257AbSAOT0K>; Tue, 15 Jan 2002 14:26:10 -0500
Received: from [208.179.59.195] ([208.179.59.195]:59256 "EHLO
	Booterz.killerlabs.com") by vger.kernel.org with ESMTP
	id <S290261AbSAOT0B>; Tue, 15 Jan 2002 14:26:01 -0500
Message-ID: <3C448241.7000104@blue-labs.org>
Date: Tue, 15 Jan 2002 14:25:53 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020115
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.2 - reiserfs::procfs.c fails compile
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like a quick fix, ..I haven't inspected it tho.

-d

gcc -D__KERNEL__ -I/usr/local/src/linux/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686  -DSMBFS_PARANOIA  -c -o inode.o inode.c
procfs.c: In function `reiserfs_version_in_proc':
procfs.c:80: conversion to non-scalar type requested
procfs.c: In function `reiserfs_super_in_proc':
procfs.c:137: conversion to non-scalar type requested
procfs.c: In function `reiserfs_per_level_in_proc':
procfs.c:217: conversion to non-scalar type requested
procfs.c: In function `reiserfs_bitmap_in_proc':
procfs.c:296: conversion to non-scalar type requested
procfs.c: In function `reiserfs_on_disk_super_in_proc':
procfs.c:337: conversion to non-scalar type requested
procfs.c: In function `reiserfs_oidmap_in_proc':
procfs.c:390: conversion to non-scalar type requested
procfs.c: In function `reiserfs_journal_in_proc':
procfs.c:441: conversion to non-scalar type requested
procfs.c:494: incompatible type for argument 1 of `bdevname'
procfs.c: In function `reiserfs_proc_register':
procfs.c:581: aggregate value used where an integer was expected
make[3]: *** [procfs.o] Error 1
make[3]: Leaving directory `/usr/local/src/linux/fs/reiserfs'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/local/src/linux/fs/reiserfs'


