Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132866AbRDQXzs>; Tue, 17 Apr 2001 19:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132906AbRDQXzj>; Tue, 17 Apr 2001 19:55:39 -0400
Received: from www.resilience.com ([209.245.157.1]:31687 "EHLO
	www.resilience.com") by vger.kernel.org with ESMTP
	id <S132866AbRDQXz2>; Tue, 17 Apr 2001 19:55:28 -0400
Message-ID: <3ADCD8D1.6753B822@resilience.com>
Date: Tue, 17 Apr 2001 16:59:13 -0700
From: Jeff Golds <jgolds@resilience.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] proc_lookup not exported
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks.

I noticed that proc_lookup is not exported in fs/proc/procfs_syms.c but
that the function is an external in include/linux/proc_fs.h.

This patch exports the function appropriately and is against the 2.4.3
kernel tree.

*** procfs_syms.c.orig  Tue Apr 17 15:50:56 2001
--- procfs_syms.c       Tue Apr 17 15:51:19 2001
***************
*** 19,24 ****
--- 19,25 ----
  EXPORT_SYMBOL(proc_net);
  EXPORT_SYMBOL(proc_bus);
  EXPORT_SYMBOL(proc_root_driver);
+ EXPORT_SYMBOL(proc_lookup);
 
  static DECLARE_FSTYPE(proc_fs_type, "proc", proc_read_super,
FS_SINGLE);


-Jeff


-- 
Jeff Golds
jgolds@resilience.com
