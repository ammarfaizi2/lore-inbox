Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261206AbSLMDm0>; Thu, 12 Dec 2002 22:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261218AbSLMDm0>; Thu, 12 Dec 2002 22:42:26 -0500
Received: from dp.samba.org ([66.70.73.150]:64405 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261206AbSLMDm0>;
	Thu, 12 Dec 2002 22:42:26 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: akpm@zip.com.au, viro@math.psu.edu
Cc: linux-kernel@vger.kernel.org
Subject: [2.5.51] Failure to mount ext3 root when ext2 compiled in
Date: Fri, 13 Dec 2002 14:48:40 +1100
Message-Id: <20021213035016.339092C24F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just noticed this (usually ext2 is compiled as a module, but was
testing a patch with CONFIG_MODULES=n).  Reverted to plain 2.5.51, and
it's still there:

	VFS: Cannot open root device "301" or 03:01
	Please append a correct "root=" boot option
	Kernel panic: VFS: Unable to mount root fs on 03:01

Now, I have an ext3 root, but when CONFIG_EXT3_FS=y and
CONFIG_EXT2_FS=y, I get this failure.  Turning off CONFIG_EXT2_FS
"fixes" it.

Hope this helps,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
