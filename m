Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317878AbSFNDzg>; Thu, 13 Jun 2002 23:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317880AbSFNDzf>; Thu, 13 Jun 2002 23:55:35 -0400
Received: from mail1.suri.co.jp ([61.194.3.174]:11795 "EHLO thames.suri.co.jp")
	by vger.kernel.org with ESMTP id <S317878AbSFNDzf>;
	Thu, 13 Jun 2002 23:55:35 -0400
Date: Fri, 14 Jun 2002 12:55:28 +0900
From: OHKUBO Katsuhiko <ohkubo-k@suri.co.jp>
To: linux-kernel@vger.kernel.org
Subject: question: The use of s_op->write_super_lockfs/unlockfs
Reply-To: ohkubo-k@suri.co.jp
Message-Id: <20020614122405.FF2D.OHKUBO-K@suri.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.00.08
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello.

There ars
	void write_super_lockfs(super_block *)
	void unlockfs(super_block *)
in struct super_operations.

Ext3 and reiserfs have implementations of it.
But I cannot find callers of it and system calls for it.

There are some pathches such as 
	http://www.lifix.fi/listarchive/lkml/2001-08/msg00464.html
but it's not included in Linux 2.4.18/2.5.21.
	drivers/md/lvm.c has only callers of functions in this patch
	if defined LVM_VFS_ENHANCEMENT, but there aren't function bodys.

Q1: Who does use s_op->write_super_lockfs/unlockfs now?
Q2: How lockfs/unlockfs will be used in future?
Q3: Is it enable to implement of system calls for lockfs/unlockfs
	without deadlocks?

Thanks in advance.

-----------
OHKUBO Katsuhiko ohkubo-k@suri.co.jp

