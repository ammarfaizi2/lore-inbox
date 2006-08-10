Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbWHJBT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbWHJBT5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 21:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWHJBT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 21:19:57 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:37781 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751182AbWHJBT4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 21:19:56 -0400
Subject: [PATCH 0/9] extents and 48bit blk changes for ext4 filesystem
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Content-Type: text/plain
Organization: IBM LTC
Date: Wed, 09 Aug 2006 18:19:57 -0700
Message-Id: <1155172797.3161.79.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As we have forked the ext4 filesystem and JBD2, this is an update the
previously known as 48bit ext3 patches

changes since last time:
-rebase all previous ext3 patches to against ext4/jbd2
-fixed an reservation window intialization issue with extent block
allocation
and merge the change to the parent patch:ext4-extents.patch
-merged prevous bug fixes patches from sct for 64 jbd2 to their parent
patch:64bit-jbd2-core.patch
-merged ext3-extents-fsblk_t patch to ext4-extents-48bit.patch
-merged 
64bit-incompat-flag-change.patch
ext3-sb-struc-sync-with-e2fsprog.patch
to parent patch 
64bit-metadata.patch


A complete series of patches (including forking ext4 filesystem patches
and 48bit patches submitted here) could be found at:
http://ext2.sourceforge.net/48bitext3/patches/latest/

To test the new ext3dev filesystem, just mount the filesystem with -t
ext3dev. By default ext3dev is still running 32 bit mode and without
extents. To testing extents and 48bit block number, need -o extent mount
option. (Maybe we should enable extent as default for ext3dev
filesystem ?)

Tested these patches on i386 and passed a few hours fsx test.

Thanks,

Mingming

