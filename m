Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265859AbUBCEzo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 23:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265871AbUBCEzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 23:55:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:29107 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265859AbUBCEzl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 23:55:41 -0500
Date: Mon, 2 Feb 2004 20:53:21 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] add syscalls.h (v2)
Message-Id: <20040202205321.12da4b04.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton wrote:
| +#include <asm/signal.h>
| +#include <asm/stat.h>
| 
| I'd be inclined to lose the includes and just add forward decls for
| structs.  Of course, you'll need the includes for typedefs. 

Yes, I was already contemplating on that one.

| +extern asmlinkage long sys_unlink(const char __user *pathname);
| +extern asmlinkage long sys_chmod(const char __user *filename, mode_t mode);
| +extern asmlinkage long sys_fchmod(unsigned int fd, mode_t mode);
| 
| Maybe lose the `extern' too.  It's just a waste of space.  I normally put
| it in for consistency if the surrounding code is done that way, but for a
| new header file, why bother?

Done.  And updated to 2.6.2-rc3.

Many more syscalls added.  Complete patch (87 KB) is at
  http://developer.osdl.org/rddunlap/syscalls/2.6.2-rc3-syscalls.diff

Build allmodconfig and allyesconfig on P4.  Not booted yet.
Plan to boot Tue. Feb. 3.

Also plan to build on ia64, maybe some other $ARCH that I don't have....


More comments etc.?
I'm still searching for syscalls that I have missed.

--
~Randy
