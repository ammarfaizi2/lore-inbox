Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbTD3Ors (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 10:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbTD3Orr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 10:47:47 -0400
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:37631 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP id S262196AbTD3Orp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 10:47:45 -0400
Date: Wed, 30 Apr 2003 16:00:04 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 607] New: NTFS - dir.c errors during compile 
In-Reply-To: <7610000.1050872780@[10.10.2.4]>
Message-ID: <Pine.SOL.3.96.1030430155857.19762D-100000@virgo.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This bug should be fixed by the latest ntfs release 2.1.4 which I
submitted to Linus for inclusion earlier today.

Best regards,

	Anton

On Sun, 20 Apr 2003, Martin J. Bligh wrote:
> http://bugme.osdl.org/show_bug.cgi?id=607
> 
>            Summary: NTFS - dir.c errors during compile
>     Kernel Version: 2.5.68
>             Status: NEW
>           Severity: normal
>              Owner: bugme-janitors@lists.osdl.org
>          Submitter: sureddin@attbi.com
> 
> 
> Distribution: SuSE 8.2
> Hardware Environment: PIII - 550
> Software Environment: GCC 3.3 pre
> Problem Description: /fs/ntfs/dir.c fails to compile
> 
> Steps to reproduce: 
> Configure Filesystems->DOS/FAT/NT filesystems->NTFS file system support (Read
> only) as in-kernel or module.  Error occurs either way. 
> 
>   gcc -Wp,-MD,fs/ntfs/.dir.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe
> -mpreferred-stack-boundary=2 -march=pentium3 -Iinclude/asm-i386/mach-default
> -nostdinc -iwithprefix include  -DNTFS_VERSION=\"2.1.0\"  -DKBUILD_BASENAME=dir
> -DKBUILD_MODNAME=ntfs -c -o fs/ntfs/dir.o fs/ntfs/dir.c
> In file included from fs/ntfs/inode.h:29,
>                  from fs/ntfs/debug.h:30,
>                  from fs/ntfs/ntfs.h:40,
>                  from fs/ntfs/dir.c:24:
> fs/ntfs/layout.h:299: warning: declaration does not declare anything
> fs/ntfs/layout.h:1449: warning: declaration does not declare anything
> fs/ntfs/layout.h:1465: warning: declaration does not declare anything
> fs/ntfs/layout.h:1714: warning: declaration does not declare anything
> fs/ntfs/layout.h:1891: warning: declaration does not declare anything
> fs/ntfs/layout.h:2051: warning: declaration does not declare anything
> fs/ntfs/layout.h:2063: warning: declaration does not declare anything
> fs/ntfs/dir.c: In function `ntfs_lookup_inode_by_name':
> fs/ntfs/dir.c:117: error: structure has no member named `length'
> fs/ntfs/dir.c:121: error: structure has no member named `key_length'
> fs/ntfs/dir.c:128: error: structure has no member named `flags'
> fs/ntfs/dir.c:162: error: structure has no member named `indexed_file'
> fs/ntfs/dir.c:171: error: structure has no member named `indexed_file'
> fs/ntfs/dir.c:214: error: structure has no member named `indexed_file'
> fs/ntfs/dir.c:268: error: structure has no member named `flags'
> fs/ntfs/dir.c:287: error: structure has no member named `length'
> fs/ntfs/dir.c:370: error: structure has no member named `length'
> fs/ntfs/dir.c:374: error: structure has no member named `key_length'
> fs/ntfs/dir.c:386: error: structure has no member named `flags'
> fs/ntfs/dir.c:420: error: structure has no member named `indexed_file'
> fs/ntfs/dir.c:429: error: structure has no member named `indexed_file'
> fs/ntfs/dir.c:472: error: structure has no member named `indexed_file'
> fs/ntfs/dir.c:524: error: structure has no member named `flags'
> fs/ntfs/dir.c:535: error: structure has no member named `length'
> fs/ntfs/dir.c: In function `ntfs_filldir':
> fs/ntfs/dir.c:1019: error: structure has no member named `indexed_file'
> fs/ntfs/dir.c:1023: error: structure has no member named `indexed_file'
> fs/ntfs/dir.c:1045: error: structure has no member named `indexed_file'
> fs/ntfs/dir.c: In function `ntfs_readdir':
> fs/ntfs/dir.c:1152: error: structure has no member named `length'
> fs/ntfs/dir.c:1158: error: structure has no member named `key_length'
> fs/ntfs/dir.c:1161: error: structure has no member named `flags'
> fs/ntfs/dir.c:1238: warning: comparison between signed and unsigned
> fs/ntfs/dir.c:1329: error: structure has no member named `length'
> fs/ntfs/dir.c:1336: error: structure has no member named `key_length'
> fs/ntfs/dir.c:1339: error: structure has no member named `flags'
> fs/ntfs/dir.c: In function `ntfs_dir_open':
> fs/ntfs/dir.c:1410: warning: comparison between signed and unsigned
> make[2]: *** [fs/ntfs/dir.o] Error 1
> make[1]: *** [fs/ntfs] Error 2
> make: *** [fs] Error 2
> linux:/usr/src/linux-2.5.68 #

-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

