Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbUKTXHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbUKTXHs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 18:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263193AbUKTXHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 18:07:48 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:52618 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S261521AbUKTXHi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 18:07:38 -0500
To: akpm@osdl.org, torvalds@osdl.org
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/13] Filesystem in Userspace
Message-Id: <E1CVeKG-0007Nr-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 21 Nov 2004 00:07:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, Linus!

Please consider applying the following patches, which add Filesystem
in Userspace.  The patches are against 2.6.10-rc2.  All comments since
the last submission have been incorporated:

  o don't use /proc, use /sys instead
  o add more documentation on locking
  o stylistic fixes

The patch is split up to the following parts:

  01 - add /sys/fs directory
  02 - MAINTAINERS, Kconfig and Makefile changes
  03 - FUSE core
  04 - read-only operations (getattr, readlink, readdir, ...)
  05 - read-write operataions (setattr, mkdir, symlink, ...)
  06 - file operations (open, read, write, ...)
  07 - mount options controlling the behavior of the filesystem
  08 - extended attribute operations (getxattr, setxattr, ...)
  09 - clustered read operation using readpages()
  10 - nfs export support
  11 - file data invalidate operation
  12 - direct I/O mount option
  13 - shared writable mapping

01-06 are crucial
07-10 are nice to have
11-13 are only to be applied if Linus changes his mind :)

I've included the last three so that those can be reviewed also.

Comments are welcome!

Thanks,
Miklos
