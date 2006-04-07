Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbWDGR5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbWDGR5P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 13:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWDGR5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 13:57:15 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:7584 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932336AbWDGR5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 13:57:14 -0400
Date: Fri, 7 Apr 2006 13:59:21 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>
Cc: Morton Andrew Morton <akpm@osdl.org>, Theodore Y Tso <theotso@us.ibm.com>
Subject: [PATCH] kdump: enable CONFIG_PROC_VMCORE by default
Message-ID: <20060407175921.GA22556@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o Everybody seems to be using /proc/vmcore as a method to access the kernel
  crash dump. Hence probably it makes sense to enable CONFIG_PROC_VMCORE by
  default if CONFIG_CRASH_DUMP is selected. This makes kdump configuration
  further easier for a user.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 fs/Kconfig |    1 +
 1 files changed, 1 insertion(+)

diff -puN fs/Kconfig~kdump-enable-config-proc-vmcore-by-default fs/Kconfig
--- linux-2.6.17-rc1-1M/fs/Kconfig~kdump-enable-config-proc-vmcore-by-default	2006-04-07 12:44:29.000000000 -0400
+++ linux-2.6.17-rc1-1M-root/fs/Kconfig	2006-04-07 12:44:29.000000000 -0400
@@ -799,6 +799,7 @@ config PROC_KCORE
 config PROC_VMCORE
         bool "/proc/vmcore support (EXPERIMENTAL)"
         depends on PROC_FS && EXPERIMENTAL && CRASH_DUMP
+	default y
         help
         Exports the dump image of crashed kernel in ELF format.
 
_
