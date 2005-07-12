Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262398AbVGLVzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbVGLVzL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 17:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbVGLVxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 17:53:24 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:22412 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262480AbVGLVjT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 17:39:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=cIUmouL+Qv85JWoib/zlGdRW3w3JGsPrQpIJc4omKZwvppfVcR7ToUw8tt+bCz+2zCwNW0CwTdCTOZgcmGtdZIFbdQLdgtyTmdNEh26aJ12VG8TRhte7jHV0EWRbLASa+JBblMU8DBkYCe8g9nYxDgD9SGtlxXcKkR/TH0LKysA=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jeff Mahoney <jeffm@suse.com>
Subject: Re: [PATCH/URL] reiserfs: reformat code with Lindent
Date: Wed, 13 Jul 2005 01:46:10 +0400
User-Agent: KMail/1.8.1
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
References: <20050712194220.GA28973@locomotive.unixthugs.org>
In-Reply-To: <20050712194220.GA28973@locomotive.unixthugs.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507130146.10633.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 July 2005 23:42, Jeff Mahoney wrote:
>  The ReiserFS code is a mix of a number of different coding styles, sometimes
>  different even from line-to-line. Since the code has been relatively stable
>  for quite some time and there are few outstanding patches to be applied, it
>  is time to reformat the code to conform to the Linux style standard outlined
>  in Documentation/CodingStyle.

>  This patch contains the result of running scripts/Lindent

With -psl picked up.

	-int is_reusable (struct super_block * s, b_blocknr_t block, int bit_value)
	+int
	+is_reusable(struct super_block *s, b_blocknr_t block, int bit_value)

>  against 
>  fs/reiserfs/*.c

patching file fs/reiserfs/item_ops.c
Hunk #1 FAILED at 793.
1 out of 1 hunk FAILED -- saving rejects to file fs/reiserfs/item_ops.c.rej

>  and include/linux/reiserfs_*.h. 

Only fs/reiserfs/*.c part.

$ diffstat -p1 01-reiserfs-lindent.diff
 fs/reiserfs/bitmap.c          | 1932 ++++++-----
 fs/reiserfs/dir.c             |  485 +-
 fs/reiserfs/do_balan.c        | 3229 +++++++++++--------
 fs/reiserfs/file.c            | 2615 ++++++++-------
 fs/reiserfs/fix_node.c        | 4136 ++++++++++++------------
 fs/reiserfs/hashes.c          |  198 -
 fs/reiserfs/ibalance.c        | 1851 +++++------
 fs/reiserfs/inode.c           | 5005 +++++++++++++++---------------
 fs/reiserfs/ioctl.c           |  203 -
 fs/reiserfs/item_ops.c        |   18
 fs/reiserfs/journal.c         | 6994 ++++++++++++++++++++++--------------------
 fs/reiserfs/lbalance.c        | 2232 ++++++-------
 fs/reiserfs/namei.c           | 2637 ++++++++-------
 fs/reiserfs/objectid.c        |  308 -
 fs/reiserfs/prints.c          | 1065 +++---
 fs/reiserfs/procfs.c          |  751 ++--
 fs/reiserfs/resize.c          |  208 -
 fs/reiserfs/stree.c           | 3488 ++++++++++----------
 fs/reiserfs/super.c           | 3751 +++++++++++-----------
 fs/reiserfs/tail_conversion.c |  467 +-
 fs/reiserfs/xattr.c           | 2148 ++++++------
 fs/reiserfs/xattr_acl.c       |  632 +--
 fs/reiserfs/xattr_security.c  |   53
 fs/reiserfs/xattr_trusted.c   |   69
 fs/reiserfs/xattr_user.c      |   88
 25 files changed, 23412 insertions(+), 21151 deletions(-)
