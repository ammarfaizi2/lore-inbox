Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbWHPHW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWHPHW5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 03:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbWHPHW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 03:22:56 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:50460 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750966AbWHPHWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 03:22:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=Wd8CPLeAb0KhYEg6a22LYYKn+j0yse+izv2jzleHC3eGzI0pvGwxzvDCfPx6ixjHd5dvBgXxs3jnvTIgca4vr9ixkpvN8wU6eMV7OH9UNAbG1Gdl4OKlGGpOGTKBIxXrfDPiQIXzYxC0SAWNRDwCjOMOPG68gt3CzWEnj622XwI=
Date: Wed, 16 Aug 2006 11:22:51 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH -mm 00/44] fs/Kconfig split
Message-ID: <20060816072251.GE5206@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Split almost all fs/Kconfig into individual fs/*/Kconfig 's. It's 70K
monster and growing.

xfs, ncpfs are already splitted this way. reiser4, gfs2, dlm will be
splitted if merged as-is. NFS, lockd and sunrpc are left for now as well
as caching stuff in -mm.

44 patches are at
http://coderock.org/kj/fs-kconfig-split/fs-kconfig-split/
and will be sent to Andrew off-list. Tarball is level higher.
---

 fs/9p/Kconfig        |   10
 fs/Kconfig           | 1625 +--------------------------------------------------
 fs/adfs/Kconfig      |   27
 fs/affs/Kconfig      |   21
 fs/afs/Kconfig       |   19
 fs/autofs/Kconfig    |   21
 fs/autofs4/Kconfig   |   20
 fs/befs/Kconfig      |   26
 fs/bfs/Kconfig       |   19
 fs/cifs/Kconfig      |  137 ++++
 fs/coda/Kconfig      |   35 +
 fs/configfs/Kconfig  |   11
 fs/cramfs/Kconfig    |   18
 fs/ecryptfs/Kconfig  |   11
 fs/efs/Kconfig       |   14
 fs/ext2/Kconfig      |   57 +
 fs/ext3/Kconfig      |   69 ++
 fs/fat/Kconfig       |   59 +
 fs/freevxfs/Kconfig  |   15
 fs/fuse/Kconfig      |   15
 fs/hfs/Kconfig       |   12
 fs/hfsplus/Kconfig   |   12
 fs/hpfs/Kconfig      |   13
 fs/hugetlbfs/Kconfig |   12
 fs/isofs/Kconfig     |   45 +
 fs/jbd/Kconfig       |   31
 fs/jffs/Kconfig      |   22
 fs/jffs2/Kconfig     |  161 +++++
 fs/jfs/Kconfig       |   49 +
 fs/minix/Kconfig     |   16
 fs/msdos/Kconfig     |   24
 fs/ncpfs/Kconfig     |   21
 fs/ntfs/Kconfig      |   78 ++
 fs/ocfs2/Kconfig     |   41 +
 fs/proc/Kconfig      |   59 +
 fs/qnx4/Kconfig      |   24
 fs/ramfs/Kconfig     |   13
 fs/reiserfs/Kconfig  |   85 ++
 fs/romfs/Kconfig     |   15
 fs/smbfs/Kconfig     |   55 +
 fs/sysfs/Kconfig     |   23
 fs/sysv/Kconfig      |   35 +
 fs/udf/Kconfig       |   17
 fs/ufs/Kconfig       |   46 +
 fs/vfat/Kconfig      |   16
 45 files changed, 1572 insertions(+), 1582 deletions(-)

