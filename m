Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964837AbVJDQDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbVJDQDf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 12:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbVJDQDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 12:03:34 -0400
Received: from qproxy.gmail.com ([72.14.204.196]:5956 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964837AbVJDQDd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 12:03:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=THVv5M+JR/1vYVavH7hxG/wLG+aEmqBs56CSHITQaf0FN4jBfjmk71c+3AVVHQphhFf4A9DVivoUdNgaWqzDPkvmh71fX7pFAklXggJTdhBskoPDHUFQ4Ojf96gR9JevNL3LE05ug6Ux30bWyh6WV8rBDnpbiZkJqIS21XBzCEQ=
Message-ID: <6bffcb0e0510040903i406e6870n@mail.gmail.com>
Date: Tue, 4 Oct 2005 16:03:32 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Reply-To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.14-rc3-git-current xfs compilation warnings
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have noticed this warnings while compiling xfs as module.

  CC [M]  fs/xfs/xfs_acl.o
fs/xfs/xfs_acl.c: In function 'xfs_acl_access':
fs/xfs/xfs_acl.c:445: warning: 'matched.ae_perm' may be used
uninitialized in this function

  CC [M]  fs/xfs/xfs_alloc_btree.o
fs/xfs/xfs_alloc_btree.c: In function 'xfs_alloc_insrec':
fs/xfs/xfs_alloc_btree.c:622: warning: 'nrec.ar_startblock' may be
used uninitialized in this function
fs/xfs/xfs_alloc_btree.c:622: warning: 'nrec.ar_blockcount' may be
used uninitialized in this function

  CC [M]  fs/xfs/xfs_dir2_sf.o
fs/xfs/xfs_dir2_sf.c: In function 'xfs_dir2_block_sfsize':
fs/xfs/xfs_dir2_sf.c:110: warning: 'parent' may be used uninitialized
in this function
  CC [M]  fs/xfs/xfs_dir_leaf.o
fs/xfs/xfs_dir_leaf.c: In function 'xfs_dir_leaf_to_shortform':
fs/xfs/xfs_dir_leaf.c:653: warning: 'parent' may be used uninitialized
in this function

  CC [M]  fs/xfs/xfs_ialloc_btree.o
fs/xfs/xfs_ialloc_btree.c: In function 'xfs_inobt_insrec':
fs/xfs/xfs_ialloc_btree.c:750: warning: 'nrec.ir_free' is used
uninitialized in this function
fs/xfs/xfs_ialloc_btree.c:750: warning: 'nrec.ir_freecount' is used
uninitialized in this function
fs/xfs/xfs_ialloc_btree.c:567: warning: 'nrec.ir_startino' may be used
uninitialized in this function

michal@debian:/usr/src/linux-git$ gcc --version
gcc (GCC) 4.0.2 (Debian 4.0.2-2)

Regards,
Michal Piotrowski
