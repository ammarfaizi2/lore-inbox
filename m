Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132101AbRC1Wxf>; Wed, 28 Mar 2001 17:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132110AbRC1Wx1>; Wed, 28 Mar 2001 17:53:27 -0500
Received: from www.resilience.com ([209.245.157.1]:47822 "EHLO
	www.resilience.com") by vger.kernel.org with ESMTP
	id <S132101AbRC1WxP>; Wed, 28 Mar 2001 17:53:15 -0500
Message-ID: <3AC26C07.61ED3332@resilience.com>
Date: Wed, 28 Mar 2001 14:56:07 -0800
From: Jeff Golds <jgolds@resilience.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.2 Patch for missing "proc_get_inode" symbol in comx driver
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

Sorry if this has been addressed before, but I didn't see this in the
release notes for the latest ac drivers.

I tried to build the comx driver in the 2.4.2 kernel, but got unresolved
external "proc_get_inode" when I attempted to load the module.  Looks
like all that is missing is an EXPORT_SYMBOL entry in procfs_syms.c

Is there some reason why this function is not being exported or is it
just an error?

Here's the patch if anyone is interested.

*** linux-2.4.2.orig/fs/proc/procfs_syms.c      Mon Sep 11 08:41:07 2000
--- linux/fs/proc/procfs_syms.c Wed Mar 28 11:48:17 2001
***************
*** 19,24 ****
--- 19,25 ----
  EXPORT_SYMBOL(proc_net);
  EXPORT_SYMBOL(proc_bus);
  EXPORT_SYMBOL(proc_root_driver);
+ EXPORT_SYMBOL(proc_get_inode);
 
  static DECLARE_FSTYPE(proc_fs_type, "proc", proc_read_super,
FS_SINGLE);



-Jeff                                                                                
-- 
Jeff Golds
jgolds@resilience.com
