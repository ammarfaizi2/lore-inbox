Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161064AbVKRMcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161064AbVKRMcu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 07:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161095AbVKRMcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 07:32:50 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:17623 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161064AbVKRMct
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 07:32:49 -0500
Date: Fri, 18 Nov 2005 18:02:46 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Morton Andrew Morton <akpm@osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Kdump: i386 compiler warning fix
Message-ID: <20051118123246.GD7217@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

With a particular config file on i386, I get a compiler warning. This patch
fixes it. This incremental patch is against 2.6.15-rc1-mm2.

Thanks
Vivek


o Fixes a compilation warning message in i386


Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.15-rc1-mm2-1M-root/include/asm-i386/kexec.h |    1 +
 1 files changed, 1 insertion(+)

diff -puN include/asm-i386/kexec.h~kdump-i386-memcpy-warning-fix include/asm-i386/kexec.h
--- linux-2.6.15-rc1-mm2-1M/include/asm-i386/kexec.h~kdump-i386-memcpy-warning-fix	2005-11-18 16:08:33.000000000 +0530
+++ linux-2.6.15-rc1-mm2-1M-root/include/asm-i386/kexec.h	2005-11-18 16:08:33.000000000 +0530
@@ -3,6 +3,7 @@
 
 #include <asm/fixmap.h>
 #include <asm/ptrace.h>
+#include <asm/string.h>
 
 /*
  * KEXEC_SOURCE_MEMORY_LIMIT maximum page get_free_page can return.
_
