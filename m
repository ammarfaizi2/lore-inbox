Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932677AbWCWUkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932677AbWCWUkp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 15:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbWCWUkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 15:40:22 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:50148 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751497AbWCWUkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 15:40:20 -0500
Message-Id: <20060323203522.545166000@dyn-9-152-242-103.boeblingen.de.ibm.com>
References: <20060323203423.620978000@dyn-9-152-242-103.boeblingen.de.ibm.com>
User-Agent: quilt/0.44-1
Date: Thu, 23 Mar 2006 00:00:10 +0100
From: Arnd Bergmann <abergman@de.ibm.com>
To: Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>
Cc: cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [patch 10/13] add sys_unshare to syscalls.h
Content-Disposition: inline; filename=unshare-decl.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All architecture independent system calls should be declared
in syscalls.h, add the one that is missing.

To: Andrew Morton <akpm@osdl.org>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---

This patch is not powerpc-specific in principle, the reason
for including it in my cell updates is that my next patch
depends on it.

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index d73501b..72de104 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -568,5 +568,6 @@ asmlinkage long compat_sys_newfstatat(un
 				      int flag);
 asmlinkage long compat_sys_openat(unsigned int dfd, const char __user *filename,
 				   int flags, int mode);
+asmlinkage long sys_unshare(unsigned long unshare_flags);
 
 #endif

--

