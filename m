Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262792AbTDFEkt (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 23:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262795AbTDFEkt (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 23:40:49 -0500
Received: from [204.60.95.213] ([204.60.95.213]:14565 "EHLO
	wbkctmsx1ipc.ipc.com") by vger.kernel.org with ESMTP
	id S262792AbTDFEks (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 5 Apr 2003 23:40:48 -0500
From: Thomas Downing <thomas.downing@ipc.com>
Reply-To: thomas.downing@ipc.com
Organization: IPC Information Systems, Inc.
To: linux-kernel@vger.kernel.org
Subject: Unresolved symbol in microcode.ko - 2.5.64bk4
Date: Wed, 12 Mar 2003 12:22:22 -0500
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303121222.22849.thomas.downing@ipc.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When building microcode support for i386 PIII as a module, I get an unresolved 
reference to devfs_set_file_size.  Attached is a patch to fs/devfs/base.c 
that fixes the problem.

Being a newbie, I don't know if that is the appropriate fix, or if devfs 
should be tweeked instead.

td

---- begin patch ----

*** linux-2.5.64_o/fs/devfs/base.c	Wed Mar 12 12:09:21 2003
--- linux-2.5.64/fs/devfs/base.c	Wed Mar 12 12:10:18 2003
***************
*** 1953,1960 ****
--- 1953,1961 ----
  EXPORT_SYMBOL(devfs_mk_symlink);
  EXPORT_SYMBOL(devfs_mk_dir);
  EXPORT_SYMBOL(devfs_remove);
  EXPORT_SYMBOL(devfs_generate_path);
+ EXPORT_SYMBOL(devfs_set_file_size);
  
  
  /**
   *	try_modload - Notify devfsd of an inode lookup by a non-devfsd process.
