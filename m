Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261829AbTCLSgl>; Wed, 12 Mar 2003 13:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261837AbTCLSgl>; Wed, 12 Mar 2003 13:36:41 -0500
Received: from [65.244.37.61] ([65.244.37.61]:47409 "EHLO WSPNYCON1IPC.ipc.com")
	by vger.kernel.org with ESMTP id <S261829AbTCLSgk>;
	Wed, 12 Mar 2003 13:36:40 -0500
Message-ID: <170EBA504C3AD511A3FE00508BB89A9201D4A2AB@exnanycmbx4.ipc.com>
From: "Downing, Thomas" <Thomas.Downing@ipc.com>
To: linux-kernel@vger.kernel.org
Subject: Unresolved symbol in microcode.ko - 2.5.64bk4
Date: Wed, 12 Mar 2003 13:48:34 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When building microcode support for i386 PIII as a module, I get an
unresolved 
reference to devfs_set_file_size.  Attached is a patch to fs/devfs/base.c 
that fixes the problem.

Being a newbie, I don't know if that is the appropriate fix, or if devfs
should be tweeked instead.

Using devfs, on 2.5.64, bk4

td

---- begin patch ----

*** linux-2.5.64_o/fs/devfs/base.c      Wed Mar 12 12:09:21 2003
--- linux-2.5.64/fs/devfs/base.c        Wed Mar 12 12:10:18 2003
***************
*** 1953,1960 ****
--- 1953,1961 ----
  EXPORT_SYMBOL(devfs_mk_symlink);
  EXPORT_SYMBOL(devfs_mk_dir);
  EXPORT_SYMBOL(devfs_remove);
  EXPORT_SYMBOL(devfs_generate_path);
+ EXPORT_SYMBOL(devfs_set_file_size);
  
  
  /**
   *    try_modload - Notify devfsd of an inode lookup by a non-devfsd
process.
