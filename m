Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263698AbTDTVMn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 17:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263700AbTDTVMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 17:12:42 -0400
Received: from franka.aracnet.com ([216.99.193.44]:10914 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263698AbTDTVMl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 17:12:41 -0400
Date: Sun, 20 Apr 2003 14:06:20 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 607] New: NTFS - dir.c errors during compile 
Message-ID: <7610000.1050872780@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=607

           Summary: NTFS - dir.c errors during compile
    Kernel Version: 2.5.68
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: sureddin@attbi.com


Distribution: SuSE 8.2
Hardware Environment: PIII - 550
Software Environment: GCC 3.3 pre
Problem Description: /fs/ntfs/dir.c fails to compile

Steps to reproduce: 
Configure Filesystems->DOS/FAT/NT filesystems->NTFS file system support (Read
only) as in-kernel or module.  Error occurs either way. 

  gcc -Wp,-MD,fs/ntfs/.dir.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=pentium3 -Iinclude/asm-i386/mach-default
-nostdinc -iwithprefix include  -DNTFS_VERSION=\"2.1.0\"  -DKBUILD_BASENAME=dir
-DKBUILD_MODNAME=ntfs -c -o fs/ntfs/dir.o fs/ntfs/dir.c
In file included from fs/ntfs/inode.h:29,
                 from fs/ntfs/debug.h:30,
                 from fs/ntfs/ntfs.h:40,
                 from fs/ntfs/dir.c:24:
fs/ntfs/layout.h:299: warning: declaration does not declare anything
fs/ntfs/layout.h:1449: warning: declaration does not declare anything
fs/ntfs/layout.h:1465: warning: declaration does not declare anything
fs/ntfs/layout.h:1714: warning: declaration does not declare anything
fs/ntfs/layout.h:1891: warning: declaration does not declare anything
fs/ntfs/layout.h:2051: warning: declaration does not declare anything
fs/ntfs/layout.h:2063: warning: declaration does not declare anything
fs/ntfs/dir.c: In function `ntfs_lookup_inode_by_name':
fs/ntfs/dir.c:117: error: structure has no member named `length'
fs/ntfs/dir.c:121: error: structure has no member named `key_length'
fs/ntfs/dir.c:128: error: structure has no member named `flags'
fs/ntfs/dir.c:162: error: structure has no member named `indexed_file'
fs/ntfs/dir.c:171: error: structure has no member named `indexed_file'
fs/ntfs/dir.c:214: error: structure has no member named `indexed_file'
fs/ntfs/dir.c:268: error: structure has no member named `flags'
fs/ntfs/dir.c:287: error: structure has no member named `length'
fs/ntfs/dir.c:370: error: structure has no member named `length'
fs/ntfs/dir.c:374: error: structure has no member named `key_length'
fs/ntfs/dir.c:386: error: structure has no member named `flags'
fs/ntfs/dir.c:420: error: structure has no member named `indexed_file'
fs/ntfs/dir.c:429: error: structure has no member named `indexed_file'
fs/ntfs/dir.c:472: error: structure has no member named `indexed_file'
fs/ntfs/dir.c:524: error: structure has no member named `flags'
fs/ntfs/dir.c:535: error: structure has no member named `length'
fs/ntfs/dir.c: In function `ntfs_filldir':
fs/ntfs/dir.c:1019: error: structure has no member named `indexed_file'
fs/ntfs/dir.c:1023: error: structure has no member named `indexed_file'
fs/ntfs/dir.c:1045: error: structure has no member named `indexed_file'
fs/ntfs/dir.c: In function `ntfs_readdir':
fs/ntfs/dir.c:1152: error: structure has no member named `length'
fs/ntfs/dir.c:1158: error: structure has no member named `key_length'
fs/ntfs/dir.c:1161: error: structure has no member named `flags'
fs/ntfs/dir.c:1238: warning: comparison between signed and unsigned
fs/ntfs/dir.c:1329: error: structure has no member named `length'
fs/ntfs/dir.c:1336: error: structure has no member named `key_length'
fs/ntfs/dir.c:1339: error: structure has no member named `flags'
fs/ntfs/dir.c: In function `ntfs_dir_open':
fs/ntfs/dir.c:1410: warning: comparison between signed and unsigned
make[2]: *** [fs/ntfs/dir.o] Error 1
make[1]: *** [fs/ntfs] Error 2
make: *** [fs] Error 2
linux:/usr/src/linux-2.5.68 #


