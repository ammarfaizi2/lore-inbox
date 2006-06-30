Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbWF3Ght@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbWF3Ght (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 02:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbWF3Ght
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 02:37:49 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:57065 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1751171AbWF3Ghs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 02:37:48 -0400
To: jitendra@linsyssoft.com, adilger@clusterfs.com, cmm@us.ibm.com
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: [RFC][PATCH 0/3] add new types for ext2
Message-Id: <20060630153741sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Fri, 30 Jun 2006 15:37:41 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On June 29, 2006, I wrote:
> There are two new types in Mingming's patches.  One is "ext3_fsblk_t"
> for filesystem relative block and the other is "ext3_grpblk_t" for
> blockgroup relative offset.  But they have no type for file relative
> offset.  Moreover variables for file relative offset are used as
> various types(int, long and unsigned long) in current kernel.
>
> Therefore I added "ext3_fileblk_t" for file relative offset.
> It gives unity, which makes maintenance easier and code clearer.
> ext3_fileblk_t is unsigned long which is the maximum size of
> current type for file relative offset.


I added the following three types for ext2(like ext3).

typedef unsigned long ext2_fsblk_t; (for filesystem relative block)
typedef long ext2_grpblk_t; (for group relative block)
typedef unsigned long ext2_fileblk_t; (for file relative offset)

This series of patches give unity, which make maintenance easier
and code clearer.

[patch 1/3] ext2_fsblk_t.patch
convert ext2 filesystem blocks to ext2_fsblk_t

[patch 2/3] ext2_grpblk_t.patch
convert ext2 group blocks to ext2_grpblk_t

[patch 3/3] ext2_fileblk_t.patch
convert ext2 file offset to ext2_fileblk_t

Any comments?

sho

