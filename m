Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751422AbWJMLtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbWJMLtc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 07:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWJMLtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 07:49:31 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:43945 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1751417AbWJMLta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 07:49:30 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 0 of 2] Stackfs: generic stackable filesystem helper functions
Message-Id: <patchbomb.1160738328@thor.fsl.cs.sunysb.edu>
Date: Fri, 13 Oct 2006 07:18:48 -0400
From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, torvalds@osdl.org, hch@infradead.org, viro@ftp.linux.org.uk,
       linux-fsdevel@vger.kernel.org, penberg@cs.helsinki.fi,
       ezk@cs.sunysb.edu, mhalcrow@us.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches introduce stackfs_copy_* functions. These functions
copy inode attributes (such as {a,c,m}time, mode, etc.) from one inode to
another.

While, intended for stackable filesystems any portion of the kernel wishing
to copy inode attributes can use them.

This series consists of two patches, the first introduces the stackfs
functions, and the second makes eCryptfs a user.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

4 files changed, 85 insertions(+), 59 deletions(-)
fs/ecryptfs/file.c       |    3 +
fs/ecryptfs/inode.c      |   71 +++++++++-------------------------------------
fs/ecryptfs/main.c       |    5 +--
include/linux/stack_fs.h |   65 ++++++++++++++++++++++++++++++++++++++++++



